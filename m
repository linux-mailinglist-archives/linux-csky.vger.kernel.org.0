Return-Path: <linux-csky+bounces-1134-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C508F9A16EC
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 02:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D651F25FB0
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 00:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67556320F;
	Thu, 17 Oct 2024 00:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBdR+HMY"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BF5161
	for <linux-csky@vger.kernel.org>; Thu, 17 Oct 2024 00:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124729; cv=none; b=pZr8A3pBpwKAupdpuoTFljFyeeYA8bzAG8moIwCPLt+9G1KFQe2YtsNhYovQKrZ0bIM5eMZx777nbJMOuKYzsP1aDnoMYa1xx80JCUmuY3iOkoi3/GcS3pRyLq5MZVh6vZN8KKNH5aIweB1j1Em/QScjc01EWQ6mbojIU66ZP+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124729; c=relaxed/simple;
	bh=rWGtnLl1arxCDHU3ybrEX26z/6hreqHLWTvxIM8Zohc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=A59mrMiECfFG+Ybn74j78/uv0oHM+3P8IG/YHL9GA6M9SXobdQi350ztsiuR6WLmm2Cqm/MH53CFGalt+WnBQ36q+sxEMKHkcCYWjULDrm+ovGUZ1pGDoUGrKKYXFjTZNp1um6kQVlUDayEwf6V8ko2LQnTf47hYHcOZ48qvyyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBdR+HMY; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e290947f6f8so691269276.2
        for <linux-csky@vger.kernel.org>; Wed, 16 Oct 2024 17:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124726; x=1729729526; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0MVEopwQelkynI+vONSt1eNqCP+P10MdFmkRWcj813Q=;
        b=EBdR+HMYU0FYU6Iy2QLj62HHhr8xlsEiMfVPzR4dnkwTikAzgSFrdtKHt9pkmsYAYz
         ruqqU83MBFk5oWQtcmMgnaXfDz99JVr3H0EZc/JplMYZmPZLxFG/lXG6zu0mPekQDfj4
         7QY8RYNVivGq20/t5+J1yY8Q/MyuBJZKoEB2V2adY+XgzUqPuthzDWbq8HSdldihi9NA
         3qKngV/SZ/KtJB/Qbk1EWGKQ7la1FIF6cH7gotflISk7QXDAT4UZtkmFAH3197vxCbNp
         PpxRaGxdV4kR1jPHRWfoRAR8StUVZonvk1b56lamweZHWMUvtNh7f0tC6OkDfxq4Tyds
         wNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124726; x=1729729526;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0MVEopwQelkynI+vONSt1eNqCP+P10MdFmkRWcj813Q=;
        b=amKDB7UunCQ0u2UXcSMfT7uwrbG2pInzac/oLps2ctUMRz8Cdfz09UmXcjsTNZuRP3
         /kGnvpUlijOuHaePtMzcVhEyfzqXiA0HZsC5TE7h5e4enRCzA0CRc8foyeiM6Qjr4Fd+
         tGkgi5MM9zlbr42IIyDEevjw9t5JyiHocl63z08B4izoZ2nCOIrhSBIKvGT+Mih5dqZv
         ck1LLF8Um6/YJrE5fV+thCSWp9lpZbQC4Jun7yArwmuLvLbGxpiCngTdhn2MEDLDlCbc
         7O+mdV+UNW8nJ2iqwbrIkTp8upErWWbrv9+3zueQJPXMuHcd+bBTwtnX8jkFLmLADuSa
         gvPg==
X-Forwarded-Encrypted: i=1; AJvYcCV7qyI/wr79j9+WBHq0kgpq6G6DKrnXTzaf2YvH3EI5Yfcn6lMS0EamUfTq7jaDIUjSVlgMuWBJSr8K@vger.kernel.org
X-Gm-Message-State: AOJu0YxhXV5CVf8ts58EyVqyBQksK/aaLALw8ruxDWSW+E466d3oy+07
	l0rhpSTrp0fAHs1Z6IJAaTeK5dFDT4j8Ov9KZID64RAjiUYUFRhrVF4ctUYHZxyCTEQLBUwiGLj
	5VlS3nw==
X-Google-Smtp-Source: AGHT+IGs6rtJljCigsHxy+gP6Zvfa6mMr4o1JCjh56mqE4HiFoyek51h2OZvh4lGlezQ3sjgUNIEEbqKPWUq
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:6902:2d08:b0:e28:f6b3:3666 with SMTP
 id 3f1490d57ef6-e2978567367mr4642276.7.1729124726404; Wed, 16 Oct 2024
 17:25:26 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:00 -0700
