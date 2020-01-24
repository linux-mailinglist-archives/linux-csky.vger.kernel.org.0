Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBB19148AD8
	for <lists+linux-csky@lfdr.de>; Fri, 24 Jan 2020 16:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388610AbgAXPAK (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 24 Jan 2020 10:00:10 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:42810 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387432AbgAXPAK (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 24 Jan 2020 10:00:10 -0500
Received: by mail-io1-f67.google.com with SMTP id n11so2250552iom.9
        for <linux-csky@vger.kernel.org>; Fri, 24 Jan 2020 07:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0cMDA7ixDAItFVnfN12x2yszCpBRnES9SQCg8kr6vIE=;
        b=RmWszcypB/S26IK0PcpVdR4tmSoXQyb0Mo9tkrqOvzFrAXM1DmFLXB0qHxrUoL9BcZ
         YJgPSlOX/vBKdvXWqHsH5nd54+XzwYfteHw5nn92TSHn915WYYQZJeUe0VFtVESBt66E
         m4pFBmI8+fBO1XvxHDUOBZ8aipHrxfRactfRA0uyrlRlg9YoFUi11pVcjdxl/8J6WUrD
         mSKI5iTXQuYFCTorunXMIPXEYewkNSdWEeOiadYJJq8jL1r3Of8L2yiv4QtDHF01m86Z
         7qbjl+nOkWfcC4KXA7BrVn5Ns8cOVfnJDhTVgqnf+7DCcRU896ltU2bZFeUQ1nZj89xT
         2gOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0cMDA7ixDAItFVnfN12x2yszCpBRnES9SQCg8kr6vIE=;
        b=q6AtxktaAokOfQE94sfNxBC/MpI5lVS95zZiwxYiQcQ4X1ag461OVczQ7cI9Z7RTMR
         Eu1EWbXwq1CBnUlZGqJPurZS6fUbaaUYlq3ovZlEqKkwZB8+1VVx7yVtBqBRG6kj6FLL
         ufmhx5+GaAOR+x43fDxfD7u+VD3DJrW9XKllSGkxLbcZqlCOL5G+FWagosNqj4xVFhTr
         03Nc/AUM79GOylcbwdsMBZG3oTWC+bQEQUg1JojcKzx92HH1dMmwauos/mp024e2L78o
         0AJ65Wlfq3AfefnDgwb6SGRiKSEL+R/nPndt64SE/Tr9EX4b7aLfepByailGgmVaeH/v
         xJYg==
X-Gm-Message-State: APjAAAWdbyxwDgMr6Z1Lh8x1OpMA4RN8XkgtDyjK5UIUyJi/mRNUc7CS
        k5lKtmb64aD/UbVOVEzp4T60FBkbac0Q4zkILVI35rtJMdo=
X-Google-Smtp-Source: APXvYqyJsAdlV0/TrA5X6TYb4X/l8bu8C0gaht1J3Nxsg7djt0s6oTDkok72ULpj7Y4GO6FpXPYusIyO7YEuJTxoldY=
X-Received: by 2002:a02:7f54:: with SMTP id r81mr2886580jac.121.1579878009159;
 Fri, 24 Jan 2020 07:00:09 -0800 (PST)
MIME-Version: 1.0
References: <1577937441-18703-1-git-send-email-han_mao@c-sky.com>
 <CAAXf6LUVA4QkSmz8OaSOyqzKaw--eD5r0zAD+zONfyGROv1MZw@mail.gmail.com>
 <20200113033451.GA15150@vmh-VirtualBox> <CAAXf6LWZZKCW=g=ReXz00hLJSiBw6sJfsmSxu0=Q_J4FVda32g@mail.gmail.com>
 <20200117023547.GA12999@vmh-VirtualBox>
In-Reply-To: <20200117023547.GA12999@vmh-VirtualBox>
From:   Thomas De Schampheleire <patrickdepinguin@gmail.com>
Date:   Fri, 24 Jan 2020 16:00:04 +0100
Message-ID: <CAAXf6LV-f9o_9oY4+Me4qHRJeQhCWA75H1GOEYMoRPu5j4m-Jg@mail.gmail.com>
Subject: Re: [Buildroot] [PATCH 1/2] package/toolchain-external: ensure
 ARCH_LIB_DIR exist
To:     Mao Han <han_mao@c-sky.com>
Cc:     xianmiao_qu@c-sky.com, buildroot <buildroot@buildroot.org>,
        ren_guo@c-sky.com, linux-csky@vger.kernel.org,
        hongdeng_chen@c-sky.com, thomas.petazzoni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Hi Mao Han,

El vie., 17 ene. 2020 a las 3:35, Mao Han (<han_mao@c-sky.com>) escribi=C3=
=B3:
[..]
> >
> > I compiled the riscv toolchain as instructed, and applied your config
> > (note: it was a full config, not a defconfig). The defconfig is:
> >
> > BR2_riscv=3Dy
> > BR2_TOOLCHAIN_EXTERNAL=3Dy
> > BR2_TOOLCHAIN_EXTERNAL_PATH=3D"/opt/riscv"
> > BR2_TOOLCHAIN_EXTERNAL_CUSTOM_PREFIX=3D"$(ARCH)-unknown-linux-gnu"
> > BR2_TOOLCHAIN_EXTERNAL_HEADERS_5_0=3Dy
> > BR2_TOOLCHAIN_EXTERNAL_CUSTOM_GLIBC=3Dy
> > BR2_TOOLCHAIN_EXTERNAL_CXX=3Dy
> > BR2_TARGET_GENERIC_GETTY_PORT=3D"ttyS0"
> > BR2_SYSTEM_DHCP=3D"eth0"
> > BR2_LINUX_KERNEL=3Dy
> > BR2_LINUX_KERNEL_CUSTOM_VERSION=3Dy
> > BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE=3D"5.1.12"
> > BR2_LINUX_KERNEL_USE_ARCH_DEFAULT_CONFIG=3Dy
> > BR2_TARGET_ROOTFS_EXT2=3Dy
> > BR2_TARGET_OPENSBI=3Dy
> > BR2_TARGET_OPENSBI_PLAT=3D"qemu/virt"
> > BR2_PACKAGE_HOST_QEMU=3Dy
> > BR2_PACKAGE_HOST_QEMU_SYSTEM_MODE=3Dy
> >
> > Using this config, I do not see the same error as you. The toolchain
> > seems to install correctly (note: later we will notice it does not;
> > see below), but I do get an error later when busybox is compiled:
> >
>
> The problem is originally occurs on a non-public released toolchain
> with a sysroot folder structure like:
> sysroot/lib64xthead/lp64d
> and I tried to reproduce with a public RISC-V toolchain, and got
> similar error weeks ago.
> I retried with the toolchains yesterday, the error is only reproduced
> with the internal one. There might be something wrong with my
> previous operation.
>
[..]
> > I'm not yet sure how this should be solved...
>
> There is another patch in the same thread:
> [PATCH 2/2] toolchain: Get ld.so name if available
> http://buildroot-busybox.2317881.n4.nabble.com/PATCH-1-2-package-toolchai=
n-external-ensure-ARCH-LIB-DIR-exist-td243604.html#a244193
> Tried to get the corresponding ld.so name with certain configuration.
>

Thanks. Using this patch '[PATCH 2/2] toolchain: Get ld.so name if
available' I actually can compile correctly.
So, PATCH 1/2 is not actually needed.

Do you agree that only PATCH 2/2 is required?
If so I will perform a more thorough review of that patch.

Thanks,
Thomas
