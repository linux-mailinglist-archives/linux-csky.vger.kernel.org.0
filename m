Return-Path: <linux-csky+bounces-2718-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F27D38C99
	for <lists+linux-csky@lfdr.de>; Sat, 17 Jan 2026 06:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58B573019559
	for <lists+linux-csky@lfdr.de>; Sat, 17 Jan 2026 05:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B49532D7FF;
	Sat, 17 Jan 2026 05:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nDjkyi5i"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B4F328B69
	for <linux-csky@vger.kernel.org>; Sat, 17 Jan 2026 05:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627789; cv=none; b=pss0FE80aeeWBVeGVBhYvlGVupKIBvZiperbCE7ojkhgZqwvZACMaGre3oJeEDBtd7bV4qvlWl/pEX8wBorP/svtUNMy/8JTSaY+U8CZ0LeyU2ze+qgTmfhVYd4VNco/kem+iHPVFlqX20MG5K2cKKr49UJK1f8CXF6H/r9860w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627789; c=relaxed/simple;
	bh=C1HaNvXTzDF+GFocEumuatdovRPHfAiSauX/HU1DN1Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=GGRP9ntgtcHmfIGh2IsbszlJlsKJ34z8u/dxZ5uD8geC1CbKHvTjfbPNtaL3V0fNnfo+wHlTekYx9sYstff2DrFLpQTdPybAJp8nyhA7hq/oE6Ox33drzt2cukAXBSx3zFPIJCyYTI15IblxXE4TuXLGQPXtLoLsmaL3TTTz5Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nDjkyi5i; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1233b91de6bso5021015c88.1
        for <linux-csky@vger.kernel.org>; Fri, 16 Jan 2026 21:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627784; x=1769232584; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUzN9Y1aSzyUn7IkPpsP+ciLuVYqFUqLe8fSLq1UShc=;
        b=nDjkyi5iwVp9B25SgiufOJ1HBNPAKENBUJSOmD0rY6b9LLys+w3Kj7US8Dx+0yh56S
         LfXZuvIXH/P1uzpLhjd1bXPpd/3GfaaCLVmAKp41DtAUSPxI7qyXm1FFkPVXqTm3F+Dl
         hx5uHq0+ORRNjvMoctLyLE4eFMuUx1A36Z8vYpdhgkZHdJrOk/+V1N7RY213UOEbLefg
         EDMr2AgD4u/lZTwHmWlaBfrn4JXzPHV3vOLcPXzfVwki+RJRkR3oawY5GZ/8s132OmeJ
         jm+I0V/aKWpyz1SUyRno4aH+V98cdkRDFGNKIaWOfKj9DH+BueNqI9EfieMarbfODUVH
         d/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627784; x=1769232584;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUzN9Y1aSzyUn7IkPpsP+ciLuVYqFUqLe8fSLq1UShc=;
        b=Vi4h9LdeNTEE2WNgT4AooGRlBMGrQ5vXDWC3iUHAGa8KdsjTZqzMqHMn6jFlj6Qf1q
         1SchFCztxygSfV/9Y5R4SkdfGAWp58ip+79zoiC9rJju8MfWt7FJYEpp3xhXv/dUuzud
         KnecsQa0/PHjJAKleRNcb/DE+2u+ybbrQ89jQAqqU+L0rHZjDwU0pi/3+Q3/zdUAQEs9
         /xNOODjQNdM5kfTMN8z6nJ9gOUjbpwH+yrew+DbBFV/+89AEHq++RHbL/zkCM+biQcnJ
         8FIbKKOQRIO+IQisjxEblWwab8pCsyI5lEC1I+l/VN4Br5USV0It6MCTwJzKUgSYPWwY
         B6zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhHvHFienmBepcevpkdRadfcg2fFA9XTpkjR/E1Hxk9sqQ+zjSU5TyAxZNBmx9wBDrOamf6QT3iQRj@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ+/yGLRL5zQOTfTFXpsKpdfLCPR8PER7S+TN8R7o88KIpXopE
	It3VoTTazn8cvyOOYI7z5FvL/QDIQzZBwiEGHbjssIInt0qKRiqxN7PRRyrslp2zOtgJAjlCUqx
	PY3iO1SFo+Q==
