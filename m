Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0968D283F65
	for <lists+linux-csky@lfdr.de>; Mon,  5 Oct 2020 21:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgJETOP (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Mon, 5 Oct 2020 15:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgJETOP (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Mon, 5 Oct 2020 15:14:15 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B36BC0613CE
        for <linux-csky@vger.kernel.org>; Mon,  5 Oct 2020 12:14:13 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id n6so3922545ioc.12
        for <linux-csky@vger.kernel.org>; Mon, 05 Oct 2020 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xwAxPetPQqjNloRqroHgPvWNU+a4/LgMNfeziHOHJfY=;
        b=F2TRLVcMaGt3VPEEmegwbHPJ4ou8ND6anmLed18QlQIrqj8v2nxubg6lM79u1s4oi9
         pUIrVv2FRRGNSC8ASvas42okTQ3qCh7q3fWtd6bfHviFqAceEtSblKsomzFqK+lMqnir
         MxxNaca8KW2t8a/hAAHLN2eXGppKSuGDWm1aA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xwAxPetPQqjNloRqroHgPvWNU+a4/LgMNfeziHOHJfY=;
        b=Ayfor5Hlfe1CjuKyP4e1u0MR26TGmFd+QDeOXXqlUvS9ckHu+F/qos+/DohEfw1Ljf
         ThUgEO49AGSz+kaM5q5ziRefi/pdk+tbbh5mhFV0Hks1zsRxFGIhstaYRf5me8pDBCwF
         ZgzSKkpT1VMsJyEQSn5CRxW7M2IdzfsHULoDFEHYXG/aIAW5gsGmkLOaWj/ee6Q7Vgbl
         Wa+x1wRi09tkweXBiHddN4pYxL6Z4KcqRC4z22lfEmYlK9YxXmRsGOa7yS8Sq58Hubki
         WL1hxCiF+wRsdBDWl8+wn3DQuuiekz1NIYqYzEAxeenb48il2//Nn+xI25X1xvNo5jNF
         btDw==
X-Gm-Message-State: AOAM533NuWkqj3HyKVvFbcI4O7T7G2NsQvtkHsX5bkMiUFysJayv9oFh
        wpw8YxHQLn3TsFzwu25kr8H0p9dz7sehWY8Q2Uq1
X-Google-Smtp-Source: ABdhPJzZTWc5aDIps9qCUH4gIcx01yrGYSRg4jL6Z7cAHeANHCNGR8ghILZwdUivcGDVDXopZEUHL3dxxcJiPt4KNJA=
X-Received: by 2002:a05:6638:dd3:: with SMTP id m19mr1345504jaj.115.1601925252825;
 Mon, 05 Oct 2020 12:14:12 -0700 (PDT)
MIME-Version: 1.0
References: <1593266228-61125-1-git-send-email-guoren@kernel.org>
 <1593266228-61125-2-git-send-email-guoren@kernel.org> <20200911204512.GA2705@aurel32.net>
 <CAJF2gTQiLV8sDE5cnvP=aBog4zaiMvMeieg_JtXwRODky1u3Hg@mail.gmail.com>
 <20200914103836.GB2705@aurel32.net> <87lfgzeidk.fsf@igel.home> <CAJF2gTQ8ONde3GRhQgx2Nqvb5X20nTmW8jZEemZKhezRDzP3aQ@mail.gmail.com>
In-Reply-To: <CAJF2gTQ8ONde3GRhQgx2Nqvb5X20nTmW8jZEemZKhezRDzP3aQ@mail.gmail.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 5 Oct 2020 12:14:01 -0700
Message-ID: <CAOnJCUJhb2K89pRETbfTJ=5jHQhWfyfrOUu8zOE77j+id6OpSA@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
To:     Guo Ren <guoren@kernel.org>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Tycho Andersen <tycho@tycho.ws>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nick Hu <nickhu@andestech.com>,
        Anup Patel <anup@brainfault.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Thu, Sep 24, 2020 at 9:19 AM Guo Ren <guoren@kernel.org> wrote:
>
> How about this, revert the commit and don't free INIT_DATA_SECTION. I
> think the solution is safe enough, but wast a little memory.
>
> diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
> index f3586e3..34d00d9 100644
> --- a/arch/riscv/kernel/vmlinux.lds.S
> +++ b/arch/riscv/kernel/vmlinux.lds.S
> @@ -22,13 +22,11 @@ SECTIONS
>         /* Beginning of code and text segment */
>         . = LOAD_OFFSET;
>         _start = .;
> -       _stext = .;
>         HEAD_TEXT_SECTION
>         . = ALIGN(PAGE_SIZE);
>
>         __init_begin = .;
>         INIT_TEXT_SECTION(PAGE_SIZE)
> -       INIT_DATA_SECTION(16)
>         . = ALIGN(8);
>         __soc_early_init_table : {
>                 __soc_early_init_table_start = .;
> @@ -55,6 +53,7 @@ SECTIONS
>         . = ALIGN(SECTION_ALIGN);
>         .text : {
>                 _text = .;
> +               _stext = .;
>                 TEXT_TEXT
>                 SCHED_TEXT
>                 CPUIDLE_TEXT
> @@ -67,6 +66,8 @@ SECTIONS
>                 _etext = .;
>         }
>
> +       INIT_DATA_SECTION(16)
> +

I think you need to move EXIT_DATA as well. Currently, we have init
data & text in one section.
In general it is better idea to separate those similar to ARM64.
Additionally, ARM64 applies different mapping for init data & text
as the init data section is marked as non-executable[1]

However, we don't modify any permission for any init sections. Should
we do that as well ?

[1] https://patchwork.kernel.org/patch/9572869/

>         /* Start of data section */
>         _sdata = .;
>         RO_DATA(SECTION_ALIGN)
>
> On Thu, Sep 24, 2020 at 3:36 PM Andreas Schwab <schwab@linux-m68k.org> wrote:
> >
> > On Sep 14 2020, Aurelien Jarno wrote:
> >
> > > How should we proceed to get that fixed in time for 5.9? For the older
> > > branches where it has been backported (so far 5.7 and 5.8), should we
> > > just get that commit reverted instead?
> >
> > Can this please be resolved ASAP?
> >
> > Andreas.
> >
> > --
> > Andreas Schwab, schwab@linux-m68k.org
> > GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> > "And now for something completely different."
>
>
>
> --
> Best Regards
>  Guo Ren
>
> ML: https://lore.kernel.org/linux-csky/
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Regards,
Atish
