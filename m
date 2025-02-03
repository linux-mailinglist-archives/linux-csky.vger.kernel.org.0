Return-Path: <linux-csky+bounces-1718-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD11A26374
	for <lists+linux-csky@lfdr.de>; Mon,  3 Feb 2025 20:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 938241886076
	for <lists+linux-csky@lfdr.de>; Mon,  3 Feb 2025 19:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112B620F078;
	Mon,  3 Feb 2025 19:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OotxtKWW"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2101520F070
	for <linux-csky@vger.kernel.org>; Mon,  3 Feb 2025 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738610120; cv=none; b=b2Jzns9tYNTjgaDRc6nc/sPerbEyGwTSwwpDh+fQfTbl30Y3ugBoET94XwLZ7SktZDhHceYKhMcPsTZtryI0DmqlwWzYJRunlLJNLbZliM+9eihshRAmpGIa84GxyjHJ5FzMRI3/Iza4XJYlQKyWDvlxunLNmriSEOmD4Fxqx1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738610120; c=relaxed/simple;
	bh=1eukzfk/qoeEs/MvVf2UR7p9fD5fIxj3KFpYr6+vSWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fVV3Xa2FKthzYc0BuqEzUimjO3tIN636Lg2WlsDHSz3I9+sRYPSbow4rbRGqpj9VLsctIlTXJWDTiAAHuZgxGit1LlB27kVi6I5S7x22xuWrcRA+Ts/UJo9sPCrTdJd5HBy4WBbr6jvEnqXHDKDBRn2LgJfW9zw8xX6shIM1KxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OotxtKWW; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2166022c5caso74683985ad.2
        for <linux-csky@vger.kernel.org>; Mon, 03 Feb 2025 11:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1738610117; x=1739214917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=s5WYJSVQEj2dIPfcyxFbM6JaAz2cg3KwbW58tJF8Jpk=;
        b=OotxtKWWyfXpsOnkR2lH/PCbxSBZ9/yZuG6Yq/7g1SWjYRYt3hDBFWm36opgkvkLAo
         CFMdk0Vrs5fLsJkl2tiTzvyQwJRDbxqSAGnGetToesLldZ2hHGShdXVzPHnWi3PRXQaj
         y8WdG6caohoCU0+/UMWNEpP3+hAYkzp68gf8HlkiPLQeE3R2XNMU9OGp1/M+Ms/zLFu/
         h5kko5GGeB/M55OHcWvQ+/yWKTKlMyL1aqbNG5qfZK34tzWd3lu80e7yp5aJJQvqQmo3
         9vi88fKogha0VOYmIEU25WvBQmRqz1s05S/B9OiyMf3y4sWiopZxyjk6f5JcdEZYqnw+
         RFng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738610117; x=1739214917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5WYJSVQEj2dIPfcyxFbM6JaAz2cg3KwbW58tJF8Jpk=;
        b=GFNEezbv1qTsESKYYabw2mmUbgITmlzSVVx9rTy/Th0c7CrpNYCoSEyzxMzoV+D5an
         Dgk852CEQ0SYDdEPgLQ7dY80gabByUbDx5gYF9lPwmY/I47kgAp8+LJGtORtp5ZltXuc
         I47Su2Unrj/iM9YD/xyMEb+9jIpD8eoajbLD6oqP4GDsf1ymwUuGYXU10DpxFye2+LMc
         qZkrsmzidG5ImOura8jETkf873KCS3S/BQYC+lcTz1KDqYuO7g0D8kSpYIk58fUDMAoL
         ZQTB58PwE1rm2b16hNrP2qLGmiTxN16Q8GRWINJ/ixrt/vJ+Xzt7ao5oTKUFgoxifGhP
         l2Mw==
X-Forwarded-Encrypted: i=1; AJvYcCVEVTY5Qgo5Q47bur5Etzi6/1APrZGGwbPSGqlmk6qidvL9JUzNXw17KkzWjJ5NT4WNWJ9Wq6ISKRH3@vger.kernel.org
X-Gm-Message-State: AOJu0YyznEIARY8+DfCx01kLGZlapGnV7k4NGPTOvxGc9dt+Syy1Q610
	SSiuaLVJTDhUN9FoLpZFKx/Ihs+pVH559ubX9uNsvuQBCEG4fLW3d4LSU+LGOhM=
X-Gm-Gg: ASbGncuM58U1EcvNeL9Uc7S/SjF2ob9ZFXsyjjsLic3dHfEY52qKt3HhA2MvKH6GGJc
	9O4DrlXh8J4aFchlrYJJhdtruqZ37b0bZP1LnxwcGywL1BMmN1fc5uqFUELu7vd2APjfNqx+U8s
	69mhQXxvT+fu4+r52XSjG+QGUzS+MrEW8LaV1uEvkI144i93PWa8f3iXAiqee2bRmloLVijp15c
	65A07fkSYAH42y5UCezEYxoWTutMwSniywKA6An9+kU5+aeEG6o++H75lp2SKAmvVdv4AWWR75g
	En0VhyIxsF4=
