Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2596051BDC5
	for <lists+linux-csky@lfdr.de>; Thu,  5 May 2022 13:11:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356656AbiEELO0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-csky@lfdr.de>); Thu, 5 May 2022 07:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356670AbiEELOY (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 5 May 2022 07:14:24 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327B449695
        for <linux-csky@vger.kernel.org>; Thu,  5 May 2022 04:10:42 -0700 (PDT)
Received: from mail-wr1-f43.google.com ([209.85.221.43]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N6bsM-1ntcJS163q-0182Xn; Thu, 05 May 2022 13:05:28 +0200
Received: by mail-wr1-f43.google.com with SMTP id b19so5599157wrh.11;
        Thu, 05 May 2022 04:05:28 -0700 (PDT)
X-Gm-Message-State: AOAM532/XuQ+VxCW+RCJlBYDifqthSn+DzppiqEiO0MXfdy9Lw2E8mwU
        AmTRs8BJlhS1+ChRbtvn1xzCo8mnDEnJc7hJUME=
X-Google-Smtp-Source: ABdhPJxGGq5Fa9Cx5SSfnKSUo4b+MfSDkdVAVLGUTqD/GBtgFGV3C400pAFOppOt2I8pMGzWGNhT2WNvFkyhjBMEOv4=
X-Received: by 2002:a5d:49cb:0:b0:20a:cee3:54fc with SMTP id
 t11-20020a5d49cb000000b0020acee354fcmr19580488wrs.12.1651748727768; Thu, 05
 May 2022 04:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220430153626.30660-1-palmer@rivosinc.com> <20220430153626.30660-3-palmer@rivosinc.com>
 <7375410.EvYhyI6sBW@diego>
In-Reply-To: <7375410.EvYhyI6sBW@diego>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 5 May 2022 13:05:11 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2fLg9DJvQeOAFhRQk-O72PAhJ77CLQ+Pz_Vvh1WV1APQ@mail.gmail.com>
Message-ID: <CAK8P3a2fLg9DJvQeOAFhRQk-O72PAhJ77CLQ+Pz_Vvh1WV1APQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/7] asm-generic: qspinlock: Indicate the use of
 mixed-size atomics
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg KH <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Jisheng Zhang <jszhang@kernel.org>, linux-csky@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:QysLADnJBunexLp/VCtIkDOzKmjNjjUU2GxeczuxJ6drISdwCcZ
 sEAlEW8THoAaog2NWGf0dK6cn1QMdZU1Y0xy3ph/vSNkTng9Csu++f7XgDol4y+nBjXU4CD
 x+ymU3d1p/NSwHjHWpb3AN+XquqUvSAyQR9Bg5roWAaHcSn+tY17mxJAC7WmXtMNh6SHUtc
 rADN6ZPKHDshur69Frhmw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2ajlgBhaTl8=:khIj6ALUmtOph2/4C1QrtW
 rP47TNWZQQdv7JXTt1ix4KpNWG6xq3pmbGGFU9DHJ2wpePLHF13Vl51dfiDKmCm7OErXbiCzB
 QYKk26jCM4aaMxYTFneK4Bq3VGP2muqkYNDrrvlpIaLfYBOOt5U5Fh1SVSvgGy40cuzmv6ETN
 cW3gsCC6MoysifR9U7X5GLsOQXbYrnxaeMqG1foybBvzteWbOUXITz+oYHiAhNJ2MXuJR0Xad
 2pDbNWi6KF6A28t0FXGORGU+ZxbcepOnFxNNtgeyvrdYNgD/Sy9ZpS7QvCUX/uTARE/awhgL2
 k4LbA1VkZ9Laz0VsOROCQ4OQyiqZrvVb101nbrN4T8VSBJXJGi19Ox5rrJcS3YkDX/bDZKbJ8
 x4ZoHaYhepz3L3NLXM4ji988dhjryNQ5uEUO3n6m7ilS6O0P+TW82Pt1XdMjZxGYlJwEPZb8q
 kx3LO5ZMQO71I9bh0FzZYOQpYRth1IBrRlKL0EeR8yBk5syLZQJ40ezwBm6KtA+pNid/yLa4t
 iSm879NI8LtiWmseHvtz76gBG3nGdwVq2kzzGk6qEG/nbmNFhwShK5RihwPVTbogo19cvucMx
 pBTrfOv81MmaALGfh7AurPYfhMRnRcK+85/S2ZZUPdh0F5TObaacSl4LDDV2jqNcZtQT7O+WV
 Ec3MgC+XeA+gq2jG5Er3Vn+UiacrKoJhGu3CCFJo0resjF2gtlA8VH9W9btjzwwjQPO0shTeW
 reCCbmum76JsbH3eKsA9ME64j9x7AhQ4rKKVif4hLVrWTxV/9fuC4G4AS4emY9ks1fVc8vM6G
 ileL5twurKynCYuby74Z+4cOgQfkWklPjCBlzws9tot8esF630=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Wed, May 4, 2022 at 2:02 PM Heiko Stübner <heiko@sntech.de> wrote:
> > index d74b13825501..95be3f3c28b5 100644
> > --- a/include/asm-generic/qspinlock.h
> > +++ b/include/asm-generic/qspinlock.h
> > @@ -2,6 +2,37 @@
> >  /*
> >   * Queued spinlock
> >   *
> > + * A 'generic' spinlock implementation that is based on MCS locks. An
>
> _For_ an architecture that's ... ?
>
> > + * architecture that's looking for a 'generic' spinlock, please first consider
> > + * ticket-lock.h and only come looking here when you've considered all the
> > + * constraints below and can show your hardware does actually perform better
> > + * with qspinlock.
> > + *
> > + *
>
> double empty line is probably not necessary
>

I've applied the series to the asm-generic tree now, and edited both the above
as you suggested in the process, to save Palmer the v5.

         Arnd
