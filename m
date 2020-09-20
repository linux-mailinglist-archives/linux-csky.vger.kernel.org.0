Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57206271615
	for <lists+linux-csky@lfdr.de>; Sun, 20 Sep 2020 18:58:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgITQ6D (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sun, 20 Sep 2020 12:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbgITQ6C (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sun, 20 Sep 2020 12:58:02 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B370C0613CE
        for <linux-csky@vger.kernel.org>; Sun, 20 Sep 2020 09:58:02 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r24so9140454ljm.3
        for <linux-csky@vger.kernel.org>; Sun, 20 Sep 2020 09:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Govkq2c7yVsAEyCudSuE8qhnS6+zy4O8TiKkmkv2nIk=;
        b=O7YDY5EZgHd0ux+0JI623n4+xCNSLKkbNn75HK0PfnOR4wlB9CfHJM9R8MpDNxC4Bt
         StinnqnJ77DBvptD2dta7OTELHl1G548xZdBUVNIayCFE6KgnVNuKWIqgtvMj+8UMN/e
         7pSxwfkCe8prPQ3KSbQLetFJedeblKFxQgFMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Govkq2c7yVsAEyCudSuE8qhnS6+zy4O8TiKkmkv2nIk=;
        b=I2n+SyQgppXOBaG9Oir866Jq+QHA9jA6fDUmeWUr1Im0IVarhLbZP2NTm6HPJWXQVv
         6PbXDodK/AF7/49CAYKZWVO76DnPYmdBybvA0VH23Avpru6F3S49IDPsfI5wy/fI3Ian
         YVT/tvSINafm7YeQD+kRqOzt4YHjEBlRVuNGsRfAcEsubpupEZWggfH4SAMUlomNYfO3
         rl/QRi1f8BCIwjUZhvEEz4IadEJwkiVHO8p/aryl1EL4pZdX2hyEYrhJJD/z9BpsR9an
         oxH0OYd8i9CDS2whrjXzpKiHhr1gSMbVuQb6Tx+umqMQLSQdHtSQJQaN8c5jVZNV4r39
         MfJQ==
X-Gm-Message-State: AOAM530Ry7C/CjzgBCuhvL5fhQTvSjxHfCOSavsnkZnD2hd2wDWYTX71
        wKTDxNuMyQVnRmuFTzyL1+1J+l7RjFF5/A==
X-Google-Smtp-Source: ABdhPJxXk4C4n74gDwMdvB1s1KShiN24Ks9XrczB3UEHB+1x60zBuMhzKgAJxgb5+8qgFMxNVpao4Q==
X-Received: by 2002:a2e:9cd7:: with SMTP id g23mr14002928ljj.183.1600621080370;
        Sun, 20 Sep 2020 09:58:00 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id s21sm1909080lfb.76.2020.09.20.09.57.59
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2020 09:57:59 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id y17so11448027lfa.8
        for <linux-csky@vger.kernel.org>; Sun, 20 Sep 2020 09:57:59 -0700 (PDT)
X-Received: by 2002:ac2:5594:: with SMTP id v20mr15170982lfg.344.1600621076988;
 Sun, 20 Sep 2020 09:57:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200919091751.011116649@linutronix.de> <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com>
 <87mu1lc5mp.fsf@nanos.tec.linutronix.de> <87k0wode9a.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87k0wode9a.fsf@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 20 Sep 2020 09:57:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com>
Message-ID: <CAHk-=wgbmwsTOKs23Z=71EBTrULoeaH2U3TNqT2atHEWvkBKdw@mail.gmail.com>
Subject: Re: [patch RFC 00/15] mm/highmem: Provide a preemptible variant of
 kmap_atomic & friends
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Paul McKenney <paulmck@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-xtensa@linux-xtensa.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vineet Gupta <vgupta@synopsys.com>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-sparc <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sun, Sep 20, 2020 at 1:49 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Actually most usage sites of kmap atomic do not need page faults to be
> disabled at all.

Right. I think the pagefault disabling has (almost) nothing at all to
do with the kmap() itself - it comes from the "atomic" part, not the
"kmap" part.

I say *almost*, because there is one issue that needs some thought:
the amount of kmap nesting.

The kmap_atomic() interface - and your local/temporary/whatever
versions of it - depends very much inherently on being strictly
nesting. In fact, it depends so much on it that maybe that should be
part of the new name?

It's very wrong to do

    addr1 = kmap_atomic();
    addr2 = kmap_atomic();
    ..do something with addr 1..
    kunmap_atomic(addr1);
    .. do something with addr 2..
    kunmap_atomic(addr2);

because the way we allocate the slots is by using a percpu-atomic
inc-return (and we deallocate using dec).

So it's fundamentally a stack.

And that's perfectly fine for page faults - if they do any kmaps,
those will obviously nest.

So the only issue with page faults might be that the stack grows
_larger_. And that might need some thought. We already make the kmap
stack bigger for CONFIG_DEBUG_HIGHMEM, and it's possibly that if we
allow page faults we need to make the kmap stack bigger still.

Btw, looking at the stack code, Ithink your new implementation of it
is a bit scary:

   static inline int kmap_atomic_idx_push(void)
   {
  -       int idx = __this_cpu_inc_return(__kmap_atomic_idx) - 1;
  +       int idx = current->kmap_ctrl.idx++;

and now that 'current->kmap_ctrl.idx' is not atomic wrt

 (a) NMI's (this may be ok, maybe we never do kmaps in NMIs, and with
nesting I think it's fine anyway - the NMI will undo whatever it did)

 (b) the prev/next switch

And that (b) part worries me. You do the kmap_switch_temporary() to
switch the entries, but you do that *separately* from actually
switching 'current' to the new value.

So kmap_switch_temporary() looks safe, but I don't think it actually
is. Because while it first unmaps the old entries and then remaps the
new ones, an interrupt can come in, and at that point it matters what
is *CURRENT*.

And regardless of whether 'current' is 'prev' or 'next', that
kmap_switch_temporary() loop may be doing the wrong thing, depending
on which one had the deeper stack. The interrupt will be using
whatever "current->kmap_ctrl.idx" is, but that might overwrite entries
that are in the process of being restored (if current is still 'prev',
but kmap_switch_temporary() is in the "restore @next's kmaps" pgase),
or it might stomp on entries that have been pte_clear()'ed by the
'prev' thing.

I dunno. The latter may be one of those "it works anyway, it
overwrites things we don't care about", but the former will most
definitely not work.

And it will be completely impossible to debug, because it will depend
on an interrupt that uses kmap_local/atomic/whatever() coming in
_just_ at the right point in the scheduler, and only when the
scheduler has been entered with the right number of kmap entries on
the prev/next stack.

And no developer will ever see this with any amount of debug code
enabled, because it will only hit on legacy platforms that do this
kmap anyway.

So honestly, that code scares me. I think it's buggy. And even if it
"happens to work", it does so for all the wrong reasons, and is very
fragile.

So I would suggest:

 - continue to use an actual per-cpu kmap_atomic_idx

 - make the switching code save the old idx, then unmap the old
entries one by one (while doing the proper "pop" action), and then map
the new entries one by one (while doing the proper "push" action).

which would mean that the only index that is actually ever *USED* is
the percpu one, and it's always up-to-date and pushed/popped for
individual entries, rather than this - imho completely bogus -
optimization where you use "p->kmap_ctrl.idx" directly and very very
unsafely.

Alternatively, that process counter would need about a hundred lines
of commentary about exactly why it's safe. Because I don't think it
is.

                   Linus