X-Google-Smtp-Source: AGHT+IGa8q1L/w2WsP8N8nsLp1KLayBcPH09Ym4t3KD9fyuAGMJmjHdlYaNkbdFwKMu+prfIEcxVEw==
X-Received: by 2002:a17:902:db04:b0:216:4c88:d93a with SMTP id d9443c01a7336-21dd7dd7356mr392103185ad.48.1738610117017;
        Mon, 03 Feb 2025 11:15:17 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:4f63:f9d5:2cbd:2947])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de331f8c9sm80863205ad.227.2025.02.03.11.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 11:15:16 -0800 (PST)
Date: Mon, 3 Feb 2025 11:15:13 -0800
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
Subject: Re: [PATCH v1 0/7] perf: Support multiple system call tables in the
 build
Message-ID: <Z6EVwaOVYaKtaK1j@ghost>
References: <20250201071455.718247-1-irogers@google.com>
 <Z6EStkn-YZ8zaO7u@ghost>
 <CAP-5=fXRz_8CKNz4Fr-=0yhKbf_QE2ND+PPykSAO5p8wcUz7xA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fXRz_8CKNz4Fr-=0yhKbf_QE2ND+PPykSAO5p8wcUz7xA@mail.gmail.com>

On Mon, Feb 03, 2025 at 11:10:49AM -0800, Ian Rogers wrote:
> On Mon, Feb 3, 2025 at 11:02 AM Charlie Jenkins <charlie@rivosinc.com> wrote:
> >
> > On Fri, Jan 31, 2025 at 11:14:48PM -0800, Ian Rogers wrote:
> > > This work builds on the clean up of system call tables and removal of
> > > libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> > >
> > > The system call table in perf trace is used to map system call numbers
> > > to names and vice versa. Prior to these changes, a single table
> > > matching the perf binary's build was present. The table would be
> > > incorrect if tracing say a 32-bit binary from a 64-bit version of
> > > perf, the names and numbers wouldn't match.
> > >
> > > Change the build so that a single system call file is built and the
> > > potentially multiple tables are identifiable from the ELF machine type
> > > of the process being examined. To determine the ELF machine type, the
> > > executable's header is read from /proc/pid/exe with fallbacks to using
> > > the perf's binary type when unknown.
> > >
> > > Remove some runtime types used by the system call tables and make
> > > equivalents generated at build time.
> >
> > Our approaches are very different but I sent out a patch to do this a
> > couple of weeks ago [1].
> >
> > Did you look at that and decide you didn't like the approach?
> 
> Missing link?

Whoops here is the link:

https://lore.kernel.org/all/20250114-perf_syscall_arch_runtime-v1-1-5b304e408e11@rivosinc.com/

