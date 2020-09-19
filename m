Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14772270FBD
	for <lists+linux-csky@lfdr.de>; Sat, 19 Sep 2020 19:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgISRYt (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 19 Sep 2020 13:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgISRYt (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sat, 19 Sep 2020 13:24:49 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D89C0613CE
        for <linux-csky@vger.kernel.org>; Sat, 19 Sep 2020 10:24:48 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lo4so12221852ejb.8
        for <linux-csky@vger.kernel.org>; Sat, 19 Sep 2020 10:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=waM6UyKAxKjxaPuk1aOj7tJ5Pe/ksOuiXEzSSo1PI/U=;
        b=PDwKTi4lX9j7zg3G7WzPyBOHBiLdhmAgWRxWPWvYR/nEys9FVfUL6zNUVgG09pDixg
         o+e2DCxbAvOZN3jBhyrOMZPfygh9RU8mogp2HXrCoLkUWHRL8e1VK4NRvgzXaMsluBfo
         GR1BPuNqLZOfJqo2g/IqA9gl4eqzfpV+zOYak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=waM6UyKAxKjxaPuk1aOj7tJ5Pe/ksOuiXEzSSo1PI/U=;
        b=A2q+Csx5W2NocT8hFrCMopgJfn6HKMYhoym/BYFhiHYV9z1U27Yn+YmmBYpCZdnNSp
         eX9Iu7QrzuL3xKD8qFQD1agiBpJVvNb3Mp3VGF27LmfemdVas6KOJ9dzzDOsXSZgSNeX
         T44FyZXDlIG+PTjk/oqBJR3ILz3xyhoSIbSZbYxQ9iKB33vhwN6nDOn7EGS2SSTW3drE
         i9JTInptoKgvBClMGV+e8IsvzPL1RdLB51ocSpFCU0ukgxRoVvJwRcQ5oWZLxC855QwP
         INdhPooeLYEFz20a9To3QwEo1dZjLRYpViS/eFdYATIVuQMIHozxG9gXDDl+53sKe7k9
         +Zqw==
X-Gm-Message-State: AOAM531FYWKiHtKW8PTdg3tkdnv01zJZ186ZsF1624lPmT2r1rbqhLA4
        +hV2ylK2rHmRYQR3L9n5mZvgvZp87xMM4Q==
X-Google-Smtp-Source: ABdhPJwGNP6qetFj22O3XC3bhZ2UsXDsOy/2T9TjbyKD2hFUANqQA/hD2zjhHjObQDIKAFrt9WCsjw==
X-Received: by 2002:a17:906:1dd0:: with SMTP id v16mr41082565ejh.309.1600536286916;
        Sat, 19 Sep 2020 10:24:46 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id h2sm4961626ejk.33.2020.09.19.10.24.46
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 10:24:46 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id g4so8655396wrs.5
        for <linux-csky@vger.kernel.org>; Sat, 19 Sep 2020 10:24:46 -0700 (PDT)
X-Received: by 2002:a19:521a:: with SMTP id m26mr14134256lfb.133.1600535951025;
 Sat, 19 Sep 2020 10:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200919091751.011116649@linutronix.de>
In-Reply-To: <20200919091751.011116649@linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 19 Sep 2020 10:18:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com>
Message-ID: <CAHk-=wiYGyrFRbA1cc71D2-nc5U9LM9jUJesXGqpPnB7E4X1YQ@mail.gmail.com>
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

On Sat, Sep 19, 2020 at 2:50 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> this provides a preemptible variant of kmap_atomic & related
> interfaces. This is achieved by:

Ack. This looks really nice, even apart from the new capability.

The only thing I really reacted to is that the name doesn't make sense
to me: "kmap_temporary()" seems a bit odd.

Particularly for an interface that really is basically meant as a
better replacement of "kmap_atomic()" (but is perhaps also a better
replacement for "kmap()").

I think I understand how the name came about: I think the "temporary"
is there as a distinction from the "longterm" regular kmap(). So I
think it makes some sense from an internal implementation angle, but I
don't think it makes a lot of sense from an interface name.

I don't know what might be a better name, but if we want to emphasize
that it's thread-private and a one-off, maybe "local" would be a
better naming, and make it distinct from the "global" nature of the
old kmap() interface?

However, another solution might be to just use this new preemptible
"local" kmap(), and remove the old global one entirely. Yes, the old
global one caches the page table mapping and that sounds really
efficient and nice. But it's actually horribly horribly bad, because
it means that we need to use locking for them. Your new "temporary"
implementation seems to be fundamentally better locking-wise, and only
need preemption disabling as locking (and is equally fast for the
non-highmem case).

So I wonder if the single-page TLB flush isn't a better model, and
whether it wouldn't be a lot simpler to just get rid of the old
complex kmap() entirely, and replace it with this?

I agree we can't replace the kmap_atomic() version, because maybe
people depend on the preemption disabling it also implied. But what
about replacing the non-atomic kmap()?

Maybe I've missed something.  Is it because the new interface still
does "pagefault_disable()" perhaps?

But does it even need the pagefault_disable() at all? Yes, the
*atomic* one obviously needed it. But why does this new one need to
disable page faults?

[ I'm just reading the patches, I didn't try to apply them and look at
the end result, so I might have missed something ]

The only other worry I would have is just test coverage of this
change. I suspect very few developers use HIGHMEM. And I know the
various test robots don't tend to test 32-bit either.

But apart from that question about naming (and perhaps replacing
kmap() entirely), I very much like it.

                        Linus
