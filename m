Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF8616BEDD
	for <lists+linux-csky@lfdr.de>; Tue, 25 Feb 2020 11:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgBYKfT (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 25 Feb 2020 05:35:19 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40162 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730186AbgBYKfT (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Tue, 25 Feb 2020 05:35:19 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.578815-0.0392774-0.381908;DS=CONTINUE|ham_system_inform|0.0040965-8.31447e-05-0.99582;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=zhiwei_liu@c-sky.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.GsFPuQz_1582626910;
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com fp:SMTPD_---.GsFPuQz_1582626910)
          by smtp.aliyun-inc.com(10.147.40.44);
          Tue, 25 Feb 2020 18:35:12 +0800
From:   LIU Zhiwei <zhiwei_liu@c-sky.com>
To:     richard.henderson@linaro.org, alistair23@gmail.com,
        chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org, LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH v4 3/5] target/riscv: add vector index load and store instructions
Date:   Tue, 25 Feb 2020 18:35:06 +0800
Message-Id: <20200225103508.7651-4-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Vector indexed operations add the contents of each element of the
vector offset operand specified by vs2 to the base effective address
to give the effective address of each element.

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
---
 target/riscv/helper.h                   |  35 ++++
 target/riscv/insn32.decode              |  16 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 138 +++++++++++++++
 target/riscv/vector_helper.c            | 219 ++++++++++++++++++++++++
 4 files changed, 408 insertions(+)

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 87dfa90609..f9b3da60ca 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -183,3 +183,38 @@ DEF_HELPER_6(vsse_v_b, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vsse_v_h, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vsse_v_w, void, ptr, ptr, tl, tl, env, i32)
 DEF_HELPER_6(vsse_v_d, void, ptr, ptr, tl, tl, env, i32)
+DEF_HELPER_6(vlxb_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxb_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxb_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxb_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxh_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxh_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxh_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxw_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxe_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxe_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxe_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxe_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxbu_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxbu_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxbu_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxbu_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxhu_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxhu_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxhu_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxwu_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vlxwu_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxb_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxb_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxb_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxb_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxh_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxh_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxh_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxw_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxw_v_d, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxe_v_b, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxe_v_h, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxe_v_w, void, ptr, ptr, tl, ptr, env, i32)
+DEF_HELPER_6(vsxe_v_d, void, ptr, ptr, tl, ptr, env, i32)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 2f2d3d13b3..6a363a6b7e 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -236,6 +236,22 @@ vssh_v     ... 010 . ..... ..... 101 ..... 0100111 @r_nfvm
 vssw_v     ... 010 . ..... ..... 110 ..... 0100111 @r_nfvm
 vsse_v     ... 010 . ..... ..... 111 ..... 0100111 @r_nfvm
 
+vlxb_v     ... 111 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlxh_v     ... 111 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlxw_v     ... 111 . ..... ..... 110 ..... 0000111 @r_nfvm
+vlxe_v     ... 011 . ..... ..... 111 ..... 0000111 @r_nfvm
+vlxbu_v    ... 011 . ..... ..... 000 ..... 0000111 @r_nfvm
+vlxhu_v    ... 011 . ..... ..... 101 ..... 0000111 @r_nfvm
+vlxwu_v    ... 011 . ..... ..... 110 ..... 0000111 @r_nfvm
+vsxb_v     ... 011 . ..... ..... 000 ..... 0100111 @r_nfvm
+vsxh_v     ... 011 . ..... ..... 101 ..... 0100111 @r_nfvm
+vsxw_v     ... 011 . ..... ..... 110 ..... 0100111 @r_nfvm
+vsxe_v     ... 011 . ..... ..... 111 ..... 0100111 @r_nfvm
+vsuxb_v    ... 111 . ..... ..... 000 ..... 0100111 @r_nfvm
+vsuxh_v    ... 111 . ..... ..... 101 ..... 0100111 @r_nfvm
+vsuxw_v    ... 111 . ..... ..... 110 ..... 0100111 @r_nfvm
+vsuxe_v    ... 111 . ..... ..... 111 ..... 0100111 @r_nfvm
+
 # *** new major opcode OP-V ***
 vsetvli         0 ........... ..... 111 ..... 1010111  @r2_zimm
 vsetvl          1000000 ..... ..... 111 ..... 1010111  @r
diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
index 1b627dc880..c0d560d789 100644
--- a/target/riscv/insn_trans/trans_rvv.inc.c
+++ b/target/riscv/insn_trans/trans_rvv.inc.c
@@ -372,3 +372,141 @@ GEN_VEXT_TRANS(vssb_v, 0, rnfvm, st_stride_op, st_stride_check)
 GEN_VEXT_TRANS(vssh_v, 1, rnfvm, st_stride_op, st_stride_check)
 GEN_VEXT_TRANS(vssw_v, 2, rnfvm, st_stride_op, st_stride_check)
 GEN_VEXT_TRANS(vsse_v, 3, rnfvm, st_stride_op, st_stride_check)
+
+/*
+ *** index load and store
+ */
+typedef void gen_helper_ldst_index(TCGv_ptr, TCGv_ptr, TCGv,
+        TCGv_ptr, TCGv_env, TCGv_i32);
+
+static bool ldst_index_trans(uint32_t vd, uint32_t rs1, uint32_t vs2,
+        uint32_t data, gen_helper_ldst_index *fn, DisasContext *s)
+{
+    TCGv_ptr dest, mask, index;
+    TCGv base;
+    TCGv_i32 desc;
+
+    dest = tcg_temp_new_ptr();
+    mask = tcg_temp_new_ptr();
+    index = tcg_temp_new_ptr();
+    base = tcg_temp_new();
+    desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
+
+    gen_get_gpr(base, rs1);
+    tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, vd));
+    tcg_gen_addi_ptr(index, cpu_env, vreg_ofs(s, vs2));
+    tcg_gen_addi_ptr(mask, cpu_env, vreg_ofs(s, 0));
+
+    fn(dest, mask, base, index, cpu_env, desc);
+
+    tcg_temp_free_ptr(dest);
+    tcg_temp_free_ptr(mask);
+    tcg_temp_free_ptr(index);
+    tcg_temp_free(base);
+    tcg_temp_free_i32(desc);
+    return true;
+}
+
+static bool ld_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint8_t nf = a->nf + 1;
+    uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9) | (nf << 11);
+    gen_helper_ldst_index *fn;
+    static gen_helper_ldst_index * const fns[7][4] = {
+        { gen_helper_vlxb_v_b,  gen_helper_vlxb_v_h,
+          gen_helper_vlxb_v_w,  gen_helper_vlxb_v_d },
+        { NULL,                 gen_helper_vlxh_v_h,
+          gen_helper_vlxh_v_w,  gen_helper_vlxh_v_d },
+        { NULL,                 NULL,
+          gen_helper_vlxw_v_w,  gen_helper_vlxw_v_d },
+        { gen_helper_vlxe_v_b,  gen_helper_vlxe_v_h,
+          gen_helper_vlxe_v_w,  gen_helper_vlxe_v_d },
+        { gen_helper_vlxbu_v_b, gen_helper_vlxbu_v_h,
+          gen_helper_vlxbu_v_w, gen_helper_vlxbu_v_d },
+        { NULL,                 gen_helper_vlxhu_v_h,
+          gen_helper_vlxhu_v_w, gen_helper_vlxhu_v_d },
+        { NULL,                 NULL,
+          gen_helper_vlxwu_v_w, gen_helper_vlxwu_v_d },
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+static bool ld_index_check(DisasContext *s, arg_rnfvm* a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_overlap_mask(s, a->rd, a->vm) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_nf(s, a->nf));
+}
+
+GEN_VEXT_TRANS(vlxb_v, 0, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxh_v, 1, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxw_v, 2, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxe_v, 3, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxbu_v, 4, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxhu_v, 5, rnfvm, ld_index_op, ld_index_check)
+GEN_VEXT_TRANS(vlxwu_v, 6, rnfvm, ld_index_op, ld_index_check)
+
+static bool st_index_op(DisasContext *s, arg_rnfvm *a, uint8_t seq)
+{
+    uint8_t nf = a->nf + 1;
+    uint32_t data = s->mlen | (a->vm << 8) | (s->lmul << 9) | (nf << 11);
+    gen_helper_ldst_index *fn;
+    static gen_helper_ldst_index * const fns[4][4] = {
+        { gen_helper_vsxb_v_b,  gen_helper_vsxb_v_h,
+          gen_helper_vsxb_v_w,  gen_helper_vsxb_v_d },
+        { NULL,                 gen_helper_vsxh_v_h,
+          gen_helper_vsxh_v_w,  gen_helper_vsxh_v_d },
+        { NULL,                 NULL,
+          gen_helper_vsxw_v_w,  gen_helper_vsxw_v_d },
+        { gen_helper_vsxe_v_b,  gen_helper_vsxe_v_h,
+          gen_helper_vsxe_v_w,  gen_helper_vsxe_v_d }
+    };
+
+    fn =  fns[seq][s->sew];
+    if (fn == NULL) {
+        return false;
+    }
+
+    return ldst_index_trans(a->rd, a->rs1, a->rs2, data, fn, s);
+}
+
+static bool st_index_check(DisasContext *s, arg_rnfvm* a)
+{
+    return (vext_check_isa_ill(s, RVV) &&
+            vext_check_reg(s, a->rd, false) &&
+            vext_check_reg(s, a->rs2, false) &&
+            vext_check_nf(s, a->nf));
+}
+
+GEN_VEXT_TRANS(vsxb_v, 0, rnfvm, st_index_op, st_index_check)
+GEN_VEXT_TRANS(vsxh_v, 1, rnfvm, st_index_op, st_index_check)
+GEN_VEXT_TRANS(vsxw_v, 2, rnfvm, st_index_op, st_index_check)
+GEN_VEXT_TRANS(vsxe_v, 3, rnfvm, st_index_op, st_index_check)
+
+static bool trans_vsuxb_v(DisasContext *s, arg_rnfvm* a)
+{
+    return trans_vsxb_v(s, a);
+}
+
+static bool trans_vsuxh_v(DisasContext *s, arg_rnfvm* a)
+{
+    return trans_vsxh_v(s, a);
+}
+
+static bool trans_vsuxw_v(DisasContext *s, arg_rnfvm* a)
+{
+    return trans_vsxw_v(s, a);
+}
+
+static bool trans_vsuxe_v(DisasContext *s, arg_rnfvm* a)
+{
+    return trans_vsxe_v(s, a);
+}
diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 8a8c062ad5..908f48e216 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -255,6 +255,28 @@ GEN_VEXT_LD_ELEM(vlshu_v_w, uint16_t, uint32_t, H4, lduw)
 GEN_VEXT_LD_ELEM(vlshu_v_d, uint16_t, uint64_t, H8, lduw)
 GEN_VEXT_LD_ELEM(vlswu_v_w, uint32_t, uint32_t, H4, ldl)
 GEN_VEXT_LD_ELEM(vlswu_v_d, uint32_t, uint64_t, H8, ldl)
