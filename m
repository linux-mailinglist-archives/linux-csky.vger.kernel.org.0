Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58CE4156FB0
	for <lists+linux-csky@lfdr.de>; Mon, 10 Feb 2020 07:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbgBJGzM (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Mon, 10 Feb 2020 01:55:12 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:47209 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726061AbgBJGzM (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Mon, 10 Feb 2020 01:55:12 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=majun258@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TpZ72wA_1581317690;
Received: from localhost(mailfrom:majun258@linux.alibaba.com fp:SMTPD_---0TpZ72wA_1581317690)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 10 Feb 2020 14:55:09 +0800
From:   Ma Jun <majun258@linux.alibaba.com>
To:     ren_guo@c-sky.com, ldv@altlinux.org
Cc:     majun258@linux.alibaba.com, linux-csky@vger.kernel.org
Subject: [PATCH] arch/csky: Fix the compile error when use abiv1
Date:   Mon, 10 Feb 2020 14:54:49 +0800
Message-Id: <1581317689-3709-1-git-send-email-majun258@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

From: MaJun <majun258@linux.alibaba.com>

Fix the bug caused by csky_regs. Because this struct
has no member r1, only a1.

Signed-off-by: Ma Jun <majun258@linux.alibaba.com>
---
 linux/csky/get_scno.c | 2 +-
 linux/csky/set_scno.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux/csky/get_scno.c b/linux/csky/get_scno.c
index 9efb202..9d4397a 100644
--- a/linux/csky/get_scno.c
+++ b/linux/csky/get_scno.c
@@ -12,7 +12,7 @@ arch_get_scno(struct tcb *tcp)
 #if defined(__CSKYABIV2__)
 	tcp->scno = csky_regs.regs[3];
 #else
-	tcp->scno = csky_regs.r1;
+	tcp->scno = csky_regs.a1;
 #endif
 	return 1;
 }
diff --git a/linux/csky/set_scno.c b/linux/csky/set_scno.c
index 655d108..c1e1c18 100644
--- a/linux/csky/set_scno.c
+++ b/linux/csky/set_scno.c
@@ -13,7 +13,7 @@ arch_set_scno(struct tcb *tcp, kernel_ulong_t scno)
 #if defined(__CSKYABIV2__)
 	csky_regs.regs[3] = scno;
 #else
-	csky_regs.r1 = scno;
+	csky_regs.a1 = scno;
 #endif
 	return set_regs(tcp->pid);
 }
-- 
1.8.3.1

