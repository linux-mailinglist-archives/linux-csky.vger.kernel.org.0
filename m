Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A8B759838
	for <lists+linux-csky@lfdr.de>; Wed, 19 Jul 2023 16:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231608AbjGSOZ0 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 19 Jul 2023 10:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbjGSOZJ (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 19 Jul 2023 10:25:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482E6268D
        for <linux-csky@vger.kernel.org>; Wed, 19 Jul 2023 07:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689776638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AYL0WxfELPHjwx6ZiDqavEiQQIijrcopNRfhrvLV03A=;
        b=Fy8i5nOuJc9vT64qGI1h402ACgpl6AB64fP+pSezsKXU7oX0ASaTIrY6cxryrL9cV8OvNU
        v0sIZeURGjZ3itQ6NPF0MFxRumgHZwjZfMTfec/c/ZD6nxw8e6l3CXc8VJBtqU8rK9ljTf
        QgQvU5p0Ucau8pjJq5qE+94Kp1SQ6E8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-AXwhDeu4P2O3U_64fsbleQ-1; Wed, 19 Jul 2023 10:23:56 -0400
X-MC-Unique: AXwhDeu4P2O3U_64fsbleQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-31701b27d19so394996f8f.1
        for <linux-csky@vger.kernel.org>; Wed, 19 Jul 2023 07:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689776635; x=1690381435;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYL0WxfELPHjwx6ZiDqavEiQQIijrcopNRfhrvLV03A=;
        b=H9Usbe2CR8b+pEu4FB1wRV3dHhUt77HJSfXMtDrqZZkWQHmBEurAo3p3E9bmMwZrSE
         ojdvxDuZ7C/W9rWUlV0oSEcOeaWx5VPCJN1D090QeWvmgQ2CGIXrl7WgPscsrAehR+kX
         iR6aHU11k18DHjANzI/8dup1oy4MbmiwxgmaY9pnVL8sFH+FQkXXlu1HbLSkt3Kxak62
         wgg8iyb0Ahrp3Dwss+n6DB4EFyOdcFqZfaBC4JT1aItosnP2wI8C/movQPb/ylrqQfAK
         ZYfyo2TdHOb45tPpbh8M8CiVFjQeL6VbMAOfNvG+TBrQ4tqGb2d/OCuDOzNHtdz9dkej
         RWKg==
X-Gm-Message-State: ABy/qLb6ENNLmp5CnfUWx/XuZv8HmuV9ac/If5EE5lMEX+/7P5V2whcy
        /hW3X0R6E+EenfJ2oylck4PNN3u6C2JDR6dAPh9mo8cAUllYZ6lJDzX/4T1FLSLw5d32OCP1zF2
        QOYvz4qsDVY2PZkaY4XnCuQ==
X-Received: by 2002:adf:f406:0:b0:317:15f5:a1cc with SMTP id g6-20020adff406000000b0031715f5a1ccmr41772wro.22.1689776635694;
        Wed, 19 Jul 2023 07:23:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHAuWaDn4wkaE25f0gFYugdobiggD0h46Z8p4U2s3LOHj24u3Bx+1zUs1XU1djJ3aSjiu0SQg==
X-Received: by 2002:adf:f406:0:b0:317:15f5:a1cc with SMTP id g6-20020adff406000000b0031715f5a1ccmr41757wro.22.1689776635405;
        Wed, 19 Jul 2023 07:23:55 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id q19-20020a056000137300b003143d80d11dsm5429196wrz.112.2023.07.19.07.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 07:23:54 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@quicinc.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Dexuan Cui <decui@microsoft.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Ren <guoren@kernel.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Khalid Aziz <khalid@gonehiking.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        WANG Xuerui <kernel@xen0n.name>, Wei Liu <wei.liu@kernel.org>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-hyperv@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 7/9] vga16fb: drop powerpc support
In-Reply-To: <20230719123944.3438363-8-arnd@kernel.org>
References: <20230719123944.3438363-1-arnd@kernel.org>
 <20230719123944.3438363-8-arnd@kernel.org>
Date:   Wed, 19 Jul 2023 16:23:53 +0200
Message-ID: <87a5vshtdy.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> I noticed that commit 0db5b61e0dc07 ("fbdev/vga16fb: Create
> EGA/VGA devices in sysfb code") broke vga16fb on non-x86 platforms,
> because the sysfb code never creates a vga-framebuffer device when
> screen_info.orig_video_isVGA is set to '1' instead of VIDEO_TYPE_VGAC.
>
> However, it turns out that the only architecture that has allowed
> building vga16fb in the past 20 years is powerpc, and this only worked
> on two 32-bit platforms and never on 64-bit powerpc. The last machine
> that actually used this was removed in linux-3.10, so this is all dead
> code and can be removed.
>
> The big-endian support in vga16fb.c could also be removed, but I'd just
> leave this in place.
>
> Fixes: 933ee7119fb14 ("powerpc: remove PReP platform")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

