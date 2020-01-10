Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE32C136B6B
	for <lists+linux-csky@lfdr.de>; Fri, 10 Jan 2020 11:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgAJKxC (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 10 Jan 2020 05:53:02 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40534 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727697AbgAJKxC (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 10 Jan 2020 05:53:02 -0500
Received: by mail-il1-f193.google.com with SMTP id c4so1442392ilo.7
        for <linux-csky@vger.kernel.org>; Fri, 10 Jan 2020 02:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g3ir94S3eKjPhHAENWTkvRIu2waN8be8SE0RRzBs5c0=;
        b=gdB5ymF34zBPnTP79OOR+F0NJVTiwDemAbOUYHmjEy2fhNprl9J1TyL3jay73n3HEz
         G3e8kHE1kFcIsNZhhTlb9I5NCHVfuUGFzxQow89JVa5OrwSLPHWil1Y8/huXh6ovBQzM
         WV4rrusuo/k4km4g4sf0mr0vmhCopjopDnlerUtTm6LoOB+dq3jNudBfApTye3kbiww9
         OtkooHRrHHHL6cjtCOwEbpHgtF8ePoUfLGLgeiFu/3oA+rCaNuaio5N9jzOAqFf86euQ
         WE7uQfvzYQ5oULZlYBOkzxO4qNEOFdZzwZvTfNvBLkaniY88voOkNiPJh/CNzUMuVINv
         Hpdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g3ir94S3eKjPhHAENWTkvRIu2waN8be8SE0RRzBs5c0=;
        b=IsVyl6VpLuGrZQUUJwgdmuBqymHPcqa/OqOo6elSSjt/udw/NVKQkzT7VBJtIvlj+J
         IPvHhGrXJU1qVkq/ayvDsq/Z0dyFuUS9XSjQYjFHBiG0iOqLu7uRacaieFTtqThJWHvr
         CPzjEpn9tmE2HEuVZXCoRT0Sp2nJSCqrRG9L3/q1ztHDYHOBIbWXWzu9OEjHgrXzSaMk
         wM8rhe9+gHa4CEVOkypzpHYl5zIV8PmIOiv/iuixj0pCEl2TpED7+mG8sH+ixo0W9/Vz
         7IsD5VgbzfvTHMqunFU886eZ+NwJldiGeI5xnMshHvc79KhIqBw1o0Jip/XgLgqxuXS0
         /XDg==
X-Gm-Message-State: APjAAAXqkACBS0Rkx/i/mhCQsXU28+0Z4G/By+hVyfd1fVP7F0+UNizI
        ik2mlrhK8+t25Y6/Ls9FOvm6VNiJncYrEKSkoVE=
X-Google-Smtp-Source: APXvYqwWsjyewgOz1GqvaVqw3UB9QWm67fyRgJbQGrga5iu1uPuPMrh++5YQPV/DNd+c5l7yNcU+p7MTQwWOvp83ETE=
X-Received: by 2002:a92:1d95:: with SMTP id g21mr1755290ile.291.1578653581887;
 Fri, 10 Jan 2020 02:53:01 -0800 (PST)
MIME-Version: 1.0
References: <1577937441-18703-1-git-send-email-han_mao@c-sky.com>
In-Reply-To: <1577937441-18703-1-git-send-email-han_mao@c-sky.com>
From:   Thomas De Schampheleire <patrickdepinguin@gmail.com>
Date:   Fri, 10 Jan 2020 11:57:00 +0100
Message-ID: <CAAXf6LUVA4QkSmz8OaSOyqzKaw--eD5r0zAD+zONfyGROv1MZw@mail.gmail.com>
Subject: Re: [Buildroot] [PATCH 1/2] package/toolchain-external: ensure
 ARCH_LIB_DIR exist
To:     Mao Han <han_mao@c-sky.com>
Cc:     buildroot <buildroot@buildroot.org>,
        Qu Xianmiao <xianmiao_qu@c-sky.com>,
        Guo Ren <ren_guo@c-sky.com>,
        Mark Corbin <mark.corbin@embecosm.com>,
        linux-csky@vger.kernel.org,
        Chen Hongdeng <hongdeng_chen@c-sky.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Hello,

El jue., 2 ene. 2020 a las 5:15, Mao Han (<han_mao@c-sky.com>) escribi=C3=
=B3:
>
> Different architecture may have different arch library folder structure
> for their multilib toolchain. RISC-V toolchain has folder structure
> like:
> /sysroot/lib64/
> /sysroot/lib64/lp64
> /sysroot/lib64/lp64d
> The first level is for ISA and the second level is for ABI.
> Current buildroot only creat lib and lib64, some error is reported
> while installing the external toolchain:
> >>> toolchain-external-custom  Installing to staging directory
> /usr/bin/install -D -m 0755 /.../build/toolchain-external-custom/toolchai=
n-wrapper /.../host/bin/toolchain-wrapper
> ln: failed to create symbolic link '/.../host/riscv64-buildroot-linux-gnu=
/sysroot/lib64/lp64': No such file or directory
> ln: failed to create symbolic link '/.../host/riscv64-buildroot-linux-gnu=
/sysroot/usr/lib64/lp64': No such file or directory
>
> Signed-off-by: Qu Xianmiao <xianmiao_qu@c-sky.com>
> Signed-off-by: Chen Hongdeng <hongdeng_chen@c-sky.com>
> Signed-off-by: Guo Ren<ren_guo@c-sky.com>
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: Mark Corbin <mark.corbin@embecosm.com>
> ---
>  toolchain/toolchain-external/pkg-toolchain-external.mk | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/toolchain/toolchain-external/pkg-toolchain-external.mk b/too=
lchain/toolchain-external/pkg-toolchain-external.mk
> index baf719a..13b2468 100644
> --- a/toolchain/toolchain-external/pkg-toolchain-external.mk
> +++ b/toolchain/toolchain-external/pkg-toolchain-external.mk
> @@ -454,6 +454,8 @@ create_lib_symlinks =3D \
>         ARCH_LIB_DIR=3D"$(call toolchain_find_libdir,$(TOOLCHAIN_EXTERNAL=
_CC) $(TOOLCHAIN_EXTERNAL_CFLAGS))" ; \
>         if [ ! -e "$${DESTDIR}/$${ARCH_LIB_DIR}" -a ! -e "$${DESTDIR}/usr=
/$${ARCH_LIB_DIR}" ]; then \
>                 relpath=3D"$(call relpath_prefix,$${ARCH_LIB_DIR})" ; \
> +               mkdir -p "$${DESTDIR}/$${ARCH_LIB_DIR}" ; \
> +               mkdir -p "$${DESTDIR}/usr/$${ARCH_LIB_DIR}" ; \
>                 ln -snf $${relpath}lib "$${DESTDIR}/$${ARCH_LIB_DIR}" ; \
>                 ln -snf $${relpath}lib "$${DESTDIR}/usr/$${ARCH_LIB_DIR}"=
 ; \

This is not correct.

The purpose of this code is to create a symbolic link named according
to 'ARCH_LIB_DIR' inside DESTDIR and DESTDIR/usr.
It is not the purpose to create a symbolic link called 'lib' inside a
directory DESTDIR/ARCH_LIB_DIR.
The change you made is creating a _directory_ ARCH_LIB_DIR while it
should be a _symbolic link_.

Could you please clarify what is the value of ARCH_LIB_DIR in your case?

And could you clarify which part of the path is missing?
'/.../host/riscv64-buildroot-linux-gnu/sysroot/lib64/lp64' ?
I assume that the 'lib64' part is missing?

Finally, please provide a defconfig that allows to reproduce and test
this problem.

Thanks,
Thomas
