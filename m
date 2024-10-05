Return-Path: <linux-csky+bounces-943-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF89991A36
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 21:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8202F1F224C8
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 19:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38A2176FDB;
	Sat,  5 Oct 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPnmTGC2"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C316087B
	for <linux-csky@vger.kernel.org>; Sat,  5 Oct 2024 19:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158177; cv=none; b=Jyuii0vxhacQqf+P2GZI8Q2SqCrCY+kKT36fEnbKh46VcaTDZjiLAJTGbm+JZ9jpCTIBnGqTnprwuzqN6vRJz9Didlhvi6vlG4i6syWjuFyudY2mkznQP2LtLsTHQy9sfOKiXVzsNtDWnW46Z93oGrR9amGnY8IAXDm5tqIYxdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158177; c=relaxed/simple;
	bh=cVIpvRAVS4B/q4rtsfLauVRqeL+8GYFjJpX7gyN/oeo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=fETt/VfcihxUA3gJP+SqhCAyzPpTHZIM52BD/IYHNPS8KkBmJQevmOk1EIkduq28PkN2ndqq05mOKnwspF34N39gwW1w1dqXd6IdaVwR3wT4bd0lTw5qQZf6XB/+3abVrkpYLa+MEgVRZ+dXjUFCkNvLM3sgfJEelVs99iTxX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wPnmTGC2; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e284982a31so55682167b3.3
        for <linux-csky@vger.kernel.org>; Sat, 05 Oct 2024 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158174; x=1728762974; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0crp/bMgJAdiK6d8c23KKPaC1XR/kHsld8YeBJQYGmI=;
        b=wPnmTGC2XHYpBNuIPm6cocnpBXFLyR5Qg7Uj1Ubj7UIKy1WN0psjfFVpZAKVD+O7o6
         ASKXAc1znuC71NQ6+sBJ1cfnDwNk/BJ9s7jfSICREVKHQZkUSIB0vO16yb9PAOUncP66
         oen6m4yddg+Wt6lb5NoFOZZdWS1O/pkQRzsR9aDiNjN4/wiKW1fY/87WCwE1o0+F6MFQ
         2eR7PssOEYZFW9k6qO/eyci5zYm6kuwopkkBhsmeE2vFKIt944zlTcg7E3MYxFVb4acb
         U1BWAvaUJiZr+SDRQPha2qfqMbO0x1hFrPoF5eNqIg71+gJ7Xc8NjohRKV7RtK47GnPS
         j20w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158174; x=1728762974;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0crp/bMgJAdiK6d8c23KKPaC1XR/kHsld8YeBJQYGmI=;
        b=WRX90Ptg+Wo1owRd5c7MO+ms6GOnQn0eXh0/T54IR5WIYZJr7VKtGPo+g/uYnL1Jqt
         zPNnA93KbTcI7ZGxQlnOHUb9Hz1wb2aJogPN7fHQMEmNLR2FnHtDesxCN9YHaz7uQ09x
         RZwrgag73N3VW1CiFBaVK4SR6gOa2N+IGQecA/mw5x2DNvIVZA8nkc2M2mYXaf05YI1P
         +6MC92Iq084GwRjYeok0urQTYlOWOAT7H/SxMYdKYrYXsC01Dm8SYOwDAtR+PBAVRSli
         Q2swVCfdZQ6pF4n6iq4G4UZWIMrHeLutF7qv+zdjlJk+ch862GUY0vAldpuAAT6p290y
         9VHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6a8Z2rzrPT+nkkzOiuVF9mMPDJVQ2WLQCsUqryj0z8QJD5Amfs1nRPrZFWsipFvBdaWc1ufKpOqXQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz2VxC4rGKG2fqM7XNzxpPjCQNVC9YOtbcxhqwD0idT49VS7MP
	2FBL1fj/uQL+QxcvHpq1p8y6hhdvP/PTpzgrV8PmdoadS0ESh6JElXeh/l6cRsjbrk5Hq2PtlcH
	WaRWeGQ==
X-Google-Smtp-Source: AGHT+IHI0ooHk2TiOSYrZi7ZdasFpBsMC3hc3dHVSPTy4zsPzZ/sjN8Kmzd2OcOEY5SwbjwD0AuHECWj/yIo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a05:690c:963:b0:6c1:298e:5a7 with SMTP id
 00721157ae682-6e2c72a0f50mr1533337b3.5.1728158174040; Sat, 05 Oct 2024
 12:56:14 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:17 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 07/31] perf build: Combine test-dwarf-getcfi into test-libdw
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

