Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9C453DD22
	for <lists+linux-csky@lfdr.de>; Sun,  5 Jun 2022 18:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245383AbiFEQlt (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sun, 5 Jun 2022 12:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245118AbiFEQlt (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sun, 5 Jun 2022 12:41:49 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB634DF56
        for <linux-csky@vger.kernel.org>; Sun,  5 Jun 2022 09:41:48 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id b8so15901671edf.11
        for <linux-csky@vger.kernel.org>; Sun, 05 Jun 2022 09:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jdIVKFSk2eIbeHqEWdMi4/8HFEkUDh1Z4gYM7GW4sa0=;
        b=QiWi8O0uBmOcDTjvLLtS7RJP75oD8QAMzCNIR6xgGGo8LMbdoFvr7/kDyWQLXQ55uU
         K+AiabjxiAwoJ89j+dYMVQGZfwFWy22kGZQb4YLQYDlhkEVn7n7dby8AaXnObgdo72fN
         GZwRjklJ0BMY1TqUhjMmtDoTtyK0M+bX7NU3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jdIVKFSk2eIbeHqEWdMi4/8HFEkUDh1Z4gYM7GW4sa0=;
        b=U3DyrsyOpMqDRVdMHOAng6+VZT/WRa7u2VwgFmIKA5f1VAsRfx51sLcTqdhvDO/2Ft
         J+RauhyewlCX+tJHGS5O5V0JfQnW5v/te9VkAvRJ38z8CgvC2VUmrJq6iaS9v9NOwZhJ
         sUxu90zWXC0oHmSVHygSx8h6+B5JJ4gqPkaojiQ25d00S/L9eLxKg7b42jkK+ltABGA6
         KftLcHEhMX+bhu2JaQQ5OIRL6ofJnYmZ0/Ru35FgjKP3aytYN0DOhBOpzoHaKAolm6Wp
         QCPudmrAN/zqp2xywoL8zNVGLcudBido7I1N+8m8NxU2yWEfraHXzMrAoASlK+Ffq8HR
         lu6g==
X-Gm-Message-State: AOAM530qlWbOccbV8AMSJQnnUAT1wktUUFbNsPwjCB+9zcO+eJtD+D8G
        vVOO7UkjO33GaFFOhb03MeJAyw+LB028JHDIFeY=
X-Google-Smtp-Source: ABdhPJxbaC3QuPyAGcK5E/KCjoDaTg278FnjRT+REe2HOyAQ2xMnQN7QN6SZEcRHvm4PkAGBya2oHw==
X-Received: by 2002:aa7:cd8e:0:b0:42e:7b9:3454 with SMTP id x14-20020aa7cd8e000000b0042e07b93454mr21424704edv.179.1654447306804;
        Sun, 05 Jun 2022 09:41:46 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id f3-20020a056402150300b0042dd3bf1403sm7012868edw.54.2022.06.05.09.41.46
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jun 2022 09:41:46 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id bg6so4979336ejb.0
        for <linux-csky@vger.kernel.org>; Sun, 05 Jun 2022 09:41:46 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr17796010wrf.193.1654446893075; Sun, 05
 Jun 2022 09:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220605162537.1604762-1-yury.norov@gmail.com>
In-Reply-To: <20220605162537.1604762-1-yury.norov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Jun 2022 09:34:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqgEA=OOPQs7JF=xps3VxjJ5uUnfXgzTv4gqTDhraZFA@mail.gmail.com>
Message-ID: <CAHk-=whqgEA=OOPQs7JF=xps3VxjJ5uUnfXgzTv4gqTDhraZFA@mail.gmail.com>
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

On Sun, Jun 5, 2022 at 9:25 AM Yury Norov <yury.norov@gmail.com> wrote:
>
> The commit 0a97953fd221 ("lib: add bitmap_{from,to}_arr64") changed
> implementation of bitmap_from_u64(), so that it doesn't typecast
> argument to u64, and actually dereferences memory.

Gaah.

That code shouldn't use DECLARE_BITMAP() at all, it should just use

    struct bdaddr_list_with_flags {
            ..
            unsigned long flags;
    };

and then use '&br_params->flags' when it nneds the actual atomic
'set_bit()' things and friends, and then when it copies the flags
around it should just use 'flags' as an integer value.

The bitmap functions are literally defined to work as "bit N in a set
of 'unsigned long'" exactly so that you can do that mixing of values
and bit operations, and not have to worry about insane architectures
that do big-endian bit ordering or things like that.

Using a 'bitmap' as if it's some bigger or potentially variable-sized
thing for this kind of flags usage is crazy, when the code already
does

  /* Make sure number of flags doesn't exceed sizeof(current_flags) */
  static_assert(__HCI_CONN_NUM_FLAGS < 32);

because other parts are limited to 32 bits.

I wonder how painful it would be to just fix that odd type mistake.

                  Linus