> 
> The patches generating a syscall(_32|_64)?.h landed. These changes
> take your changes and make it so that we just run the script once
> building a header file for all architectures. On x86 we then have the
> tables be guarded by ifdefs on i386 and x86-64. Then rather than the
> table just matching the host architecture the ELF machine is used for
> the executable running.
> 
> Thanks,
> Ian
> 
> > - Charlie
> >
> > >
> > > Ian Rogers (7):
> > >   perf syscalltble: Remove syscall_table.h
> > >   perf trace: Reorganize syscalls
> > >   perf syscalltbl: Remove struct syscalltbl
> > >   perf thread: Add support for reading the e_machine type for a thread
> > >   perf trace beauty: Add syscalltbl.sh generating all system call tables
> > >   perf syscalltbl: Use lookup table containing multiple architectures
> > >   perf build: Remove Makefile.syscalls
> > >
> > >  tools/perf/Makefile.perf                      |  10 +-
> > >  tools/perf/arch/alpha/entry/syscalls/Kbuild   |   2 -
> > >  .../alpha/entry/syscalls/Makefile.syscalls    |   5 -
> > >  tools/perf/arch/alpha/include/syscall_table.h |   2 -
> > >  tools/perf/arch/arc/entry/syscalls/Kbuild     |   2 -
> > >  .../arch/arc/entry/syscalls/Makefile.syscalls |   3 -
> > >  tools/perf/arch/arc/include/syscall_table.h   |   2 -
> > >  tools/perf/arch/arm/entry/syscalls/Kbuild     |   4 -
> > >  .../arch/arm/entry/syscalls/Makefile.syscalls |   2 -
> > >  tools/perf/arch/arm/include/syscall_table.h   |   2 -
> > >  tools/perf/arch/arm64/entry/syscalls/Kbuild   |   3 -
> > >  .../arm64/entry/syscalls/Makefile.syscalls    |   6 -
> > >  tools/perf/arch/arm64/include/syscall_table.h |   8 -
> > >  tools/perf/arch/csky/entry/syscalls/Kbuild    |   2 -
> > >  .../csky/entry/syscalls/Makefile.syscalls     |   3 -
> > >  tools/perf/arch/csky/include/syscall_table.h  |   2 -
> > >  .../perf/arch/loongarch/entry/syscalls/Kbuild |   2 -
> > >  .../entry/syscalls/Makefile.syscalls          |   3 -
> > >  .../arch/loongarch/include/syscall_table.h    |   2 -
> > >  tools/perf/arch/mips/entry/syscalls/Kbuild    |   2 -
> > >  .../mips/entry/syscalls/Makefile.syscalls     |   5 -
> > >  tools/perf/arch/mips/include/syscall_table.h  |   2 -
> > >  tools/perf/arch/parisc/entry/syscalls/Kbuild  |   3 -
> > >  .../parisc/entry/syscalls/Makefile.syscalls   |   6 -
> > >  .../perf/arch/parisc/include/syscall_table.h  |   8 -
> > >  tools/perf/arch/powerpc/entry/syscalls/Kbuild |   3 -
> > >  .../powerpc/entry/syscalls/Makefile.syscalls  |   6 -
> > >  .../perf/arch/powerpc/include/syscall_table.h |   8 -
> > >  tools/perf/arch/riscv/entry/syscalls/Kbuild   |   2 -
> > >  .../riscv/entry/syscalls/Makefile.syscalls    |   4 -
> > >  tools/perf/arch/riscv/include/syscall_table.h |   8 -
> > >  tools/perf/arch/s390/entry/syscalls/Kbuild    |   2 -
> > >  .../s390/entry/syscalls/Makefile.syscalls     |   5 -
> > >  tools/perf/arch/s390/include/syscall_table.h  |   2 -
> > >  tools/perf/arch/sh/entry/syscalls/Kbuild      |   2 -
> > >  .../arch/sh/entry/syscalls/Makefile.syscalls  |   4 -
> > >  tools/perf/arch/sh/include/syscall_table.h    |   2 -
> > >  tools/perf/arch/sparc/entry/syscalls/Kbuild   |   3 -
> > >  .../sparc/entry/syscalls/Makefile.syscalls    |   5 -
> > >  tools/perf/arch/sparc/include/syscall_table.h |   8 -
> > >  tools/perf/arch/x86/entry/syscalls/Kbuild     |   3 -
> > >  .../arch/x86/entry/syscalls/Makefile.syscalls |   6 -
> > >  tools/perf/arch/x86/include/syscall_table.h   |   8 -
> > >  tools/perf/arch/xtensa/entry/syscalls/Kbuild  |   2 -
> > >  .../xtensa/entry/syscalls/Makefile.syscalls   |   4 -
> > >  .../perf/arch/xtensa/include/syscall_table.h  |   2 -
> > >  tools/perf/builtin-trace.c                    | 275 +++++++++++-------
> > >  tools/perf/scripts/Makefile.syscalls          |  61 ----
> > >  tools/perf/scripts/syscalltbl.sh              |  86 ------
> > >  tools/perf/trace/beauty/syscalltbl.sh         | 274 +++++++++++++++++
> > >  tools/perf/util/syscalltbl.c                  | 142 ++++-----
> > >  tools/perf/util/syscalltbl.h                  |  22 +-
> > >  tools/perf/util/thread.c                      |  50 ++++
> > >  tools/perf/util/thread.h                      |  14 +-
> > >  54 files changed, 598 insertions(+), 506 deletions(-)
> > >  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/alpha/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/alpha/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/arm/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/arm64/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/csky/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/loongarch/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/mips/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/parisc/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/parisc/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/powerpc/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/riscv/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/s390/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/s390/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/sh/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/sparc/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/sparc/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/x86/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
> > >  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Kbuild
> > >  delete mode 100644 tools/perf/arch/xtensa/entry/syscalls/Makefile.syscalls
> > >  delete mode 100644 tools/perf/arch/xtensa/include/syscall_table.h
> > >  delete mode 100644 tools/perf/scripts/Makefile.syscalls
> > >  delete mode 100755 tools/perf/scripts/syscalltbl.sh
> > >  create mode 100755 tools/perf/trace/beauty/syscalltbl.sh
> > >
> > > --
> > > 2.48.1.362.g079036d154-goog
> > >

