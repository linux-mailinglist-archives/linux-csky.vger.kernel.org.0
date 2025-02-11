Return-Path: <linux-csky+bounces-1772-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BDEA2FF06
	for <lists+linux-csky@lfdr.de>; Tue, 11 Feb 2025 01:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D35F3A6CA4
	for <lists+linux-csky@lfdr.de>; Tue, 11 Feb 2025 00:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802B3595A;
	Tue, 11 Feb 2025 00:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="G9yWfml4"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f193.google.com (mail-yw1-f193.google.com [209.85.128.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EA4134B0
	for <linux-csky@vger.kernel.org>; Tue, 11 Feb 2025 00:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233413; cv=none; b=phUvRNAIpC+YE1N2F2gHVytV2GV9EJtLOBIDFz0I0zoYmL0VCVxk0FNf/LNrPFXtbyhXbsRqZWDs7rM5hkrIIGdW1G8+i6/rn6cDn3BcIJgidyZovx5fP3U9zJmuRlJNvZOv9xIqOhNhXpSuO1R5CpcxgmQLq58LDH8bE4pmbts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233413; c=relaxed/simple;
	bh=AopigPBAn3GXV2cawRws8/86QdyKd0HOJ73h/vhCKbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PODgwedOQn1WmFW6lZuqXJXc5AhbUApTvXSRXQx3rU3lsPEfTXjOoDGgp8Wtr7qYXvy83CamNz3NE2sTpY4CVnS+np3QvZxPZvgzKawUhlynRTqryCfRHRnUcUmKJ2Tr5if0R7bhUKS9V5wKUdF8uqZSHqqUa/SrKeh5wIy+eLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=G9yWfml4; arc=none smtp.client-ip=209.85.128.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yw1-f193.google.com with SMTP id 00721157ae682-6f6ca9a3425so44952447b3.2
        for <linux-csky@vger.kernel.org>; Mon, 10 Feb 2025 16:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739233409; x=1739838209; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qlUFik2Cn3+UF32BcSaPs8X9uoxvxbSY4EvgNwl3nLs=;
        b=G9yWfml4gvh4Txm8kI5UK/SeAQC1j//eIafj8xtOw+ZoEGnn/YhCDiLAH4z0A0xRuj
         +s27flFZgtItTnl10oTmd9gv5xsXyAV6qDPii1he96Qjgw/x4PkfxLgEg20mX1xTWUTl
         rh5s08w0LwJpi1Tv+bRMMGNkv8dbD3iM+16GifTZeCV3CpYSNgJjraiK5mygnrngYktf
         3mKDVFAvOo7V/8XbGhkotAzgwwGDpKAgyuTz6gLDFGJaDrWubG0t1s7dg/QeLE73sqxk
         6gC/AF7KarftnQv2FUtBEICaIAnIcmG4ww783U6qQ2BY/3G6FCKcyJ1KBOCz5LWSZysw
         ey8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739233409; x=1739838209;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qlUFik2Cn3+UF32BcSaPs8X9uoxvxbSY4EvgNwl3nLs=;
        b=ZTsdVtgVBsUqsLERdTq5mNj3RPGR234OgD9k0sYPAAC/DdMvFSvYI50z/2UvnRaiTX
         rULbC2zXDtUwxt6RzcQ+ci41ROxaFP/WGdTojMCdwpHi6A85fJuX2o3LxZBQoxioXuEL
         upA3avARIsvChVFxKIk5D41BqnJYhK/ktpRzFulvG4vsCV2qCPkiooI/1xzFvotwvbX9
         NlbJm4REvhvAzMxbSJzaPcLeXHHx7hfGiFSESuZUgnVs0PAqyQ5P1CyKpPqenrLMic/b
         /hietYmPXJtvkoL/bXGPgM9OxlKynonO6V96ClfIOWrmCSzg9sUk75NlwT02nZUD1pSn
         KpLw==
X-Forwarded-Encrypted: i=1; AJvYcCVxnL2ZN9Pm1iDLc3JXIhgvnjE5vBo1nPUd5aDkBT4cZ5kD+BTKY4iSSU1bbKNeG3+B7dJctvGn9ejm@vger.kernel.org
X-Gm-Message-State: AOJu0YyhKE40CTWwauYm9bbE6L0u6wrWLJ20rqIEzr5q4gr6MABdPcCr
	KzsxJDUpELAZHlofEOL6wd3TKl9UCKNneKPSq+CtQqty0msgMMffkjeuZSe6IcE=
X-Gm-Gg: ASbGncuWzikp235qw/oCx442h5Lkgv8w5xezlIqVwnMG7vACIS7u6Rw4TMoaR04iWGl
	AuAzvvz//7NeWiXDzNee6IXzNCt2v1/jNRsz+28vKsG5eyQeH7EBJy1o2o3Zj8ViPwkBLF5+E7j
	GQFVLpFMUqCuZ7+qh8lLRwHrOyxZYySZoXLYYmBAQb7c6DtCAKnM36hq6pzOw0W7Bx1Zyns5jQh
	vNzag7OW0ft0vfdSM0dgjqA8fI5SmGQxl93jMzXO9I5NcJ1mh5dMELhePnGv2+skswN5tM7v8Rw
	zYw=
X-Google-Smtp-Source: AGHT+IFSyb6+nkjB0xsO1NPVunIuHs7rXC4UlzNdyRAuB/KbUs8KTwwp4ehcJv9y4ufISKopybkvhw==
X-Received: by 2002:a05:690c:4448:b0:6ef:827b:2442 with SMTP id 00721157ae682-6f9b29dfba4mr162843667b3.35.1739233408845;
        Mon, 10 Feb 2025 16:23:28 -0800 (PST)
Received: from ghost ([50.146.0.9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f99ffc0aeasm18931437b3.96.2025.02.10.16.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:23:27 -0800 (PST)
Date: Mon, 10 Feb 2025 16:23:26 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Bibo Mao <maobibo@loongson.cn>,
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 6/7] perf syscalltbl: Use lookup table containing
 multiple architectures
Message-ID: <Z6qYfrdGlfHj4XEL@ghost>
References: <20250210165108.95894-1-irogers@google.com>
 <20250210165108.95894-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210165108.95894-7-irogers@google.com>

On Mon, Feb 10, 2025 at 08:51:07AM -0800, Ian Rogers wrote:
> Switch to use the lookup table containing all architectures rather
> than tables matching the perf binary.
> 
> This fixes perf trace when executed on a 32-bit i386 binary on an
> x86-64 machine. Note in the following the system call names of the
> 32-bit i386 binary as seen by an x86-64 perf.
> 
> Before:
> ```
>          ? (         ): a.out/447296  ... [continued]: munmap())                                           = 0
>      0.024 ( 0.001 ms): a.out/447296 recvfrom(ubuf: 0x2, size: 4160585708, flags: DONTROUTE|CTRUNC|TRUNC|DONTWAIT|EOR|WAITALL|FIN|SYN|CONFIRM|RST|ERRQUEUE|NOSIGNAL|WAITFORONE|BATCH|SOCK_DEVMEM|ZEROCOPY|FASTOPEN|CMSG_CLOEXEC|0x91f80000, addr: 0xe30, addr_len: 0xffce438c) = 1475198976
>      0.042 ( 0.003 ms): a.out/447296 lgetxattr(name: "", value: 0x3, size: 34)                             = 4160344064
>      0.054 ( 0.003 ms): a.out/447296 dup2(oldfd: -134422744, newfd: 4)                                     = -1 ENOENT (No such file or directory)
>      0.060 ( 0.009 ms): a.out/447296 preadv(fd: 4294967196, vec: (struct iovec){.iov_base = (void *)0x2e646c2f6374652f,.iov_len = (__kernel_size_t)7307199665335594867,}, vlen: 557056, pos_h: 4160585708) = 3
>      0.074 ( 0.004 ms): a.out/447296 lgetxattr(name: "", value: 0x1, size: 2)                              = 4160237568
>      0.080 ( 0.001 ms): a.out/447296 lstat(filename: "", statbuf: 0x193f6)                                 = 0
>      0.089 ( 0.007 ms): a.out/447296 preadv(fd: 4294967196, vec: (struct iovec){.iov_base = (void *)0x3833692f62696c2f,.iov_len = (__kernel_size_t)3276497845987585334,}, vlen: 557056, pos_h: 4160585708) = 3
>      0.097 ( 0.002 ms): a.out/447296 close(fd: 3</proc/447296/status>)                                     = 512
>      0.103 ( 0.002 ms): a.out/447296 lgetxattr(name: "", value: 0x1, size: 2050)                           = 4157935616
>      0.107 ( 0.007 ms): a.out/447296 lgetxattr(pathname: "", name: "", value: 0x5, size: 2066)             = 4158078976
>      0.116 ( 0.003 ms): a.out/447296 lgetxattr(pathname: "", name: "", value: 0x1, size: 2066)             = 4159639552
>      0.121 ( 0.003 ms): a.out/447296 lgetxattr(pathname: "", name: "", value: 0x3, size: 2066)             = 4160184320
>      0.129 ( 0.002 ms): a.out/447296 lgetxattr(pathname: "", name: "", value: 0x3, size: 50)               = 4160196608
>      0.138 ( 0.001 ms): a.out/447296 lstat(filename: "")                                                   = 0
>      0.145 ( 0.002 ms): a.out/447296 mq_timedreceive(mqdes: 4291706800, u_msg_ptr: 0xf7f9ea48, msg_len: 134616640, u_msg_prio: 0xf7fd7fec, u_abs_timeout: (struct __kernel_timespec){.tv_sec = (__kernel_time64_t)-578174027777317696,.tv_nsec = (long long int)4160349376,}) = 0
>      0.148 ( 0.001 ms): a.out/447296 mkdirat(dfd: -134617816, pathname: " ��� ���▒���▒���", mode: IFREG|ISUID|IRUSR|IWGRP|0xf7fd0000) = 447296
>      0.150 ( 0.001 ms): a.out/447296 process_vm_writev(pid: -134617812, lvec: (struct iovec){.iov_base = (void *)0xf7f9e9c8f7f9e4c0,.iov_len = (__kernel_size_t)4160349376,}, liovcnt: 4160588048, rvec: (struct iovec){}, riovcnt: 4160585708, flags: 4291707352) = 0
>      0.197 ( 0.004 ms): a.out/447296 capget(header: 4160184320, dataptr: 8192)                             = 0
>      0.202 ( 0.002 ms): a.out/447296 capget(header: 1448669184, dataptr: 4096)                             = 0
>      0.208 ( 0.002 ms): a.out/447296 capget(header: 4160577536, dataptr: 8192)                             = 0
>      0.220 ( 0.001 ms): a.out/447296 getxattr(pathname: "", name: "c������", value: 0xf7f77e34, size: 1)  = 0
>      0.228 ( 0.005 ms): a.out/447296 fchmod(fd: -134729728, mode: IRUGO|IWUGO|IFREG|IFIFO|ISVTX|IXUSR|0x10000) = 0
>      0.240 ( 0.009 ms): a.out/447296 preadv(fd: 4294967196, vec: 0x5658e008, pos_h: 4160192052)            = 3
>      0.250 ( 0.008 ms): a.out/447296 close(fd: 3</proc/447296/status>)                                     = 1436
>      0.260 ( 0.018 ms): a.out/447296 stat(filename: "", statbuf: 0xffce32ac)                               = 1436
>      0.288 (1000.213 ms): a.out/447296 readlinkat(buf: 0xffce31d4, bufsiz: 4291703244)                       = 0
> ```
> 
> After:
> ```
>          ? (         ): a.out/442930  ... [continued]: execve())                                           = 0
>      0.023 ( 0.002 ms): a.out/442930 brk()                                                                 = 0x57760000
>      0.052 ( 0.003 ms): a.out/442930 access(filename: 0xf7f5af28, mode: R)                                 = -1 ENOENT (No such file or directory)
>      0.059 ( 0.009 ms): a.out/442930 openat(dfd: CWD, filename: "/etc/ld.so.cache", flags: RDONLY|CLOEXEC|LARGEFILE) = 3
>      0.078 ( 0.001 ms): a.out/442930 close(fd: 3</proc/442930/status>)                                     = 0
>      0.087 ( 0.007 ms): a.out/442930 openat(dfd: CWD, filename: "/lib/i386-linux-", flags: RDONLY|CLOEXEC|LARGEFILE) = 3
>      0.095 ( 0.002 ms): a.out/442930 read(fd: 3</proc/442930/status>, buf: 0xffbdbb70, count: 512)         = 512
>      0.135 ( 0.001 ms): a.out/442930 close(fd: 3</proc/442930/status>)                                     = 0
>      0.148 ( 0.001 ms): a.out/442930 set_tid_address(tidptr: 0xf7f2b528)                                   = 442930 (a.out)
>      0.150 ( 0.001 ms): a.out/442930 set_robust_list(head: 0xf7f2b52c, len: 12)                            =
>      0.196 ( 0.004 ms): a.out/442930 mprotect(start: 0xf7f03000, len: 8192, prot: READ)                    = 0
>      0.202 ( 0.002 ms): a.out/442930 mprotect(start: 0x5658e000, len: 4096, prot: READ)                    = 0
>      0.207 ( 0.002 ms): a.out/442930 mprotect(start: 0xf7f63000, len: 8192, prot: READ)                    = 0
>      0.230 ( 0.005 ms): a.out/442930 munmap(addr: 0xf7f10000, len: 103414)                                 = 0
>      0.244 ( 0.010 ms): a.out/442930 openat(dfd: CWD, filename: 0x5658d008)                                = 3
>      0.255 ( 0.007 ms): a.out/442930 read(fd: 3</proc/442930/status>, buf: 0xffbdb67c, count: 4096)        = 1436
>      0.264 ( 0.018 ms): a.out/442930 write(fd: 1</dev/pts/4>, buf: , count: 1436)                          = 1436
>      0.292 (1000.173 ms): a.out/442930 clock_nanosleep(rqtp: { .tv_sec: 17866546940376776704, .tv_nsec: 4159878336 }, rmtp: 0xffbdb59c) = 0
>   1000.478 (         ): a.out/442930 exit_group()                                                          = ?
> ```
> 

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>

> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/syscalltbl.c | 89 ++++++++++++++++++++++++++----------
>  1 file changed, 64 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 760ac4d0869f..db0d2b81aed1 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -15,16 +15,39 @@
>  #include <string.h>
>  #include "string2.h"
>  
> -#if __BITS_PER_LONG == 64
> -  #include <asm/syscalls_64.h>
> -#else
> -  #include <asm/syscalls_32.h>
> -#endif
> +#include "trace/beauty/generated/syscalltbl.c"
>  
> -const char *syscalltbl__name(int e_machine __maybe_unused, int id)
> +static const struct syscalltbl *find_table(int e_machine)
>  {
> -	if (id >= 0 && id <= (int)ARRAY_SIZE(syscall_num_to_name))
> -		return syscall_num_to_name[id];
> +	static const struct syscalltbl *last_table;
> +	static int last_table_machine = EM_NONE;
> +
> +	/* Tables only exist for EM_SPARC. */
> +	if (e_machine == EM_SPARCV9)
> +		e_machine = EM_SPARC;
> +
> +	if (last_table_machine == e_machine && last_table != NULL)
> +		return last_table;
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(syscalltbls); i++) {
> +		const struct syscalltbl *entry = &syscalltbls[i];
> +
> +		if (entry->e_machine != e_machine && entry->e_machine != EM_NONE)
> +			continue;
> +
> +		last_table = entry;
> +		last_table_machine = e_machine;
> +		return entry;
> +	}
> +	return NULL;
> +}
> +
> +const char *syscalltbl__name(int e_machine, int id)
> +{
> +	const struct syscalltbl *table = find_table(e_machine);
> +
> +	if (table && id >= 0 && id < table->num_to_name_len)
> +		return table->num_to_name[id];
>  	return NULL;
>  }
>  
> @@ -41,38 +64,54 @@ static int syscallcmpname(const void *vkey, const void *ventry)
>  	return strcmp(key->name, key->tbl[*entry]);
>  }
>  
> -int syscalltbl__id(int e_machine __maybe_unused, const char *name)
> +int syscalltbl__id(int e_machine, const char *name)
>  {
> -	struct syscall_cmp_key key = {
> -		.name = name,
> -		.tbl = syscall_num_to_name,
> -	};
> -	const int *id = bsearch(&key, syscall_sorted_names,
> -				ARRAY_SIZE(syscall_sorted_names),
> -				sizeof(syscall_sorted_names[0]),
> -				syscallcmpname);
> +	const struct syscalltbl *table = find_table(e_machine);
> +	struct syscall_cmp_key key;
> +	const int *id;
> +
> +	if (!table)
> +		return -1;
> +
> +	key.name = name;
> +	key.tbl = table->num_to_name;
> +	id = bsearch(&key, table->sorted_names, table->sorted_names_len,
> +		     sizeof(table->sorted_names[0]), syscallcmpname);
>  
>  	return id ? *id : -1;
>  }
>  
> -int syscalltbl__num_idx(int e_machine __maybe_unused)
> +int syscalltbl__num_idx(int e_machine)
>  {
> -	return ARRAY_SIZE(syscall_sorted_names);
> +	const struct syscalltbl *table = find_table(e_machine);
> +
> +	if (!table)
> +		return 0;
> +
> +	return table->sorted_names_len;
>  }
>  
> -int syscalltbl__id_at_idx(int e_machine __maybe_unused, int idx)
> +int syscalltbl__id_at_idx(int e_machine, int idx)
>  {
> -	return syscall_sorted_names[idx];
> +	const struct syscalltbl *table = find_table(e_machine);
> +
> +	if (!table)
> +		return -1;
> +
> +	assert(idx >= 0 && idx < table->sorted_names_len);
> +	return table->sorted_names[idx];
>  }
>  
> -int syscalltbl__strglobmatch_next(int e_machine __maybe_unused, const char *syscall_glob, int *idx)
> +int syscalltbl__strglobmatch_next(int e_machine, const char *syscall_glob, int *idx)
>  {
> -	for (int i = *idx + 1; i < (int)ARRAY_SIZE(syscall_sorted_names); ++i) {
> -		const char *name = syscall_num_to_name[syscall_sorted_names[i]];
> +	const struct syscalltbl *table = find_table(e_machine);
> +
> +	for (int i = *idx + 1; table && i < table->sorted_names_len; ++i) {
> +		const char *name = table->num_to_name[table->sorted_names[i]];
>  
>  		if (strglobmatch(name, syscall_glob)) {
>  			*idx = i;
> -			return syscall_sorted_names[i];
> +			return table->sorted_names[i];
>  		}
>  	}
>  
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
> 

