Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66F79149B6C
	for <lists+linux-csky@lfdr.de>; Sun, 26 Jan 2020 16:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726080AbgAZPcG (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sun, 26 Jan 2020 10:32:06 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:8522 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgAZPcG (ORCPT <rfc822;linux-csky@vger.kernel.org>);
        Sun, 26 Jan 2020 10:32:06 -0500
Received: from ymorin.is-a-geek.org (unknown [IPv6:2a01:cb19:8b51:cb00:383c:9d3:6333:ab7c])
        (Authenticated sender: yann.morin.1998)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 98941200429;
        Sun, 26 Jan 2020 16:31:46 +0100 (CET)
Received: by ymorin.is-a-geek.org (sSMTP sendmail emulation); Sun, 26 Jan 2020 16:31:46 +0100
Date:   Sun, 26 Jan 2020 16:31:46 +0100
From:   "Yann E. MORIN" <yann.morin.1998@free.fr>
To:     Mao Han <han_mao@c-sky.com>
Cc:     buildroot@buildroot.org, Qu Xianmiao <xianmiao_qu@c-sky.com>,
        Guo Ren <ren_guo@c-sky.com>,
        Mark Corbin <mark.corbin@embecosm.com>,
        linux-csky@vger.kernel.org,
        Chen Hongdeng <hongdeng_chen@c-sky.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [Buildroot] [PATCH 2/2] toolchain: Get ld.so name if available
Message-ID: <20200126153146.GO32369@scaer>
References: <1577937441-18703-1-git-send-email-han_mao@c-sky.com>
 <1577937441-18703-2-git-send-email-han_mao@c-sky.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1577937441-18703-2-git-send-email-han_mao@c-sky.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 2020-01-02 11:57 +0800, Mao Han spake thusly:
> RISC-V multilib toolchain(github.com/riscv/riscv-gnu-toolchain.git) put
> multi ld.so with different ABI under sysroot/lib:
> sysroot/lib/ld-linux-riscv32-ilp32d.so.1
> sysroot/lib/ld-linux-riscv32-ilp32.so.1
> sysroot/lib/ld-linux-riscv64-lp64d.so.1
> sysroot/lib/ld-linux-riscv64-lp64.so.1
> Current buildroot script can't handle multi ld.so and report:
> >>> toolchain-external-custom  Copying external toolchain sysroot to staging...
> /bin/bash: line 0: [: too many arguments
> This patch try to get the exact name for ld.so and avoid multi ld.so check in
> the script.

I only had a cursory look at the rest of the thread, but if the last
comment from Thomas DS. is valid, then only this patch is required.

However, I have some feedback on it.

You need to provide a bit more explanations in the commit log. You
started by providing the problem you are facing, which is great, and you
explained why it happens, which is again very nice.

However, the fix you provided should be explained a bit more, because
this is touching the core infrastructure of Buildroot, and the code
touching the toolchain is always a bit hairy and fragile to manage...

> Signed-off-by: Qu Xianmiao <xianmiao_qu@c-sky.com>
> Signed-off-by: Chen Hongdeng <hongdeng_chen@c-sky.com>
> Signed-off-by: Guo Ren<ren_guo@c-sky.com>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Mark Corbin <mark.corbin@embecosm.com>
> ---
>  toolchain/helpers.mk                                   | 10 ++++++++--
>  toolchain/toolchain-external/pkg-toolchain-external.mk |  3 ++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/toolchain/helpers.mk b/toolchain/helpers.mk
> index 03355f5..cc581fc 100644
> --- a/toolchain/helpers.mk
> +++ b/toolchain/helpers.mk
> @@ -104,6 +104,7 @@ copy_toolchain_sysroot = \
>  	ARCH_SUBDIR="$(strip $3)"; \
>  	ARCH_LIB_DIR="$(strip $4)" ; \
>  	SUPPORT_LIB_DIR="$(strip $5)" ; \
> +	SPECIFIC_LD_NAME="$(strip $6)" ; \
>  	for i in etc $${ARCH_LIB_DIR} sbin usr usr/$${ARCH_LIB_DIR}; do \
>  		if [ ! -d $${ARCH_SYSROOT_DIR}/$$i ] ; then \
>  			continue ; \
> @@ -136,8 +137,13 @@ copy_toolchain_sysroot = \
>  		done ; \
>  	fi ; \
>  	if [ ! -e $(STAGING_DIR)/lib/ld*.so.* ]; then \
> -		if [ -e $${ARCH_SYSROOT_DIR}/lib/ld*.so.* ]; then \
> -			cp -a $${ARCH_SYSROOT_DIR}/lib/ld*.so.* $(STAGING_DIR)/lib/ ; \
> +		if [ "$${SPECIFIC_LD_NAME}" != "" ]; then \
> +			LD_NAME=$${SPECIFIC_LD_NAME}; \
> +		else \
> +			LD_NAME="ld*.so.*"; \
> +		fi; \
> +		if [ -e $${ARCH_SYSROOT_DIR}/lib/$${LD_NAME} ]; then \
> +			cp -a $${ARCH_SYSROOT_DIR}/lib/$${LD_NAME} $(STAGING_DIR)/lib/ ; \

Since we now have the actual interpreter name, as extracted by the
caller, we should be able to greatly simplify this conditional block,
no?

But see below...

>  		fi ; \
>  	fi ; \
>  	if [ `readlink -f $${SYSROOT_DIR}` != `readlink -f $${ARCH_SYSROOT_DIR}` ] ; then \
> diff --git a/toolchain/toolchain-external/pkg-toolchain-external.mk b/toolchain/toolchain-external/pkg-toolchain-external.mk
> index 13b2468..19cf7d6 100644
> --- a/toolchain/toolchain-external/pkg-toolchain-external.mk
> +++ b/toolchain/toolchain-external/pkg-toolchain-external.mk
> @@ -425,6 +425,7 @@ define TOOLCHAIN_EXTERNAL_INSTALL_SYSROOT_LIBS
>  	$(Q)SYSROOT_DIR="$(call toolchain_find_sysroot,$(TOOLCHAIN_EXTERNAL_CC))" ; \
>  	ARCH_SYSROOT_DIR="$(call toolchain_find_sysroot,$(TOOLCHAIN_EXTERNAL_CC) $(TOOLCHAIN_EXTERNAL_CFLAGS))" ; \
>  	ARCH_LIB_DIR="$(call toolchain_find_libdir,$(TOOLCHAIN_EXTERNAL_CC) $(TOOLCHAIN_EXTERNAL_CFLAGS))" ; \
> +	SPECIFIC_LD_NAME=`$(TOOLCHAIN_EXTERNAL_READELF) -d $${ARCH_SYSROOT_DIR}$${ARCH_LIB_DIR}/libc*.so|grep ld|grep so|awk '{print $$NF}'|sed "s/\[//g"|sed "s/\]//g"`;\

As far as I understand this, you are trying to extract the interpreter.
This is overly complex, and can be done with a single sed invocation:

    $(TOOLCHAIN_EXTERNAL_READELF) -l $${ARCH_SYSROOT_DIR}$${ARCH_LIB_DIR}/libc*.so \
    |sed -r -e '/Requesting program interpreter/!d; s:^.*/([^[:space:]]+)\]$$:\1:'

But then, we should probably do that for the internal toolchain, too?
This way we can actually cimplify the conditional block, above.

Regards,
Yann E. MORIN.

>  	SUPPORT_LIB_DIR="" ; \
>  	if test `find $${ARCH_SYSROOT_DIR} -name 'libstdc++.a' | wc -l` -eq 0 ; then \
>  		LIBSTDCPP_A_LOCATION=$$(LANG=C $(TOOLCHAIN_EXTERNAL_CC) $(TOOLCHAIN_EXTERNAL_CFLAGS) -print-file-name=libstdc++.a) ; \
> @@ -441,7 +442,7 @@ define TOOLCHAIN_EXTERNAL_INSTALL_SYSROOT_LIBS
>  		ARCH_SUBDIR=`echo $${ARCH_SYSROOT_DIR} | sed -r -e "s:^$${SYSROOT_DIR}(.*)/$$:\1:"` ; \
>  	fi ; \
>  	$(call MESSAGE,"Copying external toolchain sysroot to staging...") ; \
> -	$(call copy_toolchain_sysroot,$${SYSROOT_DIR},$${ARCH_SYSROOT_DIR},$${ARCH_SUBDIR},$${ARCH_LIB_DIR},$${SUPPORT_LIB_DIR})
> +	$(call copy_toolchain_sysroot,$${SYSROOT_DIR},$${ARCH_SYSROOT_DIR},$${ARCH_SUBDIR},$${ARCH_LIB_DIR},$${SUPPORT_LIB_DIR},$${SPECIFIC_LD_NAME})
>  endef
>  
>  # Create a symlink from (usr/)$(ARCH_LIB_DIR) to lib.
> -- 
> 2.7.4
> 
> _______________________________________________
> buildroot mailing list
> buildroot@busybox.net
> http://lists.busybox.net/mailman/listinfo/buildroot

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +33 662 376 056 | Software  Designer | \ / CAMPAIGN     |  ___               |
| +33 561 099 427 `------------.-------:  X  AGAINST      |  \e/  There is no  |
| http://ymorin.is-a-geek.org/ | _/*\_ | / \ HTML MAIL    |   v   conspiracy.  |
'------------------------------^-------^------------------^--------------------'
