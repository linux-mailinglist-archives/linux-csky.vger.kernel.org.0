Return-Path: <linux-csky+bounces-580-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C222B910C5F
	for <lists+linux-csky@lfdr.de>; Thu, 20 Jun 2024 18:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F56B1F21DC9
	for <lists+linux-csky@lfdr.de>; Thu, 20 Jun 2024 16:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01A41B4C51;
	Thu, 20 Jun 2024 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s3lH41X8"
X-Original-To: linux-csky@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE421B29CD;
	Thu, 20 Jun 2024 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900650; cv=none; b=jwijFbntAR6Zc2wbJd4GFCpAZ8a3MLtAzlTisLEKe6MCilA2+m1EvBSADFIglevoNcm6DbR37BO9aUoTUBtLKDWDnWI+V8F5VJ8j4Jw24pVnnHJ2Ysf/Wn1erlHbsTw6pBY3omVv3q1EZzAWJ/HPW1maGCddmlkedknncXRjOYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900650; c=relaxed/simple;
	bh=AKNrHrEDw/bOnYoPf4j9KvT8uWTmJp8Ho7k3J75gm1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BXQv3EDGaSuVJQDnhc49Rj9bmo21cC0L6DbktDLlBFRGgpg+aImSNvuQkHnjSKC8haHmPMXjhUz1h3oBlf2KduBlqOJq1hevWO358j6cXrMyOrelFd85purrzP5vzQKShTMl6FZd0bSqM+KfT2ZItbqWuWFWZTKaMI/x9nxaz+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s3lH41X8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D194C2BD10;
	Thu, 20 Jun 2024 16:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900649;
	bh=AKNrHrEDw/bOnYoPf4j9KvT8uWTmJp8Ho7k3J75gm1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s3lH41X8uDU30QzP5Uh6EeYrYgLqRUFP+ebyJttGbu+VgkA5y7tcuu8/kqZQ2ikmQ
	 gU8yhEWdkKRXWzgvg5ZDJL4ymc0Ww0dFKPwxkv11YMA6gQkFgxXH90lVqsXogLFizl
	 BllFCP1furlXvMwK5FHiiSSwMFZQyU5F/A9eCcqnsyAKF8P1yt5kr7Z2fwaeoX0YQw
	 8atG75dcfJ4Nv+kRMwjraopThlYyoK3sDXFeJXrd/yXTQpPo/8rrMH8ZiefnhYO1wX
	 FwPnV32KV/uXdZqYSFHQfBFTQMbLzOO9TtjsfZZAwYLazbdUAyCGJA1PVNH1L05a/n
	 GgQT6pXl8/k5Q==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mips@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	sparclinux@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	Brian Cain <bcain@quicinc.com>,
	linux-hexagon@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	libc-alpha@sourceware.org,
	musl@lists.openwall.com,
	ltp@lists.linux.it
Subject: [PATCH 05/15] sparc: fix compat recv/recvfrom syscalls
Date: Thu, 20 Jun 2024 18:23:06 +0200
Message-Id: <20240620162316.3674955-6-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240620162316.3674955-1-arnd@kernel.org>
References: <20240620162316.3674955-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

sparc has the wrong compat version of recv() and recvfrom() for both the
direct syscalls and socketcall().

The direct syscalls just need to use the compat version. For socketcall,
the same thing could be done, but it seems better to completely remove
the custom assembler code for it and just use the same implementation that
everyone else has.

Fixes: 1dacc76d0014 ("net/compat/wext: send different messages to compat tasks")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/sparc/kernel/sys32.S              | 221 -------------------------
 arch/sparc/kernel/syscalls/syscall.tbl |   4 +-
 2 files changed, 2 insertions(+), 223 deletions(-)

diff --git a/arch/sparc/kernel/sys32.S b/arch/sparc/kernel/sys32.S
index a45f0f31fe51..a3d308f2043e 100644
--- a/arch/sparc/kernel/sys32.S
+++ b/arch/sparc/kernel/sys32.S
@@ -18,224 +18,3 @@ sys32_mmap2:
 	sethi		%hi(sys_mmap), %g1
 	jmpl		%g1 + %lo(sys_mmap), %g0
 	 sllx		%o5, 12, %o5
