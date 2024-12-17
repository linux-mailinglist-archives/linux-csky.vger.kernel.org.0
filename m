Return-Path: <linux-csky+bounces-1376-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D959F4421
	for <lists+linux-csky@lfdr.de>; Tue, 17 Dec 2024 07:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 127E7188E342
	for <lists+linux-csky@lfdr.de>; Tue, 17 Dec 2024 06:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 450A91EE01F;
	Tue, 17 Dec 2024 06:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="riN7bGsr"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859CC1EB9E8
	for <linux-csky@vger.kernel.org>; Tue, 17 Dec 2024 06:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417588; cv=none; b=iec5EhFJ8jKOxFPCw7GB6VPvldwdaDOHY5JKENxL+rzWioaIl+fvQ3DUi8cvD9FM4bfhAb6qGz5ALBA/OhQXXwEhwqpAxrOkowxV1d36xBfZc6sicNTIPXc1b9UlB6lx58ddEBhFLRparIKQdfytwkk8VN8V7VvJ5rMaKezjSb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417588; c=relaxed/simple;
	bh=PpQNSHrTyKHqfiQ9AljxCE+nXdG00tODHkKAIFHU/K4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RIv5Qoej0BAHnrUPC1GqzC+lQs0EoIJ5NMWxUfniy/6hyYH9trhEPpeX28r10ySPLdKvgT0/L8uvCqCRAWyEzgz2gfvhLt9RYaQ/KlmdVEbFmOXTRm4T+q7HkiWH2Ba0mypWVKN3sN25BSkaNcDlzDqLmm0psHsqr9nkL+THJZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=riN7bGsr; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso4119067a12.2
        for <linux-csky@vger.kernel.org>; Mon, 16 Dec 2024 22:39:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734417585; x=1735022385; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BicOFFik/5T0V2bfCBpPvVi1RzBZDBKuI9cy+F3EQmo=;
        b=riN7bGsr8XBlsJYvGEYg5IALXgQuQqR7mVRQnKBBG6TUSNgsO9divJBjlORUWw7iCa
         40Q3iei3CIYs0KVqIg4QKa2Nq7N5eTyvM2yF2OLRneJGxBLJOFxVvRu60yxXpZznevo4
         Ouz9p7vNf7MxinJG49KgUfxhkKj+hnICtBEUP8qolpHSvOfgx23/cIqtnWcAHCjxlaZY
         aPXNJqUDMwu1rmuGEqmXoHYb9fpLmrjStUfWoeNm3wAOqHG80F7N1G8LZ6S4+SDlNg/1
         DGMExyqQRMPwpHs7ulGEeHR7NmQ3ha7ozxj/CHSfHEmz5l6iem7oN0hUy55xy/5oPLEZ
         yAdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734417585; x=1735022385;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BicOFFik/5T0V2bfCBpPvVi1RzBZDBKuI9cy+F3EQmo=;
        b=RqBlyTlZ3+viXlxkIjVxOS7T0pm/Kq75gsyw02wt54buwWvncL5cVBpPmtPR0mvv/6
         iY9kH8sj1Zx/fW2K96XNlFcLjXzKitFv9mHcDEalrhbfkhXHQ0re7dKPe961d7TjQw64
         j/FgYtHyCz9cpL8kMUrbyq9qlsa4iGQ1jolyKRvGddilywQRkC3NmUkKkIbQS+a/13kw
         czrLxcZHWBQ0YeuFspxe9J5iHavsIKvRtQGJNsSRlHafS98EuoeZ5zXTXna1HnVpDCzO
         ASOymkNdqtGelIkMyf7wakbjz6WpyenL8OVx7onEJMUElyPQ7kzYtL6HUloQ9t/u5yCA
         A+TA==
X-Forwarded-Encrypted: i=1; AJvYcCWNMLvcYAbTXP2J4sgbo0tEaL+ATQPgOZ2msyPzWmqIUF8nM4vocp/rIqVyVDWs4IoFuhaC/CFmhnpX@vger.kernel.org
X-Gm-Message-State: AOJu0YxyqPxQ9PbytlCsuYipyDIMzleb+yM4EzayxA8P1FnKxLBidfe+
	tfwo+otj/95tCZtcRDxZz4jlCj0YJMTr5U+FhDQWBZrvRuNVnvCB8LYBOZCx5Jk=
