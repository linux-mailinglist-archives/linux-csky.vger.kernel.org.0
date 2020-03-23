Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B76E218F032
	for <lists+linux-csky@lfdr.de>; Mon, 23 Mar 2020 08:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbgCWHYH (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Mon, 23 Mar 2020 03:24:07 -0400
Received: from out30-57.freemail.mail.aliyun.com ([115.124.30.57]:33376 "EHLO
        out30-57.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727164AbgCWHYG (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Mon, 23 Mar 2020 03:24:06 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R661e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=majun258@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0TtKsQh4_1584948228;
Received: from localhost(mailfrom:majun258@linux.alibaba.com fp:SMTPD_---0TtKsQh4_1584948228)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 23 Mar 2020 15:23:53 +0800
From:   Ma Jun <majun258@linux.alibaba.com>
To:     dev-tech-nspr@lists.mozilla.org
Cc:     majun258@linux.alibaba.com, linux-csky@vger.kernel.org
Subject: [PATCH RESEND] Add the csky architecture support
Date:   Mon, 23 Mar 2020 15:23:21 +0800
Message-Id: <1584948201-16676-1-git-send-email-majun258@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Support the csky architecture

Signed-off-by: Ma Jun <majun258@linux.alibaba.com>
---
 nspr/pr/include/md/_linux.cfg | 46 +++++++++++++++++++++++++++++++++++++++++++
 nspr/pr/include/md/_linux.h   |  2 ++
 2 files changed, 48 insertions(+)

diff --git a/nspr/pr/include/md/_linux.cfg b/nspr/pr/include/md/_linux.cfg
index 547b7c8..9e2cfa0 100644
--- a/nspr/pr/include/md/_linux.cfg
+++ b/nspr/pr/include/md/_linux.cfg
@@ -1252,6 +1252,52 @@
 #define PR_BYTES_PER_WORD_LOG2   2
 #define PR_BYTES_PER_DWORD_LOG2  3
 
+#elif defined(__csky__)
+
+#undef  IS_BIG_ENDIAN
+#define IS_LITTLE_ENDIAN 1
+#undef  IS_64
+
+#define PR_BYTES_PER_BYTE   1
+#define PR_BYTES_PER_SHORT  2
+#define PR_BYTES_PER_INT    4
+#define PR_BYTES_PER_INT64  8
+#define PR_BYTES_PER_LONG   4
+#define PR_BYTES_PER_FLOAT  4
+#define PR_BYTES_PER_DOUBLE 8
+#define PR_BYTES_PER_WORD   4
+#define PR_BYTES_PER_DWORD  8
+
+#define PR_BITS_PER_BYTE    8
+#define PR_BITS_PER_SHORT   16
+#define PR_BITS_PER_INT     32
+#define PR_BITS_PER_INT64   64
+#define PR_BITS_PER_LONG    32
+#define PR_BITS_PER_FLOAT   32
+#define PR_BITS_PER_DOUBLE  64
+#define PR_BITS_PER_WORD    32
+
+#define PR_BITS_PER_BYTE_LOG2   3
+#define PR_BITS_PER_SHORT_LOG2  4
+#define PR_BITS_PER_INT_LOG2    5
+#define PR_BITS_PER_INT64_LOG2  6
+#define PR_BITS_PER_LONG_LOG2   5
+#define PR_BITS_PER_FLOAT_LOG2  5
+#define PR_BITS_PER_DOUBLE_LOG2 6
+#define PR_BITS_PER_WORD_LOG2   5
+
+#define PR_ALIGN_OF_SHORT   2
+#define PR_ALIGN_OF_INT     4
+#define PR_ALIGN_OF_LONG    4
+#define PR_ALIGN_OF_INT64   8
+#define PR_ALIGN_OF_FLOAT   4
+#define PR_ALIGN_OF_DOUBLE  8
+#define PR_ALIGN_OF_POINTER 4
+#define PR_ALIGN_OF_WORD    4
+
+#define PR_BYTES_PER_WORD_LOG2  2
+#define PR_BYTES_PER_DWORD_LOG2 3
+
 #else
 
 #error "Unknown CPU architecture"
diff --git a/nspr/pr/include/md/_linux.h b/nspr/pr/include/md/_linux.h
index 3a7bb13..1373727 100644
--- a/nspr/pr/include/md/_linux.h
+++ b/nspr/pr/include/md/_linux.h
@@ -67,6 +67,8 @@
 #define _PR_SI_ARCHITECTURE "nios2"
 #elif defined(__nds32__)
 #define _PR_SI_ARCHITECTURE "nds32"
+#elif defined(__csky__)
+#define _PR_SI_ARCHITECTURE "csky"
 #else
 #error "Unknown CPU architecture"
 #endif
-- 
1.8.3.1

