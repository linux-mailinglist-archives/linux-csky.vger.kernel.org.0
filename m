Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC4774B1A7
	for <lists+linux-csky@lfdr.de>; Fri,  7 Jul 2023 15:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjGGNR4 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 7 Jul 2023 09:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbjGGNRw (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 7 Jul 2023 09:17:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA44F1FEE
        for <linux-csky@vger.kernel.org>; Fri,  7 Jul 2023 06:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688735827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9JvrGxpvmS801EGByUJbO9yImJLqiJJEkFic7ujcF2c=;
        b=UeXtbUy09xsIdFTyTnYo1+aFQUOXhfre8JujY0k6YgvzKlD0HpkI4yP5Q82cqpZZa0g1RB
        2Lp4zCcsxWwAVO/3Jt3Z0nGuMM3djHY/XXWls9uWEDT9sTUiTGVFXQtbUQWWQTzmxptMAX
        yRf3dqhEeO+QB94HinizzbJoXC9sYPg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-ta5RfqymOtq9yR-3ZAOwTA-1; Fri, 07 Jul 2023 09:17:03 -0400
X-MC-Unique: ta5RfqymOtq9yR-3ZAOwTA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fa8db49267so11195165e9.3
        for <linux-csky@vger.kernel.org>; Fri, 07 Jul 2023 06:17:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688735822; x=1691327822;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9JvrGxpvmS801EGByUJbO9yImJLqiJJEkFic7ujcF2c=;
        b=ArmEk9BwKT9KiQQxrRI2WpF7iqv59i6L70ihEu03ZApZGMKNicZCFw+vNw8fyZDp2k
         ZKslFduH+UPXv5RxZYsbYkWxiODFTQY8UYX9Uj6H/wPsHmLHSPINCC6/wVCuQKO2k+IO
         ljwK10rd8bAaV4B54iHz5f5eYZ+UpetDqfTwxPHgaHwhaxQgIluUR08jYeD6JYd7S0kC
         MvTKOYlZ+NeoOf8D5iyC2bKbnB3BY+kY3B02HcYXTyyEF1S2E79n8Oi1yyUqrYHKZYuj
         5piRUdgrb3MDfQ57vLUfbO4tGmLnpQrXDR8izX8NwAAfslN0SFvYg1jBVoqct21sLCGd
         U+Mw==
X-Gm-Message-State: ABy/qLZYN3Kd0M9oTWT6k3rCmgGhqrsshjmJJ+zjTOWuZC6vudwGxqWX
        oUgRycvE+EwWchdkwM+b63tygee9UoTX3xF9zhYhGfXHyILa4dbN/PYunyyCapDT3Mcb4XPzM/2
        +PSws5n5bDno+1uinP9BZow==
X-Received: by 2002:a7b:c408:0:b0:3fb:d1db:545a with SMTP id k8-20020a7bc408000000b003fbd1db545amr3779651wmi.15.1688735822573;
        Fri, 07 Jul 2023 06:17:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGWyEpITRdc6V/WDH+p8W9PEEzo9YNPXNRcelMOGQxrDOPXrD+EG7aq4IUiQzrsbuo+XZhh+g==
X-Received: by 2002:a7b:c408:0:b0:3fb:d1db:545a with SMTP id k8-20020a7bc408000000b003fbd1db545amr3779635wmi.15.1688735822235;
        Fri, 07 Jul 2023 06:17:02 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t13-20020a7bc3cd000000b003fbaade072dsm2474749wmj.23.2023.07.07.06.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 06:17:01 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        dri-devel@lists.freedesktop.org, Ard Biesheuvel <ardb@kernel.org>,
        Helge Deller <deller@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH 1/4] vgacon: rework Kconfig dependencies
In-Reply-To: <20230707095415.1449376-1-arnd@kernel.org>
References: <20230707095415.1449376-1-arnd@kernel.org>
Date:   Fri, 07 Jul 2023 15:17:01 +0200
Message-ID: <87mt07yi7m.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

Hello Arnd,

> From: Arnd Bergmann <arnd@arndb.de>
>
> The list of dependencies here is phrased as an opt-out, but this is missing
> a lot of architectures that don't actually support VGA consoles, and some
> of the entries are stale:
>
>  - powerpc used to support VGA consoles in the old arch/ppc codebase, but
>    the merged arch/powerpc never did
>
>  - arm lists footbridge, integrator and netwinder, but netwinder is actually
>    part of footbridge, and integrator does not appear to have an actual
>    VGA hardware, or list it in its ATAG or DT.
>
>  - mips has a few platforms (jazz, sibyte, and sni) that initialize
>    screen_info, on everything else the console is selected but cannot
>    actually work.
>
>  - csky, hexgagon, loongarch, nios2, riscv and xtensa are not listed
>    in the opt-out table and declare a screen_info to allow building
>    vga_con, but this cannot work because the console is never selected.
>
> Replace this with an opt-in table that lists only the platforms that
> remain. This is effectively x86, plus a couple of historic workstation
> and server machines that reused parts of the x86 system architecture.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Both our explanation and changes look good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