dwarf_getcfi support in libdw is 15 years old. Make libdw imply
dwarf_getcfi support and simplify build logic.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature            |  1 -
 tools/build/feature/Makefile            |  4 ----
 tools/build/feature/test-dwarf_getcfi.c |  9 ---------
 tools/build/feature/test-libdw.c        | 10 +++++++++-
 tools/perf/Makefile.config              |  8 +-------
 5 files changed, 10 insertions(+), 22 deletions(-)
 delete mode 100644 tools/build/feature/test-dwarf_getcfi.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index cf6a967575ea..ef72aae3dd49 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -31,7 +31,6 @@ endef
 FEATURE_TESTS_BASIC :=                  \
         backtrace                       \
         libdw                           \
-        dwarf_getcfi                    \
         eventfd                         \
         fortify-source                  \
         get_current_dir_name            \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7683d171f744..f94afd522ebb 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -6,7 +6,6 @@ FILES=                                          \
          test-backtrace.bin                     \
          test-bionic.bin                        \
          test-libdw.bin                         \
-         test-dwarf_getcfi.bin                  \
          test-eventfd.bin                       \
          test-fortify-source.bin                \
          test-get_current_dir_name.bin          \
@@ -184,9 +183,6 @@ endif
 $(OUTPUT)test-libdw.bin:
 	$(BUILD) $(DWLIBS)
 
-$(OUTPUT)test-dwarf_getcfi.bin:
-	$(BUILD) $(DWLIBS)
-
 $(OUTPUT)test-libelf-getphdrnum.bin:
 	$(BUILD) -lelf
 
diff --git a/tools/build/feature/test-dwarf_getcfi.c b/tools/build/feature/test-dwarf_getcfi.c
deleted file mode 100644
index 50e7d7cb7bdf..000000000000
--- a/tools/build/feature/test-dwarf_getcfi.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-#include <stdio.h>
-#include <elfutils/libdw.h>
-
-int main(void)
-{
-	Dwarf *dwarf = NULL;
-	return dwarf_getcfi(dwarf) == NULL;
-}
diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
index 83ea5d5f235d..71c6f8e3b0ee 100644
--- a/tools/build/feature/test-libdw.c
+++ b/tools/build/feature/test-libdw.c
@@ -34,7 +34,15 @@ int test_libdw_getlocations(void)
 	return (int)dwarf_getlocations(&attr, offset, &base, &start, &end, &op, &nops);
 }
 
+int test_libdw_getcfi(void)
+{
+	Dwarf *dwarf = NULL;
+
+	return dwarf_getcfi(dwarf) == NULL;
+}
+
 int main(void)
 {
-	return test_libdw() + test_libdw_unwind() + test_libdw_getlocations();
+	return test_libdw() + test_libdw_unwind() + test_libdw_getlocations() +
+	       test_libdw_getcfi();
 }
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 903de48c140d..9da0dc001d98 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -161,8 +161,6 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
 endif
 FEATURE_CHECK_CFLAGS-libdw := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw := $(LIBDW_LDFLAGS) $(DWARFLIBS)
-FEATURE_CHECK_CFLAGS-dwarf_getcfi := $(LIBDW_CFLAGS)
-FEATURE_CHECK_LDFLAGS-dwarf_getcfi := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 
 # for linking with debug library, run like:
 # make DEBUG=1 LIBBABELTRACE_DIR=/opt/libbabeltrace/
@@ -467,11 +465,7 @@ else
       endif
     else
       CFLAGS += -DHAVE_DWARF_GETLOCATIONS_SUPPORT
-      ifneq ($(feature-dwarf_getcfi), 1)
-        $(warning Old libdw.h, finding variables at given 'perf probe' point will not work, install elfutils-devel/libdw-dev >= 0.142)
-      else
-        CFLAGS += -DHAVE_DWARF_CFI_SUPPORT
-      endif # dwarf_getcfi
+      CFLAGS += -DHAVE_DWARF_CFI_SUPPORT
     endif # Dwarf support
   endif # libelf support
 endif # NO_LIBELF
-- 
2.47.0.rc0.187.ge670bccf7e-goog


