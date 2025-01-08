Return-Path: <linux-csky+bounces-1528-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6251A05019
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jan 2025 03:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04D481882808
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jan 2025 02:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6E5F17C20F;
	Wed,  8 Jan 2025 02:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sw2tZkh0"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2FF19E83C
	for <linux-csky@vger.kernel.org>; Wed,  8 Jan 2025 02:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302106; cv=none; b=fipM99pyIVDu+EsZ4TiK9p/qEaslFeRu+Lx9Ph4/CNuxS0rEo1C0W1qnl6MX4WIvE4DIuFFlDgrV6i7EkiFkJ9L6ZTD/FRL+EVlTHZeNoArT69rV29Lr2jt8YWsVGI2h0t+SwR4t9h4pFQauRnEln9aMsTb/9vz/z+iW58SKvbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302106; c=relaxed/simple;
	bh=1qJuKSAkdnWLg0VfU7E/FWwWi2QwiJI7tD9DHzK1vKM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMogn+JGrmBausH+aMykXPtezfXw8GK2PDB1KUkGk3k0xXN+mkoqx/HPQ3LdcF9O/fm7TAvcutbFFFTgWw5MXwrghaDAaXaOqOwh9D9ul2VjH/sYbVIXcEgjse6uvZsDhD+mpMBcvxiOn1uv/SCCxyVImngubVIS2DMkWJB9IL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sw2tZkh0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-216634dd574so158363035ad.2
        for <linux-csky@vger.kernel.org>; Tue, 07 Jan 2025 18:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736302103; x=1736906903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2gn/cNH2NBu3EZkBcEqe7v8b+p5O4PBo9lvTVMvVsg=;
        b=sw2tZkh0fg9Cia4iJiL8nWIwnsdvSIbM7wTrO75E2q7hVz2oLXW4XNKu2uIwylLQAJ
         lAmgaPFHSYieFfbIb06ox1jPm+EmP6uBxnSFIHEgLdhyw2lnjcQAwHku/O/rqELs5I30
         3S4ybwevSrq5nWZhmyIgBwLWxmL+aScSY1CAAGUTKzcA3N3VjyQ0xE1sfQnNAkZlfzke
         iP3r1vWzaOI8oRoC0GragBua+wM88vvwhvLF6LzlVN2JaFuRZ7Z6uaW0z9BPr24zFZK7
         IZTmBrUpBNPky5uVHOQjoKtqPd3fAw4hZx5eAWzm6cdSq3fPYb+Rlx2MLxRjQFbYOmTC
         1okg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736302103; x=1736906903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F2gn/cNH2NBu3EZkBcEqe7v8b+p5O4PBo9lvTVMvVsg=;
        b=Xv4csgaTlWl7pV3uMte0fypEiZvmcs9JWwKVuHvdqpt0bDRGqC8CAyrtA9UuoZ6cjn
         lTpd/p8i5aZ3pwrRTBD6k0iU0WzdLqki7Eifs5rzww8v0DftInbfxFWkZnIRKh80IAcc
         1B3QGD/9ktMiNyuGbVTM6d1RCJlrMemva0jrf9bze+H6jtxgksSx6i/3AXqPggnLZ1KC
         wtgrQIR4wTqZn8Cov/9v2M6VCkWaYlKL4Bx/7wJcF03Cs67dpzhrBCjB4UEpyNWwO6AN
         HP2E+t+7SS255FjZ7HW7p/A6XGMC3S/r3VRyov+MrhQBcKy6zk5wflyXue/p7KFXb875
         DtKA==
X-Forwarded-Encrypted: i=1; AJvYcCVGFYcqnJDZuMIbaL6teSWHy0o4NUso8lmfvq9aBdgt39qN03dBl9YtV+d7c4BDS1+yGTzy1965kSIp@vger.kernel.org
X-Gm-Message-State: AOJu0YzxDPlhazINcKRsEHYqKFSNjEEwUW1t6jM8mClZ801MBIaNFYdO
	wfBBqpCICnr1HBNELC2CaX4Kmf/19+WhxsfoMiwmWypIR3I/P4hEdm//pLTyEPk=
X-Gm-Gg: ASbGncst9zVlq8BhmnGSrRutZTOR5as+xFW3JBMsfEOhYi2SAlLanLS82j0Yp1JUT1h
	IamV4K/ReheB5kAAXPifTZQ4J+01htHcWieJgeJwP9JZlZzD3Z0SFQHTCfNUS8urITG7xYuxNsN
	jhKcBYvv+D062cv7pGRWqJX86TCStnD4HTwVaxtLlmyXc2QziivhPs1lksjw6hdjiOkerxRP8j5
	k2rv1dRHPpaqUKy6pe/OS4x8k5leG1Bbkyhi2avud0n4eVk2n9s7VgqjFNGXFEbeqLA4lP+
