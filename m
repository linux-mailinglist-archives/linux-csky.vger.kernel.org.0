Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D21613D6F4
	for <lists+linux-csky@lfdr.de>; Thu, 16 Jan 2020 10:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgAPJg5 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 16 Jan 2020 04:36:57 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:46037 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731359AbgAPJg4 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 16 Jan 2020 04:36:56 -0500
Received: by mail-io1-f65.google.com with SMTP id i11so20993949ioi.12
        for <linux-csky@vger.kernel.org>; Thu, 16 Jan 2020 01:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E7GfZJSrRM+ykUZPcCRYn9IFEFhtuET5zZHF20OLH9s=;
        b=bzU3txzlELF8ZSR1veWwsWkvrg86Dy0DyR/+RynLvoKYd5GLcKDReUj0MmHEYnIkjW
         z/dbWZ9Eqzy8UTqgulmAU+fW85mA+pgPUv/j8sazzGSqAOuMSDqox/WcnZwj0AIfGa/9
         NQEMiNU3NUjn1bMhnio1pWBBGmFpqwyUA5D2/wOJpRW82wvKa9rISekErucMHAmVa3qm
         cTz/kmtOT8ITbYpEhl2JMFTKWSaKcgCuI5ZNyLtCLxYU17XnobqTXzWt+CbnZqquNMId
         ylPnAK/DLCTKNPY9JhFoKIVKWCiIB4adUnQ5I8e+S1M3BnzviEdhvQfl78OoFviEZ40I
         MXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E7GfZJSrRM+ykUZPcCRYn9IFEFhtuET5zZHF20OLH9s=;
        b=jfikfgNHay1vk9h3VIsfI/1peoM1p0wqo/eCSsSXcptT79620IqJSFBqRsmJuppJ5K
         KcA8/nfBJyK5m/ArmsUmcojgBuuhhTo4jCqrLbpSp1IJjVa6VwYywgc/aQXGCdLZByYA
         VGQMz/du0sw5ADTStibBMec/4Gv8UOnzGQh+C8erCZgSCyvKXVxTnfqrOESM3iCH8hwv
         L6F8n57+SZye0pAdI/Ikty9N4Zs8HfCLEh2KHg0tVvEmuc1bJyL9WWkv01OyMNbDLU8d
         AgRSA+La7emDDN5yA52dS5afxyVRl5IyoxHlJNCV8t7doI0MbX6CpZnRn4/f/MzlQCFM
         Hq9g==
X-Gm-Message-State: APjAAAWlz73yTOZlVM/TNOjUB7rdOfx3Wu1tIM+z/Kh9leTVq6SJlVE0
        zyUCXsz0lz3wJESvkZjoH0JtpVpdYZc0dkXIPNRM64qd
X-Google-Smtp-Source: APXvYqyKMCWTScxcgoKmumdGxUeQvxVL5FvLpWdV5zMMquUy71rLtSO5W5Gg2olCibZO21yqRVCEnDjeGbCjMOeeMHY=
X-Received: by 2002:a6b:680d:: with SMTP id d13mr24792480ioc.188.1579167415823;
 Thu, 16 Jan 2020 01:36:55 -0800 (PST)
MIME-Version: 1.0
References: <1577937441-18703-1-git-send-email-han_mao@c-sky.com>
 <CAAXf6LUVA4QkSmz8OaSOyqzKaw--eD5r0zAD+zONfyGROv1MZw@mail.gmail.com> <20200113033451.GA15150@vmh-VirtualBox>
In-Reply-To: <20200113033451.GA15150@vmh-VirtualBox>
From:   Thomas De Schampheleire <patrickdepinguin@gmail.com>
Date:   Thu, 16 Jan 2020 10:36:45 +0100
Message-ID: <CAAXf6LWZZKCW=g=ReXz00hLJSiBw6sJfsmSxu0=Q_J4FVda32g@mail.gmail.com>
Subject: Re: [Buildroot] [PATCH 1/2] package/toolchain-external: ensure
 ARCH_LIB_DIR exist
