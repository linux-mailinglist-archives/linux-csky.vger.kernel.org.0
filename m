Return-Path: <linux-csky+bounces-1565-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1D9A06AFB
	for <lists+linux-csky@lfdr.de>; Thu,  9 Jan 2025 03:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E0C1614AE
	for <lists+linux-csky@lfdr.de>; Thu,  9 Jan 2025 02:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F8F126C16;
	Thu,  9 Jan 2025 02:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Gv5Peo3u"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515093B192
	for <linux-csky@vger.kernel.org>; Thu,  9 Jan 2025 02:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736389768; cv=none; b=jb0UFJYZBpCkUkHjAa6u6lQfJF+89Xpd6D7OoXqnRoKW2gvdRvzlmyqRU1wvj2j8xmdLznYJEGKeCIz4LX8e7Glqe8HjNI11A+1/bQHjg1AF/OqR/1DksJk+n7oIroA6FNjt1gPppNXvK8THIEPqXro1H1jzSOezM1Vu0dvz6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736389768; c=relaxed/simple;
	bh=8+qyBcO8apxheZk8Ce9xa2+qlvFR3OyMr82XXfWcAZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eBltvH3O/oyGvOpzzh6PbFML70ybdAcfeOyhjW25pCjFkRfytWyNYVaLFv8a7tfEQc96kllwK6cL/YuO/I3PPZRwL8yaICD0mxiUqYDUM1YFXAINDQcYIQg5IR+D0hsDeJKPzLgOPxzZV3I00DcwMRi8GG/O4SbOy4Dh7zuIE4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Gv5Peo3u; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2166022c5caso5566885ad.2
        for <linux-csky@vger.kernel.org>; Wed, 08 Jan 2025 18:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736389764; x=1736994564; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tuHlyCZ2v8Z/UOiT+zevmWuAaJTETQXAMxBjxTo/5Xo=;
        b=Gv5Peo3u4Ohdbw8NnuFYZI6AbOfW2iNkNmeQAM4mPxbLHQahsR1TlyUtAY4lMfU/zE
         6fGu9bMim87xmRHXepDITyJg5/iYC+enlXS9hsrzTf8hEPylETnWOUGzy9UQa2E+RGiZ
         DvwBExJ6oWqV3CSE5xXEeS/g5stsqhSBPF7U5hDhjur88U5I1er04P8Hy1Wdr+CSvI4Y
         YveYF7WHciO6CoIODJwK07UQsByydBf4abz0yViY8MAHjRT1ydJAGRiNdJEvShHWvw7S
         TLDQoIiO6uv0YoG3MWkELUzONcmiTXlqFad6HMyOebHwqKnfxr9sBoyra0K1tFNsfa9L
         xk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736389764; x=1736994564;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tuHlyCZ2v8Z/UOiT+zevmWuAaJTETQXAMxBjxTo/5Xo=;
        b=AIVMTYsPpGq97YhJiRByM4YpyOxx8AeTBN+jb9zzJGUaq+DHAv6N85lCTeg98oajQD
         jB3Rkc2cF8OrbeBpRDJBEMFapGDUfxJOwtthNR9OompkJD38eg80gTtERkQ1ijcIei1K
         IgWi5oEEd/SR+2+21USRnORc4tYKUzFZOTXWpC6mIGvPHke77rYlhDKGnVbGhNlEgrfS
         xsUxYs0O+ZjMzlNkFRt9uVM08CI21NtS2sJLvRTetnJs+Fj+AM/czLjSoXQKt/oqsf+z
         ofDy+07F0x2pgNeGoDeg6f2a9LlMWo73+MIg4tav1RkGbVaF7vpKwmUoc/rxjQ7pyySE
         Fvpw==
X-Forwarded-Encrypted: i=1; AJvYcCVYkAUTi1aZfvOEMC8j3DQw+jbTRpsQSN7J9zZnAkPBe5iGGFJCo0PfuY93aOmPgoHSwHdciHMI2wxy@vger.kernel.org
X-Gm-Message-State: AOJu0YzMT1iwMQ/Vtwr/ZLzpVVfMfDHXPQtP9xQw1pujg6UivZYgm+4V
	W6zwKqNDyb4ruJ/1R14VPHShubCTK3/PM+UJGETeCF4AM5ij71M72oS0CTuFrjQ=
X-Gm-Gg: ASbGncvViV+DYcs9EUeIgIvg6+nuXZabYJgWWk0p+LPuLuDFNuZ1eh9io/9zRjxsP1N
	PLxRYCCZi46RGBKO5eFpyhQdZBAjWmPXaXEpfGNi2URhnNSG+haA+o1pdvCf5R5YlWGprbz9tl6
	zhEFzla4sDoElCn3/+F41rqtnS6YgagVYvTX6o/d0Odsj6hmgYAF95l/waq0vgU7MnA29zhqEB0
	JhUfN2iaWgSMC54DcHknz1CE61iEYZYVtVvOG6DPa6MVYI=
