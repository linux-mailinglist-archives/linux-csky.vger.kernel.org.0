Return-Path: <linux-csky+bounces-1258-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A393E9C283F
	for <lists+linux-csky@lfdr.de>; Sat,  9 Nov 2024 00:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7E18B22AD8
	for <lists+linux-csky@lfdr.de>; Fri,  8 Nov 2024 23:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9240C1F709E;
	Fri,  8 Nov 2024 23:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnpg/lLr"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8377F1E0DB2
	for <linux-csky@vger.kernel.org>; Fri,  8 Nov 2024 23:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109574; cv=none; b=VrwH0s4yR6RGI41vFzjBDuDS0PNfy2xEdw0BryLdVjzHWeOwSE9A/qHg6YeH4c4xmzfI2QotrmpJ4u/ODkvS/aptL+A9Ujb4Jnn+wEGXLzG00TAu3Pa2Q+GsJ/85+UjTMyV7tRdCiFZtqdlPNqJkh9Hd5cE9TvaYb/2h4eQFBqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109574; c=relaxed/simple;
	bh=slTDJpkuXaI2FSflzZPrxxPFD5Jf9rX1KtNIM7MAfoU=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=oLraJPE9AijvWeBwIUCg+eYUqbA3J+PUPk/CEhkOgTiDQAZSL0nwMjZmc+ByW7uktNEzYZh08FyPuHPXBDDMKDtWtc5w4ORRXrZS+P4w94WVkdfP7hN7Ny9gWQnU20Fvlzypr7ivzwBi1L4SL2rROEo8dwKXW9EXgvxmq5dydd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnpg/lLr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e32ff6f578eso4908626276.1
        for <linux-csky@vger.kernel.org>; Fri, 08 Nov 2024 15:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109570; x=1731714370; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bo+XoNcfTiWt9dXZSAxdrxoaHvpnygZk759HUW2Tdtc=;
        b=cnpg/lLrrHzrGjA6Xnsfa6VxTMuT2o3uTHL1sWo5/cPFNSF28T+05JpuIFjMCCz6v9
         xte1vqJ43SHIIyEiYzissF3qG1h+FQApnvXBWKARh0iT3cL+C598hy5rV0sbnBbCW/ko
         3SyOUaZ9cnLMGOMHP63meI8n09upT7ZgWihwb+zvDPe0t3P+embVW1qaV/klQjteG5BA
         xrXLgRC+8Bb7/nVozy1V+LcvpyHKvk7FkkGlFVOnpFR9Xb+5scysop3MQc9sshLjnFBu
         nFFctVDR4B91YQNiTtbCKKNRe1hWIGNdZIGzgDNu6dRCNlXcVGCIsmPNjIrYRcOq0W8h
         IXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109570; x=1731714370;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bo+XoNcfTiWt9dXZSAxdrxoaHvpnygZk759HUW2Tdtc=;
        b=IbKp3i2T/b5pwD5CNMubItDmW6YUpS9f0EJ5A2vdodCKIBUZil+ecN1RiI90+bbazR
         3g8ZSiO4w7QYc2w6axmCWVzqd/8hlj1PXLBFe05+BxRG9RjYsBK/A5I/DbAamxDDhwef
         3gXSrx2Q9z0ufvjXOCQkWNh2k4M7mvxoPwYNfyH1WBqld9q2fmQInYKyf3jFu93ZthLV
         pkatJHREf06ZCMJCJ4jZg9k2pYKf80ugl0Er0WTdyFMAg3xd4vW1MyerYh1LLj2hkHEk
         5ILZ/Ey5DjsKehNGjmjLBAFGOn31UBM9y9yEIPlyPIvDQOx5OKBF86bTZ0ifV78UAW/w
         ydYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7DTmTOjUSesHPqlPP8HOVdsCFzW7ob0JbgEYsB+CKO7kDCxFBzg7BvEG4WNabT717JgToS1f4Mqwg@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0KT6qWD1kI9qHnx7QP/yy04hD+CrPrvVpr41JvE+0pALJ9kRt
	kGabJl/vDpE6iint9wYByM8dFsQcXCuwBK69Vb7Ru7KtUSDcnRzVQlnyLmTYHLknIbmMRgREvgg
	BjdjD5g==
X-Google-Smtp-Source: AGHT+IG7nNHrZbf62YTEIFaabL+CBo69CYr9RS79+TUQD474jGBOE4r4BpO1ymNXWY8gOslRzk6deJr/eKGp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:d843:0:b0:e29:7454:e773 with SMTP id
 3f1490d57ef6-e337e1d738cmr20475276.5.1731109569972; Fri, 08 Nov 2024 15:46:09
 -0800 (PST)
Date: Fri,  8 Nov 2024 15:45:45 -0800
Message-Id: <20241108234606.429459-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 00/20] Remove PERF_HAVE_DWARF_REGS
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

These changes were originally on top of:
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

v4: Add CSky defines to dwarf-regs.h Add reviewed-by tags from Masami.
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
 tools/perf/util/disasm.c                      |   1 +
 tools/perf/util/disasm.h                      |   4 +
 .../dwarf-regs.c => util/dwarf-regs-csky.c}   |  19 +--
 tools/perf/util/dwarf-regs-powerpc.c          |  61 +++++++
 tools/perf/util/dwarf-regs-x86.c              |  50 ++++++
 tools/perf/util/dwarf-regs.c                  |  38 +++--
 tools/perf/util/include/dwarf-regs.h          | 120 +++++++++++---
 tools/perf/util/probe-finder.c                |  13 +-
 tools/perf/util/probe-finder.h                |   3 +-
 63 files changed, 339 insertions(+), 927 deletions(-)
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
2.47.0.277.g8800431eea-goog


