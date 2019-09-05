Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3B3BA98F7
	for <lists+linux-csky@lfdr.de>; Thu,  5 Sep 2019 05:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730873AbfIEDqo (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 4 Sep 2019 23:46:44 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:57024 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730872AbfIEDqo (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 4 Sep 2019 23:46:44 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07440601|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.365205-0.0142482-0.620547;FP=0|0|0|0|0|-1|-1|-1;HT=e01l07423;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.FP-Lmsn_1567655201;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.FP-Lmsn_1567655201)
          by smtp.aliyun-inc.com(10.147.41.199);
          Thu, 05 Sep 2019 11:46:41 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        Mao Han <han_mao@c-sky.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <green.hu@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Subject: [PATCH V7 1/2] riscv: Add support for perf registers sampling
Date:   Thu,  5 Sep 2019 11:46:35 +0800
Message-Id: <49c2c29459afc59130b036eba1b1fd5155572355.1567653632.git.han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1567653632.git.han_mao@c-sky.com>
References: <cover.1567653632.git.han_mao@c-sky.com>
In-Reply-To: <cover.1567653632.git.han_mao@c-sky.com>
References: <cover.1567653632.git.han_mao@c-sky.com>
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

This patch implements the perf registers sampling and validation API
for riscv arch. The valid registers and their register ID are defined in
perf_regs.h. Perf tool can backtrace in userspace with unwind library
and the registers/user stack dump support.

Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Greentime Hu <green.hu@gmail.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: linux-riscv <linux-riscv@lists.infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig                      |  2 ++
 arch/riscv/include/uapi/asm/perf_regs.h | 42 +++++++++++++++++++++++++++++++
 arch/riscv/kernel/Makefile              |  1 +
 arch/riscv/kernel/perf_regs.c           | 44 +++++++++++++++++++++++++++++++++
 4 files changed, 89 insertions(+)
 create mode 100644 arch/riscv/include/uapi/asm/perf_regs.h
 create mode 100644 arch/riscv/kernel/perf_regs.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 59a4727..4bc976d 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -35,6 +35,8 @@ config RISCV
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_FUTEX_CMPXCHG if FUTEX
 	select HAVE_PERF_EVENTS
+	select HAVE_PERF_REGS
+	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_SYSCALL_TRACEPOINTS
 	select IRQ_DOMAIN
 	select SPARSE_IRQ
diff --git a/arch/riscv/include/uapi/asm/perf_regs.h b/arch/riscv/include/uapi/asm/perf_regs.h
new file mode 100644
index 0000000..196f964
--- /dev/null
+++ b/arch/riscv/include/uapi/asm/perf_regs.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
+
+#ifndef _ASM_RISCV_PERF_REGS_H
+#define _ASM_RISCV_PERF_REGS_H
+
+enum perf_event_riscv_regs {
+	PERF_REG_RISCV_PC,
+	PERF_REG_RISCV_RA,
+	PERF_REG_RISCV_SP,
+	PERF_REG_RISCV_GP,
+	PERF_REG_RISCV_TP,
+	PERF_REG_RISCV_T0,
+	PERF_REG_RISCV_T1,
+	PERF_REG_RISCV_T2,
+	PERF_REG_RISCV_S0,
+	PERF_REG_RISCV_S1,
+	PERF_REG_RISCV_A0,
+	PERF_REG_RISCV_A1,
+	PERF_REG_RISCV_A2,
+	PERF_REG_RISCV_A3,
+	PERF_REG_RISCV_A4,
+	PERF_REG_RISCV_A5,
+	PERF_REG_RISCV_A6,
+	PERF_REG_RISCV_A7,
+	PERF_REG_RISCV_S2,
+	PERF_REG_RISCV_S3,
+	PERF_REG_RISCV_S4,
+	PERF_REG_RISCV_S5,
+	PERF_REG_RISCV_S6,
+	PERF_REG_RISCV_S7,
+	PERF_REG_RISCV_S8,
+	PERF_REG_RISCV_S9,
+	PERF_REG_RISCV_S10,
+	PERF_REG_RISCV_S11,
+	PERF_REG_RISCV_T3,
+	PERF_REG_RISCV_T4,
+	PERF_REG_RISCV_T5,
+	PERF_REG_RISCV_T6,
+	PERF_REG_RISCV_MAX,
+};
+#endif /* _ASM_RISCV_PERF_REGS_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index b1bea89..696020f 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -40,5 +40,6 @@ obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
+obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
 
 clean:
diff --git a/arch/riscv/kernel/perf_regs.c b/arch/riscv/kernel/perf_regs.c
new file mode 100644
index 0000000..04a38fb
--- /dev/null
+++ b/arch/riscv/kernel/perf_regs.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
+
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/perf_event.h>
+#include <linux/bug.h>
+#include <asm/perf_regs.h>
+#include <asm/ptrace.h>
+
+u64 perf_reg_value(struct pt_regs *regs, int idx)
+{
+	if (WARN_ON_ONCE((u32)idx >= PERF_REG_RISCV_MAX))
+		return 0;
+
+	return ((unsigned long *)regs)[idx];
+}
+
+#define REG_RESERVED (~((1ULL << PERF_REG_RISCV_MAX) - 1))
+
+int perf_reg_validate(u64 mask)
+{
+	if (!mask || mask & REG_RESERVED)
+		return -EINVAL;
+
+	return 0;
+}
+
+u64 perf_reg_abi(struct task_struct *task)
+{
+#if __riscv_xlen == 64
+	return PERF_SAMPLE_REGS_ABI_64;
+#else
+	return PERF_SAMPLE_REGS_ABI_32;
+#endif
+}
+
+void perf_get_regs_user(struct perf_regs *regs_user,
+			struct pt_regs *regs,
+			struct pt_regs *regs_user_copy)
+{
+	regs_user->regs = task_pt_regs(current);
+	regs_user->abi = perf_reg_abi(current);
+}
-- 
2.7.4

