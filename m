Return-Path: <linux-csky+bounces-1663-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 868C8A11124
	for <lists+linux-csky@lfdr.de>; Tue, 14 Jan 2025 20:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB253A17A2
	for <lists+linux-csky@lfdr.de>; Tue, 14 Jan 2025 19:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC812066DC;
	Tue, 14 Jan 2025 19:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wWgz3XtF"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754C1FBC8A
	for <linux-csky@vger.kernel.org>; Tue, 14 Jan 2025 19:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736882860; cv=none; b=CUzyvpB5AeDnnUSvx0qx3fhLQ52keqizOSEpi532wMEiemLEjDpCDHhHzmbLFH0RbComaCVWDpdy9M5tYeHqs33NeGBENjHc/9lz3e28GC6HeLM7OIN7BuR+DCWPAZ2nYFREngL4/3k0qeD7yOlsh8GmH6vjK6bGeAixnEBMknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736882860; c=relaxed/simple;
	bh=Uxw0taxwqk1Pq7X+X5K0+wSP4PXacCH+ZF9RVEkvz0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVkEwMkLqgFc2lHXaj3qDMPCbLMHT0tgwceYtZl8gNzqc4p6r8tpgpiNhfilt1eNCFGryxfXiW0Z8u9ess7Vmih1Ij9p6uedF8T6M69+/lvq/07Xfq8LM3jwi0ntyqd0yCgHNZygC8jUQpdsvi086k0R25LxZPvmyUf1F0khwL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wWgz3XtF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21675fd60feso130682575ad.2
        for <linux-csky@vger.kernel.org>; Tue, 14 Jan 2025 11:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736882857; x=1737487657; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ES4PfYVi7ZyhgRUm9GYH+FMCnEy4+AUcUAHWe5oV5jA=;
        b=wWgz3XtFKEYGCy0b4YoNhIb1fCXl/Z7F2KkJZlBmh3dRCLA2PvI48C7oqgDaE+pEqg
         FYyNAMsX0JfGGLTRLOehfKbYCTIGCjOIo7f6scTY6Yw8NsR1GCRa0DguFtaZFhWcghR2
         x32iou7RzmiOp+lK3y6aveqa+rCM+X9+qwD8V4vbDYpNqAKbgvGDXo6MVVcgbeWMl/vf
         XPBI2cp7SpulNsG2uN+olI53aRT7Dejq3hBkE2fkAJIcVUkyH0NkIFA2vhtVJeh7gvBO
         nfHqYLSQV/iI4BwxjcZSNdGZwiBjQr/hzcITXsBTKsVF8RNU2JjifmvjoRYAzWmG5Hpd
         54hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736882857; x=1737487657;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ES4PfYVi7ZyhgRUm9GYH+FMCnEy4+AUcUAHWe5oV5jA=;
        b=d9XHZtAybP6IktLyc8d/Wj4upCaX7iImobq+1TIKAvRoRzi1erI6CWj6iAuwCus+u1
         3ro6CoPa1zzCa4iKUp5gZ6axZ0Jas4QZXZBKFiS+myVGONPY0QVaKpgZkSc74tXNJ7Ys
         /L1550xRNRfmhb26T9MlQPqpRgmAeFX/UGj7dgQv0w7923MBvh1ZPxQIMPM1FPT/Na9n
         tvJq+hjxlo7dBSqOqqSkKIxchOVwLpdkCKjuKMdPMhYVwh3JouBdN1OODL41lMRhibmj
         baU/j+V9occJqaRvXvm8aPY8pI97ALeg5bfe7Z9RZ/dH/TUBTlJKe+sjk2V2isTeRWv1
         XkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwsR1n7ekD/U93Lvo0zjw+adB3Y+f9eohtSJWDLuYYrmgGxM2/VDfLwlmxES8Btw+i/36kDfaHzHL7@vger.kernel.org
X-Gm-Message-State: AOJu0Yybd83SV9TS91oAPttBWJu7SPqsJzmyL+g2nqbTreefF12D1S7Q
	VCxZegHbakTNd0msVXGyZGEH9MbKj9vvkMDTN3L29cdK4YOB8zVWWIAl8WdhdKE=
X-Gm-Gg: ASbGnctkAs4sCAcK34KWLoCDxDevsA0rwQ10kX3oTMMuZG1QgQNR+tyfSPaiy0IFMzB
	Xua0cKTuG0DpvgczsvgU7IGE9G2BA4N4gcGSaWfEHScdmuNp9zh8ReWxzkrvXUafk9DaAL5tBET
	QXGxha4GeABqqxJg5+0piS8KrwVGw84szy0FSe2ZIAUkztLx5JWdLYtyhRwlsVD+fyHrAqCv/rM
	dsL4m6N9z8G2j2qAgyUWgp0BX9qTOsSmM02V3sbrXAZ9PRKKNA8
