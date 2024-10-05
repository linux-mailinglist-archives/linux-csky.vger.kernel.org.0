Return-Path: <linux-csky+bounces-944-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C31991A37
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 21:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 426FF1F234EE
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 19:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD27317838D;
	Sat,  5 Oct 2024 19:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KAjMUXh7"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CA3176FA5
	for <linux-csky@vger.kernel.org>; Sat,  5 Oct 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158178; cv=none; b=ixA4KOdR06FuvWqAaU9ASU1YeDsf49U4klgVqgOB/rGwgCfDtNh0SzgF5SM8M7NU1cRV1KQEvIc7B3ihr98SZUD11nz3vBB9YIzoYN6xz46Chzot1xSxUHIm4Aoz7hwyvpv+gpZmYacP5tAp8vMNp8zKIFt7znb/1ilN77XBShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158178; c=relaxed/simple;
	bh=Xn0CrDm+Tw2JEX1Fd/tJd9qqM7XBvfBAuJD2KkaHeq4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=iJ9+7EGJKDEExclOXECjYOJwHP3ebCnytzLJPFSO3dcdwcKz4JuTA+LdXl8+RwHRSyooeQ/xE9nzd1VjBeqFhTDDZMH+UT9W8yf7e92Fn3mWTL6LmPE3ddHiCmaigJjZauKwEQYTX1Huhc6Kfb11tohqbwJ985rOf20LKtR1PDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KAjMUXh7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e28d223794so55654377b3.0
        for <linux-csky@vger.kernel.org>; Sat, 05 Oct 2024 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158176; x=1728762976; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fgt0lsBTAjEFCZBom0GI4KzA9aiVHAzByTiPs2bLNH0=;
        b=KAjMUXh7RUmrU8Ivq6pyXGAJjM16RkHxyJxX5K1nharLKPCg8JqZuxeLjaJlCapsAT
         FcMVZJNKfdZVjMdulY1gN4wSAxRdEOrr/KvA8VjKiE15lnfomZy0p8q/oTCv5YqnudeZ
         JHs3QjtbW3XXxIzHpKEgpkE+OmiLZFLamotN5JZWQEt1GWgmjDxh0QN9kF7HsEqy/JnT
         Wcxb/JhRgFKXR3fwtN2InTbX86fb77iMEtv+1Bgk+Ek3rDGitBbJ+GU61VRe+HZ0iOKT
         3SSiVCvjL99yxFHfo+QSB97wwK92BIAIdE1SwIlvX/dusvL0XFFDmu9MhjgeqgCNKm6H
         /rqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158176; x=1728762976;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fgt0lsBTAjEFCZBom0GI4KzA9aiVHAzByTiPs2bLNH0=;
        b=jSNSBcP5NOcW/QxzuL6C27ZtF5eThv/g+TWtR5lCenLa2DuxSv1jtjov/23qfTaaCk
         rd9E+gcDDRHQ9QSuCs01yPiRCgqj1nfNAnizQ7lEeI+eZKylPXSOkwlnyOF5HFjns9Ad
         Z097751mhi77rmZBUuu2V822xJ6MXSN7OEL0452tvu3Ih4rcCM88V50WROeOQBb3Sjh1
         9NyBtkM/B1Kuoeo2Hco40vv09JMomz8IUVPENTafG/rxr1ksuRm+j4XtaQUiHbOP5l/S
         QQvu3sm4heL3JPvX+55YvXR0XTj25+Rxr32fzGMqKBxiJBpunHDfV7E6c0GeesQruYsR
         GVWA==
X-Forwarded-Encrypted: i=1; AJvYcCXGRDVHUPc0USktrW0pqKWcKda7rTetldg8JL0Ed/fwaSEN7lmBxFknL5fUiRoU9hmRgBVjsL6K0/+g@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6Z/4HeSfV2CYRN4riX99tPiO8UNa2AX5NbULlcZ9iZ9x16Ryg
	ndThWLXDJRKIcE/H9c3skogIpcCMpdkjkNYfCymEB1TUtOXsaLUvxEMCSq8sFzEtQfF43tiQmdL
	dmIYiIw==
X-Google-Smtp-Source: AGHT+IFA6H6s3G571F/veS3qfEggY+9ZaK9DeEUkrcK8nWDGOpnAk500UyqK+1gwSyAo/S2IwW08+pvNJZfj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a81:ad1a:0:b0:62d:1142:83a5 with SMTP id
 00721157ae682-6e2c72a6f27mr784467b3.8.1728158176294; Sat, 05 Oct 2024
 12:56:16 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:18 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 08/31] perf probe: Move elfutils support check to libdw check
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
index 78f34fa0c391..7434b38596b9 100644
--- a/tools/perf/util/probe-finder.c
+++ b/tools/perf/util/probe-finder.c
@@ -1379,10 +1379,8 @@ int debuginfo__find_trace_events(struct debuginfo *dbg,
 	if (ret >= 0 && tf.pf.skip_empty_arg)
 		ret = fill_empty_trace_arg(pev, tf.tevs, tf.ntevs);
 
-#if _ELFUTILS_PREREQ(0, 142)
 	dwarf_cfi_end(tf.pf.cfi_eh);
 	dwarf_cfi_end(tf.pf.cfi_dbg);
-#endif
 
 	if (ret < 0 || tf.ntevs == 0) {
 		for (i = 0; i < tf.ntevs; i++)
diff --git a/tools/perf/util/probe-finder.h b/tools/perf/util/probe-finder.h
index 3add5ff516e1..f0149d72310c 100644
--- a/tools/perf/util/probe-finder.h
+++ b/tools/perf/util/probe-finder.h
@@ -63,12 +63,10 @@ struct probe_finder {
 	struct intlist		*lcache;	/* Line cache for lazy match */
 
 	/* For variable searching */
-#if _ELFUTILS_PREREQ(0, 142)
 	/* Call Frame Information from .eh_frame */
 	Dwarf_CFI		*cfi_eh;
 	/* Call Frame Information from .debug_frame */
 	Dwarf_CFI		*cfi_dbg;
-#endif
 	Dwarf_Op		*fb_ops;	/* Frame base attribute */
 	unsigned int		machine;	/* Target machine arch */
 	struct perf_probe_arg	*pvar;		/* Current target variable */
-- 
2.47.0.rc0.187.ge670bccf7e-goog


