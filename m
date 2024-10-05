Return-Path: <linux-csky+bounces-964-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D975B991A60
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 22:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0901F21D6B
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 20:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58D9165EFA;
	Sat,  5 Oct 2024 19:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cpU4xR+5"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F29171E55
	for <linux-csky@vger.kernel.org>; Sat,  5 Oct 2024 19:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158223; cv=none; b=h8PSE1oMVa5RYHG3OmvkX4XD0nwuuwNgy4sYVkP9JBV6h0ud/SfRppNFAl4BDUCoyq9hZvctn0czrFocFLGTgg3GFlOTcw8asNjeO3eIi5uxitfI4o8hotSKSNF35mRUofOVMYSXxsgHdzLKrO8l1ewO0XtyYTqg5D1TRliG+dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158223; c=relaxed/simple;
	bh=ud+u/eatxR8lSjxU4/sjJPTzPGztQgHZhWOyJn7RnHg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UJ6I9Weft0VdjMCouk03DG0jVEE5ZKUP4YQHgy2NeekleP8ZIr27HA7Et8QVzJfI88FpAewG6eQRqONshG2WRgSGzps8qncYtLYgHJ5sv1WJ5B0jMIoas5qQ4wSWAUI4VFuZ4fXjefeDXnL8g84IdJ75QUVd9F5ZGmtRC02eQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cpU4xR+5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e2e5e376fcso4442627b3.2
        for <linux-csky@vger.kernel.org>; Sat, 05 Oct 2024 12:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158221; x=1728763021; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EmoeEuCrVGDr9+YoKquNF8Xi70GOR2fm/afSJcJ29Mk=;
        b=cpU4xR+5RGRCKWcyG7dpWikiSn75SsdEQDcXzXNqjxDj4GG2Ai4+urzp67a+o/JgFd
         rbyv4B9SSktvoH6pOB0SpBjY7ZPILS9j8U1xFLcaMWcz/URrH8JKdj4g/Z+Fda8BzUD6
         KSubolnfULj3JaE6aNrd1X0Cz2H7KdcbRp9o39g2sfJ382BQ9CharLbBlgle0hL89tFV
         IZAyEVp7TBvFU7//bCG3ZEHDH13QB5bNXvt7x+jmkSn3si23uma53/7O3fDFGEgLf5do
         Sy1xIOHs0FTmYBoN7HmCPVj56lZ+I1cxPzqEjGYEV+fW5OjBKFnWO6+K8ZMk2pls4P+l
         xaFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158221; x=1728763021;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmoeEuCrVGDr9+YoKquNF8Xi70GOR2fm/afSJcJ29Mk=;
        b=v5ASTUQC0eshcMSFhYz3uy34ByTFZ4yN6KDSSxX3ppvUqhTtDlBtXsc0But02HoRXA
         JUzNHPg+w7syNKOun3WNQ9Rn2Nn09S/taptAeDQ7XfEDe50N7pOtde7KWU84rMzqHqTE
         YRZ7kJPpLjiat1VDbHPL0jwLk2m4UoHD1U14HUWlFEcokKfBIJ0q8tg1O6O0oXVX1Wu+
         TLVZpRjPFL2/wRd8ZD504hddLbhtOEjfjw1FtgrtpAHDANbxhK/uGPq38POxjGU8Y3cR
         IqsfyMR7QudMDpxeuP2D2YBPG6Ewq53lGs4fwiXqCpEzj5fcGvY4+S4zNVaD2+74Ixw+
         RBzA==
X-Forwarded-Encrypted: i=1; AJvYcCUafiCsUEIO004fey0bvSwcHnqqyZAUV0AWx3Ov1nBn6Tg2+ul+FKIHU1zGsfTqNhShNcmsFePHjecF@vger.kernel.org
X-Gm-Message-State: AOJu0YwSXo9TRGEdyuHAn0c77vu6NRRaT8vm5O6YeG90ysnmRTPoyMEX
	yBgVuVzJTuYP09cwL7HfdSnrPN0c1EvHylbrzxOm0n552BBu6+4v8dCIjVQOZeme+Mk+4/CSvAh
	Y1mbqoA==
X-Google-Smtp-Source: AGHT+IFm23ZIOzXg/tKwngJH/dLPKtNLjC7D9wEED6EI/kRFIrzWkVHnKrlI68/GiP6LjaWVtUm7B1Gocmo8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:fb0a:0:b0:e1c:ed3d:7bb7 with SMTP id
 3f1490d57ef6-e28936be3d2mr4614276.1.1728158220962; Sat, 05 Oct 2024 12:57:00
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:38 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-29-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 28/31] perf sparc: Remove dwarf-regs.c
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
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Yury Norov <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

The file just provides the function get_arch_regstr, however, if in
the only caller get_dwarf_regstr EM_HOST is used for the EM_NONE case
the function can never be called. So remove as dead code. As this is
the only file in the arch/sparc/util clean up Build files. Tidy up the
EM_NONE cases for sparc in dwarf-regs.c.

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
index 2b212ed70a15..b2cf7d9e4785 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -81,7 +81,8 @@
 #ifdef HAVE_LIBDW_SUPPORT
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
     && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
-    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__) && !defined(__sh__)
+    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__) && !defined(__sh__) \
+    && !defined(__sparc64__) && !defined(__sparc__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