X-Google-Smtp-Source: AGHT+IHNba0GEbibje0t5wLZKfmTow6LQxoYMbmUndt+PVUCx5IeqgXnaaRg1lp0Qu+9TDj1PY7X3A==
X-Received: by 2002:a17:902:d4cd:b0:216:3c2b:a5e5 with SMTP id d9443c01a7336-21a83f71115mr361190955ad.27.1736882856927;
        Tue, 14 Jan 2025 11:27:36 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:c3be:2c11:1223:572a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f10e006sm70578375ad.1.2025.01.14.11.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 11:27:34 -0800 (PST)
Date: Tue, 14 Jan 2025 11:27:30 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
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
Subject: Re: [PATCH v6 00/16] perf tools: Use generic syscall scripts for all
 archs
Message-ID: <Z4a6oivg7f74N12Q@ghost>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
 <Z3_ybwWW3QZvJ4V6@x1>
 <Z4AoFA974kauIJ9T@ghost>
 <Z4A2Y269Ffo0ERkS@x1>
 <Z4BEygdXmofWBr0-@x1>
 <Z4BVK3D7sN-XYg2o@ghost>
 <Z4F1dXQLPGZ3JFI5@ghost>
 <Z4UpRqywqYPZSUM_@x1>
 <Z4alwvqYithaVLSL@x1>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4alwvqYithaVLSL@x1>

On Tue, Jan 14, 2025 at 02:58:26PM -0300, Arnaldo Carvalho de Melo wrote:
> On Mon, Jan 13, 2025 at 11:55:05AM -0300, Arnaldo Carvalho de Melo wrote:
> > On Fri, Jan 10, 2025 at 11:31:01AM -0800, Charlie Jenkins wrote:
> > > On Thu, Jan 09, 2025 at 03:00:59PM -0800, Charlie Jenkins wrote:
> > > > Ooh okay I see, the quiet commands were being ignored as-is. We could
> > > > add the lines to handle this to Makefile.syscalls, but I think the
> > > > better solution is to move the lines from Makefile.build to
> > > > Makefile.perf to be more generically available. Here is a patch for
> > > > that. I also added the comment from the kernel Makefile describing what
> > > > this does.
> > 
> > > > From 8dcec7f5d937ede3d33c687573dc2f1654ddc59e Mon Sep 17 00:00:00 2001
> > > > From: Charlie Jenkins <charlie@rivosinc.com>
> > > > Date: Thu, 9 Jan 2025 14:36:40 -0800
> > > > Subject: [PATCH] perf tools: Expose quiet/verbose variables in Makefile.perf
> > > > 
> > > > The variables to make builds silent/verbose live inside
> > > > tools/build/Makefile.build. Move those variables to the top-level
> > > > Makefile.perf to be generally available.
> > 
> > <SNIP applied patch>
> >  
> > > Let me know how you want to handle this, I can send this out as a
> > > separate patch if that's better.
> > 
> > I used the patch you provided above after hand editing the message
> > before feeding it to 'git am', added these comments:
> 
> Somehow this is causing some trouble:
> 
> ⬢ [acme@toolbox perf-tools-next]$ make -C tools/perf build-test
> make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> - tarpkg: ./tests/perf-targz-src-pkg .
> /bin/sh: line 1: @make: command not found
> make[4]: *** [Makefile:27: clean-asm_pure_loop] Error 127
> make[3]: *** [Makefile.perf:764: tests-coresight-targets-clean] Error 2
> make[2]: *** [Makefile:96: clean] Error 2
> make[1]: *** [tests/make:330: make_static] Error 2
> make: *** [Makefile:109: build-test] Error 2
> make: Leaving directory '/home/acme/git/perf-tools-next/tools/perf'
> ⬢ [acme@toolbox perf-tools-next]$
> 
> Can you please try fixing it as I'm busy now (I'll be on vacation from
> tomorrow till early February)? This is what I extracted:

There was an erroneous $(Q) in
tools/perf/tests/shell/coresight/Makefile. Previously it would expand to
the empty string so wouldn't cause any problems, but now it's in the
middle of an expression so hence the error. I'll send an updated patch.

