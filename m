Return-Path: <linux-csky+bounces-1906-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 579E4A576EC
	for <lists+linux-csky@lfdr.de>; Sat,  8 Mar 2025 01:34:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4FE1887720
	for <lists+linux-csky@lfdr.de>; Sat,  8 Mar 2025 00:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4B9158553;
	Sat,  8 Mar 2025 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J0Hyhj7f"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F77F11CA0
	for <linux-csky@vger.kernel.org>; Sat,  8 Mar 2025 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741393955; cv=none; b=o2vEM6A0PbB/qO/y+L1kD0pmk4v1jVLMhnG3Uqy8QZ0sDkNzHrxt7SqAXxRyvOSG/qoYuIHOgdPaQZFxNxBXDiXMZJHDaiRTjrDF1Di3WBOkIyJz8j5/2NpvpbyHqmdlL+RamAtH5f81PrxahSV5kq7zsA2CXxq/9Y1Dib0jb1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741393955; c=relaxed/simple;
	bh=tkpE5yf6lhv0HCff3vMWjebf55ibmzUj0gG9xamBxYI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=I5K4wIgaLW/tb7cBnLEbRM6JE9DeOkFjBGKiaizgjbPKRSoIOZ8YcVEdlS2mysm9UHHSv2+w3zzHEFCvxWUSSn3y+w6wdBGrYDkXc1RVaCq9L/CvNso67mOu3RHSF8d1GctGTZDNnx0d+WA5n7xy6FhVecTp/2H+FSPCiORVwGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=J0Hyhj7f; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e60c24d9fe8so3515902276.0
        for <linux-csky@vger.kernel.org>; Fri, 07 Mar 2025 16:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741393953; x=1741998753; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uv3gSi2uGb/rZBWAfK/HKSoE0hwzZt2P2jyoBxCTag8=;
        b=J0Hyhj7f2teSDzB0noRG+aaD0kEjITmrfRt8wa9bgVdMZBhlA7GogHjvs3ae6TNcu9
         AywGsbIaA6+uNMG4FFSUdjxHqEmCjV0gaePEX1z/5ixybmu9mdleK7fJDmQV4H3Zz74a
         COOybBvxUbjCFMi08MMnj+WNMzwMz86mQkLwiw7hkilzAW3GxSabXDVnMEBUL2uheQ2W
         604i6Awby10LwxL+PtESNadwno/qRf3qn10VirOgZw6rljWNMYsNSDKq4bKU1uo4JEie
         7aPSVxW6+HSokY1tMenqz6aaUd63GKD9S+nfFsfJmiT8ZVCdFRVcgM0uVFpPHP091nld
         nPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741393953; x=1741998753;
        h=content-transfer-encoding:to:from:subject:references:mime-version
         :message-id:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uv3gSi2uGb/rZBWAfK/HKSoE0hwzZt2P2jyoBxCTag8=;
        b=UonQF9PfdLURhWr1af7y5iSlfewmMOz9EUFraxI/0rQcdaysXXm0Aj7ZBNWajmMRxY
         eAmc4U/vDh10S42ADzFD0+492qjcDU6/BYKfU5iEG7TRq6JPPg2atdMqb4UAWDk+bhQZ
         YGi0HKFe76pHJB7xXnq3/TIlZZ2LPizVXdoIz7ulbH7zbWFvfSqJ1rMvpHulLS4cHL9F
         pE+3VjTTGvR85qainvVDcN9D1O6mGLuwIw0B1xlyKWU6+ygiLBIu7LDmlBh3t+ihkjWi
         FhmeyAG0C4mgJFVRy3/EFSRNQa5D8JH3MHLAAasDFleCc+xAAY49nqKxU5y1WvIK5X3Y
         eAmA==
X-Forwarded-Encrypted: i=1; AJvYcCWoYTTmk23+zi/Tq240e0d0gcll+ppcrYHTG140ubNXteJoqLdoIcfhjKZeLWE//QPMBk0s3AmhRhTi@vger.kernel.org
X-Gm-Message-State: AOJu0YyXm1DizvtXlagQ6W5rs1JfCl8LJT1IJb+RfQ/sKm9wSDDzUhwA
	3chDpyw4IETFJJZDAEe0ABo/Mf8i/AeloyEV0AjMZoBJRLJsMy4iG+hhMr8Oo4b9+lno/ZQWgi6
	TDcZuwA==
X-Google-Smtp-Source: AGHT+IFs2Qu7hOI+ZkryA/SR8ozQLnfo7wV+jFqgt45ZHjCLNu9+c1jV23yEUzf/okxG+EJas0/wlMjGTuit
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:1541:e490:aa80:5766])
 (user=irogers job=sendgmr) by 2002:a25:dc47:0:b0:e63:699a:4e6b with SMTP id
 3f1490d57ef6-e63699a4ff7mr24016276.4.1741393953007; Fri, 07 Mar 2025 16:32:33
 -0800 (PST)
