Return-Path: <linux-csky+bounces-540-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B71907B70
	for <lists+linux-csky@lfdr.de>; Thu, 13 Jun 2024 20:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1AE31C24364
	for <lists+linux-csky@lfdr.de>; Thu, 13 Jun 2024 18:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD6114EC5E;
	Thu, 13 Jun 2024 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oyKVGp8D"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372B214D716
	for <linux-csky@vger.kernel.org>; Thu, 13 Jun 2024 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303561; cv=none; b=D2hY4hwmhsBYBh1a5qYr4nS9MxIws/Kvff+q4NMc3pJEhTvX3PXaQrnzwWjv6pbk9MC/ilPe5cQ7dI4mAHUZ4Ysro1SdD9QOlKXNAzu8jyD8DIvFDkA4kc6e2DnQlyJXPu2NS7Nrc1yPiXPmIwZ9hSAvNe/ZBr2F6pmJXR6KLDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303561; c=relaxed/simple;
	bh=0n3NWiOLohwJNKVKL9gV3Koesj5loLw/lRVeMyy3BQk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=HODQvy056DkxboKi5503qnQr3yyviK+3ZWnVsMl3yMUR0A+cKDeCm+FpC6CbeFlY//tzZQbTKKBCEy42K6QKxFxOoIeg324GQF3LJWExDVrIVJM6/UFhkOvcUCyD/Xx2eDz/VINRBtUqjkaLCfhti0zK9I4fAp0Q6HucJOo7IKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oyKVGp8D; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfec7058deeso2605514276.2
        for <linux-csky@vger.kernel.org>; Thu, 13 Jun 2024 11:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718303559; x=1718908359; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CxA/uxqQnuEGimdVVLwjMbl2Ju2kVgaw0AA0enSCOv4=;
        b=oyKVGp8DWXSHPF5hvIFJGufsndq098qASZ7CacmHCntT5Ay8fLIDTVFgGuaBVZOMM4
         04GgV/x7aibnJjpgoEXeQkhzgGD/Y+bgI1GOnLP7MaKY2FmJFVQUH0B8URKwcTK63yFx
         5h5z3WUCNpRMWmMIkDSW8hCuZ2cdCF6xXieEoaeRRlbU0aBLtzxnekOTVvF6yWvhdvOd
         V+Dan41yzKQDZDpeVvGspTtClzGW4qjgQzTw//PpjUu5gJmMfvXqEHEGjjWrHY+VSbZS
         Y6zTbr+zdfk0SJIt4Rx8iGykCsiRRZGhFHcNRvPtj/vfr9SY9bsBfHmkKHWrlFj9jhzt
         oqzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718303559; x=1718908359;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CxA/uxqQnuEGimdVVLwjMbl2Ju2kVgaw0AA0enSCOv4=;
        b=YXNDHP8PS+FETm0ahHDLoNGdjgBmrbOxy5GjUUwAHZAoz4qIDtA8WLbjmXjN2HYnMI
         6FiVl56Fatv9XBRvkgXNCwwZUlyd255QAI+9rpArIqoQd1fiNc4lowr2qJGdBdwMyJDU
         KO7Flw9Gm+EdTAP2bTXLh5njkAxw+LYgAd8CW4LcqPDPNQuG/nBC67NOgC2bR3Va1YRC
         wqa8+zXGQ7r7C6gVESkNFFGT3L80DSlAVelde6XI/SESJ4ATF9bzkZI5QMtvhdkN02It
         QZmOqiCSHOqGU0Z7jLfPAIncPCdxJlbkSwZeJVEpm+rRsHuHK7hZvC6/490r4XEXgdPQ
         efiw==
X-Forwarded-Encrypted: i=1; AJvYcCVDIdd/h57GustLdxExmotHD6vIhzLvl10vwoEwPEp3uBQd47baZP3YZ9RBw6Z5kMSTgh6ZSJvIL02KFbcT4qDhf+E27sLWUuqpvA==
X-Gm-Message-State: AOJu0YwLUofQeuYG6tOXJOj+aSWCE0+FjHywVMNtqfptUwUGr/BtLvOG
	ml6X7MW5MJ+i/VQthI7BJoEkuzCjW958Sodq1vEYAbQhZktwHEJCO/GB7kBi7VCesAL1NwJvU2a
	5td3zzg==
X-Google-Smtp-Source: AGHT+IGAZ1ZgG57wyEl3hAgidkrUPAgXgRKQMEY99fAI3aVfJqxlfcnLYdCjeTpkCSQlE8nj6I8g7s5cWbGz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:96dd:26a6:1493:53c8])
 (user=irogers job=sendgmr) by 2002:a05:6902:1082:b0:dff:12d0:207d with SMTP
 id 3f1490d57ef6-dff150dc3c9mr98556276.0.1718303559074; Thu, 13 Jun 2024
 11:32:39 -0700 (PDT)
Date: Thu, 13 Jun 2024 11:32:19 -0700
In-Reply-To: <20240613183224.3399628-1-irogers@google.com>
Message-Id: <20240613183224.3399628-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613183224.3399628-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v2 3/8] perf pmu-events: Make pmu-events a library
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Nick Terrell <terrelln@fb.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	coresight@lists.linaro.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Make pmu-events into a library so it may be linked against things like
the python module and not built from source.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: James Clark <james.clark@arm.com>
---
 tools/perf/Makefile.perf | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index c5a027381c55..9640c6ae1837 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -428,11 +428,14 @@ export PERL_PATH
 LIBPERF_UI_IN := $(OUTPUT)perf-ui-in.o
 LIBPERF_UI := $(OUTPUT)libperf-ui.a
 
+LIBPMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
+LIBPMU_EVENTS := $(OUTPUT)libpmu-events.a
+
 PERFLIBS = $(LIBAPI) $(LIBPERF) $(LIBSUBCMD) $(LIBSYMBOL)
 ifdef LIBBPF_STATIC
   PERFLIBS += $(LIBBPF)
 endif
-PERFLIBS += $(LIBPERF_UI)
+PERFLIBS += $(LIBPERF_UI) $(LIBPMU_EVENTS)
 
 # We choose to avoid "if .. else if .. else .. endif endif"
 # because maintaining the nesting to match is a pain.  If
@@ -721,8 +724,6 @@ strip: $(PROGRAMS) $(OUTPUT)perf
 	$(STRIP) $(STRIP_OPTS) $(PROGRAMS) $(OUTPUT)perf
 
 PERF_IN := $(OUTPUT)perf-in.o
-
-PMU_EVENTS_IN := $(OUTPUT)pmu-events/pmu-events-in.o
 export NO_JEVENTS
 
 build := -f $(srctree)/tools/build/Makefile.build dir=. obj
@@ -730,18 +731,21 @@ build := -f $(srctree)/tools/build/Makefile.build dir=. obj
 $(PERF_IN): prepare FORCE
 	$(Q)$(MAKE) $(build)=perf
 
-$(PMU_EVENTS_IN): FORCE prepare
+$(LIBPMU_EVENTS_IN): FORCE prepare
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
+$(LIBPMU_EVENTS): $(LIBPMU_EVENTS_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
+
 $(LIBPERF_UI_IN): FORCE prepare
 	$(Q)$(MAKE) $(build)=perf-ui
 
 $(LIBPERF_UI): $(LIBPERF_UI_IN)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $<
 
-$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
+$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN)
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
-		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
+		$(PERF_IN) $(LIBS) -o $@
 
 $(GTK_IN): FORCE prepare
 	$(Q)$(MAKE) $(build)=gtk
-- 
2.45.2.627.g7a2c4fd464-goog


