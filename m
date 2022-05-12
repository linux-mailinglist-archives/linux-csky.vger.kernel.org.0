Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F7F5243E2
	for <lists+linux-csky@lfdr.de>; Thu, 12 May 2022 06:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiELEJI (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 12 May 2022 00:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbiELEJH (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 12 May 2022 00:09:07 -0400
Received: from condef-09.nifty.com (condef-09.nifty.com [202.248.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3EF71D0432
        for <linux-csky@vger.kernel.org>; Wed, 11 May 2022 21:09:05 -0700 (PDT)
Received: from conuserg-07.nifty.com ([10.126.8.70])by condef-09.nifty.com with ESMTP id 24C41hqV029858
        for <linux-csky@vger.kernel.org>; Thu, 12 May 2022 13:01:43 +0900
Received: from grover.jp (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 24C41CNP015198;
        Thu, 12 May 2022 13:01:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 24C41CNP015198
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652328073;
        bh=onFv+YAOxIPYNs8nK9urU409UP2PBRJMAjENXFOL5Vk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eg03YOigSKL+FkCX7H+IUzTgy39mWtqGcAJHY9n411eCCEDc4gA7Sy0edNb2f/zt8
         Pp/I7NVhbKw1fBUw8m6FK1j1z9Lja7xHfMfXnS88e1vRmAAcm94Xbh4TbfD688aUWH
         ad6SvDP9sMQgY9VDXFQzK8tBZuAARcUVsEn/FzbCZioIsE97iwOkWQZAAhzyGJ94tw
         UOE5p5uTx9bPcYhGG9BqUbzEkZ0JIER7SS4b/Fst11j2a5BkioQ2Q8qdvUaKA91PvN
         bxz2atiZ1r5LwreohfTE8mhwj+uOm8OB0iU0U3FXyTjo/Q841PecMkkS+YVm1+4KGl
         UDDA5c8/3RUFA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/4] csky: introduce CONFIG_CSKY_ABI_V1/2
Date:   Thu, 12 May 2022 12:59:02 +0900
Message-Id: <20220512035903.2779287-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220512035903.2779287-1-masahiroy@kernel.org>
References: <20220512035903.2779287-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

This is useful to clean up Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/csky/Kconfig  | 11 +++++++++++
 arch/csky/Makefile | 14 ++++++++------
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 75ef86605d69..da756ecf0f85 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -161,6 +161,12 @@ config ARCH_MMAP_RND_BITS_MIN
 config ARCH_MMAP_RND_BITS_MAX
 	default 17
 
+config CSKY_ABI_V1
+	bool
+
+config CSKY_ABI_V2
+	bool
+
 menu "Processor type and features"
 
 choice
@@ -172,15 +178,18 @@ config CPU_CK610
 	select CPU_NEED_TLBSYNC
 	select CPU_NEED_SOFTALIGN
 	select CPU_NO_USER_BKPT
+	select CSKY_ABI_V1
 
 config CPU_CK810
 	bool "CSKY CPU ck810"
 	select CPU_HAS_HILO
 	select CPU_NEED_TLBSYNC
+	select CSKY_ABI_V2
 
 config CPU_CK807
 	bool "CSKY CPU ck807"
 	select CPU_HAS_HILO
+	select CSKY_ABI_V2
 
 config CPU_CK860
 	bool "CSKY CPU ck860"
@@ -188,6 +197,8 @@ config CPU_CK860
 	select CPU_HAS_CACHEV2
 	select CPU_HAS_LDSTEX
 	select CPU_HAS_FPUV2
+	select CSKY_ABI_V2
+
 endchoice
 
 choice
diff --git a/arch/csky/Makefile b/arch/csky/Makefile
index 4d72aca4069b..2b30525f39e1 100644
--- a/arch/csky/Makefile
+++ b/arch/csky/Makefile
@@ -16,34 +16,36 @@ endif
 
 ifdef CONFIG_CPU_CK610
 CPUTYPE	= ck610
-CSKYABI	= abiv1
 endif
 
 ifdef CONFIG_CPU_CK810
 CPUTYPE = ck810
-CSKYABI	= abiv2
 endif
 
 ifdef CONFIG_CPU_CK807
 CPUTYPE = ck807
-CSKYABI	= abiv2
 endif
 
 ifdef CONFIG_CPU_CK860
 CPUTYPE = ck860
+endif
+
+ifdef CONFIG_CSKY_ABI_V1
+CSKYABI	= abiv1
+endif
+
+ifdef CONFIG_CSKY_ABI_V2
 CSKYABI	= abiv2
 endif
 
-ifneq ($(CSKYABI),)
 MCPU_STR = $(CPUTYPE)$(FPUEXT)$(VDSPEXT)$(TEEEXT)
 KBUILD_CFLAGS += -mcpu=$(CPUTYPE) -Wa,-mcpu=$(MCPU_STR)
 KBUILD_CFLAGS += -DCSKYCPU_DEF_NAME=\"$(MCPU_STR)\"
 KBUILD_CFLAGS += -msoft-float -mdiv
 KBUILD_CFLAGS += -fno-tree-vectorize
-endif
 
 KBUILD_CFLAGS += -pipe
-ifeq ($(CSKYABI),abiv2)
+ifdef CONFIG_CSKY_ABI_V2
 KBUILD_CFLAGS += -mno-stack-size
 endif
 
-- 
2.32.0

