Return-Path: <linux-csky+bounces-1130-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F7FE9A16AB
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 02:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F668283B03
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 00:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DA11E535;
	Thu, 17 Oct 2024 00:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mv3jf5ah"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9F2249E5
	for <linux-csky@vger.kernel.org>; Thu, 17 Oct 2024 00:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124065; cv=none; b=FRksoyDLacwnUaYXL4JOl/yJU0OGO8XvN8hXnN7PAqZadrcR2NGewG6M7pbHOrY6i59Tw/pqr0QrERVAcHqn8fFgjG7kZO8SI3xWd5Dvv8k8mcaSmiscIxFBfZ5qM9l+ZQ2X24t5W+wkJrMyF5CnSf/1hcGXopryV4B1ws6DsUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124065; c=relaxed/simple;
	bh=KskvT3pCaHipMk1dH7NqUoJymZdrkHzaAu51i8pSk7k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=kR6vCvOp8dr/Hi5gyEBnmNUewSKI9jn/1mAgmanI7x0YO8Ns5fhftKqkvES5XEUr8S/reptltYt/NKYUKeJFfQ4t5Px2xpdIn4qlizazj89e3D92V+7xlVJkAi/Y/AmeKU4iS1y29QW3nO5FTWvgh9mpbHE8o6G1nNeVr2fn1H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mv3jf5ah; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e2974759f5fso512137276.0
        for <linux-csky@vger.kernel.org>; Wed, 16 Oct 2024 17:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124062; x=1729728862; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VU9D23fFMOa9LXkPnFVSmMuH/zksDMncppJ/JVZzd4k=;
        b=mv3jf5ah8b3/J5Pbu+z0coMxbs7x2epIluTKZxp4EmWx+99Ca9/S79g21xd6arLTNL
         pzzXjSjMlbmD/QgXfy1rrbE+IDML2Z2AF44z6hIr4A9hA75s3CjseFhSPq+4EUIzSMBu
         2egf3ViQemL+4XiUeImr+zvrtJ9Ef1MAr+Feko6SA6Ue5ozaluLaGFclX4uxjHW571Ov
         NTPQJf/PCst5PlYfMCOP7/RtOap5HXYt1vNL5ivvqFb92Yh6WSuuQgQmSYWRB5Fu8Xqf
         DH5pv9kTeDSLoIsrMyHNS5x05QEUUpUSR5dplvzja0OZ+1FkYS2cilbvjyAnh1G8c1St
         /8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124062; x=1729728862;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VU9D23fFMOa9LXkPnFVSmMuH/zksDMncppJ/JVZzd4k=;
        b=Hij40Glh+/MvBDOwcB1jM3jlbrqTcdw7OgN8n8VEz+azkYcyI6U1YgR8QuATDL0n7L
         YvQMioeJ3am0WohNQTIJsSxCtsHHyCGDUnnR3OdzLdqp8a/ODqoNwrgpapeHzb28R0sW
         IG4J1vrm2I0HLlXGdF2Nt9PL6h+szn0JtfkxsnuACkmihBIjraiX8EgBVbHqpdTkQGj4
         +21Vr74guBbypCT46lBZDyAxzvDvl127Jhv9B+nu9LqfSSfs5JkFvfjTzhK5boMqs6FM
         qQYy7jjkOkVuwtt5Mes2pcmi5in5y1NWphlDG59gq3+RHdUNMJpsm4TBOgF62BGVWK0/
         FUjw==
X-Forwarded-Encrypted: i=1; AJvYcCU+kof0q/ldWop0rY3tZBdL2uoZZo0OvtmeKR/SSx6h2bNQAnid5cnFnoLwDXX42lZdCr35kE/ryZNj@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1q8BO+ilxbYGWOmMOOR7It4FKggO1OHJFZCo/4/mp7L/YAsp2
	a3GsBqXuWjqRZ9R3jofIKbwwS6s3PcwcqDZdctw4AyoQJmjtinW09ZVhc5SguL/m2RKqVMKEu5E
	kLkL4aA==
X-Google-Smtp-Source: AGHT+IFAHdFpfyYHAxh33deC15C0o4iPWMQpiNWeQk6y+OhOBawQMGHjEN4HBQ/OuO3SGFQn1AE+qnHXoGYY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:6902:d47:b0:e29:7587:66d6 with SMTP id
 3f1490d57ef6-e2b9ce7583cmr2127276.4.1729124062376; Wed, 16 Oct 2024 17:14:22
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:13:51 -0700
In-Reply-To: <20241017001354.56973-1-irogers@google.com>
Message-Id: <20241017001354.56973-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017001354.56973-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 08/11] perf probe: Move elfutils support check to libdw check
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

The test _ELFUTILS_PREREQ(0, 142) is false for elfutils before
2009-06-13, but that is 15 years ago and very unlikely. Add a test to
test-libdw.c and assume the libdw version is at least 0.142 to
simplify the build logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/test-libdw.c | 10 +++++++++-
 tools/perf/util/probe-finder.c   |  2 --
 tools/perf/util/probe-finder.h   |  2 --
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
index 71c6f8e3b0ee..2fb59479ab77 100644
--- a/tools/build/feature/test-libdw.c
+++ b/tools/build/feature/test-libdw.c
@@ -41,8 +41,16 @@ int test_libdw_getcfi(void)
 	return dwarf_getcfi(dwarf) == NULL;
 }
 
+int test_elfutils(void)
+{
+	Dwarf_CFI *cfi = NULL;
+
+	dwarf_cfi_end(cfi);
+	return 0;
+}
+
 int main(void)
 {
 	return test_libdw() + test_libdw_unwind() + test_libdw_getlocations() +
-	       test_libdw_getcfi();
+	       test_libdw_getcfi() + test_elfutils();
 }
diff --git a/tools/perf/util/probe-finder.c b/tools/perf/util/probe-finder.c
index d6b902899940..b6775d3bdeac 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1379,9 +1379,7 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
 	if (ret >= 0 && tf.pf.skip_empty_arg)
 		ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
 
-#if _ELFUTILS_PREREQ(0, 142)
 	dwarf_cfi_end(tf.pf.cfi_eh);
-#endif
 
 	if (ret < 0 || tf.ntevs == 0) {
 		for (i = 0; i < tf.ntevs; i++)
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index 724db829b49e..5ced3b058fd8 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -63,12 +63,10 @@ struct probe_finder {
 	struct intlist		*lcache;	/* Line cache for lazy match */
 
 	/* For variable searching */
-#if _ELFUTILS_PREREQ(0, 142)
 	/* Call Frame Information from .eh_frame. Owned by this struct. */
 	Dwarf_CFI		*cfi_eh;
 	/* Call Frame Information from .debug_frame. Not owned. */
 	Dwarf_CFI		*cfi_dbg;
-#endif
 	Dwarf_Op		*fb_ops;	/* Frame base attribute */
 	unsigned int		machine;	/* Target machine arch */
 	struct perf_probe_arg	*pvar;		/* Current target variable */
-- 
2.47.0.105.g07ac214952-goog