+GEN_VEXT_LD_ELEM(vlxb_v_b, int8_t,  int8_t,  H1, ldsb)
+GEN_VEXT_LD_ELEM(vlxb_v_h, int8_t,  int16_t, H2, ldsb)
+GEN_VEXT_LD_ELEM(vlxb_v_w, int8_t,  int32_t, H4, ldsb)
+GEN_VEXT_LD_ELEM(vlxb_v_d, int8_t,  int64_t, H8, ldsb)
+GEN_VEXT_LD_ELEM(vlxh_v_h, int16_t, int16_t, H2, ldsw)
+GEN_VEXT_LD_ELEM(vlxh_v_w, int16_t, int32_t, H4, ldsw)
+GEN_VEXT_LD_ELEM(vlxh_v_d, int16_t, int64_t, H8, ldsw)
+GEN_VEXT_LD_ELEM(vlxw_v_w, int32_t, int32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vlxw_v_d, int32_t, int64_t, H8, ldl)
+GEN_VEXT_LD_ELEM(vlxe_v_b, int8_t,  int8_t,  H1, ldsb)
+GEN_VEXT_LD_ELEM(vlxe_v_h, int16_t, int16_t, H2, ldsw)
+GEN_VEXT_LD_ELEM(vlxe_v_w, int32_t, int32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vlxe_v_d, int64_t, int64_t, H8, ldq)
+GEN_VEXT_LD_ELEM(vlxbu_v_b, uint8_t,  uint8_t,  H1, ldub)
+GEN_VEXT_LD_ELEM(vlxbu_v_h, uint8_t,  uint16_t, H2, ldub)
+GEN_VEXT_LD_ELEM(vlxbu_v_w, uint8_t,  uint32_t, H4, ldub)
+GEN_VEXT_LD_ELEM(vlxbu_v_d, uint8_t,  uint64_t, H8, ldub)
+GEN_VEXT_LD_ELEM(vlxhu_v_h, uint16_t, uint16_t, H2, lduw)
+GEN_VEXT_LD_ELEM(vlxhu_v_w, uint16_t, uint32_t, H4, lduw)
+GEN_VEXT_LD_ELEM(vlxhu_v_d, uint16_t, uint64_t, H8, lduw)
+GEN_VEXT_LD_ELEM(vlxwu_v_w, uint32_t, uint32_t, H4, ldl)
+GEN_VEXT_LD_ELEM(vlxwu_v_d, uint32_t, uint64_t, H8, ldl)
 
 #define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                       \
 static void vext_##NAME##_st_elem(CPURISCVState *env, abi_ptr addr,   \
