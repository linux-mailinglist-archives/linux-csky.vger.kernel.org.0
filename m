Return-Path: <linux-csky+bounces-1140-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB6199A16FB
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 02:27:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EFE7B25B8C
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 00:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459C64779D;
	Thu, 17 Oct 2024 00:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H9qiTCx+"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4E3A1B5
	for <linux-csky@vger.kernel.org>; Thu, 17 Oct 2024 00:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124746; cv=none; b=bPbMbWv9tulOJThb8eu1QC0UjBtqZxCQvf5dI3phdso4fUafJiRH6GjlDNvsno3WpWDlVHdfShOD+V1Nt0eeVCCJhIe0D3kl8Wi6Wbf23MYChTPosb3ecL2ryypN0uwk+WhvxUx+cSDeKrjewLvDsJmHco3ledYsgXsMujcCusI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124746; c=relaxed/simple;
	bh=jg0A+EsLd62EFrzbaEEO9QdKw/zYM2mFMhq9eemZy8A=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gC5WTJXIr/PFiNUYFY8QaVAfuKY8+ac81k9wXL6SZxaE0MiB6nL6HC/4WZUQVDgIEWWecCGywJQXM9Gu8uZocIG8N3FYlCcmhLHmdOYHYsPEN4+fgvf4NuPq8wROMD7c3aumBaXwKlNoCBtZN3ezZOpeaXZ0HFTCncrI8X1sxb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H9qiTCx+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2a8355786dso663717276.2
        for <linux-csky@vger.kernel.org>; Wed, 16 Oct 2024 17:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124742; x=1729729542; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=izrYBPhm17udGFGkR4Iwcv4Dc//bGf094GyDIT7L4tU=;
        b=H9qiTCx+CS62mw2fs/L8dWumtiUlOLvNaZi2vksybB9Zea3ic8ncLbRJrOQP+xcnkE
         Whs7hYYQncEZGAF2bU9CwNOjYKjwJMH+VcyrpEkbAqfLv1AQzeiN18JWeYfLmOQbzT9S
         tifpNVZbTJfCBpIErEx7Nj8KwrQGMZldSbiIohrSv+Rbh6Y8Ky6j4CCqmkdzAI0PaNe/
         G00WkRt9yVtUMuGtW39xso+BPDsZme1erbZuVdCk6/9WgujeYtmsbR9vBtBQBVgzzu0d
         aVeG1i1SVgKHDO6MQipN27MZW9R0SzYrJ0Rs+eo19K6LIlTo38j03/Wg60GCrx+VGnc9
         AIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124742; x=1729729542;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=izrYBPhm17udGFGkR4Iwcv4Dc//bGf094GyDIT7L4tU=;
        b=iyQDShX5yWvpZQ6k6rxssc9cgCKPwE4fZCFk1zrh+opxkTRtE+NvaHwu6lVhwyPqip
         pkKPUCHwsuHPZPCyy9/FkfbCOUZ3XLHU1aKZqOm0+5FElug1bgeupQf1nmWbO2f+IH7O
         MvzgICiyd3Wart2TpCYXgY8zyTJeHucy84F3Ywzyaa5xwG7xvPClvbeK2rVtcJBmS3Zb
         jvoBsFlZG/bSB2sFrI99YueMP5lTKK2wkey2FJhosPfeyFLp4IvgDeXEPfOETUYfz3Ix
         Qod6ogGbtKPE4RP2f3w1gKM9F+PC8U9qT+y6wDJNACEDF1tJC+iD6QNYq5yfVcqKjeb2
         4vWA==
X-Forwarded-Encrypted: i=1; AJvYcCVdl20afmdMgaTFL5LRL6zUAIa31lkeMuyBXUZFHhhV2NdOODfvo2JtUFHXVry+Z2rbL724kEveCk8B@vger.kernel.org
X-Gm-Message-State: AOJu0YyOR+s0NbsjWeXxuRzDjzSRaROfXm/9C7h27Ztg6CIZmPEfSCq+
	KSuxgXr53qMxEkTfAMBLxM2CLumwg+rh33tQDrHQfZ0OpE8vGur55LoQPh6XdRY93TK4swZYz5K
	Mpn7vTg==
X-Google-Smtp-Source: AGHT+IGe0qtX+nrFLCMypOG0orC3BMXFb6Kx9df1N+z/dKs05V2ms0PPErMRkoeQh6CQMoXF8+l+PYfUhcwf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:aaa3:0:b0:e20:25f5:a889 with SMTP id
 3f1490d57ef6-e29783030e0mr3217276.5.1729124742291; Wed, 16 Oct 2024 17:25:42
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:06 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 06/20] perf dwarf-regs: Pass ELF flags to get_dwarf_regstr
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

Pass a flags value as architectures like csky need the flags to
determine the ABI variant.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dwarf-regs.c         |  3 ++-
 tools/perf/util/include/dwarf-regs.h | 11 ++++++-----
 tools/perf/util/probe-finder.c       | 13 +++++++------
 tools/perf/util/probe-finder.h       |  3 ++-
 4 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 1321387f6948..86b3ef638fbb 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -29,7 +29,8 @@
 #define __get_dwarf_regstr(tbl, n) (((n) < ARRAY_SIZE(tbl)) ? (tbl)[(n)] : NULL)
 
 /* Return architecture dependent register string (for kprobe-tracer) */
