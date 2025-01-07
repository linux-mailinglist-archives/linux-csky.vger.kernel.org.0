Return-Path: <linux-csky+bounces-1519-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEACA04970
	for <lists+linux-csky@lfdr.de>; Tue,  7 Jan 2025 19:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F121918877F1
	for <lists+linux-csky@lfdr.de>; Tue,  7 Jan 2025 18:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7931F472C;
	Tue,  7 Jan 2025 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uQsODK6V"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C801F37BC
	for <linux-csky@vger.kernel.org>; Tue,  7 Jan 2025 18:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736275506; cv=none; b=JGGGhIB7R7xTenG1hkk7CFkvVMAGNRaSmgJ2Up9aQp6WtOFNQ4M2u+tE0xVZ/vy5BCqq59xftOaKWU4pmsDXNgb3VKecFUt2pZ5LMYAHWnYqG0660ysbem6BihAs2zGa9JfOfq6GuIJSZfGPDtiCmv39nf3p7pY9u/zXM48+Tco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736275506; c=relaxed/simple;
	bh=Ix8CwgupWnsJ2NHz+6bGRcZAT6fmMTgIODWckWOqE2I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c1eeVX3XLovX9gZp81XuN4ZSb7bkJcV1XW1FsCo/kRzMys9RXvfVjvcXj+bfMDN0a92ksdXVXzEnukik0AlyNvhwZASHKepb+njSNCH/nk0cvRd33WXhWW4KoPMyVlMUSZ09TMO0n0bfQfECE72WoTC5qgDFLX4hg8F+nhBdWVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uQsODK6V; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso7235ab.1
        for <linux-csky@vger.kernel.org>; Tue, 07 Jan 2025 10:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736275501; x=1736880301; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJJx+P1BM3o2AclN0fARVZxzF2vJee5sNA/yq96x/gk=;
        b=uQsODK6VCc6/KMLKhOCN21VX7Xt3DTjNxjce7xZVMkkFabDMhAbmKhqW+Yn6yIZkCF
         OHtM1RHjKRpl5VFNUNkeEiCBOePlhgsM3EXhd737svqH+rMaja3/h3SEyvR53pxOaq+M
         kd6N5HYFQatuK6C69+Cw2ATPqV5usdGs3YhoXf2ukyVL8zgfoXMuNdStFh+NaGNjqpLP
         IOhE27O6Fea84b9a0YOr4gINh4FlMnhCHDsXQm1yYImiJymurUCPyMAxfYtxtnSZj83z
         N/HxTg2K02JAlNw504U6HIoEThXEzSPU/psFpwfKPhmNXz/iJaIolSnFXteIfm0n/Anl
         O1hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736275501; x=1736880301;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJJx+P1BM3o2AclN0fARVZxzF2vJee5sNA/yq96x/gk=;
        b=LD6rclgNJ6aKI3pYVSMxy7FrIAEBmofRMTqivZWfqBughCT/rbF9x6bgxD7Qgb3Sx0
         3JC48WG9U+SD5Q2MBtQQdgM3wvoYMe4J+R0OaWoTK6clDjVKVaJgyn5apUEd/mecVu8u
         ngMPp0HzGSsR/z7z3obLONenLkzlZCFhY2bz9aD3vVGMT0S88nX4d1SXIyhQ/V4lFaUp
         R5s2LJhHZYK2fLc4ZQZiKJ72nbAF+Q1sgRQa1IVMXdrmrCFGibPWljQyYE6dVHuV99Mz
         dsRFf++M5cNq/UC0S0fmZpXrBZVPpgqs9oKi1Rg6c536c4gVQ6VQ0Cp6vAxjD9kys6jf
         cbbg==
