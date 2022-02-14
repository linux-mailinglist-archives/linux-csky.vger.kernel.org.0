Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5224B58B7
	for <lists+linux-csky@lfdr.de>; Mon, 14 Feb 2022 18:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356541AbiBNRl1 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Mon, 14 Feb 2022 12:41:27 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348450AbiBNRl0 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Mon, 14 Feb 2022 12:41:26 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BA165436
        for <linux-csky@vger.kernel.org>; Mon, 14 Feb 2022 09:41:18 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id q17so268647edd.4
        for <linux-csky@vger.kernel.org>; Mon, 14 Feb 2022 09:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hl2tx2/b0j1as4iPc8br7ak6VbssTN3Lkaa01qKImp4=;
        b=B3+89vMVlD+t/jr4Ir3J5heCAGLy+8O/Bfqv5DSjHS7vGRacFAUCCs0TF2tOD5+IOJ
         DARHbhMwmXg8IKTGNN5wyW1UIWJ3dy3zDkUXnMSy6euD4EH/SAawjrYbWaSs+0JtxWja
         ZBOb3OkzZ9V/CSYGxjkJVHb89skxzNvZve0yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hl2tx2/b0j1as4iPc8br7ak6VbssTN3Lkaa01qKImp4=;
        b=l/0Y3VYpdPGB07QMgiOVC8nF/XVd9z9zk/ig2cR9K1GG4tQhyqVGhF/8TKx3IZemsH
         1g1Cw2i4Jygxcm8wXbOc+dFWNLXG8ySK/NEyfaYmmgIGml4+YNwS+6hxMh/EbvwRuWN9
         oxOo7/TR9GbLbJw8AHDeoqynaSW9zpp4db9Xb5809YXPCBS2rQDTLlzzZTAAu+xbo9tl
         SGvFSvW1R42ya08WQIOlqryhzuS2QlGF/FG45YmsOfuueWZQ9t+ATehHnI/3EJVXNjgc
         z+5h2MAB2sfZvnz+M/qHPPTw2hTmv01k792BkNZiat30FxNbYumHtwobt4hx+qcL3FpV
         yWpw==
X-Gm-Message-State: AOAM533eCDirwK6zXVP+twTgufevYiT0Gpay4vGkZBwGkUBWADuMIYQ8
        Tx6jusZIzXkaNnQ0Qu+gqt9gIfvHYDgqwT2MhaA=
X-Google-Smtp-Source: ABdhPJwXg5HJXF+Gya7wq2WdcFwDS4u7bXnb+NZS5ROugYWKExilQ7k1QafUfWMVNbx5Nt/lWteJfQ==
X-Received: by 2002:a05:6402:22b7:: with SMTP id cx23mr741761edb.91.1644860476919;
        Mon, 14 Feb 2022 09:41:16 -0800 (PST)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id z18sm1275693ejl.78.2022.02.14.09.41.16
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Feb 2022 09:41:16 -0800 (PST)
Received: by mail-ej1-f46.google.com with SMTP id h8so12509423ejy.4
        for <linux-csky@vger.kernel.org>; Mon, 14 Feb 2022 09:41:16 -0800 (PST)
X-Received: by 2002:a19:4302:: with SMTP id q2mr49672lfa.449.1644860131952;
 Mon, 14 Feb 2022 09:35:31 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org>
In-Reply-To: <20220214163452.1568807-1-arnd@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Feb 2022 09:35:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=whXYWoP6of7js=f4zov62on97mNFRSVRWhY75WoGM6CoQ@mail.gmail.com>
Message-ID: <CAHk-=whXYWoP6of7js=f4zov62on97mNFRSVRWhY75WoGM6CoQ@mail.gmail.com>
Subject: Re: [PATCH 00/14] clean up asm/uaccess.h, kill set_fs for good
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
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
        <linux-snps-arc@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        linux-hexagon <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        openrisc@lists.librecores.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-xtensa@linux-xtensa.org
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

On Mon, Feb 14, 2022 at 8:35 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> I did a patch for microblaze at some point, which turned out to be fairly
> generic, and now ported it to most other architectures, using new generic
> implementations of access_ok() and __{get,put}_kernel_nocheck().

Thanks for doing this.

Apart from the sparc64 issue with completely separate address spaces
(so access_ok() should always return true like Al pointed out), this
looks excellent to me.

Somebody should check that there aren't other cases like sparc64, but
let's merge this asap other than that.

              Linus
