Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C9867F22E
	for <lists+linux-csky@lfdr.de>; Sat, 28 Jan 2023 00:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjA0XTk (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 27 Jan 2023 18:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbjA0XTj (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 27 Jan 2023 18:19:39 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7AECC2F
        for <linux-csky@vger.kernel.org>; Fri, 27 Jan 2023 15:19:38 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id m2so1473044plg.4
        for <linux-csky@vger.kernel.org>; Fri, 27 Jan 2023 15:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8CUiuR0W5E+PBhliE9B5Xpc1hgvQcn7IvZXYHXz1Ztk=;
        b=paJf4L9cWbEi06hvXF3W+dvDzKcJfx5lCtIJZryT2W6x9jn8QFdqdeSxBXueWWBz4l
         rmERWAhF8Jm6eVjAbcEKqXWk92TaZ81krplTYlrMd/cx7BLYELfqbb5CODOLpDvn3Wml
         kRDg2FG0oQukaBrpadAmUfS7JdX6dtNX5Yhxfrmh9fF25lANpaUbh+OUe4mJnDmapjXX
         gkAdUczu4u3q5myPePEFbhYsOrjzSYhCHKeHI7PmJlrIZYidHb64mfDumPwdlk9pOjoP
         gInzuu73k1EMmj9geC+hKbAVQjTYtmE/jHVcj9mm7ngPUJ7ymq4p0azycwmTjONcP99X
         kwzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8CUiuR0W5E+PBhliE9B5Xpc1hgvQcn7IvZXYHXz1Ztk=;
        b=CsAd8taJvjgRMh62rmZ0GI3IwFutqOp8fvuERrDjAxj9zHfCB1G7hw0MVJD5dIH08W
         brUqQ2lS3CdizT35d+8xdmEuncjossRe9djD5XZQOtG6NF0f3f7CWIMwnl3674DHHnl3
         dlCdAubE7J8w6AoawuKkIKAlDAfStAhb5qhq6Iuox+XtimX2TMr6xJBmlH1DLTOfq8/a
         ZHL9XCtoLeHyR3IeIrdZ9D/T4JFEJb31BH/5k99Q73enBtf1u38E7l5Xnmy9HjunKluD
         JoeGXEpC//Sj3XZaKIaBdtNV/Rk1A3w4M2lPhR0mi9NYNLgPNP3KtUKCEMlJ2ruQtpFy
         kz2g==
X-Gm-Message-State: AO0yUKVFOC1OVZn33vcXnrTn2TbtYfh9sFOsiB6KPtJiflQWRpSe31B7
        79+sGzKtyCOpntEux0zZIPDKkHSknp3kQdEc27okSA==
X-Google-Smtp-Source: AK7set86nD7AHLHjFHADNw68YHO3+pTEXmPYEX73qRUo91NxvyvumPLImtBCeS4GMfu57Ja5MOsxUjtYU3znLSUgghw=
X-Received: by 2002:a17:90a:2ec7:b0:22c:419a:f4cd with SMTP id
 h7-20020a17090a2ec700b0022c419af4cdmr750919pjs.74.1674861577303; Fri, 27 Jan
 2023 15:19:37 -0800 (PST)
MIME-Version: 1.0
References: <20221221235147.45lkqmosndritfpe@google.com> <mhng-17d41c33-7f33-4a1c-8af2-ae7d07134e8c@palmer-ri-x1c9>
In-Reply-To: <mhng-17d41c33-7f33-4a1c-8af2-ae7d07134e8c@palmer-ri-x1c9>
From:   Fangrui Song <maskray@google.com>
Date:   Fri, 27 Jan 2023 18:19:25 -0500
Message-ID: <CAFP8O3J1Pn+_BMKXtxB+avtYyZ+bBKffHfNOXoJPMD5QHv5obQ@mail.gmail.com>
Subject: Re: [PATCH v2] vdso: Improve cmd_vdso_check to check all dynamic relocations
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     christophe.leroy@csgroup.eu, Palmer Dabbelt <palmer@dabbelt.com>,
        luto@kernel.org, tglx@linutronix.de, vincenzo.frascino@arm.com,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Thu, Dec 29, 2022 at 11:22 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 21 Dec 2022 15:51:47 PST (-0800), maskray@google.com wrote:
> > The actual intention is that no dynamic relocation exists. However, some
> > GNU ld ports produce unneeded R_*_NONE. (If a port fails to determine
> > the exact .rel[a].dyn size, the trailing zeros become R_*_NONE
> > relocations. E.g. ld's powerpc port recently fixed
> > https://sourceware.org/bugzilla/show_bug.cgi?id=29540) R_*_NONE are
> > generally no-op in the dynamic loaders. So just ignore them.
> >
> > With the change, we can remove ARCH_REL_TYPE_ABS. ARCH_REL_TYPE_ABS is a
> > bit misnomer as ports may check RELAVETIVE/GLOB_DAT/JUMP_SLOT which are
> > not called "absolute relocations". (The patch is motivated by the arm64
> > port missing R_AARCH64_RELATIVE.)
> >
> > Signed-off-by: Fangrui Song <maskray@google.com>
> > Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> > ---
> > Change from v1:
> > * rebase after 8ac3b5cd3e0521d92f9755e90d140382fc292510 (lib/vdso: use "grep -E" instead of "egrep")
> > * change the commit message to mention an example GNU ld bug; no longer say the patch fixes a deprecated egrep use
> > ---
> >   arch/arm/vdso/Makefile            |  3 ---
> >   arch/arm64/kernel/vdso/Makefile   |  3 ---
> >   arch/arm64/kernel/vdso32/Makefile |  3 ---
> >   arch/csky/kernel/vdso/Makefile    |  3 ---
> >   arch/loongarch/vdso/Makefile      |  3 ---
> >   arch/mips/vdso/Makefile           |  3 ---
> >   arch/powerpc/kernel/vdso/Makefile |  1 -
> >   arch/riscv/kernel/vdso/Makefile   |  3 ---
> >   arch/s390/kernel/vdso32/Makefile  |  2 --
> >   arch/s390/kernel/vdso64/Makefile  |  2 --
> >   arch/x86/entry/vdso/Makefile      |  4 ----
> >   lib/vdso/Makefile                 | 13 ++++---------
> >   12 files changed, 4 insertions(+), 39 deletions(-)
>
> [snip]
>
> > diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> > index 06e6b27f3bcc..d85c37e11b21 100644
> > --- a/arch/riscv/kernel/vdso/Makefile
> > +++ b/arch/riscv/kernel/vdso/Makefile
> > @@ -1,9 +1,6 @@
> >   # SPDX-License-Identifier: GPL-2.0-only
> >   # Copied from arch/tile/kernel/vdso/Makefile
> >
> > -# Absolute relocation type $(ARCH_REL_TYPE_ABS) needs to be defined before
> > -# the inclusion of generic Makefile.
> > -ARCH_REL_TYPE_ABS := R_RISCV_32|R_RISCV_64|R_RISCV_JUMP_SLOT
> >   include $(srctree)/lib/vdso/Makefile
> >   # Symbols present in the vdso
> >   vdso-syms  = rt_sigreturn
>
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V
>
> Thanks!

Looks like this patch hasn't been picked yet...
