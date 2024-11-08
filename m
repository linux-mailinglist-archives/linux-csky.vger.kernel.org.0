Return-Path: <linux-csky+bounces-1275-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 166239C2861
	for <lists+linux-csky@lfdr.de>; Sat,  9 Nov 2024 00:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32592B210BF
	for <lists+linux-csky@lfdr.de>; Fri,  8 Nov 2024 23:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F00D21E108;
	Fri,  8 Nov 2024 23:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CR5Hfg/N"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B726521D23C
	for <linux-csky@vger.kernel.org>; Fri,  8 Nov 2024 23:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109614; cv=none; b=LGyB0N5ASJ4bXCOb2b4PIVJbJdocYpuOiyMw6ZAJtJxBFGBVzzSnFcWw5DqSDF1zZ9deIupZ6f+Zx7Ugo94NDE+WCzFc9Okix+QFSIgc1d1el5279FpfSmRllbiFe23xZjguTirCtnUAhO0YtIxurq5dgjIUWTDOSzxWPRwCkuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109614; c=relaxed/simple;
	bh=Q03M1if3BN4GI81DpNihRqsDa7yubEf6u9TES8StfA4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bGlT3ZvmgSY9pEsoYrcNRZE+pTz8JdEIww3PARClRI8uPB6iaVIcyG71+lMtpMeEUd82V4zVLOY0cbEpuBUp8K0Ae/ZQkvNSoSb5BbqYxaVIhHYEsB1TqkP5sW6cb8RTifhuaCcZfW7jUpS8COKhKXVhoKw6xeo4e8M4GLW4Ncg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CR5Hfg/N; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e30df8dbfd4so5538044276.0
        for <linux-csky@vger.kernel.org>; Fri, 08 Nov 2024 15:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109609; x=1731714409; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RmiOTcOt4xvL7SUpRtazzW9V0wlycYaelDur7TC1ayY=;
        b=CR5Hfg/N7epnNhfq8bzRu0LC6uiVujNrSgkBKvq2HDWynV8fb+XTmMVYnaFFkyyvfp
         wFebzNAIV3bkZOLt1IEzAC4v8lt/81a0JGpXNErWVZqZyRxsdUe28wo+1x3re8pcI/Sg
         H+98q+ICbOwG/8eE8EGxiDS3Pje/TtnzKUw+GNJekyHpKbeKUTIGYHZV9hXisqXzy4L+
         l7BJETspWXKsz35lTOPFcw61Wr4/EruPAAIx2HlPcoPn+ZmsqZPwnRRZNVwQE4zPhZ6Y
         5pnWYYSjMbfIa/U5VKHtnYy/nZerMXeBQCRrnPsTWTcW5RAmWZ5g3WvdPBR/nslc0bHS
         YKlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109609; x=1731714409;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RmiOTcOt4xvL7SUpRtazzW9V0wlycYaelDur7TC1ayY=;
        b=cE1W2KiehhEyD0Cm3Vu9xJ7Wsldk8km36xfeQwjO7m4LXd3mtmtxW/O+MYevN3UWjh
         +IjBhqzk18igmTEFYIWUcH+BiHaqYmcNW/wZQOKB4H0qglnOvtXTqaE0U9HwtbU9ZE/d
         HK3kFZl82y1bn24EoQONxjW4I3lYbDwpIZ4e3ll+j1emzIMN359f30qw+ASaxyLJVnC5
         D4nrrLTPDf/WcllZnjENKVDuGHVrMKk+79OIoxxWqC4jPO4gMiMX7D6P6ittnQOE1AQu
         Z2DRl3yA6Oy8IH72hBrp6fA9ygZY7KcYQMetaRZM2htsQgPZpYOseEOkdCHWeKW0lmcL
         GPZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvYZt3lGPWFC/ornVsztsxlBFM/t6gZzES1V6KNi/L3dUnYhfRHq5btuAZIX8xBfOmDuKVU0O4radv@vger.kernel.org
X-Gm-Message-State: AOJu0YwLJ9knz/653SZ9kuxYMxlMe6Ky5bX4zwoQh9ZJkgIZ7mVYeSIz
	HAPfbBIGgl8SXyWsmGJVqfAmYmOLFW514u4EnQ7RF5qpjeEBrFuA6zUQ3adcMy3HyXH8b25yoTT
	v131zbg==
X-Google-Smtp-Source: AGHT+IF4N5D93KRKVJ4fQRTeMSW4T9kcM3Lzz9T6djLTNIFhVJljb1s5CGPpX100JDYMvvcjayu+M2Ggfoao
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:c805:0:b0:e2e:3328:7a00 with SMTP id
 3f1490d57ef6-e337f858ebdmr6015276.3.1731109609435; Fri, 08 Nov 2024 15:46:49
 -0800 (PST)
