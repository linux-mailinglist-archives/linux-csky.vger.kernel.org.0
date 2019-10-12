Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86243D4E45
	for <lists+linux-csky@lfdr.de>; Sat, 12 Oct 2019 10:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728782AbfJLI0T (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 12 Oct 2019 04:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:42468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728259AbfJLI0T (ORCPT <rfc822;linux-csky@vger.kernel.org>);
        Sat, 12 Oct 2019 04:26:19 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 239F2206A1
        for <linux-csky@vger.kernel.org>; Sat, 12 Oct 2019 08:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570868778;
        bh=aubyP9gSP7lFm7cUQQCZt/rsziAndkFQdXv181VLZ2Q=;
        h=References:In-Reply-To:From:Date:Subject:To:From;
        b=QKIKQdmqAUieh1ZsNkheYeNAnlPk4Q5MNZw9lkOSvd+UpcXhR/o+yGgzxsBDnMyLu
         ri/mFS2QrzqaO9/gteRsOn2eDapjyWUVWEN+uLKgtJ0gCYun7gKYj3gdwH1zkOnWr7
         qW9zBz5cekG2moGExKH23Oa5OyOBf/QQ00gXPXDQ=
Received: by mail-wm1-f41.google.com with SMTP id r17so10879896wme.0
        for <linux-csky@vger.kernel.org>; Sat, 12 Oct 2019 01:26:18 -0700 (PDT)
X-Gm-Message-State: APjAAAUftJ9SDboCTkoMFE4Ug7Dy84d9y1My7lzml0WBgZ27AuC2SSU7
        Ceg+Q4VGYU4GxXobanK59d0mIT/2R730ojuzMGw=
X-Google-Smtp-Source: APXvYqypIsYqxs//J6qRRKBL9y7Q+HWMJ/BivhZNuuDrBCSRMSaP9TDyHlEF0HwfQX9PjFGRIvEay/3Cf+SfSXx7Ea4=
X-Received: by 2002:a1c:20d8:: with SMTP id g207mr6546915wmg.79.1570868776604;
 Sat, 12 Oct 2019 01:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <1570762615-4256-1-git-send-email-han_mao@c-sky.com>
In-Reply-To: <1570762615-4256-1-git-send-email-han_mao@c-sky.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 12 Oct 2019 16:26:05 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ8b_EH=fozH7RXwXGp7-yaVLGPnd-1DSKUp=K_xiHZcg@mail.gmail.com>
Message-ID: <CAJF2gTQ8b_EH=fozH7RXwXGp7-yaVLGPnd-1DSKUp=K_xiHZcg@mail.gmail.com>
Subject: Fwd: [PATCH] csky: Initial stack protector support
To:     linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

---------- Forwarded message ---------
From: Mao Han <han_mao@c-sky.com>
Date: Fri, Oct 11, 2019 at 10:59 AM
Subject: [PATCH] csky: Initial stack protector support
To: <linux-kernel@vger.kernel.org>
Cc: Mao Han <han_mao@c-sky.com>, Guo Ren <guoren@kernel.org>


This is a basic -fstack-protector support without per-task canary
switching. The protector will report something like when stack
corruption is detected:

stack-protector: Kernel stack is corrupted in: sys_kill+0x23c/0x23c

Tested with a local array overflow in kill system call.

Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Guo Ren <guoren@kernel.org>
---
 arch/csky/Kconfig                      |  1 +
 arch/csky/include/asm/stackprotector.h | 29 +++++++++++++++++++++++++++++
 arch/csky/kernel/process.c             |  6 ++++++
 3 files changed, 36 insertions(+)
 create mode 100644 arch/csky/include/asm/stackprotector.h

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 3973847..2852343 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -48,6 +48,7 @@ config CSKY
        select HAVE_PERF_USER_STACK_DUMP
        select HAVE_DMA_API_DEBUG
        select HAVE_DMA_CONTIGUOUS
+       select HAVE_STACKPROTECTOR
        select HAVE_SYSCALL_TRACEPOINTS
        select MAY_HAVE_SPARSE_IRQ
        select MODULES_USE_ELF_RELA if MODULES
diff --git a/arch/csky/include/asm/stackprotector.h
b/arch/csky/include/asm/stackprotector.h
new file mode 100644
index 0000000..d7cd4e5
--- /dev/null
+++ b/arch/csky/include/asm/stackprotector.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_STACKPROTECTOR_H
+#define _ASM_STACKPROTECTOR_H 1
+
+#include <linux/random.h>
+#include <linux/version.h>
+
+extern unsigned long __stack_chk_guard;
+
+/*
+ * Initialize the stackprotector canary value.
+ *
+ * NOTE: this must only be called from functions that never return,
+ * and it must always be inlined.
+ */
+static __always_inline void boot_init_stack_canary(void)
+{
+       unsigned long canary;
+
+       /* Try to get a semi random initial value. */
+       get_random_bytes(&canary, sizeof(canary));
+       canary ^= LINUX_VERSION_CODE;
+       canary &= CANARY_MASK;
+
+       current->stack_canary = canary;
+       __stack_chk_guard = current->stack_canary;
+}
+
+#endif /* __ASM_SH_STACKPROTECTOR_H */
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index f320d92..5349cd8 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -16,6 +16,12 @@

 struct cpuinfo_csky cpu_data[NR_CPUS];

+#ifdef CONFIG_STACKPROTECTOR
+#include <linux/stackprotector.h>
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
 asmlinkage void ret_from_fork(void);
 asmlinkage void ret_from_kernel_thread(void);

--
2.7.4



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
