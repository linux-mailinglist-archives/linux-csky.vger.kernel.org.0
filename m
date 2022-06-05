Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4409B53DF09
	for <lists+linux-csky@lfdr.de>; Mon,  6 Jun 2022 02:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348637AbiFFACw (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sun, 5 Jun 2022 20:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348715AbiFFACv (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sun, 5 Jun 2022 20:02:51 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75492ED58
        for <linux-csky@vger.kernel.org>; Sun,  5 Jun 2022 17:02:47 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j10so20856590lfe.12
        for <linux-csky@vger.kernel.org>; Sun, 05 Jun 2022 17:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iRX+dAaHFYHOMUkkn7e8l97Dwcch2sYAXae8M4f8XjE=;
        b=B+w0Y6o1NT9jGOE9kjSjrSBAJ9eA6U+dI1XGTGNKFUSIW1CGxv58Uvz8TroRpXFL1I
         jOVUYOxXT6wmSLmfjsCY84xZJczlEuYLR0s8LaRgKZd9k2S+h1lWW2reAZZdqlSLPNu4
         ZeJUTW8DlEBxbtUxbl/awnYiB+zDYOwZ9VUro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iRX+dAaHFYHOMUkkn7e8l97Dwcch2sYAXae8M4f8XjE=;
        b=gKY6OnXncL5LhZHV9FcbqMFBd9O1cPf/dXW7s/VzOb5CYV61IUVLrNU3c6eWLw2X9T
         JC6KapmjHtCNNP6p+uJN0UQ3hmXE7OHjmXO3VtjqwsAlDdC8Le8tAx3KmeguqOodWEe6
         ljd4jUMC0SjiN65dKKiI8maNdmP6eNppGRqLpqTTkZiGO/qfZrbsLVleztpDf9pJ25rR
         /+uhE04J/9Bqh7BURrVSHwv76rb1OfHGnzKNHMitaxTCnIviVXgiOL5orUTWBHdK1x7E
         grK/xUsW/2dEuA9oUQySRYH9i3RtxdXbTE2VpULam+IFYMnEiVeg5geVS5PFMyotFQ7R
         foAA==
X-Gm-Message-State: AOAM532nLAuimoqouoC7vdPnuhaWID0Hoyiw/aqcPJ7tcLa3xtzFYFUS
        d6ELIvYPWQTToWyMJmsP4jfSmRGCA9A/UItiNLI=
X-Google-Smtp-Source: ABdhPJzh7utd+dlnu1CITo6ZAB0nR4S1RRn51ztuOP/yh65ELAClhKdY2w20OTlWKaKI0e3L5eJgdA==
X-Received: by 2002:ac2:4c50:0:b0:479:4fac:dd8e with SMTP id o16-20020ac24c50000000b004794facdd8emr621570lfk.678.1654473765892;
        Sun, 05 Jun 2022 17:02:45 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id f15-20020a19dc4f000000b0047255d210e4sm2649458lfj.19.2022.06.05.17.02.45
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 17:02:45 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id y15so8714957ljc.0
        for <linux-csky@vger.kernel.org>; Sun, 05 Jun 2022 17:02:45 -0700 (PDT)
X-Received: by 2002:a05:6000:1b0f:b0:210:313a:ef2a with SMTP id
 f15-20020a0560001b0f00b00210313aef2amr18555328wrz.281.1654473412987; Sun, 05
 Jun 2022 16:56:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220605162537.1604762-1-yury.norov@gmail.com>
 <CAHk-=whqgEA=OOPQs7JF=xps3VxjJ5uUnfXgzTv4gqTDhraZFA@mail.gmail.com> <CAHk-=wib4F=71sXhamdPzLEZ9S4Lw4Dv3N2jLxv6-i8fHfMeDQ@mail.gmail.com>
In-Reply-To: <CAHk-=wib4F=71sXhamdPzLEZ9S4Lw4Dv3N2jLxv6-i8fHfMeDQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jun 2022 16:56:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wicWxvuaL7GCj+1uEvpvpntdcB=AHot_h3j4wpenwyZ2Q@mail.gmail.com>
Message-ID: <CAHk-=wicWxvuaL7GCj+1uEvpvpntdcB=AHot_h3j4wpenwyZ2Q@mail.gmail.com>
Subject: Re: [PATCH] net/bluetooth: fix erroneous use of bitmap_from_u64()
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
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

On Sun, Jun 5, 2022 at 11:51 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> *Most* of the accesses to those connection flags seem to be with
> hci_dev_lock() held, and the ones that aren't can't possibly depend on
> atomicity since those things are currently copied around with random
> other "copy bitmaps" functions.

I've committed that patch as commit e1cff7002b71 ("bluetooth: don't
use bitmaps for random flag accesses").

That basically ends up reverting

  a9a347655d22 ("Bluetooth: MGMT: Add conditions for setting
HCI_CONN_FLAG_REMOTE_WAKEUP")
  6126ffabba6b ("Bluetooth: Introduce HCI_CONN_FLAG_DEVICE_PRIVACY device flag")

which did horrible things, and would end up overwriting the end of the
bitmap allocation on 32-bit architectures.

Luiz, if the reason for the change to use a bitmap type was because of
some atomicity concerns, then you can do that by

 (a) change 'hci_conn_flags_t' to be an 'atomic_t' instead of a 'u8'

 (b) change the regular accesses to it to use 'atomic_read/write()'

 (c) change the "bitfield" operations to use 'atomic_or/andnot()'

but honestly, when it used to mix atomic ops
(set_bit/clear_bit/test_bit) with random non-atomic users
(bitmap_from_u64(), bitmap_to_arr32() etc) it was never atomic to
begin with.

Regardless, trying to use bitmaps for this was absolutely not the
right thing to ever do. It looks like gcc randomly started complaining
when 'bitmap_from_u64()' was changed, but it was buggy before that
too.

                 Linus
