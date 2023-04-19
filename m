Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9366E789B
	for <lists+linux-csky@lfdr.de>; Wed, 19 Apr 2023 13:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjDSL2A (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 19 Apr 2023 07:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjDSL15 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 19 Apr 2023 07:27:57 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD6C13C0D
        for <linux-csky@vger.kernel.org>; Wed, 19 Apr 2023 04:27:48 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4ec86aeeb5cso2848847e87.3
        for <linux-csky@vger.kernel.org>; Wed, 19 Apr 2023 04:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1681903666; x=1684495666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N99yfKqkNg/PzVluqPrnuo7/UXaVkUZ4pARZeRWAW0=;
        b=Ux/GDGVAM57WoTf6l6plF//sVNIuD838Epbh9s62EhDffZ8C1zND9VCp6I65XnhTD0
         RmN3ZqdJwI+YF7CDY+Sm9EL7fryeXPnwUIp3b4Vq4dUnaTlaFTtPCyB6F3eYABp5CfA4
         RmTp72Hkk/roWQCzxffKV02t6ttEGsWZZCiqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681903666; x=1684495666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8N99yfKqkNg/PzVluqPrnuo7/UXaVkUZ4pARZeRWAW0=;
        b=gRZ3I4n5MQLhogTTYxClTe5dbRJzdmmo10g9WLJrSljQyqN3qexa/xuzKmYDA1FLB9
         YwvRVdsk+hjobKtyL2GZN6hPAoQo/q9gN5UixfNH+PrwNuBOV2k5IdDOvaaoLizh+35Q
         e5sLn87wwoV+z07ub6SpsN02/1zT7zpHQLLbYuXiaAhdzZDJHhN0EsoOtGHo7nl/tL2N
         UCQGhD5dSIOmY/942/e8q7Na9iXuC642I/b2lST9IDCSg9RFBAUzpI2bhMMV4QN3bcA1
         uf1HWeiREkkmw0Uw1YBk/lrRbgxIArRLmGEC1PAeWDkJGIjiaEUJCHRr/qAHeH4H1CgF
         qGYQ==
X-Gm-Message-State: AAQBX9d2ajX5hZ8ILEXbAPnSRgoBxRJ75KB1s6MorMWrynnp0mPCuBW+
        eGI81pV+mJeAsc3i6FUNNGc7YqTSbr4nBnPuQQij1A==
X-Google-Smtp-Source: AKy350aAKZd2nplapkhBn15mkdLADX/aXFBLgBXh+eoV7vtkzbLudJZQNXmi0ryH4UjoUGbUynGzaw==
X-Received: by 2002:a19:7606:0:b0:4e9:8cae:c620 with SMTP id c6-20020a197606000000b004e98caec620mr4414751lff.61.1681903666367;
        Wed, 19 Apr 2023 04:27:46 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id c3-20020a05651221a300b004a6f66eed7fsm2636354lft.165.2023.04.19.04.27.44
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 04:27:44 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-lj1-f178.google.com with SMTP id x34so20346379ljq.1
        for <linux-csky@vger.kernel.org>; Wed, 19 Apr 2023 04:27:44 -0700 (PDT)
X-Received: by 2002:a2e:7012:0:b0:2a5:fe8f:b314 with SMTP id
 l18-20020a2e7012000000b002a5fe8fb314mr1874851ljc.5.1681903663880; Wed, 19 Apr
 2023 04:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230325060828.2662773-1-rppt@kernel.org> <20230325060828.2662773-3-rppt@kernel.org>
 <CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com>
 <ZCvQGJzdED+An8an@kernel.org> <CAFbkSA38eTA_iJ3ttBvQ8G4Rjj8qB12GxY7Z=qmZ8wm+0tZieA@mail.gmail.com>
 <ZDbp7LAHES3YFo30@arm.com> <20230418150557.ea8c87c96ec64c899c88ab08@linux-foundation.org>
 <ZD/K+Mof/Dx5yzjQ@arm.com>
In-Reply-To: <ZD/K+Mof/Dx5yzjQ@arm.com>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Wed, 19 Apr 2023 06:27:31 -0500
X-Gmail-Original-Message-ID: <CAFbkSA3yn_4Monrnk2u3CzfJ934Hy15rjAJ85AdFU40nV7KTkQ@mail.gmail.com>
Message-ID: <CAFbkSA3yn_4Monrnk2u3CzfJ934Hy15rjAJ85AdFU40nV7KTkQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Wed, Apr 19, 2023 at 6:12=E2=80=AFAM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Tue, Apr 18, 2023 at 03:05:57PM -0700, Andrew Morton wrote:
> > On Wed, 12 Apr 2023 18:27:08 +0100 Catalin Marinas <catalin.marinas@arm=
.com> wrote:
> > > > It sounds nice in theory. In practice. EXPERT hides too much. When =
you
> > > > flip expert, you expose over a 175ish new config options which are
> > > > hidden behind EXPERT.  You don't have to know what you are doing ju=
st
> > > > with the MAX_ORDER, but a whole bunch more as well.  If everyone we=
re
> > > > already running 10, this might be less of a problem. At least Fedor=
a
> > > > and RHEL are running 13 for 4K pages on aarch64. This was not some
> > > > accidental choice, we had to carry a patch to even allow it for a
> > > > while.  If this does go in as is, we will likely just carry a patch=
 to
> > > > remove the "if EXPERT", but that is a bit of a disservice to users =
who
> > > > might be trying to debug something else upstream, bisecting upstrea=
m
> > > > kernels or testing a patch.  In those cases, people tend to use
> > > > pristine upstream sources without distro patches to verify, and the=
y
> > > > tend to use their existing configs. With this change, their MAX_ORD=
ER
> > > > will drop to 10 from 13 silently.   That can look like a different
> > > > issue enough to ruin a bisect or have them give bad feedback on a
> > > > patch because it introduces a "regression" which is not a regressio=
n
> > > > at all, but a config change they couldn't see.
> > >
> > > If we remove EXPERT (as prior to this patch), I'd rather keep the ran=
ges
> > > and avoid having to explain to people why some random MAX_ORDER doesn=
't
> > > build (keeping the range would also make sense for randconfig, not su=
re
> > > we got to any conclusion there).
> >
> > Well this doesn't seem to have got anywhere.  I think I'll send the
> > patchset into Linus for the next merge window as-is.  Please let's take
> > a look at this Kconfig presentation issue during the following -rc
> > cycle.
>
> That's fine by me. I have a slight preference to drop EXPERT and keep
> the ranges in, especially if it affects current distro kernels. Debian
> seems to enable EXPERT already in their arm64 kernel config but I'm not
> sure about the Fedora or other distro kernels. If they don't, we can
> fix/revert this Kconfig entry once the merging window is closed.

Fedora and RHEL do not enable EXPERT already.

Justin