@@ -291,6 +313,19 @@ GEN_VEXT_ST_ELEM(vsse_v_b, int8_t,  H1, stb)
 GEN_VEXT_ST_ELEM(vsse_v_h, int16_t, H2, stw)
 GEN_VEXT_ST_ELEM(vsse_v_w, int32_t, H4, stl)
 GEN_VEXT_ST_ELEM(vsse_v_d, int64_t, H8, stq)
+GEN_VEXT_ST_ELEM(vsxb_v_b, int8_t,  H1, stb)
+GEN_VEXT_ST_ELEM(vsxb_v_h, int16_t, H2, stb)
+GEN_VEXT_ST_ELEM(vsxb_v_w, int32_t, H4, stb)
+GEN_VEXT_ST_ELEM(vsxb_v_d, int64_t, H8, stb)
+GEN_VEXT_ST_ELEM(vsxh_v_h, int16_t, H2, stw)
+GEN_VEXT_ST_ELEM(vsxh_v_w, int32_t, H4, stw)
+GEN_VEXT_ST_ELEM(vsxh_v_d, int64_t, H8, stw)
+GEN_VEXT_ST_ELEM(vsxw_v_w, int32_t, H4, stl)
+GEN_VEXT_ST_ELEM(vsxw_v_d, int64_t, H8, stl)
+GEN_VEXT_ST_ELEM(vsxe_v_b, int8_t,  H1, stb)
+GEN_VEXT_ST_ELEM(vsxe_v_h, int16_t, H2, stw)
+GEN_VEXT_ST_ELEM(vsxe_v_w, int32_t, H4, stl)
+GEN_VEXT_ST_ELEM(vsxe_v_d, int64_t, H8, stq)
 
 /*
  *** unit-stride: load vector element from continuous guest memory
@@ -621,3 +656,187 @@ GEN_VEXT_ST_STRIDE(vsse_v_b, int8_t,  int8_t)
 GEN_VEXT_ST_STRIDE(vsse_v_h, int16_t, int16_t)
 GEN_VEXT_ST_STRIDE(vsse_v_w, int32_t, int32_t)
 GEN_VEXT_ST_STRIDE(vsse_v_d, int64_t, int64_t)
+
+/*
+ *** index: load indexed vector element from guest memory
+ */
+typedef target_ulong (*vext_get_index_addr)(target_ulong base,
+        uint32_t idx, void *vs2);
+
+#define GEN_VEXT_GET_INDEX_ADDR(NAME, ETYPE, H)                   \
+static target_ulong vext_##NAME##_get_addr(target_ulong base,     \
+        uint32_t idx, void *vs2)                                  \
+{                                                                 \
+    return (base + *((ETYPE *)vs2 + H(idx)));                     \
+}
+
+GEN_VEXT_GET_INDEX_ADDR(vlxb_v_b, int8_t,  H1)
+GEN_VEXT_GET_INDEX_ADDR(vlxb_v_h, int16_t, H2)
+GEN_VEXT_GET_INDEX_ADDR(vlxb_v_w, int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vlxb_v_d, int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vlxh_v_h, int16_t, H2)
+GEN_VEXT_GET_INDEX_ADDR(vlxh_v_w, int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vlxh_v_d, int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vlxw_v_w, int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vlxw_v_d, int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vlxe_v_b, int8_t,  H1)
+GEN_VEXT_GET_INDEX_ADDR(vlxe_v_h, int16_t, H2)
+GEN_VEXT_GET_INDEX_ADDR(vlxe_v_w, int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vlxe_v_d, int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vlxbu_v_b, uint8_t,  H1)
+GEN_VEXT_GET_INDEX_ADDR(vlxbu_v_h, uint16_t, H2)
+GEN_VEXT_GET_INDEX_ADDR(vlxbu_v_w, uint32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vlxbu_v_d, uint64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vlxhu_v_h, uint16_t, H2)
+GEN_VEXT_GET_INDEX_ADDR(vlxhu_v_w, uint32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vlxhu_v_d, uint64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vlxwu_v_w, uint32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vlxwu_v_d, uint64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vsxb_v_b, int8_t,  H1)
+GEN_VEXT_GET_INDEX_ADDR(vsxb_v_h, int16_t, H2)
+GEN_VEXT_GET_INDEX_ADDR(vsxb_v_w, int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vsxb_v_d, int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vsxh_v_h, int16_t, H2)
+GEN_VEXT_GET_INDEX_ADDR(vsxh_v_w, int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vsxh_v_d, int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vsxw_v_w, int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vsxw_v_d, int64_t, H8)
+GEN_VEXT_GET_INDEX_ADDR(vsxe_v_b, int8_t,  H1)
+GEN_VEXT_GET_INDEX_ADDR(vsxe_v_h, int16_t, H2)
+GEN_VEXT_GET_INDEX_ADDR(vsxe_v_w, int32_t, H4)
+GEN_VEXT_GET_INDEX_ADDR(vsxe_v_d, int64_t, H8)
+
+static inline void vext_ld_index(void *vd, void *v0, target_ulong base,
+        void *vs2, CPURISCVState *env, uint32_t desc,
+        vext_get_index_addr get_index_addr,
+        vext_ld_elem_fn ld_elem,
+        vext_ld_clear_elem clear_elem,
+        uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    uint32_t i, k;
+    uint32_t nf = vext_nf(desc);
+    uint32_t vm = vext_vm(desc);
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+
+    if (env->vl == 0) {
+        return;
+    }
+    /* probe every access*/
+    for (i = 0; i < env->vl; i++) {
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        probe_read_access(env, get_index_addr(base, i, vs2), nf * msz, ra);
+    }
+    /* load bytes from guest memory */
+    for (i = 0; i < env->vl; i++) {
+        k = 0;
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        while (k < nf) {
+            abi_ptr addr = get_index_addr(base, i, vs2) + k * msz;
+            ld_elem(env, addr, i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+    /* clear tail elements */
+    for (k = 0; k < nf; k++) {
+        clear_elem(vd, env->vl + k * vlmax, env->vl * esz, vlmax * esz);
+    }
+}
+
+#define GEN_VEXT_LD_INDEX(NAME, MTYPE, ETYPE)              \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,   \
+        void *vs2, CPURISCVState *env, uint32_t desc)      \
+{                                                          \
+    vext_ld_index(vd, v0, base, vs2, env, desc,            \
+        vext_##NAME##_get_addr,                            \
+        vext_##NAME##_ld_elem,                             \
+        vext_##NAME##_clear_elem,                          \
+        sizeof(ETYPE), sizeof(MTYPE), GETPC());            \
+}
+
+GEN_VEXT_LD_INDEX(vlxb_v_b, int8_t,  int8_t)
+GEN_VEXT_LD_INDEX(vlxb_v_h, int8_t,  int16_t)
+GEN_VEXT_LD_INDEX(vlxb_v_w, int8_t,  int32_t)
+GEN_VEXT_LD_INDEX(vlxb_v_d, int8_t,  int64_t)
+GEN_VEXT_LD_INDEX(vlxh_v_h, int16_t, int16_t)
+GEN_VEXT_LD_INDEX(vlxh_v_w, int16_t, int32_t)
+GEN_VEXT_LD_INDEX(vlxh_v_d, int16_t, int64_t)
+GEN_VEXT_LD_INDEX(vlxw_v_w, int32_t, int32_t)
+GEN_VEXT_LD_INDEX(vlxw_v_d, int32_t, int64_t)
+GEN_VEXT_LD_INDEX(vlxe_v_b, int8_t,  int8_t)
+GEN_VEXT_LD_INDEX(vlxe_v_h, int16_t, int16_t)
+GEN_VEXT_LD_INDEX(vlxe_v_w, int32_t, int32_t)
+GEN_VEXT_LD_INDEX(vlxe_v_d, int64_t, int64_t)
+GEN_VEXT_LD_INDEX(vlxbu_v_b, uint8_t,  uint8_t)
+GEN_VEXT_LD_INDEX(vlxbu_v_h, uint8_t,  uint16_t)
+GEN_VEXT_LD_INDEX(vlxbu_v_w, uint8_t,  uint32_t)
+GEN_VEXT_LD_INDEX(vlxbu_v_d, uint8_t,  uint64_t)
+GEN_VEXT_LD_INDEX(vlxhu_v_h, uint16_t, uint16_t)
+GEN_VEXT_LD_INDEX(vlxhu_v_w, uint16_t, uint32_t)
+GEN_VEXT_LD_INDEX(vlxhu_v_d, uint16_t, uint64_t)
+GEN_VEXT_LD_INDEX(vlxwu_v_w, uint32_t, uint32_t)
+GEN_VEXT_LD_INDEX(vlxwu_v_d, uint32_t, uint64_t)
+
+/*
+ *** index: store indexed vector element to guest memory
+ */
+static inline void vext_st_index(void *vd, void *v0, target_ulong base,
+        void *vs2, CPURISCVState *env, uint32_t desc,
+        vext_get_index_addr get_index_addr,
+        vext_st_elem_fn st_elem,
+        uint32_t esz, uint32_t msz, uintptr_t ra)
+{
+    uint32_t i, k;
+    uint32_t nf = vext_nf(desc);
+    uint32_t vm = vext_vm(desc);
+    uint32_t mlen = vext_mlen(desc);
+    uint32_t vlmax = vext_maxsz(desc) / esz;
+
+    /* probe every access*/
+    for (i = 0; i < env->vl; i++) {
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        probe_write_access(env, get_index_addr(base, i, vs2), nf * msz, ra);
+    }
+    /* store bytes to guest memory */
+    for (i = 0; i < env->vl; i++) {
+        k = 0;
+        if (!vm && !vext_elem_mask(v0, mlen, i)) {
+            continue;
+        }
+        while (k < nf) {
+            target_ulong addr = get_index_addr(base, i, vs2) + k * msz;
+            st_elem(env, addr, i + k * vlmax, vd, ra);
+            k++;
+        }
+    }
+}
+
+#define GEN_VEXT_ST_INDEX(NAME, MTYPE, ETYPE)                \
+void HELPER(NAME)(void *vd, void *v0, target_ulong base,     \
+        void *vs2, CPURISCVState *env, uint32_t desc)        \
+{                                                            \
+    vext_st_index(vd, v0, base, vs2, env, desc,              \
+        vext_##NAME##_get_addr,                              \
+        vext_##NAME##_st_elem,                               \
+        sizeof(ETYPE), sizeof(MTYPE), GETPC());              \
+}
+
+GEN_VEXT_ST_INDEX(vsxb_v_b, int8_t,  int8_t)
+GEN_VEXT_ST_INDEX(vsxb_v_h, int8_t,  int16_t)
+GEN_VEXT_ST_INDEX(vsxb_v_w, int8_t,  int32_t)
+GEN_VEXT_ST_INDEX(vsxb_v_d, int8_t,  int64_t)
+GEN_VEXT_ST_INDEX(vsxh_v_h, int16_t, int16_t)
+GEN_VEXT_ST_INDEX(vsxh_v_w, int16_t, int32_t)
+GEN_VEXT_ST_INDEX(vsxh_v_d, int16_t, int64_t)
+GEN_VEXT_ST_INDEX(vsxw_v_w, int32_t, int32_t)
+GEN_VEXT_ST_INDEX(vsxw_v_d, int32_t, int64_t)
+GEN_VEXT_ST_INDEX(vsxe_v_b, int8_t,  int8_t)
+GEN_VEXT_ST_INDEX(vsxe_v_h, int16_t, int16_t)
+GEN_VEXT_ST_INDEX(vsxe_v_w, int32_t, int32_t)
+GEN_VEXT_ST_INDEX(vsxe_v_d, int64_t, int64_t)
-- 
2.23.0

