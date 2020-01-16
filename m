Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2457013D6D0
	for <lists+linux-csky@lfdr.de>; Thu, 16 Jan 2020 10:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730700AbgAPJ0K (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 16 Jan 2020 04:26:10 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:44534 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730599AbgAPJ0K (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 16 Jan 2020 04:26:10 -0500
Received: by mail-il1-f194.google.com with SMTP id z12so17515802iln.11
        for <linux-csky@vger.kernel.org>; Thu, 16 Jan 2020 01:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+T2+f3YUqy/mz/g0zqdHuyixNv3uIRSRLqHpYCvIA8=;
        b=YNsZvqMC3qBwhA390kR+0O1+Z775NXpgorZ1Uj0LTNfhunlCVnboeL+hdbdTD7zPyj
         cO4YdefQbXLyr/t0viYTQNIs2/R9znJRs+JPdwF+zlywPmjg5MJOT97iGih9buKS3tvr
         detFCcSpM8To0oU1Jp0ON3jtZma7mcyCUwQck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+T2+f3YUqy/mz/g0zqdHuyixNv3uIRSRLqHpYCvIA8=;
        b=EN210UzYxUD/rac+HJa1uPrGgX88XfntJv31s0hlf2CXoC/w4jM6yF+pnQCrgRAAdm
         yhMLegPV6Q9lp6ggAsx8jTmsQ8u6oQcuHZk0jyFdU8O9dIv/xULD1QwDw6IyAsZ2CLcR
         e4QdF+7DHdlx0Ce+hBFqwIGCDPwLHZBS3Axd68nfRj6zcT8iKlQ2rpYlHNbbOxeqZOHk
         ygthcF2l7UU+t23Th18H+Teda+4SpF3Le6rx0d3j+AXxkmkz5YvFE+Q82h9Cgm6ImdFt
         fzVso9L9raL7EoL020+u7eFoGFboJkAtCCUPAGdjHKsnDVELCl0G+PCXEIW++2nttlJA
         Ih/Q==
X-Gm-Message-State: APjAAAWbD8kW9XVu7mrWzxyRYVQ/Wmlv+m79uRqTH2l8uG6faqfQ28tZ
        eIsamxlOiSG3J4rZC8HFH1Y9xkE5R0KlS7aeUai9Mw==
X-Google-Smtp-Source: APXvYqzcJuvwLp0x5+fMsP13ADUUEVQCs/aLETOB1GPnAQGr8kZxelM+YUGAkJZnZhbBbnQ8HdB5j4UwUbclM7dRrHw=
X-Received: by 2002:a92:8851:: with SMTP id h78mr2599028ild.308.1579166769584;
 Thu, 16 Jan 2020 01:26:09 -0800 (PST)
MIME-Version: 1.0
References: <20200115063410.131692-1-hsinyi@chromium.org> <20200115114112.GA3663@bogus>
In-Reply-To: <20200115114112.GA3663@bogus>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 16 Jan 2020 17:25:43 +0800
Message-ID: <CAJMQK-ip7C71=K+CViEKcc3ed4GPY_Uknm5uNgLJTzZb2aQOcA@mail.gmail.com>
Subject: Re: [PATCH v5] reboot: support offline CPUs before reboot
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Pavankumar Kondeti <pkondeti@codeaurora.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Wed, Jan 15, 2020 at 7:41 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Jan 15, 2020 at 02:34:10PM +0800, Hsin-Yi Wang wrote:
> > Currently system reboots uses architecture specific codes (smp_send_stop)
> > to offline non reboot CPUs. Most architecture's implementation is looping
> > through all non reboot online CPUs and call ipi function to each of them. Some
> > architecture like arm64, arm, and x86... would set offline masks to cpu without
> > really offline them. This causes some race condition and kernel warning comes
> > out sometimes when system reboots.
> >
> > This patch adds a config ARCH_OFFLINE_CPUS_ON_REBOOT, which would offline cpus in
> > migrate_to_reboot_cpu(). If non reboot cpus are all offlined here, the loop for
> > checking online cpus would be an empty loop. If architecture don't enable this
> > config, or some cpus somehow fails to offline, it would fallback to ipi
> > function.
> >
>
> What's the timing impact on systems with large number of CPUs(say 256 or
> more) ? I remember we added some change to reduce the wait times for
> offlining CPUs in system suspend path on arm64, still not negligible.
>

This is not the final solution, but I would still provided some data
points here:

Tested on my arm64 with 4 cpu: 2 a53 and 2 a72.
Offlining 3 cpu takes about 60~65 ms
Offlining 2 cpu(a53+a72 or a72+a72) takes about 42~47 ms
Offlining 1 cpu(a53 or a72) takes about 23~25 ms.

It would take longer time for systems with large number of CPUs.
