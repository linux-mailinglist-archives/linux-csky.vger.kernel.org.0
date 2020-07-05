Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56AC214F50
	for <lists+linux-csky@lfdr.de>; Sun,  5 Jul 2020 22:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgGEUby (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sun, 5 Jul 2020 16:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgGEUby (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sun, 5 Jul 2020 16:31:54 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619C9C061794
        for <linux-csky@vger.kernel.org>; Sun,  5 Jul 2020 13:31:54 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m22so7061462pgv.9
        for <linux-csky@vger.kernel.org>; Sun, 05 Jul 2020 13:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ur7mB1HQd3aacYwlGEFeNIXsEbUuMF415cElS3tVlkQ=;
        b=JDpzbBFHelJ+U3gs0XnqMdc/wE1/wEy2lbGSnkGrl84Cxopx0PV7YffkPDncy+PyuR
         XCG9Sqzhws6JDKzAfs4dnTSCmZ4jbLklFaKH1xvR6cHeQb7xmHJSxB1QSff5g07yw91J
         GmVq69VJBztKqy+z680mZmPxPEkKYR2EhdVyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ur7mB1HQd3aacYwlGEFeNIXsEbUuMF415cElS3tVlkQ=;
        b=Zfnszk/eU+rqxX59G3U+VdgpZ6kSYUH9NxgvvDA6GCf/8iYYWi1gC/7Lnyu9bs/Isq
         GJrk92TtPir074inxx0CTSxjWKyg/95CQYaLzjLlnAe1tMbW6xO9W26mSaqTJSJ2l+6h
         uSmFEEHRygDhhPYUF5B8V64Ni8bxuq8Gy4yE3o3UBTCi+hcvpDr06+RgvXQrP/hchLlU
         OLlC54gspiL0Iew1fVPnrFCz3fhluSo4FVzffKJ95RzdD+Bw3FLdZU0PffgFcphxpjJT
         Zmr9wVtTU9MYl44T088lh0cK01sxwXT3k4uf8+yBZZogDs4M5iuyVesKmNfQ1bHwT20z
         TcEg==
X-Gm-Message-State: AOAM531yMgjYSZo3tfSWEkMWHZizD+4PfFBl+0IkAvWBUyKU3TDmqabh
        MsN5yYp5LzaG9HuIcvB3/W9kmA==
X-Google-Smtp-Source: ABdhPJxGflcwOaYyfs2gLTjaHiikusvtN11502CcX43vmcvaWqy2v3cL096nKsEZPkw+SWGXAu7ksA==
X-Received: by 2002:a62:164a:: with SMTP id 71mr43090161pfw.266.1593981113896;
        Sun, 05 Jul 2020 13:31:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m9sm1342538pjs.18.2020.07.05.13.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 13:31:53 -0700 (PDT)
Date:   Sun, 5 Jul 2020 13:31:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>,
        Greentime Hu <green.hu@gmail.com>,
        Atish Patra <atish.patra@wdc.com>
Subject: Re: [PATCH] riscv: Add STACKPROTECTOR supported
Message-ID: <202007051328.FE9EF99@keescook>
References: <1593930255-12378-1-git-send-email-guoren@kernel.org>
 <202007042350.4C153C4F8@keescook>
 <CAJF2gTQFqH7GMvRgmtb=hBwvUy6NZyM8xLqOsUTvnYhO48tQbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQFqH7GMvRgmtb=hBwvUy6NZyM8xLqOsUTvnYhO48tQbg@mail.gmail.com>
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sun, Jul 05, 2020 at 10:16:14PM +0800, Guo Ren wrote:
> On Sun, Jul 5, 2020 at 2:53 PM Kees Cook <keescook@chromium.org> wrote:
> > On Sun, Jul 05, 2020 at 06:24:15AM +0000, guoren@kernel.org wrote:
> > > +static __always_inline void boot_init_stack_canary(void)
> > > +{
> > > +     unsigned long canary;
> > > +
> > > +     /* Try to get a semi random initial value. */
> > > +     get_random_bytes(&canary, sizeof(canary));
> > > +     canary ^= LINUX_VERSION_CODE;
> > > +     canary &= CANARY_MASK;
> >
> > Does riscv have any kind of instruction counters or other trivial timers
> > that could be mixed in here? (e.g. x86's TSC)
> Do you mean:
>   get_random_bytes(&canary, sizeof(canary));
> + canary += get_cycles64() + (get_cycles64() << 32UL);
>   canary ^= LINUX_VERSION_CODE;
>   canary &= CANARY_MASK;
> 
> Ok ?

Sure -- I assume get_cycles64() is architecturally "simple"? (i.e. it
doesn't require that the entire time-keeping subsystem has started?)

> >
> > > +
> > > +     current->stack_canary = canary;
> > > +     __stack_chk_guard = current->stack_canary;
> >
> > What's needed for riscv to support a per-task canary? (e.g. x86's TLS or
> > arm64's register-specific methods)
> Some archs change __stack_chk_guard in _switch_to of entry.S, but it
> depends on !CONFIG_SMP.

Oh, funny. I hadn't actually noticed that logic for the !CONFIG_SMP
cases. I see to problem with that, but the more important case, I think
is the per-task canaries.

> #if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
>         get  value  from next_task->stack_canary
>         store  value to __stack_chk_guard
> #endif
> 
> It's a so limitation solution for per-task canary, so I didn't copy it
> into riscv?

Right -- it's a limited solution. On the other had, is !CONFIG_SMP
expected to be a common config for riscv? If so, it's worth adding. If
not, I'd say skip it. (Though it looks very simple to do...)

-- 
Kees Cook