Date: Fri,  7 Mar 2025 16:32:07 -0800
In-Reply-To: <20250308003209.234114-1-irogers@google.com>
Message-Id: <20250308003209.234114-10-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250308003209.234114-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v5 09/11] perf syscalltbl: Use lookup table containing
 multiple architectures
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Switch to use the lookup table containing all architectures rather
than tables matching the perf binary.

This fixes perf trace when executed on a 32-bit i386 binary on an
x86-64 machine. Note in the following the system call names of the
32-bit i386 binary as seen by an x86-64 perf.

Before:
```
         ? (         ): a.out/447296  ... [continued]: munmap())           =
                                =3D 0
     0.024 ( 0.001 ms): a.out/447296 recvfrom(ubuf: 0x2, size: 4160585708, =
flags: DONTROUTE|CTRUNC|TRUNC|DONTWAIT|EOR|WAITALL|FIN|SYN|CONFIRM|RST|ERRQ=
UEUE|NOSIGNAL|WAITFORONE|BATCH|SOCK_DEVMEM|ZEROCOPY|FASTOPEN|CMSG_CLOEXEC|0=
x91f80000, addr: 0xe30, addr_len: 0xffce438c) =3D 1475198976
     0.042 ( 0.003 ms): a.out/447296 lgetxattr(name: "", value: 0x3, size: =
34)                             =3D 4160344064
     0.054 ( 0.003 ms): a.out/447296 dup2(oldfd: -134422744, newfd: 4)     =
                                =3D -1 ENOENT (No such file or directory)
     0.060 ( 0.009 ms): a.out/447296 preadv(fd: 4294967196, vec: (struct io=
vec){.iov_base =3D (void *)0x2e646c2f6374652f,.iov_len =3D (__kernel_size_t=
)7307199665335594867,}, vlen: 557056, pos_h: 4160585708) =3D 3
     0.074 ( 0.004 ms): a.out/447296 lgetxattr(name: "", value: 0x1, size: =
2)                              =3D 4160237568
     0.080 ( 0.001 ms): a.out/447296 lstat(filename: "", statbuf: 0x193f6) =
                                =3D 0
     0.089 ( 0.007 ms): a.out/447296 preadv(fd: 4294967196, vec: (struct io=
vec){.iov_base =3D (void *)0x3833692f62696c2f,.iov_len =3D (__kernel_size_t=
)3276497845987585334,}, vlen: 557056, pos_h: 4160585708) =3D 3
     0.097 ( 0.002 ms): a.out/447296 close(fd: 3</proc/447296/status>)     =
                                =3D 512
     0.103 ( 0.002 ms): a.out/447296 lgetxattr(name: "", value: 0x1, size: =
2050)                           =3D 4157935616
     0.107 ( 0.007 ms): a.out/447296 lgetxattr(pathname: "", name: "", valu=
e: 0x5, size: 2066)             =3D 4158078976
     0.116 ( 0.003 ms): a.out/447296 lgetxattr(pathname: "", name: "", valu=
e: 0x1, size: 2066)             =3D 4159639552
     0.121 ( 0.003 ms): a.out/447296 lgetxattr(pathname: "", name: "", valu=
e: 0x3, size: 2066)             =3D 4160184320
     0.129 ( 0.002 ms): a.out/447296 lgetxattr(pathname: "", name: "", valu=
e: 0x3, size: 50)               =3D 4160196608
     0.138 ( 0.001 ms): a.out/447296 lstat(filename: "")                   =
                                =3D 0
     0.145 ( 0.002 ms): a.out/447296 mq_timedreceive(mqdes: 4291706800, u_m=
sg_ptr: 0xf7f9ea48, msg_len: 134616640, u_msg_prio: 0xf7fd7fec, u_abs_timeo=
ut: (struct __kernel_timespec){.tv_sec =3D (__kernel_time64_t)-578174027777=
317696,.tv_nsec =3D (long long int)4160349376,}) =3D 0
     0.148 ( 0.001 ms): a.out/447296 mkdirat(dfd: -134617816, pathname: " =
=EF=BF=BD=EF=BF=BD=EF=BF=BD =EF=BF=BD=EF=BF=BD=EF=BF=BD=E2=96=92=EF=BF=BD=
=EF=BF=BD=EF=BF=BD=E2=96=92=EF=BF=BD=EF=BF=BD=EF=BF=BD", mode: IFREG|ISUID|=
IRUSR|IWGRP|0xf7fd0000) =3D 447296
     0.150 ( 0.001 ms): a.out/447296 process_vm_writev(pid: -134617812, lve=
c: (struct iovec){.iov_base =3D (void *)0xf7f9e9c8f7f9e4c0,.iov_len =3D (__=
kernel_size_t)4160349376,}, liovcnt: 4160588048, rvec: (struct iovec){}, ri=
ovcnt: 4160585708, flags: 4291707352) =3D 0
     0.197 ( 0.004 ms): a.out/447296 capget(header: 4160184320, dataptr: 81=
92)                             =3D 0
     0.202 ( 0.002 ms): a.out/447296 capget(header: 1448669184, dataptr: 40=
96)                             =3D 0
     0.208 ( 0.002 ms): a.out/447296 capget(header: 4160577536, dataptr: 81=
92)                             =3D 0
     0.220 ( 0.001 ms): a.out/447296 getxattr(pathname: "", name: "c=EF=BF=
=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD=EF=BF=BD", value: 0xf7f77e34, size:=
 1)  =3D 0
     0.228 ( 0.005 ms): a.out/447296 fchmod(fd: -134729728, mode: IRUGO|IWU=
GO|IFREG|IFIFO|ISVTX|IXUSR|0x10000) =3D 0
     0.240 ( 0.009 ms): a.out/447296 preadv(fd: 4294967196, vec: 0x5658e008=
, pos_h: 4160192052)            =3D 3
     0.250 ( 0.008 ms): a.out/447296 close(fd: 3</proc/447296/status>)     =
                                =3D 1436
     0.260 ( 0.018 ms): a.out/447296 stat(filename: "", statbuf: 0xffce32ac=
)                               =3D 1436
     0.288 (1000.213 ms): a.out/447296 readlinkat(buf: 0xffce31d4, bufsiz: =
4291703244)                       =3D 0
```

