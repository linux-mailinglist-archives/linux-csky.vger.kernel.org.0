Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4874712E22E
	for <lists+linux-csky@lfdr.de>; Thu,  2 Jan 2020 05:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbgABEKb (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 1 Jan 2020 23:10:31 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:39412 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbgABEKa (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 1 Jan 2020 23:10:30 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07638919|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.734873-0.0107833-0.254344;DS=||;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03303;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.GUW09RE_1577938226;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.GUW09RE_1577938226)
          by smtp.aliyun-inc.com(10.147.42.22);
          Thu, 02 Jan 2020 12:10:26 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     buildroot@buildroot.org
Cc:     linux-csky@vger.kernel.org, Mao Han <han_mao@c-sky.com>,
        Qu Xianmiao <xianmiao_qu@c-sky.com>,
        Chen Hongdeng <hongdeng_chen@c-sky.com>,
        Guo Ren <ren_guo@c-sky.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Mark Corbin <mark.corbin@embecosm.com>
Subject: [PATCH 2/2] toolchain: Get ld.so name if available
Date:   Thu,  2 Jan 2020 11:57:21 +0800
Message-Id: <1577937441-18703-2-git-send-email-han_mao@c-sky.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577937441-18703-1-git-send-email-han_mao@c-sky.com>
References: <1577937441-18703-1-git-send-email-han_mao@c-sky.com>
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

RISC-V multilib toolchain(github.com/riscv/riscv-gnu-toolchain.git) put
multi ld.so with different ABI under sysroot/lib:
sysroot/lib/ld-linux-riscv32-ilp32d.so.1
sysroot/lib/ld-linux-riscv32-ilp32.so.1
sysroot/lib/ld-linux-riscv64-lp64d.so.1
sysroot/lib/ld-linux-riscv64-lp64.so.1
Current buildroot script can't handle multi ld.so and report:
>>> toolchain-external-custom  Copying external toolchain sysroot to staging...
/bin/bash: line 0: [: too many arguments
This patch try to get the exact name for ld.so and avoid multi ld.so check in
the script.

Signed-off-by: Qu Xianmiao <xianmiao_qu@c-sky.com>
Signed-off-by: Chen Hongdeng <hongdeng_chen@c-sky.com>
Signed-off-by: Guo Ren<ren_guo@c-sky.com>
Signed-off-by: Mao Han <han_mao@c-sky.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Mark Corbin <mark.corbin@embecosm.com>
---
 toolchain/helpers.mk                                   | 10 ++++++++--
 toolchain/toolchain-external/pkg-toolchain-external.mk |  3 ++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/toolchain/helpers.mk b/toolchain/helpers.mk
index 03355f5..cc581fc 100644
--- a/toolchain/helpers.mk
+++ b/toolchain/helpers.mk
@@ -104,6 +104,7 @@ copy_toolchain_sysroot = \
 	ARCH_SUBDIR="$(strip $3)"; \
 	ARCH_LIB_DIR="$(strip $4)" ; \
 	SUPPORT_LIB_DIR="$(strip $5)" ; \
+	SPECIFIC_LD_NAME="$(strip $6)" ; \
 	for i in etc $${ARCH_LIB_DIR} sbin usr usr/$${ARCH_LIB_DIR}; do \
 		if [ ! -d $${ARCH_SYSROOT_DIR}/$$i ] ; then \
 			continue ; \
@@ -136,8 +137,13 @@ copy_toolchain_sysroot = \
 		done ; \
 	fi ; \
 	if [ ! -e $(STAGING_DIR)/lib/ld*.so.* ]; then \
-		if [ -e $${ARCH_SYSROOT_DIR}/lib/ld*.so.* ]; then \
-			cp -a $${ARCH_SYSROOT_DIR}/lib/ld*.so.* $(STAGING_DIR)/lib/ ; \
+		if [ "$${SPECIFIC_LD_NAME}" != "" ]; then \
+			LD_NAME=$${SPECIFIC_LD_NAME}; \
+		else \
+			LD_NAME="ld*.so.*"; \
+		fi; \
+		if [ -e $${ARCH_SYSROOT_DIR}/lib/$${LD_NAME} ]; then \
+			cp -a $${ARCH_SYSROOT_DIR}/lib/$${LD_NAME} $(STAGING_DIR)/lib/ ; \
 		fi ; \
 	fi ; \
 	if [ `readlink -f $${SYSROOT_DIR}` != `readlink -f $${ARCH_SYSROOT_DIR}` ] ; then \
diff --git a/toolchain/toolchain-external/pkg-toolchain-external.mk b/toolchain/toolchain-external/pkg-toolchain-external.mk
index 13b2468..19cf7d6 100644
--- a/toolchain/toolchain-external/pkg-toolchain-external.mk
+++ b/toolchain/toolchain-external/pkg-toolchain-external.mk
@@ -425,6 +425,7 @@ define TOOLCHAIN_EXTERNAL_INSTALL_SYSROOT_LIBS
 	$(Q)SYSROOT_DIR="$(call toolchain_find_sysroot,$(TOOLCHAIN_EXTERNAL_CC))" ; \
 	ARCH_SYSROOT_DIR="$(call toolchain_find_sysroot,$(TOOLCHAIN_EXTERNAL_CC) $(TOOLCHAIN_EXTERNAL_CFLAGS))" ; \
 	ARCH_LIB_DIR="$(call toolchain_find_libdir,$(TOOLCHAIN_EXTERNAL_CC) $(TOOLCHAIN_EXTERNAL_CFLAGS))" ; \
+	SPECIFIC_LD_NAME=`$(TOOLCHAIN_EXTERNAL_READELF) -d $${ARCH_SYSROOT_DIR}$${ARCH_LIB_DIR}/libc*.so|grep ld|grep so|awk '{print $$NF}'|sed "s/\[//g"|sed "s/\]//g"`;\
 	SUPPORT_LIB_DIR="" ; \
 	if test `find $${ARCH_SYSROOT_DIR} -name 'libstdc++.a' | wc -l` -eq 0 ; then \
 		LIBSTDCPP_A_LOCATION=$$(LANG=C $(TOOLCHAIN_EXTERNAL_CC) $(TOOLCHAIN_EXTERNAL_CFLAGS) -print-file-name=libstdc++.a) ; \
@@ -441,7 +442,7 @@ define TOOLCHAIN_EXTERNAL_INSTALL_SYSROOT_LIBS
 		ARCH_SUBDIR=`echo $${ARCH_SYSROOT_DIR} | sed -r -e "s:^$${SYSROOT_DIR}(.*)/$$:\1:"` ; \
 	fi ; \
 	$(call MESSAGE,"Copying external toolchain sysroot to staging...") ; \
-	$(call copy_toolchain_sysroot,$${SYSROOT_DIR},$${ARCH_SYSROOT_DIR},$${ARCH_SUBDIR},$${ARCH_LIB_DIR},$${SUPPORT_LIB_DIR})
+	$(call copy_toolchain_sysroot,$${SYSROOT_DIR},$${ARCH_SYSROOT_DIR},$${ARCH_SUBDIR},$${ARCH_LIB_DIR},$${SUPPORT_LIB_DIR},$${SPECIFIC_LD_NAME})
 endef
 
 # Create a symlink from (usr/)$(ARCH_LIB_DIR) to lib.
-- 
2.7.4