X-Google-Smtp-Source: AGHT+IFSJrypmTM/WQweUKyqvQSa6ii4c5wCiufgBhOgFzZRQom4LscpaM3vSvLqLKiUhSSlEfeLcQ==
X-Received: by 2002:a17:902:e5c2:b0:215:6f5d:b756 with SMTP id d9443c01a7336-21a83f36e79mr16422645ad.7.1736302102871;
        Tue, 07 Jan 2025 18:08:22 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca0282fsm316662405ad.259.2025.01.07.18.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:08:21 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 Jan 2025 18:07:54 -0800
Subject: [PATCH v5 06/16] perf tools: sparc: Support syscall headers
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-perf_syscalltbl-v5-6-935de46d3175@rivosinc.com>
References: <20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com>
In-Reply-To: <20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=26055; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=1qJuKSAkdnWLg0VfU7E/FWwWi2QwiJI7tD9DHzK1vKM=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rtPUZlpvPm2f/yBfUuPTo+/8m/DVlnjHdGPZKf01r6/
 H/Nm8TCjlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACayUYyRYdbns9xLpp76zyef
 X1vAqngoU3raU3eX2spH39ZGcLTtqWD4X1Ji7ZArd7jaXnXzVL4/ehW2+9RX7XEW1l6/4kaskVg
 iDwA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

sparc uses a syscall table, use that in perf instead of requiring
libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/arch/sparc/entry/syscalls/Kbuild        |   3 +
 .../arch/sparc/entry/syscalls/Makefile.syscalls    |   5 +
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl   | 514 +++++++++++++++++++++
 tools/perf/arch/sparc/include/syscall_table.h      |   8 +
 tools/perf/check-headers.sh                        |   1 +
 6 files changed, 532 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 8ba1772406b6d5a65dd89d2efd8e9eeb89bce1de..96f4018d8fac999a96262a230f9a602e8b61b846 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc csky arm sh
