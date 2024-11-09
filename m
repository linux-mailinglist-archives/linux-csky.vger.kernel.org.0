Return-Path: <linux-csky+bounces-1263-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A269C2848
	for <lists+linux-csky@lfdr.de>; Sat,  9 Nov 2024 00:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A54E6B22DF4
	for <lists+linux-csky@lfdr.de>; Fri,  8 Nov 2024 23:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF971E0DB2;
	Fri,  8 Nov 2024 23:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4vQSA4Ek"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C361720DD6F
	for <linux-csky@vger.kernel.org>; Fri,  8 Nov 2024 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109584; cv=none; b=UfghKhWu39W/amf9MCo4uBJBc45SyVSBKeG4KbgpHSz9Z0Sw6cLYBSGnRAVMNAn1poyy4fhVOrO/KuH/jlR2QrR3jozMoWo8SXd+IMLNFzrYawpyW91ipEMQJME0Xu9cbKTTAQrmmlPp+jvr6HpEJd9VAwRMgzp64hJYfkY5Nko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109584; c=relaxed/simple;
	bh=UpbEPbsvR+MMP/prNjsuZ9PUWl/4549dj65p4AXiKzk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=PAO7zM3npSrXEWpBYw5MOrx4alIEC3tLD8WjcI8MflAMHLIfxyzSGcRRPzh0cjjrhqLfYl4bKfWZJZs6R7jqX8uJU0ZGZ4y+Ww+8XIOsu8YDXcDGE2j1luYEjrw/rczxZphKjBQaRNF8jIIV08hQQ3Ma7ZRaPUahArUt6AK763o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4vQSA4Ek; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e376aa4586so54942177b3.1
        for <linux-csky@vger.kernel.org>; Fri, 08 Nov 2024 15:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109582; x=1731714382; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AVtWpsuHpFiBnlibbq5HoTF1wljBLHXYozEcDvYWBgA=;
        b=4vQSA4EkVEIJM5AubTw7cfStKPLmDDT9yF38/RsRU1HOp1Qt4QbSTyxFgPASB+HtIT
         0EWD48cEW2ApwaQxRiWVlGDSyZEXdTxMvVTjue+hIv/UMFoS9ADmoD5SLlsYKrRm41Z9
         PaoWoveFNf/5r0RDYCG7k4wzx/4WaxY5Vsw/429P5ppWhNz9/6rPZukOdc7pJ3VPaLiI
         ANa/dkx5TYTzrD/iMp5/SBm/zvcSxXwtYHYVOWWmtV/9Zg1LkAr5Ig+4DpsEyDu4qdZR
         I73mKSNk8qgt4qICj9LbTos1ZZZYVjSS19/yFuG+Hovn6WLOJiSerizvAm3uNdNh1FIs
         hlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109582; x=1731714382;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AVtWpsuHpFiBnlibbq5HoTF1wljBLHXYozEcDvYWBgA=;
        b=NE/2kj3lj1KewTrVeYnxydYqCQMPe1gd52gPAB+i6qZ1tMPyWx5b+4ZJuxEuw1geCm
         CF9e4ifbz6TvSJjLdZop9tCD32Z9PgoGNJA8FRibIBlEObXiR1F04yj/zvm5c2etiNCU
         A5IUn6T4VLVCSl1PyIwabjcxLmcFSAGXm/8WmSuTR///2LvCSSxkXbCEt6GKXxmbeecQ
         QJEjo33zWEhSoQiVCR1vBw1hkaXbK6GkwcOb4K2XcQ7iKQRsNj6Fq0dLVwwg+5drAnnH
         0/qkKc9VJf0a3tZQ1TJaA0jrURUBTlY0/EKzEpyhSWdyFsFRNB4b2oPKaqwqjuPNvV58
         scEA==
X-Forwarded-Encrypted: i=1; AJvYcCWDSmY/RJKJsLe030/Co0Rx6OWXcU6FYDAiDb28jIc+QFh+WL2tWOlnKvCbOXmmPMCJUoGfBZPzUY/8@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+WbOA1BWv6y+9kGZ1Kto13IcdFcsTX1fdsy8Pc9miT5IA2PMd
	SAAHRcbDTOso3pk4XTm4QAY0wjo1ryJxdmWu4Zb3akCdoIwQJRLpIv5GD5dZ4P9xBBz4gYB3MGQ
	UyiUz3Q==