After:
```
         ? (         ): a.out/442930  ... [continued]: execve())           =
                                =3D 0
     0.023 ( 0.002 ms): a.out/442930 brk()                                 =
                                =3D 0x57760000
     0.052 ( 0.003 ms): a.out/442930 access(filename: 0xf7f5af28, mode: R) =
                                =3D -1 ENOENT (No such file or directory)
     0.059 ( 0.009 ms): a.out/442930 openat(dfd: CWD, filename: "/etc/ld.so=
.cache", flags: RDONLY|CLOEXEC|LARGEFILE) =3D 3
     0.078 ( 0.001 ms): a.out/442930 close(fd: 3</proc/442930/status>)     =
                                =3D 0
     0.087 ( 0.007 ms): a.out/442930 openat(dfd: CWD, filename: "/lib/i386-=
linux-", flags: RDONLY|CLOEXEC|LARGEFILE) =3D 3
     0.095 ( 0.002 ms): a.out/442930 read(fd: 3</proc/442930/status>, buf: =
0xffbdbb70, count: 512)         =3D 512
     0.135 ( 0.001 ms): a.out/442930 close(fd: 3</proc/442930/status>)     =
                                =3D 0
     0.148 ( 0.001 ms): a.out/442930 set_tid_address(tidptr: 0xf7f2b528)   =
                                =3D 442930 (a.out)
     0.150 ( 0.001 ms): a.out/442930 set_robust_list(head: 0xf7f2b52c, len:=
 12)                            =3D
     0.196 ( 0.004 ms): a.out/442930 mprotect(start: 0xf7f03000, len: 8192,=
 prot: READ)                    =3D 0
     0.202 ( 0.002 ms): a.out/442930 mprotect(start: 0x5658e000, len: 4096,=
 prot: READ)                    =3D 0
     0.207 ( 0.002 ms): a.out/442930 mprotect(start: 0xf7f63000, len: 8192,=
 prot: READ)                    =3D 0
     0.230 ( 0.005 ms): a.out/442930 munmap(addr: 0xf7f10000, len: 103414) =
                                =3D 0
     0.244 ( 0.010 ms): a.out/442930 openat(dfd: CWD, filename: 0x5658d008)=
                                =3D 3
     0.255 ( 0.007 ms): a.out/442930 read(fd: 3</proc/442930/status>, buf: =
0xffbdb67c, count: 4096)        =3D 1436
     0.264 ( 0.018 ms): a.out/442930 write(fd: 1</dev/pts/4>, buf: , count:=
 1436)                          =3D 1436
     0.292 (1000.173 ms): a.out/442930 clock_nanosleep(rqtp: { .tv_sec: 178=
66546940376776704, .tv_nsec: 4159878336 }, rmtp: 0xffbdb59c) =3D 0
  1000.478 (         ): a.out/442930 exit_group()                          =
                                =3D ?
```

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Howard Chu <howardchu95@gmail.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/util/syscalltbl.c | 89 ++++++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 760ac4d0869f..db0d2b81aed1 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -15,16 +15,39 @@
 #include <string.h>
 #include "string2.h"
