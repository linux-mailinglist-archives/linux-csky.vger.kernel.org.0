Return-Path: <linux-csky+bounces-1272-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6A19C2859
	for <lists+linux-csky@lfdr.de>; Sat,  9 Nov 2024 00:49:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DB061F2126C
	for <lists+linux-csky@lfdr.de>; Fri,  8 Nov 2024 23:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C16A21B44B;
	Fri,  8 Nov 2024 23:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpOC0g+m"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81A921CF9D
	for <linux-csky@vger.kernel.org>; Fri,  8 Nov 2024 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109604; cv=none; b=uE/cgEe0hGztPQSp7gzyVKD6Pmy5pK+rOYz+jVKlnB0y1PGebrdDwot+115I6hx2wT/vdqYkVIJvIor39LOfct3uOx5AhG6r8FEmAoVSiJu05QoMzgriRDV1KDgrYeB586e6g8P1FAqrWzkM7sLzigKDbamqGN2QFrGdbTMoqMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109604; c=relaxed/simple;
	bh=lxwX8wQlEPnS+PAZeVSY9HLlrY+iYxf2rLWu2wd8+M4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=vAkq3yXAH/qpgccgSsSwxUfjNJA1ZITEo1+V4A2cCg6HRNgGlFy/cTZurnRKb8hQKlJZYpzX3Z0LYm87hfNDZR1xWiTiaVHMkdSUClPpq8Lqs5BQxfWjB0VoV5IdTxstR1KJjqp9IcSskeCcyyvB8WhRAn/RsKHsfxv7pH7/BnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fpOC0g+m; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3c638cc27so53906437b3.0
        for <linux-csky@vger.kernel.org>; Fri, 08 Nov 2024 15:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109602; x=1731714402; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eqWMrnzo0j4YyPMZKa2aiWl4n8rmwjjeUqcbD/Ug9qQ=;
        b=fpOC0g+mNqly1/ZQmdhE/FH/GJnQnHVLQNMlGauQFHY5KCQ7iO2qk8og+aySMu+RwF
         J+aCP8UtGQEf78Q1o0UOKFO9D29HYgcvDLAkGDVZDhyPJabVbFAYm1w39ljB+vHdjQ5m
         VN5Q93gKIdpWnzQXxSaxTWnQLN3FbKoRT+FIrmObm1oM1Cd/0QmTpJWxYf7tlEQ058AJ
         t8kgeboZVfbCVI5TumPVVkneCFwH02AxT7B9LJ75EfEYD21lspPBTyqTaLVt/fhsHbhl
         LQDq78xZgkbAKLu9NPbtVltJhXwO9lIgDUGMQiojdcRHj2+EWitYCIibMKVFhkeembMO
         7rHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109602; x=1731714402;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eqWMrnzo0j4YyPMZKa2aiWl4n8rmwjjeUqcbD/Ug9qQ=;
        b=MxfsCt/1iNsUASAlpT9tEzzDUmxMt7/8mL20hclcNi4Y4+Mvgi/CaQQeBnrf454xqu
         HH94JCj14RDWBSrMUFusoKMpUlJhmoTjh+hLaAxqSX3a4K1PO4bU3RVEJp1fCqw2Kjvp
         61PlHrd4OoZ32LyGuZlmW7bTvsGj6M7Onqd2xYKrKDgYqGKB9f/Dsh10k1gUDt0Fj3vL
         SFbiSp405XbuOJ2CLdy4H2mM+xILhoqt6S1Pl+L9DZEnFesRmfZcVgeG7EPZL9LUSJcZ
         qvw6d58BAx5E6X+8epR/OUcMrHSGgyoE7DOHaQtvJHWhUShNCtyvt5zq+dOmrDnwrVcC
         QHuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYlH1XNmNLzBUKh2X16aRj6DOmTm39Pu3R8wYq1uGnQfsDw6v3rt7xzYEhrDuSXJGw2vJKDCCM7kuE@vger.kernel.org
X-Gm-Message-State: AOJu0Yws2Vk+cTw2It6U/IP9pMcbUXxwmYkRja6rnwYK+M4UePOm0I6a
	jTJDJ9pHOcHcZV7bnPhrdTt5Q6D7gqVIV/TvUaq2bt4MeLa/+YO8dPrNp9VaFao0zRgje+eS5el
	i8udWYQ==
X-Google-Smtp-Source: AGHT+IHQv2/HetZIKd9sCauNhBkFTTcfGmC6Wh+WbHbWlZ+a9vS0rL2sguJXg20BQRNHR1FgsV28QiZqkehn
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a0d:c7c5:0:b0:6ea:6872:2fe6 with SMTP id
 00721157ae682-6eadde3cde7mr310537b3.4.1731109602037; Fri, 08 Nov 2024
 15:46:42 -0800 (PST)
