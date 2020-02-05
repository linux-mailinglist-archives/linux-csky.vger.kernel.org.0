Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA7B152924
	for <lists+linux-csky@lfdr.de>; Wed,  5 Feb 2020 11:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgBEKa6 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 5 Feb 2020 05:30:58 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:39927 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727771AbgBEKa6 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 5 Feb 2020 05:30:58 -0500
Received: by mail-io1-f66.google.com with SMTP id c16so1538828ioh.6
        for <linux-csky@vger.kernel.org>; Wed, 05 Feb 2020 02:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=TQUghOM4m25dYryTofJJfNk7kM5890C24NzW602QU0c=;
        b=YGDSWs8YuODA/23TjngpMtA6zb3m4m/mNxRhTbWruE3KGdA+lpzqxs93fYp9m99OCu
         l6riSvvk+jkssP+gS7oTNZSqwJ3D806+lQPol8z/TPm26pN4TpuTH1BPHD5FdLt/DTVi
         yTWEM/A5C/ghlIjHIZgMl8wKDb86IL9XY0ceE6U1HRuGhwuXmM+T7WECGsfctLRo/stM
         ZKNjRjm7ibP8WmFNomia0dF9NWpt4YWxYYbcJ9acXlvXTwimkdZFaTjWu8yM3i1KCsRf
         KDDuRlK58ehZ7gB9HfX51CVNVlUCzS4aTxDmTQh7X6bqr9Ji4GCL1y6QrTWQ6yBtIAaL
         j5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=TQUghOM4m25dYryTofJJfNk7kM5890C24NzW602QU0c=;
        b=ANLVG0BMOurkHBsqDMnu1bXBVakPbpnEyvP+zBQWXLEhvrMA+T0hlvS8k2kwmh5ElI
         0Zo2R1hqlMYrBWpyLsWOgc4+939aNDP1B8ZwwoIcV7JUX3nmQbIZs/0LpNv/sdsC/URR
         D7lj/SkrfhL4tQahYZ5XlR3/Zhi7Fqh16R4hvs4BFcqJQoli2geD7IRHDyEJTG/ah1Yq
         pFZrIltKdfddJgh4Gt4mzDZhL0lt0tqnpd+e9iXu9+DPwAIzsAvf8P6+IC63K37OUgyo
         iQ8LoGFmwWOx+7WvzcI0U3PWDRHe7ZI4SNfkrSQhMEozcU8Pubzx8+Jc+uRa3oWzzsVS
         DkeA==
X-Gm-Message-State: APjAAAUeMHswQO7i5fli5Nr51Y1zDSwnbk26vQ5/xXetTVKCyjhq4IAb
        d1FZSJAegwTlTnDFPE78/+Wp+B/aXhnFe2+YMno=
X-Google-Smtp-Source: APXvYqx6dhs3HFdJS0oA03uCUpD59KNUGzLSPteSnBvjEOWDl+Lfgk8SS5/R6KO9xgHWXv3bKiwAsWeMk2g15c094wA=
X-Received: by 2002:a6b:3742:: with SMTP id e63mr27250953ioa.303.1580898657460;
 Wed, 05 Feb 2020 02:30:57 -0800 (PST)
MIME-Version: 1.0
References: <1577937441-18703-1-git-send-email-han_mao@c-sky.com> <1577937441-18703-2-git-send-email-han_mao@c-sky.com>
In-Reply-To: <1577937441-18703-2-git-send-email-han_mao@c-sky.com>
From:   Thomas De Schampheleire <patrickdepinguin@gmail.com>
Date:   Wed, 5 Feb 2020 11:30:59 +0100
Message-ID: <CAAXf6LUV+WOJc+x_yZtDQbEXq6yH4uD67mvMHZoRQGnj4nrsjg@mail.gmail.com>
Subject: Re: [Buildroot] [PATCH 2/2] toolchain: Get ld.so name if available
To:     Mao Han <han_mao@c-sky.com>
Cc:     buildroot <buildroot@buildroot.org>,
        Qu Xianmiao <xianmiao_qu@c-sky.com>,
        Guo Ren <ren_guo@c-sky.com>,
        Mark Corbin <mark.corbin@embecosm.com>,
        linux-csky@vger.kernel.org,
        Chen Hongdeng <hongdeng_chen@c-sky.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Hi Mao Han,

El jue., 2 ene. 2020 a las 5:15, Mao Han (<han_mao@c-sky.com>) escribi=C3=
=B3:
>
> RISC-V multilib toolchain(github.com/riscv/riscv-gnu-toolchain.git) put
> multi ld.so with different ABI under sysroot/lib:
> sysroot/lib/ld-linux-riscv32-ilp32d.so.1
> sysroot/lib/ld-linux-riscv32-ilp32.so.1
> sysroot/lib/ld-linux-riscv64-lp64d.so.1
> sysroot/lib/ld-linux-riscv64-lp64.so.1
> Current buildroot script can't handle multi ld.so and report:
> >>> toolchain-external-custom  Copying external toolchain sysroot to stag=
ing...
> /bin/bash: line 0: [: too many arguments
> This patch try to get the exact name for ld.so and avoid multi ld.so chec=
k in
> the script.
>
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
> @@ -104,6 +104,7 @@ copy_toolchain_sysroot =3D \
>         ARCH_SUBDIR=3D"$(strip $3)"; \
>         ARCH_LIB_DIR=3D"$(strip $4)" ; \
>         SUPPORT_LIB_DIR=3D"$(strip $5)" ; \
> +       SPECIFIC_LD_NAME=3D"$(strip $6)" ; \
>         for i in etc $${ARCH_LIB_DIR} sbin usr usr/$${ARCH_LIB_DIR}; do \
>                 if [ ! -d $${ARCH_SYSROOT_DIR}/$$i ] ; then \
>                         continue ; \
> @@ -136,8 +137,13 @@ copy_toolchain_sysroot =3D \
>                 done ; \
>         fi ; \
>         if [ ! -e $(STAGING_DIR)/lib/ld*.so.* ]; then \
> -               if [ -e $${ARCH_SYSROOT_DIR}/lib/ld*.so.* ]; then \
> -                       cp -a $${ARCH_SYSROOT_DIR}/lib/ld*.so.* $(STAGING=
_DIR)/lib/ ; \
> +               if [ "$${SPECIFIC_LD_NAME}" !=3D "" ]; then \
> +                       LD_NAME=3D$${SPECIFIC_LD_NAME}; \
> +               else \
> +                       LD_NAME=3D"ld*.so.*"; \
> +               fi; \

In addition to the comments posted previously by Yann E. Morin, I
wonder if there can actually be a case where SPECIFIC_LD_NAME is
empty. What I mean is: do we still need the wildcard-based approach if
we are using a more correct approach of actually checking the
interpreter via readelf?
Removing the wildcards would make the code a bit more clear. In this
case, the name 'SPECIFIC_LD_NAME' could perhaps be renamed to just
'LD_SO_FILENAME' or something.

Best regards,
Thomas
