Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D182A17478F
	for <lists+linux-csky@lfdr.de>; Sat, 29 Feb 2020 16:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727112AbgB2PHA (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 29 Feb 2020 10:07:00 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:41082 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727103AbgB2PHA (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Sat, 29 Feb 2020 10:07:00 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1036667|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.143762-0.0303341-0.825904;DS=CONTINUE|ham_system_inform|0.0467761-0.00184495-0.951379;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03278;MF=zhiwei_liu@c-sky.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.GuBq59D_1582988809;
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com fp:SMTPD_---.GuBq59D_1582988809)
          by smtp.aliyun-inc.com(10.147.40.200);
          Sat, 29 Feb 2020 23:06:49 +0800
From:   LIU Zhiwei <zhiwei_liu@c-sky.com>
To:     richard.henderson@linaro.org, alistair23@gmail.com,
        chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org, LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH v6 0/4] target-riscv: support vector extension part 1 
Date:   Sat, 29 Feb 2020 23:04:09 +0800
Message-Id: <20200229150413.24950-1-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

This is the first part of v6 patchset. The changelog of v6 is only coverd
the part1.

Features:
  * support specification riscv-v-spec-0.7.1.
  * support basic vector extension.
  * support Zvlsseg.
  * support Zvamo.
  * not support Zvediv as it is changing.
  * SLEN always equals VLEN.
  * element width support 8bit, 16bit, 32bit, 64bit.

Changelog:
v6
  * keep vector CSR in read/write order
  * define fields name of VTYPE just like specification.
v5
  * vector registers as direct fields in RISCVCPUState.
  * mov the properties to last patch.
  * check RVV in vs().
  * check if rs1 is x0 in vsetvl/vsetvli.
  * check VILL, EDIV, RESERVED fileds in vsetvl.
v4
  * adjust max vlen to 512 bits.
  * check maximum on elen(64bits).
  * check minimum on vlen(128bits).
  * check if rs1 is x0 in vsetvl/vsetvli.
  * use gen_goto_tb in vsetvli instead of exit_tb.
  * fixup fetch vlmax from rs2, not env->vext.type.
v3
  * support VLEN configure from qemu command line.
  * support ELEN configure from qemu command line.
  * support vector specification version configure from qemu command line.
  * only default on for "any" cpu, others turn on from command line.
  * use a continous memory block for vector register description.
V2
  * use float16_compare{_quiet}
  * only use GETPC() in outer most helper
  * add ctx.ext_v Property

LIU Zhiwei (4):
  target/riscv: add vector extension field in CPURISCVState
  target/riscv: implementation-defined constant parameters
  target/riscv: support vector extension csr
  target/riscv: add vector configure instruction

 target/riscv/Makefile.objs              |  2 +-
 target/riscv/cpu.c                      |  7 +++
 target/riscv/cpu.h                      | 78 ++++++++++++++++++++++---
 target/riscv/cpu_bits.h                 | 15 +++++
 target/riscv/csr.c                      | 75 +++++++++++++++++++++++-
 target/riscv/helper.h                   |  2 +
 target/riscv/insn32.decode              |  5 ++
 target/riscv/insn_trans/trans_rvv.inc.c | 69 ++++++++++++++++++++++
 target/riscv/translate.c                | 17 +++++-
 target/riscv/vector_helper.c            | 53 +++++++++++++++++
 10 files changed, 311 insertions(+), 12 deletions(-)
 create mode 100644 target/riscv/insn_trans/trans_rvv.inc.c
 create mode 100644 target/riscv/vector_helper.c

-- 
2.23.0

