Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2CA501DF3
	for <lists+linux-csky@lfdr.de>; Fri, 15 Apr 2022 00:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245355AbiDNWHq (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 14 Apr 2022 18:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237039AbiDNWHn (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 14 Apr 2022 18:07:43 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88C9AD13A
        for <linux-csky@vger.kernel.org>; Thu, 14 Apr 2022 15:05:14 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h5so5920370pgc.7
        for <linux-csky@vger.kernel.org>; Thu, 14 Apr 2022 15:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=kj79e2RofkdZtpcV4cuOdSuq76rCoCCYoAotU+R/caE=;
        b=Mub7+Xk9wwSBUzXegquRSmLHR9ZMLVl+1ewzq5ugAx4HR1GhjoZLMMFmESOz5cYpd4
         IUiDTMhYid2V2PzT+m554J80jj/yd0Smc/vEc8jxPkbRHFPCLa6XsvbMaUwGDVx5GqRk
         Sd5V0dPiRN96hXapmj2tjFQuC0Qh4YXAbNDqG/xgOYl1dzeFH2v0VX3nBxxyFb+9Nern
         2NFcsL/GBKleI6+/AFI5moGEf64wKIr1pufuCE/CAFm5t1MNIgwqoSnpO8NCH6LeTttu
         n9q0DFM8C/BW8GyewTYnqBCX5uc2Bm0yPLTCVweVHMFgSjYiAOq98kz9s95A+ZT8PL5J
         SbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=kj79e2RofkdZtpcV4cuOdSuq76rCoCCYoAotU+R/caE=;
        b=JZZzT0Avpoc9Ni2wW/2Au/J/sDW3WBQaZc7jQYkpWV2pxUwJouOYMUZSIEa6JyoYjN
         /y0EfuIX6PfjXPoHTExAXul4pCKvO7DAzdmwOcrC1lROmmTCwFPAi7W0oK3bz+j8QaGJ
         r6+kTqq9v4puiwz3vYs7tFUJMVzIadoXQVoT0e3uvHDu9kGI6TSAQ13wBDq9P6D37Xsd
         tvJWgrRL0iUbo+czFef67XDQtfJmeCbwPh+Jp/oD3WiUTcU4rbWCuEmZGfWcZ45HNby9
         DtSklytWujvTqz/nu6XKxv5CxF+0GUg4YTyGMWRX2TW6QE55Bx1ysvPXQYmIpuuEWC8s
         9frg==
X-Gm-Message-State: AOAM532n991tztBt/J0/4MEz88TWvjHQdBzglys8in2KuFiDYpQ4Mp7M
        kw7opJic4abqmgZws4jAagvMYQ==
X-Google-Smtp-Source: ABdhPJwjtqU6AWYAwYXufYTV42SdwmS0JH8rrNmXsZg+uKyEV95T0qFTo4wyvCTdhcUWt5XoHP3CIg==
X-Received: by 2002:a63:780f:0:b0:386:5d6f:2153 with SMTP id t15-20020a63780f000000b003865d6f2153mr3792784pgc.555.1649973914297;
        Thu, 14 Apr 2022 15:05:14 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id g12-20020a056a001a0c00b004e1307b249csm836244pfv.69.2022.04.14.15.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 15:05:13 -0700 (PDT)
Subject: [PATCH v3 0/7] Generic Ticket Spinlocks
Date:   Thu, 14 Apr 2022 15:02:07 -0700
Message-Id: <20220414220214.24556-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, macro@orcam.me.uk,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, wangkefeng.wang@huawei.com,
        jszhang@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, openrisc@lists.librecores.org,
        linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>, heiko@sntech.de, guoren@kernel.org,
        shorne@gmail.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Looks like feedback has been largely positive on this one.  I think I
got everything from the v1 and v2, but it was a bit mixed up so sorry if
I missed something.  I'm generally being conservative on the tags here,
as things have drifted around a bit.  Specifically I dropped the
Tested-bys, as this is all based on 5.18-rc1 now and there's been a
touch of diff.

I've put this at palmer/tspinlock-v3, in case that helps anyone.  This
generally looks good to me, but I'll wait for feedback before putting it
anywhere else.  I'd default to doing a shared tag for the asm-generic
stuff and then let other arch folks pull in that (with their arch
support), but if you want me to take it via my tree then feel free to
just say so explicitly.  What's on that branch right now definately
shouldn't be treated as stable, though, as I'll wait for at least an
official Ack/Review from the asm-generic folks (and of course there may
be more feedback).

This passes my standard tests, both as the whole thing and as just the
RISC-V spinlock change.  That's just QEMU, though, so it's not all that
exciting.

Changes since v2 <20220319035457.2214979-1-guoren@kernel.org>:
* Picked up Peter's SOBs, which were posted on the v1.
* Re-ordered the first two patches, as they
* Re-worded the RISC-V qrwlock patch, as it was a bit mushy.  I also
  added a blurb in the qrwlock's top comment about this dependency.
* Picked up Stafford's fix for big-endian systems, which I have not
  tested as I don't have one (at least easily availiable, I think the BE
  MIPS systems are still in that pile in my garage).
* Call the generic version <asm-genenic/spinlock{_types}.h>, as there's
  really no utility to the version that only errors out.

Changes since v1 <20220316232600.20419-1-palmer@rivosinc.com>:
* Follow Arnd suggestion to make the patch series more generic.
* Add csky in the series.
* Combine RISC-V's two patches into one.
* Modify openrisc's patch to suit the new generic version.