> 
> commit c199fd785d18121ffd0ba5758e23a42ba2984e11
> Author: Charlie Jenkins <charlie@rivosinc.com>
> Date:   Mon Jan 13 11:50:55 2025 -0300
> 
>     perf tools: Expose quiet/verbose variables in Makefile.perf
>     
>     The variables to make builds silent/verbose live inside
>     tools/build/Makefile.build. Move those variables to the top-level
>     Makefile.perf to be generally available.
>     
>     Committer testing:
>     
>     See the SYSCALL lines, now they are consistent with the other
>     operations in other lines:
>     
>       SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_32.h
>       SYSTBL  /tmp/build/perf-tools-next/arch/x86/include/generated/asm/syscalls_64.h
>       GEN     /tmp/build/perf-tools-next/common-cmds.h
>       GEN     /tmp/build/perf-tools-next/arch/arm64/include/generated/asm/sysreg-defs.h
>       PERF_VERSION = 6.13.rc2.g3d94bb6ed1d0
>       GEN     perf-archive
>       MKDIR   /tmp/build/perf-tools-next/jvmti/
>       MKDIR   /tmp/build/perf-tools-next/jvmti/
>       MKDIR   /tmp/build/perf-tools-next/jvmti/
>       MKDIR   /tmp/build/perf-tools-next/jvmti/
>       GEN     perf-iostat
>       CC      /tmp/build/perf-tools-next/jvmti/libjvmti.o
>       CC      /tmp/build/perf-tools-next/jvmti/jvmti_agent.o
>     
>     Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>     Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
>     Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
>     Cc: Adrian Hunter <adrian.hunter@intel.com>
>     Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
>     Cc: Arnd Bergmann <arnd@arndb.de>
>     Cc: Christian Brauner <brauner@kernel.org>
>     Cc: Guo Ren <guoren@kernel.org>
>     Cc: Günther Noack <gnoack@google.com>
>     Cc: Ian Rogers <irogers@google.com>
>     Cc: Ingo Molnar <mingo@redhat.com>
>     Cc: James Clark <james.clark@linaro.org>
>     Cc: Jiri Olsa <jolsa@kernel.org>
>     Cc: John Garry <john.g.garry@oracle.com>
>     Cc: Jonathan Corbet <corbet@lwn.net>
>     Cc: Leo Yan <leo.yan@linux.dev>
>     Cc: Mark Rutland <mark.rutland@arm.com>
>     Cc: Mickaël Salaün <mic@digikod.net>
>     Cc: Mike Leach <mike.leach@linaro.org>
>     Cc: Namhyung Kim <namhyung@kernel.org>
>     Cc: Palmer Dabbelt <palmer@dabbelt.com>
>     Cc: Paul Walmsley <paul.walmsley@sifive.com>
>     Cc: Peter Zijlstra <peterz@infradead.org>
>     Cc: Will Deacon <will@kernel.org>
>     Link: http://lore.kernel.org/lkml/None
>     Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> diff --git a/tools/build/Makefile.build b/tools/build/Makefile.build
> index 5fb3fb3d97e0fd11..e710ed67a1b49d9f 100644
> --- a/tools/build/Makefile.build
> +++ b/tools/build/Makefile.build
> @@ -12,26 +12,6 @@
>  PHONY := __build
>  __build:
>  
> -ifeq ($(V),1)
> -  quiet =
> -  Q =
> -else
> -  quiet=quiet_
> -  Q=@
> -endif
> -
> -# If the user is running make -s (silent mode), suppress echoing of commands
> -# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> -ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> -short-opts := $(firstword -$(MAKEFLAGS))
> -else
> -short-opts := $(filter-out --%,$(MAKEFLAGS))
> -endif
> -
> -ifneq ($(findstring s,$(short-opts)),)
> -  quiet=silent_
> -endif
> -
>  build-dir := $(srctree)/tools/build
>  
>  # Define $(fixdep) for dep-cmd function
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index a449d00155364422..55d6ce9ea52fb2a5 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -161,12 +161,47 @@ export VPATH
>  SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
>  endif
>  
> +# Beautify output
> +# ---------------------------------------------------------------------------
> +#
> +# Most of build commands in Kbuild start with "cmd_". You can optionally define
> +# "quiet_cmd_*". If defined, the short log is printed. Otherwise, no log from
> +# that command is printed by default.
> +#
> +# e.g.)
> +#    quiet_cmd_depmod = DEPMOD  $(MODLIB)
> +#          cmd_depmod = $(srctree)/scripts/depmod.sh $(DEPMOD) $(KERNELRELEASE)
> +#
> +# A simple variant is to prefix commands with $(Q) - that's useful
> +# for commands that shall be hidden in non-verbose mode.
> +#
> +#    $(Q)$(MAKE) $(build)=scripts/basic
> +#
> +# To put more focus on warnings, be less verbose as default
> +# Use 'make V=1' to see the full commands
> +
>  ifeq ($(V),1)
> +  quiet =
>    Q =
>  else
> -  Q = @
> +  quiet=quiet_
> +  Q=@
>  endif
>  
> +# If the user is running make -s (silent mode), suppress echoing of commands
> +# make-4.0 (and later) keep single letter options in the 1st word of MAKEFLAGS.
> +ifeq ($(filter 3.%,$(MAKE_VERSION)),)
> +short-opts := $(firstword -$(MAKEFLAGS))
> +else
> +short-opts := $(filter-out --%,$(MAKEFLAGS))
> +endif
> +
> +ifneq ($(findstring s,$(short-opts)),)
> +  quiet=silent_
> +endif
> +
> +export quiet Q
> +
>  # Do not use make's built-in rules
>  # (this improves performance and avoids hard-to-debug behaviour);
>  MAKEFLAGS += -r

