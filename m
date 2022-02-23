Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743474C1CEA
	for <lists+linux-csky@lfdr.de>; Wed, 23 Feb 2022 21:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237621AbiBWUNT (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 23 Feb 2022 15:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbiBWUNS (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 23 Feb 2022 15:13:18 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AE64C419
        for <linux-csky@vger.kernel.org>; Wed, 23 Feb 2022 12:12:50 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u11so5737685lju.4
        for <linux-csky@vger.kernel.org>; Wed, 23 Feb 2022 12:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+S6BFzj6o5ckty5iXSThNrfkPsdFE94/fVb8NP4+aFs=;
        b=F/2f/aEUKxSuzDdCknAbug+t8clrlE0v7gj9NkhphhHftuFg6XGIjvpJXVx+ZHKhn9
         jOIdz4l7lK+/F1JhXkxR/PARyehOhzu1/S93ijWQKe7fGKOKTiRs9R81aIq3OYNVOgnf
         G4UcKLBEtMgH8cssPIzV42vV3R64/Z0YRVhdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+S6BFzj6o5ckty5iXSThNrfkPsdFE94/fVb8NP4+aFs=;
        b=i4RfXHCy2K/QvbiQXUKRY24L5wJuJASeIgm3HxFfUagrXtsTJ2V/w7CUI3WRbCrCxQ
         BEzL1E7qmEe/ayxWuHwXmT4zAbHXzVX4nxIUlaPacDnp/jfQ4Gp2Er3QFiFBgxz+xvEj
         C64R2CN+fQNk3o0C+LKN+6w8gF6Htz7N4/z5lg4tEm+OpY35GQLC3KxHQ5MODt0ykaX9
         oipJxUxrwv8EhgTYd7GAclNh4QhmMt14V+FTFvAHbrf6BxCQ0DUcdldCmBuNoKIjusb9
         VyxJ9Flk7fu6pgb3nfgKPENHp8wZ3Mr6AIaPsWzCS0vSNzaUAh9IzdT95VCh6ODvgM2x
         GACw==
X-Gm-Message-State: AOAM530gEgWzJtOR0WYYUtDWSjFbVJdlFB36JZbOCqa8O1lUCIKcsN2l
        4nJZRB0AVGImTFB5Y4kC85ASV2cmLtWAiB5u2OY=
X-Google-Smtp-Source: ABdhPJxJ8vmgw4exvhzmo1ZtEz++xIfJbr7xUZK6LmmPDja1Kfk9pq5eM7vdDFuXf9dDRXJvV7p/kg==
X-Received: by 2002:a05:651c:1411:b0:246:187:4cd2 with SMTP id u17-20020a05651c141100b0024601874cd2mr697675lje.299.1645647168154;
        Wed, 23 Feb 2022 12:12:48 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id k1sm41238lfo.258.2022.02.23.12.12.47
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:12:47 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id v28so18895549ljv.9
        for <linux-csky@vger.kernel.org>; Wed, 23 Feb 2022 12:12:47 -0800 (PST)
X-Received: by 2002:a05:6512:130b:b0:443:c2eb:399d with SMTP id
 x11-20020a056512130b00b00443c2eb399dmr822016lfu.27.1645646720244; Wed, 23 Feb
 2022 12:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-10-arnd@kernel.org>
 <20220221132456.GA7139@alpha.franken.de>
In-Reply-To: <20220221132456.GA7139@alpha.franken.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 12:05:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjdHz6OU3M9T5zE9Fc9SNdDs52iOE+eVn-wuUT6UDpBLg@mail.gmail.com>
Message-ID: <CAHk-=wjdHz6OU3M9T5zE9Fc9SNdDs52iOE+eVn-wuUT6UDpBLg@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] mips: use simpler access_ok()
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>, linux-csky@vger.kernel.org,
        linux-hexagon <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Mon, Feb 21, 2022 at 5:25 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> With this patch
[ .. snip snip ..]
> I at least get my simple test cases fixed, but I'm not sure this is
> correct.

I think you really want to do that anyway, just to get things like
wild kernel pointers right (ie think get_kernel_nofault() and friends
for ftrace etc).

They shouldn't happen in any normal situation, but those kinds of
unverified pointers is why we _have_ get_kernel_nofault() in the first
place.

On x86-64, the roughly equivalent situation is that addresses that
aren't in canonical format do not take a #PF (page fault), they take a
#GP (general protection) fault.

So I think you want to do that fixup_exception() for any possible addresses.

> Is there a reason to not also #define TASK_SIZE_MAX   __UA_LIMIT like
> for the 32bit case ?

I would suggest against using a non-constant TASK_SIZE_MAX. Being
constant is literally one reason why it exists, when TASK_SIZE itself
has often been about other things (ie "32-bit process").

Having to load variables for things like get_user() is annoying, if
you could do it with a simple constant instead (where that "simple"
part is to avoid having to load big values from a constant pool -
often constants like "high bit set" can be loaded and compared against
more efficiently).

               Linus
