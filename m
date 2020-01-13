Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 806D91389CE
	for <lists+linux-csky@lfdr.de>; Mon, 13 Jan 2020 04:39:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387424AbgAMDjv (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sun, 12 Jan 2020 22:39:51 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:40328 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387435AbgAMDjv (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Sun, 12 Jan 2020 22:39:51 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436369|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.132041-0.00328277-0.864676;DS=CONTINUE|ham_regular_dialog|0.0807283-0.000946779-0.918325;FP=0|0|0|0|0|0|0|0;HT=e02c03311;MF=han_mao@c-sky.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.Gb4L70U_1578886780;
Received: from localhost(mailfrom:han_mao@c-sky.com fp:SMTPD_---.Gb4L70U_1578886780)
          by smtp.aliyun-inc.com(10.147.40.7);
          Mon, 13 Jan 2020 11:39:40 +0800
Date:   Mon, 13 Jan 2020 11:34:52 +0800
From:   Mao Han <han_mao@c-sky.com>
To:     Thomas De Schampheleire <patrickdepinguin@gmail.com>
Cc:     buildroot@buildroot.org, xianmiao_qu@c-sky.com, ren_guo@c-sky.com,
        linux-csky@vger.kernel.org, hongdeng_chen@c-sky.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [Buildroot] [PATCH 1/2] package/toolchain-external: ensure
 ARCH_LIB_DIR exist
Message-ID: <20200113033451.GA15150@vmh-VirtualBox>
References: <1577937441-18703-1-git-send-email-han_mao@c-sky.com>
 <CAAXf6LUVA4QkSmz8OaSOyqzKaw--eD5r0zAD+zONfyGROv1MZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXf6LUVA4QkSmz8OaSOyqzKaw--eD5r0zAD+zONfyGROv1MZw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi,
On Fri, Jan 10, 2020 at 11:57:00AM +0100, Thomas De Schampheleire wrote:
> Hello,
> 
> El jue., 2 ene. 2020 a las 5:15, Mao Han (<han_mao@c-sky.com>) escribi�:
> >
> > Different architecture may have different arch library folder structure
> > for their multilib toolchain. RISC-V toolchain has folder structure
> > like:
> > /sysroot/lib64/
> > /sysroot/lib64/lp64
> > /sysroot/lib64/lp64d
> > The first level is for ISA and the second level is for ABI.
> > Current buildroot only creat lib and lib64, some error is reported
> > while installing the external toolchain:
> > >>> toolchain-external-custom  Installing to staging directory
> > /usr/bin/install -D -m 0755 /.../build/toolchain-external-custom/toolchain-wrapper /.../host/bin/toolchain-wrapper
> > ln: failed to create symbolic link '/.../host/riscv64-buildroot-linux-gnu/sysroot/lib64/lp64': No such file or directory
> > ln: failed to create symbolic link '/.../host/riscv64-buildroot-linux-gnu/sysroot/usr/lib64/lp64': No such file or directory
> >
> > Signed-off-by: Qu Xianmiao <xianmiao_qu@c-sky.com>
> > Signed-off-by: Chen Hongdeng <hongdeng_chen@c-sky.com>
> > Signed-off-by: Guo Ren<ren_guo@c-sky.com>
> > Signed-off-by: Mao Han <han_mao@c-sky.com>
> > Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > Cc: Mark Corbin <mark.corbin@embecosm.com>
> > ---
> >  toolchain/toolchain-external/pkg-toolchain-external.mk | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/toolchain/toolchain-external/pkg-toolchain-external.mk b/toolchain/toolchain-external/pkg-toolchain-external.mk
> > index baf719a..13b2468 100644
> > --- a/toolchain/toolchain-external/pkg-toolchain-external.mk
> > +++ b/toolchain/toolchain-external/pkg-toolchain-external.mk
> > @@ -454,6 +454,8 @@ create_lib_symlinks = \
> >         ARCH_LIB_DIR="$(call toolchain_find_libdir,$(TOOLCHAIN_EXTERNAL_CC) $(TOOLCHAIN_EXTERNAL_CFLAGS))" ; \
> >         if [ ! -e "$${DESTDIR}/$${ARCH_LIB_DIR}" -a ! -e "$${DESTDIR}/usr/$${ARCH_LIB_DIR}" ]; then \
> >                 relpath="$(call relpath_prefix,$${ARCH_LIB_DIR})" ; \
> > +               mkdir -p "$${DESTDIR}/$${ARCH_LIB_DIR}" ; \
> > +               mkdir -p "$${DESTDIR}/usr/$${ARCH_LIB_DIR}" ; \
> >                 ln -snf $${relpath}lib "$${DESTDIR}/$${ARCH_LIB_DIR}" ; \
> >                 ln -snf $${relpath}lib "$${DESTDIR}/usr/$${ARCH_LIB_DIR}" ; \
> 
> This is not correct.
> 
> The purpose of this code is to create a symbolic link named according
> to 'ARCH_LIB_DIR' inside DESTDIR and DESTDIR/usr.
> It is not the purpose to create a symbolic link called 'lib' inside a
> directory DESTDIR/ARCH_LIB_DIR.
> The change you made is creating a _directory_ ARCH_LIB_DIR while it
> should be a _symbolic link_.
>

Yes, I misunderstood the option -f as it will only remove the symbol
file not the directory.
The path sysroot/lib64 is relinked to sysroot/lib after the external
tool installation, all the libraries are copied to sysroot/lib/lp64d.
The toolchain can find it's corresponding library, so I don't notice
the mistake.

If I change the code like:
mkdir -p `dirname "$${DESTDIR}/$${ARCH_LIB_DIR}"` ; \
mkdir -p `dirname "$${DESTDIR}/usr/$${ARCH_LIB_DIR}"` ; \

Two symbol links are created:
sysroot/:lib64 -> lib
sysroot/lib: lp64d -> ../lib
The libraries are under: lib, lib64, lib64/lp64d ...
 
> Could you please clarify what is the value of ARCH_LIB_DIR in your case?
> 
> And could you clarify which part of the path is missing?
> '/.../host/riscv64-buildroot-linux-gnu/sysroot/lib64/lp64' ?
> I assume that the 'lib64' part is missing?
>

Yes, "lib64" is the missing part. It can be some other value like
"lib64xthead" when the extension is different.
 
> Finally, please provide a defconfig that allows to reproduce and test
> this problem.
> 

The defconfig is attached. And the toolchain I used comes from:
https://github.com/riscv/riscv-gnu-toolchain

make with:
git clone https://github.com/riscv/riscv-gnu-toolchain
cd riscv-gnu-toolchain
git submodule update --init --recursive
./configure --prefix=/opt/riscv --enable-multilib
make linux

I can't provide the toolchain binary as it is quite large, and
the network is also limited.

Thanks,
Mao Han

--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=defconfig

#
# Automatically generated file; DO NOT EDIT.
# Buildroot 2019.11.1 Configuration
#
BR2_HAVE_DOT_CONFIG=y
BR2_HOST_GCC_AT_LEAST_4_9=y
BR2_HOST_GCC_AT_LEAST_5=y

#
# Target options
#
BR2_ARCH_IS_64=y
BR2_ARCH_HAS_MMU_MANDATORY=y
# BR2_arcle is not set
# BR2_arceb is not set
# BR2_arm is not set
# BR2_armeb is not set
# BR2_aarch64 is not set
# BR2_aarch64_be is not set
# BR2_csky is not set
# BR2_i386 is not set
# BR2_m68k is not set
# BR2_microblazeel is not set
# BR2_microblazebe is not set
# BR2_mips is not set
# BR2_mipsel is not set
# BR2_mips64 is not set
# BR2_mips64el is not set
# BR2_nds32 is not set
# BR2_nios2 is not set
# BR2_or1k is not set
# BR2_powerpc is not set
# BR2_powerpc64 is not set
# BR2_powerpc64le is not set
BR2_riscv=y
# BR2_sh is not set
# BR2_sparc is not set
# BR2_sparc64 is not set
# BR2_x86_64 is not set
# BR2_xtensa is not set
BR2_ARCH_HAS_TOOLCHAIN_BUILDROOT=y
BR2_ARCH_NEEDS_GCC_AT_LEAST_4_8=y
BR2_ARCH_NEEDS_GCC_AT_LEAST_4_9=y
BR2_ARCH_NEEDS_GCC_AT_LEAST_5=y
BR2_ARCH_NEEDS_GCC_AT_LEAST_6=y
BR2_ARCH_NEEDS_GCC_AT_LEAST_7=y
BR2_ARCH="riscv64"
BR2_ENDIAN="LITTLE"
BR2_GCC_TARGET_ABI="lp64d"
BR2_BINFMT_SUPPORTS_SHARED=y
BR2_READELF_ARCH_NAME="RISC-V"
BR2_BINFMT_ELF=y
BR2_RISCV_ISA_RVI=y
BR2_RISCV_ISA_RVM=y
BR2_RISCV_ISA_RVA=y
BR2_RISCV_ISA_RVF=y
BR2_RISCV_ISA_RVD=y
BR2_riscv_g=y
# BR2_riscv_custom is not set
# BR2_RISCV_32 is not set
BR2_RISCV_64=y
# BR2_RISCV_ABI_LP64 is not set
# BR2_RISCV_ABI_LP64F is not set
BR2_RISCV_ABI_LP64D=y

#
# Build options
#

#
# Commands
#
BR2_WGET="wget --passive-ftp -nd -t 3"
BR2_SVN="svn --non-interactive"
BR2_BZR="bzr"
BR2_GIT="git"
BR2_CVS="cvs"
BR2_LOCALFILES="cp"
BR2_SCP="scp"
BR2_HG="hg"
BR2_ZCAT="gzip -d -c"
BR2_BZCAT="bzcat"
BR2_XZCAT="xzcat"
BR2_LZCAT="lzip -d -c"
BR2_TAR_OPTIONS=""
BR2_DEFCONFIG="/home/vmh/t7/buildroot-2019.11.1/configs/qemu_riscv64_virt_defconfig"
BR2_DL_DIR="$(TOPDIR)/dl"
BR2_HOST_DIR="$(BASE_DIR)/host"

#
# Mirrors and Download locations
#
BR2_PRIMARY_SITE=""
BR2_BACKUP_SITE="http://sources.buildroot.net"
BR2_KERNEL_MIRROR="https://cdn.kernel.org/pub"
BR2_GNU_MIRROR="http://ftpmirror.gnu.org"
BR2_LUAROCKS_MIRROR="http://rocks.moonscript.org"
BR2_CPAN_MIRROR="http://cpan.metacpan.org"
BR2_JLEVEL=0
# BR2_CCACHE is not set
# BR2_ENABLE_DEBUG is not set
BR2_STRIP_strip=y
BR2_STRIP_EXCLUDE_FILES=""
BR2_STRIP_EXCLUDE_DIRS=""
# BR2_OPTIMIZE_0 is not set
# BR2_OPTIMIZE_1 is not set
# BR2_OPTIMIZE_2 is not set
# BR2_OPTIMIZE_3 is not set
# BR2_OPTIMIZE_G is not set
BR2_OPTIMIZE_S=y
# BR2_OPTIMIZE_FAST is not set
# BR2_STATIC_LIBS is not set
BR2_SHARED_LIBS=y
# BR2_SHARED_STATIC_LIBS is not set
BR2_PACKAGE_OVERRIDE_FILE="$(CONFIG_DIR)/local.mk"
BR2_GLOBAL_PATCH_DIR=""

#
# Advanced
#
BR2_COMPILER_PARANOID_UNSAFE_PATH=y
# BR2_FORCE_HOST_BUILD is not set
# BR2_REPRODUCIBLE is not set

#
# Security Hardening Options
#
# BR2_PIC_PIE is not set
BR2_SSP_NONE=y
# BR2_SSP_REGULAR is not set
# BR2_SSP_STRONG is not set
# BR2_SSP_ALL is not set
BR2_RELRO_NONE=y
# BR2_RELRO_PARTIAL is not set
# BR2_RELRO_FULL is not set
BR2_FORTIFY_SOURCE_NONE=y
# BR2_FORTIFY_SOURCE_1 is not set
# BR2_FORTIFY_SOURCE_2 is not set

#
# Toolchain
#
BR2_TOOLCHAIN=y
BR2_TOOLCHAIN_USES_GLIBC=y
# BR2_TOOLCHAIN_BUILDROOT is not set
BR2_TOOLCHAIN_EXTERNAL=y

#
# Toolchain External Options
#
BR2_TOOLCHAIN_EXTERNAL_CUSTOM=y
# BR2_TOOLCHAIN_EXTERNAL_DOWNLOAD is not set
BR2_TOOLCHAIN_EXTERNAL_PREINSTALLED=y
BR2_TOOLCHAIN_EXTERNAL_PATH="/opt/riscv"
BR2_TOOLCHAIN_EXTERNAL_GLIBC=y
BR2_PACKAGE_HAS_TOOLCHAIN_EXTERNAL=y
BR2_PACKAGE_PROVIDES_TOOLCHAIN_EXTERNAL="toolchain-external-custom"
BR2_TOOLCHAIN_EXTERNAL_PREFIX="$(ARCH)-unknown-linux-gnu"
BR2_TOOLCHAIN_EXTERNAL_CUSTOM_PREFIX="$(ARCH)-unknown-linux-gnu"
BR2_TOOLCHAIN_EXTERNAL_GCC_9=y
# BR2_TOOLCHAIN_EXTERNAL_GCC_8 is not set
# BR2_TOOLCHAIN_EXTERNAL_GCC_7 is not set
# BR2_TOOLCHAIN_EXTERNAL_GCC_6 is not set
# BR2_TOOLCHAIN_EXTERNAL_GCC_5 is not set
# BR2_TOOLCHAIN_EXTERNAL_GCC_4_9 is not set
# BR2_TOOLCHAIN_EXTERNAL_GCC_4_8 is not set
# BR2_TOOLCHAIN_EXTERNAL_GCC_4_7 is not set
# BR2_TOOLCHAIN_EXTERNAL_GCC_4_6 is not set
# BR2_TOOLCHAIN_EXTERNAL_GCC_4_5 is not set
# BR2_TOOLCHAIN_EXTERNAL_GCC_4_4 is not set
# BR2_TOOLCHAIN_EXTERNAL_GCC_4_3 is not set
# BR2_TOOLCHAIN_EXTERNAL_GCC_OLD is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_5_3 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_5_2 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_5_1 is not set
BR2_TOOLCHAIN_EXTERNAL_HEADERS_5_0=y
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_20 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_19 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_18 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_17 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_16 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_15 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_14 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_13 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_12 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_11 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_10 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_9 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_8 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_7 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_6 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_5 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_4 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_3 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_2 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_1 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_4_0 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_19 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_18 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_17 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_16 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_15 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_14 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_13 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_12 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_11 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_10 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_9 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_8 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_7 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_6 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_5 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_4 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_3 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_2 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_1 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_3_0 is not set
# BR2_TOOLCHAIN_EXTERNAL_HEADERS_REALLY_OLD is not set
# BR2_TOOLCHAIN_EXTERNAL_CUSTOM_UCLIBC is not set
BR2_TOOLCHAIN_EXTERNAL_CUSTOM_GLIBC=y
# BR2_TOOLCHAIN_EXTERNAL_CUSTOM_MUSL is not set
BR2_TOOLCHAIN_EXTERNAL_HAS_SSP=y
BR2_TOOLCHAIN_EXTERNAL_INET_RPC=y
BR2_TOOLCHAIN_EXTERNAL_CXX=y
# BR2_TOOLCHAIN_EXTERNAL_DLANG is not set
# BR2_TOOLCHAIN_EXTERNAL_FORTRAN is not set
# BR2_TOOLCHAIN_EXTERNAL_OPENMP is not set
# BR2_TOOLCHAIN_EXTERNAL_GDB_SERVER_COPY is not set

#
# Toolchain Generic Options
#
BR2_TOOLCHAIN_SUPPORTS_ALWAYS_LOCKFREE_ATOMIC_INTS=y
BR2_TOOLCHAIN_SUPPORTS_VARIADIC_MI_THUNK=y
BR2_TOOLCHAIN_HAS_NATIVE_RPC=y
BR2_USE_WCHAR=y
BR2_ENABLE_LOCALE=y
BR2_INSTALL_LIBSTDCPP=y
BR2_TOOLCHAIN_HAS_THREADS=y
BR2_TOOLCHAIN_HAS_THREADS_DEBUG=y
BR2_TOOLCHAIN_HAS_THREADS_NPTL=y
BR2_TOOLCHAIN_HAS_SSP=y
BR2_TOOLCHAIN_HAS_UCONTEXT=y
BR2_TOOLCHAIN_SUPPORTS_PIE=y
# BR2_TOOLCHAIN_GLIBC_GCONV_LIBS_COPY is not set
BR2_TOOLCHAIN_EXTRA_LIBS=""
BR2_TOOLCHAIN_HAS_FULL_GETTEXT=y
BR2_USE_MMU=y
BR2_TARGET_OPTIMIZATION=""
BR2_TARGET_LDFLAGS=""
# BR2_ECLIPSE_REGISTER is not set
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_0=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_1=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_2=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_3=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_4=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_5=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_6=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_7=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_8=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_9=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_10=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_11=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_12=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_13=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_14=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_15=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_16=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_17=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_18=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_3_19=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_0=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_1=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_2=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_3=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_4=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_5=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_6=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_7=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_8=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_9=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_10=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_11=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_12=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_13=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_14=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_15=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_16=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_17=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_18=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_19=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_4_20=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST_5_0=y
BR2_TOOLCHAIN_HEADERS_AT_LEAST="5.0"
BR2_TOOLCHAIN_GCC_AT_LEAST_4_3=y
BR2_TOOLCHAIN_GCC_AT_LEAST_4_4=y
BR2_TOOLCHAIN_GCC_AT_LEAST_4_5=y
BR2_TOOLCHAIN_GCC_AT_LEAST_4_6=y
BR2_TOOLCHAIN_GCC_AT_LEAST_4_7=y
BR2_TOOLCHAIN_GCC_AT_LEAST_4_8=y
BR2_TOOLCHAIN_GCC_AT_LEAST_4_9=y
BR2_TOOLCHAIN_GCC_AT_LEAST_5=y
BR2_TOOLCHAIN_GCC_AT_LEAST_6=y
BR2_TOOLCHAIN_GCC_AT_LEAST_7=y
BR2_TOOLCHAIN_GCC_AT_LEAST_8=y
BR2_TOOLCHAIN_GCC_AT_LEAST_9=y
BR2_TOOLCHAIN_GCC_AT_LEAST="9"
BR2_TOOLCHAIN_HAS_MNAN_OPTION=y
BR2_TOOLCHAIN_HAS_SYNC_1=y
BR2_TOOLCHAIN_HAS_SYNC_2=y
BR2_TOOLCHAIN_HAS_SYNC_4=y
BR2_TOOLCHAIN_HAS_SYNC_8=y
BR2_TOOLCHAIN_HAS_LIBATOMIC=y
BR2_TOOLCHAIN_HAS_ATOMIC=y

#
# System configuration
#
BR2_ROOTFS_SKELETON_DEFAULT=y
# BR2_ROOTFS_SKELETON_CUSTOM is not set
BR2_TARGET_GENERIC_HOSTNAME="buildroot"
BR2_TARGET_GENERIC_ISSUE="Welcome to Buildroot"
BR2_TARGET_GENERIC_PASSWD_SHA256=y
# BR2_TARGET_GENERIC_PASSWD_SHA512 is not set
BR2_TARGET_GENERIC_PASSWD_METHOD="sha-256"
BR2_INIT_BUSYBOX=y
# BR2_INIT_SYSV is not set
# BR2_INIT_OPENRC is not set
# BR2_INIT_SYSTEMD is not set
# BR2_INIT_NONE is not set
# BR2_ROOTFS_DEVICE_CREATION_STATIC is not set
BR2_ROOTFS_DEVICE_CREATION_DYNAMIC_DEVTMPFS=y
# BR2_ROOTFS_DEVICE_CREATION_DYNAMIC_MDEV is not set
# BR2_ROOTFS_DEVICE_CREATION_DYNAMIC_EUDEV is not set
BR2_ROOTFS_DEVICE_TABLE="system/device_table.txt"
# BR2_ROOTFS_DEVICE_TABLE_SUPPORTS_EXTENDED_ATTRIBUTES is not set
# BR2_ROOTFS_MERGED_USR is not set
BR2_TARGET_ENABLE_ROOT_LOGIN=y
BR2_TARGET_GENERIC_ROOT_PASSWD=""
BR2_SYSTEM_BIN_SH_BUSYBOX=y

#
# bash, dash, mksh, zsh need BR2_PACKAGE_BUSYBOX_SHOW_OTHERS
#
# BR2_SYSTEM_BIN_SH_NONE is not set
BR2_TARGET_GENERIC_GETTY=y
BR2_TARGET_GENERIC_GETTY_PORT="ttyS0"
BR2_TARGET_GENERIC_GETTY_BAUDRATE_KEEP=y
# BR2_TARGET_GENERIC_GETTY_BAUDRATE_9600 is not set
# BR2_TARGET_GENERIC_GETTY_BAUDRATE_19200 is not set
# BR2_TARGET_GENERIC_GETTY_BAUDRATE_38400 is not set
# BR2_TARGET_GENERIC_GETTY_BAUDRATE_57600 is not set
# BR2_TARGET_GENERIC_GETTY_BAUDRATE_115200 is not set
BR2_TARGET_GENERIC_GETTY_BAUDRATE="0"
BR2_TARGET_GENERIC_GETTY_TERM="vt100"
BR2_TARGET_GENERIC_GETTY_OPTIONS=""
BR2_TARGET_GENERIC_REMOUNT_ROOTFS_RW=y
BR2_SYSTEM_DHCP="eth0"
BR2_SYSTEM_DEFAULT_PATH="/bin:/sbin:/usr/bin:/usr/sbin"
BR2_ENABLE_LOCALE_PURGE=y
BR2_ENABLE_LOCALE_WHITELIST="C en_US"
BR2_GENERATE_LOCALE=""
# BR2_SYSTEM_ENABLE_NLS is not set
# BR2_TARGET_TZ_INFO is not set
BR2_ROOTFS_USERS_TABLES=""
BR2_ROOTFS_OVERLAY=""
BR2_ROOTFS_POST_BUILD_SCRIPT=""
BR2_ROOTFS_POST_FAKEROOT_SCRIPT=""
BR2_ROOTFS_POST_IMAGE_SCRIPT=""

#
# Kernel
#
BR2_LINUX_KERNEL=y
# BR2_LINUX_KERNEL_LATEST_VERSION is not set
# BR2_LINUX_KERNEL_LATEST_CIP_VERSION is not set
BR2_LINUX_KERNEL_CUSTOM_VERSION=y
# BR2_LINUX_KERNEL_CUSTOM_TARBALL is not set
# BR2_LINUX_KERNEL_CUSTOM_GIT is not set
# BR2_LINUX_KERNEL_CUSTOM_HG is not set
# BR2_LINUX_KERNEL_CUSTOM_SVN is not set
BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="5.1.12"
BR2_LINUX_KERNEL_VERSION="5.1.12"
BR2_LINUX_KERNEL_PATCH=""
# BR2_LINUX_KERNEL_USE_DEFCONFIG is not set
BR2_LINUX_KERNEL_USE_ARCH_DEFAULT_CONFIG=y
# BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG is not set
BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES=""
BR2_LINUX_KERNEL_CUSTOM_LOGO_PATH=""
BR2_LINUX_KERNEL_IMAGE=y
# BR2_LINUX_KERNEL_VMLINUX is not set
# BR2_LINUX_KERNEL_IMAGE_TARGET_CUSTOM is not set
BR2_LINUX_KERNEL_GZIP=y
# BR2_LINUX_KERNEL_LZ4 is not set
# BR2_LINUX_KERNEL_LZMA is not set
# BR2_LINUX_KERNEL_LZO is not set
# BR2_LINUX_KERNEL_XZ is not set
# BR2_LINUX_KERNEL_DTS_SUPPORT is not set
# BR2_LINUX_KERNEL_INSTALL_TARGET is not set
# BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL is not set
# BR2_LINUX_KERNEL_NEEDS_HOST_LIBELF is not set

#
# Linux Kernel Extensions
#
# BR2_LINUX_KERNEL_EXT_RTAI is not set
# BR2_LINUX_KERNEL_EXT_EV3DEV_LINUX_DRIVERS is not set
# BR2_LINUX_KERNEL_EXT_FBTFT is not set
# BR2_LINUX_KERNEL_EXT_AUFS is not set

#
# Linux Kernel Tools
#
# BR2_PACKAGE_LINUX_TOOLS_CPUPOWER is not set
# BR2_PACKAGE_LINUX_TOOLS_GPIO is not set
# BR2_PACKAGE_LINUX_TOOLS_IIO is not set
# BR2_PACKAGE_LINUX_TOOLS_PCI is not set
# BR2_PACKAGE_LINUX_TOOLS_PERF is not set

#
# selftests needs BR2_PACKAGE_BUSYBOX_SHOW_OTHERS and a toolchain w/ dynamic library
#
# BR2_PACKAGE_LINUX_TOOLS_TMON is not set

#
# Target packages
#
BR2_PACKAGE_BUSYBOX=y
BR2_PACKAGE_BUSYBOX_CONFIG="package/busybox/busybox.config"
BR2_PACKAGE_BUSYBOX_CONFIG_FRAGMENT_FILES=""
# BR2_PACKAGE_BUSYBOX_SHOW_OTHERS is not set
# BR2_PACKAGE_BUSYBOX_SELINUX is not set
# BR2_PACKAGE_BUSYBOX_INDIVIDUAL_BINARIES is not set
# BR2_PACKAGE_BUSYBOX_WATCHDOG is not set
BR2_PACKAGE_SKELETON=y
BR2_PACKAGE_HAS_SKELETON=y
BR2_PACKAGE_PROVIDES_SKELETON="skeleton-init-sysv"
BR2_PACKAGE_SKELETON_INIT_COMMON=y
BR2_PACKAGE_SKELETON_INIT_SYSV=y

#
# Audio and video applications
#
# BR2_PACKAGE_ALSA_UTILS is not set
# BR2_PACKAGE_ATEST is not set
# BR2_PACKAGE_AUMIX is not set
# BR2_PACKAGE_BELLAGIO is not set
# BR2_PACKAGE_BLUEZ_ALSA is not set
# BR2_PACKAGE_DVBLAST is not set
# BR2_PACKAGE_DVDAUTHOR is not set
# BR2_PACKAGE_DVDRW_TOOLS is not set
# BR2_PACKAGE_ESPEAK is not set
# BR2_PACKAGE_FAAD2 is not set
BR2_PACKAGE_FFMPEG_ARCH_SUPPORTS=y
# BR2_PACKAGE_FFMPEG is not set
# BR2_PACKAGE_FLAC is not set
# BR2_PACKAGE_FLITE is not set
# BR2_PACKAGE_GMRENDER_RESURRECT is not set
# BR2_PACKAGE_GSTREAMER is not set
# BR2_PACKAGE_GSTREAMER1 is not set
# BR2_PACKAGE_JACK1 is not set
# BR2_PACKAGE_JACK2 is not set
BR2_PACKAGE_KODI_ARCH_SUPPORTS=y

#
# kodi needs python w/ .py modules, a uClibc or glibc toolchain w/ C++, threads, wchar, dynamic library, gcc >= 4.8
#

#
# kodi needs an OpenGL EGL backend with OpenGL support
#
# BR2_PACKAGE_LAME is not set
# BR2_PACKAGE_MADPLAY is not set
# BR2_PACKAGE_MIMIC is not set
# BR2_PACKAGE_MINIMODEM is not set

#
# miraclecast needs systemd and a glibc toolchain w/ threads and wchar
#
# BR2_PACKAGE_MJPEGTOOLS is not set
# BR2_PACKAGE_MODPLUGTOOLS is not set
# BR2_PACKAGE_MOTION is not set
# BR2_PACKAGE_MPD is not set
# BR2_PACKAGE_MPD_MPC is not set
# BR2_PACKAGE_MPG123 is not set
# BR2_PACKAGE_MPV is not set
# BR2_PACKAGE_MULTICAT is not set
# BR2_PACKAGE_MUSEPACK is not set
# BR2_PACKAGE_NCMPC is not set
# BR2_PACKAGE_OPUS_TOOLS is not set
BR2_PACKAGE_PULSEAUDIO_HAS_ATOMIC=y
# BR2_PACKAGE_PULSEAUDIO is not set
# BR2_PACKAGE_SOX is not set
# BR2_PACKAGE_SQUEEZELITE is not set
# BR2_PACKAGE_TSTOOLS is not set
# BR2_PACKAGE_TWOLAME is not set
# BR2_PACKAGE_UDPXY is not set
# BR2_PACKAGE_UPMPDCLI is not set
# BR2_PACKAGE_V4L2GRAB is not set
# BR2_PACKAGE_V4L2LOOPBACK is not set
# BR2_PACKAGE_VLC is not set
# BR2_PACKAGE_VORBIS_TOOLS is not set
# BR2_PACKAGE_WAVPACK is not set
# BR2_PACKAGE_YAVTA is not set
# BR2_PACKAGE_YMPD is not set

#
# Compressors and decompressors
#
# BR2_PACKAGE_BROTLI is not set
# BR2_PACKAGE_BZIP2 is not set
# BR2_PACKAGE_LRZIP is not set
# BR2_PACKAGE_LZ4 is not set
# BR2_PACKAGE_LZIP is not set
# BR2_PACKAGE_LZOP is not set
# BR2_PACKAGE_P7ZIP is not set
# BR2_PACKAGE_PIGZ is not set
# BR2_PACKAGE_PIXZ is not set
# BR2_PACKAGE_UNRAR is not set
# BR2_PACKAGE_XZ is not set
# BR2_PACKAGE_ZIP is not set
# BR2_PACKAGE_ZSTD is not set

#
# Debugging, profiling and benchmark
#
# BR2_PACKAGE_BLKTRACE is not set
# BR2_PACKAGE_BONNIE is not set
# BR2_PACKAGE_CACHE_CALIBRATOR is not set

#
# clinfo needs an OpenCL provider
#

#
# dacapo needs OpenJDK
#
# BR2_PACKAGE_DHRYSTONE is not set
# BR2_PACKAGE_DIEHARDER is not set
# BR2_PACKAGE_DMALLOC is not set
# BR2_PACKAGE_DROPWATCH is not set
# BR2_PACKAGE_DSTAT is not set
# BR2_PACKAGE_DT is not set
# BR2_PACKAGE_DUMA is not set
# BR2_PACKAGE_FIO is not set
BR2_PACKAGE_GDB_ARCH_SUPPORTS=y
# BR2_PACKAGE_GDB is not set
# BR2_PACKAGE_IOZONE is not set
# BR2_PACKAGE_KTAP is not set
# BR2_PACKAGE_LATENCYTOP is not set
# BR2_PACKAGE_LMBENCH is not set
BR2_PACKAGE_LTP_TESTSUITE_ARCH_SUPPORTS=y
# BR2_PACKAGE_LTP_TESTSUITE is not set
# BR2_PACKAGE_LTTNG_BABELTRACE is not set
# BR2_PACKAGE_LTTNG_MODULES is not set
# BR2_PACKAGE_LTTNG_TOOLS is not set
# BR2_PACKAGE_MEMSTAT is not set
# BR2_PACKAGE_NETPERF is not set
# BR2_PACKAGE_NETSNIFF_NG is not set
# BR2_PACKAGE_NMON is not set
# BR2_PACKAGE_PAX_UTILS is not set
# BR2_PACKAGE_PV is not set
# BR2_PACKAGE_RAMSMP is not set
# BR2_PACKAGE_RAMSPEED is not set
# BR2_PACKAGE_RT_TESTS is not set
# BR2_PACKAGE_SPIDEV_TEST is not set
# BR2_PACKAGE_STRACE is not set
# BR2_PACKAGE_STRESS is not set
# BR2_PACKAGE_STRESS_NG is not set
# BR2_PACKAGE_TINYMEMBENCH is not set
# BR2_PACKAGE_TRACE_CMD is not set
# BR2_PACKAGE_UCLIBC_NG_TEST is not set
# BR2_PACKAGE_VMTOUCH is not set
# BR2_PACKAGE_WHETSTONE is not set

#
# Development tools
#
# BR2_PACKAGE_BINUTILS is not set
# BR2_PACKAGE_BSDIFF is not set
# BR2_PACKAGE_CHECK is not set
# BR2_PACKAGE_CPPUNIT is not set
# BR2_PACKAGE_CUNIT is not set
# BR2_PACKAGE_CVS is not set
# BR2_PACKAGE_CXXTEST is not set
# BR2_PACKAGE_FLEX is not set
# BR2_PACKAGE_GETTEXT is not set
BR2_PACKAGE_PROVIDES_HOST_GETTEXT="host-gettext-tiny"
# BR2_PACKAGE_GIT is not set
# BR2_PACKAGE_GIT_CRYPT is not set
# BR2_PACKAGE_GPERF is not set
# BR2_PACKAGE_JO is not set
# BR2_PACKAGE_JQ is not set
# BR2_PACKAGE_LIBTOOL is not set
# BR2_PACKAGE_MAKE is not set
# BR2_PACKAGE_PKGCONF is not set
# BR2_PACKAGE_SUBVERSION is not set
# BR2_PACKAGE_TREE is not set

#
# Filesystem and flash utilities
#
# BR2_PACKAGE_ABOOTIMG is not set
# BR2_PACKAGE_AUFS_UTIL is not set
# BR2_PACKAGE_AUTOFS is not set
# BR2_PACKAGE_BTRFS_PROGS is not set
# BR2_PACKAGE_CIFS_UTILS is not set
# BR2_PACKAGE_CPIO is not set
# BR2_PACKAGE_CRAMFS is not set
# BR2_PACKAGE_CURLFTPFS is not set
# BR2_PACKAGE_DAVFS2 is not set
# BR2_PACKAGE_DOSFSTOOLS is not set
# BR2_PACKAGE_E2FSPROGS is not set
# BR2_PACKAGE_E2TOOLS is not set
# BR2_PACKAGE_ECRYPTFS_UTILS is not set
# BR2_PACKAGE_EXFAT is not set
# BR2_PACKAGE_EXFAT_UTILS is not set
# BR2_PACKAGE_F2FS_TOOLS is not set
# BR2_PACKAGE_FLASHBENCH is not set
# BR2_PACKAGE_FSCRYPTCTL is not set
# BR2_PACKAGE_FWUP is not set
# BR2_PACKAGE_GENEXT2FS is not set
# BR2_PACKAGE_GENPART is not set
# BR2_PACKAGE_GENROMFS is not set
# BR2_PACKAGE_IMX_USB_LOADER is not set
# BR2_PACKAGE_MMC_UTILS is not set
# BR2_PACKAGE_MTD is not set
# BR2_PACKAGE_MTOOLS is not set
# BR2_PACKAGE_NFS_UTILS is not set
# BR2_PACKAGE_NILFS_UTILS is not set
# BR2_PACKAGE_NTFS_3G is not set
# BR2_PACKAGE_SP_OOPS_EXTRACT is not set
# BR2_PACKAGE_SQUASHFS is not set
# BR2_PACKAGE_SSHFS is not set
# BR2_PACKAGE_UDFTOOLS is not set
# BR2_PACKAGE_UNIONFS is not set
# BR2_PACKAGE_XFSPROGS is not set

#
# Fonts, cursors, icons, sounds and themes
#

#
# Cursors
#
# BR2_PACKAGE_COMIX_CURSORS is not set
# BR2_PACKAGE_OBSIDIAN_CURSORS is not set

#
# Fonts
#
# BR2_PACKAGE_BITSTREAM_VERA is not set
# BR2_PACKAGE_CANTARELL is not set
# BR2_PACKAGE_DEJAVU is not set
# BR2_PACKAGE_FONT_AWESOME is not set
# BR2_PACKAGE_GHOSTSCRIPT_FONTS is not set
# BR2_PACKAGE_INCONSOLATA is not set
# BR2_PACKAGE_LIBERATION is not set

#
# Icons
#
# BR2_PACKAGE_GOOGLE_MATERIAL_DESIGN_ICONS is not set
# BR2_PACKAGE_HICOLOR_ICON_THEME is not set

#
# Sounds
#
# BR2_PACKAGE_SOUND_THEME_BOREALIS is not set
# BR2_PACKAGE_SOUND_THEME_FREEDESKTOP is not set

#
# Themes
#

#
# Games
#
# BR2_PACKAGE_ASCII_INVADERS is not set
# BR2_PACKAGE_CHOCOLATE_DOOM is not set
# BR2_PACKAGE_FLARE_ENGINE is not set
# BR2_PACKAGE_GNUCHESS is not set
# BR2_PACKAGE_LBREAKOUT2 is not set
# BR2_PACKAGE_LTRIS is not set
# BR2_PACKAGE_OPENTYRIAN is not set
# BR2_PACKAGE_PRBOOM is not set
# BR2_PACKAGE_SL is not set
# BR2_PACKAGE_STELLA is not set

#
# Graphic libraries and applications (graphic/text)
#

#
# Graphic applications
#

#
# cog needs wpewebkit and a toolchain w/ threads
#
# BR2_PACKAGE_FSWEBCAM is not set
# BR2_PACKAGE_GHOSTSCRIPT is not set

#
# glmark2 needs an OpenGL or an openGL ES and EGL backend
#
# BR2_PACKAGE_GNUPLOT is not set
# BR2_PACKAGE_JHEAD is not set
# BR2_PACKAGE_LIBVA_UTILS is not set
BR2_PACKAGE_NETSURF_ARCH_SUPPORTS=y
# BR2_PACKAGE_NETSURF is not set
# BR2_PACKAGE_PNGQUANT is not set
# BR2_PACKAGE_RRDTOOL is not set

#
# stellarium needs Qt5 and an OpenGL provider
#
# BR2_PACKAGE_TESSERACT_OCR is not set

#
# Graphic libraries
#
# BR2_PACKAGE_CEGUI06 is not set
# BR2_PACKAGE_DIRECTFB is not set
# BR2_PACKAGE_FB_TEST_APP is not set
# BR2_PACKAGE_FBDUMP is not set
# BR2_PACKAGE_FBGRAB is not set
# BR2_PACKAGE_FBTERM is not set
# BR2_PACKAGE_FBV is not set
# BR2_PACKAGE_FREERDP is not set
# BR2_PACKAGE_IMAGEMAGICK is not set
# BR2_PACKAGE_LINUX_FUSION is not set
# BR2_PACKAGE_MESA3D is not set
# BR2_PACKAGE_OCRAD is not set

#
# ogre needs X11 and an OpenGL provider
#
# BR2_PACKAGE_PSPLASH is not set
# BR2_PACKAGE_SDL is not set
# BR2_PACKAGE_SDL2 is not set

#
# Other GUIs
#
# BR2_PACKAGE_QT5 is not set

#
# tekui needs a Lua interpreter and a toolchain w/ threads, dynamic library
#

#
# weston needs udev and a toolchain w/ locale, threads, dynamic library, headers >= 3.0
#
# BR2_PACKAGE_XORG7 is not set

#
# vte needs an OpenGL or an OpenGL-EGL/wayland backend
#
# BR2_PACKAGE_XKEYBOARD_CONFIG is not set

#
# Hardware handling
#

#
# Firmware
#
# BR2_PACKAGE_ARMBIAN_FIRMWARE is not set
# BR2_PACKAGE_B43_FIRMWARE is not set
# BR2_PACKAGE_LINUX_FIRMWARE is not set
# BR2_PACKAGE_MURATA_CYW_FW is not set
# BR2_PACKAGE_UX500_FIRMWARE is not set
# BR2_PACKAGE_WILC1000_FIRMWARE is not set
# BR2_PACKAGE_WILINK_BT_FIRMWARE is not set
# BR2_PACKAGE_ZD1211_FIRMWARE is not set
# BR2_PACKAGE_18XX_TI_UTILS is not set
# BR2_PACKAGE_ACPICA is not set
# BR2_PACKAGE_ACPID is not set
# BR2_PACKAGE_ACPITOOL is not set
# BR2_PACKAGE_AER_INJECT is not set
# BR2_PACKAGE_AVRDUDE is not set

#
# bcache-tools needs udev /dev management
#

#
# brickd needs udev /dev management, a toolchain w/ threads, wchar
#
# BR2_PACKAGE_BRLTTY is not set
# BR2_PACKAGE_CC_TOOL is not set
# BR2_PACKAGE_CDRKIT is not set
# BR2_PACKAGE_CRYPTSETUP is not set
# BR2_PACKAGE_CWIID is not set
# BR2_PACKAGE_DAHDI_LINUX is not set
# BR2_PACKAGE_DAHDI_TOOLS is not set
# BR2_PACKAGE_DBUS is not set
# BR2_PACKAGE_DFU_UTIL is not set
# BR2_PACKAGE_DMRAID is not set

#
# dt-utils needs udev /dev management
#
# BR2_PACKAGE_DTV_SCAN_TABLES is not set
# BR2_PACKAGE_DUMP1090 is not set
# BR2_PACKAGE_DVB_APPS is not set
# BR2_PACKAGE_DVBSNOOP is not set
# BR2_PACKAGE_EDID_DECODE is not set

#
# eudev needs eudev /dev management
#
# BR2_PACKAGE_EVEMU is not set
# BR2_PACKAGE_EVTEST is not set
# BR2_PACKAGE_FAN_CTRL is not set
# BR2_PACKAGE_FCONFIG is not set
# BR2_PACKAGE_FIS is not set
BR2_PACKAGE_FLASHROM_ARCH_SUPPORTS=y
# BR2_PACKAGE_FLASHROM is not set
# BR2_PACKAGE_FMTOOLS is not set
# BR2_PACKAGE_FXLOAD is not set
# BR2_PACKAGE_GADGETFS_TEST is not set
# BR2_PACKAGE_GPM is not set
# BR2_PACKAGE_GPSD is not set
# BR2_PACKAGE_GPTFDISK is not set
# BR2_PACKAGE_GVFS is not set
# BR2_PACKAGE_HWDATA is not set
# BR2_PACKAGE_HWLOC is not set
# BR2_PACKAGE_INPUT_EVENT_DAEMON is not set
# BR2_PACKAGE_IOSTAT is not set
# BR2_PACKAGE_IPMITOOL is not set
# BR2_PACKAGE_IRDA_UTILS is not set
# BR2_PACKAGE_KBD is not set
# BR2_PACKAGE_LCDPROC is not set
# BR2_PACKAGE_LIBUBOOTENV is not set
# BR2_PACKAGE_LIBUIO is not set
# BR2_PACKAGE_LINUX_BACKPORTS is not set
# BR2_PACKAGE_LINUX_SERIAL_TEST is not set
# BR2_PACKAGE_LINUXCONSOLETOOLS is not set
# BR2_PACKAGE_LIRC_TOOLS is not set
# BR2_PACKAGE_LM_SENSORS is not set
# BR2_PACKAGE_LSHW is not set
# BR2_PACKAGE_LSSCSI is not set
# BR2_PACKAGE_LSUIO is not set
# BR2_PACKAGE_LUKSMETA is not set
# BR2_PACKAGE_LVM2 is not set
# BR2_PACKAGE_MDADM is not set
# BR2_PACKAGE_MDEVD is not set
# BR2_PACKAGE_MEMTESTER is not set
# BR2_PACKAGE_MEMTOOL is not set
# BR2_PACKAGE_MINICOM is not set
# BR2_PACKAGE_NANOCOM is not set
# BR2_PACKAGE_NEARD is not set
# BR2_PACKAGE_NVME is not set
# BR2_PACKAGE_OFONO is not set
# BR2_PACKAGE_OPEN2300 is not set
# BR2_PACKAGE_OPENIPMI is not set
# BR2_PACKAGE_OPENOCD is not set
# BR2_PACKAGE_PARTED is not set
# BR2_PACKAGE_PCIUTILS is not set
# BR2_PACKAGE_PDBG is not set
# BR2_PACKAGE_PICOCOM is not set
# BR2_PACKAGE_POWERTOP is not set
# BR2_PACKAGE_PPS_TOOLS is not set
# BR2_PACKAGE_READ_EDID is not set
# BR2_PACKAGE_RNG_TOOLS is not set
# BR2_PACKAGE_RS485CONF is not set
# BR2_PACKAGE_RTC_TOOLS is not set
# BR2_PACKAGE_RTL8188EU is not set
# BR2_PACKAGE_RTL8189FS is not set
# BR2_PACKAGE_RTL8723BS is not set
# BR2_PACKAGE_RTL8723BU is not set
# BR2_PACKAGE_RTL8821AU is not set
# BR2_PACKAGE_SANE_BACKENDS is not set
# BR2_PACKAGE_SDPARM is not set
# BR2_PACKAGE_SETSERIAL is not set
# BR2_PACKAGE_SG3_UTILS is not set
# BR2_PACKAGE_SIGROK_CLI is not set
# BR2_PACKAGE_SISPMCTL is not set
# BR2_PACKAGE_SMARTMONTOOLS is not set
# BR2_PACKAGE_SMSTOOLS3 is not set
# BR2_PACKAGE_SPI_TOOLS is not set
# BR2_PACKAGE_SREDIRD is not set
# BR2_PACKAGE_STATSERIAL is not set
# BR2_PACKAGE_STM32FLASH is not set
# BR2_PACKAGE_SYSSTAT is not set

#
# targetcli-fb depends on Python
#

#
# ti-sgx-um needs the ti-sgx-km driver
#
# BR2_PACKAGE_TI_UIM is not set
# BR2_PACKAGE_TI_UTILS is not set
# BR2_PACKAGE_TRIGGERHAPPY is not set
# BR2_PACKAGE_UBOOT_TOOLS is not set
# BR2_PACKAGE_UBUS is not set
# BR2_PACKAGE_UCCP420WLAN is not set

#
# udisks needs udev /dev management
#
# BR2_PACKAGE_UHUBCTL is not set

#
# upower needs udev /dev management
#
# BR2_PACKAGE_USB_MODESWITCH is not set
# BR2_PACKAGE_USB_MODESWITCH_DATA is not set

#
# usbmount requires udev to be enabled
#

#
# usbutils needs udev /dev management and toolchain w/ threads
#
# BR2_PACKAGE_W_SCAN is not set
# BR2_PACKAGE_WIPE is not set
# BR2_PACKAGE_XORRISO is not set
# BR2_PACKAGE_XR819_XRADIO is not set

#
# Interpreter languages and scripting
#
# BR2_PACKAGE_4TH is not set
# BR2_PACKAGE_ENSCRIPT is not set
BR2_PACKAGE_HOST_ERLANG_ARCH_SUPPORTS=y
# BR2_PACKAGE_EXECLINE is not set
# BR2_PACKAGE_FICL is not set
# BR2_PACKAGE_HASERL is not set
# BR2_PACKAGE_JIMTCL is not set
# BR2_PACKAGE_LUA is not set
BR2_PACKAGE_PROVIDES_HOST_LUAINTERPRETER="host-lua"
# BR2_PACKAGE_MICROPYTHON is not set
BR2_PACKAGE_HOST_MONO_ARCH_SUPPORTS=y
BR2_PACKAGE_HOST_OPENJDK_BIN_ARCH_SUPPORTS=y
# BR2_PACKAGE_PERL is not set
# BR2_PACKAGE_PHP is not set
# BR2_PACKAGE_PYTHON is not set
# BR2_PACKAGE_PYTHON3 is not set
# BR2_PACKAGE_RUBY is not set
# BR2_PACKAGE_TCL is not set

#
# Libraries
#

#
# Audio/Sound
#
# BR2_PACKAGE_ALSA_LIB is not set
# BR2_PACKAGE_AUBIO is not set
# BR2_PACKAGE_AUDIOFILE is not set
# BR2_PACKAGE_BCG729 is not set
# BR2_PACKAGE_CAPS is not set
# BR2_PACKAGE_CELT051 is not set
# BR2_PACKAGE_LIBAO is not set
# BR2_PACKAGE_LIBASPLIB is not set
# BR2_PACKAGE_LIBBROADVOICE is not set
# BR2_PACKAGE_LIBCDAUDIO is not set
# BR2_PACKAGE_LIBCDDB is not set
# BR2_PACKAGE_LIBCDIO is not set
# BR2_PACKAGE_LIBCDIO_PARANOIA is not set
# BR2_PACKAGE_LIBCODEC2 is not set
# BR2_PACKAGE_LIBCUE is not set
# BR2_PACKAGE_LIBCUEFILE is not set
# BR2_PACKAGE_LIBEBUR128 is not set
# BR2_PACKAGE_LIBG7221 is not set
# BR2_PACKAGE_LIBGSM is not set
# BR2_PACKAGE_LIBID3TAG is not set
# BR2_PACKAGE_LIBILBC is not set
# BR2_PACKAGE_LIBLO is not set
# BR2_PACKAGE_LIBMAD is not set
# BR2_PACKAGE_LIBMODPLUG is not set
# BR2_PACKAGE_LIBMPD is not set
# BR2_PACKAGE_LIBMPDCLIENT is not set
# BR2_PACKAGE_LIBREPLAYGAIN is not set
# BR2_PACKAGE_LIBSAMPLERATE is not set
# BR2_PACKAGE_LIBSIDPLAY2 is not set
# BR2_PACKAGE_LIBSILK is not set
# BR2_PACKAGE_LIBSNDFILE is not set
# BR2_PACKAGE_LIBSOUNDTOUCH is not set
# BR2_PACKAGE_LIBSOXR is not set
# BR2_PACKAGE_LIBVORBIS is not set
# BR2_PACKAGE_MP4V2 is not set
BR2_PACKAGE_OPENAL_ARCH_SUPPORTS=y
# BR2_PACKAGE_OPENAL is not set
# BR2_PACKAGE_OPENCORE_AMR is not set
# BR2_PACKAGE_OPUS is not set
# BR2_PACKAGE_OPUSFILE is not set
# BR2_PACKAGE_PORTAUDIO is not set
# BR2_PACKAGE_SBC is not set
# BR2_PACKAGE_SPANDSP is not set
# BR2_PACKAGE_SPEEX is not set
# BR2_PACKAGE_SPEEXDSP is not set
# BR2_PACKAGE_TAGLIB is not set
# BR2_PACKAGE_TINYALSA is not set
# BR2_PACKAGE_TREMOR is not set
# BR2_PACKAGE_VO_AACENC is not set

#
# Compression and decompression
#
# BR2_PACKAGE_LIBARCHIVE is not set
# BR2_PACKAGE_LIBMSPACK is not set
# BR2_PACKAGE_LIBSQUISH is not set
# BR2_PACKAGE_LIBZIP is not set
# BR2_PACKAGE_LZO is not set
# BR2_PACKAGE_MINIZIP is not set
# BR2_PACKAGE_SNAPPY is not set
# BR2_PACKAGE_SZIP is not set
# BR2_PACKAGE_ZLIB is not set
BR2_PACKAGE_PROVIDES_HOST_ZLIB="host-libzlib"
# BR2_PACKAGE_ZZIPLIB is not set

#
# Crypto
#
# BR2_PACKAGE_BEECRYPT is not set
# BR2_PACKAGE_CA_CERTIFICATES is not set
# BR2_PACKAGE_CRYPTODEV is not set
# BR2_PACKAGE_GCR is not set
# BR2_PACKAGE_GNUTLS is not set
# BR2_PACKAGE_LIBASSUAN is not set
# BR2_PACKAGE_LIBGCRYPT is not set
BR2_PACKAGE_LIBGPG_ERROR_ARCH_SUPPORTS=y
# BR2_PACKAGE_LIBGPG_ERROR is not set
BR2_PACKAGE_LIBGPG_ERROR_SYSCFG="riscv64-unknown-linux-gnu"
# BR2_PACKAGE_LIBGPGME is not set
# BR2_PACKAGE_LIBKCAPI is not set
# BR2_PACKAGE_LIBKSBA is not set
# BR2_PACKAGE_LIBMCRYPT is not set
# BR2_PACKAGE_LIBMHASH is not set
# BR2_PACKAGE_LIBNSS is not set
# BR2_PACKAGE_LIBOLM is not set
# BR2_PACKAGE_LIBP11 is not set
# BR2_PACKAGE_LIBSCRYPT is not set
# BR2_PACKAGE_LIBSECRET is not set
# BR2_PACKAGE_LIBSHA1 is not set
# BR2_PACKAGE_LIBSODIUM is not set
# BR2_PACKAGE_LIBSSH is not set
# BR2_PACKAGE_LIBSSH2 is not set
# BR2_PACKAGE_LIBTOMCRYPT is not set
# BR2_PACKAGE_LIBUECC is not set
# BR2_PACKAGE_MBEDTLS is not set
# BR2_PACKAGE_NETTLE is not set
# BR2_PACKAGE_OPENSSL is not set
BR2_PACKAGE_PROVIDES_HOST_OPENSSL="host-libopenssl"
# BR2_PACKAGE_RHASH is not set
# BR2_PACKAGE_TINYDTLS is not set
# BR2_PACKAGE_TPM2_TSS is not set
# BR2_PACKAGE_TROUSERS is not set
# BR2_PACKAGE_USTREAM_SSL is not set
# BR2_PACKAGE_WOLFSSL is not set

#
# Database
#
# BR2_PACKAGE_BERKELEYDB is not set
# BR2_PACKAGE_GDBM is not set
# BR2_PACKAGE_HIREDIS is not set
# BR2_PACKAGE_KOMPEXSQLITE is not set
# BR2_PACKAGE_LEVELDB is not set
# BR2_PACKAGE_LIBGIT2 is not set
# BR2_PACKAGE_MYSQL is not set
# BR2_PACKAGE_POSTGRESQL is not set
# BR2_PACKAGE_REDIS is not set
# BR2_PACKAGE_SQLCIPHER is not set
# BR2_PACKAGE_SQLITE is not set
# BR2_PACKAGE_UNIXODBC is not set

#
# Filesystem
#
# BR2_PACKAGE_GAMIN is not set
# BR2_PACKAGE_LIBCONFIG is not set
# BR2_PACKAGE_LIBCONFUSE is not set
# BR2_PACKAGE_LIBFUSE is not set
# BR2_PACKAGE_LIBLOCKFILE is not set
# BR2_PACKAGE_LIBNFS is not set
# BR2_PACKAGE_LIBSYSFS is not set
# BR2_PACKAGE_LOCKDEV is not set
# BR2_PACKAGE_PHYSFS is not set

#
# Graphics
#
# BR2_PACKAGE_ASSIMP is not set

#
# at-spi2-atk depends on X.org
#

#
# at-spi2-core depends on X.org
#
# BR2_PACKAGE_ATK is not set
# BR2_PACKAGE_ATKMM is not set
# BR2_PACKAGE_BULLET is not set
# BR2_PACKAGE_CAIRO is not set
# BR2_PACKAGE_CAIROMM is not set

#
# chipmunk needs an OpenGL backend
#
# BR2_PACKAGE_EXEMPI is not set
# BR2_PACKAGE_EXIV2 is not set
# BR2_PACKAGE_FONTCONFIG is not set
# BR2_PACKAGE_FREETYPE is not set
# BR2_PACKAGE_GD is not set
# BR2_PACKAGE_GDK_PIXBUF is not set
# BR2_PACKAGE_GIFLIB is not set

#
# granite needs libgtk3 and a toolchain w/ wchar, threads
#
# BR2_PACKAGE_GRAPHITE2 is not set

#
# gtkmm3 needs libgtk3 and a toolchain w/ C++, wchar, threads, gcc >= 4.9
#
# BR2_PACKAGE_HARFBUZZ is not set
# BR2_PACKAGE_IJS is not set
# BR2_PACKAGE_IMLIB2 is not set

#
# irrlicht needs X11 and an OpenGL provider
#
# BR2_PACKAGE_JASPER is not set
# BR2_PACKAGE_JPEG is not set
# BR2_PACKAGE_KMSXX is not set
# BR2_PACKAGE_LCMS2 is not set
# BR2_PACKAGE_LENSFUN is not set
# BR2_PACKAGE_LEPTONICA is not set
# BR2_PACKAGE_LIBART is not set
# BR2_PACKAGE_LIBDMTX is not set
# BR2_PACKAGE_LIBDRM is not set

#
# libepoxy needs an OpenGL and/or OpenGL EGL backend
#
# BR2_PACKAGE_LIBEXIF is not set

#
# libfm needs X.org and a toolchain w/ wchar, threads, C++, gcc >= 4.8
#
# BR2_PACKAGE_LIBFM_EXTRA is not set

#
# libfreeglut depends on X.org and needs an OpenGL backend
#
# BR2_PACKAGE_LIBFREEIMAGE is not set
# BR2_PACKAGE_LIBGEOTIFF is not set

#
# libglew depends on X.org and needs an OpenGL backend
#

#
# libglfw depends on X.org and needs an OpenGL backend
#

#
# libglu needs an OpenGL backend
#
# BR2_PACKAGE_LIBGTA is not set

#
# libgtk3 needs an OpenGL or an OpenGL-EGL/wayland backend
#
# BR2_PACKAGE_LIBMEDIAART is not set
# BR2_PACKAGE_LIBMNG is not set
# BR2_PACKAGE_LIBPNG is not set
# BR2_PACKAGE_LIBQRENCODE is not set
# BR2_PACKAGE_LIBRAW is not set
# BR2_PACKAGE_LIBRSVG is not set

#
# libsoil needs an OpenGL backend and a toolchain w/ dynamic library
#
# BR2_PACKAGE_LIBSVG is not set
# BR2_PACKAGE_LIBSVG_CAIRO is not set
# BR2_PACKAGE_LIBSVGTINY is not set
# BR2_PACKAGE_LIBVA is not set
# BR2_PACKAGE_LIBVIPS is not set

#
# libwpe needs a toolchain w/ C++, dynamic library and an OpenEGL-capable backend
#
# BR2_PACKAGE_MENU_CACHE is not set
# BR2_PACKAGE_OPENCV is not set
# BR2_PACKAGE_OPENCV3 is not set
# BR2_PACKAGE_OPENJPEG is not set
# BR2_PACKAGE_PANGO is not set
# BR2_PACKAGE_PANGOMM is not set
# BR2_PACKAGE_PIXMAN is not set
# BR2_PACKAGE_POPPLER is not set
# BR2_PACKAGE_TIFF is not set
# BR2_PACKAGE_WAYLAND is not set
# BR2_PACKAGE_WEBP is not set
# BR2_PACKAGE_WOFF2 is not set

#
# wpebackend-fdo needs a toolchain w/ C++, wchar, threads, dynamic library and an OpenEGL-capable Wayland backend
#
# BR2_PACKAGE_ZBAR is not set
# BR2_PACKAGE_ZXING_CPP is not set

#
# Hardware handling
#
# BR2_PACKAGE_ACSCCID is not set
# BR2_PACKAGE_C_PERIPHERY is not set
# BR2_PACKAGE_CCID is not set
# BR2_PACKAGE_DTC is not set
# BR2_PACKAGE_HACKRF is not set

#
# hidapi needs udev /dev management and a toolchain w/ NPTL threads
#
# BR2_PACKAGE_JITTERENTROPY_LIBRARY is not set
# BR2_PACKAGE_LCDAPI is not set
# BR2_PACKAGE_LET_ME_CREATE is not set
# BR2_PACKAGE_LIBAIO is not set

#
# libatasmart requires udev to be enabled
#
# BR2_PACKAGE_LIBCEC is not set
# BR2_PACKAGE_LIBFREEFARE is not set
# BR2_PACKAGE_LIBFTDI is not set
# BR2_PACKAGE_LIBFTDI1 is not set
# BR2_PACKAGE_LIBGPHOTO2 is not set
# BR2_PACKAGE_LIBGPIOD is not set

#
# libgudev needs udev /dev handling and a toolchain w/ wchar, threads
#
# BR2_PACKAGE_LIBHID is not set
# BR2_PACKAGE_LIBIIO is not set

#
# libinput needs udev /dev management and a toolchain w/ locale
#
# BR2_PACKAGE_LIBIQRF is not set
# BR2_PACKAGE_LIBLLCP is not set
# BR2_PACKAGE_LIBMBIM is not set
# BR2_PACKAGE_LIBNFC is not set
# BR2_PACKAGE_LIBPCIACCESS is not set
# BR2_PACKAGE_LIBPHIDGET is not set
# BR2_PACKAGE_LIBPRI is not set
# BR2_PACKAGE_LIBQMI is not set
# BR2_PACKAGE_LIBRAW1394 is not set
# BR2_PACKAGE_LIBRTLSDR is not set
# BR2_PACKAGE_LIBSERIAL is not set
# BR2_PACKAGE_LIBSERIALPORT is not set
# BR2_PACKAGE_LIBSIGROK is not set
# BR2_PACKAGE_LIBSIGROKDECODE is not set
# BR2_PACKAGE_LIBSOC is not set
# BR2_PACKAGE_LIBSS7 is not set
# BR2_PACKAGE_LIBUSB is not set
# BR2_PACKAGE_LIBUSBGX is not set
# BR2_PACKAGE_LIBV4L is not set
# BR2_PACKAGE_LIBXKBCOMMON is not set
# BR2_PACKAGE_MTDEV is not set
# BR2_PACKAGE_NEARDAL is not set
# BR2_PACKAGE_OWFS is not set
# BR2_PACKAGE_PCSC_LITE is not set
# BR2_PACKAGE_TSLIB is not set
# BR2_PACKAGE_URG is not set
# BR2_PACKAGE_WIRINGPI is not set

#
# Javascript
#
# BR2_PACKAGE_ANGULARJS is not set
# BR2_PACKAGE_BOOTSTRAP is not set
# BR2_PACKAGE_DUKTAPE is not set
# BR2_PACKAGE_EXPLORERCANVAS is not set
# BR2_PACKAGE_FLOT is not set
# BR2_PACKAGE_JQUERY is not set
# BR2_PACKAGE_JSMIN is not set
# BR2_PACKAGE_JSON_JAVASCRIPT is not set
# BR2_PACKAGE_OPENLAYERS is not set

#
# JSON/XML
#
# BR2_PACKAGE_BENEJSON is not set
# BR2_PACKAGE_CJSON is not set
# BR2_PACKAGE_EXPAT is not set
# BR2_PACKAGE_EZXML is not set
# BR2_PACKAGE_JANSSON is not set
# BR2_PACKAGE_JOSE is not set
# BR2_PACKAGE_JSMN is not set
# BR2_PACKAGE_JSON_C is not set
# BR2_PACKAGE_JSON_FOR_MODERN_CPP is not set
# BR2_PACKAGE_JSON_GLIB is not set
# BR2_PACKAGE_JSONCPP is not set
# BR2_PACKAGE_LIBBSON is not set
# BR2_PACKAGE_LIBFASTJSON is not set
# BR2_PACKAGE_LIBJSON is not set
# BR2_PACKAGE_LIBROXML is not set
# BR2_PACKAGE_LIBUCL is not set
# BR2_PACKAGE_LIBXML2 is not set
# BR2_PACKAGE_LIBXMLPP is not set
# BR2_PACKAGE_LIBXMLRPC is not set
# BR2_PACKAGE_LIBXSLT is not set
# BR2_PACKAGE_LIBYAML is not set
# BR2_PACKAGE_MXML is not set
# BR2_PACKAGE_PUGIXML is not set
# BR2_PACKAGE_RAPIDJSON is not set
# BR2_PACKAGE_RAPIDXML is not set
# BR2_PACKAGE_RAPTOR is not set
# BR2_PACKAGE_TINYXML is not set
# BR2_PACKAGE_TINYXML2 is not set
# BR2_PACKAGE_VALIJSON is not set
# BR2_PACKAGE_XERCES is not set
# BR2_PACKAGE_YAJL is not set
# BR2_PACKAGE_YAML_CPP is not set

#
# Logging
#
# BR2_PACKAGE_GLOG is not set
# BR2_PACKAGE_LIBLOG4C_LOCALTIME is not set
# BR2_PACKAGE_LIBLOGGING is not set
# BR2_PACKAGE_LOG4CPLUS is not set
# BR2_PACKAGE_LOG4CPP is not set
# BR2_PACKAGE_LOG4CXX is not set
# BR2_PACKAGE_OPENTRACING_CPP is not set
# BR2_PACKAGE_SPDLOG is not set
# BR2_PACKAGE_ZLOG is not set

#
# Multimedia
#
# BR2_PACKAGE_BITSTREAM is not set
# BR2_PACKAGE_DAV1D is not set
# BR2_PACKAGE_KVAZAAR is not set
# BR2_PACKAGE_LIBAACS is not set
# BR2_PACKAGE_LIBASS is not set
# BR2_PACKAGE_LIBBDPLUS is not set
# BR2_PACKAGE_LIBBLURAY is not set

#
# libcamera needs udev and a toolchain w/ C++, threads, gcc >= 5
#
# BR2_PACKAGE_LIBDCADEC is not set
# BR2_PACKAGE_LIBDVBCSA is not set
# BR2_PACKAGE_LIBDVBPSI is not set
# BR2_PACKAGE_LIBDVBSI is not set
# BR2_PACKAGE_LIBDVDCSS is not set
# BR2_PACKAGE_LIBDVDNAV is not set
# BR2_PACKAGE_LIBDVDREAD is not set
# BR2_PACKAGE_LIBEBML is not set
# BR2_PACKAGE_LIBHDHOMERUN is not set
# BR2_PACKAGE_LIBMATROSKA is not set
# BR2_PACKAGE_LIBMMS is not set
# BR2_PACKAGE_LIBMPEG2 is not set
# BR2_PACKAGE_LIBOGG is not set
# BR2_PACKAGE_LIBOPUSENC is not set
# BR2_PACKAGE_LIBPLAYER is not set
# BR2_PACKAGE_LIBTHEORA is not set
# BR2_PACKAGE_LIBVPX is not set
# BR2_PACKAGE_LIBYUV is not set
# BR2_PACKAGE_LIVE555 is not set
# BR2_PACKAGE_MEDIASTREAMER is not set
# BR2_PACKAGE_X264 is not set
# BR2_PACKAGE_X265 is not set

#
# Networking
#
# BR2_PACKAGE_AGENTPP is not set
# BR2_PACKAGE_AZMQ is not set
# BR2_PACKAGE_AZURE_IOT_SDK_C is not set
# BR2_PACKAGE_BATMAN_ADV is not set
# BR2_PACKAGE_C_ARES is not set
# BR2_PACKAGE_CGIC is not set
# BR2_PACKAGE_CPPZMQ is not set
# BR2_PACKAGE_CURLPP is not set
# BR2_PACKAGE_CZMQ is not set
# BR2_PACKAGE_DAQ is not set
# BR2_PACKAGE_DAVICI is not set
# BR2_PACKAGE_ENET is not set
# BR2_PACKAGE_FILEMQ is not set
# BR2_PACKAGE_FLICKCURL is not set
# BR2_PACKAGE_FREERADIUS_CLIENT is not set
# BR2_PACKAGE_GEOIP is not set
# BR2_PACKAGE_GLIB_NETWORKING is not set
# BR2_PACKAGE_GRPC is not set
# BR2_PACKAGE_GSSDP is not set
# BR2_PACKAGE_GUPNP is not set
# BR2_PACKAGE_GUPNP_AV is not set
# BR2_PACKAGE_GUPNP_DLNA is not set
# BR2_PACKAGE_IBRCOMMON is not set
# BR2_PACKAGE_IBRDTN is not set
# BR2_PACKAGE_LIBCGI is not set
# BR2_PACKAGE_LIBCGICC is not set
# BR2_PACKAGE_LIBCOAP is not set
# BR2_PACKAGE_LIBCPPRESTSDK is not set
# BR2_PACKAGE_LIBCURL is not set
# BR2_PACKAGE_LIBDNET is not set
# BR2_PACKAGE_LIBEXOSIP2 is not set
# BR2_PACKAGE_LIBFCGI is not set
# BR2_PACKAGE_LIBGSASL is not set
# BR2_PACKAGE_LIBHTP is not set
# BR2_PACKAGE_LIBHTTPPARSER is not set
# BR2_PACKAGE_LIBHTTPSERVER is not set
# BR2_PACKAGE_LIBIDN is not set
# BR2_PACKAGE_LIBIDN2 is not set
# BR2_PACKAGE_LIBISCSI is not set
# BR2_PACKAGE_LIBKRB5 is not set
# BR2_PACKAGE_LIBLDNS is not set
# BR2_PACKAGE_LIBMAXMINDDB is not set
# BR2_PACKAGE_LIBMBUS is not set
# BR2_PACKAGE_LIBMEMCACHED is not set
# BR2_PACKAGE_LIBMICROHTTPD is not set
# BR2_PACKAGE_LIBMINIUPNPC is not set
# BR2_PACKAGE_LIBMNL is not set
# BR2_PACKAGE_LIBMODBUS is not set
# BR2_PACKAGE_LIBNATPMP is not set
# BR2_PACKAGE_LIBNDP is not set
# BR2_PACKAGE_LIBNET is not set
# BR2_PACKAGE_LIBNETCONF2 is not set
# BR2_PACKAGE_LIBNETFILTER_ACCT is not set
# BR2_PACKAGE_LIBNETFILTER_CONNTRACK is not set
# BR2_PACKAGE_LIBNETFILTER_CTHELPER is not set
# BR2_PACKAGE_LIBNETFILTER_CTTIMEOUT is not set
# BR2_PACKAGE_LIBNETFILTER_LOG is not set
# BR2_PACKAGE_LIBNETFILTER_QUEUE is not set
# BR2_PACKAGE_LIBNFNETLINK is not set
# BR2_PACKAGE_LIBNFTNL is not set
# BR2_PACKAGE_LIBNICE is not set
# BR2_PACKAGE_LIBNL is not set
# BR2_PACKAGE_LIBOAUTH is not set
# BR2_PACKAGE_LIBOPING is not set
# BR2_PACKAGE_LIBOSIP2 is not set
# BR2_PACKAGE_LIBPAGEKITE is not set
# BR2_PACKAGE_LIBPCAP is not set
# BR2_PACKAGE_LIBPJSIP is not set
# BR2_PACKAGE_LIBRSYNC is not set
# BR2_PACKAGE_LIBSHAIRPLAY is not set
# BR2_PACKAGE_LIBSHOUT is not set
# BR2_PACKAGE_LIBSOCKETCAN is not set
# BR2_PACKAGE_LIBSOUP is not set
# BR2_PACKAGE_LIBSRTP is not set
# BR2_PACKAGE_LIBSTROPHE is not set
# BR2_PACKAGE_LIBTIRPC is not set
# BR2_PACKAGE_LIBTORRENT is not set
# BR2_PACKAGE_LIBTORRENT_RASTERBAR is not set
# BR2_PACKAGE_LIBUPNP is not set
# BR2_PACKAGE_LIBUPNP18 is not set
# BR2_PACKAGE_LIBUPNPP is not set
# BR2_PACKAGE_LIBURIPARSER is not set
# BR2_PACKAGE_LIBVNCSERVER is not set
# BR2_PACKAGE_LIBWEBSOCK is not set
# BR2_PACKAGE_LIBWEBSOCKETS is not set
# BR2_PACKAGE_LIBYANG is not set
# BR2_PACKAGE_LKSCTP_TOOLS is not set
# BR2_PACKAGE_MONGOOSE is not set
# BR2_PACKAGE_NANOMSG is not set
# BR2_PACKAGE_NEON is not set
# BR2_PACKAGE_NGHTTP2 is not set
# BR2_PACKAGE_NORM is not set
# BR2_PACKAGE_NSS_MYHOSTNAME is not set
# BR2_PACKAGE_NSS_PAM_LDAPD is not set
# BR2_PACKAGE_OMNIORB is not set
# BR2_PACKAGE_OPENLDAP is not set
# BR2_PACKAGE_OPENMPI is not set
# BR2_PACKAGE_OPENPGM is not set
# BR2_PACKAGE_OPENZWAVE is not set
# BR2_PACKAGE_ORTP is not set
# BR2_PACKAGE_PAHO_MQTT_C is not set
# BR2_PACKAGE_PAHO_MQTT_CPP is not set
# BR2_PACKAGE_QDECODER is not set
# BR2_PACKAGE_QPID_PROTON is not set
# BR2_PACKAGE_RABBITMQ_C is not set
# BR2_PACKAGE_RESTCLIENT_CPP is not set
# BR2_PACKAGE_RTMPDUMP is not set
# BR2_PACKAGE_SLIRP is not set
# BR2_PACKAGE_SNMPPP is not set
# BR2_PACKAGE_SOFIA_SIP is not set
# BR2_PACKAGE_SYSREPO is not set
# BR2_PACKAGE_THRIFT is not set
# BR2_PACKAGE_USBREDIR is not set
# BR2_PACKAGE_WAMPCC is not set
# BR2_PACKAGE_WEBSOCKETPP is not set
# BR2_PACKAGE_ZEROMQ is not set
# BR2_PACKAGE_ZMQPP is not set
# BR2_PACKAGE_ZYRE is not set

#
# Other
#
# BR2_PACKAGE_APR is not set
# BR2_PACKAGE_APR_UTIL is not set
# BR2_PACKAGE_ARMADILLO is not set
# BR2_PACKAGE_ATF is not set
# BR2_PACKAGE_BCTOOLBOX is not set
# BR2_PACKAGE_BOOST is not set
# BR2_PACKAGE_C_CAPNPROTO is not set
# BR2_PACKAGE_CAPNPROTO is not set
# BR2_PACKAGE_CLAPACK is not set
# BR2_PACKAGE_CMOCKA is not set
# BR2_PACKAGE_CPPCMS is not set
# BR2_PACKAGE_CRACKLIB is not set
# BR2_PACKAGE_DAWGDIC is not set
# BR2_PACKAGE_DING_LIBS is not set
# BR2_PACKAGE_EIGEN is not set
# BR2_PACKAGE_ELFUTILS is not set
# BR2_PACKAGE_ELL is not set
# BR2_PACKAGE_FFTW is not set
# BR2_PACKAGE_FLANN is not set
# BR2_PACKAGE_FLATBUFFERS is not set
# BR2_PACKAGE_FLATCC is not set
# BR2_PACKAGE_GCONF is not set
# BR2_PACKAGE_GFLAGS is not set
# BR2_PACKAGE_GLI is not set
# BR2_PACKAGE_GLIBMM is not set
# BR2_PACKAGE_GLM is not set
# BR2_PACKAGE_GMP is not set
# BR2_PACKAGE_GSL is not set
# BR2_PACKAGE_GTEST is not set
BR2_PACKAGE_JEMALLOC_ARCH_SUPPORTS=y
# BR2_PACKAGE_JEMALLOC is not set

#
# lapack/blas needs a toolchain w/ fortran
#
# BR2_PACKAGE_LIBARGTABLE2 is not set
# BR2_PACKAGE_LIBAVL is not set
# BR2_PACKAGE_LIBB64 is not set
BR2_PACKAGE_LIBBSD_ARCH_SUPPORTS=y
# BR2_PACKAGE_LIBBSD is not set
# BR2_PACKAGE_LIBCAP is not set
# BR2_PACKAGE_LIBCAP_NG is not set
# BR2_PACKAGE_LIBCGROUP is not set
# BR2_PACKAGE_LIBCORRECT is not set
# BR2_PACKAGE_LIBCROCO is not set
# BR2_PACKAGE_LIBCROSSGUID is not set
# BR2_PACKAGE_LIBCSV is not set
# BR2_PACKAGE_LIBDAEMON is not set
# BR2_PACKAGE_LIBEE is not set
# BR2_PACKAGE_LIBEV is not set
# BR2_PACKAGE_LIBEVDEV is not set
# BR2_PACKAGE_LIBEVENT is not set
# BR2_PACKAGE_LIBFFI is not set
# BR2_PACKAGE_LIBGEE is not set
# BR2_PACKAGE_LIBGLIB2 is not set
# BR2_PACKAGE_LIBGLOB is not set
# BR2_PACKAGE_LIBICAL is not set
# BR2_PACKAGE_LIBITE is not set
# BR2_PACKAGE_LIBLINEAR is not set
# BR2_PACKAGE_LIBLOKI is not set
# BR2_PACKAGE_LIBNPTH is not set
BR2_PACKAGE_LIBNSPR_ARCH_SUPPORT=y
# BR2_PACKAGE_LIBNSPR is not set
# BR2_PACKAGE_LIBPFM4 is not set
# BR2_PACKAGE_LIBPLIST is not set
# BR2_PACKAGE_LIBPTHREAD_STUBS is not set
# BR2_PACKAGE_LIBPTHSEM is not set
# BR2_PACKAGE_LIBPWQUALITY is not set
# BR2_PACKAGE_LIBSIGC is not set
BR2_PACKAGE_LIBSIGSEGV_ARCH_SUPPORTS=y
# BR2_PACKAGE_LIBSIGSEGV is not set
# BR2_PACKAGE_LIBSPATIALINDEX is not set
# BR2_PACKAGE_LIBTASN1 is not set
# BR2_PACKAGE_LIBTOMMATH is not set
# BR2_PACKAGE_LIBTPL is not set
# BR2_PACKAGE_LIBUBOX is not set
# BR2_PACKAGE_LIBUCI is not set
BR2_PACKAGE_LIBURCU_ARCH_SUPPORTS=y
# BR2_PACKAGE_LIBURCU is not set
# BR2_PACKAGE_LIBUV is not set
# BR2_PACKAGE_LIGHTNING is not set
# BR2_PACKAGE_LINUX_PAM is not set
# BR2_PACKAGE_LIQUID_DSP is not set
# BR2_PACKAGE_LTTNG_LIBUST is not set
# BR2_PACKAGE_MPC is not set
# BR2_PACKAGE_MPDECIMAL is not set
# BR2_PACKAGE_MPFR is not set
# BR2_PACKAGE_MPIR is not set
# BR2_PACKAGE_MSGPACK is not set
# BR2_PACKAGE_MTDEV2TUIO is not set
# BR2_PACKAGE_ORC is not set
# BR2_PACKAGE_P11_KIT is not set
BR2_PACKAGE_PROTOBUF_ARCH_SUPPORTS=y
# BR2_PACKAGE_PROTOBUF is not set
# BR2_PACKAGE_PROTOBUF_C is not set
# BR2_PACKAGE_QHULL is not set
# BR2_PACKAGE_QLIBC is not set
# BR2_PACKAGE_RIEMANN_C_CLIENT is not set
# BR2_PACKAGE_SHAPELIB is not set
# BR2_PACKAGE_SKALIBS is not set
# BR2_PACKAGE_SPHINXBASE is not set
# BR2_PACKAGE_TINYCBOR is not set
# BR2_PACKAGE_UVW is not set
# BR2_PACKAGE_XAPIAN is not set

#
# Security
#
# BR2_PACKAGE_LIBSELINUX is not set
# BR2_PACKAGE_LIBSEPOL is not set
# BR2_PACKAGE_SAFECLIB is not set

#
# Text and terminal handling
#
# BR2_PACKAGE_AUGEAS is not set
# BR2_PACKAGE_ENCHANT is not set
# BR2_PACKAGE_FMT is not set
# BR2_PACKAGE_FSTRCMP is not set
# BR2_PACKAGE_ICU is not set
# BR2_PACKAGE_LIBCLI is not set
# BR2_PACKAGE_LIBEDIT is not set
# BR2_PACKAGE_LIBENCA is not set
# BR2_PACKAGE_LIBESTR is not set
# BR2_PACKAGE_LIBFRIBIDI is not set
# BR2_PACKAGE_LIBUNISTRING is not set
# BR2_PACKAGE_LINENOISE is not set
# BR2_PACKAGE_NCURSES is not set
# BR2_PACKAGE_NEWT is not set
# BR2_PACKAGE_ONIGURUMA is not set
# BR2_PACKAGE_PCRE is not set
# BR2_PACKAGE_PCRE2 is not set
# BR2_PACKAGE_POPT is not set
# BR2_PACKAGE_READLINE is not set
# BR2_PACKAGE_SLANG is not set
# BR2_PACKAGE_TCLAP is not set
# BR2_PACKAGE_UTF8PROC is not set

#
# Mail
#
# BR2_PACKAGE_DOVECOT is not set
# BR2_PACKAGE_EXIM is not set
# BR2_PACKAGE_FETCHMAIL is not set
# BR2_PACKAGE_HEIRLOOM_MAILX is not set
# BR2_PACKAGE_LIBESMTP is not set
# BR2_PACKAGE_MSMTP is not set
# BR2_PACKAGE_MUTT is not set

#
# Miscellaneous
#
# BR2_PACKAGE_AESPIPE is not set
# BR2_PACKAGE_BC is not set
BR2_PACKAGE_BITCOIN_ARCH_SUPPORTS=y
# BR2_PACKAGE_BITCOIN is not set
# BR2_PACKAGE_CLAMAV is not set
# BR2_PACKAGE_COLLECTD is not set
# BR2_PACKAGE_COLLECTL is not set

#
# domoticz needs lua 5.3 and a toolchain w/ C++, gcc >= 4.8, NPTL, wchar, dynamic library
#
# BR2_PACKAGE_EMPTY is not set
# BR2_PACKAGE_GNURADIO is not set
# BR2_PACKAGE_GOOGLEFONTDIRECTORY is not set

#
# gqrx needs a toolchain w/ C++, threads, wchar, dynamic library
#

#
# gqrx needs qt5
#
# BR2_PACKAGE_GSETTINGS_DESKTOP_SCHEMAS is not set
# BR2_PACKAGE_HAVEGED is not set
# BR2_PACKAGE_LINUX_SYSCALL_SUPPORT is not set
# BR2_PACKAGE_MCRYPT is not set
# BR2_PACKAGE_MOBILE_BROADBAND_PROVIDER_INFO is not set
# BR2_PACKAGE_PROJ is not set
# BR2_PACKAGE_QPDF is not set
# BR2_PACKAGE_SHARED_MIME_INFO is not set
# BR2_PACKAGE_SUNWAIT is not set
# BR2_PACKAGE_TASKD is not set
# BR2_PACKAGE_XUTIL_UTIL_MACROS is not set

#
# Networking applications
#
# BR2_PACKAGE_AIRCRACK_NG is not set
# BR2_PACKAGE_AOETOOLS is not set
# BR2_PACKAGE_APACHE is not set
# BR2_PACKAGE_ARGUS is not set
# BR2_PACKAGE_ARP_SCAN is not set
# BR2_PACKAGE_ARPTABLES is not set
# BR2_PACKAGE_ASTERISK is not set
# BR2_PACKAGE_ATFTP is not set
# BR2_PACKAGE_AVAHI is not set
# BR2_PACKAGE_AXEL is not set
# BR2_PACKAGE_BABELD is not set
# BR2_PACKAGE_BANDWIDTHD is not set
# BR2_PACKAGE_BATCTL is not set
# BR2_PACKAGE_BCUSDK is not set
# BR2_PACKAGE_BIND is not set
# BR2_PACKAGE_BIRD is not set
# BR2_PACKAGE_BLUEZ_UTILS is not set
# BR2_PACKAGE_BLUEZ5_UTILS is not set
# BR2_PACKAGE_BMON is not set
# BR2_PACKAGE_BOA is not set
# BR2_PACKAGE_BOINC is not set
# BR2_PACKAGE_BRCM_PATCHRAM_PLUS is not set
# BR2_PACKAGE_BRIDGE_UTILS is not set
# BR2_PACKAGE_BWM_NG is not set
# BR2_PACKAGE_C_ICAP is not set
# BR2_PACKAGE_CAN_UTILS is not set
# BR2_PACKAGE_CANNELLONI is not set
# BR2_PACKAGE_CHRONY is not set
# BR2_PACKAGE_CIVETWEB is not set
# BR2_PACKAGE_CONNMAN is not set

#
# connman-gtk needs libgtk3 and a glibc or uClibc toolchain w/ wchar, threads, resolver, dynamic library
#
# BR2_PACKAGE_CONNTRACK_TOOLS is not set
# BR2_PACKAGE_CORKSCREW is not set
# BR2_PACKAGE_CRDA is not set
# BR2_PACKAGE_CTORRENT is not set
# BR2_PACKAGE_CUPS is not set
# BR2_PACKAGE_DANTE is not set
# BR2_PACKAGE_DARKHTTPD is not set
# BR2_PACKAGE_DEHYDRATED is not set
# BR2_PACKAGE_DHCPCD is not set
# BR2_PACKAGE_DHCPDUMP is not set
# BR2_PACKAGE_DNSMASQ is not set
# BR2_PACKAGE_DRBD_UTILS is not set
# BR2_PACKAGE_DROPBEAR is not set
# BR2_PACKAGE_EBTABLES is not set

#
# ejabberd needs erlang, toolchain w/ C++
#
# BR2_PACKAGE_ETHTOOL is not set
# BR2_PACKAGE_FAIFA is not set
# BR2_PACKAGE_FASTD is not set
# BR2_PACKAGE_FCGIWRAP is not set
# BR2_PACKAGE_FPING is not set
# BR2_PACKAGE_FREESWITCH is not set
# BR2_PACKAGE_GERBERA is not set
# BR2_PACKAGE_GESFTPSERVER is not set
# BR2_PACKAGE_GLORYTUN is not set

#
# gupnp-tools needs libgtk3
#
# BR2_PACKAGE_HANS is not set
BR2_PACKAGE_HAPROXY_ARCH_SUPPORTS=y
# BR2_PACKAGE_HAPROXY is not set
# BR2_PACKAGE_HIAWATHA is not set
# BR2_PACKAGE_HOSTAPD is not set
# BR2_PACKAGE_HTTPING is not set
# BR2_PACKAGE_I2PD is not set
# BR2_PACKAGE_IBRDTN_TOOLS is not set
# BR2_PACKAGE_IBRDTND is not set
# BR2_PACKAGE_IFMETRIC is not set
# BR2_PACKAGE_IFTOP is not set
BR2_PACKAGE_IFUPDOWN_SCRIPTS=y
# BR2_PACKAGE_IGD2_FOR_LINUX is not set
# BR2_PACKAGE_IGH_ETHERCAT is not set
# BR2_PACKAGE_IGMPPROXY is not set
# BR2_PACKAGE_INADYN is not set
# BR2_PACKAGE_IODINE is not set
# BR2_PACKAGE_IPERF is not set
# BR2_PACKAGE_IPERF3 is not set
# BR2_PACKAGE_IPROUTE2 is not set
# BR2_PACKAGE_IPSEC_TOOLS is not set
# BR2_PACKAGE_IPSET is not set
# BR2_PACKAGE_IPTABLES is not set
# BR2_PACKAGE_IPTRAF_NG is not set
# BR2_PACKAGE_IPUTILS is not set
# BR2_PACKAGE_IRSSI is not set
# BR2_PACKAGE_IW is not set
# BR2_PACKAGE_IWD is not set
# BR2_PACKAGE_JANUS_GATEWAY is not set
# BR2_PACKAGE_KEEPALIVED is not set
# BR2_PACKAGE_KISMET is not set
# BR2_PACKAGE_KNOCK is not set
# BR2_PACKAGE_LEAFNODE2 is not set
# BR2_PACKAGE_LFT is not set
# BR2_PACKAGE_LFTP is not set
# BR2_PACKAGE_LIGHTTPD is not set
# BR2_PACKAGE_LINKNX is not set
# BR2_PACKAGE_LINKS is not set
# BR2_PACKAGE_LINPHONE is not set
# BR2_PACKAGE_LINUX_ZIGBEE is not set
# BR2_PACKAGE_LINUXPTP is not set
# BR2_PACKAGE_LLDPD is not set
# BR2_PACKAGE_LRZSZ is not set
# BR2_PACKAGE_LYNX is not set
# BR2_PACKAGE_MACCHANGER is not set
# BR2_PACKAGE_MEMCACHED is not set
# BR2_PACKAGE_MII_DIAG is not set
# BR2_PACKAGE_MINI_SNMPD is not set
# BR2_PACKAGE_MINIDLNA is not set
# BR2_PACKAGE_MINISSDPD is not set
# BR2_PACKAGE_MJPG_STREAMER is not set
# BR2_PACKAGE_MODEM_MANAGER is not set
BR2_PACKAGE_MONGREL2_LIBC_SUPPORTS=y
# BR2_PACKAGE_MONGREL2 is not set
# BR2_PACKAGE_MONKEY is not set
# BR2_PACKAGE_MOSH is not set
# BR2_PACKAGE_MOSQUITTO is not set
# BR2_PACKAGE_MROUTED is not set
# BR2_PACKAGE_MTR is not set
# BR2_PACKAGE_NBD is not set
# BR2_PACKAGE_NCFTP is not set
# BR2_PACKAGE_NDISC6 is not set
# BR2_PACKAGE_NETATALK is not set
# BR2_PACKAGE_NETPLUG is not set
# BR2_PACKAGE_NETSNMP is not set
# BR2_PACKAGE_NETSTAT_NAT is not set

#
# NetworkManager needs udev /dev management and a glibc toolchain w/ headers >= 3.2, dynamic library, wchar, threads
#
# BR2_PACKAGE_NFACCT is not set
# BR2_PACKAGE_NFTABLES is not set
# BR2_PACKAGE_NGINX is not set
# BR2_PACKAGE_NGIRCD is not set
# BR2_PACKAGE_NGREP is not set
# BR2_PACKAGE_NLOAD is not set
# BR2_PACKAGE_NMAP is not set
# BR2_PACKAGE_NOIP is not set
# BR2_PACKAGE_NTP is not set
# BR2_PACKAGE_NUTTCP is not set
# BR2_PACKAGE_ODHCP6C is not set
# BR2_PACKAGE_ODHCPLOC is not set
# BR2_PACKAGE_OLSR is not set
# BR2_PACKAGE_OPEN_LLDP is not set
# BR2_PACKAGE_OPEN_PLC_UTILS is not set
# BR2_PACKAGE_OPENNTPD is not set
# BR2_PACKAGE_OPENOBEX is not set
# BR2_PACKAGE_OPENRESOLV is not set
# BR2_PACKAGE_OPENSSH is not set
# BR2_PACKAGE_OPENSWAN is not set
# BR2_PACKAGE_OPENVPN is not set
# BR2_PACKAGE_P910ND is not set
# BR2_PACKAGE_PHIDGETWEBSERVICE is not set
# BR2_PACKAGE_PHYTOOL is not set
# BR2_PACKAGE_PIMD is not set
# BR2_PACKAGE_PIXIEWPS is not set
# BR2_PACKAGE_POUND is not set
# BR2_PACKAGE_PPPD is not set
# BR2_PACKAGE_PPTP_LINUX is not set
# BR2_PACKAGE_PRIVOXY is not set
# BR2_PACKAGE_PROFTPD is not set

#
# prosody needs the lua interpreter, dynamic library
#
# BR2_PACKAGE_PROXYCHAINS_NG is not set
# BR2_PACKAGE_PTPD is not set
# BR2_PACKAGE_PTPD2 is not set
# BR2_PACKAGE_PURE_FTPD is not set
# BR2_PACKAGE_PUTTY is not set
# BR2_PACKAGE_QUAGGA is not set

#
# rabbitmq-server needs erlang
#
# BR2_PACKAGE_RADVD is not set
# BR2_PACKAGE_REAVER is not set
# BR2_PACKAGE_RP_PPPOE is not set
# BR2_PACKAGE_RPCBIND is not set
# BR2_PACKAGE_RSH_REDONE is not set
# BR2_PACKAGE_RSYNC is not set
# BR2_PACKAGE_RTORRENT is not set
# BR2_PACKAGE_RTPTOOLS is not set
# BR2_PACKAGE_RYGEL is not set
# BR2_PACKAGE_S6_DNS is not set
# BR2_PACKAGE_S6_NETWORKING is not set
# BR2_PACKAGE_SAMBA4 is not set
# BR2_PACKAGE_SCONESERVER is not set
# BR2_PACKAGE_SER2NET is not set
# BR2_PACKAGE_SHADOWSOCKS_LIBEV is not set
# BR2_PACKAGE_SHAIRPORT_SYNC is not set
# BR2_PACKAGE_SHELLINABOX is not set
# BR2_PACKAGE_SMCROUTE is not set
# BR2_PACKAGE_SNGREP is not set
# BR2_PACKAGE_SNORT is not set
# BR2_PACKAGE_SOCAT is not set
# BR2_PACKAGE_SOCKETCAND is not set
# BR2_PACKAGE_SOFTETHER is not set
# BR2_PACKAGE_SPAWN_FCGI is not set
# BR2_PACKAGE_SPICE_PROTOCOL is not set
# BR2_PACKAGE_SQUID is not set
# BR2_PACKAGE_SSHGUARD is not set
# BR2_PACKAGE_SSHPASS is not set
# BR2_PACKAGE_SSLH is not set
# BR2_PACKAGE_STRONGSWAN is not set
# BR2_PACKAGE_STUNNEL is not set
# BR2_PACKAGE_SURICATA is not set
# BR2_PACKAGE_TCPDUMP is not set
# BR2_PACKAGE_TCPING is not set
# BR2_PACKAGE_TCPREPLAY is not set
# BR2_PACKAGE_THTTPD is not set
# BR2_PACKAGE_TINC is not set
# BR2_PACKAGE_TINYHTTPD is not set
# BR2_PACKAGE_TOR is not set
# BR2_PACKAGE_TRACEROUTE is not set
# BR2_PACKAGE_TRANSMISSION is not set
# BR2_PACKAGE_TUNCTL is not set
# BR2_PACKAGE_TVHEADEND is not set
# BR2_PACKAGE_UACME is not set
# BR2_PACKAGE_UDPCAST is not set
# BR2_PACKAGE_UFTP is not set
# BR2_PACKAGE_UHTTPD is not set
# BR2_PACKAGE_ULOGD is not set
# BR2_PACKAGE_USHARE is not set
# BR2_PACKAGE_USSP_PUSH is not set
# BR2_PACKAGE_VDE2 is not set
# BR2_PACKAGE_VDR is not set
# BR2_PACKAGE_VNSTAT is not set
# BR2_PACKAGE_VPNC is not set
# BR2_PACKAGE_VSFTPD is not set
# BR2_PACKAGE_VTUN is not set
# BR2_PACKAGE_WAVEMON is not set
# BR2_PACKAGE_WIREGUARD is not set
# BR2_PACKAGE_WIRELESS_REGDB is not set
# BR2_PACKAGE_WIRELESS_TOOLS is not set
# BR2_PACKAGE_WIRESHARK is not set
# BR2_PACKAGE_WPA_SUPPLICANT is not set
# BR2_PACKAGE_WPAN_TOOLS is not set
# BR2_PACKAGE_XINETD is not set
# BR2_PACKAGE_XL2TP is not set
# BR2_PACKAGE_XTABLES_ADDONS is not set
# BR2_PACKAGE_ZNC is not set

#
# Package managers
#

#
# -------------------------------------------------------
#

#
# Please note:                                           
#

#
# - Buildroot does *not* generate binary packages,       
#

#
# - Buildroot does *not* install any package database.   
#

#
# *                                                      
#

#
# It is up to you to provide those by yourself if you    
#

#
# want to use any of those package managers.             
#

#
# *                                                      
#

#
# See the manual:                                        
#

#
# http://buildroot.org/manual.html#faq-no-binary-packages
#

#
# -------------------------------------------------------
#
# BR2_PACKAGE_OPKG is not set

#
# Real-Time
#
# BR2_PACKAGE_XENOMAI is not set

#
# Security
#
# BR2_PACKAGE_CHECKPOLICY is not set
# BR2_PACKAGE_IMA_EVM_UTILS is not set
# BR2_PACKAGE_OPTEE_BENCHMARK is not set
# BR2_PACKAGE_OPTEE_CLIENT is not set
# BR2_PACKAGE_PAXTEST is not set
# BR2_PACKAGE_RESTORECOND is not set
# BR2_PACKAGE_SELINUX_PYTHON is not set
# BR2_PACKAGE_SEMODULE_UTILS is not set
# BR2_PACKAGE_SETOOLS is not set

#
# Shell and utilities
#

#
# Shells
#
# BR2_PACKAGE_MKSH is not set
# BR2_PACKAGE_ZSH is not set

#
# Utilities
#
# BR2_PACKAGE_AT is not set
# BR2_PACKAGE_CCRYPT is not set
# BR2_PACKAGE_DIALOG is not set
# BR2_PACKAGE_DTACH is not set
# BR2_PACKAGE_EASY_RSA is not set
# BR2_PACKAGE_FILE is not set
# BR2_PACKAGE_GNUPG is not set
# BR2_PACKAGE_GNUPG2 is not set
# BR2_PACKAGE_INOTIFY_TOOLS is not set
# BR2_PACKAGE_LOCKFILE_PROGS is not set
# BR2_PACKAGE_LOGROTATE is not set
# BR2_PACKAGE_LOGSURFER is not set
# BR2_PACKAGE_PDMENU is not set
# BR2_PACKAGE_PINENTRY is not set
# BR2_PACKAGE_RANGER is not set
# BR2_PACKAGE_SCREEN is not set
# BR2_PACKAGE_SUDO is not set
# BR2_PACKAGE_TINI is not set
# BR2_PACKAGE_TMUX is not set
# BR2_PACKAGE_XMLSTARLET is not set
# BR2_PACKAGE_XXHASH is not set
# BR2_PACKAGE_YTREE is not set

#
# System tools
#
# BR2_PACKAGE_ACL is not set
# BR2_PACKAGE_ANDROID_TOOLS is not set
# BR2_PACKAGE_ATOP is not set
# BR2_PACKAGE_ATTR is not set
# BR2_PACKAGE_CGROUPFS_MOUNT is not set

#
# circus needs Python 3 and a toolchain w/ C++, threads
#
# BR2_PACKAGE_CPULOAD is not set
# BR2_PACKAGE_DAEMON is not set
# BR2_PACKAGE_DC3DD is not set
# BR2_PACKAGE_DDRESCUE is not set
# BR2_PACKAGE_DOCKER_COMPOSE is not set
# BR2_PACKAGE_EMLOG is not set
# BR2_PACKAGE_FTOP is not set
# BR2_PACKAGE_GETENT is not set
# BR2_PACKAGE_HTOP is not set
BR2_PACKAGE_INITSCRIPTS=y

#
# iotop depends on python or python3
#
# BR2_PACKAGE_IPRUTILS is not set
# BR2_PACKAGE_IRQBALANCE is not set
# BR2_PACKAGE_KEYUTILS is not set
# BR2_PACKAGE_KMOD is not set
# BR2_PACKAGE_LIBOSTREE is not set
# BR2_PACKAGE_LXC is not set
# BR2_PACKAGE_MONIT is not set
# BR2_PACKAGE_NCDU is not set

#
# netifrc needs openrc as init system
#
# BR2_PACKAGE_NUT is not set

#
# pamtester depends on linux-pam
#
# BR2_PACKAGE_POLKIT is not set
# BR2_PACKAGE_PROCRANK_LINUX is not set
# BR2_PACKAGE_PWGEN is not set
# BR2_PACKAGE_QUOTA is not set
# BR2_PACKAGE_QUOTATOOL is not set
# BR2_PACKAGE_RAUC is not set
# BR2_PACKAGE_S6 is not set
# BR2_PACKAGE_S6_LINUX_INIT is not set
# BR2_PACKAGE_S6_LINUX_UTILS is not set
# BR2_PACKAGE_S6_PORTABLE_UTILS is not set
# BR2_PACKAGE_S6_RC is not set
# BR2_PACKAGE_SCRUB is not set
# BR2_PACKAGE_SCRYPT is not set
# BR2_PACKAGE_SMACK is not set

#
# supervisor needs a python interpreter
#
# BR2_PACKAGE_SWUPDATE is not set
BR2_PACKAGE_SYSTEMD_ARCH_SUPPORTS=y
# BR2_PACKAGE_TPM_TOOLS is not set
# BR2_PACKAGE_TPM2_ABRMD is not set
# BR2_PACKAGE_TPM2_TOOLS is not set
# BR2_PACKAGE_TPM2_TOTP is not set
# BR2_PACKAGE_UNSCD is not set
# BR2_PACKAGE_UTIL_LINUX is not set

#
# Text editors and viewers
#
# BR2_PACKAGE_ED is not set
# BR2_PACKAGE_JOE is not set
# BR2_PACKAGE_MC is not set
# BR2_PACKAGE_MOST is not set
# BR2_PACKAGE_NANO is not set
# BR2_PACKAGE_UEMACS is not set

#
# Filesystem images
#
# BR2_TARGET_ROOTFS_AXFS is not set
# BR2_TARGET_ROOTFS_BTRFS is not set
# BR2_TARGET_ROOTFS_CLOOP is not set
# BR2_TARGET_ROOTFS_CPIO is not set
# BR2_TARGET_ROOTFS_CRAMFS is not set
BR2_TARGET_ROOTFS_EXT2=y
BR2_TARGET_ROOTFS_EXT2_2=y
# BR2_TARGET_ROOTFS_EXT2_2r0 is not set
BR2_TARGET_ROOTFS_EXT2_2r1=y
# BR2_TARGET_ROOTFS_EXT2_3 is not set
# BR2_TARGET_ROOTFS_EXT2_4 is not set
BR2_TARGET_ROOTFS_EXT2_GEN=2
BR2_TARGET_ROOTFS_EXT2_REV=1
BR2_TARGET_ROOTFS_EXT2_LABEL=""
BR2_TARGET_ROOTFS_EXT2_SIZE="60M"
BR2_TARGET_ROOTFS_EXT2_INODES=0
BR2_TARGET_ROOTFS_EXT2_RESBLKS=5
BR2_TARGET_ROOTFS_EXT2_MKFS_OPTIONS="-O ^64bit"
BR2_TARGET_ROOTFS_EXT2_NONE=y
# BR2_TARGET_ROOTFS_EXT2_GZIP is not set
# BR2_TARGET_ROOTFS_EXT2_BZIP2 is not set
# BR2_TARGET_ROOTFS_EXT2_LZ4 is not set
# BR2_TARGET_ROOTFS_EXT2_LZMA is not set
# BR2_TARGET_ROOTFS_EXT2_LZO is not set
# BR2_TARGET_ROOTFS_EXT2_XZ is not set
# BR2_TARGET_ROOTFS_F2FS is not set
# BR2_TARGET_ROOTFS_INITRAMFS is not set
# BR2_TARGET_ROOTFS_JFFS2 is not set
# BR2_TARGET_ROOTFS_ROMFS is not set
# BR2_TARGET_ROOTFS_SQUASHFS is not set
BR2_TARGET_ROOTFS_TAR=y
BR2_TARGET_ROOTFS_TAR_NONE=y
# BR2_TARGET_ROOTFS_TAR_GZIP is not set
# BR2_TARGET_ROOTFS_TAR_BZIP2 is not set
# BR2_TARGET_ROOTFS_TAR_LZ4 is not set
# BR2_TARGET_ROOTFS_TAR_LZMA is not set
# BR2_TARGET_ROOTFS_TAR_LZO is not set
# BR2_TARGET_ROOTFS_TAR_XZ is not set
BR2_TARGET_ROOTFS_TAR_OPTIONS=""
# BR2_TARGET_ROOTFS_UBI is not set
# BR2_TARGET_ROOTFS_UBIFS is not set
# BR2_TARGET_ROOTFS_YAFFS2 is not set

#
# Bootloaders
#
# BR2_TARGET_BAREBOX is not set
BR2_TARGET_OPENSBI=y
BR2_TARGET_OPENSBI_PLAT="qemu/virt"
# BR2_TARGET_OPENSBI_LINUX_PAYLOAD is not set
# BR2_TARGET_UBOOT is not set

#
# Host utilities
#
# BR2_PACKAGE_HOST_AESPIPE is not set
# BR2_PACKAGE_HOST_ANDROID_TOOLS is not set
# BR2_PACKAGE_HOST_BTRFS_PROGS is not set
# BR2_PACKAGE_HOST_CARGO is not set
# BR2_PACKAGE_HOST_CHECKPOLICY is not set
# BR2_PACKAGE_HOST_CHECKSEC is not set
# BR2_PACKAGE_HOST_CMAKE is not set
# BR2_PACKAGE_HOST_CRAMFS is not set
# BR2_PACKAGE_HOST_CRYPTSETUP is not set
# BR2_PACKAGE_HOST_DBUS_PYTHON is not set
# BR2_PACKAGE_HOST_DFU_UTIL is not set
# BR2_PACKAGE_HOST_DOS2UNIX is not set
# BR2_PACKAGE_HOST_DOSFSTOOLS is not set
# BR2_PACKAGE_HOST_DTC is not set
BR2_PACKAGE_HOST_E2FSPROGS=y
# BR2_PACKAGE_HOST_E2TOOLS is not set
# BR2_PACKAGE_HOST_F2FS_TOOLS is not set
# BR2_PACKAGE_HOST_FAKETIME is not set
# BR2_PACKAGE_HOST_FATCAT is not set
# BR2_PACKAGE_HOST_FWUP is not set
# BR2_PACKAGE_HOST_GENEXT2FS is not set
# BR2_PACKAGE_HOST_GENIMAGE is not set
# BR2_PACKAGE_HOST_GENPART is not set
# BR2_PACKAGE_HOST_GNUPG is not set
BR2_PACKAGE_HOST_GO_HOST_ARCH_SUPPORTS=y
BR2_PACKAGE_HOST_GO_BOOTSTRAP_ARCH_SUPPORTS=y
BR2_PACKAGE_HOST_GOOGLE_BREAKPAD_ARCH_SUPPORTS=y
# BR2_PACKAGE_HOST_GPTFDISK is not set
# BR2_PACKAGE_HOST_IMAGEMAGICK is not set
# BR2_PACKAGE_HOST_IMX_MKIMAGE is not set
# BR2_PACKAGE_HOST_JQ is not set
# BR2_PACKAGE_HOST_JSMIN is not set
# BR2_PACKAGE_HOST_LIBP11 is not set
# BR2_PACKAGE_HOST_LPC3250LOADER is not set
# BR2_PACKAGE_HOST_LTTNG_BABELTRACE is not set
# BR2_PACKAGE_HOST_MENDER_ARTIFACT is not set
# BR2_PACKAGE_HOST_MKPASSWD is not set
# BR2_PACKAGE_HOST_MTD is not set
# BR2_PACKAGE_HOST_MTOOLS is not set
# BR2_PACKAGE_HOST_OPENOCD is not set
# BR2_PACKAGE_HOST_OPKG_UTILS is not set
# BR2_PACKAGE_HOST_PARTED is not set
BR2_PACKAGE_HOST_PATCHELF=y
# BR2_PACKAGE_HOST_PKGCONF is not set
# BR2_PACKAGE_HOST_PWGEN is not set
# BR2_PACKAGE_HOST_PYTHON is not set
# BR2_PACKAGE_HOST_PYTHON_CYTHON is not set
# BR2_PACKAGE_HOST_PYTHON_LXML is not set
# BR2_PACKAGE_HOST_PYTHON_SIX is not set
# BR2_PACKAGE_HOST_PYTHON_XLRD is not set
# BR2_PACKAGE_HOST_PYTHON3 is not set
BR2_PACKAGE_HOST_QEMU_ARCH_SUPPORTS=y
BR2_PACKAGE_HOST_QEMU_SYSTEM_ARCH_SUPPORTS=y
BR2_PACKAGE_HOST_QEMU_USER_ARCH_SUPPORTS=y
BR2_PACKAGE_HOST_QEMU=y

#
# Emulators selection
#
BR2_PACKAGE_HOST_QEMU_SYSTEM_MODE=y
# BR2_PACKAGE_HOST_QEMU_LINUX_USER_MODE is not set
# BR2_PACKAGE_HOST_QEMU_VDE2 is not set
# BR2_PACKAGE_HOST_QEMU_VIRTFS is not set
# BR2_PACKAGE_HOST_QEMU_USB is not set
# BR2_PACKAGE_HOST_RAUC is not set
# BR2_PACKAGE_HOST_RCW is not set
BR2_PACKAGE_HOST_RUSTC_ARCH_SUPPORTS=y
BR2_PACKAGE_HOST_RUSTC_ARCH="riscv64"
# BR2_PACKAGE_HOST_RUSTC is not set
BR2_PACKAGE_PROVIDES_HOST_RUSTC="host-rust-bin"
# BR2_PACKAGE_HOST_SAM_BA is not set
# BR2_PACKAGE_HOST_SQUASHFS is not set
# BR2_PACKAGE_HOST_SWIG is not set
# BR2_PACKAGE_HOST_UBOOT_TOOLS is not set
BR2_PACKAGE_HOST_UTIL_LINUX=y
# BR2_PACKAGE_HOST_UTP_COM is not set
# BR2_PACKAGE_HOST_VBOOT_UTILS is not set
# BR2_PACKAGE_HOST_XORRISO is not set
# BR2_PACKAGE_HOST_ZIP is not set
# BR2_PACKAGE_HOST_ZSTD is not set

#
# Legacy config options
#

#
# Legacy options removed in 2019.11
#
# BR2_PACKAGE_OPENVMTOOLS_PROCPS is not set
# BR2_PACKAGE_ALLJOYN is not set
# BR2_PACKAGE_ALLJOYN_BASE is not set
# BR2_PACKAGE_ALLJOYN_BASE_CONTROLPANEL is not set
# BR2_PACKAGE_ALLJOYN_BASE_NOTIFICATION is not set
# BR2_PACKAGE_ALLJOYN_BASE_ONBOARDING is not set
# BR2_PACKAGE_ALLJOYN_TCL_BASE is not set
# BR2_PACKAGE_ALLJOYN_TCL is not set
BR2_TOOLCHAIN_EXTRA_EXTERNAL_LIBS=""
# BR2_PACKAGE_PYTHON_PYSNMP_APPS is not set
# BR2_KERNEL_HEADERS_5_2 is not set
# BR2_TARGET_RISCV_PK is not set
# BR2_PACKAGE_SQLITE_STAT3 is not set
# BR2_KERNEL_HEADERS_5_1 is not set
# BR2_PACKAGE_DEVMEM2 is not set
# BR2_PACKAGE_USTR is not set
# BR2_PACKAGE_KODI_SCREENSAVER_PLANESTATE is not set
# BR2_PACKAGE_KODI_VISUALISATION_WAVEFORHUE is not set
# BR2_PACKAGE_KODI_AUDIODECODER_OPUS is not set
# BR2_PACKAGE_MESA3D_OSMESA is not set
# BR2_PACKAGE_HOSTAPD_DRIVER_RTW is not set
# BR2_PACKAGE_WPA_SUPPLICANT_DBUS_NEW is not set
# BR2_PACKAGE_WPA_SUPPLICANT_DBUS_OLD is not set

#
# Legacy options removed in 2019.08
#
# BR2_TARGET_TS4800_MBRBOOT is not set
# BR2_PACKAGE_LIBAMCODEC is not set
# BR2_PACKAGE_ODROID_SCRIPTS is not set
# BR2_PACKAGE_ODROID_MALI is not set
# BR2_PACKAGE_KODI_PLATFORM_AML is not set
# BR2_GCC_VERSION_6_X is not set
# BR2_GCC_VERSION_4_9_X is not set
# BR2_GDB_VERSION_7_12 is not set
# BR2_PACKAGE_XAPP_MKFONTDIR is not set
# BR2_GDB_VERSION_8_0 is not set
# BR2_KERNEL_HEADERS_4_20 is not set
# BR2_KERNEL_HEADERS_5_0 is not set

#
# Legacy options removed in 2019.05
#
# BR2_CSKY_DSP is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_COMPOSITOR is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_IQA is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_OPENCV is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_STEREO is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_VCD is not set
# BR2_PACKAGE_LUNIT is not set
# BR2_PACKAGE_FFMPEG_FFSERVER is not set
# BR2_PACKAGE_LIBUMP is not set
# BR2_PACKAGE_SUNXI_MALI is not set
# BR2_BINUTILS_VERSION_2_29_X is not set
# BR2_BINUTILS_VERSION_2_28_X is not set
# BR2_PACKAGE_GST_PLUGINS_BAD_PLUGIN_APEXSINK is not set

#
# Legacy options removed in 2019.02
#
# BR2_PACKAGE_QT is not set
# BR2_PACKAGE_QTUIO is not set
# BR2_PACKAGE_PINENTRY_QT4 is not set
# BR2_PACKAGE_POPPLER_QT is not set
# BR2_PACKAGE_OPENCV3_WITH_QT is not set
# BR2_PACKAGE_OPENCV_WITH_QT is not set
# BR2_PACKAGE_AMD_CATALYST_CCCLE is not set
# BR2_PACKAGE_SDL_QTOPIA is not set
# BR2_PACKAGE_PYTHON_PYQT is not set
# BR2_PACKAGE_GNURADIO_QTGUI is not set
# BR2_PACKAGE_LUACRYPTO is not set
# BR2_PACKAGE_TN5250 is not set
# BR2_PACKAGE_BOOST_SIGNALS is not set
# BR2_PACKAGE_FFTW_PRECISION_SINGLE is not set
# BR2_PACKAGE_FFTW_PRECISION_DOUBLE is not set
# BR2_PACKAGE_FFTW_PRECISION_LONG_DOUBLE is not set
# BR2_PACKAGE_LUA_5_2 is not set
# BR2_TARGET_GENERIC_PASSWD_MD5 is not set

#
# Legacy options removed in 2018.11
#
# BR2_TARGET_XLOADER is not set
# BR2_PACKAGE_TIDSP_BINARIES is not set
# BR2_PACKAGE_DSP_TOOLS is not set
# BR2_PACKAGE_GST_DSP is not set
# BR2_PACKAGE_BOOTUTILS is not set
# BR2_PACKAGE_EXPEDITE is not set
# BR2_PACKAGE_MESA3D_OPENGL_TEXTURE_FLOAT is not set
# BR2_KERNEL_HEADERS_4_10 is not set
# BR2_KERNEL_HEADERS_4_11 is not set
# BR2_KERNEL_HEADERS_4_12 is not set
# BR2_KERNEL_HEADERS_4_13 is not set
# BR2_KERNEL_HEADERS_4_15 is not set
# BR2_KERNEL_HEADERS_4_17 is not set
# BR2_PACKAGE_LIBNFTNL_XML is not set
# BR2_KERNEL_HEADERS_3_2 is not set
# BR2_KERNEL_HEADERS_4_1 is not set
# BR2_KERNEL_HEADERS_4_16 is not set
# BR2_KERNEL_HEADERS_4_18 is not set

#
# Legacy options removed in 2018.08
#
# BR2_PACKAGE_DOCKER_ENGINE_STATIC_CLIENT is not set
# BR2_PACKAGE_XSERVER_XORG_SERVER_V_1_19 is not set
# BR2_PACKAGE_XPROTO_APPLEWMPROTO is not set
# BR2_PACKAGE_XPROTO_BIGREQSPROTO is not set
# BR2_PACKAGE_XPROTO_COMPOSITEPROTO is not set
# BR2_PACKAGE_XPROTO_DAMAGEPROTO is not set
# BR2_PACKAGE_XPROTO_DMXPROTO is not set
# BR2_PACKAGE_XPROTO_DRI2PROTO is not set
# BR2_PACKAGE_XPROTO_DRI3PROTO is not set
# BR2_PACKAGE_XPROTO_FIXESPROTO is not set
# BR2_PACKAGE_XPROTO_FONTCACHEPROTO is not set
# BR2_PACKAGE_XPROTO_FONTSPROTO is not set
# BR2_PACKAGE_XPROTO_GLPROTO is not set
# BR2_PACKAGE_XPROTO_INPUTPROTO is not set
# BR2_PACKAGE_XPROTO_KBPROTO is not set
# BR2_PACKAGE_XPROTO_PRESENTPROTO is not set
# BR2_PACKAGE_XPROTO_RANDRPROTO is not set
# BR2_PACKAGE_XPROTO_RECORDPROTO is not set
# BR2_PACKAGE_XPROTO_RENDERPROTO is not set
# BR2_PACKAGE_XPROTO_RESOURCEPROTO is not set
# BR2_PACKAGE_XPROTO_SCRNSAVERPROTO is not set
# BR2_PACKAGE_XPROTO_VIDEOPROTO is not set
# BR2_PACKAGE_XPROTO_WINDOWSWMPROTO is not set
# BR2_PACKAGE_XPROTO_XCMISCPROTO is not set
# BR2_PACKAGE_XPROTO_XEXTPROTO is not set
# BR2_PACKAGE_XPROTO_XF86BIGFONTPROTO is not set
# BR2_PACKAGE_XPROTO_XF86DGAPROTO is not set
# BR2_PACKAGE_XPROTO_XF86DRIPROTO is not set
# BR2_PACKAGE_XPROTO_XF86VIDMODEPROTO is not set
# BR2_PACKAGE_XPROTO_XINERAMAPROTO is not set
# BR2_PACKAGE_XPROTO_XPROTO is not set
# BR2_PACKAGE_XPROTO_XPROXYMANAGEMENTPROTOCOL is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_LIB_OPENGL_OPENGL is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_LIB_OPENGL_GLES2 is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_LIB_OPENGL_GLX is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_LIB_OPENGL_EGL is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_LIB_OPENGL_X11 is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_LIB_OPENGL_WAYLAND is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_LIB_OPENGL_DISPMANX is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_AUDIOMIXER is not set
# BR2_PACKAGE_GST1_PLUGINS_UGLY_PLUGIN_LAME is not set
# BR2_PACKAGE_GST1_PLUGINS_UGLY_PLUGIN_MPG123 is not set
# BR2_GDB_VERSION_7_11 is not set
# BR2_GDB_VERSION_7_10 is not set

#
# Legacy options removed in 2018.05
#
# BR2_PACKAGE_MEDIAART_BACKEND_NONE is not set
# BR2_PACKAGE_MEDIAART_BACKEND_GDK_PIXBUF is not set
# BR2_PACKAGE_TI_SGX_AM335X is not set
# BR2_PACKAGE_TI_SGX_AM437X is not set
# BR2_PACKAGE_TI_SGX_AM4430 is not set
# BR2_PACKAGE_TI_SGX_AM5430 is not set
# BR2_PACKAGE_JANUS_AUDIO_BRIDGE is not set
# BR2_PACKAGE_JANUS_ECHO_TEST is not set
# BR2_PACKAGE_JANUS_RECORDPLAY is not set
# BR2_PACKAGE_JANUS_SIP_GATEWAY is not set
# BR2_PACKAGE_JANUS_STREAMING is not set
# BR2_PACKAGE_JANUS_TEXT_ROOM is not set
# BR2_PACKAGE_JANUS_VIDEO_CALL is not set
# BR2_PACKAGE_JANUS_VIDEO_ROOM is not set
# BR2_PACKAGE_JANUS_MQTT is not set
# BR2_PACKAGE_JANUS_RABBITMQ is not set
# BR2_PACKAGE_JANUS_REST is not set
# BR2_PACKAGE_JANUS_UNIX_SOCKETS is not set
# BR2_PACKAGE_JANUS_WEBSOCKETS is not set
# BR2_PACKAGE_IPSEC_SECCTX_DISABLE is not set
# BR2_PACKAGE_IPSEC_SECCTX_ENABLE is not set
# BR2_PACKAGE_IPSEC_SECCTX_KERNEL is not set
# BR2_PACKAGE_LIBTFDI_CPP is not set
# BR2_PACKAGE_JQUERY_UI_THEME_BLACK_TIE is not set
# BR2_PACKAGE_JQUERY_UI_THEME_BLITZER is not set
# BR2_PACKAGE_JQUERY_UI_THEME_CUPERTINO is not set
# BR2_PACKAGE_JQUERY_UI_THEME_DARK_HIVE is not set
# BR2_PACKAGE_JQUERY_UI_THEME_DOT_LUV is not set
# BR2_PACKAGE_JQUERY_UI_THEME_EGGPLANT is not set
# BR2_PACKAGE_JQUERY_UI_THEME_EXCITE_BIKE is not set
# BR2_PACKAGE_JQUERY_UI_THEME_FLICK is not set
# BR2_PACKAGE_JQUERY_UI_THEME_HOT_SNEAKS is not set
# BR2_PACKAGE_JQUERY_UI_THEME_HUMANITY is not set
# BR2_PACKAGE_JQUERY_UI_THEME_LE_FROG is not set
# BR2_PACKAGE_JQUERY_UI_THEME_MINT_CHOC is not set
# BR2_PACKAGE_JQUERY_UI_THEME_OVERCAST is not set
# BR2_PACKAGE_JQUERY_UI_THEME_PEPPER_GRINDER is not set
# BR2_PACKAGE_JQUERY_UI_THEME_REDMOND is not set
# BR2_PACKAGE_JQUERY_UI_THEME_SMOOTHNESS is not set
# BR2_PACKAGE_JQUERY_UI_THEME_SOUTH_STREET is not set
# BR2_PACKAGE_JQUERY_UI_THEME_START is not set
# BR2_PACKAGE_JQUERY_UI_THEME_SUNNY is not set
# BR2_PACKAGE_JQUERY_UI_THEME_SWANKY_PURSE is not set
# BR2_PACKAGE_JQUERY_UI_THEME_TRONTASTIC is not set
# BR2_PACKAGE_JQUERY_UI_THEME_UI_DARKNESS is not set
# BR2_PACKAGE_JQUERY_UI_THEME_UI_LIGHTNESS is not set
# BR2_PACKAGE_JQUERY_UI_THEME_VADER is not set
# BR2_PACKAGE_BLUEZ5_PLUGINS_HEALTH is not set
# BR2_PACKAGE_BLUEZ5_PLUGINS_MIDI is not set
# BR2_PACKAGE_BLUEZ5_PLUGINS_NFC is not set
# BR2_PACKAGE_BLUEZ5_PLUGINS_SAP is not set
# BR2_PACKAGE_BLUEZ5_PLUGINS_SIXAXIS is not set
# BR2_PACKAGE_TRANSMISSION_REMOTE is not set
# BR2_PACKAGE_LIBKCAPI_APPS is not set
# BR2_PACKAGE_MPLAYER is not set
# BR2_PACKAGE_MPLAYER_MPLAYER is not set
# BR2_PACKAGE_MPLAYER_MENCODER is not set
# BR2_PACKAGE_LIBPLAYER_MPLAYER is not set
# BR2_PACKAGE_IQVLINUX is not set
# BR2_BINFMT_FLAT_SEP_DATA is not set
# BR2_bfin is not set
# BR2_PACKAGE_KODI_ADSP_BASIC is not set
# BR2_PACKAGE_KODI_ADSP_FREESURROUND is not set

#
# Legacy options removed in 2018.02
#
# BR2_KERNEL_HEADERS_3_4 is not set
# BR2_KERNEL_HEADERS_3_10 is not set
# BR2_KERNEL_HEADERS_3_12 is not set
# BR2_BINUTILS_VERSION_2_27_X is not set
# BR2_PACKAGE_EEPROG is not set
# BR2_PACKAGE_GNUPG2_GPGV2 is not set
# BR2_PACKAGE_IMX_GPU_VIV_APITRACE is not set
# BR2_PACKAGE_IMX_GPU_VIV_G2D is not set

#
# Legacy options removed in 2017.11
#
# BR2_PACKAGE_RFKILL is not set
# BR2_PACKAGE_UTIL_LINUX_RESET is not set
# BR2_PACKAGE_POLICYCOREUTILS_AUDIT2ALLOW is not set
# BR2_PACKAGE_POLICYCOREUTILS_RESTORECOND is not set
# BR2_PACKAGE_SEPOLGEN is not set
# BR2_PACKAGE_OPENOBEX_BLUEZ is not set
# BR2_PACKAGE_OPENOBEX_LIBUSB is not set
# BR2_PACKAGE_OPENOBEX_APPS is not set
# BR2_PACKAGE_OPENOBEX_SYSLOG is not set
# BR2_PACKAGE_OPENOBEX_DUMP is not set
# BR2_PACKAGE_AICCU is not set
# BR2_PACKAGE_UTIL_LINUX_LOGIN_UTILS is not set

#
# Legacy options removed in 2017.08
#
# BR2_TARGET_GRUB is not set
# BR2_PACKAGE_SIMICSFS is not set
# BR2_BINUTILS_VERSION_2_26_X is not set
BR2_XTENSA_OVERLAY_DIR=""
BR2_XTENSA_CUSTOM_NAME=""
# BR2_PACKAGE_HOST_MKE2IMG is not set
BR2_TARGET_ROOTFS_EXT2_BLOCKS=0
BR2_TARGET_ROOTFS_EXT2_EXTRA_INODES=0
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_CDXAPARSE is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_DATAURISRC is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_DCCP is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_HDVPARSE is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_MVE is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_NUVDEMUX is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_PATCHDETECT is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_SDI is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_TTA is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_VIDEOMEASURE is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_APEXSINK is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_SDL is not set
# BR2_PACKAGE_GST1_PLUGINS_UGLY_PLUGIN_MAD is not set
# BR2_STRIP_none is not set
# BR2_PACKAGE_BEECRYPT_CPP is not set
# BR2_PACKAGE_SPICE_CLIENT is not set
# BR2_PACKAGE_SPICE_GUI is not set
# BR2_PACKAGE_SPICE_TUNNEL is not set
# BR2_PACKAGE_INPUT_TOOLS is not set
# BR2_PACKAGE_INPUT_TOOLS_INPUTATTACH is not set
# BR2_PACKAGE_INPUT_TOOLS_JSCAL is not set
# BR2_PACKAGE_INPUT_TOOLS_JSTEST is not set
# BR2_TOOLCHAIN_EXTERNAL_CODESOURCERY_SH is not set
# BR2_TOOLCHAIN_EXTERNAL_CODESOURCERY_X86 is not set
# BR2_GCC_VERSION_4_8_X is not set

#
# Legacy options removed in 2017.05
#
# BR2_PACKAGE_SUNXI_MALI_R2P4 is not set
# BR2_PACKAGE_NODEJS_MODULES_COFFEESCRIPT is not set
# BR2_PACKAGE_NODEJS_MODULES_EXPRESS is not set
# BR2_PACKAGE_BLUEZ5_UTILS_GATTTOOL is not set
# BR2_PACKAGE_OPENOCD_FT2XXX is not set
# BR2_PACKAGE_KODI_RTMPDUMP is not set
# BR2_PACKAGE_KODI_VISUALISATION_FOUNTAIN is not set
# BR2_PACKAGE_PORTMAP is not set
# BR2_BINUTILS_VERSION_2_25_X is not set
# BR2_TOOLCHAIN_BUILDROOT_INET_RPC is not set
BR2_TARGET_ROOTFS_EXT2_EXTRA_BLOCKS=0
# BR2_PACKAGE_SYSTEMD_KDBUS is not set
# BR2_PACKAGE_POLARSSL is not set
# BR2_NBD_CLIENT is not set
# BR2_NBD_SERVER is not set
# BR2_PACKAGE_GMOCK is not set
# BR2_KERNEL_HEADERS_4_8 is not set
# BR2_KERNEL_HEADERS_3_18 is not set
# BR2_GLIBC_VERSION_2_22 is not set

#
# Legacy options removed in 2017.02
#
# BR2_PACKAGE_PERL_DB_FILE is not set
# BR2_KERNEL_HEADERS_4_7 is not set
# BR2_KERNEL_HEADERS_4_6 is not set
# BR2_KERNEL_HEADERS_4_5 is not set
# BR2_KERNEL_HEADERS_3_14 is not set
# BR2_TOOLCHAIN_EXTERNAL_MUSL_CROSS is not set
# BR2_UCLIBC_INSTALL_TEST_SUITE is not set
# BR2_TOOLCHAIN_EXTERNAL_BLACKFIN_UCLINUX is not set
# BR2_PACKAGE_MAKEDEVS is not set
# BR2_TOOLCHAIN_EXTERNAL_ARAGO_ARMV7A is not set
# BR2_TOOLCHAIN_EXTERNAL_ARAGO_ARMV5TE is not set
# BR2_PACKAGE_SNOWBALL_HDMISERVICE is not set
# BR2_PACKAGE_SNOWBALL_INIT is not set
# BR2_GDB_VERSION_7_9 is not set

#
# Legacy options removed in 2016.11
#
# BR2_PACKAGE_PHP_SAPI_CLI_CGI is not set
# BR2_PACKAGE_PHP_SAPI_CLI_FPM is not set
# BR2_PACKAGE_WVSTREAMS is not set
# BR2_PACKAGE_WVDIAL is not set
# BR2_PACKAGE_WEBKITGTK24 is not set
# BR2_PACKAGE_TORSMO is not set
# BR2_PACKAGE_SSTRIP is not set
# BR2_KERNEL_HEADERS_4_3 is not set
# BR2_KERNEL_HEADERS_4_2 is not set
# BR2_PACKAGE_KODI_ADDON_XVDR is not set
# BR2_PACKAGE_IPKG is not set
# BR2_GCC_VERSION_4_7_X is not set
# BR2_BINUTILS_VERSION_2_24_X is not set
# BR2_PACKAGE_WESTON_RPI is not set
# BR2_LINUX_KERNEL_TOOL_CPUPOWER is not set
# BR2_LINUX_KERNEL_TOOL_PERF is not set
# BR2_LINUX_KERNEL_TOOL_SELFTESTS is not set
# BR2_GCC_VERSION_4_8_ARC is not set
# BR2_KERNEL_HEADERS_4_0 is not set
# BR2_KERNEL_HEADERS_3_19 is not set
# BR2_PACKAGE_LIBEVAS_GENERIC_LOADERS is not set
# BR2_PACKAGE_ELEMENTARY is not set
# BR2_LINUX_KERNEL_CUSTOM_LOCAL is not set

#
# Legacy options removed in 2016.08
#
# BR2_PACKAGE_EFL_JP2K is not set
# BR2_PACKAGE_SYSTEMD_COMPAT is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_LIVEADDER is not set
# BR2_PACKAGE_LIBFSLVPUWRAP is not set
# BR2_PACKAGE_LIBFSLPARSER is not set
# BR2_PACKAGE_LIBFSLCODEC is not set
# BR2_PACKAGE_UBOOT_TOOLS_MKIMAGE_FIT_SIGNATURE_SUPPORT is not set
# BR2_PTHREADS_OLD is not set
# BR2_BINUTILS_VERSION_2_23_X is not set
# BR2_TOOLCHAIN_BUILDROOT_EGLIBC is not set
# BR2_GDB_VERSION_7_8 is not set

#
# Legacy options removed in 2016.05
#
# BR2_PACKAGE_OPENVPN_CRYPTO_POLARSSL is not set
# BR2_PACKAGE_NGINX_HTTP_SPDY_MODULE is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_RTP is not set
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_MPG123 is not set
# BR2_TOOLCHAIN_EXTERNAL_CODESOURCERY_POWERPC is not set
# BR2_TOOLCHAIN_EXTERNAL_CODESOURCERY_POWERPC_E500V2 is not set
# BR2_x86_i386 is not set
# BR2_PACKAGE_QT5QUICK1 is not set
BR2_TARGET_UBOOT_CUSTOM_PATCH_DIR=""
# BR2_PACKAGE_XDRIVER_XF86_INPUT_VOID is not set
# BR2_KERNEL_HEADERS_3_17 is not set
# BR2_GDB_VERSION_7_7 is not set
# BR2_PACKAGE_FOOMATIC_FILTERS is not set
# BR2_PACKAGE_SAMBA is not set
# BR2_PACKAGE_KODI_WAVPACK is not set
# BR2_PACKAGE_KODI_RSXS is not set
# BR2_PACKAGE_KODI_GOOM is not set
# BR2_PACKAGE_SYSTEMD_ALL_EXTRAS is not set
# BR2_GCC_VERSION_4_5_X is not set
# BR2_PACKAGE_SQLITE_READLINE is not set

#
# Legacy options removed in 2016.02
#
# BR2_PACKAGE_DOVECOT_BZIP2 is not set
# BR2_PACKAGE_DOVECOT_ZLIB is not set
# BR2_PACKAGE_E2FSPROGS_FINDFS is not set
# BR2_PACKAGE_OPENPOWERLINK_DEBUG_LEVEL is not set
# BR2_PACKAGE_OPENPOWERLINK_KERNEL_MODULE is not set
# BR2_PACKAGE_OPENPOWERLINK_LIBPCAP is not set
# BR2_LINUX_KERNEL_SAME_AS_HEADERS is not set
# BR2_PACKAGE_CUPS_PDFTOPS is not set
# BR2_KERNEL_HEADERS_3_16 is not set
# BR2_PACKAGE_PYTHON_PYXML is not set
# BR2_ENABLE_SSP is not set
# BR2_PACKAGE_DIRECTFB_CLE266 is not set
# BR2_PACKAGE_DIRECTFB_UNICHROME is not set
# BR2_PACKAGE_LIBELEMENTARY is not set
# BR2_PACKAGE_LIBEINA is not set
# BR2_PACKAGE_LIBEET is not set
# BR2_PACKAGE_LIBEVAS is not set
# BR2_PACKAGE_LIBECORE is not set
# BR2_PACKAGE_LIBEDBUS is not set
# BR2_PACKAGE_LIBEFREET is not set
# BR2_PACKAGE_LIBEIO is not set
# BR2_PACKAGE_LIBEMBRYO is not set
# BR2_PACKAGE_LIBEDJE is not set
# BR2_PACKAGE_LIBETHUMB is not set
# BR2_PACKAGE_INFOZIP is not set
# BR2_BR2_PACKAGE_NODEJS_0_10_X is not set
# BR2_BR2_PACKAGE_NODEJS_0_12_X is not set
# BR2_BR2_PACKAGE_NODEJS_4_X is not set

#
# Legacy options removed in 2015.11
#
# BR2_PACKAGE_GST1_PLUGINS_BAD_PLUGIN_REAL is not set
# BR2_PACKAGE_MEDIA_CTL is not set
# BR2_PACKAGE_SCHIFRA is not set
# BR2_PACKAGE_ZXING is not set
# BR2_PACKAGE_BLACKBOX is not set
# BR2_KERNEL_HEADERS_3_0 is not set
# BR2_KERNEL_HEADERS_3_11 is not set
# BR2_KERNEL_HEADERS_3_13 is not set
# BR2_KERNEL_HEADERS_3_15 is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_ANDI is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_BLTLOAD is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_CPULOAD is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_DATABUFFER is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_DIOLOAD is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_DOK is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_DRIVERTEST is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_FIRE is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_FLIP is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_FONTS is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_INPUT is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_JOYSTICK is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_KNUCKLES is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_LAYER is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_MATRIX is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_MATRIX_WATER is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_NEO is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_NETLOAD is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_PALETTE is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_PARTICLE is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_PORTER is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_STRESS is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_TEXTURE is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_VIDEO is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_VIDEO_PARTICLE is not set
# BR2_PACKAGE_DIRECTFB_EXAMPLES_WINDOW is not set
# BR2_PACKAGE_KOBS_NG is not set
# BR2_PACKAGE_SAWMAN is not set
# BR2_PACKAGE_DIVINE is not set

#
# Legacy options removed in 2015.08
#
# BR2_PACKAGE_KODI_PVR_ADDONS is not set
# BR2_BINUTILS_VERSION_2_23_2 is not set
# BR2_BINUTILS_VERSION_2_24 is not set
# BR2_BINUTILS_VERSION_2_25 is not set
# BR2_PACKAGE_PERF is not set
# BR2_BINUTILS_VERSION_2_22 is not set
# BR2_PACKAGE_GPU_VIV_BIN_MX6Q is not set
# BR2_TARGET_UBOOT_NETWORK is not set

#
# Legacy options removed in 2015.05
#
# BR2_TARGET_ROOTFS_JFFS2_NANDFLASH_512_16K is not set
# BR2_TARGET_ROOTFS_JFFS2_NANDFLASH_2K_128K is not set
# BR2_PACKAGE_MONO_20 is not set
# BR2_PACKAGE_MONO_40 is not set
# BR2_PACKAGE_MONO_45 is not set
# BR2_CIVETWEB_WITH_LUA is not set
# BR2_PACKAGE_TIFF_TIFF2PDF is not set
# BR2_PACKAGE_TIFF_TIFFCP is not set
# BR2_LINUX_KERNEL_EXT_RTAI_PATCH is not set
# BR2_TARGET_GENERIC_PASSWD_DES is not set
# BR2_PACKAGE_GTK2_THEME_HICOLOR is not set
# BR2_PACKAGE_VALGRIND_PTRCHECK is not set

#
# Legacy options removed in 2015.02
#
# BR2_PACKAGE_LIBGC is not set
# BR2_PACKAGE_WDCTL is not set
# BR2_PACKAGE_UTIL_LINUX_ARCH is not set
# BR2_PACKAGE_UTIL_LINUX_DDATE is not set
# BR2_PACKAGE_RPM_BZIP2_PAYLOADS is not set
# BR2_PACKAGE_RPM_XZ_PAYLOADS is not set
# BR2_PACKAGE_M4 is not set
# BR2_PACKAGE_FLEX_BINARY is not set
# BR2_PACKAGE_BISON is not set
# BR2_PACKAGE_GOB2 is not set
# BR2_PACKAGE_DISTCC is not set
# BR2_PACKAGE_HASERL_VERSION_0_8_X is not set
# BR2_PACKAGE_STRONGSWAN_TOOLS is not set
# BR2_PACKAGE_XBMC_ADDON_XVDR is not set
# BR2_PACKAGE_XBMC_PVR_ADDONS is not set
# BR2_PACKAGE_XBMC is not set
# BR2_PACKAGE_XBMC_ALSA_LIB is not set
# BR2_PACKAGE_XBMC_AVAHI is not set
# BR2_PACKAGE_XBMC_DBUS is not set
# BR2_PACKAGE_XBMC_LIBBLURAY is not set
# BR2_PACKAGE_XBMC_GOOM is not set
# BR2_PACKAGE_XBMC_RSXS is not set
# BR2_PACKAGE_XBMC_LIBCEC is not set
# BR2_PACKAGE_XBMC_LIBMICROHTTPD is not set
# BR2_PACKAGE_XBMC_LIBNFS is not set
# BR2_PACKAGE_XBMC_RTMPDUMP is not set
# BR2_PACKAGE_XBMC_LIBSHAIRPLAY is not set
# BR2_PACKAGE_XBMC_LIBSMBCLIENT is not set
# BR2_PACKAGE_XBMC_LIBTHEORA is not set
# BR2_PACKAGE_XBMC_LIBUSB is not set
# BR2_PACKAGE_XBMC_LIBVA is not set
# BR2_PACKAGE_XBMC_WAVPACK is not set
# BR2_PREFER_STATIC_LIB is not set

#
# Legacy options removed in 2014.11
#
# BR2_x86_generic is not set
# BR2_GCC_VERSION_4_4_X is not set
# BR2_sparc_sparchfleon is not set
# BR2_sparc_sparchfleonv8 is not set
# BR2_sparc_sparcsfleon is not set
# BR2_sparc_sparcsfleonv8 is not set
# BR2_PACKAGE_LINUX_FIRMWARE_XC5000 is not set
# BR2_PACKAGE_LINUX_FIRMWARE_CXGB4 is not set
# BR2_PACKAGE_LINUX_FIRMWARE_IWLWIFI_3160_7260_7 is not set
# BR2_PACKAGE_LINUX_FIRMWARE_IWLWIFI_3160_7260_8 is not set

#
# Legacy options removed in 2014.08
#
# BR2_PACKAGE_LIBELF is not set
# BR2_KERNEL_HEADERS_3_8 is not set
# BR2_PACKAGE_GETTEXT_TOOLS is not set
# BR2_PACKAGE_PROCPS is not set
# BR2_BINUTILS_VERSION_2_20_1 is not set
# BR2_BINUTILS_VERSION_2_21 is not set
# BR2_BINUTILS_VERSION_2_23_1 is not set
# BR2_UCLIBC_VERSION_0_9_32 is not set
# BR2_GCC_VERSION_4_3_X is not set
# BR2_GCC_VERSION_4_6_X is not set
# BR2_GDB_VERSION_7_4 is not set
# BR2_GDB_VERSION_7_5 is not set
# BR2_BUSYBOX_VERSION_1_19_X is not set
# BR2_BUSYBOX_VERSION_1_20_X is not set
# BR2_BUSYBOX_VERSION_1_21_X is not set
# BR2_PACKAGE_LIBV4L_DECODE_TM6000 is not set
# BR2_PACKAGE_LIBV4L_IR_KEYTABLE is not set
# BR2_PACKAGE_LIBV4L_V4L2_COMPLIANCE is not set
# BR2_PACKAGE_LIBV4L_V4L2_CTL is not set
# BR2_PACKAGE_LIBV4L_V4L2_DBG is not set

#
# Legacy options removed in 2014.05
#
# BR2_PACKAGE_EVTEST_CAPTURE is not set
# BR2_KERNEL_HEADERS_3_6 is not set
# BR2_KERNEL_HEADERS_3_7 is not set
# BR2_PACKAGE_VALA is not set
BR2_PACKAGE_TZDATA_ZONELIST=""
# BR2_PACKAGE_LUA_INTERPRETER_EDITING_NONE is not set
# BR2_PACKAGE_LUA_INTERPRETER_READLINE is not set
# BR2_PACKAGE_LUA_INTERPRETER_LINENOISE is not set
# BR2_PACKAGE_DVB_APPS_UTILS is not set
# BR2_KERNEL_HEADERS_SNAP is not set
# BR2_ROOTFS_DEVICE_CREATION_DYNAMIC_UDEV is not set
# BR2_PACKAGE_UDEV is not set
# BR2_PACKAGE_UDEV_RULES_GEN is not set
# BR2_PACKAGE_UDEV_ALL_EXTRAS is not set

#
# Legacy options removed in 2014.02
#
# BR2_sh2 is not set
# BR2_sh3 is not set
# BR2_sh3eb is not set
# BR2_KERNEL_HEADERS_3_1 is not set
# BR2_KERNEL_HEADERS_3_3 is not set
# BR2_KERNEL_HEADERS_3_5 is not set
# BR2_GDB_VERSION_7_2 is not set
# BR2_GDB_VERSION_7_3 is not set
# BR2_PACKAGE_CCACHE is not set
# BR2_HAVE_DOCUMENTATION is not set
# BR2_PACKAGE_AUTOMAKE is not set
# BR2_PACKAGE_AUTOCONF is not set
# BR2_PACKAGE_XSTROKE is not set
# BR2_PACKAGE_LZMA is not set
# BR2_PACKAGE_TTCP is not set
# BR2_PACKAGE_LIBNFC_LLCP is not set
# BR2_PACKAGE_MYSQL_CLIENT is not set
# BR2_PACKAGE_SQUASHFS3 is not set
# BR2_TARGET_ROOTFS_SQUASHFS3 is not set
# BR2_PACKAGE_NETKITBASE is not set
# BR2_PACKAGE_NETKITTELNET is not set
# BR2_PACKAGE_LUASQL is not set
# BR2_PACKAGE_LUACJSON is not set

#
# Legacy options removed in 2013.11
#
# BR2_PACKAGE_LVM2_DMSETUP_ONLY is not set
# BR2_PACKAGE_QT_JAVASCRIPTCORE is not set
# BR2_PACKAGE_MODULE_INIT_TOOLS is not set
BR2_TARGET_UBOOT_CUSTOM_GIT_REPO_URL=""
BR2_TARGET_UBOOT_CUSTOM_GIT_VERSION=""
BR2_LINUX_KERNEL_CUSTOM_GIT_REPO_URL=""
BR2_LINUX_KERNEL_CUSTOM_GIT_VERSION=""

#
# Legacy options removed in 2013.08
#
# BR2_ARM_OABI is not set
# BR2_PACKAGE_DOSFSTOOLS_DOSFSCK is not set
# BR2_PACKAGE_DOSFSTOOLS_DOSFSLABEL is not set
# BR2_PACKAGE_DOSFSTOOLS_MKDOSFS is not set
# BR2_ELF2FLT is not set
# BR2_VFP_FLOAT is not set
# BR2_PACKAGE_GCC_TARGET is not set
# BR2_HAVE_DEVFILES is not set

--AhhlLboLdkugWU4S--