=20
-#if __BITS_PER_LONG =3D=3D 64
-  #include <asm/syscalls_64.h>
-#else
-  #include <asm/syscalls_32.h>
-#endif
+#include "trace/beauty/generated/syscalltbl.c"
=20
-const char *syscalltbl__name(int e_machine __maybe_unused, int id)
+static const struct syscalltbl *find_table(int e_machine)
 {
-	if (id >=3D 0 && id <=3D (int)ARRAY_SIZE(syscall_num_to_name))
-		return syscall_num_to_name[id];
+	static const struct syscalltbl *last_table;
+	static int last_table_machine =3D EM_NONE;
+
+	/* Tables only exist for EM_SPARC. */
+	if (e_machine =3D=3D EM_SPARCV9)
+		e_machine =3D EM_SPARC;
+
+	if (last_table_machine =3D=3D e_machine && last_table !=3D NULL)
+		return last_table;
+
+	for (size_t i =3D 0; i < ARRAY_SIZE(syscalltbls); i++) {
+		const struct syscalltbl *entry =3D &syscalltbls[i];
+
+		if (entry->e_machine !=3D e_machine && entry->e_machine !=3D EM_NONE)
+			continue;
+
+		last_table =3D entry;
+		last_table_machine =3D e_machine;
+		return entry;
+	}
+	return NULL;
+}
+
+const char *syscalltbl__name(int e_machine, int id)
+{
+	const struct syscalltbl *table =3D find_table(e_machine);
+
+	if (table && id >=3D 0 && id < table->num_to_name_len)
+		return table->num_to_name[id];
 	return NULL;
 }
=20
@@ -41,38 +64,54 @@ static int syscallcmpname(const void *vkey, const void =
*ventry)
 	return strcmp(key->name, key->tbl[*entry]);
 }
=20
-int syscalltbl__id(int e_machine __maybe_unused, const char *name)
+int syscalltbl__id(int e_machine, const char *name)
 {
-	struct syscall_cmp_key key =3D {
-		.name =3D name,
-		.tbl =3D syscall_num_to_name,
-	};
-	const int *id =3D bsearch(&key, syscall_sorted_names,
-				ARRAY_SIZE(syscall_sorted_names),
-				sizeof(syscall_sorted_names[0]),
-				syscallcmpname);
+	const struct syscalltbl *table =3D find_table(e_machine);
+	struct syscall_cmp_key key;
+	const int *id;
+
+	if (!table)
+		return -1;
+
+	key.name =3D name;
+	key.tbl =3D table->num_to_name;
+	id =3D bsearch(&key, table->sorted_names, table->sorted_names_len,
+		     sizeof(table->sorted_names[0]), syscallcmpname);
=20
 	return id ? *id : -1;
 }
=20
-int syscalltbl__num_idx(int e_machine __maybe_unused)
+int syscalltbl__num_idx(int e_machine)
 {
-	return ARRAY_SIZE(syscall_sorted_names);
+	const struct syscalltbl *table =3D find_table(e_machine);
+
+	if (!table)
+		return 0;
+
+	return table->sorted_names_len;
 }
=20
-int syscalltbl__id_at_idx(int e_machine __maybe_unused, int idx)
+int syscalltbl__id_at_idx(int e_machine, int idx)
 {
-	return syscall_sorted_names[idx];
+	const struct syscalltbl *table =3D find_table(e_machine);
+
+	if (!table)
+		return -1;
+
+	assert(idx >=3D 0 && idx < table->sorted_names_len);
+	return table->sorted_names[idx];
 }
=20
-int syscalltbl__strglobmatch_next(int e_machine __maybe_unused, const char=
 *syscall_glob, int *idx)
+int syscalltbl__strglobmatch_next(int e_machine, const char *syscall_glob,=
 int *idx)
 {
-	for (int i =3D *idx + 1; i < (int)ARRAY_SIZE(syscall_sorted_names); ++i) =
{
-		const char *name =3D syscall_num_to_name[syscall_sorted_names[i]];
+	const struct syscalltbl *table =3D find_table(e_machine);
+
+	for (int i =3D *idx + 1; table && i < table->sorted_names_len; ++i) {
+		const char *name =3D table->num_to_name[table->sorted_names[i]];
=20
 		if (strglobmatch(name, syscall_glob)) {
 			*idx =3D i;
-			return syscall_sorted_names[i];
+			return table->sorted_names[i];
 		}
 	}
=20
--=20
2.49.0.rc0.332.g42c0ae87b1-goog


