Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 756C034B8B9
	for <lists+linux-csky@lfdr.de>; Sat, 27 Mar 2021 19:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbhC0SH5 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 27 Mar 2021 14:07:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:42512 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhC0SHf (ORCPT <rfc822;linux-csky@vger.kernel.org>);
        Sat, 27 Mar 2021 14:07:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6195161965;
        Sat, 27 Mar 2021 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616868455;
        bh=LvRCrrCzj8udXkBA6WRXdyg71qL92AhvWoldyruR39k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=chiiL0yvB6GLw1pCkrzaWTJFvn76YRJU/n+BZBYztHPTGh+uoGLlmhRgoAQNlC54g
         OXCeIFjmYUhLqapkXYOi/+TB1ppmtdmV6JWFIoTlQf01SnYuPqe+BS30sWdry4VzOj
         iets2HU2I+h8s4RGn2zEFvrJPF6S3z7lPYsL+zTbW9dtL2wCMT0XrYdp+YEyYrXv3I
         zlBfOGPI6QPpa1G6XxskkEBivoktFSRd97qELc2fE4m63miZFBlygrMQ61hkcB91PA
         hbed4poQHYm7sNaEmRumdO5k4br16LR++Z3EUsqz7E6qeHcS8GnSNQpGabM1eDqiZO
         fMQgTZXR28bkA==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Subject: [PATCH v4 3/4] locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Date:   Sat, 27 Mar 2021 18:06:38 +0000
Message-Id: <1616868399-82848-4-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616868399-82848-1-git-send-email-guoren@kernel.org>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Some architectures don't have sub-word swap atomic instruction,
they only have the full word's one.

The sub-word swap only improve the performance when:
NR_CPUS < 16K
 *  0- 7: locked byte
 *     8: pending
 *  9-15: not used
 * 16-17: tail index
 * 18-31: tail cpu (+1)

The 9-15 bits are wasted to use xchg16 in xchg_tail.

Please let architecture select xchg16/xchg32 to implement
xchg_tail.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Waiman Long <longman@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Anup Patel <anup@brainfault.org>
---
 kernel/Kconfig.locks       |  3 +++
 kernel/locking/qspinlock.c | 44 +++++++++++++++++++++-----------------
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/kernel/Kconfig.locks b/kernel/Kconfig.locks
index 3de8fd11873b..d02f1261f73f 100644
--- a/kernel/Kconfig.locks
+++ b/kernel/Kconfig.locks
@@ -239,6 +239,9 @@ config LOCK_SPIN_ON_OWNER
 config ARCH_USE_QUEUED_SPINLOCKS
 	bool
 
+config ARCH_USE_QUEUED_SPINLOCKS_XCHG32
+	bool
+
 config QUEUED_SPINLOCKS
 	def_bool y if ARCH_USE_QUEUED_SPINLOCKS
 	depends on SMP
diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
index cbff6ba53d56..54de0632c6a8 100644
--- a/kernel/locking/qspinlock.c
+++ b/kernel/locking/qspinlock.c
@@ -163,26 +163,6 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 	WRITE_ONCE(lock->locked_pending, _Q_LOCKED_VAL);
 }
 
-/*
- * xchg_tail - Put in the new queue tail code word & retrieve previous one
- * @lock : Pointer to queued spinlock structure
- * @tail : The new queue tail code word
- * Return: The previous queue tail code word
- *
- * xchg(lock, tail), which heads an address dependency
- *
- * p,*,* -> n,*,* ; prev = xchg(lock, node)
- */
-static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
-{
-	/*
-	 * We can use relaxed semantics since the caller ensures that the
-	 * MCS node is properly initialized before updating the tail.
-	 */
-	return (u32)xchg_relaxed(&lock->tail,
-				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
-}
-
 #else /* _Q_PENDING_BITS == 8 */
 
 /**
@@ -206,6 +186,30 @@ static __always_inline void clear_pending_set_locked(struct qspinlock *lock)
 {
 	atomic_add(-_Q_PENDING_VAL + _Q_LOCKED_VAL, &lock->val);
 }
+#endif
+
+#if _Q_PENDING_BITS == 8 && !defined(CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32)
+/*
+ * xchg_tail - Put in the new queue tail code word & retrieve previous one
+ * @lock : Pointer to queued spinlock structure
+ * @tail : The new queue tail code word
+ * Return: The previous queue tail code word
+ *
+ * xchg(lock, tail), which heads an address dependency
+ *
+ * p,*,* -> n,*,* ; prev = xchg(lock, node)
+ */
+static __always_inline u32 xchg_tail(struct qspinlock *lock, u32 tail)
+{
+	/*
+	 * We can use relaxed semantics since the caller ensures that the
+	 * MCS node is properly initialized before updating the tail.
+	 */
+	return (u32)xchg_relaxed(&lock->tail,
+				 tail >> _Q_TAIL_OFFSET) << _Q_TAIL_OFFSET;
+}
+
+#else
 
 /**
  * xchg_tail - Put in the new queue tail code word & retrieve previous one
-- 
2.17.1

