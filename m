Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81D4A17478E
	for <lists+linux-csky@lfdr.de>; Sat, 29 Feb 2020 16:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbgB2PGz (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 29 Feb 2020 10:06:55 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:58573 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727068AbgB2PGz (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Sat, 29 Feb 2020 10:06:55 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09570916|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0847261-0.00699878-0.908275;DS=CONTINUE|ham_system_inform|0.0333957-0.000332124-0.966272;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16378;MF=zhiwei_liu@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.GuBq59D_1582988809;
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com fp:SMTPD_---.GuBq59D_1582988809)
          by smtp.aliyun-inc.com(10.147.40.200);
          Sat, 29 Feb 2020 23:06:50 +0800
From:   LIU Zhiwei <zhiwei_liu@c-sky.com>
To:     richard.henderson@linaro.org, alistair23@gmail.com,
        chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org, LIU Zhiwei <zhiwei_liu@c-sky.com>,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v6 1/4] target/riscv: add vector extension field in CPURISCVState
Date:   Sat, 29 Feb 2020 23:04:10 +0800
Message-Id: <20200229150413.24950-2-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200229150413.24950-1-zhiwei_liu@c-sky.com>
References: <20200229150413.24950-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

The 32 vector registers will be viewed as a continuous memory block.
It avoids the convension between element index and (regno, offset).
Thus elements can be directly accessed by offset from the first vector
base address.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index de0a8d893a..2e8d01c155 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -64,6 +64,7 @@
 #define RVA RV('A')
 #define RVF RV('F')
 #define RVD RV('D')
+#define RVV RV('V')
 #define RVC RV('C')
 #define RVS RV('S')
 #define RVU RV('U')
@@ -93,9 +94,20 @@ typedef struct CPURISCVState CPURISCVState;
 
 #include "pmp.h"
 
+#define RV_VLEN_MAX 512
+
 struct CPURISCVState {
     target_ulong gpr[32];
     uint64_t fpr[32]; /* assume both F and D extensions */
+
+    /* vector coprocessor state. */
+    uint64_t vreg[32 * RV_VLEN_MAX / 64] QEMU_ALIGNED(16);
+    target_ulong vxrm;
+    target_ulong vxsat;
+    target_ulong vl;
+    target_ulong vstart;
+    target_ulong vtype;
+
     target_ulong pc;
     target_ulong load_res;
     target_ulong load_val;
-- 
2.23.0

