Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2CE41BCD5
	for <lists+linux-csky@lfdr.de>; Wed, 29 Sep 2021 04:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243861AbhI2Cfi (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 28 Sep 2021 22:35:38 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:12965 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243851AbhI2CfY (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 28 Sep 2021 22:35:24 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HK0lC0RyYzWZG7;
        Wed, 29 Sep 2021 10:32:23 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 29 Sep 2021 10:33:41 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 29 Sep 2021 10:33:41 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, <linux-sh@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-csky@vger.kernel.org>
CC:     Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 3/3] genirq: Cleanup Kconfig
Date:   Wed, 29 Sep 2021 10:35:22 +0800
Message-ID: <20210929023522.57732-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210929023522.57732-1-wangkefeng.wang@huawei.com>
References: <20210929023522.57732-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

As the last user of MAY_HAVE_SPARSE_IRQ is gone, kill it, and clean
up the SPARSE_IRQ description, covert the help text into comment.

Also move GENERIC_IRQ_MULTI_HANDLER into menu, and change all spaces
to tabs to fix alignment issue.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 kernel/irq/Kconfig | 50 +++++++++++++++++++---------------------------
 1 file changed, 20 insertions(+), 30 deletions(-)

diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index fbc54c2a7f23..aa7d0e3edea6 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -2,13 +2,9 @@
 menu "IRQ subsystem"
 # Options selectable by the architecture code
 
-# Make sparse irq Kconfig switch below available
-config MAY_HAVE_SPARSE_IRQ
-       bool
-
 # Legacy support, required for itanic
 config GENERIC_IRQ_LEGACY
-       bool
+	bool
 
 # Enable the generic irq autoprobe mechanism
 config GENERIC_IRQ_PROBE
@@ -16,15 +12,15 @@ config GENERIC_IRQ_PROBE
 
 # Use the generic /proc/interrupts implementation
 config GENERIC_IRQ_SHOW
-       bool
+	bool
 
 # Print level/edge extra information
 config GENERIC_IRQ_SHOW_LEVEL
-       bool
+	bool
 
 # Supports effective affinity mask
 config GENERIC_IRQ_EFFECTIVE_AFF_MASK
-       bool
+	bool
 
 # Support for delayed migration from interrupt context
 config GENERIC_PENDING_IRQ
@@ -36,7 +32,7 @@ config GENERIC_IRQ_MIGRATION
 
 # Alpha specific irq affinity mechanism
 config AUTO_IRQ_AFFINITY
-       bool
+	bool
 
 # Interrupt injection mechanism
 config GENERIC_IRQ_INJECTION
@@ -44,16 +40,16 @@ config GENERIC_IRQ_INJECTION
 
 # Tasklet based software resend for pending interrupts on enable_irq()
 config HARDIRQS_SW_RESEND
-       bool
+	bool
 
 # Edge style eoi based handler (cell)
 config IRQ_EDGE_EOI_HANDLER
-       bool
+	bool
 
 # Generic configurable interrupt chip implementation
 config GENERIC_IRQ_CHIP
-       bool
-       select IRQ_DOMAIN
+	bool
+	select IRQ_DOMAIN
 
 # Generic irq_domain hw <--> linux irq number translation
 config IRQ_DOMAIN
@@ -103,6 +99,10 @@ config HANDLE_DOMAIN_IRQ
 config IRQ_TIMINGS
 	bool
 
+# Allow to specify the low level IRQ handler at run time.
+config GENERIC_IRQ_MULTI_HANDLER
+	bool
+
 config GENERIC_IRQ_MATRIX_ALLOCATOR
 	bool
 
@@ -111,20 +111,15 @@ config GENERIC_IRQ_RESERVATION_MODE
 
 # Support forced irq threading
 config IRQ_FORCED_THREADING
-       bool
+	bool
 
+# Sparse irq numbering is useful for distro kernels that want
+# to define a high CONFIG_NR_CPUS value but still want to have
+# low kernel memory footprint on smaller machines.
+# Sparse irqs can also be beneficial on NUMA boxes, as they spread
+# out the interrupt descriptors in a more NUMA-friendly way.
 config SPARSE_IRQ
-	bool "Support sparse irq numbering" if MAY_HAVE_SPARSE_IRQ
-	help
-
-	  Sparse irq numbering is useful for distro kernels that want
-	  to define a high CONFIG_NR_CPUS value but still want to have
-	  low kernel memory footprint on smaller machines.
-
-	  ( Sparse irqs can also be beneficial on NUMA boxes, as they spread
-	    out the interrupt descriptors in a more NUMA-friendly way. )
-
-	  If you don't know what to do here, say N.
+	bool
 
 config GENERIC_IRQ_DEBUGFS
 	bool "Expose irq internals in debugfs"
@@ -139,8 +134,3 @@ config GENERIC_IRQ_DEBUGFS
 	  If you don't know what to do here, say N.
 
 endmenu
-
-config GENERIC_IRQ_MULTI_HANDLER
-	bool
-	help
-	  Allow to specify the low level IRQ handler at run time.
-- 
2.26.2