X-Google-Smtp-Source: AGHT+IFq1UuJ7hc/ApetK/H2sFL5m2uMATjY+fqFwJq/WDc5NUWTV7ClaOKOd64kgsF/WFeRan59owDlPrau
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a25:84c9:0:b0:e33:111b:c6a4 with SMTP id
 3f1490d57ef6-e337f81b835mr3397276.1.1731109581785; Fri, 08 Nov 2024 15:46:21
 -0800 (PST)
Date: Fri,  8 Nov 2024 15:45:50 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 05/20] perf dwarf-regs: Pass accurate disassembly machine
 to get_dwarf_regnum
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

Rather than pass 0/EM_NONE, use the value computed in the disasm
struct arch. Switch the EM_NONE case to EM_HOST, rewriting EM_NONE if
it were passed to get_dwarf_regnum. Pass a flags value as
architectures like csky need the flags to determine the ABI variant.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c           | 6 +++---
 tools/perf/util/dwarf-regs.c         | 8 ++++++--
 tools/perf/util/include/dwarf-regs.h | 5 +++--
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 37ce43c4eb8f..b1d98da79be8 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2292,7 +2292,7 @@ static int extract_reg_offset(struct arch *arch, const char *str,
 	if (regname == NULL)
 		return -1;
 
-	op_loc->reg1 = get_dwarf_regnum(regname, 0);
+	op_loc->reg1 = get_dwarf_regnum(regname, arch->e_machine, arch->e_flags);
 	free(regname);
 
 	/* Get the second register */
@@ -2305,7 +2305,7 @@ static int extract_reg_offset(struct arch *arch, const char *str,
 		if (regname == NULL)
 			return -1;
 
-		op_loc->reg2 = get_dwarf_regnum(regname, 0);
+		op_loc->reg2 = get_dwarf_regnum(regname, arch->e_machine, arch->e_flags);
 		free(regname);
 	}
 	return 0;
@@ -2405,7 +2405,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 				return -1;
 
 			if (*s == arch->objdump.register_char)
-				op_loc->reg1 = get_dwarf_regnum(s, 0);
+				op_loc->reg1 = get_dwarf_regnum(s, arch->e_machine, arch->e_flags);
 			else if (*s == arch->objdump.imm_char) {
 				op_loc->offset = strtol(s + 1, &p, 0);
 				if (p && p != s + 1)
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 7c01bc4d7e5b..1321387f6948 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -70,7 +70,7 @@ __weak int get_arch_regnum(const char *name __maybe_unused)
 }
 
 /* Return DWARF register number from architecture register name */
-int get_dwarf_regnum(const char *name, unsigned int machine)
+int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags __maybe_unused)
 {
 	char *regname = strdup(name);
 	int reg = -1;
@@ -84,8 +84,12 @@ int get_dwarf_regnum(const char *name, unsigned int machine)
 	if (p)
 		*p = '\0';
 
+	if (machine == EM_NONE) {
+		/* Generic arch - use host arch */
+		machine = EM_HOST;
+	}
 	switch (machine) {
-	case EM_NONE:	/* Generic arch - use host arch */
+	case EM_HOST:
 		reg = get_arch_regnum(regname);
 		break;
 	default:
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index ce9f10b3282d..3c3a908b9f36 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -103,12 +103,13 @@ int get_arch_regnum(const char *name);
  * name: architecture register name
  * machine: ELF machine signature (EM_*)
  */
-int get_dwarf_regnum(const char *name, unsigned int machine);
+int get_dwarf_regnum(const char *name, unsigned int machine, unsigned int flags);
 
 #else /* HAVE_LIBDW_SUPPORT */
 
 static inline int get_dwarf_regnum(const char *name __maybe_unused,
-				   unsigned int machine __maybe_unused)
+				   unsigned int machine __maybe_unused,
+				   unsigned int flags __maybe_unused)
 {
 	return -1;
 }
-- 
2.47.0.277.g8800431eea-goog