To:     Mao Han <han_mao@c-sky.com>
Cc:     buildroot <buildroot@buildroot.org>, xianmiao_qu@c-sky.com,
        ren_guo@c-sky.com, linux-csky@vger.kernel.org,
        hongdeng_chen@c-sky.com, thomas.petazzoni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Hello Mao Han,

El lun., 13 ene. 2020 a las 4:39, Mao Han (<han_mao@c-sky.com>) escribi=C3=
=B3:
>
> Hi,
> On Fri, Jan 10, 2020 at 11:57:00AM +0100, Thomas De Schampheleire wrote:
> > Hello,
> >
> > El jue., 2 ene. 2020 a las 5:15, Mao Han (<han_mao@c-sky.com>) escribi=
=C3=B3:
> > >
> > > Different architecture may have different arch library folder structu=
re
> > > for their multilib toolchain. RISC-V toolchain has folder structure
> > > like:
> > > /sysroot/lib64/
> > > /sysroot/lib64/lp64
> > > /sysroot/lib64/lp64d
> > > The first level is for ISA and the second level is for ABI.
> > > Current buildroot only creat lib and lib64, some error is reported
> > > while installing the external toolchain:
> > > >>> toolchain-external-custom  Installing to staging directory
> > > /usr/bin/install -D -m 0755 /.../build/toolchain-external-custom/tool=
chain-wrapper /.../host/bin/toolchain-wrapper
> > > ln: failed to create symbolic link '/.../host/riscv64-buildroot-linux=
-gnu/sysroot/lib64/lp64': No such file or directory
> > > ln: failed to create symbolic link '/.../host/riscv64-buildroot-linux=
-gnu/sysroot/usr/lib64/lp64': No such file or directory
> > >
> > > Signed-off-by: Qu Xianmiao <xianmiao_qu@c-sky.com>
> > > Signed-off-by: Chen Hongdeng <hongdeng_chen@c-sky.com>
> > > Signed-off-by: Guo Ren<ren_guo@c-sky.com>
> > > Signed-off-by: Mao Han <han_mao@c-sky.com>
> > > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > > Cc: Mark Corbin <mark.corbin@embecosm.com>
> > > ---
> > >  toolchain/toolchain-external/pkg-toolchain-external.mk | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/toolchain/toolchain-external/pkg-toolchain-external.mk b=
/toolchain/toolchain-external/pkg-toolchain-external.mk
> > > index baf719a..13b2468 100644
> > > --- a/toolchain/toolchain-external/pkg-toolchain-external.mk
> > > +++ b/toolchain/toolchain-external/pkg-toolchain-external.mk
> > > @@ -454,6 +454,8 @@ create_lib_symlinks =3D \
> > >         ARCH_LIB_DIR=3D"$(call toolchain_find_libdir,$(TOOLCHAIN_EXTE=
RNAL_CC) $(TOOLCHAIN_EXTERNAL_CFLAGS))" ; \
> > >         if [ ! -e "$${DESTDIR}/$${ARCH_LIB_DIR}" -a ! -e "$${DESTDIR}=
/usr/$${ARCH_LIB_DIR}" ]; then \
> > >                 relpath=3D"$(call relpath_prefix,$${ARCH_LIB_DIR})" ;=
 \
> > > +               mkdir -p "$${DESTDIR}/$${ARCH_LIB_DIR}" ; \
> > > +               mkdir -p "$${DESTDIR}/usr/$${ARCH_LIB_DIR}" ; \
> > >                 ln -snf $${relpath}lib "$${DESTDIR}/$${ARCH_LIB_DIR}"=
 ; \
