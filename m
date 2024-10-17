Return-Path: <linux-csky+bounces-1129-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936109A16A9
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 02:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB4FDB2162E
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 00:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E495661;
	Thu, 17 Oct 2024 00:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RcCveLKS"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119FC23741
	for <linux-csky@vger.kernel.org>; Thu, 17 Oct 2024 00:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124062; cv=none; b=vGHb+O7R+2XZgq63FvghQNAlrFJLMjDwVjyZrPJBFArEupY2+Mv2qLU5Tm2uxkqQ0CUV7RzIWBFsMgA7xyTYXUeyH+TMqAmahLx3kcjdji1JF8Q/LVQwfIY+jaRuu/3URpNcFSo/C/o0w0APWAY87Ie58jCp0mYGtFtMPPPvRF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124062; c=relaxed/simple;
	bh=P0Gp28BkMYlC/A7gXQDsJFdIHzwBEhHd5H8cstYec9E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=d5fUce7n6p/fgO9O7fzW4cXa+UODTTLri7rtnwS2xglWtKkx3aBTgTONVo9/rJbsOGXsJl76A+wGMgq5TTKQ0Oh0wtvRbgAZ+90eHQYX5IDCwv39APbrMlnd7ERLCmySMlSdoLN8pFaH65HEC9AUImAvAjypQ5xxty7sfdV9M+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RcCveLKS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e1fbe2a6b1so8998117b3.2
        for <linux-csky@vger.kernel.org>; Wed, 16 Oct 2024 17:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124060; x=1729728860; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Tad0E7gcGFVieZCra5vDET9AmRJVsC8ZllrVS3JLUH0=;
        b=RcCveLKS+p5TDdzfYCp6NC8DtwV2A2S4w1uvXboxEy9HshglDB7YuGXGYBPlZoSutM
         5gc/Q+D4XikKNRfVo1IYs+eL5V3PEq8aw0upxB03GNAL9reA5//uDusJUCvAbeUWeT4L
         n/4JXoDchwHFL5F+UVW4uoqA54I8vB7WqcD+CJZXNDRDf4tjaMmRY7q7iQ+/GVPmKVPI
         IrlFeSvlF5ptfr+8XUUW7zttx+w+0/6Ncn3EIGoZQUvcZ4WNz/mrbXfS+cXwJkfFYzMp
         HNUfKOV7rDpA2PEeqmCY32vDkGQ2UAqEVwj6fthjojSr1kb2YnOZ7HB51WdsGrkv09Ku
         QFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124060; x=1729728860;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Tad0E7gcGFVieZCra5vDET9AmRJVsC8ZllrVS3JLUH0=;
        b=loOVciiXCeCuXywzmrul9axqclDYeqI+ulVX5rjgwfGAJByyQS1aW6mmNQ7W0Psd2n
         PBTkJh9VofkyyP9OEGFutWpD5ZWSXqOjICOKZ0Ym3TTpUEVJdYpeyyqk/eIjTSTvSL7u
         LC1hhpz8amK846LOTfllualrkKXWFGXaCaPd5hbgGiquJbZ9mcUvYdp1DWccmTjPczpt
         NUcGHeCYdIPsNR6n0oGCAYYBtfhnPNMk6KvjCFD67kPNt+Ib1aETsJ4jCUG4DvMJRytF
         0kCCZPFJzLnnL7/Iv7+ZhE/D2VyxC04P9nmQIUjOHhKDQopoz6BmyvTNW5xjsFkVOGRa
         vdwg==
X-Forwarded-Encrypted: i=1; AJvYcCUGHtLv2Cw7mlbr4VAVxbNALO+FpZ5Ddu6h92f1uC3vxaZV7dbJA6ycokPtfoiMoUQEZiFUjoIsCkrN@vger.kernel.org
X-Gm-Message-State: AOJu0YzTmdT/lmS2Piq1w9xWJBcZmyw16I0Q1kemSuZZ5V158OAib6p3
	5YlGgenfQa8ZLxI5x2pXpl40FSrCWoK1resQQb7N35G38Q09pyI9uk+gqjx+EWlzBfEWGLoEuVK
	a4k9B3Q==
X-Google-Smtp-Source: AGHT+IGePwSgVpWBgHdlZAEHvgtdZU4v9XTpwRgCq9JMZeuOMFSyMOIR6zQOqhOB1mh8mXpAaT7pdZ4G4iD7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:dc4e:0:b0:e28:f231:1aa8 with SMTP id
 3f1490d57ef6-e29782bbb03mr7701276.2.1729124060026; Wed, 16 Oct 2024 17:14:20
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:13:50 -0700
In-Reply-To: <20241017001354.56973-1-irogers@google.com>
Message-Id: <20241017001354.56973-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017001354.56973-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 07/11] perf build: Combine test-dwarf-getcfi into test-libdw
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
index 0af3e0255fed..d28ad7672a27 100644
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
@@ -187,9 +186,6 @@ endif
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
index fefa779041a0..6378811f2568 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -164,8 +164,6 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
 endif
 FEATURE_CHECK_CFLAGS-libdw := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw := $(LIBDW_LDFLAGS) $(DWARFLIBS)
-FEATURE_CHECK_CFLAGS-dwarf_getcfi := $(LIBDW_CFLAGS)
-FEATURE_CHECK_LDFLAGS-dwarf_getcfi := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 
 # for linking with debug library, run like:
 # make DEBUG=1 LIBBABELTRACE_DIR=/opt/libbabeltrace/
@@ -470,11 +468,7 @@ else
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
2.47.0.105.g07ac214952-goog


