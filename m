Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52DB5418F5
	for <lists+linux-csky@lfdr.de>; Tue,  7 Jun 2022 23:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376266AbiFGVSX (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 7 Jun 2022 17:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380760AbiFGVQ4 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 7 Jun 2022 17:16:56 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF2D66697
        for <linux-csky@vger.kernel.org>; Tue,  7 Jun 2022 11:57:16 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s13so20242689ljd.4
        for <linux-csky@vger.kernel.org>; Tue, 07 Jun 2022 11:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxgwqXrTE5CS81OOTZfgrmr4rRv5j2bUa4aaRbpCvDQ=;
        b=UIn4bvZhXW7AF2rT52jP/vHIPjI8XyKoA3dn2Q+Bi0s2HH11YyOvGVEVe86JVSoGKI
         BaaWsQh6OrE4aTrQmY6fkIGKtAYybadmY8CgsBkfKkdrn9/E2Hw2YgipoxbbIFvguJ8i
         wugGZSlCqni+gcqC9Yso1tIQl10wVmmIOsHm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxgwqXrTE5CS81OOTZfgrmr4rRv5j2bUa4aaRbpCvDQ=;
        b=T77gOzY+9wDW2D+DJDNSKVE3CckywPSHdogQa8SB8HEmTNwtnmUeWc0wOGxBHUqBPh
         daPjqVjCcaklUsp2/9deZOO/K7n4//SHRRp4ydkU3sHkQ8CVB3yAJ3Zuympkkv/1EloM
         NddiIcv2K9MhMdy0J37afYIXG/fadO9aZQcRL/IHcDn1L4zwLF5NWGD7Dk0VJm3klncm
         JuAGOPtAeDcIz1nG6CWAvYvfedbPz8pwPPTkFp9+FBSLW+jpb7B4Cp1n8FfdEBGo73sa
         ASXIx9/i5iJoi6skCkPa1T4o8CHUqNBldTX8j1QeDN0lN96nRG6lD873EyPFmJKVgYOQ
         g26w==
X-Gm-Message-State: AOAM5332sqyjNS9oa7S8IbOqZbm0UWlRIIq9BBz9HTa4pIUv3557/flP
        xi2e/E1DbfDJqYSA5ddkZZ33e9Tq2hE7rC/vzDg=
X-Google-Smtp-Source: ABdhPJyZQ6uHFsQVMlyWpq6mfTWMtuZIUb7k2l3+Lc4CIB4KjO9tnIwikokM0YMpjwpkcUFWkaFYHA==
X-Received: by 2002:a2e:a7c8:0:b0:255:a000:cbc9 with SMTP id x8-20020a2ea7c8000000b00255a000cbc9mr5697809ljp.28.1654628234998;
        Tue, 07 Jun 2022 11:57:14 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id du8-20020a056512298800b0047255d21104sm1279162lfb.51.2022.06.07.11.57.14
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 11:57:14 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id be31so29747241lfb.10
        for <linux-csky@vger.kernel.org>; Tue, 07 Jun 2022 11:57:14 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr28815309wrz.281.1654627813569; Tue, 07
 Jun 2022 11:50:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220605162537.1604762-1-yury.norov@gmail.com>
 <CAHk-=whqgEA=OOPQs7JF=xps3VxjJ5uUnfXgzTv4gqTDhraZFA@mail.gmail.com>
 <CAHk-=wib4F=71sXhamdPzLEZ9S4Lw4Dv3N2jLxv6-i8fHfMeDQ@mail.gmail.com>
 <CAHk-=wicWxvuaL7GCj+1uEvpvpntdcB=AHot_h3j4wpenwyZ2Q@mail.gmail.com> <CABBYNZJfqAU-o7f9HhLCgTmL46WfwNQbM5NsCACsVVDLACMLYw@mail.gmail.com>
In-Reply-To: <CABBYNZJfqAU-o7f9HhLCgTmL46WfwNQbM5NsCACsVVDLACMLYw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Jun 2022 11:49:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcV=BE6bkyd50eZZnggaczKdpU_PevFRWw_hjJS72UPw@mail.gmail.com>
Message-ID: <CAHk-=whcV=BE6bkyd50eZZnggaczKdpU_PevFRWw_hjJS72UPw@mail.gmail.com>
Subject: Re: [PATCH] net/bluetooth: fix erroneous use of bitmap_from_u64()
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Guo Ren <guoren@kernel.org>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
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

On Mon, Jun 6, 2022 at 11:00 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Right, thanks for fixing it. About some of the changes perhaps we
> should use BIT when declaring values in enum hci_conn_flags?

That sounds sane, although with just two flag values I'm not sure it matters.

But I guess it would document the fact that it's a bitmask, not an
ordinal value, and it looks like that header is already using BIT()
elsewhere so there are no new header file dependencies..

              Linus
