Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BEC1A9FD9
	for <lists+linux-csky@lfdr.de>; Wed, 15 Apr 2020 14:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S368850AbgDOMSI (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 15 Apr 2020 08:18:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:40992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2409273AbgDOLqP (ORCPT <rfc822;linux-csky@vger.kernel.org>);
        Wed, 15 Apr 2020 07:46:15 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409CC206A2;
        Wed, 15 Apr 2020 11:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586951174;
        bh=14d0vipBRsRPlRsQS2dkebED6wLV/m2MRXuuwhWQ9Mw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gKirTRHF3NqR/x6MEVlaaFSsLocxeRks00KCJmXGsgiS0jeujNlG6Ea3o6lcenOZv
         hyK0bNIENwSiR5bcBoi06/Q7Xhr0UD/iNhst+QHIGgpzH3RUyI+QagS9bw4E3yBFd2
         zs6ymomKj0/YGgvyzj+5f8wh1qAZeM+W75yVydZA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Lu Chongzhi <chongzhi.lcz@alibaba-inc.com>,
        Sasha Levin <sashal@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 78/84] csky: Fixup init_fpu compile warning with __init
Date:   Wed, 15 Apr 2020 07:44:35 -0400
Message-Id: <20200415114442.14166-78-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200415114442.14166-1-sashal@kernel.org>
References: <20200415114442.14166-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

[ Upstream commit 12879bda3c2a974b7e4fe199a9c21f0c5f6bca04 ]

WARNING: vmlinux.o(.text+0x2366): Section mismatch in reference from the
function csky_start_secondary() to the function .init.text:init_fpu()

The function csky_start_secondary() references
the function __init init_fpu().
This is often because csky_start_secondary lacks a __init
annotation or the annotation of init_fpu is wrong.

Reported-by: Lu Chongzhi <chongzhi.lcz@alibaba-inc.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/abiv2/fpu.c         | 5 -----
 arch/csky/abiv2/inc/abi/fpu.h | 3 ++-
 arch/csky/kernel/smp.c        | 3 +++
 3 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/csky/abiv2/fpu.c b/arch/csky/abiv2/fpu.c
index 86d187d4e5af1..5acc5c2e544e1 100644
--- a/arch/csky/abiv2/fpu.c
+++ b/arch/csky/abiv2/fpu.c
@@ -10,11 +10,6 @@
 #define MTCR_DIST	0xC0006420
 #define MFCR_DIST	0xC0006020
 
-void __init init_fpu(void)
-{
-	mtcr("cr<1, 2>", 0);
-}
-
 /*
  * fpu_libc_helper() is to help libc to excute:
  *  - mfcr %a, cr<1, 2>
diff --git a/arch/csky/abiv2/inc/abi/fpu.h b/arch/csky/abiv2/inc/abi/fpu.h
index 22ca3cf2794a1..09e2700a36936 100644
--- a/arch/csky/abiv2/inc/abi/fpu.h
+++ b/arch/csky/abiv2/inc/abi/fpu.h
@@ -9,7 +9,8 @@
 
 int fpu_libc_helper(struct pt_regs *regs);
 void fpu_fpe(struct pt_regs *regs);
-void __init init_fpu(void);
+
+static inline void init_fpu(void) { mtcr("cr<1, 2>", 0); }
 
 void save_to_user_fp(struct user_fp *user_fp);
 void restore_from_user_fp(struct user_fp *user_fp);
diff --git a/arch/csky/kernel/smp.c b/arch/csky/kernel/smp.c
index de61feb4b6df2..b5c5bc3afeb5c 100644
--- a/arch/csky/kernel/smp.c
+++ b/arch/csky/kernel/smp.c
@@ -22,6 +22,9 @@
 #include <asm/sections.h>
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
+#ifdef CONFIG_CPU_HAS_FPU
+#include <abi/fpu.h>
+#endif
 
 struct ipi_data_struct {
 	unsigned long bits ____cacheline_aligned;
-- 
2.20.1