> > >                 ln -snf $${relpath}lib "$${DESTDIR}/usr/$${ARCH_LIB_D=
IR}" ; \
> >
> > This is not correct.
> >
> > The purpose of this code is to create a symbolic link named according
> > to 'ARCH_LIB_DIR' inside DESTDIR and DESTDIR/usr.
> > It is not the purpose to create a symbolic link called 'lib' inside a
> > directory DESTDIR/ARCH_LIB_DIR.
> > The change you made is creating a _directory_ ARCH_LIB_DIR while it
> > should be a _symbolic link_.
> >
>
> Yes, I misunderstood the option -f as it will only remove the symbol
> file not the directory.
> The path sysroot/lib64 is relinked to sysroot/lib after the external
> tool installation, all the libraries are copied to sysroot/lib/lp64d.
> The toolchain can find it's corresponding library, so I don't notice
> the mistake.
>
> If I change the code like:
> mkdir -p `dirname "$${DESTDIR}/$${ARCH_LIB_DIR}"` ; \
> mkdir -p `dirname "$${DESTDIR}/usr/$${ARCH_LIB_DIR}"` ; \
>
> Two symbol links are created:
> sysroot/:lib64 -> lib
> sysroot/lib: lp64d -> ../lib
> The libraries are under: lib, lib64, lib64/lp64d ...
>
> > Could you please clarify what is the value of ARCH_LIB_DIR in your case=
?
> >
> > And could you clarify which part of the path is missing?
> > '/.../host/riscv64-buildroot-linux-gnu/sysroot/lib64/lp64' ?
> > I assume that the 'lib64' part is missing?
> >
>
> Yes, "lib64" is the missing part. It can be some other value like
> "lib64xthead" when the extension is different.
>
> > Finally, please provide a defconfig that allows to reproduce and test
> > this problem.
> >
>
> The defconfig is attached. And the toolchain I used comes from:
> https://github.com/riscv/riscv-gnu-toolchain
>
> make with:
> git clone https://github.com/riscv/riscv-gnu-toolchain
> cd riscv-gnu-toolchain
> git submodule update --init --recursive
> ./configure --prefix=3D/opt/riscv --enable-multilib
> make linux
>
> I can't provide the toolchain binary as it is quite large, and
> the network is also limited.
>

I compiled the riscv toolchain as instructed, and applied your config
(note: it was a full config, not a defconfig). The defconfig is:

BR2_riscv=3Dy
BR2_TOOLCHAIN_EXTERNAL=3Dy
BR2_TOOLCHAIN_EXTERNAL_PATH=3D"/opt/riscv"
BR2_TOOLCHAIN_EXTERNAL_CUSTOM_PREFIX=3D"$(ARCH)-unknown-linux-gnu"
BR2_TOOLCHAIN_EXTERNAL_HEADERS_5_0=3Dy
BR2_TOOLCHAIN_EXTERNAL_CUSTOM_GLIBC=3Dy
BR2_TOOLCHAIN_EXTERNAL_CXX=3Dy
BR2_TARGET_GENERIC_GETTY_PORT=3D"ttyS0"
BR2_SYSTEM_DHCP=3D"eth0"
BR2_LINUX_KERNEL=3Dy
BR2_LINUX_KERNEL_CUSTOM_VERSION=3Dy
BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE=3D"5.1.12"
BR2_LINUX_KERNEL_USE_ARCH_DEFAULT_CONFIG=3Dy
BR2_TARGET_ROOTFS_EXT2=3Dy
BR2_TARGET_OPENSBI=3Dy
BR2_TARGET_OPENSBI_PLAT=3D"qemu/virt"
BR2_PACKAGE_HOST_QEMU=3Dy
BR2_PACKAGE_HOST_QEMU_SYSTEM_MODE=3Dy

Using this config, I do not see the same error as you. The toolchain
seems to install correctly (note: later we will notice it does not;
see below), but I do get an error later when busybox is compiled:

...
  CC      libbb/xregcomp.o
  AR      libbb/lib.a
  LINK    busybox_unstripped
