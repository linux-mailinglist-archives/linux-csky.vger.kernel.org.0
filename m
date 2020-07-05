Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D719214F70
	for <lists+linux-csky@lfdr.de>; Sun,  5 Jul 2020 22:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgGEUke (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sun, 5 Jul 2020 16:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728133AbgGEUkc (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sun, 5 Jul 2020 16:40:32 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CA1C061794
        for <linux-csky@vger.kernel.org>; Sun,  5 Jul 2020 13:40:32 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q17so96692pls.9
        for <linux-csky@vger.kernel.org>; Sun, 05 Jul 2020 13:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=q9lFBU3d76A+AvC7/qqAJBRlf6HVmM0fTZD+IkpZgqM=;
        b=j53MF7EfkDpIVkrbnWBG49SQ/STTBmGcVbJNSxRrB8lv1l4ZMnKBmTWKjH2PjiJ93e
         1cEu/vd01vMJETyxI5n7qLiYFu7EX5pX9NMr/gQCHhrCAca7AapP7jP4N1BBW1gOAwBr
         mtb8MIB0lDM1JT80lAEQaJ4xb+tgJR5vQIDqg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=q9lFBU3d76A+AvC7/qqAJBRlf6HVmM0fTZD+IkpZgqM=;
        b=hBb5r1THV7cQo34a4s1F5KJDnO7+1M3TwTuZsh7hdnUD7j60DOfDfptwffei51qimn
         PWBMY6E84/tMFmbNdRZ1LXmtjeDphjWIopSPCVzO37xHuFjay+Bl0s59kp4pPkjmncx3
         piuccrWyBQfx1jklYmvJuk3xYjUaodGXfkt+rvDvFtPGqzt/2KvwH7bgUP5HrB81VRP2
         qKjjFqlRkPwfB+GnujbWF5k82I/M27YX4rfyuDySkh31aeSBRhxbm/xRdHtB+Q6R+OoU
         xOU3IxEMXJ3YWTG2wf4RRuBVKq9upXXHbBYGmKgZYux2AJKMyAHxSqEGsxXBWc61+sPR
         B9dQ==
X-Gm-Message-State: AOAM531+drOjiNJmXRYcbzY2rUauqULAZMtLS9FehwbF3YLDdw2I8Z/1
        8mtQYZdfWh4hZW1/CJGjvUF2Zw==
X-Google-Smtp-Source: ABdhPJyrWXBh3rxmwtUH1i70uMO24g4DdmDaRzUAGEXGlglnhpp2zI7U2R18YXFmrFfNNa3qnyReBg==
X-Received: by 2002:a17:90b:358e:: with SMTP id mm14mr51022580pjb.54.1593981631976;
        Sun, 05 Jul 2020 13:40:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z5sm16925366pfn.117.2020.07.05.13.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 13:40:31 -0700 (PDT)
Date:   Sun, 5 Jul 2020 13:40:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>
Subject: Re: [RFC PATCH] riscv: enable per-task stack canaries
Message-ID: <202007051336.C9EA0ECF65@keescook>
References: <1593958397-62466-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1593958397-62466-1-git-send-email-guoren@kernel.org>
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sun, Jul 05, 2020 at 02:13:17PM +0000, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> After compare arm64 and x86 implementations, seems arm64's is more
> flexible and readable. The key point is how gcc get the offset of
> stack_canary from gs/el0_sp.
> 
> x86: Use a fix offset from gs, not flexible.
> 
> struct fixed_percpu_data {
>         /*
>          * GCC hardcodes the stack canary as %gs:40.  Since the
>          * irq_stack is the object at %gs:0, we reserve the bottom
>          * 48 bytes of the irq stack for the canary.
>          */
>         char            gs_base[40]; // :(
>         unsigned long   stack_canary;
> };

Yes, x86's compiler's implementation of "thread local" stack canary
isn't great for the kernel.

> arm64: Use -mstack-protector-guard-offset & guard-reg
> 
> ifeq ($(CONFIG_STACKPROTECTOR_PER_TASK),y)
> prepare: stack_protector_prepare
> stack_protector_prepare: prepare0
>        $(eval KBUILD_CFLAGS += -mstack-protector-guard=sysreg            \
>                                -mstack-protector-guard-reg=sp_el0        \
>                                -mstack-protector-guard-offset=$(shell    \
>                        awk '{if ($$2 == "TSK_STACK_CANARY") print $$3;}' \
>                                        include/generated/asm-offsets.h))
> endif
> 
> I prefer arm64, but x86 percpu_data design needs to be considered ?

I don't know riscv internals, so I leave that to y'all! :)

> After the discussion, let's continue the work for riscv gcc
> stack-protector.

I think you'll need some buy-in from GCC before this kernel patch can
land.

> Here is arm64 gcc's work [1].
> 
> [1] https://github.com/gcc-mirror/gcc/commit/cd0b2d361df82c848dc7e1c3078651bb0624c3c6

Can this kind of thing be made general-purposes, instead of having to
reimplement it each time there's a new arch wanting to do it?

> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Kees Cook <keescook@chromium.org>
> ---
>  arch/riscv/Kconfig                      |  7 +++++++
>  arch/riscv/Makefile                     | 10 ++++++++++
>  arch/riscv/include/asm/stackprotector.h |  3 ++-
>  arch/riscv/kernel/asm-offsets.c         |  3 +++
>  arch/riscv/kernel/process.c             |  2 +-
>  5 files changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4b0e308..4b4e833 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -394,6 +394,13 @@ config CMDLINE_FORCE
>  
>  endchoice
>  
> +config CC_HAVE_STACKPROTECTOR_SYSREG
> +	def_bool $(cc-option,-mstack-protector-guard=gpr -mstack-protector-guard-reg=tp -mstack-protector-guard-offset=0)

And, as I'm sure you realize, it's not supported by the riscv backend
yet:

riscv64-unknown-linux-gnu-gcc: error: unrecognized command line option '-mstack-protector-guard=gpr'; did you mean '-fstack-protector-strong'?
riscv64-unknown-linux-gnu-gcc: error: unrecognized command line option '-mstack-protector-guard-reg=tp'; did you mean '-fstack-protector-strong'?
riscv64-unknown-linux-gnu-gcc: error: unrecognized command line option '-mstack-protector-guard-offset=0'; did you mean '-fstack-protector-strong'?

-- 
Kees Cook
