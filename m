Return-Path: <linux-csky+bounces-1150-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3B19A170E
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 02:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36F6BB2363B
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 00:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A92917C9EA;
	Thu, 17 Oct 2024 00:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z9k7MeL+"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880F1179965
	for <linux-csky@vger.kernel.org>; Thu, 17 Oct 2024 00:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124770; cv=none; b=SVIAmqrCUlc6WEqCLgcqK0WhJU2WIN+Nf4lOSBusBtEYDe8JTj+TQiTAwStRJeBr7simmh4o/bA6Y0ddCJnbGV5fWvcqQcvyQ5+OOKErD97xLvJKTR0VimRnSe9grrvX+lx1p0cH4tmb3CrBhRuI5M3iqumt5pvsPyCMNW76G14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124770; c=relaxed/simple;
	bh=SAv92amf90M9xPKiLnVEQ2/ksaT2ewK9Kq/gzzcJmZE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=AhjVoe+a2Qk/xx0jisM7LcCVrHOqOB6QYNfs6iFS7g0bHpBT86wi5i3B0ScClidRUzW3644RTgW9KqPbUJz/k2P9vbVWZo+HEVzA0L426EcECAp7+PBHKsz+XKlWyYA4LSNLTa7I7j0V4SqOQf28X8MmbeT+SIPiqnk5fHj3H9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z9k7MeL+; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e1159159528so2307637276.1
        for <linux-csky@vger.kernel.org>; Wed, 16 Oct 2024 17:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124767; x=1729729567; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IfgOrXuzIi5D9S6tBKQjs6ZaYP759vz/COjt5onTx3c=;
        b=Z9k7MeL+mxU6S4Rm7jjFfkLRkot/wmuR20veFBqoO0oCgC6wXME0Nor6XvTRCwmjUT
         Ojpp86+UiZumky+1qaWieuQMtbOH83+Ra1gI/859sDGNLAHp1lnzB2wme60UztPizzsJ
         xqeZYW9MScMb2+xMvP274mCAo12NhGAeWhzRlmlYI3EciTlMQfyYAe3smGfemO2H0QOi
         Nrbe9h+giRcqPFhh51HXXAla3HdrS9e2rOooGy9papP7ROMXD3+Z0T5wbmzZ80FXIKJF
         msjgHeUzzV6xq1FpFz7fPU/F5j+Wfcn0e20zQQyfSIkveoYvFBAeAHicdcwURB+odJ96
         R9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124767; x=1729729567;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IfgOrXuzIi5D9S6tBKQjs6ZaYP759vz/COjt5onTx3c=;
        b=uSAG1pIE1C7kd1TWOAIIdOVNKPi7Gyqmr85l1pZo8WYJyLgoZNfy22NOYu5T1pJRX3
         mDMYL6wFcHMqHdI/561clHUqL6C8qKtsJxizmYjl7SGg3pgGmsHR+2wleS1Qi4QjSq4g
         K7nPeCV0BSICb8w7HN/m8OD1uG0fqJHCl2/QPvfwvusGX/jzULvSyYsyRZo7UWmzOPh0
         43dhY8yusai/RO00k5Vg17ALYr0u6H1xvPUweIy6DrRt/OoHVvTAHWYr+SgHFnf01X/n
         R+LXIpW2b2u18G/L9SMOT60F5H4afNAkb4gSX/3YEoxtDABLLuxc4vakjNibRWWQPBsy
         Rppw==
X-Forwarded-Encrypted: i=1; AJvYcCUOSTmSXN72kZfVkHkA2HafqDpGKIguUfaM7NDSSiMF374mdunpsQhtVPYvvlHhejqqa1BCbilI5XzF@vger.kernel.org
X-Gm-Message-State: AOJu0YxIDCdAlco37c/A3StP6zgWCc8vPo63FVHWVRoxLp/ZheiUI583
	YDEGeNrF3zpWZ6RbiqrIud986WYTmxH7CgGdcxQ/C8kr6Pxi8ukZNxVf8yoHXIO9xEDdFuBkLcg
	Ile/+bw==
X-Google-Smtp-Source: AGHT+IFt+bqmIASGNbZ3TFisN0iIRghMq2JpjsLpeMTXAlMa2KnLBBPyKnoUzSRzo42bXC3TE8xo0dk3pEWH
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:664c:0:b0:e29:7454:e773 with SMTP id
 3f1490d57ef6-e2b9d02921cmr1392276.5.1729124767112; Wed, 16 Oct 2024 17:26:07
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:16 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-17-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 16/20] perf sh: Remove dwarf-regs.c
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
2.47.0.105.g07ac214952-goog