Your linker does not support --sort-section,alignment
Your linker does not support --sort-common
Your linker does not support -Wl,--gc-sections
Trying libraries: m resolv
Failed: -Wl,--start-group  -lm -lresolv  -Wl,--end-group
Output of:
/home/tdescham/repo/contrib/buildroot/output/host/bin/riscv64-unknown-linux=
-gnu-gcc
-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=3D64 -Os
-Wall -Wshadow -Wwrite-strings -Wundef -Wstrict-prototypes -Wunused
-Wunused-parameter -Wunused-function -Wunused-value
-Wmissing-prototypes -Wmissing-declarations -Wno-format-security
-Wdeclaration-after-statement -Wold-style-definition
-fno-builtin-strlen -finline-limit=3D0 -fomit-frame-pointer
-ffunction-sections -fdata-sections -fno-guess-branch-probability
-funsigned-char -static-libgcc -falign-functions=3D1 -falign-jumps=3D1
-falign-labels=3D1 -falign-loops=3D1 -fno-unwind-tables
-fno-asynchronous-unwind-tables -fno-builtin-printf -Os -o
busybox_unstripped -Wl,--start-group applets/built-in.o archival/lib.a
archival/libarchive/lib.a console-tools/lib.a coreutils/lib.a
coreutils/libcoreutils/lib.a debianutils/lib.a klibc-utils/lib.a
e2fsprogs/lib.a editors/lib.a findutils/lib.a init/lib.a libbb/lib.a
libpwdgrp/lib.a loginutils/lib.a mailutils/lib.a miscutils/lib.a
modutils/lib.a networking/lib.a networking/libiproute/lib.a
networking/udhcp/lib.a printutils/lib.a procps/lib.a runit/lib.a
selinux/lib.a shell/lib.a sysklogd/lib.a util-linux/lib.a
util-linux/volume_id/lib.a archival/built-in.o
archival/libarchive/built-in.o console-tools/built-in.o
coreutils/built-in.o coreutils/libcoreutils/built-in.o
debianutils/built-in.o klibc-utils/built-in.o e2fsprogs/built-in.o
editors/built-in.o findutils/built-in.o init/built-in.o
libbb/built-in.o libpwdgrp/built-in.o loginutils/built-in.o
mailutils/built-in.o miscutils/built-in.o modutils/built-in.o
networking/built-in.o networking/libiproute/built-in.o
networking/udhcp/built-in.o printutils/built-in.o procps/built-in.o
runit/built-in.o selinux/built-in.o shell/built-in.o
sysklogd/built-in.o util-linux/built-in.o
util-linux/volume_id/built-in.o -Wl,--end-group -Wl,--start-group -lm
-lresolv -Wl,--end-group
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
/home/tdescham/repo/contrib/riscv/lib/gcc/riscv64-unknown-linux-gnu/9.2.0/.=
./../../../riscv64-unknown-linux-gnu/bin/ld:
coreutils/lib.a(mktemp.o): in function `.L5':
mktemp.c:(.text.mktemp_main+0xb4): warning: the use of `mktemp' is
dangerous, better use `mkstemp' or `mkdtemp'
/home/tdescham/repo/contrib/riscv/lib/gcc/riscv64-unknown-linux-gnu/9.2.0/.=
./../../../riscv64-unknown-linux-gnu/bin/ld:
cannot find /lib/ld-linux-riscv64-lp64d.so.1 inside
/home/tdescham/repo/contrib/buildroot/output/host/riscv64-buildroot-linux-g=
nu/sysroot
collect2: error: ld returned 1 exit status
Note: if build needs additional libraries, put them in CONFIG_EXTRA_LDLIBS.
Example: CONFIG_EXTRA_LDLIBS=3D"pthread dl tirpc audit pam"
make[1]: *** [Makefile:718: busybox_unstripped] Error 1
make[1]: Leaving directory
'/home/tdescham/repo/contrib/buildroot/output/build/busybox-1.31.1'
make: *** [package/pkg-generic.mk:260:
/home/tdescham/repo/contrib/buildroot/output/build/busybox-1.31.1/.stamp_bu=
ilt]
Error 2


So the actual error here is:
/home/tdescham/repo/contrib/riscv/lib/gcc/riscv64-unknown-linux-gnu/9.2.0/.=
./../../../riscv64-unknown-linux-gnu/bin/ld:
cannot find /lib/ld-linux-riscv64-lp64d.so.1 inside
/home/tdescham/repo/contrib/buildroot/output/host/riscv64-buildroot-linux-g=
nu/sysroot
collect2: error: ld returned 1 exit status

