Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4C7174790
	for <lists+linux-csky@lfdr.de>; Sat, 29 Feb 2020 16:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgB2PHG (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 29 Feb 2020 10:07:06 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:48771 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727085AbgB2PHG (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Sat, 29 Feb 2020 10:07:06 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07499207|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.229394-0.0274106-0.743196;DS=CONTINUE|ham_alarm|0.0378873-0.000574383-0.961538;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16368;MF=zhiwei_liu@c-sky.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.GuBq59D_1582988809;
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
Subject: [PATCH v6 2/4] target/riscv: implementation-defined constant parameters
Date:   Sat, 29 Feb 2020 23:04:11 +0800
Message-Id: <20200229150413.24950-3-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200229150413.24950-1-zhiwei_liu@c-sky.com>
References: <20200229150413.24950-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

vlen is the vector register length in bits.
elen is the max element size in bits.
vext_spec is the vector specification version, default value is v0.7.1.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/riscv/cpu.c | 7 +++++++
 target/riscv/cpu.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8c86ebc109..6900714432 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -98,6 +98,11 @@ static void set_priv_version(CPURISCVState *env, int priv_ver)
     env->priv_ver = priv_ver;
 }
 
+static void set_vext_version(CPURISCVState *env, int vext_ver)
+{
+    env->vext_ver = vext_ver;
+}
+
 static void set_feature(CPURISCVState *env, int feature)
 {
     env->features |= (1ULL << feature);
@@ -320,6 +325,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     CPURISCVState *env = &cpu->env;
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     int priv_version = PRIV_VERSION_1_11_0;
+    int vext_version = VEXT_VERSION_0_07_1;
     target_ulong target_misa = 0;
     Error *local_err = NULL;
 
@@ -345,6 +351,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     }
 
     set_priv_version(env, priv_version);
+    set_vext_version(env, vext_version);
     set_resetvec(env, DEFAULT_RSTVEC);
 
     if (cpu->cfg.mmu) {
diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
index 2e8d01c155..748bd557f9 100644
--- a/target/riscv/cpu.h
+++ b/target/riscv/cpu.h
@@ -83,6 +83,8 @@ enum {
 #define PRIV_VERSION_1_10_0 0x00011000
 #define PRIV_VERSION_1_11_0 0x00011100
 
+#define VEXT_VERSION_0_07_1 0x00000701
+
 #define TRANSLATE_PMP_FAIL 2
 #define TRANSLATE_FAIL 1
 #define TRANSLATE_SUCCESS 0
@@ -117,6 +119,7 @@ struct CPURISCVState {
     target_ulong badaddr;
 
     target_ulong priv_ver;
+    target_ulong vext_ver;
     target_ulong misa;
     target_ulong misa_mask;
 
@@ -231,6 +234,8 @@ typedef struct RISCVCPU {
 
         char *priv_spec;
         char *user_spec;
+        uint16_t vlen;
+        uint16_t elen;
         bool mmu;
         bool pmp;
     } cfg;
-- 
2.23.0