X-Forwarded-Encrypted: i=1; AJvYcCVj8iPdynJf8CdGV2jSqzqblYhQAlmemn8CI20wxc+unbfZrTZ+hXhR0VO1DjuYxpomnKEpbiiwzhni@vger.kernel.org
X-Gm-Message-State: AOJu0YxGjB5x7NtPnet0yl5nXVc3QZmRn2XaE1qM65IExZe0XiU6XY5I
	Bbadh3OhURTrmKKI0Pfrn7tny9KZGFSMTCLjbKriNmA7imNrBVbMfCK4NK87v0M7lT/I3PgkeEc
	1mtizA0IvZJq9H4G7bYamDuIpCXdRMDKvsGBa
X-Gm-Gg: ASbGncuyhFmamPnvZNpAkZV7Cg5WigFRsM5uN/UjcS0KriucUU5SP4JgZPJpikpzP2L
	FDnMtg3loJqZs/sQ6Ild/nimrvdd6ytaFLNgm0VY1F8brUtUveztfgMjRbTWG8sKG2+MdUw==
X-Google-Smtp-Source: AGHT+IEseKvNZN6+1U5xaeEFYg5v0HSjPQ42KLZsijQ/hQCyvb+Yo8x6RDlu2GEmFg6ThF8oNhQEjR4YLtlu8w6G6hY=
X-Received: by 2002:a92:cd09:0:b0:3a7:dcc1:9936 with SMTP id
 e9e14a558f8ab-3ce333ac737mr3451575ab.23.1736275500747; Tue, 07 Jan 2025
 10:45:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218-perf_syscalltbl-v4-0-bc8caef2ca8e@rivosinc.com>
In-Reply-To: <20241218-perf_syscalltbl-v4-0-bc8caef2ca8e@rivosinc.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Jan 2025 10:44:49 -0800
X-Gm-Features: AbW1kvZ2ue7zebeJn1ASl6IcPrVI85kIxnXUJ0ZFdYfd60rswaW74SbtuHBtKwI
Message-ID: <CAP-5=fVoH3_naH_UzwBKy9ayCC=Ee5ck6=iJQ9bVPuVCame6Gg@mail.gmail.com>
Subject: Re: [PATCH v4 00/16] perf tools: Use generic syscall scripts for all archs
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Arnd Bergmann <arnd@arndb.de>, Albert Ou <aou@eecs.berkeley.edu>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 1:24=E2=80=AFAM Charlie Jenkins <charlie@rivosinc.c=
om> wrote:
>
> Standardize the generation of syscall headers around syscall tables.
> Previously each architecture independently selected how syscall headers
> would be generated, or would not define a way and fallback onto
> libaudit. Convert all architectures to use a standard syscall header
> generation script and allow each architecture to override the syscall
> table to use if they do not use the generic table.
>
> As a result of these changes, no architecture will require libaudit, and
> so the fallback case of using libaudit is removed by this series.
>
> Testing:
>
> I have tested that the syscall mappings of id to name generation works
> as expected for every architecture, but I have only validated that perf
> trace compiles and runs as expected on riscv, arm64, and x86_64.
>
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
>
> On x86-64:
> Tested-by: Ian Rogers <irogers@google.com>

