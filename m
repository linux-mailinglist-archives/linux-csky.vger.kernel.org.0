Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFD2816BEDC
	for <lists+linux-csky@lfdr.de>; Tue, 25 Feb 2020 11:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgBYKfQ (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 25 Feb 2020 05:35:16 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36143 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730126AbgBYKfQ (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Tue, 25 Feb 2020 05:35:16 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.65445-0.0401631-0.305387;DS=CONTINUE|ham_system_inform|0.686825-0.000258514-0.312917;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03308;MF=zhiwei_liu@c-sky.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.GsFPuQz_1582626910;
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com fp:SMTPD_---.GsFPuQz_1582626910)
          by smtp.aliyun-inc.com(10.147.40.44);
          Tue, 25 Feb 2020 18:35:13 +0800
From:   LIU Zhiwei <zhiwei_liu@c-sky.com>
To:     richard.henderson@linaro.org, alistair23@gmail.com,
        chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org, LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH v4 4/5] target/riscv: add fault-only-first unit stride load
Date:   Tue, 25 Feb 2020 18:35:07 +0800
Message-Id: <20200225103508.7651-5-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

The unit-stride fault-only-fault load instructions are used to
vectorize loops with data-dependent exit conditions(while loops).
These instructions execute as a regular load except that they
will only take a trap on element 0.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |  22 ++++
 target/riscv/insn32.decode              |   7 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  66 ++++++++++++
 target/riscv/vector_helper.c            | 136 ++++++++++++++++++++++++
 4 files changed, 231 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index f9b3da60ca..72ba4d9bdb 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -218,3 +218,25 @@ DEF_HELPER_6(vsxe_v_b, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxe_v_h, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxe_v_w, void, ptr, ptr, tl, ptr, env, i32)
 DEF_HELPER_6(vsxe_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_5(vlbff_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vleff_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vleff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vleff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vleff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbuff_v_b, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbuff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbuff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlbuff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhuff_v_h, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhuff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlhuff_v_d, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwuff_v_w, void, ptr, ptr, tl, env, i32)
+DEF_HELPER_5(vlwuff_v_d, void, ptr, ptr, tl, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6a363a6b7e..973ac63fda 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -219,6 +219,13 @@ vle_v      ... 000 . 00000 ..... 111 ..... 0000111 @r2_nfvm
 vlbu_v     ... 000 . 00000 ..... 000 ..... 0000111 @r2_nfvm
 vlhu_v     ... 000 . 00000 ..... 101 ..... 0000111 @r2_nfvm
 vlwu_v     ... 000 . 00000 ..... 110 ..... 0000111 @r2_nfvm
+vlbff_v    ... 100 . 10000 ..... 000 ..... 0000111 @r2_nfvm
+vlhff_v    ... 100 . 10000 ..... 101 ..... 0000111 @r2_nfvm
+vlwff_v    ... 100 . 10000 ..... 110 ..... 0000111 @r2_nfvm
+vleff_v    ... 000 . 10000 ..... 111 ..... 0000111 @r2_nfvm
+vlbuff_v   ... 000 . 10000 ..... 000 ..... 0000111 @r2_nfvm
+vlhuff_v   ... 000 . 10000 ..... 101 ..... 0000111 @r2_nfvm
+vlwuff_v   ... 000 . 10000 ..... 110 ..... 0000111 @r2_nfvm
 vsb_v      ... 000 . 00000 ..... 000 ..... 0100111 @r2_nfvm
 vsh_v      ... 000 . 00000 ..... 101 ..... 0100111 @r2_nfvm
 vsw_v      ... 000 . 00000 ..... 110 ..... 0100111 @r2_nfvm
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index c0d560d789..dda3ba555c 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -510,3 +510,69 @@ static bool trans_vsuxe_v(DisasContext *s, arg_rnfvm* a)
 {
     return trans_vsxe_v(s, a);
 }
+
+/*
+ *** unit stride fault-only-first load
+ */
+static bool ldff_trans(uint32_t vd, uint32_t rs1, uint32_t data,
+        gen_helper_ldst_us *fn, DisasContext *s)
+{
+    TCGv_ptr dest, mask;
+    TCGv base;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    base = tcg_temp_new();
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    gen_get_gpr(base, rs1);
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, base, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free(base);
+    tcg_temp_free_i32(desc);
+    return true;
+}
+
+static bool ldff_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
+{
+    uint8_t nf = a->nf + 1;
+    uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9) | (nf << 11);
+    gen_helper_ldst_us *fn;
+    static gen_helper_ldst_us * const fns[7][4] = {
+        { gen_helper_vlbff_v_b,  gen_helper_vlbff_v_h,
+          gen_helper_vlbff_v_w,  gen_helper_vlbff_v_d },
+        { NULL,                  gen_helper_vlhff_v_h,
+          gen_helper_vlhff_v_w,  gen_helper_vlhff_v_d },
+        { NULL,                  NULL,
+          gen_helper_vlwff_v_w,  gen_helper_vlwff_v_d },
+        { gen_helper_vleff_v_b,  gen_helper_vleff_v_h,
+          gen_helper_vleff_v_w,  gen_helper_vleff_v_d },
+        { gen_helper_vlbuff_v_b, gen_helper_vlbuff_v_h,
+          gen_helper_vlbuff_v_w, gen_helper_vlbuff_v_d },
+        { NULL,                  gen_helper_vlhuff_v_h,
+          gen_helper_vlhuff_v_w, gen_helper_vlhuff_v_d },
+        { NULL,                  NULL,
+          gen_helper_vlwuff_v_w, gen_helper_vlwuff_v_d }
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    return ldff_trans(a->rd, a->rs1, data, fn, s);
+}
+
+GEN_VEXT_TRANS(vlbff_v, 0, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vlhff_v, 1, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vlwff_v, 2, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vleff_v, 3, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vlbuff_v, 4, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vlhuff_v, 5, r2nfvm, ldff_op, ld_us_check)
+GEN_VEXT_TRANS(vlwuff_v, 6, r2nfvm, ldff_op, ld_us_check)
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 908f48e216..6772e31ecb 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -277,6 +277,28 @@ GEN_VEXT_LD_ELEM(vlxhu_v_w, uint16_t, uint32_t, H4, lduw)
 GEN_VEXT_LD_ELEM(vlxhu_v_d, uint16_t, uint64_t, H8, lduw)
 GEN_VEXT_LD_ELEM(vlxwu_v_w, uint32_t, uint32_t, H4, ldl)
 GEN_VEXT_LD_ELEM(vlxwu_v_d, uint32_t, uint64_t, H8, ldl)
+GEN_VEXT_LD_ELEM(vlbff_v_b, int8_t,  int8_t,  H1, ldsb)
+GEN_VEXT_LD_ELEM(vlbff_v_h, int8_t,  int16_t, H2, ldsb)
+GEN_VEXT_LD_ELEM(vlbff_v_w, int8_t,  int32_t, H4, ldsb)
+GEN_VEXT_LD_ELEM(vlbff_v_d, int8_t,  int64_t, H8, ldsb)
+GEN_VEXT_LD_ELEM(vlhff_v_h, int16_t, int16_t, H2, ldsw)
+GEN_VEXT_LD_ELEM(vlhff_v_w, int16_t, int32_t, H4, ldsw)
+GEN_VEXT_LD_ELEM(vlhff_v_d, int16_t, int64_t, H8, ldsw)
+GEN_VEXT_LD_ELEM(vlwff_v_w, int32_t, int32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vlwff_v_d, int32_t, int64_t, H8, ldl)
+GEN_VEXT_LD_ELEM(vleff_v_b, int8_t,  int8_t,  H1, ldsb)
+GEN_VEXT_LD_ELEM(vleff_v_h, int16_t, int16_t, H2, ldsw)
+GEN_VEXT_LD_ELEM(vleff_v_w, int32_t, int32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vleff_v_d, int64_t, int64_t, H8, ldq)
+GEN_VEXT_LD_ELEM(vlbuff_v_b, uint8_t,  uint8_t,  H1, ldub)
+GEN_VEXT_LD_ELEM(vlbuff_v_h, uint8_t,  uint16_t, H2, ldub)
+GEN_VEXT_LD_ELEM(vlbuff_v_w, uint8_t,  uint32_t, H4, ldub)
+GEN_VEXT_LD_ELEM(vlbuff_v_d, uint8_t,  uint64_t, H8, ldub)
+GEN_VEXT_LD_ELEM(vlhuff_v_h, uint16_t, uint16_t, H2, lduw)
+GEN_VEXT_LD_ELEM(vlhuff_v_w, uint16_t, uint32_t, H4, lduw)
+GEN_VEXT_LD_ELEM(vlhuff_v_d, uint16_t, uint64_t, H8, lduw)
+GEN_VEXT_LD_ELEM(vlwuff_v_w, uint32_t, uint32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vlwuff_v_d, uint32_t, uint64_t, H8, ldl)
 
 #define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                       \
 static void vext_##NAME##_st_elem(CPURISCVState *env, abi_ptr addr,   \
@@ -840,3 +862,117 @@ GEN_VEXT_ST_INDEX(vsxe_v_b, int8_t,  int8_t)
 GEN_VEXT_ST_INDEX(vsxe_v_h, int16_t, int16_t)
 GEN_VEXT_ST_INDEX(vsxe_v_w, int32_t, int32_t)
 GEN_VEXT_ST_INDEX(vsxe_v_d, int64_t, int64_t)
+
+/*
+ *** unit-stride fault-only-fisrt load instructions
+ */
+static inline void vext_ldff(void *vd, void *v0, target_ulong base,
+        CPURISCVState *env, uint32_t desc,
+        vext_ld_elem_fn ld_elem,
+        vext_ld_clear_elem clear_elem,
+        int mmuidx, uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    void *host;
+    uint32_t i, k, vl = 0;
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t nf = vext_nf(desc);
+    uint32_t vm = vext_vm(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+    target_ulong addr, offset, remain;
+
+    if (env->vl == 0) {
+        return;
+    }
+    /* probe every access*/
+    for (i = 0; i < env->vl; i++) {
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        addr = base + nf * i * msz;
+        if (i == 0) {
+            probe_read_access(env, addr, nf * msz, ra);
+        } else {
+            /* if it triggles an exception, no need to check watchpoint */
+            offset = -(addr | TARGET_PAGE_MASK);
+            remain = nf * msz;
+            while (remain > 0) {
+                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmuidx);
+                if (host) {
+#ifdef CONFIG_USER_ONLY
+                    if (page_check_range(addr, nf * msz, PAGE_READ) < 0) {
+                        vl = i;
+                        goto ProbeSuccess;
+                    }
+#else
+                    probe_read_access(env, addr, nf * msz, ra);
+#endif
+                } else {
+                    vl = i;
+                    goto ProbeSuccess;
+                }
+                if (remain <=  offset) {
+                    break;
+                }
+                remain -= offset;
+                addr += offset;
+                offset = -(addr | TARGET_PAGE_MASK);
+            }
+        }
+    }
+ProbeSuccess:
+    /* load bytes from guest memory */
+    if (vl != 0) {
+        env->vl = vl;
+    }
+    for (i = 0; i < env->vl; i++) {
+        k = 0;
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        while (k < nf) {
+            target_ulong addr = base + (i * nf + k) * msz;
+            ld_elem(env, addr, i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+    /* clear tail elements */
+    if (vl != 0) {
+        return;
+    }
+    for (k = 0; k < nf; k++) {
+        clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+    }
+}
+
+#define GEN_VEXT_LDFF(NAME, MTYPE, ETYPE, MMUIDX)         \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,  \
+        CPURISCVState *env, uint32_t desc)                \
+{                                                         \
+    vext_ldff(vd, v0, base, env, desc,                    \
+        vext_##NAME##_ld_elem,                            \
+        vext_##NAME##_clear_elem,                         \
+        MMUIDX, sizeof(ETYPE), sizeof(MTYPE), GETPC());   \
+}
+
+GEN_VEXT_LDFF(vlbff_v_b, int8_t,  int8_t, MO_SB)
+GEN_VEXT_LDFF(vlbff_v_h, int8_t,  int16_t, MO_SB)
+GEN_VEXT_LDFF(vlbff_v_w, int8_t,  int32_t, MO_SB)
+GEN_VEXT_LDFF(vlbff_v_d, int8_t,  int64_t, MO_SB)
+GEN_VEXT_LDFF(vlhff_v_h, int16_t, int16_t, MO_LESW)
+GEN_VEXT_LDFF(vlhff_v_w, int16_t, int32_t, MO_LESW)
+GEN_VEXT_LDFF(vlhff_v_d, int16_t, int64_t, MO_LESW)
+GEN_VEXT_LDFF(vlwff_v_w, int32_t, int32_t, MO_LESL)
+GEN_VEXT_LDFF(vlwff_v_d, int32_t, int64_t, MO_LESL)
+GEN_VEXT_LDFF(vleff_v_b, int8_t,  int8_t, MO_SB)
+GEN_VEXT_LDFF(vleff_v_h, int16_t, int16_t, MO_LESW)
+GEN_VEXT_LDFF(vleff_v_w, int32_t, int32_t, MO_LESL)
+GEN_VEXT_LDFF(vleff_v_d, int64_t, int64_t, MO_LEQ)
+GEN_VEXT_LDFF(vlbuff_v_b, uint8_t,  uint8_t, MO_UB)
+GEN_VEXT_LDFF(vlbuff_v_h, uint8_t,  uint16_t, MO_UB)
+GEN_VEXT_LDFF(vlbuff_v_w, uint8_t,  uint32_t, MO_UB)
+GEN_VEXT_LDFF(vlbuff_v_d, uint8_t,  uint64_t, MO_UB)
+GEN_VEXT_LDFF(vlhuff_v_h, uint16_t, uint16_t, MO_LEUW)
+GEN_VEXT_LDFF(vlhuff_v_w, uint16_t, uint32_t, MO_LEUW)
+GEN_VEXT_LDFF(vlhuff_v_d, uint16_t, uint64_t, MO_LEUW)
+GEN_VEXT_LDFF(vlwuff_v_w, uint32_t, uint32_t, MO_LEUL)
+GEN_VEXT_LDFF(vlwuff_v_d, uint32_t, uint64_t, MO_LEUL)
-- 
2.23.0