Message-Id: <20241017002520.59124-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 00/20] Remove PERF_HAVE_DWARF_REGS
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

These changes are on top of:
https://lore.kernel.org/lkml/20241017001354.56973-1-irogers@google.com/

Prior to these patches PERF_HAVE_DWARF_REGS indicated the presence of
dwarf-regs.c in the arch directory. dwarf-regs.c provided upto 4
functions:

1) regs_query_register_offset would translate a register name into a
pt_regs offset and was used by BPF prologues. BPF prologues existed
for BPF events and support for these was removed many releases ago.
This code was dead and could be removed.

2) get_arch_regstr duplicated get_dwarf_regstr and so it could be
removed.  The case for csky was a little more complicated as the ABI
controlled the string. The callers of get_dwarf_regstr were updated to
also pass the ELF flags so that on csky the ABI appropriate table
could be used. As the argument is only used on csky this a no-op for
everything else.

3) get_arch_regnum translated a register name back to a dwarf number
and only existed on x86 where "al", "ax", "eax" and "rax" could all
mean register 0. This code was moved to util with similar
machine/flags logic to get_arch_regstr and for consistency with it.

4) get_powerpc_regs a PowerPC specific function used by annotate that
should really be in util.

2 and 3 required the wiring through of the ELF machine and flags in
callers to get_dwarf_regstr and get_dwarf_regnum. When these values
weren't dependent on an ELF file a new EM_HOST and EF_HOST were added
to give the host ELF machine and flags. These 2 #defines got rid of
the existing separate arch files and #ifdefs.

v3: These files were separated from the rest of the v2 libdw clean up
    in:
https://lore.kernel.org/lkml/CAP-5=fVZH3L-6y_sxLwSmT8WyMXDMFnuqUksNULdQYJCPNBFYw@mail.gmail.com/