Date: Fri,  8 Nov 2024 15:45:59 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 14/20] perf riscv: Remove dwarf-regs.c and add dwarf-regs-table.h
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
the only caller get_dwarf_regstr EM_HOST is used for the EM_NONE case,
and the register table is provided in a header file, the function can
never be called. So remove as dead code. Tidy up the EM_NONE cases for
riscv in dwarf-regs.c.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../dwarf-regs-table.h}                       | 32 ++++---------------
 tools/perf/arch/riscv/util/Build              |  1 -
 tools/perf/util/dwarf-regs.c                  |  7 ++--
 tools/perf/util/include/dwarf-regs.h          |  2 +-
 4 files changed, 12 insertions(+), 30 deletions(-)
 rename tools/perf/arch/riscv/{util/dwarf-regs.c => include/dwarf-regs-table.h} (56%)

diff --git a/tools/perf/arch/riscv/util/dwarf-regs.c b/tools/perf/arch/riscv/include/dwarf-regs-table.h
similarity index 56%
rename from tools/perf/arch/riscv/util/dwarf-regs.c
rename to tools/perf/arch/riscv/include/dwarf-regs-table.h
index a9c4402ae57e..a45b63a6d5a8 100644
--- a/tools/perf/arch/riscv/util/dwarf-regs.c
+++ b/tools/perf/arch/riscv/include/dwarf-regs-table.h
@@ -1,23 +1,10 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
- * Mapping of DWARF debug register numbers into register names.
- */
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifdef DEFINE_DWARF_REGSTR_TABLE
+/* This is included in perf/util/dwarf-regs.c */
 
-#include <stddef.h>
-#include <errno.h> /* for EINVAL */
-#include <string.h> /* for strcmp */
-#include <dwarf-regs.h>
+#define REG_DWARFNUM_NAME(reg, idx)	[idx] = "%" #reg
 
-struct regs_dwarfnum {
-	const char *name;
-	unsigned int dwarfnum;
-};
-
-#define REG_DWARFNUM_NAME(r, num) {.name = r, .dwarfnum = num}
-#define REG_DWARFNUM_END {.name = NULL, .dwarfnum = 0}
-
-struct regs_dwarfnum riscv_dwarf_regs_table[] = {
+static const char * const riscv_regstr_tbl[] = {
 	REG_DWARFNUM_NAME("%zero", 0),
 	REG_DWARFNUM_NAME("%ra", 1),
 	REG_DWARFNUM_NAME("%sp", 2),
@@ -50,13 +37,6 @@ struct regs_dwarfnum riscv_dwarf_regs_table[] = {
 	REG_DWARFNUM_NAME("%t4", 29),
 	REG_DWARFNUM_NAME("%t5", 30),
 	REG_DWARFNUM_NAME("%t6", 31),
-	REG_DWARFNUM_END,
 };
 
-#define RISCV_MAX_REGS ((sizeof(riscv_dwarf_regs_table) / \
-		 sizeof(riscv_dwarf_regs_table[0])) - 1)
-
-const char *get_arch_regstr(unsigned int n)
-{
-	return (n < RISCV_MAX_REGS) ? riscv_dwarf_regs_table[n].name : NULL;
-}
+#endif
diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
index 8f93091b8345..58a672246024 100644
--- a/tools/perf/arch/riscv/util/Build
+++ b/tools/perf/arch/riscv/util/Build
@@ -2,5 +2,4 @@ perf-util-y += perf_regs.o
 perf-util-y += header.o
 
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 3d98c2bf6035..2c6b197556dd 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -20,6 +20,7 @@
 #include "../arch/arm64/include/dwarf-regs-table.h"
 #include "../arch/sh/include/dwarf-regs-table.h"
 #include "../arch/powerpc/include/dwarf-regs-table.h"
+#include "../arch/riscv/include/dwarf-regs-table.h"
 #include "../arch/s390/include/dwarf-regs-table.h"
 #include "../arch/sparc/include/dwarf-regs-table.h"
 #include "../arch/xtensa/include/dwarf-regs-table.h"
@@ -33,7 +34,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
     || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
-    || EM_HOST == EM_PPC64
+    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -42,7 +43,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
     && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
-    && EM_HOST != EM_PPC64
+    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
@@ -63,6 +64,8 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 	case EM_PPC:
 	case EM_PPC64:
 		return __get_dwarf_regstr(powerpc_regstr_tbl, n);
+	case EM_RISCV:
+		return __get_dwarf_regstr(riscv_regstr_tbl, n);
 	case EM_SPARC:
 	case EM_SPARCV9:
 		return __get_dwarf_regstr(sparc_regstr_tbl, n);
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index e47c4697da36..28075de8bcf4 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -91,7 +91,7 @@
 #ifdef HAVE_LIBDW_SUPPORT
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
     && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
-    && !defined(__powerpc64__)
+    && !defined(__powerpc64__) && !defined(__riscv__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.277.g8800431eea-goog


