Return-Path: <linux-csky+bounces-963-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46E2991A5E
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 22:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA251F235B8
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 20:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6984718BC27;
	Sat,  5 Oct 2024 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SMli5bb6"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E2018B491
	for <linux-csky@vger.kernel.org>; Sat,  5 Oct 2024 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158221; cv=none; b=d4uYzIYYy6EmXtPBgvcqclL2tWXawSSfgZE/KHLGzHAi4D1Ay6VPjUulj6oDatyPCBV6cMymeYwgcocZ6HBbDLq0g1NqFjhjJJbSg2DZmQ5aQHe6yIkLiE+aAW1u/48bAkNjn341c08f8a9aTvHI88Ry/DY7ZdeLcC+BEfbvBN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158221; c=relaxed/simple;
	bh=8qjRlEcZv7MlmzingnT/N+Gd/hYl6tzGS2IvVKEovyY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=FGJ3hVVjvQSfwbOJbPHB3eFMFW3i/iyMlf5hZhu4rH77B9BWMxeMLzN6BuxrmoYZSvOr16UBcWM/ObWDhhdWljf5HA9YMvTQ17rcA3jDhawSbQmgje1fGOLAWRkY6Y0eqRoeIqPtvt9bdz5454fkUrnnzKQvBIsv+7FFIaZISl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SMli5bb6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2605ce4276so5650677276.3
        for <linux-csky@vger.kernel.org>; Sat, 05 Oct 2024 12:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158219; x=1728763019; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ma4kgoFy2RIK7A+71lTzE6CEm9/tJ6zbTbn85DXB8RQ=;
        b=SMli5bb64C8AVHAjnE1qXfwQb5miAIj0T6FBKpDjzokxSwL/uClhnEz3229laFF4sy
         4/e77FMOjbSzPYR4SOR0QOq1aW4YF+eblvTh/U531y67V3mXOcR+iV3WjtgKOg8qfAGl
         uBTE13zGAzF5E6ECWywOSK20eMel7GwfKTYH5pl4npPgeiIU1LsF+H/QhaIPYzHvvNJl
         /SWtzXWMMrne3IgktmFWmtIZH+8LuyFVfQWKnWaAstJ/RhvoRhR5Byzt1Jnm0iDQYm/P
         CHi5Tx/XfMK2tDsrcj8nMB/paQr7fgB0DV7WCNY+rtPPzw/goykew8akXNvUH+w3+rii
         2CdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158219; x=1728763019;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ma4kgoFy2RIK7A+71lTzE6CEm9/tJ6zbTbn85DXB8RQ=;
        b=wmAzbFI5VHCTgNuM7vYONBnWHrLwPAUuxCTitCj++3xFO8lEvPzQAMFfK5KJyinRgf
         ZlHSlgdHmh6KGLGp8COuNHPAHSvH2j9ta3GX1Jb3KCopiDlQAgMD6kkTsJaZUbI/JzIY
         0CrVLzcQRdZUhwuk8DU6WCg36hnMocGRhIyeClXKEXKaLD06SlEoZPJmp0TFed4lI1Ff
         29zI46W7Wuld0s9xJcuIX1D3ALbCrdnXSiL+2nvC8nlYY2HT9HpClZLwgTwWceqbhxyI
         TSiWQIYjPK6QvL3UH/MZcgecxyaVMIDbgJ6LALWm47YTqSe5H+X3w83fcJ862Bc31HFZ
         e7Ag==
X-Forwarded-Encrypted: i=1; AJvYcCVsHABKAaLhrpqC1qGyUyeX620nOBPAAD3ophVJ3JtguQ2kHYZCjQ0KMs8gYh/iXJstriG38SVIPJKP@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ0RXvZDNEM4Ok9FPvyRJAL8RKT2CeWQBXRZZEBaPsb0mkgPxm
	6ivlR3r87kLwhpkQU+3S70lD3YCeGQ/cxnF/CvpZUpCBWMd++VUNUqiTIV4FkbUqm777EW8IxoE
	1PCcdLg==
X-Google-Smtp-Source: AGHT+IEl51HegVcv/pl0KKiaLpVIfkXCyaK+ttN6DaWvP25wIl/YaqJ6jogCCBBTO/D119SZYDZzeC85Makg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:aa21:0:b0:e22:5bdf:39b4 with SMTP id
 3f1490d57ef6-e28936baae8mr4651276.2.1728158218682; Sat, 05 Oct 2024 12:56:58
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:37 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-28-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 27/31] perf sh: Remove dwarf-regs.c
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
the only file in the arch/sh/util clean up Build files. Tidy up the
EM_NONE cases for sh in dwarf-regs.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/sh/Build             |  1 -
 tools/perf/arch/sh/util/Build        |  1 -
 tools/perf/arch/sh/util/dwarf-regs.c | 41 ----------------------------
 tools/perf/util/dwarf-regs.c         |  4 +--
 tools/perf/util/include/dwarf-regs.h |  2 +-
 5 files changed, 3 insertions(+), 46 deletions(-)
 delete mode 100644 tools/perf/arch/sh/Build
 delete mode 100644 tools/perf/arch/sh/util/Build
 delete mode 100644 tools/perf/arch/sh/util/dwarf-regs.c

diff --git a/tools/perf/arch/sh/Build b/tools/perf/arch/sh/Build
deleted file mode 100644
index e63eabc2c8f4..000000000000
--- a/tools/perf/arch/sh/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-y += util/
diff --git a/tools/perf/arch/sh/util/Build b/tools/perf/arch/sh/util/Build
deleted file mode 100644
index 2337a0b710a2..000000000000
--- a/tools/perf/arch/sh/util/Build
+++ /dev/null
@@ -1 +0,0 @@
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
diff --git a/tools/perf/arch/sh/util/dwarf-regs.c b/tools/perf/arch/sh/util/dwarf-regs.c
deleted file mode 100644
index 4b17fc86c73b..000000000000
--- a/tools/perf/arch/sh/util/dwarf-regs.c
+++ /dev/null
@@ -1,41 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (C) 2010 Matt Fleming <matt@console-pimps.org>
- */
-
-#include <stddef.h>
-#include <dwarf-regs.h>
-
-/*
- * Generic dwarf analysis helpers
- */
-
-#define SH_MAX_REGS 18
-const char *sh_regs_table[SH_MAX_REGS] = {
-	"r0",
-	"r1",
-	"r2",
-	"r3",
-	"r4",
-	"r5",
-	"r6",
-	"r7",
-	"r8",
-	"r9",
-	"r10",
-	"r11",
-	"r12",
-	"r13",
-	"r14",
-	"r15",
-	"pc",
-	"pr",
-};
-
-/* Return architecture dependent register string (for kprobe-tracer) */
-const char *get_arch_regstr(unsigned int n)
-{
-	return (n < SH_MAX_REGS) ? sh_regs_table[n] : NULL;
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 1649fc07f4f5..944ff4ef0290 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -34,7 +34,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
     || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
-    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390
+    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390 || EM_HOST == EM_SH
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -43,7 +43,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
     && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
-    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390
+    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390 && EM_HOST != EM_SH
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 25f3d6b90f10..2b212ed70a15 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -81,7 +81,7 @@
 #ifdef HAVE_LIBDW_SUPPORT
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
     && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
-    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__)
+    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__) && !defined(__sh__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