+generic_syscall_table_archs := riscv arc csky arm sh sparc
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
diff --git a/tools/perf/arch/sparc/entry/syscalls/Kbuild b/tools/perf/arch/sparc/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..84c6599b4ea6a160217a3496449b205f2263f0fb
--- /dev/null
+++ b/tools/perf/arch/sparc/entry/syscalls/Kbuild
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..212c1800b64477c615b8963176d873db5ccabe0c
--- /dev/null
+++ b/tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32  +=
+syscall_abis_64  +=
+syscalltbl = $(srctree)/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/sparc/entry/syscalls/syscall.tbl b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
new file mode 100644
index 0000000000000000000000000000000000000000..727f99d333b304b3db0711953a3d91ece18a28eb
--- /dev/null
+++ b/tools/perf/arch/sparc/entry/syscalls/syscall.tbl
@@ -0,0 +1,514 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for sparc
+#
+# The format is:
+# <number> <abi> <name> <entry point> <compat entry point>
+#
+# The <abi> can be common, 64, or 32 for this file.
+#
+0	common	restart_syscall		sys_restart_syscall
+1	32	exit			sys_exit			sparc_exit
+1	64	exit			sparc_exit
+2	common	fork			sys_fork
+3	common	read			sys_read
+4	common	write			sys_write
+5	common	open			sys_open			compat_sys_open
+6	common	close			sys_close
+7	common	wait4			sys_wait4			compat_sys_wait4
+8	common	creat			sys_creat
+9	common	link			sys_link
+10	common	unlink			sys_unlink
+11	32	execv			sunos_execv
+11	64	execv			sys_nis_syscall
+12	common	chdir			sys_chdir
+13	32    	chown			sys_chown16
+13	64	chown			sys_chown
+14	common	mknod			sys_mknod
+15	common	chmod			sys_chmod
+16	32	lchown			sys_lchown16
+16	64	lchown			sys_lchown
+17	common	brk			sys_brk
+18	common	perfctr			sys_nis_syscall
+19	common	lseek			sys_lseek			compat_sys_lseek
+20	common	getpid			sys_getpid
+21	common	capget			sys_capget
+22	common	capset			sys_capset
+23	32    	setuid			sys_setuid16
+23	64    	setuid			sys_setuid
+24	32	getuid			sys_getuid16
+24	64   	getuid			sys_getuid
+25	common	vmsplice		sys_vmsplice
+26	common	ptrace			sys_ptrace			compat_sys_ptrace
+27	common	alarm			sys_alarm
+28	common	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
+29	32    	pause			sys_pause
+29	64    	pause			sys_nis_syscall
+30	32	utime			sys_utime32
+30	64	utime			sys_utime
+31	32    	lchown32		sys_lchown
+32	32    	fchown32		sys_fchown
+33	common	access			sys_access
+34	common	nice			sys_nice
+35	32    	chown32			sys_chown
+36	common	sync			sys_sync
+37	common	kill			sys_kill
+38	common	stat			sys_newstat			compat_sys_newstat
+39	32	sendfile		sys_sendfile			compat_sys_sendfile
+39	64	sendfile		sys_sendfile64
+40	common	lstat			sys_newlstat			compat_sys_newlstat
+41	common	dup			sys_dup
+42	common	pipe			sys_sparc_pipe
+43	common	times			sys_times			compat_sys_times
+44	32    	getuid32		sys_getuid
+45	common	umount2			sys_umount
+46	32	setgid			sys_setgid16
+46	64	setgid			sys_setgid
+47	32	getgid			sys_getgid16
+47	64	getgid			sys_getgid
+48	common	signal			sys_signal
+49	32	geteuid			sys_geteuid16
+49	64	geteuid			sys_geteuid
+50	32	getegid			sys_getegid16
+50	64	getegid			sys_getegid
+51	common	acct			sys_acct
+52	64	memory_ordering		sys_memory_ordering
+53	32	getgid32		sys_getgid
+54	common	ioctl			sys_ioctl			compat_sys_ioctl
+55	common	reboot			sys_reboot
+56	32    	mmap2			sys_mmap2			sys32_mmap2
+57	common	symlink			sys_symlink
+58	common	readlink		sys_readlink
+59	32	execve			sys_execve			sys32_execve
+59	64	execve			sys64_execve
+60	common	umask			sys_umask
+61	common	chroot			sys_chroot
+62	common	fstat			sys_newfstat			compat_sys_newfstat
+63	common	fstat64			sys_fstat64			compat_sys_fstat64
+64	common	getpagesize		sys_getpagesize
+65	common	msync			sys_msync
+66	common	vfork			sys_vfork
+67	common	pread64			sys_pread64			compat_sys_pread64
+68	common	pwrite64		sys_pwrite64			compat_sys_pwrite64
+69	32    	geteuid32		sys_geteuid
+70	32	getegid32		sys_getegid
+71	common	mmap			sys_mmap
+72	32	setreuid32		sys_setreuid
+73	32	munmap			sys_munmap
+73	64	munmap			sys_64_munmap
+74	common	mprotect		sys_mprotect
+75	common	madvise			sys_madvise
+76	common	vhangup			sys_vhangup
+77	32	truncate64		sys_truncate64			compat_sys_truncate64
+78	common	mincore			sys_mincore
+79	32	getgroups		sys_getgroups16
+79	64	getgroups		sys_getgroups
+80	32	setgroups		sys_setgroups16
+80	64	setgroups		sys_setgroups
+81	common	getpgrp			sys_getpgrp
+82	32	setgroups32		sys_setgroups
+83	common	setitimer		sys_setitimer			compat_sys_setitimer
+84	32	ftruncate64		sys_ftruncate64			compat_sys_ftruncate64
+85	common	swapon			sys_swapon
+86	common	getitimer		sys_getitimer			compat_sys_getitimer
+87	32	setuid32		sys_setuid
+88	common	sethostname		sys_sethostname
+89	32	setgid32		sys_setgid
+90	common	dup2			sys_dup2
+91	32	setfsuid32		sys_setfsuid
+92	common	fcntl			sys_fcntl			compat_sys_fcntl
+93	common	select			sys_select			compat_sys_select
+94	32	setfsgid32		sys_setfsgid
+95	common	fsync			sys_fsync
+96	common	setpriority		sys_setpriority
+97	common	socket			sys_socket
+98	common	connect			sys_connect
+99	common	accept			sys_accept
+100	common	getpriority		sys_getpriority
+101	common	rt_sigreturn		sys_rt_sigreturn		sys32_rt_sigreturn
+102	common	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
+103	common	rt_sigprocmask		sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+104	common	rt_sigpending		sys_rt_sigpending		compat_sys_rt_sigpending
+105	32	rt_sigtimedwait		sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+105	64	rt_sigtimedwait		sys_rt_sigtimedwait
+106	common	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+107	common	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+108	32	setresuid32		sys_setresuid
+108	64	setresuid		sys_setresuid
+109	32	getresuid32		sys_getresuid
+109	64	getresuid		sys_getresuid
+110	32	setresgid32		sys_setresgid
+110	64	setresgid		sys_setresgid
+111	32	getresgid32		sys_getresgid
+111	64	getresgid		sys_getresgid
+112	32	setregid32		sys_setregid
+113	common	recvmsg			sys_recvmsg			compat_sys_recvmsg
+114	common	sendmsg			sys_sendmsg			compat_sys_sendmsg
+115	32	getgroups32		sys_getgroups
+116	common	gettimeofday		sys_gettimeofday		compat_sys_gettimeofday
+117	common	getrusage		sys_getrusage			compat_sys_getrusage
+118	common	getsockopt		sys_getsockopt			sys_getsockopt
+119	common	getcwd			sys_getcwd
+120	common	readv			sys_readv
+121	common	writev			sys_writev
+122	common	settimeofday		sys_settimeofday		compat_sys_settimeofday
+123	32	fchown			sys_fchown16
+123	64	fchown			sys_fchown
+124	common	fchmod			sys_fchmod
+125	common	recvfrom		sys_recvfrom			compat_sys_recvfrom
+126	32	setreuid		sys_setreuid16
+126	64	setreuid		sys_setreuid
+127	32	setregid		sys_setregid16
+127	64	setregid		sys_setregid
+128	common	rename			sys_rename
+129	common	truncate		sys_truncate			compat_sys_truncate
+130	common	ftruncate		sys_ftruncate			compat_sys_ftruncate
+131	common	flock			sys_flock
+132	common	lstat64			sys_lstat64			compat_sys_lstat64
+133	common	sendto			sys_sendto
+134	common	shutdown		sys_shutdown
+135	common	socketpair		sys_socketpair
+136	common	mkdir			sys_mkdir
+137	common	rmdir			sys_rmdir
+138	32	utimes			sys_utimes_time32
+138	64	utimes			sys_utimes
+139	common	stat64			sys_stat64			compat_sys_stat64
+140	common	sendfile64		sys_sendfile64
+141	common	getpeername		sys_getpeername
+142	32	futex			sys_futex_time32
+142	64	futex			sys_futex
+143	common	gettid			sys_gettid
+144	common	getrlimit		sys_getrlimit			compat_sys_getrlimit
+145	common	setrlimit		sys_setrlimit			compat_sys_setrlimit
+146	common	pivot_root		sys_pivot_root
+147	common	prctl			sys_prctl
+148	common	pciconfig_read		sys_pciconfig_read
+149	common	pciconfig_write		sys_pciconfig_write
+150	common	getsockname		sys_getsockname
+151	common	inotify_init		sys_inotify_init
+152	common	inotify_add_watch	sys_inotify_add_watch
+153	common	poll			sys_poll
+154	common	getdents64		sys_getdents64
+155	32	fcntl64			sys_fcntl64			compat_sys_fcntl64
+156	common	inotify_rm_watch	sys_inotify_rm_watch
+157	common	statfs			sys_statfs			compat_sys_statfs
+158	common	fstatfs			sys_fstatfs			compat_sys_fstatfs
+159	common	umount			sys_oldumount
+160	common	sched_set_affinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
+161	common	sched_get_affinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
+162	common	getdomainname		sys_getdomainname
+163	common	setdomainname		sys_setdomainname
+164	64	utrap_install		sys_utrap_install
+165	common	quotactl		sys_quotactl
+166	common	set_tid_address		sys_set_tid_address
+167	common	mount			sys_mount
+168	common	ustat			sys_ustat			compat_sys_ustat
+169	common	setxattr		sys_setxattr
+170	common	lsetxattr		sys_lsetxattr
+171	common	fsetxattr		sys_fsetxattr
+172	common	getxattr		sys_getxattr
+173	common	lgetxattr		sys_lgetxattr
+174	common	getdents		sys_getdents			compat_sys_getdents
+175	common	setsid			sys_setsid
+176	common	fchdir			sys_fchdir
+177	common	fgetxattr		sys_fgetxattr
+178	common	listxattr		sys_listxattr
+179	common	llistxattr		sys_llistxattr
+180	common	flistxattr		sys_flistxattr
+181	common	removexattr		sys_removexattr
+182	common	lremovexattr		sys_lremovexattr
+183	32	sigpending		sys_sigpending			compat_sys_sigpending
+183	64	sigpending		sys_nis_syscall
+184	common	query_module		sys_ni_syscall
+185	common	setpgid			sys_setpgid
+186	common	fremovexattr		sys_fremovexattr
+187	common	tkill			sys_tkill
+188	32	exit_group		sys_exit_group			sparc_exit_group
+188	64	exit_group		sparc_exit_group
+189	common	uname			sys_newuname
+190	common	init_module		sys_init_module
+191	32	personality		sys_personality			sys_sparc64_personality
+191	64	personality		sys_sparc64_personality
+192	32	remap_file_pages	sys_sparc_remap_file_pages	sys_remap_file_pages
+192	64	remap_file_pages	sys_remap_file_pages
+193	common	epoll_create		sys_epoll_create
+194	common	epoll_ctl		sys_epoll_ctl
+195	common	epoll_wait		sys_epoll_wait
+196	common	ioprio_set		sys_ioprio_set
+197	common	getppid			sys_getppid
+198	32	sigaction		sys_sparc_sigaction		compat_sys_sparc_sigaction
+198	64	sigaction		sys_nis_syscall
+199	common	sgetmask		sys_sgetmask
+200	common	ssetmask		sys_ssetmask
+201	32	sigsuspend		sys_sigsuspend
+201	64	sigsuspend		sys_nis_syscall
+202	common	oldlstat		sys_newlstat			compat_sys_newlstat
+203	common	uselib			sys_uselib
+204	32	readdir			sys_old_readdir			compat_sys_old_readdir
+204	64	readdir			sys_nis_syscall
+205	common	readahead		sys_readahead			compat_sys_readahead
+206	common	socketcall		sys_socketcall			compat_sys_socketcall
+207	common	syslog			sys_syslog
+208	common	lookup_dcookie		sys_ni_syscall
+209	common	fadvise64		sys_fadvise64			compat_sys_fadvise64
+210	common	fadvise64_64		sys_fadvise64_64		compat_sys_fadvise64_64
+211	common	tgkill			sys_tgkill
+212	common	waitpid			sys_waitpid
+213	common	swapoff			sys_swapoff
+214	common	sysinfo			sys_sysinfo			compat_sys_sysinfo
+215	32	ipc			sys_ipc				compat_sys_ipc
+215	64	ipc			sys_sparc_ipc
+216	32	sigreturn		sys_sigreturn			sys32_sigreturn
+216	64	sigreturn		sys_nis_syscall
+217	common	clone			sys_clone
+218	common	ioprio_get		sys_ioprio_get
+219	32	adjtimex		sys_adjtimex_time32
+219	64	adjtimex		sys_sparc_adjtimex
+220	32	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
+220	64	sigprocmask		sys_nis_syscall
+221	common	create_module		sys_ni_syscall
+222	common	delete_module		sys_delete_module
+223	common	get_kernel_syms		sys_ni_syscall
+224	common	getpgid			sys_getpgid
+225	common	bdflush			sys_ni_syscall
+226	common	sysfs			sys_sysfs
+227	common	afs_syscall		sys_nis_syscall
+228	common	setfsuid		sys_setfsuid16
+229	common	setfsgid		sys_setfsgid16
+230	common	_newselect		sys_select			compat_sys_select
+231	32	time			sys_time32
+232	common	splice			sys_splice
+233	32	stime			sys_stime32
+233	64	stime			sys_stime
+234	common	statfs64		sys_statfs64			compat_sys_statfs64
+235	common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
+236	common	_llseek			sys_llseek
+237	common	mlock			sys_mlock
+238	common	munlock			sys_munlock
+239	common	mlockall		sys_mlockall
+240	common	munlockall		sys_munlockall
+241	common	sched_setparam		sys_sched_setparam
+242	common	sched_getparam		sys_sched_getparam
+243	common	sched_setscheduler	sys_sched_setscheduler
+244	common	sched_getscheduler	sys_sched_getscheduler
+245	common	sched_yield		sys_sched_yield
+246	common	sched_get_priority_max	sys_sched_get_priority_max
+247	common	sched_get_priority_min	sys_sched_get_priority_min
+248	32	sched_rr_get_interval	sys_sched_rr_get_interval_time32
+248	64	sched_rr_get_interval	sys_sched_rr_get_interval
+249	32	nanosleep		sys_nanosleep_time32
+249	64	nanosleep		sys_nanosleep
+250	32	mremap			sys_mremap
+250	64	mremap			sys_64_mremap
+251	common	_sysctl			sys_ni_syscall
+252	common	getsid			sys_getsid
+253	common	fdatasync		sys_fdatasync
+254	32	nfsservctl		sys_ni_syscall			sys_nis_syscall
+254	64	nfsservctl		sys_nis_syscall
+255	common	sync_file_range		sys_sync_file_range		compat_sys_sync_file_range
+256	32	clock_settime		sys_clock_settime32
+256	64	clock_settime		sys_clock_settime
+257	32	clock_gettime		sys_clock_gettime32
+257	64	clock_gettime		sys_clock_gettime
+258	32	clock_getres		sys_clock_getres_time32
+258	64	clock_getres		sys_clock_getres
+259	32	clock_nanosleep		sys_clock_nanosleep_time32
+259	64	clock_nanosleep		sys_clock_nanosleep
+260	common	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
+261	common	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
+262	32	timer_settime		sys_timer_settime32
+262	64	timer_settime		sys_timer_settime
+263	32	timer_gettime		sys_timer_gettime32
+263	64	timer_gettime		sys_timer_gettime
+264	common	timer_getoverrun	sys_timer_getoverrun
+265	common	timer_delete		sys_timer_delete
+266	common	timer_create		sys_timer_create		compat_sys_timer_create
+# 267 was vserver
+267	common	vserver			sys_nis_syscall
+268	common	io_setup		sys_io_setup			compat_sys_io_setup
+269	common	io_destroy		sys_io_destroy
+270	common	io_submit		sys_io_submit			compat_sys_io_submit
+271	common	io_cancel		sys_io_cancel
+272	32	io_getevents		sys_io_getevents_time32
+272	64	io_getevents		sys_io_getevents
+273	common	mq_open			sys_mq_open			compat_sys_mq_open
+274	common	mq_unlink		sys_mq_unlink
+275	32	mq_timedsend		sys_mq_timedsend_time32
+275	64	mq_timedsend		sys_mq_timedsend
+276	32	mq_timedreceive		sys_mq_timedreceive_time32
+276	64	mq_timedreceive		sys_mq_timedreceive
+277	common	mq_notify		sys_mq_notify			compat_sys_mq_notify
+278	common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
+279	common	waitid			sys_waitid			compat_sys_waitid
+280	common	tee			sys_tee
+281	common	add_key			sys_add_key
+282	common	request_key		sys_request_key
+283	common	keyctl			sys_keyctl			compat_sys_keyctl
+284	common	openat			sys_openat			compat_sys_openat
+285	common	mkdirat			sys_mkdirat
+286	common	mknodat			sys_mknodat
+287	common	fchownat		sys_fchownat
+288	32	futimesat		sys_futimesat_time32
+288	64	futimesat		sys_futimesat
+289	common	fstatat64		sys_fstatat64			compat_sys_fstatat64
+290	common	unlinkat		sys_unlinkat
+291	common	renameat		sys_renameat
+292	common	linkat			sys_linkat
+293	common	symlinkat		sys_symlinkat
+294	common	readlinkat		sys_readlinkat
+295	common	fchmodat		sys_fchmodat
+296	common	faccessat		sys_faccessat
+297	32	pselect6		sys_pselect6_time32		compat_sys_pselect6_time32
+297	64	pselect6		sys_pselect6
+298	32	ppoll			sys_ppoll_time32		compat_sys_ppoll_time32
+298	64	ppoll			sys_ppoll
+299	common	unshare			sys_unshare
+300	common	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
+301	common	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
+302	common	migrate_pages		sys_migrate_pages
+303	common	mbind			sys_mbind
+304	common	get_mempolicy		sys_get_mempolicy
+305	common	set_mempolicy		sys_set_mempolicy
+306	common	kexec_load		sys_kexec_load			compat_sys_kexec_load
+307	common	move_pages		sys_move_pages
+308	common	getcpu			sys_getcpu
+309	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
+310	32	utimensat		sys_utimensat_time32
+310	64	utimensat		sys_utimensat
+311	common	signalfd		sys_signalfd			compat_sys_signalfd
+312	common	timerfd_create		sys_timerfd_create
+313	common	eventfd			sys_eventfd
+314	common	fallocate		sys_fallocate			compat_sys_fallocate
+315	32	timerfd_settime		sys_timerfd_settime32
+315	64	timerfd_settime		sys_timerfd_settime
+316	32	timerfd_gettime		sys_timerfd_gettime32
+316	64	timerfd_gettime		sys_timerfd_gettime
+317	common	signalfd4		sys_signalfd4			compat_sys_signalfd4
+318	common	eventfd2		sys_eventfd2
+319	common	epoll_create1		sys_epoll_create1
+320	common	dup3			sys_dup3
+321	common	pipe2			sys_pipe2
+322	common	inotify_init1		sys_inotify_init1
+323	common	accept4			sys_accept4
+324	common	preadv			sys_preadv			compat_sys_preadv
+325	common	pwritev			sys_pwritev			compat_sys_pwritev
+326	common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+327	common	perf_event_open		sys_perf_event_open
+328	32	recvmmsg		sys_recvmmsg_time32		compat_sys_recvmmsg_time32
+328	64	recvmmsg		sys_recvmmsg
+329	common	fanotify_init		sys_fanotify_init
+330	common	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
+331	common	prlimit64		sys_prlimit64
+332	common	name_to_handle_at	sys_name_to_handle_at
+333	common	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
+334	32	clock_adjtime		sys_clock_adjtime32
+334	64	clock_adjtime		sys_sparc_clock_adjtime
+335	common	syncfs			sys_syncfs
+336	common	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
+337	common	setns			sys_setns
+338	common	process_vm_readv	sys_process_vm_readv
+339	common	process_vm_writev	sys_process_vm_writev
+340	32	kern_features		sys_ni_syscall			sys_kern_features
+340	64	kern_features		sys_kern_features
+341	common	kcmp			sys_kcmp
+342	common	finit_module		sys_finit_module
+343	common	sched_setattr		sys_sched_setattr
+344	common	sched_getattr		sys_sched_getattr
+345	common	renameat2		sys_renameat2
+346	common	seccomp			sys_seccomp
+347	common	getrandom		sys_getrandom
+348	common	memfd_create		sys_memfd_create
+349	common	bpf			sys_bpf
+350	32	execveat		sys_execveat			sys32_execveat
+350	64	execveat		sys64_execveat
+351	common	membarrier		sys_membarrier
+352	common	userfaultfd		sys_userfaultfd
+353	common	bind			sys_bind
+354	common	listen			sys_listen
+355	common	setsockopt		sys_setsockopt			sys_setsockopt
+356	common	mlock2			sys_mlock2
+357	common	copy_file_range		sys_copy_file_range
+358	common	preadv2			sys_preadv2			compat_sys_preadv2
+359	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
+360	common	statx			sys_statx
+361	32	io_pgetevents		sys_io_pgetevents_time32	compat_sys_io_pgetevents
+361	64	io_pgetevents		sys_io_pgetevents
+362	common	pkey_mprotect		sys_pkey_mprotect
+363	common	pkey_alloc		sys_pkey_alloc
+364	common	pkey_free		sys_pkey_free
+365	common	rseq			sys_rseq
+# room for arch specific syscalls
+392	64	semtimedop			sys_semtimedop
+393	common	semget			sys_semget
+394	common	semctl			sys_semctl			compat_sys_semctl
+395	common	shmget			sys_shmget
+396	common	shmctl			sys_shmctl			compat_sys_shmctl
+397	common	shmat			sys_shmat			compat_sys_shmat
+398	common	shmdt			sys_shmdt
+399	common	msgget			sys_msgget
+400	common	msgsnd			sys_msgsnd			compat_sys_msgsnd
+401	common	msgrcv			sys_msgrcv			compat_sys_msgrcv
+402	common	msgctl			sys_msgctl			compat_sys_msgctl
+403	32	clock_gettime64			sys_clock_gettime		sys_clock_gettime
+404	32	clock_settime64			sys_clock_settime		sys_clock_settime
+405	32	clock_adjtime64			sys_clock_adjtime		sys_clock_adjtime
+406	32	clock_getres_time64		sys_clock_getres		sys_clock_getres
+407	32	clock_nanosleep_time64		sys_clock_nanosleep		sys_clock_nanosleep
+408	32	timer_gettime64			sys_timer_gettime		sys_timer_gettime
+409	32	timer_settime64			sys_timer_settime		sys_timer_settime
+410	32	timerfd_gettime64		sys_timerfd_gettime		sys_timerfd_gettime
+411	32	timerfd_settime64		sys_timerfd_settime		sys_timerfd_settime
+412	32	utimensat_time64		sys_utimensat			sys_utimensat
+413	32	pselect6_time64			sys_pselect6			compat_sys_pselect6_time64
+414	32	ppoll_time64			sys_ppoll			compat_sys_ppoll_time64
+416	32	io_pgetevents_time64		sys_io_pgetevents		compat_sys_io_pgetevents_time64
+417	32	recvmmsg_time64			sys_recvmmsg			compat_sys_recvmmsg_time64
+418	32	mq_timedsend_time64		sys_mq_timedsend		sys_mq_timedsend
+419	32	mq_timedreceive_time64		sys_mq_timedreceive		sys_mq_timedreceive
+420	32	semtimedop_time64		sys_semtimedop			sys_semtimedop
+421	32	rt_sigtimedwait_time64		sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	32	futex_time64			sys_futex			sys_futex
+423	32	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+424	common	pidfd_send_signal		sys_pidfd_send_signal
+425	common	io_uring_setup			sys_io_uring_setup
+426	common	io_uring_enter			sys_io_uring_enter
+427	common	io_uring_register		sys_io_uring_register
+428	common	open_tree			sys_open_tree
+429	common	move_mount			sys_move_mount
+430	common	fsopen				sys_fsopen
+431	common	fsconfig			sys_fsconfig
+432	common	fsmount				sys_fsmount
+433	common	fspick				sys_fspick
+434	common	pidfd_open			sys_pidfd_open
+# 435 reserved for clone3
+436	common	close_range			sys_close_range
+437	common	openat2			sys_openat2
+438	common	pidfd_getfd			sys_pidfd_getfd
+439	common	faccessat2			sys_faccessat2
+440	common	process_madvise			sys_process_madvise
+441	common	epoll_pwait2			sys_epoll_pwait2		compat_sys_epoll_pwait2
+442	common	mount_setattr			sys_mount_setattr
+443	common	quotactl_fd			sys_quotactl_fd
+444	common	landlock_create_ruleset		sys_landlock_create_ruleset
+445	common	landlock_add_rule		sys_landlock_add_rule
+446	common	landlock_restrict_self		sys_landlock_restrict_self
+# 447 reserved for memfd_secret
+448	common	process_mrelease		sys_process_mrelease
+449	common  futex_waitv                     sys_futex_waitv
+450	common	set_mempolicy_home_node		sys_set_mempolicy_home_node
+451	common	cachestat			sys_cachestat
+452	common	fchmodat2			sys_fchmodat2
+453	common	map_shadow_stack		sys_map_shadow_stack
+454	common	futex_wake			sys_futex_wake
+455	common	futex_wait			sys_futex_wait
+456	common	futex_requeue			sys_futex_requeue
+457	common	statmount			sys_statmount
+458	common	listmount			sys_listmount
+459	common	lsm_get_self_attr		sys_lsm_get_self_attr
+460	common	lsm_set_self_attr		sys_lsm_set_self_attr
+461	common	lsm_list_modules		sys_lsm_list_modules
+462	common	mseal 				sys_mseal
+463	common	setxattrat			sys_setxattrat
+464	common	getxattrat			sys_getxattrat
+465	common	listxattrat			sys_listxattrat
+466	common	removexattrat			sys_removexattrat
diff --git a/tools/perf/arch/sparc/include/syscall_table.h b/tools/perf/arch/sparc/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..7ff51b783000d727ec48be960730b81ecdb05575
--- /dev/null
+++ b/tools/perf/arch/sparc/include/syscall_table.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/bitsperlong.h>
+
+#if __BITS_PER_LONG == 64
+#include <asm/syscalls_64.h>
+#else
+#include <asm/syscalls_32.h>
+#endif
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 2f1b42bf337b3d601f0f2e792bd79413f46e583a..99a278a3f1b5bf44132c817ed1f2623a232d3dc5 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -204,6 +204,7 @@ check_2 tools/perf/arch/s390/entry/syscalls/syscall.tbl arch/s390/kernel/syscall
 check_2 tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl arch/mips/kernel/syscalls/syscall_n64.tbl
 check_2 tools/perf/arch/arm/entry/syscalls/syscall.tbl arch/arm/tools/syscall.tbl
 check_2 tools/perf/arch/sh/entry/syscalls/syscall.tbl arch/sh/kernel/syscalls/syscall.tbl
+check_2 tools/perf/arch/sparc/entry/syscalls/syscall.tbl arch/sparc/kernel/syscalls/syscall.tbl
 
 for i in "${BEAUTY_FILES[@]}"
 do

-- 
2.34.1