-const char *get_dwarf_regstr(unsigned int n, unsigned int machine)
+const char *get_dwarf_regstr(unsigned int n, unsigned int machine,
+			     unsigned int flags __maybe_unused)
 {
 	switch (machine) {
 	case EM_NONE:	/* Generic arch - use host arch */
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index ee0a734564c7..925525405e2d 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -80,12 +80,13 @@
 
 #ifdef HAVE_LIBDW_SUPPORT
 const char *get_arch_regstr(unsigned int n);
-/*
- * get_dwarf_regstr - Returns ftrace register string from DWARF regnum
- * n: DWARF register number
- * machine: ELF machine signature (EM_*)
+/**
+ * get_dwarf_regstr() - Returns ftrace register string from DWARF regnum.
+ * @n: DWARF register number.
+ * @machine: ELF machine signature (EM_*).
+ * @flags: ELF flags for things like ABI differences.
  */
-const char *get_dwarf_regstr(unsigned int n, unsigned int machine);
+const char *get_dwarf_regstr(unsigned int n, unsigned int machine, unsigned int flags);
 
 int get_arch_regnum(const char *name);
 /*
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index 8ea15a2a4397..8a932cc2f63d 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -56,7 +56,7 @@ static struct probe_trace_arg_ref *alloc_trace_arg_ref(long offs)
  */
 static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 				     Dwarf_Op *fb_ops, Dwarf_Die *sp_die,
-				     unsigned int machine,
+				     const struct probe_finder *pf,
 				     struct probe_trace_arg *tvar)
 {
 	Dwarf_Attribute attr;
@@ -166,7 +166,7 @@ static int convert_variable_location(Dwarf_Die *vr_die, Dwarf_Addr addr,
 	if (!tvar)
 		return ret2;
 
-	regs = get_dwarf_regstr(regn, machine);
+	regs = get_dwarf_regstr(regn, pf->e_machine, pf->e_flags);
 	if (!regs) {
 		/* This should be a bug in DWARF or this tool */
 		pr_warning("Mapping for the register number %u "
@@ -451,7 +451,7 @@ static int convert_variable(Dwarf_Die *vr_die, struct probe_finder *pf)
 		 dwarf_diename(vr_die));
 
 	ret = convert_variable_location(vr_die, pf->addr, pf->fb_ops,
-					&pf->sp_die, pf->machine, pf->tvar);
+					&pf->sp_die, pf, pf->tvar);
 	if (ret == -ENOENT && pf->skip_empty_arg)
 		/* This can be found in other place. skip it */
 		return 0;
@@ -1134,7 +1134,8 @@ static int debuginfo__find_probes(struct debuginfo *dbg,
 	if (gelf_getehdr(elf, &ehdr) == NULL)
 		return -EINVAL;
 
-	pf->machine = ehdr.e_machine;
+	pf->e_machine = ehdr.e_machine;
+	pf->e_flags = ehdr.e_flags;
 
 	do {
 		GElf_Shdr shdr;
@@ -1171,7 +1172,7 @@ static int copy_variables_cb(Dwarf_Die *die_mem, void *data)
 	    (tag == DW_TAG_variable && vf->vars)) {
 		if (convert_variable_location(die_mem, vf->pf->addr,
 					      vf->pf->fb_ops, &pf->sp_die,
-					      pf->machine, NULL) == 0) {
+					      pf, /*tvar=*/NULL) == 0) {
 			vf->args[vf->nargs].var = (char *)dwarf_diename(die_mem);
 			if (vf->args[vf->nargs].var == NULL) {
 				vf->ret = -ENOMEM;
@@ -1402,7 +1403,7 @@ static int collect_variables_cb(Dwarf_Die *die_mem, void *data)
 	    tag == DW_TAG_variable) {
 		ret = convert_variable_location(die_mem, af->pf.addr,
 						af->pf.fb_ops, &af->pf.sp_die,
-						af->pf.machine, NULL);
+						&af->pf, /*tvar=*/NULL);
 		if (ret == 0 || ret == -ERANGE) {
 			int ret2;
 			bool externs = !af->child;
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index dfcf8cdd9e8d..be7b46ea2460 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -68,7 +68,8 @@ struct probe_finder {
 	/* Call Frame Information from .debug_frame. Not owned. */
 	Dwarf_CFI		*cfi_dbg;
 	Dwarf_Op		*fb_ops;	/* Frame base attribute */
-	unsigned int		machine;	/* Target machine arch */
+	unsigned int		e_machine;	/* ELF target machine arch */
+	unsigned int		e_flags;	/* ELF target machine flags */
 	struct perf_probe_arg	*pvar;		/* Current target variable */
 	struct probe_trace_arg	*tvar;		/* Current result variable */
 	bool			skip_empty_arg;	/* Skip non-exist args */
-- 
2.47.0.105.g07ac214952-goog


