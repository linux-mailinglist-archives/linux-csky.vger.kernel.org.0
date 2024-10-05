Return-Path: <linux-csky+bounces-959-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C5289991A56
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 22:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2611FB23647
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 20:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542831898EB;
	Sat,  5 Oct 2024 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OMzn+J0q"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA00188907
	for <linux-csky@vger.kernel.org>; Sat,  5 Oct 2024 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158212; cv=none; b=hHS2ACPaZwyafNtU6uaPieAk1n+d/HCjPZXb0ABaGHok8obq6lqDqixPLg3lvRI4pqKRWm2uY01Ev6E4hulYOhNR1zFHtbeWM5VZ27V47vHi+gd0nSYHlB+anc7GUbRrrsWdhB1cDWvgj//xVAtArcxqTvTxTDaVCwFMUhIubJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158212; c=relaxed/simple;
	bh=LW71KAwfTi6eG9vq9n5agNT7JJAELLoTx+H3DXkGY6c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mFtL7gPPDYL3kvqO1feraO3pMLvTNBH1/PjNXipTELcwbK5GpuLLjzINoKzu0eRH42PAKYFoIeJsd8GmlPOzhel+b18G5ND3Fys2Nvf5r+p+pRqCrAMVShAPAKP//83CEkLOsWyFfw2hrc2kEG3jHBq5ks48UKy84VF8NdaWI2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OMzn+J0q; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e22f0be237so59585717b3.1
        for <linux-csky@vger.kernel.org>; Sat, 05 Oct 2024 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158209; x=1728763009; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3UNBBKLriPYWF4cbzt+fW/Yb0JAtoFXD8tWOi1OErdE=;
        b=OMzn+J0qTZi8dE2s3Ulg4JUM+T9JBVX43Mmp7+6bCQ+uI8KBJ88jajZObioY6p8NNf
         vs2wFp0abGvOg3HVzLywlWOoVt4dOxSp4c7fQzft8p6bb5122imTeA1wGqg68Vg7+pJA
         KzXxECTKmT1d0Nlz8xTfPYLNyqd2mpPNCgtv944k7bEfmow4PFgqFMiL2iqS5cCqj0tu
         Wmz4peHW48ryCa+2tPFAxCTAUsVwZF15iWeVETzDtAahqjs/Dc5e9JdExq2xgYHK2t4g
         2hwYUh9slcvdNDKfM9ySnP7Vu02ZpN5e/PkkB0/yRYl1nfleKN8Mf59SvuLIrBC2AkUx
         Nb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158209; x=1728763009;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3UNBBKLriPYWF4cbzt+fW/Yb0JAtoFXD8tWOi1OErdE=;
        b=QFGeBUWPJ2Pag0nqnEei+HCqPNNerdS1PS1X1BUzR8ayJHu+IFXsrZWMFawi2SFp0H
         jKADrf7rhJZRoiU7VVttEml6HfotYCCbucCLj0wUk6fGZZIAFBR1DjzJRqCiAN1MT0fD
         tRQzKQXNb6smaB6EYzoXykxdKVcR/dMtjUe/GXLClS7V55fbrTWtg5fmdsfQTJ+/cbWX
         kaLiuDuqKcwUL5/oMR/XqExnQqHMw/ZFbWdFjE5JGwb4kbtnrnQF4uKy6gG66UqA0HUK
         AfcBKFcJP0I5v62xRDktVzCuevHlTNwUuy0YDF/IEshYzoimca+cr7volt9kd5TIYcX9
         trlg==
X-Forwarded-Encrypted: i=1; AJvYcCUu0A7LurOlDjVajXa3wtJUQh74wMwXsOS091f9NUfZRnhCtD3E5JbxENT7x+PT4eeCWqejzNGmAlzY@vger.kernel.org
X-Gm-Message-State: AOJu0YwTIYkvYEstuMi87dRjnQ8pAbpebuPWs7kaSSywWu3xghPwsksd
	sl1Q17/HlZMoX/1y+OsPafEiAdOqVmrq3ywneeBddWn42SkTMntwX6xlYbtcc5kz0wkyrj+dod6
	6gTatJw==
X-Google-Smtp-Source: AGHT+IGd8n4duwoirMvSpqfOv40zKZGdVHyzgM8WiLhDFeOCNQk3EZ65qgcXqmWv7lPgqHaXqfVgKLepfmDX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a05:690c:2b8e:b0:6dd:d138:d823 with SMTP
 id 00721157ae682-6e2c72adbdamr920857b3.8.1728158209657; Sat, 05 Oct 2024
 12:56:49 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:33 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-24-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 23/31] perf mips: Remove dwarf-regs.c
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
the function can never be called. So remove as dead code. Tidy up the
EM_NONE cases for mips in dwarf-regs.c.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/arch/mips/util/Build        |  1 -
 tools/perf/arch/mips/util/dwarf-regs.c | 38 --------------------------
 tools/perf/util/dwarf-regs.c           |  4 +--
 tools/perf/util/include/dwarf-regs.h   |  2 +-
 4 files changed, 3 insertions(+), 42 deletions(-)
 delete mode 100644 tools/perf/arch/mips/util/dwarf-regs.c

diff --git a/tools/perf/arch/mips/util/Build b/tools/perf/arch/mips/util/Build
index b328109fc16c..691fa2051958 100644
--- a/tools/perf/arch/mips/util/Build
+++ b/tools/perf/arch/mips/util/Build
@@ -1,3 +1,2 @@
 perf-util-y += perf_regs.o
-perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
diff --git a/tools/perf/arch/mips/util/dwarf-regs.c b/tools/perf/arch/mips/util/dwarf-regs.c
deleted file mode 100644
index 25c13a91c2a7..000000000000
--- a/tools/perf/arch/mips/util/dwarf-regs.c
+++ /dev/null
@@ -1,38 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * dwarf-regs.c : Mapping of DWARF debug register numbers into register names.
- *
- * Copyright (C) 2013 Cavium, Inc.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- */
-
-#include <stdio.h>
-#include <dwarf-regs.h>
-
-static const char *mips_gpr_names[32] = {
-	"$0", "$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8", "$9",
-	"$10", "$11", "$12", "$13", "$14", "$15", "$16", "$17", "$18", "$19",
-	"$20", "$21", "$22", "$23", "$24", "$25", "$26", "$27", "$28", "$29",
-	"$30", "$31"
-};
-
-const char *get_arch_regstr(unsigned int n)
-{
-	if (n < 32)
-		return mips_gpr_names[n];
-	if (n == 64)
-		return "hi";
-	if (n == 65)
-		return "lo";
-	return NULL;
-}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index efc41d0fbee9..d536964df43c 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -32,7 +32,7 @@
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags)
 {
 #if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
-    || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH
+    || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
@@ -40,7 +40,7 @@ const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int
 #endif
 	switch (machine) {
 #if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
-    && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH
+    && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS
 	case EM_NONE:	/* Generic arch - use host arch */
 		return get_arch_regstr(n);
 #endif
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 4f205a58db89..1f771b635789 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -80,7 +80,7 @@
 
 #ifdef HAVE_LIBDW_SUPPORT
 #if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
-    && !defined(__loongarch__)
+    && !defined(__loongarch__) && !defined(__mips__)
 const char *get_arch_regstr(unsigned int n);
 #endif
 
-- 
2.47.0.rc0.187.ge670bccf7e-goog


