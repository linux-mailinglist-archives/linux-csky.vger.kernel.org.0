Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FF95ED436
	for <lists+linux-csky@lfdr.de>; Wed, 28 Sep 2022 07:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbiI1FZw (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 28 Sep 2022 01:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiI1FZv (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 28 Sep 2022 01:25:51 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DA41CD69D
        for <linux-csky@vger.kernel.org>; Tue, 27 Sep 2022 22:25:49 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a10so13204589ljq.0
        for <linux-csky@vger.kernel.org>; Tue, 27 Sep 2022 22:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=IPCLwIQ+UERHPm9w4nQGFYrwmlLzJ4AJ3JlVNkOLjfk=;
        b=owmaWL8J0DjnByEMa+cLbTORIRrq8yp3lKV8crjvgMM/NkKnWeQIxzmI5VTzceEs3i
         S3i46YmZL6hhUlOZgye5isjPYmsTL9s7ZQbh4KxfmQHhPEMfq8R8W01RbLcG9+VJVBK9
         8fBxKiJNmH3HTgTCP9QbaG5As7Xex+3GS9vMzEkw0RXkyxtNit3zG4NH6cmFKNhRPLcJ
         1wpCfkC3/obFIyVNyGRuEV+B6a4cqc/MfTeighQRcl1evlTq2RPNa22Fpm7esVybK8t9
         XiN03BRQL3c+PNAEazrBabL0xPu6A+N1Pr1UnZe63PhoxCuf5jkappeLkxgBidmJu+mi
         rgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=IPCLwIQ+UERHPm9w4nQGFYrwmlLzJ4AJ3JlVNkOLjfk=;
        b=SmVzczGY7+wBRAGohDoZlCUUWb6L+bHuFG86h6nryy3b2WYJ2XdhLmGpUSru2YRCTb
         HBXdHY+3i20vy+NTBZ5CyF3EdBKGkAsmFhS5QGeqTwS9hASBpwvUxa0czZIiaxGV63nU
         5SwFqfNHt+y9x4LSOO7zEGO9wO3jAW0mDDwma2ylEDWVIjNQqMd4fkgh3feHOl7YEdsK
         WTSzz3Y3VRe7UEY6DUFmbDPFMfBKawKOxOaWofc6NOpiP7h44PSm+YtFoGwIJ2Zu+99M
         kEK/fWs7iG2RD/2/sEfyZZXt5bnul8OwCEnUp+X9OYEDA+OharvWOIMXf7pK8yWa2up2
         z5jg==
X-Gm-Message-State: ACrzQf3v3yLJGZpiUqAFaiv/qNIv1F0gzTmM/HHy+IYacU9S95aEu74N
        xbQDEouZPciafT+VeY3CMVnl65PVk4YwTJpTxrZekw==
X-Google-Smtp-Source: AMsMyM7wMhHzCDPMFbCTrNC4bpJlQfmpId5OarS9R/571Zfneoaf+BQ5BEj/3dPyNZFm2pWs5O4V9tiCRmerzE31Li4=
X-Received: by 2002:a2e:3909:0:b0:26c:2ea4:1a79 with SMTP id
 g9-20020a2e3909000000b0026c2ea41a79mr10902755lja.401.1664342747490; Tue, 27
 Sep 2022 22:25:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220830193701.1702962-1-maskray@google.com> <20220910075316.no72fdyqjvunomwm@google.com>
In-Reply-To: <20220910075316.no72fdyqjvunomwm@google.com>
From:   Fangrui Song <maskray@google.com>
Date:   Tue, 27 Sep 2022 22:25:35 -0700
Message-ID: <CAFP8O3+OwanSJdzd5V3oGJ_MOJOSVdbn+4iBJJKm2LCR8mCA0Q@mail.gmail.com>
Subject: Re: [PATCH] vdso: Improve cmd_vdso_check to check all dynamic relocations
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sat, Sep 10, 2022 at 12:53 AM Fangrui Song <maskray@google.com> wrote:
>
> On 2022-08-30, Fangrui Song wrote:
> >The actual intention is that no dynamic relocation exists. However, some
> >GNU ld ports produce unneeded R_*_NONE. (If a port is not care enough to
> >determine the exact .rel[a].dyn size, the trailing zeros become R_*_NONE
> >relocations. E.g. powerpc64le ld as of 2.38 has the issue with
> >defconfig.) R_*_NONE are generally no-op in the dynamic loaders. So just
> >ignore them.
> >
> >With the change, we can remove ARCH_REL_TYPE_ABS. ARCH_REL_TYPE_ABS is a
> >bit misnomer as ports may check RELAVETIVE/GLOB_DAT/JUMP_SLOT which are
> >not called "absolute relocations". (The patch is motivated by the arm64
> >port missing R_AARCH64_RELATIVE.)
> >
> >While here, replace "egrep" with "grep" as "egrep" is deprecated in GNU
> >grep 3.7.
> >
> >Signed-off-by: Fangrui Song <maskray@google.com>
> >---
> >[...]
> >
>
> Ping.

Ping^2 :)