Ian Rogers (20):
  perf bpf-prologue: Remove unused file
  perf dwarf-regs: Remove PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET
  perf dwarf-regs: Add EM_HOST and EF_HOST defines
  perf disasm: Add e_machine/e_flags to struct arch
  perf dwarf-regs: Pass accurate disassembly machine to get_dwarf_regnum
  perf dwarf-regs: Pass ELF flags to get_dwarf_regstr
  perf dwarf-regs: Move x86 dwarf-regs out of arch
  perf arm64: Remove dwarf-regs.c
  perf arm: Remove dwarf-regs.c
  perf dwarf-regs: Move csky dwarf-regs out of arch
  perf loongarch: Remove dwarf-regs.c
  perf mips: Remove dwarf-regs.c
  perf dwarf-regs: Move powerpc dwarf-regs out of arch
  perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h
  perf s390: Remove dwarf-regs.c
  perf sh: Remove dwarf-regs.c
  perf sparc: Remove dwarf-regs.c
  perf xtensa: Remove dwarf-regs.c
  perf dwarf-regs: Remove get_arch_regstr code
  perf build: Remove PERF_HAVE_DWARF_REGS

 tools/perf/Makefile.config                    |  17 +-
 tools/perf/arch/arc/annotate/instructions.c   |   2 +
 tools/perf/arch/arm/Makefile                  |   3 -
 tools/perf/arch/arm/annotate/instructions.c   |   2 +
 tools/perf/arch/arm/util/Build                |   2 -
 tools/perf/arch/arm/util/dwarf-regs.c         |  61 -------
 tools/perf/arch/arm64/Makefile                |   4 -
 tools/perf/arch/arm64/annotate/instructions.c |   2 +
 tools/perf/arch/arm64/util/Build              |   1 -
 tools/perf/arch/arm64/util/dwarf-regs.c       |  92 -----------
 tools/perf/arch/csky/Makefile                 |   4 -
 tools/perf/arch/csky/annotate/instructions.c  |   7 +-
 tools/perf/arch/csky/util/Build               |   1 -
 tools/perf/arch/loongarch/Makefile            |   4 -
 .../arch/loongarch/annotate/instructions.c    |   2 +
 tools/perf/arch/loongarch/util/Build          |   1 -
 tools/perf/arch/loongarch/util/dwarf-regs.c   |  44 -----
 tools/perf/arch/mips/Makefile                 |   4 -
 tools/perf/arch/mips/annotate/instructions.c  |   2 +
 tools/perf/arch/mips/util/Build               |   1 -
 tools/perf/arch/mips/util/dwarf-regs.c        |  38 -----
 tools/perf/arch/powerpc/Makefile              |   5 -
 .../perf/arch/powerpc/annotate/instructions.c |   2 +
 tools/perf/arch/powerpc/util/Build            |   1 -
 tools/perf/arch/powerpc/util/dwarf-regs.c     | 153 ------------------
 tools/perf/arch/riscv/Makefile                |   5 +-
 .../arch/riscv/include/dwarf-regs-table.h     |  42 +++++
 tools/perf/arch/riscv/util/Build              |   1 -
 tools/perf/arch/riscv/util/dwarf-regs.c       |  72 ---------
 .../perf/arch/riscv64/annotate/instructions.c |   2 +
 tools/perf/arch/s390/Makefile                 |   4 -
 tools/perf/arch/s390/annotate/instructions.c  |   2 +
 tools/perf/arch/s390/util/Build               |   1 -
 tools/perf/arch/s390/util/dwarf-regs.c        |  43 -----
 tools/perf/arch/sh/Build                      |   1 -
 tools/perf/arch/sh/Makefile                   |   4 -
 tools/perf/arch/sh/util/Build                 |   1 -
 tools/perf/arch/sh/util/dwarf-regs.c          |  41 -----
 tools/perf/arch/sparc/Build                   |   1 -
 tools/perf/arch/sparc/Makefile                |   4 -
 tools/perf/arch/sparc/annotate/instructions.c |   2 +
 tools/perf/arch/sparc/util/Build              |   1 -
 tools/perf/arch/sparc/util/dwarf-regs.c       |  39 -----
 tools/perf/arch/x86/Makefile                  |   4 -
 tools/perf/arch/x86/annotate/instructions.c   |   3 +-
 tools/perf/arch/x86/util/Build                |   3 -
 tools/perf/arch/x86/util/dwarf-regs.c         | 153 ------------------
 tools/perf/arch/xtensa/Build                  |   1 -
 tools/perf/arch/xtensa/Makefile               |   4 -
 tools/perf/arch/xtensa/util/Build             |   1 -
 tools/perf/arch/xtensa/util/dwarf-regs.c      |  21 ---
 tools/perf/util/Build                         |   3 +
 tools/perf/util/annotate.c                    |   6 +-
 tools/perf/util/bpf-prologue.h                |  37 -----
 tools/perf/util/disasm.h                      |   4 +
 .../dwarf-regs.c => util/dwarf-regs-csky.c}   |  19 +--
 tools/perf/util/dwarf-regs-powerpc.c          |  61 +++++++
 tools/perf/util/dwarf-regs-x86.c              |  50 ++++++
 tools/perf/util/dwarf-regs.c                  |  38 +++--
 tools/perf/util/include/dwarf-regs.h          | 110 ++++++++++---
 tools/perf/util/probe-finder.c                |  13 +-
 tools/perf/util/probe-finder.h                |   3 +-
 62 files changed, 328 insertions(+), 927 deletions(-)
 delete mode 100644 tools/perf/arch/arm/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/arm64/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/csky/Makefile
 delete mode 100644 tools/perf/arch/loongarch/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/mips/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/powerpc/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/riscv/include/dwarf-regs-table.h
 delete mode 100644 tools/perf/arch/riscv/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/s390/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/sh/Build
 delete mode 100644 tools/perf/arch/sh/Makefile
 delete mode 100644 tools/perf/arch/sh/util/Build
 delete mode 100644 tools/perf/arch/sh/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/sparc/Build
 delete mode 100644 tools/perf/arch/sparc/util/Build
 delete mode 100644 tools/perf/arch/sparc/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/x86/util/dwarf-regs.c
 delete mode 100644 tools/perf/arch/xtensa/Build
 delete mode 100644 tools/perf/arch/xtensa/Makefile
 delete mode 100644 tools/perf/arch/xtensa/util/Build
 delete mode 100644 tools/perf/arch/xtensa/util/dwarf-regs.c
 delete mode 100644 tools/perf/util/bpf-prologue.h
 rename tools/perf/{arch/csky/util/dwarf-regs.c => util/dwarf-regs-csky.c} (74%)
 create mode 100644 tools/perf/util/dwarf-regs-powerpc.c
 create mode 100644 tools/perf/util/dwarf-regs-x86.c

-- 
2.47.0.105.g07ac214952-goog