I'd like to see this land. The patches apply cleanly on
perf-tools-next for me and except for a 1 liner on patch 16 everything
has my:
Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
> Changes in v4:
> - Remove audit_machine member of syscalltbl struct (Ian)
> - Rebase on perf-tools-next
> - Link to v3: https://lore.kernel.org/r/20241216-perf_syscalltbl-v3-0-239=
f032481d5@rivosinc.com
>
> Changes in v3:
> - Fix compiliation when OUTPUT is empty
> - Correct unused headers to be .h instead of .c  (Namhyung)
> - Make variable definition of supported archs (Namhyung)
> - Convert +=3D into :=3D for syscalls headers (Namhyung)
> - Link to v2: https://lore.kernel.org/r/20241212-perf_syscalltbl-v2-0-f8c=
a984ffe40@rivosinc.com
>
> Changes in v2:
> - Rebase onto 6.13-rc2
> - Fix output path so it generates to /tools/perf/arch properly
> - Link to v1: https://lore.kernel.org/r/20241104-perf_syscalltbl-v1-0-9ad=
ae5c761ef@rivosinc.com
>
> ---
> Charlie Jenkins (16):
>       perf tools: Create generic syscall table support
>       perf tools: arc: Support generic syscall headers
>       perf tools: csky: Support generic syscall headers
>       perf tools: arm: Support syscall headers
>       perf tools: sh: Support syscall headers
>       perf tools: sparc: Support syscall headers
>       perf tools: xtensa: Support syscall header
>       perf tools: x86: Use generic syscall scripts
>       perf tools: alpha: Support syscall header
>       perf tools: parisc: Support syscall header
>       perf tools: arm64: Use syscall table
>       perf tools: loongarch: Use syscall table
>       perf tools: mips: Use generic syscall scripts
>       perf tools: powerpc: Use generic syscall table scripts
>       perf tools: s390: Use generic syscall table scripts
>       perf tools: Remove dependency on libaudit
>
>  Documentation/admin-guide/workload-tracing.rst     |   2 +-
>  tools/build/feature/Makefile                       |   4 -
>  tools/build/feature/test-libaudit.c                |  11 -
>  tools/perf/Documentation/perf-check.txt            |   1 -
>  tools/perf/Makefile.config                         |  39 +-
>  tools/perf/Makefile.perf                           |  12 +-
>  tools/perf/arch/alpha/entry/syscalls/Kbuild        |   2 +
>  .../arch/alpha/entry/syscalls/Makefile.syscalls    |   5 +
>  tools/perf/arch/alpha/entry/syscalls/syscall.tbl   | 504 +++++++++++++++=
+++++
>  tools/perf/arch/alpha/include/syscall_table.h      |   2 +
>  tools/perf/arch/arc/entry/syscalls/Kbuild          |   2 +
>  .../perf/arch/arc/entry/syscalls/Makefile.syscalls |   3 +
>  tools/perf/arch/arc/include/syscall_table.h        |   2 +
>  tools/perf/arch/arm/entry/syscalls/Kbuild          |   4 +
>  .../perf/arch/arm/entry/syscalls/Makefile.syscalls |   2 +
>  tools/perf/arch/arm/entry/syscalls/syscall.tbl     | 483 +++++++++++++++=
++++
>  tools/perf/arch/arm/include/syscall_table.h        |   2 +
>  tools/perf/arch/arm64/Makefile                     |  22 -
>  tools/perf/arch/arm64/entry/syscalls/Kbuild        |   3 +
>  .../arch/arm64/entry/syscalls/Makefile.syscalls    |   6 +
>  tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  |  46 --
>  .../perf/arch/arm64/entry/syscalls/syscall_32.tbl  | 476 +++++++++++++++=
++++
>  .../perf/arch/arm64/entry/syscalls/syscall_64.tbl  |   1 +
>  tools/perf/arch/arm64/include/syscall_table.h      |   8 +
>  tools/perf/arch/csky/entry/syscalls/Kbuild         |   2 +
>  .../arch/csky/entry/syscalls/Makefile.syscalls     |   3 +
>  tools/perf/arch/csky/include/syscall_table.h       |   2 +
>  tools/perf/arch/loongarch/Makefile                 |  22 -
>  tools/perf/arch/loongarch/entry/syscalls/Kbuild    |   2 +
>  .../loongarch/entry/syscalls/Makefile.syscalls     |   3 +
>  .../arch/loongarch/entry/syscalls/mksyscalltbl     |  45 --
>  tools/perf/arch/loongarch/include/syscall_table.h  |   2 +
>  tools/perf/arch/mips/entry/syscalls/Kbuild         |   2 +
>  .../arch/mips/entry/syscalls/Makefile.syscalls     |   5 +
>  tools/perf/arch/mips/entry/syscalls/mksyscalltbl   |  32 --
>  tools/perf/arch/mips/include/syscall_table.h       |   2 +
>  tools/perf/arch/parisc/entry/syscalls/Kbuild       |   3 +
>  .../arch/parisc/entry/syscalls/Makefile.syscalls   |   6 +
>  tools/perf/arch/parisc/entry/syscalls/syscall.tbl  | 463 +++++++++++++++=
++++
>  tools/perf/arch/parisc/include/syscall_table.h     |   8 +
>  tools/perf/arch/powerpc/Makefile                   |  25 -
>  tools/perf/arch/powerpc/entry/syscalls/Kbuild      |   3 +
>  .../arch/powerpc/entry/syscalls/Makefile.syscalls  |   6 +
>  .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  39 --
>  tools/perf/arch/powerpc/include/syscall_table.h    |   8 +
>  tools/perf/arch/riscv/Makefile                     |  22 -
>  tools/perf/arch/riscv/entry/syscalls/Kbuild        |   2 +
>  .../arch/riscv/entry/syscalls/Makefile.syscalls    |   4 +
>  tools/perf/arch/riscv/entry/syscalls/mksyscalltbl  |  47 --
>  tools/perf/arch/riscv/include/syscall_table.h      |   8 +
>  tools/perf/arch/s390/Makefile                      |  21 -
>  tools/perf/arch/s390/entry/syscalls/Kbuild         |   2 +
>  .../arch/s390/entry/syscalls/Makefile.syscalls     |   5 +
>  tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  32 --
>  tools/perf/arch/s390/include/syscall_table.h       |   2 +
>  tools/perf/arch/sh/entry/syscalls/Kbuild           |   2 +
>  .../perf/arch/sh/entry/syscalls/Makefile.syscalls  |   4 +
>  tools/perf/arch/sh/entry/syscalls/syscall.tbl      | 472 +++++++++++++++=
++++
>  tools/perf/arch/sh/include/syscall_table.h         |   2 +
>  tools/perf/arch/sparc/entry/syscalls/Kbuild        |   3 +
>  .../arch/sparc/entry/syscalls/Makefile.syscalls    |   5 +
>  tools/perf/arch/sparc/entry/syscalls/syscall.tbl   | 514 +++++++++++++++=
++++++
>  tools/perf/arch/sparc/include/syscall_table.h      |   8 +
>  tools/perf/arch/x86/Build                          |   1 -
>  tools/perf/arch/x86/Makefile                       |  25 -
>  tools/perf/arch/x86/entry/syscalls/Kbuild          |   3 +
>  .../perf/arch/x86/entry/syscalls/Makefile.syscalls |   6 +
>  tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |  42 --
>  tools/perf/arch/x86/include/syscall_table.h        |   8 +
>  tools/perf/arch/xtensa/entry/syscalls/Kbuild       |   2 +
>  .../arch/xtensa/entry/syscalls/Makefile.syscalls   |   4 +
>  tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  | 439 +++++++++++++++=
+++
>  tools/perf/arch/xtensa/include/syscall_table.h     |   2 +
>  tools/perf/builtin-check.c                         |   1 -
>  tools/perf/builtin-help.c                          |   2 -
>  tools/perf/builtin-trace.c                         |  30 --
>  tools/perf/check-headers.sh                        |   9 +
>  tools/perf/perf.c                                  |   6 +-
>  tools/perf/scripts/Makefile.syscalls               |  61 +++
>  tools/perf/scripts/syscalltbl.sh                   |  86 ++++
>  tools/perf/tests/make                              |   7 +-
>  tools/perf/util/env.c                              |   4 +-
>  tools/perf/util/generate-cmdlist.sh                |   4 +-
>  tools/perf/util/syscalltbl.c                       |  90 +---
>  tools/perf/util/syscalltbl.h                       |   1 -
>  tools/scripts/syscall.tbl                          | 409 +++++++++++++++=
+
>  86 files changed, 4102 insertions(+), 620 deletions(-)
> ---
> base-commit: e8b3012cbd8f2263777347c2e8310b3f00d494f5
> change-id: 20240913-perf_syscalltbl-6f98defcc6f5
> --
> - Charlie
>

