Return-Path: <linux-csky+bounces-1277-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A989C2863
	for <lists+linux-csky@lfdr.de>; Sat,  9 Nov 2024 00:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37B4F2870DE
	for <lists+linux-csky@lfdr.de>; Fri,  8 Nov 2024 23:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C27921E138;
	Fri,  8 Nov 2024 23:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HocLfHH6"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D198F21E12C
	for <linux-csky@vger.kernel.org>; Fri,  8 Nov 2024 23:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109617; cv=none; b=guZ6BLlyRiJmvqARcaY+Ayahe2qYNn8npwVJEpUtZyLIETOesGtTj/LgrLxqYJErzhUxjiYyEWtwsBmrZovKrw9enSTnKBT7u6ysVmT1WpYxsNJnahGGjR0Db1wdC5hJWSnN6wRIAw4ScjVx/AQofJuKOG0byDAHesfPTAzVucM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109617; c=relaxed/simple;
	bh=HRonAENCmnFIC3hFc0WXj7tfPfqpB1ytutxm11waHvc=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lP89PUMqla1DnsEg7s2qyY6BW4W4J0vA2tvTYD4otLJNppWlC4t6wElKtluc8gf9+UIievkoEhf2s7WpVf1S0s+2QU2dVA3eFiP79zc5x6E3zTfkLJgnzbY476bdOJf21a/hPoHasUp/3ABWnO9DRxK6qGyxuDk2NidmUewZ0Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HocLfHH6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29142c79d6so4139611276.3
        for <linux-csky@vger.kernel.org>; Fri, 08 Nov 2024 15:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109615; x=1731714415; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mQRPvLF54EMjS0fZBHCrPGIISSwDJSkkZI6lor/m+jQ=;
        b=HocLfHH6MYrWRbWD39o/T9ofpW+yTexjDDkgYvi6Gz8tY6qJqNiFL4ACxMtT3ctrw7
         kOmMmelDIyluJHZjE8y3qHJgV1Y0OxfwX+i0MpmvASDwCLhDL/y3N81c2WAEg5oWhFwU
         0hNDA7WmRhYf27hBr4ZJPbChHijiF3g+vVE6KSBfBHXvMwDiInQ7ohEQ1BOw+AWlUs/v
         bcTzcampy0fSnRVPUSwEIHBAxbzl348QsxV9fldYmyF7L9TiLZ02XHgLpH2IPFzUENTh
         brfWO+GqX/LZBdAG4XL9k6XdAvYmIFM9Bgjng3LvgwYCC6ZSB/X5Mo+7+gd0l0BdDR6X
         2Smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109615; x=1731714415;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mQRPvLF54EMjS0fZBHCrPGIISSwDJSkkZI6lor/m+jQ=;
        b=lkaEX5ENCDHUlraTUuc8zMnEz+jKR9znzGlIlRrtiDkmzYYq9fj0dfmPDOvsaGKrr5
         D9mzAT1l0npoq5iBy7aFbrMwXEZ1Fm+ZLmyK7scXTNzktEtn1ZdYqdAq3rMNyUZFNP5S
         XIW5bVr8ILszPtzfHLvyMuDuUM3GeIHGSo2+MMHoqHrLza925fUB3PNR0ikIkW3FIjJm
         UmYSgoMiZeWLOzOZXAfdLzUfNtdlo5OILR18S3L/C1NDnd7fMgZ40tVYIniMbOMAHgLv
         eJyJNDVAFR7ax6XC+xnupidccgGJGSS8mJygqaqx0V7UEuiT5knr1sbC2J5mQ3TQa3dH
         Jbwg==
X-Forwarded-Encrypted: i=1; AJvYcCVdluPmZG/f3C9sEdaAQuW4xyFXd8tn2NWpXu9I8DTUuMKO9t+k+o4898RUvYthM2ak9yJO3LIUZgMf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8oc/vY8PJPCtBWB4xndkpj6lpXc1iH/K//zavz8PFmjtDOETZ
	x4r129AVUVuaSGHlEggpCCwTpFgJYO+iohM617ixy0Zjz207qerSnrv30WizyO1oMnadn6DFhTx
	3PpTgUQ==
X-Google-Smtp-Source: AGHT+IGsk9VYrw3QfDO3eDsFvs4Q9nFhi7SGEsHvVXxeM2FcQ1VTtH8rj7jQkOX7hcCXvoTVKKB7//tdZThy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:a289:0:b0:e33:9110:27fd with SMTP id
 3f1490d57ef6-e33911028b7mr868276.9.1731109614446; Fri, 08 Nov 2024 15:46:54
 -0800 (PST)
Date: Fri,  8 Nov 2024 15:46:04 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-20-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 19/20] perf dwarf-regs: Remove get_arch_regstr code
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

get_arch_regstr no longer exists so remove declaration. Associated ifs
and switches are made unconditional.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dwarf-regs.c         | 12 ------------
 tools/perf/util/include/dwarf-regs.h |  7 -------
 2 files changed, 19 deletions(-)

diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 05fff75a8f59..28a1cfdf26d4 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -32,23 +32,11 @@
 /* Return architecture dependent register string (for kprobe-tracer) */
 const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags)
 {
-#if EM_HOST == EM_X86_64 || EM_HOST == EM_386 || EM_HOST == EM_AARCH64 || EM_HOST == EM_ARM \
-    || EM_HOST == EM_CSKY || EM_HOST == EM_LOONGARCH || EM_HOST == EM_MIPS || EM_HOST == EM_PPC \
-    || EM_HOST == EM_PPC64 || EM_HOST == EM_RISCV || EM_HOST == EM_S390 || EM_HOST == EM_SH \
-    || EM_HOST == EM_SPARC || EM_HOST == EM_SPARCV9 || EM_HOST == EM_XTENSA
 	if (machine == EM_NONE) {
 		/* Generic arch - use host arch */
 		machine = EM_HOST;
 	}
-#endif
 	switch (machine) {
-#if EM_HOST != EM_X86_64 && EM_HOST != EM_386 && EM_HOST != EM_AARCH64 && EM_HOST != EM_ARM \
-    && EM_HOST != EM_CSKY && EM_HOST != EM_LOONGARCH && EM_HOST != EM_MIPS && EM_HOST != EM_PPC \
-    && EM_HOST != EM_PPC64 && EM_HOST != EM_RISCV && EM_HOST != EM_S390 && EM_HOST != EM_SH \
-    && EM_HOST != EM_SPARC && EM_HOST != EM_SPARCV9 && EM_HOST != EM_XTENSA
-	case EM_NONE:	/* Generic arch - use host arch */
-		return get_arch_regstr(n);
-#endif
 	case EM_386:
 		return __get_dwarf_regstr(x86_32_regstr_tbl, n);
 	case EM_X86_64:
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index e0f1d65895f5..6f1b9f6b2466 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -89,13 +89,6 @@
 #define DWARF_REG_FB  0xd3affb /* random number */
 
 #ifdef HAVE_LIBDW_SUPPORT
-#if !defined(__x86_64__) && !defined(__i386__) && !defined(__aarch64__) && !defined(__arm__) \
-    && !defined(__loongarch__) && !defined(__mips__) && !defined(__powerpc__) \
-    && !defined(__powerpc64__) && !defined(__riscv__) && !defined(__s390x__) && !defined(__sh__) \
-    && !defined(__sparc64__) && !defined(__sparc__) && !defined(__xtensa__)
-const char *get_arch_regstr(unsigned int n);
-#endif
-
 const char *get_csky_regstr(unsigned int n, unsigned int flags);
 
 /**
-- 
2.47.0.277.g8800431eea-goog