X-Google-Smtp-Source: AGHT+IEiW0hQMlynZLTeSqEG8t5Hx4KJYijsRSL5BopHzTcxKBDRtDH+iOQvqvSzplZg51yWB1kRWw==
X-Received: by 2002:a05:6a00:e8e:b0:72a:bc6a:3a87 with SMTP id d2e1a72fcca58-72d21df17bfmr7052394b3a.0.1736389764464;
        Wed, 08 Jan 2025 18:29:24 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a31d4d6b477sm161833a12.61.2025.01.08.18.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 18:29:23 -0800 (PST)
Date: Wed, 8 Jan 2025 18:29:20 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 00/16] perf tools: Use generic syscall scripts for all
 archs
Message-ID: <Z380gLRYAKVPVEet@ghost>
References: <20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com>
 <Z368mNynBTDWPM6R@google.com>
 <Z37-t9fhnmSghIPe@x1>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z37-t9fhnmSghIPe@x1>

On Wed, Jan 08, 2025 at 07:39:51PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Jan 08, 2025 at 09:57:44AM -0800, Namhyung Kim wrote:
> > Hello,
> > 
> > On Tue, Jan 07, 2025 at 06:07:48PM -0800, Charlie Jenkins wrote:
> > > Standardize the generation of syscall headers around syscall tables.
> > > Previously each architecture independently selected how syscall headers
> > > would be generated, or would not define a way and fallback onto
> > > libaudit. Convert all architectures to use a standard syscall header
> > > generation script and allow each architecture to override the syscall
> > > table to use if they do not use the generic table.
> > > 
> > > As a result of these changes, no architecture will require libaudit, and
> > > so the fallback case of using libaudit is removed by this series.
> > > 
> > > Testing:
> > > 
> > > I have tested that the syscall mappings of id to name generation works
> > > as expected for every architecture, but I have only validated that perf
> > > trace compiles and runs as expected on riscv, arm64, and x86_64.
> > > 
> > > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > > Reviewed-by: Ian Rogers <irogers@google.com>
> > > Tested-by: Ian Rogers <irogers@google.com>
> > 
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> 
> So, somehow the first patch of this series didn't reach my inbox, b4
> found it, and in it perf now does;
> 
> tools/perf/scripts/Makefile.syscalls
> 
>   include $(srctree)/scripts/Kbuild.include
> 
> I.e. it uses a file that is outside tools/ so normal devel in the kernel
> community may end up breaking tools/ living code, something we decided
> not to have.
> 
> I noticed this while doing a: "make -C tools/perf build-test", the first
> test creates a perf tarball and then tries to build it after
> uncompressing it somewhere out of the checked out kernel source tree:
> 
> ⬢ [acme@toolbox perf-tools-next]$ make help | grep perf
>   perf-tar-src-pkg    - Build the perf source tarball with no compression
>   perf-targz-src-pkg  - Build the perf source tarball with gzip compression
>   perf-tarbz2-src-pkg - Build the perf source tarball with bz2 compression
>   perf-tarxz-src-pkg  - Build the perf source tarball with xz compression
>   perf-tarzst-src-pkg - Build the perf source tarball with zst compression
> ⬢ [acme@toolbox perf-tools-next]$ make perf-tarxz-src-pkg
>   UPD     .tmp_HEAD
>   COPY    .tmp_perf/HEAD
>   GEN     .tmp_perf/PERF-VERSION-FILE
>   PERF_VERSION = 6.13.rc2.g48d3eefaa683
>   ARCHIVE perf-6.13.0-rc2.tar.xz
> ⬢ [acme@toolbox perf-tools-next]$ mv perf-6.13.0-rc2.tar.xz ~
> ⬢ [acme@toolbox perf-tools-next]$ cd ~
> ⬢ [acme@toolbox ~]$ tar xvf perf-6.13.0-rc2.tar.xz | tail -5
> perf-6.13.0-rc2/tools/scripts/Makefile.include
> perf-6.13.0-rc2/tools/scripts/syscall.tbl
> perf-6.13.0-rc2/tools/scripts/utilities.mak
> perf-6.13.0-rc2/HEAD
> perf-6.13.0-rc2/PERF-VERSION-FILE
> ⬢ [acme@toolbox ~]$ cd perf-6.13.0-rc2/
> ⬢ [acme@toolbox perf-6.13.0-rc2]$ make -C tools/perf
> make: Entering directory '/home/acme/perf-6.13.0-rc2/tools/perf'
>   BUILD:   Doing 'make -j28' parallel build
> Warning: Skipped check-headers due to missing ../../include
> 
> Auto-detecting system features:
> ...                                   libdw: [ on  ]
> ...                                   glibc: [ on  ]
> ...                                  libbfd: [ on  ]
> ...                          libbfd-buildid: [ on  ]
> ...                                  libelf: [ on  ]
> ...                                 libnuma: [ on  ]
> ...                  numa_num_possible_cpus: [ on  ]
> ...                                 libperl: [ on  ]
> ...                               libpython: [ on  ]
> ...                               libcrypto: [ on  ]
> ...                               libunwind: [ on  ]
> ...                             libcapstone: [ on  ]
> ...                               llvm-perf: [ on  ]
> ...                                    zlib: [ on  ]
> ...                                    lzma: [ on  ]
> ...                               get_cpuid: [ on  ]
> ...                                     bpf: [ on  ]
> ...                                  libaio: [ on  ]
> ...                                 libzstd: [ on  ]
> 
> /home/acme/perf-6.13.0-rc2/tools/perf/scripts/Makefile.syscalls:18: /home/acme/perf-6.13.0-rc2/scripts/Kbuild.include: No such file or directory
> make[2]: *** No rule to make target '/home/acme/perf-6.13.0-rc2/scripts/Kbuild.include'.  Stop.
> make[1]: *** [Makefile.perf:286: sub-make] Error 2
> make: *** [Makefile:76: all] Error 2
> make: Leaving directory '/home/acme/perf-6.13.0-rc2/tools/perf'
> ⬢ [acme@toolbox perf-6.13.0-rc2]$ 
> 
> This would probably (it does, just tested, but read on) make it work:
> 
> ⬢ [acme@toolbox perf-tools-next]$ git diff
> diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
> index dc42de1785cee715..83ef5d1365880929 100644
> --- a/tools/perf/MANIFEST
> +++ b/tools/perf/MANIFEST
> @@ -22,6 +22,7 @@ tools/lib/str_error_r.c
>  tools/lib/vsprintf.c
>  tools/lib/zalloc.c
>  scripts/bpf_doc.py
> +scripts/Kbuild.include
>  tools/bpf/bpftool
>  kernel/bpf/disasm.c
>  kernel/bpf/disasm.h
> ⬢ [acme@toolbox perf-tools-next]$
> 
> As now we would find it, but then it references some other part of the
> kernel's Kbuild system:
> 
> ⬢ [acme@toolbox perf-tools-next]$ grep -w srctree scripts/Kbuild.include
> build := -f $(srctree)/scripts/Makefile.build obj
> clean := -f $(srctree)/scripts/Makefile.clean obj
> ⬢ [acme@toolbox perf-tools-next]$
> 
> And perf has:
> 
> ⬢ [acme@toolbox perf-tools-next]$ find tools/ -name Makefile.build
> tools/build/Makefile.build
> ⬢ [acme@toolbox perf-tools-next]$
> 
> And we also have:
> 
> ⬢ [acme@toolbox perf-tools-next]$ ls -la tools/scripts/
> total 40
> drwxr-xr-x. 1 acme acme   106 Jan  8 19:13 .
> drwxr-xr-x. 1 acme acme   514 Jan  8 11:39 ..
> -rw-r--r--. 1 acme acme  1224 Jan  8 11:41 Makefile.arch
> -rw-r--r--. 1 acme acme  6205 Dec 20 21:48 Makefile.include
> -rw-r--r--. 1 acme acme 17401 Jan  8 19:13 syscall.tbl
> -rw-r--r--. 1 acme acme  6186 Dec 20 21:48 utilities.mak
> ⬢ [acme@toolbox perf-tools-next]$
> 
> And:
> 
> ⬢ [acme@toolbox perf-tools-next]$ grep -w build tools/build/Makefile.include 
> build := -f $(srctree)/tools/build/Makefile.build dir=. obj
> 	$(SILENT_MAKE) -C $(srctree)/tools/build CFLAGS= LDFLAGS= $(OUTPUT)fixdep
> 	$(Q)$(MAKE) -C $(srctree)/tools/build clean
> ⬢ [acme@toolbox perf-tools-next]$
> 
> That is also in:
> 
> ⬢ [acme@toolbox perf-tools-next]$ grep -w build scripts/Kbuild.include 
> # Shorthand for $(Q)$(MAKE) -f scripts/Makefile.build obj=
> # $(Q)$(MAKE) $(build)=dir
> build := -f $(srctree)/scripts/Makefile.build obj
> # the interrupted recipe. So, you can safely stop the build by Ctrl-C (Make
> # (1) PHONY targets are always build
> # (2) No target, so we better build it
> ⬢ [acme@toolbox perf-tools-next]$
> 
> So it seems we need to look at what we're using from the kernel's
> scripts/Makefile.build to have it in a tools/build/ file.
> 
> Its late here and I'll have to stop at this point, please take a look to
> see if this can be easily resolved so that we can merge your series, I
> very much like to say goodbye to one more tools/perf library dependency
> :-)

Thank you for pointing this out. We can use tools/build/Build.include
which seems to have everything that is required.  A "space" convenience
variable needs to be added, but that is all. I'll send an updated
version with that change.

- Charlie

> 
> Best regards,
> 
> - Arnaldo

