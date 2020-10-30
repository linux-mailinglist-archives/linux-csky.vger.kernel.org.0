Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07AB2A0F89
	for <lists+linux-csky@lfdr.de>; Fri, 30 Oct 2020 21:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgJ3Ued (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 30 Oct 2020 16:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbgJ3UeH (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 30 Oct 2020 16:34:07 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EACC0613CF
        for <linux-csky@vger.kernel.org>; Fri, 30 Oct 2020 13:34:05 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id bn26so10333871ejb.6
        for <linux-csky@vger.kernel.org>; Fri, 30 Oct 2020 13:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kjos0+S2Gon+fH3b26doFlCP2cxrfT62BjLoezK4rG4=;
        b=J8d/YD59wQ/au5l1BQ7ue2vwfU1yPmEzaWIbs72/a3aDX73KGLSsh/e6e4T2ilr+m6
         v7YctKloyJWKSYk1q7y81pi983c4f8E7/f/kLdP0CFwMkO7uyjtkdfJgwTbIAUd3yTgV
         b5YrSxtLonkg9fnewHN7YslOk1fl6e5oIhge0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kjos0+S2Gon+fH3b26doFlCP2cxrfT62BjLoezK4rG4=;
        b=HCDEk1aDWOT18XvhNv8MUvkKONyn9Cm2pPmZ/4d0v6Ia4mxQbm8vmAuvyoX7vccMWD
         Jv3zGZTvf+DN9/fGT9OVgbeVVa60jX7GHSOTe+aoo9+1ctBu8TsQHqb2YVvd8GilmdpA
         G0WPgmZv5QPa0MA3qVIyzVBPLN0/bLbb6Gw+ozf+Nrn1AaJlEuiRz1RUNYxbQHqui+lV
         8j5BXBFkI37086SZoxeMKi+3Cd9V+hBKptDk/ctw/9u7D/GivG/5OysMRHEaMT0TLend
         oR3qwp7i+9nCnozJym4AMdf+XUNZMuwkFUGEs7WHcrdLaO9DGyq9vL8IVo70dByKHZVL
         Z1zA==
X-Gm-Message-State: AOAM530rlfc5G8lfOSrjXwMyoA1H1SEQ4VvAFyXX8J28Sk21ZcEWNS41
        ehWDH29Aj9Btua7IO5yKLkc+QwjnzARH+w==
X-Google-Smtp-Source: ABdhPJw8psO/3elCgseQgQsRa508dBTwNg7iXgCt8j892Fqab/H75maRWFErA1btbMGX365fY/bkNw==
X-Received: by 2002:a17:906:4d59:: with SMTP id b25mr4460040ejv.404.1604090044203;
        Fri, 30 Oct 2020 13:34:04 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id x2sm1357813ejb.86.2020.10.30.13.34.03
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2020 13:34:03 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id s15so10305051ejf.8
        for <linux-csky@vger.kernel.org>; Fri, 30 Oct 2020 13:34:03 -0700 (PDT)
X-Received: by 2002:a2e:760a:: with SMTP id r10mr1661953ljc.421.1604089720167;
 Fri, 30 Oct 2020 13:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20201029221806.189523375@linutronix.de> <CAHk-=wiFxxGapdOyZHE-7LbFPk+jdfoqdeeJg0zWNQ86WvJGXg@mail.gmail.com>
 <87pn50ob0s.fsf@nanos.tec.linutronix.de> <87blgknjcw.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87blgknjcw.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Oct 2020 13:28:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=whsJv0bwWRVZHsLoSe48ykAea6T7Oi=G+r8ckLrZ0YUpg@mail.gmail.com>
Message-ID: <CAHk-=whsJv0bwWRVZHsLoSe48ykAea6T7Oi=G+r8ckLrZ0YUpg@mail.gmail.com>
Subject: Re: [patch V2 00/18] mm/highmem: Preemptible variant of kmap_atomic & friends
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Christoph Hellwig <hch@lst.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Fri, Oct 30, 2020 at 2:39 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> But then we really should not name it kmap_local. 'local' suggests
> locality, think local_irq*, local_bh* ... kmap_task would be more
> accurate then.

So the main reason I'd like to see it is because I think on a
non-highmem machine, the new kmap should be a complete no-op. IOW,
we'd make sure that there are no costs, no need to increment any
"restrict migration" counts etc.

It's been a bit of a pain to have kmap_atomic() have magical side
semantics that people might then depend on.

I think "local" could still work as a name, because it would have to
be thread-local (and maybe we'd want a debug mode where that gets
verified, as actual HIGHMEM machines are getting rare).

I'd avoid "task", because that implies (to me, at least) that it
wouldn't be good for interrupts etc that don't have a task context.

I think the main issue is that it has to be released in the same
context as it was created (ie no passing those things around to other
contexts). I think "local" is fine for that, but I could imagine other
names. The ones that come to mind are somewhat cumbersome, though
("shortterm" or "local_ctx" or something along those lines).

I dunno.

              Linus
