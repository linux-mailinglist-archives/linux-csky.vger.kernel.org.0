Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B976412E22D
	for <lists+linux-csky@lfdr.de>; Thu,  2 Jan 2020 05:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgABEKY (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 1 Jan 2020 23:10:24 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44972 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbgABEKY (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 1 Jan 2020 23:10:24 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07627742|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.679564-0.0209353-0.2995;DS=||;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03305;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.GUW-h81_1577938218;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.GUW-h81_1577938218)
          by smtp.aliyun-inc.com(10.147.42.16);
          Thu, 02 Jan 2020 12:10:18 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     buildroot@buildroot.org
Cc:     linux-csky@vger.kernel.org, Mao Han <han_mao@c-sky.com>,
        Qu Xianmiao <xianmiao_qu@c-sky.com>,
        Chen Hongdeng <hongdeng_chen@c-sky.com>,
        Guo Ren <ren_guo@c-sky.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Corbin <mark.corbin@embecosm.com>
Subject: [PATCH 1/2] package/toolchain-external: ensure ARCH_LIB_DIR exist
Date:   Thu,  2 Jan 2020 11:57:20 +0800
Message-Id: <1577937441-18703-1-git-send-email-han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Different architecture may have different arch library folder structure
for their multilib toolchain. RISC-V toolchain has folder structure
like:
/sysroot/lib64/
/sysroot/lib64/lp64
/sysroot/lib64/lp64d
The first level is for ISA and the second level is for ABI.
Current buildroot only creat lib and lib64, some error is reported
while installing the external toolchain:
>>> toolchain-external-custom  Installing to staging directory
/usr/bin/install -D -m 0755 /.../build/toolchain-external-custom/toolchain-wrapper /.../host/bin/toolchain-wrapper
ln: failed to create symbolic link '/.../host/riscv64-buildroot-linux-gnu/sysroot/lib64/lp64': No such file or directory
ln: failed to create symbolic link '/.../host/riscv64-buildroot-linux-gnu/sysroot/usr/lib64/lp64': No such file or directory

Signed-off-by: Qu Xianmiao <xianmiao_qu@c-sky.com>
Signed-off-by: Chen Hongdeng <hongdeng_chen@c-sky.com>
Signed-off-by: Guo Ren<ren_guo@c-sky.com>
Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Mark Corbin <mark.corbin@embecosm.com>
---
 toolchain/toolchain-external/pkg-toolchain-external.mk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/toolchain/toolchain-external/pkg-toolchain-external.mk b/toolchain/toolchain-external/pkg-toolchain-external.mk
index baf719a..13b2468 100644
--- a/toolchain/toolchain-external/pkg-toolchain-external.mk
+++ b/toolchain/toolchain-external/pkg-toolchain-external.mk
@@ -454,6 +454,8 @@ create_lib_symlinks = \
 	ARCH_LIB_DIR="$(call toolchain_find_libdir,$(TOOLCHAIN_EXTERNAL_CC) $(TOOLCHAIN_EXTERNAL_CFLAGS))" ; \
 	if [ ! -e "$${DESTDIR}/$${ARCH_LIB_DIR}" -a ! -e "$${DESTDIR}/usr/$${ARCH_LIB_DIR}" ]; then \
 		relpath="$(call relpath_prefix,$${ARCH_LIB_DIR})" ; \
+		mkdir -p "$${DESTDIR}/$${ARCH_LIB_DIR}" ; \
+		mkdir -p "$${DESTDIR}/usr/$${ARCH_LIB_DIR}" ; \
 		ln -snf $${relpath}lib "$${DESTDIR}/$${ARCH_LIB_DIR}" ; \
 		ln -snf $${relpath}lib "$${DESTDIR}/usr/$${ARCH_LIB_DIR}" ; \
 	fi
-- 
2.7.4

