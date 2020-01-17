Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED6391401FD
	for <lists+linux-csky@lfdr.de>; Fri, 17 Jan 2020 03:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbgAQCfz (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 16 Jan 2020 21:35:55 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:60477 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388992AbgAQCfz (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Thu, 16 Jan 2020 21:35:55 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436282|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0882262-0.00172096-0.910053;DS=CONTINUE|ham_regular_dialog|0.746479-0.00133968-0.252181;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03307;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.GdRlLok_1579228549;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.GdRlLok_1579228549)
          by smtp.aliyun-inc.com(10.147.40.233);
          Fri, 17 Jan 2020 10:35:49 +0800
Date:   Fri, 17 Jan 2020 10:35:47 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     Thomas De Schampheleire <patrickdepinguin@gmail.com>
Cc:     xianmiao_qu@c-sky.com, buildroot@buildroot.org, ren_guo@c-sky.com,
        linux-csky@vger.kernel.org, hongdeng_chen@c-sky.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [Buildroot] [PATCH 1/2] package/toolchain-external: ensure
 ARCH_LIB_DIR exist
Message-ID: <20200117023547.GA12999@vmh-VirtualBox>
References: <1577937441-18703-1-git-send-email-han_mao@c-sky.com>
 <CAAXf6LUVA4QkSmz8OaSOyqzKaw--eD5r0zAD+zONfyGROv1MZw@mail.gmail.com>
 <20200113033451.GA15150@vmh-VirtualBox>
 <CAAXf6LWZZKCW=g=ReXz00hLJSiBw6sJfsmSxu0=Q_J4FVda32g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXf6LWZZKCW=g=ReXz00hLJSiBw6sJfsmSxu0=Q_J4FVda32g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

I'v replied the email yesterday, but I can't find it in the mailist.
So just resend one.

Hi Thomas,
On Thu, Jan 16, 2020 at 10:36:45AM +0100, Thomas De Schampheleire wrote:
> Hello Mao Han,
> 
> El lun., 13 ene. 2020 a las 4:39, Mao Han (<han_mao@c-sky.com>) escribió:
> >
> > Hi,
> > On Fri, Jan 10, 2020 at 11:57:00AM +0100, Thomas De Schampheleire wrote:
> > > Hello,
> > >
> > > El jue., 2 ene. 2020 a las 5:15, Mao Han (<han_mao@c-sky.com>) escribió:
> > > >
> > > > Different architecture may have different arch library folder structure
> > > > for their multilib toolchain. RISC-V toolchain has folder structure
> > > > like:
> > > > /sysroot/lib64/
> > > > /sysroot/lib64/lp64
> > > > /sysroot/lib64/lp64d
> > > > The first level is for ISA and the second level is for ABI.
> > > > Current buildroot only creat lib and lib64, some error is reported
> > > > while installing the external toolchain:
> > > > >>> toolchain-external-custom  Installing to staging directory
> > > > /usr/bin/install -D -m 0755 /.../build/toolchain-external-custom/toolchain-wrapper /.../host/bin/toolchain-wrapper
> > > > ln: failed to create symbolic link '/.../host/riscv64-buildroot-linux-gnu/sysroot/lib64/lp64': No such file or directory
> > > > ln: failed to create symbolic link '/.../host/riscv64-buildroot-linux-gnu/sysroot/usr/lib64/lp64': No such file or directory
> > > >
> > > > Signed-off-by: Qu Xianmiao <xianmiao_qu@c-sky.com>
> > > > Signed-off-by: Chen Hongdeng <hongdeng_chen@c-sky.com>
> > > > Signed-off-by: Guo Ren<ren_guo@c-sky.com>
> > > > Signed-off-by: Mao Han <han_mao@c-sky.com>
> > > > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > > > Cc: Mark Corbin <mark.corbin@embecosm.com>
> > > > ---
> > > >  toolchain/toolchain-external/pkg-toolchain-external.mk | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/toolchain/toolchain-external/pkg-toolchain-external.mk b/toolchain/toolchain-external/pkg-toolchain-external.mk
> > > > index baf719a..13b2468 100644
> > > > --- a/toolchain/toolchain-external/pkg-toolchain-external.mk
> > > > +++ b/toolchain/toolchain-external/pkg-toolchain-external.mk
> > > > @@ -454,6 +454,8 @@ create_lib_symlinks = \
> > > >         ARCH_LIB_DIR="$(call toolchain_find_libdir,$(TOOLCHAIN_EXTERNAL_CC) $(TOOLCHAIN_EXTERNAL_CFLAGS))" ; \
> > > >         if [ ! -e "$${DESTDIR}/$${ARCH_LIB_DIR}" -a ! -e "$${DESTDIR}/usr/$${ARCH_LIB_DIR}" ]; then \
> > > >                 relpath="$(call relpath_prefix,$${ARCH_LIB_DIR})" ; \
> > > > +               mkdir -p "$${DESTDIR}/$${ARCH_LIB_DIR}" ; \
> > > > +               mkdir -p "$${DESTDIR}/usr/$${ARCH_LIB_DIR}" ; \
> > > >                 ln -snf $${relpath}lib "$${DESTDIR}/$${ARCH_LIB_DIR}" ; \
> > > >                 ln -snf $${relpath}lib "$${DESTDIR}/usr/$${ARCH_LIB_DIR}" ; \
> > >
> > > This is not correct.
> > >
> > > The purpose of this code is to create a symbolic link named according
> > > to 'ARCH_LIB_DIR' inside DESTDIR and DESTDIR/usr.
> > > It is not the purpose to create a symbolic link called 'lib' inside a
> > > directory DESTDIR/ARCH_LIB_DIR.
> > > The change you made is creating a _directory_ ARCH_LIB_DIR while it
> > > should be a _symbolic link_.
> > >
> >
> > Yes, I misunderstood the option -f as it will only remove the symbol
> > file not the directory.
> > The path sysroot/lib64 is relinked to sysroot/lib after the external
> > tool installation, all the libraries are copied to sysroot/lib/lp64d.
> > The toolchain can find it's corresponding library, so I don't notice
> > the mistake.
> >
> > If I change the code like:
> > mkdir -p `dirname "$${DESTDIR}/$${ARCH_LIB_DIR}"` ; \
> > mkdir -p `dirname "$${DESTDIR}/usr/$${ARCH_LIB_DIR}"` ; \
> >
> > Two symbol links are created:
> > sysroot/:lib64 -> lib
> > sysroot/lib: lp64d -> ../lib
> > The libraries are under: lib, lib64, lib64/lp64d ...
> >
> > > Could you please clarify what is the value of ARCH_LIB_DIR in your case?
> > >
> > > And could you clarify which part of the path is missing?
> > > '/.../host/riscv64-buildroot-linux-gnu/sysroot/lib64/lp64' ?
> > > I assume that the 'lib64' part is missing?
> > >
> >
> > Yes, "lib64" is the missing part. It can be some other value like
> > "lib64xthead" when the extension is different.
> >
> > > Finally, please provide a defconfig that allows to reproduce and test
> > > this problem.
> > >
> >
> > The defconfig is attached. And the toolchain I used comes from:
> > https://github.com/riscv/riscv-gnu-toolchain
> >
> > make with:
> > git clone https://github.com/riscv/riscv-gnu-toolchain
> > cd riscv-gnu-toolchain
> > git submodule update --init --recursive
> > ./configure --prefix=/opt/riscv --enable-multilib
> > make linux
> >
> > I can't provide the toolchain binary as it is quite large, and
> > the network is also limited.
> >
> 
> I compiled the riscv toolchain as instructed, and applied your config
> (note: it was a full config, not a defconfig). The defconfig is:
> 
> BR2_riscv=y
> BR2_TOOLCHAIN_EXTERNAL=y
> BR2_TOOLCHAIN_EXTERNAL_PATH="/opt/riscv"
> BR2_TOOLCHAIN_EXTERNAL_CUSTOM_PREFIX="$(ARCH)-unknown-linux-gnu"
> BR2_TOOLCHAIN_EXTERNAL_HEADERS_5_0=y
> BR2_TOOLCHAIN_EXTERNAL_CUSTOM_GLIBC=y
> BR2_TOOLCHAIN_EXTERNAL_CXX=y
> BR2_TARGET_GENERIC_GETTY_PORT="ttyS0"
> BR2_SYSTEM_DHCP="eth0"
> BR2_LINUX_KERNEL=y
> BR2_LINUX_KERNEL_CUSTOM_VERSION=y
> BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="5.1.12"
> BR2_LINUX_KERNEL_USE_ARCH_DEFAULT_CONFIG=y
> BR2_TARGET_ROOTFS_EXT2=y
> BR2_TARGET_OPENSBI=y
> BR2_TARGET_OPENSBI_PLAT="qemu/virt"
> BR2_PACKAGE_HOST_QEMU=y
> BR2_PACKAGE_HOST_QEMU_SYSTEM_MODE=y
>
> Using this config, I do not see the same error as you. The toolchain
> seems to install correctly (note: later we will notice it does not;
> see below), but I do get an error later when busybox is compiled:
>

The problem is originally occurs on a non-public released toolchain
with a sysroot folder structure like:
sysroot/lib64xthead/lp64d
and I tried to reproduce with a public RISC-V toolchain, and got
similar error weeks ago.
I retried with the toolchains yesterday, the error is only reproduced
with the internal one. There might be something wrong with my 
previous operation.

> ...
>   CC      libbb/xregcomp.o
>   AR      libbb/lib.a
>   LINK    busybox_unstripped
> Your linker does not support --sort-section,alignment
> Your linker does not support --sort-common
> Your linker does not support -Wl,--gc-sections
> Trying libraries: m resolv
> Failed: -Wl,--start-group  -lm -lresolv  -Wl,--end-group
> Output of:
> /home/tdescham/repo/contrib/buildroot/output/host/bin/riscv64-unknown-linux-gnu-gcc
> -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -Os
> -Wall -Wshadow -Wwrite-strings -Wundef -Wstrict-prototypes -Wunused
> -Wunused-parameter -Wunused-function -Wunused-value
> -Wmissing-prototypes -Wmissing-declarations -Wno-format-security
> -Wdeclaration-after-statement -Wold-style-definition
> -fno-builtin-strlen -finline-limit=0 -fomit-frame-pointer
> -ffunction-sections -fdata-sections -fno-guess-branch-probability
> -funsigned-char -static-libgcc -falign-functions=1 -falign-jumps=1
> -falign-labels=1 -falign-loops=1 -fno-unwind-tables
> -fno-asynchronous-unwind-tables -fno-builtin-printf -Os -o
> busybox_unstripped -Wl,--start-group applets/built-in.o archival/lib.a
> archival/libarchive/lib.a console-tools/lib.a coreutils/lib.a
> coreutils/libcoreutils/lib.a debianutils/lib.a klibc-utils/lib.a
> e2fsprogs/lib.a editors/lib.a findutils/lib.a init/lib.a libbb/lib.a
> libpwdgrp/lib.a loginutils/lib.a mailutils/lib.a miscutils/lib.a
> modutils/lib.a networking/lib.a networking/libiproute/lib.a
> networking/udhcp/lib.a printutils/lib.a procps/lib.a runit/lib.a
> selinux/lib.a shell/lib.a sysklogd/lib.a util-linux/lib.a
> util-linux/volume_id/lib.a archival/built-in.o
> archival/libarchive/built-in.o console-tools/built-in.o
> coreutils/built-in.o coreutils/libcoreutils/built-in.o
> debianutils/built-in.o klibc-utils/built-in.o e2fsprogs/built-in.o
> editors/built-in.o findutils/built-in.o init/built-in.o
> libbb/built-in.o libpwdgrp/built-in.o loginutils/built-in.o
> mailutils/built-in.o miscutils/built-in.o modutils/built-in.o
> networking/built-in.o networking/libiproute/built-in.o
> networking/udhcp/built-in.o printutils/built-in.o procps/built-in.o
> runit/built-in.o selinux/built-in.o shell/built-in.o
> sysklogd/built-in.o util-linux/built-in.o
> util-linux/volume_id/built-in.o -Wl,--end-group -Wl,--start-group -lm
> -lresolv -Wl,--end-group
> ==========
> /home/tdescham/repo/contrib/riscv/lib/gcc/riscv64-unknown-linux-gnu/9.2.0/../../../../riscv64-unknown-linux-gnu/bin/ld:
> coreutils/lib.a(mktemp.o): in function `.L5':
> mktemp.c:(.text.mktemp_main+0xb4): warning: the use of `mktemp' is
> dangerous, better use `mkstemp' or `mkdtemp'
> /home/tdescham/repo/contrib/riscv/lib/gcc/riscv64-unknown-linux-gnu/9.2.0/../../../../riscv64-unknown-linux-gnu/bin/ld:
> cannot find /lib/ld-linux-riscv64-lp64d.so.1 inside
> /home/tdescham/repo/contrib/buildroot/output/host/riscv64-buildroot-linux-gnu/sysroot
> collect2: error: ld returned 1 exit status
> Note: if build needs additional libraries, put them in CONFIG_EXTRA_LDLIBS.
> Example: CONFIG_EXTRA_LDLIBS="pthread dl tirpc audit pam"
> make[1]: *** [Makefile:718: busybox_unstripped] Error 1
> make[1]: Leaving directory
> '/home/tdescham/repo/contrib/buildroot/output/build/busybox-1.31.1'
> make: *** [package/pkg-generic.mk:260:
> /home/tdescham/repo/contrib/buildroot/output/build/busybox-1.31.1/.stamp_built]
> Error 2
> 
> 
> So the actual error here is:
> /home/tdescham/repo/contrib/riscv/lib/gcc/riscv64-unknown-linux-gnu/9.2.0/../../../../riscv64-unknown-linux-gnu/bin/ld:
> cannot find /lib/ld-linux-riscv64-lp64d.so.1 inside
> /home/tdescham/repo/contrib/buildroot/output/host/riscv64-buildroot-linux-gnu/sysroot
> collect2: error: ld returned 1 exit status
> 
> At this point, the situation in the buildroot sysroot is:
> 
> $ ls -l output/host/riscv64-buildroot-linux-gnu/sysroot/
> total 56
> drwxr-xr-x 2 tdescham tdescham 4096 Jan 16 10:05 bin/
> drwxr-xr-x 2 tdescham tdescham 4096 May  7  2019 dev/
> drwxr-xr-x 3 tdescham tdescham 4096 Jan 15 21:58 etc/
> drwxr-xr-x 2 tdescham tdescham 4096 Jan 16 08:48 lib/
> lrwxrwxrwx 1 tdescham tdescham    3 Jan 16 10:05 lib64 -> lib/
> drwxr-xr-x 2 tdescham tdescham 4096 May 28  2014 media/
> drwxr-xr-x 2 tdescham tdescham 4096 May 28  2014 mnt/
> drwxr-xr-x 2 tdescham tdescham 4096 May 28  2014 opt/
> drwxr-xr-x 2 tdescham tdescham 4096 May 28  2014 proc/
> drwxr-xr-x 2 tdescham tdescham 4096 Jan 25  2017 root/
> drwxr-xr-x 2 tdescham tdescham 4096 Feb  2  2016 run/
> drwxr-xr-x 2 tdescham tdescham 4096 Jan 15 21:58 sbin/
> drwxr-xr-x 2 tdescham tdescham 4096 May 28  2014 sys/
> drwxr-xr-x 2 tdescham tdescham 4096 May 28  2014 tmp/
> drwxr-xr-x 8 tdescham tdescham 4096 Jan 15 21:57 usr/
> 
> $ ls -l output/host/riscv64-buildroot-linux-gnu/sysroot/lib/lp64d
> lrwxrwxrwx 1 tdescham tdescham 6 Jan 16 10:05
> output/host/riscv64-buildroot-linux-gnu/sysroot/lib/lp64d -> ../lib/
> 
> and there is no ld-linux* file found anywhere, indeed.
> 
> Looking at the output of the toolchain installation, there was an error:
> >>> toolchain-external-custom  Copying external toolchain sysroot to staging...
> /bin/sh: line 0: [: too many arguments
> 
> which is caused by the fact that there are multiple 'ld*' matches:
> (extra traces added)
> 
> SYSROOT_DIR=/home/tdescham/repo/contrib/riscv/sysroot/
> ARCH_SYSROOT_DIR=/home/tdescham/repo/contrib/riscv/sysroot/
> ARCH_SUBDIR=
> ARCH_LIB_DIR=lib64/lp64d
> SUPPORT_LIB_DIR=
> no ld found yet @@@@@@@@@@@@
> /home/tdescham/repo/contrib/riscv/sysroot//lib/ld-linux-riscv32-ilp32d.so.1
> /home/tdescham/repo/contrib/riscv/sysroot//lib/ld-linux-riscv32-ilp32.so.1
> /home/tdescham/repo/contrib/riscv/sysroot//lib/ld-linux-riscv64-lp64d.so.1
> /home/tdescham/repo/contrib/riscv/sysroot//lib/ld-linux-riscv64-lp64.so.1
> /bin/sh: line 0: [: too many arguments
> done no ld found @@@@@@@@@@@@
> 
> Corresponding to this code:
> 
>     if [ ! -e $(STAGING_DIR)/lib/ld*.so.* ]; then \
>         echo "no ld found yet @@@@@@@@@@@@"; \
>         ls $${ARCH_SYSROOT_DIR}/lib/ld*.so.* ; \
>         if [ -e $${ARCH_SYSROOT_DIR}/lib/ld*.so.* ]; then \
>             echo "ld found in arch_sysroot_dir @@@@@@@@@@@@@"; \
>             cp -a $${ARCH_SYSROOT_DIR}/lib/ld*.so.* $(STAGING_DIR)/lib/ ; \
>         fi ; \
>         echo "done no ld found @@@@@@@@@@@@" ; \
>     fi ; \
> 
> 
> I'm not yet sure how this should be solved...

There is another patch in the same thread:
[PATCH 2/2] toolchain: Get ld.so name if available
http://buildroot-busybox.2317881.n4.nabble.com/PATCH-1-2-package-toolchain-external-ensure-ARCH-LIB-DIR-exist-td243604.html#a244193
Tried to get the corresponding ld.so name with certain configuration.

Thanks,
Mao Han
