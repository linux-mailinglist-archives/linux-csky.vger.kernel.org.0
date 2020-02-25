Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3418616BEDB
	for <lists+linux-csky@lfdr.de>; Tue, 25 Feb 2020 11:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730242AbgBYKfP (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 25 Feb 2020 05:35:15 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:51792 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729417AbgBYKfP (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Tue, 25 Feb 2020 05:35:15 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09531976|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.170054-0.0243383-0.805608;DS=CONTINUE|ham_regular_dialog|0.0116271-0.000104934-0.988268;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03267;MF=zhiwei_liu@c-sky.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.GsFPuQz_1582626910;
Received: from L-PF1D6DP4-1208.hz.ali.com(mailfrom:zhiwei_liu@c-sky.com fp:SMTPD_---.GsFPuQz_1582626910)
          by smtp.aliyun-inc.com(10.147.40.44);
          Tue, 25 Feb 2020 18:35:11 +0800
From:   LIU Zhiwei <zhiwei_liu@c-sky.com>
To:     richard.henderson@linaro.org, alistair23@gmail.com,
        chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org, LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: [PATCH v4 0/5] target/riscv: support vector extension part 2
Date:   Tue, 25 Feb 2020 18:35:03 +0800
Message-Id: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Features:
  * support specification riscv-v-spec-0.7.1.
  * support basic vector extension.
  * support Zvlsseg.
  * support Zvamo.
  * not support Zvediv as it is changing.
  * fixed SLEN 128bit.
  * element width support 8bit, 16bit, 32bit, 64bit.

Changelog:
v4
  * remove check structure, use check function directly
  * use (s->vlen / 8) as maxsz in simd_maxsz
  * remove helper structure vext_ctx, pass args directly.
v3
  * move check code from execution time to translation time.
  * probe pages before real load or store access.
  * use probe_page_check for no-fault operations in linux user mode.
  * add atomic and noatomic operation for vector amo instructions.
V2
  * use float16_compare{_quiet}
  * only use GETPC() in outer most helper
  * add ctx.ext_v Property

LIU Zhiwei (5):
  target/riscv: add vector unit stride load and store instructions
  target/riscv: add vector stride load and store instructions
  target/riscv: add vector index load and store instructions
  target/riscv: add fault-only-first unit stride load
  target/riscv: add vector amo operations

 target/riscv/helper.h                   |  218 ++++
 target/riscv/insn32-64.decode           |   11 +
 target/riscv/insn32.decode              |   67 ++
 target/riscv/insn_trans/trans_rvv.inc.c |  663 +++++++++++++
 target/riscv/translate.c                |    2 +
 target/riscv/vector_helper.c            | 1203 +++++++++++++++++++++++
 6 files changed, 2164 insertions(+)

-- 
2.23.0

