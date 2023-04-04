Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71426D5F75
	for <lists+linux-csky@lfdr.de>; Tue,  4 Apr 2023 13:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjDDLuU (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 4 Apr 2023 07:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbjDDLuT (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 4 Apr 2023 07:50:19 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B7510F3
        for <linux-csky@vger.kernel.org>; Tue,  4 Apr 2023 04:50:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id c9so31617668lfb.1
        for <linux-csky@vger.kernel.org>; Tue, 04 Apr 2023 04:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1680609014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+C2675DfMBQc+7bmUpHmKjNV2QoW8Hg7liBbtScQEs=;
        b=Hqzl4Bdv544XnV8S3Wj+exJ5CY/x4W588UQYZVhcW44bu4B3fWCejh8k1F/gNnSr+b
         vRvtelWjQP/m4pNr9bUBQwQGccDG6zbLQ2Nr7X+ay1wk/8kaabA9m1GavV7TV830h133
         OVmc3S6ROmBzl9xxyLJwyDdi2fRvRnD4bGQ34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680609014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I+C2675DfMBQc+7bmUpHmKjNV2QoW8Hg7liBbtScQEs=;
        b=G8ehlI+2E1bFG9UXg4goRiQjTHl3D3wRPSfecsoSf4P/On5mHXj2zisN3W+gcMNN8u
         TaEHUY1SXBdJNHvS2UjovLo5X4QHGS3EqYbTDrUmdWLFD8bs43f03iYLlfQK0nDixRdf
         WPBtuFcE3Cb+Pu/C76vV4V6YyQKZRSTHrKy4A/ewL8ask0Id0h7zoQXlgfGshxPeRhbg
         FxZWr7s5TVelAwby/FlaiVQNk4OMwPxa4izZI/sR7KL0X3tf4k2rfz2uD/ZmXavVp0D6
         Vg9VQV99RR9t6FUCHUT8Nf8a8oS8N9LV7IKoce715SnSOa1fKlIEqIwE2QBq9sMPjLhL
         9T0A==
X-Gm-Message-State: AAQBX9fqBuL7peqmA8hSpPOCM6CurGkfP74aiJ0BybBzpQ0Jnm8VCP8w
        0lbZAaeAM4pVSndn+nVQ29e1Ua2ivXY4AKPhthe4pg==
X-Google-Smtp-Source: AKy350b+v6XIezyN3hPcTt3fmAa46Kf5CzK+1UZldvw2VO4+jEdl2CPhAmBnP/MqCmCTLyTtwqXpjA==
X-Received: by 2002:ac2:4c95:0:b0:4d1:d8b8:84bc with SMTP id d21-20020ac24c95000000b004d1d8b884bcmr565470lfl.10.1680609014334;
        Tue, 04 Apr 2023 04:50:14 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id w12-20020a19c50c000000b004e977970721sm2265011lfe.219.2023.04.04.04.50.13
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 04:50:13 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-lf1-f45.google.com with SMTP id y15so42032599lfa.7
        for <linux-csky@vger.kernel.org>; Tue, 04 Apr 2023 04:50:13 -0700 (PDT)
X-Received: by 2002:a05:6512:38d1:b0:4e8:45d5:53cd with SMTP id
 p17-20020a05651238d100b004e845d553cdmr662558lft.12.1680609012911; Tue, 04 Apr
 2023 04:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230325060828.2662773-1-rppt@kernel.org> <20230325060828.2662773-3-rppt@kernel.org>
 <CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com> <ZCvQGJzdED+An8an@kernel.org>
In-Reply-To: <ZCvQGJzdED+An8an@kernel.org>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Tue, 4 Apr 2023 06:50:01 -0500
X-Gmail-Original-Message-ID: <CAFbkSA38eTA_iJ3ttBvQ8G4Rjj8qB12GxY7Z=qmZ8wm+0tZieA@mail.gmail.com>
Message-ID: <CAFbkSA38eTA_iJ3ttBvQ8G4Rjj8qB12GxY7Z=qmZ8wm+0tZieA@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Tue, Apr 4, 2023 at 2:22=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> On Wed, Mar 29, 2023 at 10:55:37AM -0500, Justin Forbes wrote:
> > On Sat, Mar 25, 2023 at 1:09=E2=80=AFAM Mike Rapoport <rppt@kernel.org>=
 wrote:
> > >
> > > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > >
> > > It is not a good idea to change fundamental parameters of core memory
> > > management. Having predefined ranges suggests that the values within
> > > those ranges are sensible, but one has to *really* understand
> > > implications of changing MAX_ORDER before actually amending it and
> > > ranges don't help here.
> > >
> > > Drop ranges in definition of ARCH_FORCE_MAX_ORDER and make its prompt
> > > visible only if EXPERT=3Dy
> >
> > I do not like suddenly hiding this behind EXPERT for a couple of
> > reasons.  Most importantly, it will silently change the config for
> > users building with an old kernel config.  If a user has for instance
> > "13" set and building with 4K pages, as is the current configuration
> > for Fedora and RHEL aarch64 builds, an oldconfig build will now set it
> > to 10 with no indication that it is doing so.  And while I think that
> > 10 is a fine default for many aarch64 users, there are valid reasons
> > for choosing other values. Putting this behind expert makes it much
> > less obvious that this is an option.
>
> That's the idea of EXPERT, no?
>
> This option was intended to allow allocation of huge pages for
> architectures that had PMD_ORDER > MAX_ORDER and not to allow user to
> select size of maximal physically contiguous allocation.
>
> Changes to MAX_ORDER fundamentally change the behaviour of core mm and
> unless users *really* know what they are doing there is no reason to choo=
se
> non-default values so hiding this option behind EXPERT seems totally
> appropriate to me.

It sounds nice in theory. In practice. EXPERT hides too much. When you
flip expert, you expose over a 175ish new config options which are
hidden behind EXPERT.  You don't have to know what you are doing just
with the MAX_ORDER, but a whole bunch more as well.  If everyone were
already running 10, this might be less of a problem. At least Fedora
and RHEL are running 13 for 4K pages on aarch64. This was not some
accidental choice, we had to carry a patch to even allow it for a
while.  If this does go in as is, we will likely just carry a patch to
remove the "if EXPERT", but that is a bit of a disservice to users who
might be trying to debug something else upstream, bisecting upstream
kernels or testing a patch.  In those cases, people tend to use
pristine upstream sources without distro patches to verify, and they
tend to use their existing configs. With this change, their MAX_ORDER
will drop to 10 from 13 silently.   That can look like a different
issue enough to ruin a bisect or have them give bad feedback on a
patch because it introduces a "regression" which is not a regression
at all, but a config change they couldn't see.

>
> > Justin
> >
> > > Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > > Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> > > ---
> > >  arch/arm64/Kconfig | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > > index e60baf7859d1..7324032af859 100644
> > > --- a/arch/arm64/Kconfig
> > > +++ b/arch/arm64/Kconfig
> > > @@ -1487,11 +1487,9 @@ config XEN
> > >  # 16K |       27          |      14      |       13        |        =
 11         |
> > >  # 64K |       29          |      16      |       13        |        =
 13         |
> > >  config ARCH_FORCE_MAX_ORDER
> > > -       int "Maximum zone order" if ARM64_4K_PAGES || ARM64_16K_PAGES
> > > +       int "Maximum zone order" if EXPERT && (ARM64_4K_PAGES || ARM6=
4_16K_PAGES)
> > >         default "13" if ARM64_64K_PAGES
> > > -       range 11 13 if ARM64_16K_PAGES
> > >         default "11" if ARM64_16K_PAGES
> > > -       range 10 15 if ARM64_4K_PAGES
> > >         default "10"
> > >         help
> > >           The kernel memory allocator divides physically contiguous m=
emory
> > > --
> > > 2.35.1
> > >
> > >
>
> --
> Sincerely yours,
> Mike.
>