-
-	.align		32
-	.globl		sys32_socketcall
-sys32_socketcall:	/* %o0=call, %o1=args */
-	cmp		%o0, 1
-	bl,pn		%xcc, do_einval
-	 cmp		%o0, 18
-	bg,pn		%xcc, do_einval
-	 sub		%o0, 1, %o0
-	sllx		%o0, 5, %o0
-	sethi		%hi(__socketcall_table_begin), %g2
-	or		%g2, %lo(__socketcall_table_begin), %g2
-	jmpl		%g2 + %o0, %g0
-	 nop
-do_einval:
-	retl
-	 mov		-EINVAL, %o0
-
-	.align		32
-__socketcall_table_begin:
-
-	/* Each entry is exactly 32 bytes. */
-do_sys_socket: /* sys_socket(int, int, int) */
-1:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_socket), %g1
-2:	ldswa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_socket), %g0
-3:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_bind: /* sys_bind(int fd, struct sockaddr *, int) */
-4:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_bind), %g1
-5:	ldswa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_bind), %g0
-6:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_connect: /* sys_connect(int, struct sockaddr *, int) */
-7:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_connect), %g1
-8:	ldswa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_connect), %g0
-9:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_listen: /* sys_listen(int, int) */
-10:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_listen), %g1
-	jmpl		%g1 + %lo(sys_listen), %g0
-11:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-	nop
-do_sys_accept: /* sys_accept(int, struct sockaddr *, int *) */
-12:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_accept), %g1
-13:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_accept), %g0
-14:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_getsockname: /* sys_getsockname(int, struct sockaddr *, int *) */
-15:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_getsockname), %g1
-16:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_getsockname), %g0
-17:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_getpeername: /* sys_getpeername(int, struct sockaddr *, int *) */
-18:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_getpeername), %g1
-19:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(sys_getpeername), %g0
-20:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_socketpair: /* sys_socketpair(int, int, int, int *) */
-21:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_socketpair), %g1
-22:	ldswa		[%o1 + 0x8] %asi, %o2
-23:	lduwa		[%o1 + 0xc] %asi, %o3
-	jmpl		%g1 + %lo(sys_socketpair), %g0
-24:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-do_sys_send: /* sys_send(int, void *, size_t, unsigned int) */
-25:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_send), %g1
-26:	lduwa		[%o1 + 0x8] %asi, %o2
-27:	lduwa		[%o1 + 0xc] %asi, %o3
-	jmpl		%g1 + %lo(sys_send), %g0
-28:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-do_sys_recv: /* sys_recv(int, void *, size_t, unsigned int) */
-29:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_recv), %g1
-30:	lduwa		[%o1 + 0x8] %asi, %o2
-31:	lduwa		[%o1 + 0xc] %asi, %o3
-	jmpl		%g1 + %lo(sys_recv), %g0
-32:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-do_sys_sendto: /* sys_sendto(int, u32, compat_size_t, unsigned int, u32, int) */
-33:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_sendto), %g1
-34:	lduwa		[%o1 + 0x8] %asi, %o2
-35:	lduwa		[%o1 + 0xc] %asi, %o3
-36:	lduwa		[%o1 + 0x10] %asi, %o4
-37:	ldswa		[%o1 + 0x14] %asi, %o5
-	jmpl		%g1 + %lo(sys_sendto), %g0
-38:	 lduwa		[%o1 + 0x4] %asi, %o1
-do_sys_recvfrom: /* sys_recvfrom(int, u32, compat_size_t, unsigned int, u32, u32) */
-39:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_recvfrom), %g1
-40:	lduwa		[%o1 + 0x8] %asi, %o2
-41:	lduwa		[%o1 + 0xc] %asi, %o3
-42:	lduwa		[%o1 + 0x10] %asi, %o4
-43:	lduwa		[%o1 + 0x14] %asi, %o5
-	jmpl		%g1 + %lo(sys_recvfrom), %g0
-44:	 lduwa		[%o1 + 0x4] %asi, %o1
-do_sys_shutdown: /* sys_shutdown(int, int) */
-45:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_shutdown), %g1
-	jmpl		%g1 + %lo(sys_shutdown), %g0
-46:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-	nop
-do_sys_setsockopt: /* sys_setsockopt(int, int, int, char *, int) */
-47:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_setsockopt), %g1
-48:	ldswa		[%o1 + 0x8] %asi, %o2
-49:	lduwa		[%o1 + 0xc] %asi, %o3
-50:	ldswa		[%o1 + 0x10] %asi, %o4
-	jmpl		%g1 + %lo(sys_setsockopt), %g0
-51:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-do_sys_getsockopt: /* sys_getsockopt(int, int, int, u32, u32) */
-52:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_getsockopt), %g1
-53:	ldswa		[%o1 + 0x8] %asi, %o2
-54:	lduwa		[%o1 + 0xc] %asi, %o3
-55:	lduwa		[%o1 + 0x10] %asi, %o4
-	jmpl		%g1 + %lo(sys_getsockopt), %g0
-56:	 ldswa		[%o1 + 0x4] %asi, %o1
-	nop
-do_sys_sendmsg: /* compat_sys_sendmsg(int, struct compat_msghdr *, unsigned int) */
-57:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(compat_sys_sendmsg), %g1
-58:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(compat_sys_sendmsg), %g0
-59:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_recvmsg: /* compat_sys_recvmsg(int, struct compat_msghdr *, unsigned int) */
-60:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(compat_sys_recvmsg), %g1
-61:	lduwa		[%o1 + 0x8] %asi, %o2
-	jmpl		%g1 + %lo(compat_sys_recvmsg), %g0
-62:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-	nop
-do_sys_accept4: /* sys_accept4(int, struct sockaddr *, int *, int) */
-63:	ldswa		[%o1 + 0x0] %asi, %o0
-	sethi		%hi(sys_accept4), %g1
-64:	lduwa		[%o1 + 0x8] %asi, %o2
-65:	ldswa		[%o1 + 0xc] %asi, %o3
-	jmpl		%g1 + %lo(sys_accept4), %g0
-66:	 lduwa		[%o1 + 0x4] %asi, %o1
-	nop
-	nop
-
-	.section	__ex_table,"a"
-	.align		4
-	.word		1b, __retl_efault, 2b, __retl_efault
-	.word		3b, __retl_efault, 4b, __retl_efault
-	.word		5b, __retl_efault, 6b, __retl_efault
-	.word		7b, __retl_efault, 8b, __retl_efault
-	.word		9b, __retl_efault, 10b, __retl_efault
-	.word		11b, __retl_efault, 12b, __retl_efault
-	.word		13b, __retl_efault, 14b, __retl_efault
-	.word		15b, __retl_efault, 16b, __retl_efault
-	.word		17b, __retl_efault, 18b, __retl_efault
-	.word		19b, __retl_efault, 20b, __retl_efault
-	.word		21b, __retl_efault, 22b, __retl_efault
-	.word		23b, __retl_efault, 24b, __retl_efault
-	.word		25b, __retl_efault, 26b, __retl_efault
-	.word		27b, __retl_efault, 28b, __retl_efault
-	.word		29b, __retl_efault, 30b, __retl_efault
-	.word		31b, __retl_efault, 32b, __retl_efault
-	.word		33b, __retl_efault, 34b, __retl_efault
-	.word		35b, __retl_efault, 36b, __retl_efault
-	.word		37b, __retl_efault, 38b, __retl_efault
-	.word		39b, __retl_efault, 40b, __retl_efault
-	.word		41b, __retl_efault, 42b, __retl_efault
-	.word		43b, __retl_efault, 44b, __retl_efault
-	.word		45b, __retl_efault, 46b, __retl_efault
-	.word		47b, __retl_efault, 48b, __retl_efault
-	.word		49b, __retl_efault, 50b, __retl_efault
-	.word		51b, __retl_efault, 52b, __retl_efault
-	.word		53b, __retl_efault, 54b, __retl_efault
-	.word		55b, __retl_efault, 56b, __retl_efault
-	.word		57b, __retl_efault, 58b, __retl_efault
-	.word		59b, __retl_efault, 60b, __retl_efault
-	.word		61b, __retl_efault, 62b, __retl_efault
-	.word		63b, __retl_efault, 64b, __retl_efault
-	.word		65b, __retl_efault, 66b, __retl_efault
-	.previous
diff --git a/arch/sparc/kernel/syscalls/syscall.tbl b/arch/sparc/kernel/syscalls/syscall.tbl
index 5e55f73f9880..cfdfb3707c16 100644
--- a/arch/sparc/kernel/syscalls/syscall.tbl
+++ b/arch/sparc/kernel/syscalls/syscall.tbl
@@ -155,7 +155,7 @@
 123	32	fchown			sys_fchown16
 123	64	fchown			sys_fchown
 124	common	fchmod			sys_fchmod
-125	common	recvfrom		sys_recvfrom
+125	common	recvfrom		sys_recvfrom			compat_sys_recvfrom
 126	32	setreuid		sys_setreuid16
 126	64	setreuid		sys_setreuid
 127	32	setregid		sys_setregid16
@@ -247,7 +247,7 @@
 204	32	readdir			sys_old_readdir			compat_sys_old_readdir
 204	64	readdir			sys_nis_syscall
 205	common	readahead		sys_readahead			compat_sys_readahead
-206	common	socketcall		sys_socketcall			sys32_socketcall
+206	common	socketcall		sys_socketcall			compat_sys_socketcall
 207	common	syslog			sys_syslog
 208	common	lookup_dcookie		sys_ni_syscall
 209	common	fadvise64		sys_fadvise64			compat_sys_fadvise64
-- 
2.39.2