X-Received: from dlae5.prod.google.com ([2002:a05:701b:2305:b0:123:2aa4:47a4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:660f:b0:123:2d00:1668
 with SMTP id a92af1059eb24-1244b37f8bdmr4510370c88.49.1768627783323; Fri, 16
 Jan 2026 21:29:43 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:39 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-14-irogers@google.com>
Subject: [PATCH v1 13/23] perf dwarf-regs: Add basic get_dwarf_regnum for most architectures
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"

Add a basic get_dwarf_regnum implementation for most architectures by
using the get_dwarf_regstr tables and returning the index of the name
within the table.

Some minor name and constification clean up for csky.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 .../util/dwarf-regs-arch/dwarf-regs-csky.c    | 24 +++++++-
 tools/perf/util/dwarf-regs.c                  | 58 +++++++++++++++++--
 tools/perf/util/include/dwarf-regs.h          |  5 +-
 3 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
index d38ef1f07f3e..86394ed46397 100644
--- a/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
@@ -2,11 +2,12 @@
 // Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
 // Mapping of DWARF debug register numbers into register names.
 
+#include <errno.h>
 #include <stddef.h>
 #include <dwarf-regs.h>
 
 #define CSKY_ABIV2_MAX_REGS 73
-const char *csky_dwarf_regs_table_abiv2[CSKY_ABIV2_MAX_REGS] = {
+static const char * const csky_dwarf_regs_table_abiv2[CSKY_ABIV2_MAX_REGS] = {
 	/* r0 ~ r8 */
 	"%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1", "%regs2", "%regs3",
 	/* r9 ~ r15 */
@@ -27,7 +28,7 @@ const char *csky_dwarf_regs_table_abiv2[CSKY_ABIV2_MAX_REGS] = {
 };
 
 #define CSKY_ABIV1_MAX_REGS 57
-const char *csky_dwarf_regs_table_abiv1[CSKY_ABIV1_MAX_REGS] = {
+static const char * const csky_dwarf_regs_table_abiv1[CSKY_ABIV1_MAX_REGS] = {
 	/* r0 ~ r8 */
 	"%sp", "%regs9", "%a0", "%a1", "%a2", "%a3", "%regs0", "%regs1",
 	/* r9 ~ r15 */
@@ -41,10 +42,27 @@ const char *csky_dwarf_regs_table_abiv1[CSKY_ABIV1_MAX_REGS] = {
 	"%epc",
 };
 
-const char *get_csky_regstr(unsigned int n, unsigned int flags)
+const char *__get_csky_regstr(unsigned int n, unsigned int flags)
 {
 	if (flags & EF_CSKY_ABIV2)
 		return (n < CSKY_ABIV2_MAX_REGS) ? csky_dwarf_regs_table_abiv2[n] : NULL;
 
 	return (n < CSKY_ABIV1_MAX_REGS) ? csky_dwarf_regs_table_abiv1[n] : NULL;
 }
+
+static int __get_dwarf_regnum(const char *const *regstr, size_t num_regstr, const char *name)
+{
+	for (size_t i = 0; i < num_regstr; i++) {
+		if (regstr[i] && !strcmp(regstr[i], name))
+			return i;
+	}
+	return -ENOENT;
+}
+
+int __get_csky_regnum(const char *name, unsigned int flags)
+{
+	if (flags & EF_CSKY_ABIV2)
+		return __get_dwarf_regnum(csky_dwarf_regs_table_abiv2, CSKY_ABIV2_MAX_REGS, name);
+
+	return __get_dwarf_regnum(csky_dwarf_regs_table_abiv1, CSKY_ABIV1_MAX_REGS, name);
+}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 1f7d892612df..dffa0c8bdd14 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -27,11 +27,11 @@
 #include "../arch/mips/include/dwarf-regs-table.h"
 #include "../arch/loongarch/include/dwarf-regs-table.h"
 
-#define __get_dwarf_regstr(tbl, n) (((n) < ARRAY_SIZE(tbl)) ? (tbl)[(n)] : NULL)
-
 /* Return architecture dependent register string (for kprobe-tracer) */
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags)
 {
+	#define __get_dwarf_regstr(tbl, n) (((n) < ARRAY_SIZE(tbl)) ? (tbl)[(n)] : NULL)
+
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -46,7 +46,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 	case EM_AARCH64:
 		return __get_dwarf_regstr(aarch64_regstr_tbl, n);
 	case EM_CSKY:
-		return get_csky_regstr(n, flags);
+		return __get_csky_regstr(n, flags);
 	case EM_SH:
 		return __get_dwarf_regstr(sh_regstr_tbl, n);
 	case EM_S390:
@@ -69,15 +69,28 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 		pr_err("ELF MACHINE %x is not supported.\n", machine);
 	}
 	return NULL;
+
+	#undef __get_dwarf_regstr
+}
+
+static int __get_dwarf_regnum(const char *const *regstr, size_t num_regstr, const char *name)
+{
+	for (size_t i = 0; i < num_regstr; i++) {
+		if (regstr[i] && !strcmp(regstr[i], name))
+			return i;
+	}
+	return -ENOENT;
 }
 
 /* Return DWARF register number from architecture register name */
-int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags __maybe_unused)
+int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags)
 {
 	char *regname = strdup(name);
 	int reg = -1;
 	char *p;
 
+	#define _get_dwarf_regnum(tbl, name) __get_dwarf_regnum(tbl, ARRAY_SIZE(tbl), name)
+
 	if (regname == NULL)
 		return -EINVAL;
 
@@ -97,11 +110,48 @@ int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags
 	case EM_386:
 		reg = __get_dwarf_regnum_i386(name);
 		break;
+	case EM_ARM:
+		reg = _get_dwarf_regnum(arm_regstr_tbl, name);
+		break;
+	case EM_AARCH64:
+		reg = _get_dwarf_regnum(aarch64_regstr_tbl, name);
+		break;
+	case EM_CSKY:
+		reg = __get_csky_regnum(name, flags);
+		break;
+	case EM_SH:
+		reg = _get_dwarf_regnum(sh_regstr_tbl, name);
+		break;
+	case EM_S390:
+		reg = _get_dwarf_regnum(s390_regstr_tbl, name);
+		break;
+	case EM_PPC:
+	case EM_PPC64:
+		reg = _get_dwarf_regnum(powerpc_regstr_tbl, name);
+		break;
+	case EM_RISCV:
+		reg = _get_dwarf_regnum(riscv_regstr_tbl, name);
+		break;
+	case EM_SPARC:
+	case EM_SPARCV9:
+		reg = _get_dwarf_regnum(sparc_regstr_tbl, name);
+		break;
+	case EM_XTENSA:
+		reg = _get_dwarf_regnum(xtensa_regstr_tbl, name);
+		break;
+	case EM_MIPS:
+		reg = _get_dwarf_regnum(mips_regstr_tbl, name);
+		break;
+	case EM_LOONGARCH:
+		reg = _get_dwarf_regnum(loongarch_regstr_tbl, name);
+		break;
 	default:
 		pr_err("ELF MACHINE %x is not supported.\n", machine);
 	}
 	free(regname);
 	return reg;
+
+	#undef _get_dwarf_regnum
 }
 
 static int get_libdw_frame_nregs(unsigned int machine, unsigned int flags __maybe_unused)
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 00881f1d45d6..a120c97a5fac 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -89,8 +89,6 @@
 #define DWARF_REG_FB  0xd3affb /* random number */
 
 #ifdef HAVE_LIBDW_SUPPORT
-const char *get_csky_regstr(unsigned int n, unsigned int flags);
-
 /**
  * get_dwarf_regstr() - Returns ftrace register string from DWARF regnum.
  * @n: DWARF register number.
@@ -99,6 +97,9 @@ const char *get_csky_regstr(unsigned int n, unsigned int flags);
  */
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags);
 
+const char *__get_csky_regstr(unsigned int n, unsigned int flags);
+int __get_csky_regnum(const char *name, unsigned int flags);
+
 int __get_dwarf_regnum_i386(const char *name);
 int __get_dwarf_regnum_x86_64(const char *name);
 int __get_dwarf_regnum_for_perf_regnum_i386(int perf_regnum);
-- 
2.52.0.457.g6b5491de43-goog