At this point, the situation in the buildroot sysroot is:

$ ls -l output/host/riscv64-buildroot-linux-gnu/sysroot/
total 56
drwxr-xr-x 2 tdescham tdescham 4096 Jan 16 10:05 bin/
drwxr-xr-x 2 tdescham tdescham 4096 May  7  2019 dev/
drwxr-xr-x 3 tdescham tdescham 4096 Jan 15 21:58 etc/
drwxr-xr-x 2 tdescham tdescham 4096 Jan 16 08:48 lib/
lrwxrwxrwx 1 tdescham tdescham    3 Jan 16 10:05 lib64 -> lib/
drwxr-xr-x 2 tdescham tdescham 4096 May 28  2014 media/
drwxr-xr-x 2 tdescham tdescham 4096 May 28  2014 mnt/
drwxr-xr-x 2 tdescham tdescham 4096 May 28  2014 opt/
drwxr-xr-x 2 tdescham tdescham 4096 May 28  2014 proc/
drwxr-xr-x 2 tdescham tdescham 4096 Jan 25  2017 root/
drwxr-xr-x 2 tdescham tdescham 4096 Feb  2  2016 run/
drwxr-xr-x 2 tdescham tdescham 4096 Jan 15 21:58 sbin/
drwxr-xr-x 2 tdescham tdescham 4096 May 28  2014 sys/
drwxr-xr-x 2 tdescham tdescham 4096 May 28  2014 tmp/
drwxr-xr-x 8 tdescham tdescham 4096 Jan 15 21:57 usr/

$ ls -l output/host/riscv64-buildroot-linux-gnu/sysroot/lib/lp64d
lrwxrwxrwx 1 tdescham tdescham 6 Jan 16 10:05
output/host/riscv64-buildroot-linux-gnu/sysroot/lib/lp64d -> ../lib/

and there is no ld-linux* file found anywhere, indeed.

Looking at the output of the toolchain installation, there was an error:
>>> toolchain-external-custom  Copying external toolchain sysroot to stagin=
g...
/bin/sh: line 0: [: too many arguments

which is caused by the fact that there are multiple 'ld*' matches:
(extra traces added)

SYSROOT_DIR=3D/home/tdescham/repo/contrib/riscv/sysroot/
ARCH_SYSROOT_DIR=3D/home/tdescham/repo/contrib/riscv/sysroot/
ARCH_SUBDIR=3D
ARCH_LIB_DIR=3Dlib64/lp64d
SUPPORT_LIB_DIR=3D
no ld found yet @@@@@@@@@@@@
/home/tdescham/repo/contrib/riscv/sysroot//lib/ld-linux-riscv32-ilp32d.so.1
/home/tdescham/repo/contrib/riscv/sysroot//lib/ld-linux-riscv32-ilp32.so.1
/home/tdescham/repo/contrib/riscv/sysroot//lib/ld-linux-riscv64-lp64d.so.1
/home/tdescham/repo/contrib/riscv/sysroot//lib/ld-linux-riscv64-lp64.so.1
/bin/sh: line 0: [: too many arguments
done no ld found @@@@@@@@@@@@

Corresponding to this code:

    if [ ! -e $(STAGING_DIR)/lib/ld*.so.* ]; then \
        echo "no ld found yet @@@@@@@@@@@@"; \
        ls $${ARCH_SYSROOT_DIR}/lib/ld*.so.* ; \
        if [ -e $${ARCH_SYSROOT_DIR}/lib/ld*.so.* ]; then \
            echo "ld found in arch_sysroot_dir @@@@@@@@@@@@@"; \
            cp -a $${ARCH_SYSROOT_DIR}/lib/ld*.so.* $(STAGING_DIR)/lib/ ; \
        fi ; \
        echo "done no ld found @@@@@@@@@@@@" ; \
    fi ; \


I'm not yet sure how this should be solved...

Best regards,
Thomas