Date: Fri,  8 Nov 2024 15:46:02 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-18-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 17/20] perf sparc: Remove dwarf-regs.c
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

The file just provides the function get_arch_regstr, however, if in
the only caller get_dwarf_regstr EM_HOST is used for the EM_NONE case
the function can never be called. So remove as dead code. As this is
the only file in the arch/sparc/util clean up Build files. Tidy up the
EM_NONE cases for sparc in dwarf-regs.c.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/sparc/Build             |  1 -
 tools/perf/arch/sparc/util/Build        |  1 -
 tools/perf/arch/sparc/util/dwarf-regs.c | 39 -------------------------
 tools/perf/util/dwarf-regs.c            |  6 ++--
 tools/perf/util/include/dwarf-regs.h    |  3 +-
 5 files changed, 6 insertions(+), 44 deletions(-)
 delete mode 100644 tools/perf/arch/sparc/Build
 delete mode 100644 tools/perf/arch/sparc/util/Build
 delete mode 100644 tools/perf/arch/sparc/util/dwarf-regs.c

diff --git a/tools/perf/arch/sparc/Build b/tools/perf/arch/sparc/Build
deleted file mode 100644
index e63eabc2c8f4..000000000000
--- a/tools/perf/arch/sparc/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-y += util/
diff --git a/tools/perf/arch/sparc/util/Build b/tools/perf/arch/sparc/util/Build
deleted file mode 100644
index 2337a0b710a2..000000000000
--- a/tools/perf/arch/sparc/util/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
diff --git a/tools/perf/arch/sparc/util/dwarf-regs.c b/tools/perf/arch/sparc/util/dwarf-regs.c
deleted file mode 100644
index 1282cb2dc7bd..000000000000
--- a/tools/perf/arch/sparc/util/dwarf-regs.c
+++ /dev/null
@@ -1,39 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (C) 2010 David S. Miller <davem@davemloft.net>
- */
-
-#include <stddef.h>
-#include <dwarf-regs.h>
-
-#define SPARC_MAX_REGS	96
-
-const char *sparc_regs_table[SPARC_MAX_REGS] = {
-	"%g0", "%g1", "%g2", "%g3", "%g4", "%g5", "%g6", "%g7",
-	"%o0", "%o1", "%o2", "%o3", "%o4", "%o5", "%sp", "%o7",
-	"%l0", "%l1", "%l2", "%l3", "%l4", "%l5", "%l6", "%l7",
-	"%i0", "%i1", "%i2", "%i3", "%i4", "%i5", "%fp", "%i7",
-	"%f0", "%f1", "%f2", "%f3", "%f4", "%f5", "%f6", "%f7",
-	"%f8", "%f9", "%f10", "%f11", "%f12", "%f13", "%f14", "%f15",
-	"%f16", "%f17", "%f18", "%f19", "%f20", "%f21", "%f22", "%f23",
-	"%f24", "%f25", "%f26", "%f27", "%f28", "%f29", "%f30", "%f31",
-	"%f32", "%f33", "%f34", "%f35", "%f36", "%f37", "%f38", "%f39",
-	"%f40", "%f41", "%f42", "%f43", "%f44", "%f45", "%f46", "%f47",
-	"%f48", "%f49", "%f50", "%f51", "%f52", "%f53", "%f54", "%f55",
-	"%f56", "%f57", "%f58", "%f59", "%f60", "%f61", "%f62", "%f63",
-};
-
-/**
- * get_arch_regstr() - lookup register name from it's DWARF register number
- * @n:	the DWARF register number
- *
- * get_arch_regstr() returns the name of the register in struct
- * regdwarfnum_table from it's DWARF register number. If the register is not
- * found in the table, this returns NULL;
- */
-const char *get_arch_regstr(unsigned int n)
-{
-	return (n < SPARC_MAX_REGS) ? sparc_regs_table[n] : NULL;
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 944ff4ef0290..a0bcc2529cb0 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -34,7 +34,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
     || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
-    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390 || EM_HOST == EM_SH
+    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390 || EM_HOST == EM_SH \
+    || EM_HOST == EM_SPARC || EM_HOST == EM_SPARCV9
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -43,7 +44,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
     && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
-    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390 && EM_HOST != EM_SH
+    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390 && EM_HOST != EM_SH \
+    && EM_HOST != EM_SPARC && EM_HOST != EM_SPARCV9
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 7026a3d2aaa7..cb632d1f46f3 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -91,7 +91,8 @@
 #ifdef HAVE_LIBDW_SUPPORT
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
     && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
-    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__) && !defined(__sh__)
+    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__) && !defined(__sh__) \
+    && !defined(__sparc64__) && !defined(__sparc__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.277.g8800431eea-goog


