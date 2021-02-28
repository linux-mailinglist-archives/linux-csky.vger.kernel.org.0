Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401C832746E
	for <lists+linux-csky@lfdr.de>; Sun, 28 Feb 2021 21:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbhB1Uh3 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sun, 28 Feb 2021 15:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbhB1Uh2 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sun, 28 Feb 2021 15:37:28 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746D4C061786
        for <linux-csky@vger.kernel.org>; Sun, 28 Feb 2021 12:36:48 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id e7so22167078lft.2
        for <linux-csky@vger.kernel.org>; Sun, 28 Feb 2021 12:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0I080SabAeL7RXDtwNRlIP4qQeXFJN4hk5j5dJcEAcc=;
        b=Eju6M1mE051upv5FFkpJodVO2LnTADaVzIS/WPcsP6Q/vN68qSqmc5o4cdlp7oy52S
         smCIOyibPmZnW/KGCpTe4Ks2xVsfvsVUTuzwANPq+rfPleaZSi8dvAsHnAqSDTCapqC6
         SpO7UTNJOp6Tp1xC3zBzd7/ZM8YiQKMiI7LsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0I080SabAeL7RXDtwNRlIP4qQeXFJN4hk5j5dJcEAcc=;
        b=bvfXqzMgnyGqtPsquDlXbMCtuj7yG7QlqCbfRyOiehqKMB9iiK8D7UD4cGMpvRmRT1
         xUVwB8nZfWSaPwdgFENYXvo4ENYkjnraSZNLjDB5gdaYeZaE/M6P9jknz99nqwetxROG
         1TPlYjwN3TIoKvA/Y9TOm16jV7w/VyztwkhRJ4CySxAA6Nb3nWs1bYeZOWCREXZ39Yxg
         cDmmWxyxb5R1Oe6NbOa775Y+aXipoBBL0UWIglx/+gaOf062CsT5ysc+Ut7jBIA9H3XT
         IcYleLl+etc/EdJpoltuDWEq22TMZKHh0gZbj9JF2rp37B6EWEPQB2Qx893ZHnyeOdEZ
         XkVQ==
X-Gm-Message-State: AOAM531LJet8gPeGTqbDH2XxxULy3mgyk655Wnb3murTN4Cs73TvwFkj
        0NZ5WszaNDU5xcSofLu/QTAtiynbSzdC3A==
X-Google-Smtp-Source: ABdhPJx6cdCtsXDtevo8cCAT1YX3yg1xnjndLnDe29TLowK8nGcEsrltlPNl7TdCfj3M4q+86f27dQ==
X-Received: by 2002:a05:6512:94b:: with SMTP id u11mr7667885lft.15.1614544606589;
        Sun, 28 Feb 2021 12:36:46 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id q6sm2069153lfb.288.2021.02.28.12.36.45
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 12:36:45 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id b1so11359751lfb.7
        for <linux-csky@vger.kernel.org>; Sun, 28 Feb 2021 12:36:45 -0800 (PST)
X-Received: by 2002:a05:6512:398d:: with SMTP id j13mr7283600lfu.41.1614544605255;
 Sun, 28 Feb 2021 12:36:45 -0800 (PST)
MIME-Version: 1.0
References: <20210228034300.1090149-1-guoren@kernel.org>
In-Reply-To: <20210228034300.1090149-1-guoren@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 28 Feb 2021 12:36:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjM+kCsKqNdb=c0hKsv=J7-3Q1zmM15vp6_=8S5XfGMtA@mail.gmail.com>
Message-ID: <CAHk-=wjM+kCsKqNdb=c0hKsv=J7-3Q1zmM15vp6_=8S5XfGMtA@mail.gmail.com>
Subject: Re: [GIT PULL] csky changes for v5.12-rc1
To:     Guo Ren <guoren@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

So this is entirely unrelated to the csky pull request, and is more of
a generic "the perf CPU hotplug thing seems a complete mess".

The csky thing is just the latest - of many - that have been bitten by
the mess, and the one that added yet another hotplug state, and
finally made me go "Let's at least talk about this"

For csky, the problem is this:

On Sat, Feb 27, 2021 at 7:43 PM <guoren@kernel.org> wrote:
>
> arch/csky patches for 5.12-rc1
>
>  - Fixup perf probe failed

and in this case it is 398cb92495cc ("csky: Fixup perf probe failed")
in my current -git tree.

But it's also

    cf6acb8bdb1d ("s390/cpumf: Add support for complete counter set extraction")
    dcb5cdf60a1f ("powerpc/perf/hv-gpci: Add cpu hotplug support")
    1a8f0886a600 ("powerpc/perf/hv-24x7: Add cpu hotplug support")
    6b7ce8927b5a ("irqchip: RISC-V per-HART local interrupt controller driver")
    e9b880581d55 ("coresight: cti: Add CPU Hotplug handling to CTI driver")
    e0685fa228fd ("arm64: Retrieve stolen time as paravirtualized guest")
    6282edb72bed ("clocksource/drivers/exynos_mct: Increase priority
over ARM arch timer")
    78f4e932f776 ("x86/microcode, cpuhotplug: Add a microcode loader
CPU hotplug callback")
    72c69dcddce1 ("powerpc/perf: Trace imc events detection and cpuhotplug")
    5861381d4866 ("PM / arch: x86: Rework the
MSR_IA32_ENERGY_PERF_BIAS handling")
    69c32972d593 ("drivers/perf: Add Cavium ThunderX2 SoC UNCORE PMU driver")
    ...

and that's not even the complete list.

Does it really make sense to have this kind of silly enumeration of
many (MANY!) different arch CPU hotplug state indexes, where most of
them are relevant only to that particular architecture..

No, I don't think this is a _problem_, but it's kind of ugly, wouldn't
you agree?

Wouldn't it be better to just reserve N different states for the
architecture hotplug state, and then let each architecture decide how
they want to order them?

Or better yet, make at least some of them architecture-neutral.
Because now there are drivers that clearly are very tied to one
architecture - or SoCs (look at various timer things) - do they really
want or need their own architecture- or SoC-specific hotplug state?
IOW, do we really need all of these:

        CPUHP_AP_ARM_ARCH_TIMER_STARTING,
        CPUHP_AP_ARM_GLOBAL_TIMER_STARTING,
        CPUHP_AP_JCORE_TIMER_STARTING,
        CPUHP_AP_QCOM_TIMER_STARTING,
        CPUHP_AP_TEGRA_TIMER_STARTING,
        CPUHP_AP_ARMADA_TIMER_STARTING,
        CPUHP_AP_MARCO_TIMER_STARTING,
        CPUHP_AP_MIPS_GIC_TIMER_STARTING,
        CPUHP_AP_ARC_TIMER_STARTING,
        CPUHP_AP_RISCV_TIMER_STARTING,
        CPUHP_AP_CLINT_TIMER_STARTING,
        CPUHP_AP_CSKY_TIMER_STARTING,
        CPUHP_AP_HYPERV_TIMER_STARTING,
        CPUHP_AP_KVM_ARM_TIMER_STARTING,
        CPUHP_AP_DUMMY_TIMER_STARTING,

as separate hotplug events?

Whatever. I don't really care deeply, but this just smells a bit to me.

Comments?

                   Linus