X-Gm-Gg: ASbGncv1d7YTYAXGSSAnKF/znuGiW9Frw4E23G3Q6HxtCz6QNJkU6uNZi5B3iLqoRhY
	xgZpWMdRrnzeIjNqm1rr01ZdSeGZrfk1OhIzVrNCT65KgZ7U0WzrJ7lyFVDBD/ZcWF4Gg8R3gjd
	cw0IrRUBjKVP7R5x7x51x/ZET3TVSBtC0FmHxQRWi1U1C53SXh3qp1276X0rMOfIkiGkiRDWXMX
	FDZ6GIcDRdJk1rM/LtqZNjadg1dEeHEhKxx0vInEMt208B4m4eKLsvnMLDkpJmPpt59S841
X-Google-Smtp-Source: AGHT+IFSH/BgcKRnb66t4bs6miOD1NSdnl6PBHKI9Y+W1GQNZ9HrguhGITQYbpIOOyfbb4hpEHfU0A==
X-Received: by 2002:a17:90b:4d05:b0:2ee:b26c:1099 with SMTP id 98e67ed59e1d1-2f2902ae9damr18860217a91.34.1734417584852;
        Mon, 16 Dec 2024 22:39:44 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90d6bsm9179551a91.2.2024.12.16.22.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:39:43 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 16 Dec 2024 22:32:55 -0800
Subject: [PATCH v3 10/16] perf tools: parisc: Support syscall header
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-perf_syscalltbl-v3-10-239f032481d5@rivosinc.com>
References: <20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com>
In-Reply-To: <20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com>
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
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=23665; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=PpQNSHrTyKHqfiQ9AljxCE+nXdG00tODHkKAIFHU/K4=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qiTH+hu+/y1c//nV661eF0/1LNpwJKs6tP//nXyPFO2
 uL2XevIjlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACYyNZDhn2WAzULe9ogbOUkX
 Fr2vazgm8cF3Qs7sryfPJT5nVrSOeM/IsF5J+8zc559+ZN6pZwj8qrs01Jm//+tdF94vPZlW8X3
 72AE=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

parisc uses a syscall table, use that in perf instead of requiring
libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.perf                           |   2 +-
 tools/perf/arch/parisc/entry/syscalls/Kbuild       |   3 +
 .../arch/parisc/entry/syscalls/Makefile.syscalls   |   6 +
 tools/perf/arch/parisc/entry/syscalls/syscall.tbl  | 463 +++++++++++++++++++++
 tools/perf/arch/parisc/include/syscall_table.h     |   8 +
 tools/perf/check-headers.sh                        |   1 +
 6 files changed, 482 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 7528e6acaf3b1cf76198dafe094800fc00fd56eb..c4bd151fb7e4fb14a53998e58afae37599696da3 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha
+generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
diff --git a/tools/perf/arch/parisc/entry/syscalls/Kbuild b/tools/perf/arch/parisc/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..84c6599b4ea6a160217a3496449b205f2263f0fb
--- /dev/null
+++ b/tools/perf/arch/parisc/entry/syscalls/Kbuild
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..ae326fecb83b307fb5b0a885ae109480aafd586f
--- /dev/null
+++ b/tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32  +=
+syscall_abis_64  +=
+
+syscalltbl = $(srctree)/tools/perf/arch/parisc/entry/syscalls/syscall.tbl
diff --git a/tools/perf/arch/parisc/entry/syscalls/syscall.tbl b/tools/perf/arch/parisc/entry/syscalls/syscall.tbl
new file mode 100644
index 0000000000000000000000000000000000000000..66dc406b12e4482832b0e8836b8267b0fb37a5ed
--- /dev/null
+++ b/tools/perf/arch/parisc/entry/syscalls/syscall.tbl
@@ -0,0 +1,463 @@
+# SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
+#
+# system call numbers and entry vectors for parisc
+#
+# The format is:
+# <number> <abi> <name> <entry point> <compat entry point>
+#
+# The <abi> can be common, 64, or 32 for this file.
+#
+0	common	restart_syscall		sys_restart_syscall
+1	common	exit			sys_exit
+2	common	fork			sys_fork_wrapper
+3	common	read			sys_read
+4	common	write			sys_write
+5	common	open			sys_open			compat_sys_open
+6	common	close			sys_close
+7	common	waitpid			sys_waitpid
+8	common	creat			sys_creat
+9	common	link			sys_link
+10	common	unlink			sys_unlink
+11	common	execve			sys_execve			compat_sys_execve
+12	common	chdir			sys_chdir
+13	32	time			sys_time32
+13	64	time			sys_time
+14	common	mknod			sys_mknod
+15	common	chmod			sys_chmod
+16	common	lchown			sys_lchown
+17	common	socket			sys_socket
+18	common	stat			sys_newstat			compat_sys_newstat
+19	common	lseek			sys_lseek			compat_sys_lseek
+20	common	getpid			sys_getpid
+21	common	mount			sys_mount
+22	common	bind			sys_bind
+23	common	setuid			sys_setuid
+24	common	getuid			sys_getuid
+25	32	stime			sys_stime32
+25	64	stime			sys_stime
+26	common	ptrace			sys_ptrace			compat_sys_ptrace
+27	common	alarm			sys_alarm
+28	common	fstat			sys_newfstat			compat_sys_newfstat
+29	common	pause			sys_pause
+30	32	utime			sys_utime32
+30	64	utime			sys_utime
+31	common	connect			sys_connect
+32	common	listen			sys_listen
+33	common	access			sys_access
+34	common	nice			sys_nice
+35	common	accept			sys_accept
+36	common	sync			sys_sync
+37	common	kill			sys_kill
+38	common	rename			sys_rename
+39	common	mkdir			sys_mkdir
+40	common	rmdir			sys_rmdir
+41	common	dup			sys_dup
+42	common	pipe			sys_pipe
+43	common	times			sys_times			compat_sys_times
+44	common	getsockname		sys_getsockname
+45	common	brk			sys_brk
+46	common	setgid			sys_setgid
+47	common	getgid			sys_getgid
+48	common	signal			sys_signal
+49	common	geteuid			sys_geteuid
+50	common	getegid			sys_getegid
+51	common	acct			sys_acct
+52	common	umount2			sys_umount
+53	common	getpeername		sys_getpeername
+54	common	ioctl			sys_ioctl			compat_sys_ioctl
+55	common	fcntl			sys_fcntl			compat_sys_fcntl
+56	common	socketpair		sys_socketpair
+57	common	setpgid			sys_setpgid
+58	common	send			sys_send
+59	common	uname			sys_newuname
+60	common	umask			sys_umask
+61	common	chroot			sys_chroot
+62	common	ustat			sys_ustat			compat_sys_ustat
+63	common	dup2			sys_dup2
+64	common	getppid			sys_getppid
+65	common	getpgrp			sys_getpgrp
+66	common	setsid			sys_setsid
+67	common	pivot_root		sys_pivot_root
+68	common	sgetmask		sys_sgetmask			sys32_unimplemented
+69	common	ssetmask		sys_ssetmask			sys32_unimplemented
+70	common	setreuid		sys_setreuid
+71	common	setregid		sys_setregid
+72	common	mincore			sys_mincore
+73	common	sigpending		sys_sigpending			compat_sys_sigpending
+74	common	sethostname		sys_sethostname
+75	common	setrlimit		sys_setrlimit			compat_sys_setrlimit
+76	common	getrlimit		sys_getrlimit			compat_sys_getrlimit
+77	common	getrusage		sys_getrusage			compat_sys_getrusage
+78	common	gettimeofday		sys_gettimeofday		compat_sys_gettimeofday
+79	common	settimeofday		sys_settimeofday		compat_sys_settimeofday
+80	common	getgroups		sys_getgroups
+81	common	setgroups		sys_setgroups
+82	common	sendto			sys_sendto
+83	common	symlink			sys_symlink
+84	common	lstat			sys_newlstat			compat_sys_newlstat
+85	common	readlink		sys_readlink
+86	common	uselib			sys_ni_syscall
+87	common	swapon			sys_swapon
+88	common	reboot			sys_reboot
+89	common	mmap2			sys_mmap2
+90	common	mmap			sys_mmap
+91	common	munmap			sys_munmap
+92	common	truncate		sys_truncate			compat_sys_truncate
+93	common	ftruncate		sys_ftruncate			compat_sys_ftruncate
+94	common	fchmod			sys_fchmod
+95	common	fchown			sys_fchown
+96	common	getpriority		sys_getpriority
+97	common	setpriority		sys_setpriority
+98	common	recv			sys_recv			compat_sys_recv
+99	common	statfs			sys_statfs			compat_sys_statfs
+100	common	fstatfs			sys_fstatfs			compat_sys_fstatfs
+101	common	stat64			sys_stat64
+# 102 was socketcall
+103	common	syslog			sys_syslog
+104	common	setitimer		sys_setitimer			compat_sys_setitimer
+105	common	getitimer		sys_getitimer			compat_sys_getitimer
+106	common	capget			sys_capget
+107	common	capset			sys_capset
+108	32	pread64			parisc_pread64
+108	64	pread64			sys_pread64
+109	32	pwrite64		parisc_pwrite64
+109	64	pwrite64		sys_pwrite64
+110	common	getcwd			sys_getcwd
+111	common	vhangup			sys_vhangup
+112	common	fstat64			sys_fstat64
+113	common	vfork			sys_vfork_wrapper
+114	common	wait4			sys_wait4			compat_sys_wait4
+115	common	swapoff			sys_swapoff
+116	common	sysinfo			sys_sysinfo			compat_sys_sysinfo
+117	common	shutdown		sys_shutdown
+118	common	fsync			sys_fsync
+119	common	madvise			parisc_madvise
+120	common	clone			sys_clone_wrapper
+121	common	setdomainname		sys_setdomainname
+122	common	sendfile		sys_sendfile			compat_sys_sendfile
+123	common	recvfrom		sys_recvfrom			compat_sys_recvfrom
+124	32	adjtimex		sys_adjtimex_time32
+124	64	adjtimex		sys_adjtimex
+125	common	mprotect		sys_mprotect
+126	common	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
+# 127 was create_module
+128	common	init_module		sys_init_module
+129	common	delete_module		sys_delete_module
+# 130 was get_kernel_syms
+131	common	quotactl		sys_quotactl
+132	common	getpgid			sys_getpgid
+133	common	fchdir			sys_fchdir
+134	common	bdflush			sys_ni_syscall
+135	common	sysfs			sys_sysfs
+136	32	personality		parisc_personality
+136	64	personality		sys_personality
+# 137 was afs_syscall
+138	common	setfsuid		sys_setfsuid
+139	common	setfsgid		sys_setfsgid
+140	common	_llseek			sys_llseek
+141	common	getdents		sys_getdents			compat_sys_getdents
+142	common	_newselect		sys_select			compat_sys_select
+143	common	flock			sys_flock
+144	common	msync			sys_msync
+145	common	readv			sys_readv
+146	common	writev			sys_writev
+147	common	getsid			sys_getsid
+148	common	fdatasync		sys_fdatasync
+149	common	_sysctl			sys_ni_syscall
+150	common	mlock			sys_mlock
+151	common	munlock			sys_munlock
+152	common	mlockall		sys_mlockall
+153	common	munlockall		sys_munlockall
+154	common	sched_setparam		sys_sched_setparam
+155	common	sched_getparam		sys_sched_getparam
+156	common	sched_setscheduler	sys_sched_setscheduler
+157	common	sched_getscheduler	sys_sched_getscheduler
+158	common	sched_yield		sys_sched_yield
+159	common	sched_get_priority_max	sys_sched_get_priority_max
+160	common	sched_get_priority_min	sys_sched_get_priority_min
+161	32	sched_rr_get_interval	sys_sched_rr_get_interval_time32
+161	64	sched_rr_get_interval	sys_sched_rr_get_interval
+162	32	nanosleep		sys_nanosleep_time32
+162	64	nanosleep		sys_nanosleep
+163	common	mremap			sys_mremap
+164	common	setresuid		sys_setresuid
+165	common	getresuid		sys_getresuid
+166	common	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
+# 167 was query_module
+168	common	poll			sys_poll
+# 169 was nfsservctl
+170	common	setresgid		sys_setresgid
+171	common	getresgid		sys_getresgid
+172	common	prctl			sys_prctl
+173	common	rt_sigreturn		sys_rt_sigreturn_wrapper
+174	common	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
+175	common	rt_sigprocmask		sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+176	common	rt_sigpending		sys_rt_sigpending		compat_sys_rt_sigpending
+177	32	rt_sigtimedwait		sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+177	64	rt_sigtimedwait		sys_rt_sigtimedwait
+178	common	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+179	common	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+180	common	chown			sys_chown
+181	common	setsockopt		sys_setsockopt			sys_setsockopt
+182	common	getsockopt		sys_getsockopt			sys_getsockopt
+183	common	sendmsg			sys_sendmsg			compat_sys_sendmsg
+184	common	recvmsg			sys_recvmsg			compat_sys_recvmsg
+185	common	semop			sys_semop
+186	common	semget			sys_semget
+187	common	semctl			sys_semctl			compat_sys_semctl
+188	common	msgsnd			sys_msgsnd			compat_sys_msgsnd
+189	common	msgrcv			sys_msgrcv			compat_sys_msgrcv
+190	common	msgget			sys_msgget
+191	common	msgctl			sys_msgctl			compat_sys_msgctl
+192	common	shmat			sys_shmat			compat_sys_shmat
+193	common	shmdt			sys_shmdt
+194	common	shmget			sys_shmget
+195	common	shmctl			sys_shmctl			compat_sys_shmctl
+# 196 was getpmsg
+# 197 was putpmsg
+198	common	lstat64			sys_lstat64
+199	32	truncate64		parisc_truncate64
+199	64	truncate64		sys_truncate64
+200	32	ftruncate64		parisc_ftruncate64
+200	64	ftruncate64		sys_ftruncate64
+201	common	getdents64		sys_getdents64
+202	common	fcntl64			sys_fcntl64			compat_sys_fcntl64
+# 203 was attrctl
+# 204 was acl_get
+# 205 was acl_set
+206	common	gettid			sys_gettid
+207	32	readahead		parisc_readahead
+207	64	readahead		sys_readahead
+208	common	tkill			sys_tkill
+209	common	sendfile64		sys_sendfile64			compat_sys_sendfile64
+210	32	futex			sys_futex_time32
+210	64	futex			sys_futex
+211	common	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
+212	common	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
+# 213 was set_thread_area
+# 214 was get_thread_area
+215	common	io_setup		sys_io_setup			compat_sys_io_setup
+216	common	io_destroy		sys_io_destroy
+217	32	io_getevents		sys_io_getevents_time32
+217	64	io_getevents		sys_io_getevents
+218	common	io_submit		sys_io_submit			compat_sys_io_submit
+219	common	io_cancel		sys_io_cancel
+# 220 was alloc_hugepages
+# 221 was free_hugepages
+222	common	exit_group		sys_exit_group
+223	common	lookup_dcookie		sys_ni_syscall
+224	common	epoll_create		sys_epoll_create
+225	common	epoll_ctl		sys_epoll_ctl
+226	common	epoll_wait		sys_epoll_wait
+227	common	remap_file_pages	sys_remap_file_pages
+228	32	semtimedop		sys_semtimedop_time32
+228	64	semtimedop		sys_semtimedop
+229	common	mq_open			sys_mq_open			compat_sys_mq_open
+230	common	mq_unlink		sys_mq_unlink
+231	32	mq_timedsend		sys_mq_timedsend_time32
+231	64	mq_timedsend		sys_mq_timedsend
+232	32	mq_timedreceive		sys_mq_timedreceive_time32
+232	64	mq_timedreceive		sys_mq_timedreceive
+233	common	mq_notify		sys_mq_notify			compat_sys_mq_notify
+234	common	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
+235	common	waitid			sys_waitid			compat_sys_waitid
+236	32	fadvise64_64		parisc_fadvise64_64
+236	64	fadvise64_64		sys_fadvise64_64
+237	common	set_tid_address		sys_set_tid_address
+238	common	setxattr		sys_setxattr
+239	common	lsetxattr		sys_lsetxattr
+240	common	fsetxattr		sys_fsetxattr
+241	common	getxattr		sys_getxattr
+242	common	lgetxattr		sys_lgetxattr
+243	common	fgetxattr		sys_fgetxattr
+244	common	listxattr		sys_listxattr
+245	common	llistxattr		sys_llistxattr
+246	common	flistxattr		sys_flistxattr
+247	common	removexattr		sys_removexattr
+248	common	lremovexattr		sys_lremovexattr
+249	common	fremovexattr		sys_fremovexattr
+250	common	timer_create		sys_timer_create		compat_sys_timer_create
+251	32	timer_settime		sys_timer_settime32
+251	64	timer_settime		sys_timer_settime
+252	32	timer_gettime		sys_timer_gettime32
+252	64	timer_gettime		sys_timer_gettime
+253	common	timer_getoverrun	sys_timer_getoverrun
+254	common	timer_delete		sys_timer_delete
+255	32	clock_settime		sys_clock_settime32
+255	64	clock_settime		sys_clock_settime
+256	32	clock_gettime		sys_clock_gettime32
+256	64	clock_gettime		sys_clock_gettime
+257	32	clock_getres		sys_clock_getres_time32
+257	64	clock_getres		sys_clock_getres
+258	32	clock_nanosleep		sys_clock_nanosleep_time32
+258	64	clock_nanosleep		sys_clock_nanosleep
+259	common	tgkill			sys_tgkill
+260	common	mbind			sys_mbind
+261	common	get_mempolicy		sys_get_mempolicy
+262	common	set_mempolicy		sys_set_mempolicy
+# 263 was vserver
+264	common	add_key			sys_add_key
+265	common	request_key		sys_request_key
+266	common	keyctl			sys_keyctl			compat_sys_keyctl
+267	common	ioprio_set		sys_ioprio_set
+268	common	ioprio_get		sys_ioprio_get
+269	common	inotify_init		sys_inotify_init
+270	common	inotify_add_watch	sys_inotify_add_watch
+271	common	inotify_rm_watch	sys_inotify_rm_watch
+272	common	migrate_pages		sys_migrate_pages
+273	32	pselect6		sys_pselect6_time32		compat_sys_pselect6_time32
+273	64	pselect6		sys_pselect6
+274	32	ppoll			sys_ppoll_time32		compat_sys_ppoll_time32
+274	64	ppoll			sys_ppoll
+275	common	openat			sys_openat			compat_sys_openat
+276	common	mkdirat			sys_mkdirat
+277	common	mknodat			sys_mknodat
+278	common	fchownat		sys_fchownat
+279	32	futimesat		sys_futimesat_time32
+279	64	futimesat		sys_futimesat
+280	common	fstatat64		sys_fstatat64
+281	common	unlinkat		sys_unlinkat
+282	common	renameat		sys_renameat
+283	common	linkat			sys_linkat
+284	common	symlinkat		sys_symlinkat
+285	common	readlinkat		sys_readlinkat
+286	common	fchmodat		sys_fchmodat
+287	common	faccessat		sys_faccessat
+288	common	unshare			sys_unshare
+289	common	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
+290	common	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
+291	common	splice			sys_splice
+292	32	sync_file_range		parisc_sync_file_range
+292	64	sync_file_range		sys_sync_file_range
+293	common	tee			sys_tee
+294	common	vmsplice		sys_vmsplice
+295	common	move_pages		sys_move_pages
+296	common	getcpu			sys_getcpu
+297	common	epoll_pwait		sys_epoll_pwait			compat_sys_epoll_pwait
+298	common	statfs64		sys_statfs64			compat_sys_statfs64
+299	common	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
+300	common	kexec_load		sys_kexec_load			compat_sys_kexec_load
+301	32	utimensat		sys_utimensat_time32
+301	64	utimensat		sys_utimensat
+302	common	signalfd		sys_signalfd			compat_sys_signalfd
+# 303 was timerfd
+304	common	eventfd			sys_eventfd
+305	32	fallocate		parisc_fallocate
+305	64	fallocate		sys_fallocate
+306	common	timerfd_create		parisc_timerfd_create
+307	32	timerfd_settime		sys_timerfd_settime32
+307	64	timerfd_settime		sys_timerfd_settime
+308	32	timerfd_gettime		sys_timerfd_gettime32
+308	64	timerfd_gettime		sys_timerfd_gettime
+309	common	signalfd4		parisc_signalfd4		parisc_compat_signalfd4
+310	common	eventfd2		parisc_eventfd2
+311	common	epoll_create1		sys_epoll_create1
+312	common	dup3			sys_dup3
+313	common	pipe2			parisc_pipe2
+314	common	inotify_init1		parisc_inotify_init1
+315	common	preadv	sys_preadv	compat_sys_preadv
+316	common	pwritev	sys_pwritev	compat_sys_pwritev
+317	common	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+318	common	perf_event_open		sys_perf_event_open
+319	32	recvmmsg		sys_recvmmsg_time32		compat_sys_recvmmsg_time32
+319	64	recvmmsg		sys_recvmmsg
+320	common	accept4			sys_accept4
+321	common	prlimit64		sys_prlimit64
+322	common	fanotify_init		sys_fanotify_init
+323	common	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
+324	32	clock_adjtime		sys_clock_adjtime32
+324	64	clock_adjtime		sys_clock_adjtime
+325	common	name_to_handle_at	sys_name_to_handle_at
+326	common	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
+327	common	syncfs			sys_syncfs
+328	common	setns			sys_setns
+329	common	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
+330	common	process_vm_readv	sys_process_vm_readv
+331	common	process_vm_writev	sys_process_vm_writev
+332	common	kcmp			sys_kcmp
+333	common	finit_module		sys_finit_module
+334	common	sched_setattr		sys_sched_setattr
+335	common	sched_getattr		sys_sched_getattr
+336	32	utimes			sys_utimes_time32
+336	64	utimes			sys_utimes
+337	common	renameat2		sys_renameat2
+338	common	seccomp			sys_seccomp
+339	common	getrandom		sys_getrandom
+340	common	memfd_create		sys_memfd_create
+341	common	bpf			sys_bpf
+342	common	execveat		sys_execveat			compat_sys_execveat
+343	common	membarrier		sys_membarrier
+344	common	userfaultfd		parisc_userfaultfd
+345	common	mlock2			sys_mlock2
+346	common	copy_file_range		sys_copy_file_range
+347	common	preadv2			sys_preadv2			compat_sys_preadv2
+348	common	pwritev2		sys_pwritev2			compat_sys_pwritev2
+349	common	statx			sys_statx
+350	32	io_pgetevents		sys_io_pgetevents_time32	compat_sys_io_pgetevents
+350	64	io_pgetevents		sys_io_pgetevents
+351	common	pkey_mprotect		sys_pkey_mprotect
+352	common	pkey_alloc		sys_pkey_alloc
+353	common	pkey_free		sys_pkey_free
+354	common	rseq			sys_rseq
+355	common	kexec_file_load		sys_kexec_file_load		sys_kexec_file_load
+356	common	cacheflush		sys_cacheflush
+# up to 402 is unassigned and reserved for arch specific syscalls
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
+435	common	clone3				sys_clone3_wrapper
+436	common	close_range			sys_close_range
+437	common	openat2				sys_openat2
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
+449	common	futex_waitv			sys_futex_waitv
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
+462	common	mseal				sys_mseal
diff --git a/tools/perf/arch/parisc/include/syscall_table.h b/tools/perf/arch/parisc/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..7ff51b783000d727ec48be960730b81ecdb05575
--- /dev/null
+++ b/tools/perf/arch/parisc/include/syscall_table.h
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
index a821df1fd4c0e78c9706304e5b8974cbc5ef4437..ae9f00ae79f34fec75ef2c91300ccd771c030529 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -207,6 +207,7 @@ check_2 tools/perf/arch/sh/entry/syscalls/syscall.tbl arch/sh/kernel/syscalls/sy
 check_2 tools/perf/arch/sparc/entry/syscalls/syscall.tbl arch/sparc/kernel/syscalls/syscall.tbl
 check_2 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl arch/xtensa/kernel/syscalls/syscall.tbl
 check_2 tools/perf/arch/alpha/entry/syscalls/syscall.tbl arch/alpha/entry/syscalls/syscall.tbl
+check_2 tools/perf/arch/parisc/entry/syscalls/syscall.tbl arch/parisc/entry/syscalls/syscall.tbl
 
 for i in "${BEAUTY_FILES[@]}"
 do

-- 
2.34.1


