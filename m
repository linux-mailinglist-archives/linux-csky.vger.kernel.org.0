Return-Path: <linux-csky+bounces-1127-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFBB9A16A5
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 02:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30EBA1C21C90
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 00:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E4633F6;
	Thu, 17 Oct 2024 00:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zBTDDswo"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5571C69D
	for <linux-csky@vger.kernel.org>; Thu, 17 Oct 2024 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124058; cv=none; b=aTOYQtN8ZSwTwvLJVRzLbn1qYF213Hja0BZsG5m8JQbGNzvXAsAGPHnnpRXE4rgGZwnTP9vPKWTZ34GwgUq3nKOv0Tf84JUyyReWpavG4i0Uh0GEZJZEnzBb4AoUjFlodnfauDmpLsHS/WMCR8nLSIdLTfOHHRr/hhnTNIPWsmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124058; c=relaxed/simple;
	bh=zMh1r3eChZPJViKMzZCqXcyAQ/CCQmSa02OcG8ZRigk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=B/VMHv97JWg7ISThyip8gqehp7IB+ffqpz3io1n9FQuaVAvM3ko4IZH5y9FrdvtC5Qo07vcVBm7MvbWAYTny/SzyW0mhahRTSeBnGWnUFJKVUvdZ8xYIBZqqRcHbWUr/OWHvH5DqmqqZSJikFH5fogMimw9U/MWc1yTFq5AKIqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zBTDDswo; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e2928d9e615so633936276.0
        for <linux-csky@vger.kernel.org>; Wed, 16 Oct 2024 17:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124055; x=1729728855; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XruooYYEp4qZm36/rBHba0zUOpJtUJVrKsk9Et8lqQs=;
        b=zBTDDswoVJXHnLKlSnDx7/jvuebLgDH/IoBkxNlZ5GkXK9ndEGy6zJjVfWVdWcjI6X
         NuCu/Hsrr1R+fIiIAdVhLPT22t+cPbdmbsWU4X35Zhk5wLVzb5L95o96dgkKLw3NQhDm
         MlLl8oL92J0/kgXBoXJVWduUvRXTqKjMhM32viPflN3LCbDjYdAwxiG5YL0gGosaOIeO
         d3idkkBhj/qBrDnEbDuQJDlTg1WkRetsRu/rWN6MBn2goySefyaDZITsk1ryPXnDWzEA
         6hpgfeKn7WghHxoJ11hF59n3WbDj1Aa8Y0W/oH8LwOSAzDNjRd7xwH2D4QvYoQ5vOVr/
         ZsRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124055; x=1729728855;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XruooYYEp4qZm36/rBHba0zUOpJtUJVrKsk9Et8lqQs=;
        b=e5cV6lNvYudhOCaPl7zbubw1xLohJ/g5PvQ1qEMhd+Rs59mP9Wx0nOS+lirODOjKle
         paMpqLwJf7cU76I1ihxA2iyIXLNXQQdByNrSoYo2u6aWATv82V/TDOa2nFLqMlPcm1Vo
         f9oqrJI5FMc1qz81B2s/0ItWeiZdwEfAhVD6R5q3BAkukAZPNuvTarUyJm6kXpeEhlqd
         faanALR95dGJ19E2BhiOYg2qqRMuT1kffhbEcKS8YfkENqgDuHyayxDdWkPCIg4duNny
         pN/2uzUI93/u49zq49v5lBgfGUyBbv7Lf+RtxHtyHOEQnqYDZi5jB/Lkc2zVFQo5HqNb
         DV/A==
X-Forwarded-Encrypted: i=1; AJvYcCUidWZsM03piwmd6w3PThBP18B/vOT5+oZZgerMi54T02l27Hn6hAM/vNya7EUPFGmMaoE8OYSP80QW@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMpl/v9m9jB/Fg299qSDFHrZKiipJ4wTfR5teyAHV7HLBHCTC
	2qQxmpESwm0k9UYDPEjU9N25BguQ6LG4rY00/3DOifg6cNcxoLKA8FOa/N3YVPpb9EIp7rm6Drx
	aPhk8eg==
X-Google-Smtp-Source: AGHT+IEWSf9KTS25YKU/OuIukGw6sWQXoPw62GyskrXeRoMByAlrcshBkd7RuFz+z1QPDU6BnqyVlH2IKX9F
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:2e0b:0:b0:e0b:f69b:da30 with SMTP id
 3f1490d57ef6-e2978571005mr6949276.9.1729124055304; Wed, 16 Oct 2024 17:14:15
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:13:48 -0700
In-Reply-To: <20241017001354.56973-1-irogers@google.com>
Message-Id: <20241017001354.56973-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017001354.56973-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 05/11] perf build: Combine libdw-dwarf-unwind into libdw
 feature tests
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

Support in libdw has been present for 10 years so let's simplify the
build logic with a single feature test.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature                  |  2 --
 tools/build/feature/Makefile                  |  4 ----
 tools/build/feature/test-all.c                |  5 -----
 tools/build/feature/test-libdw-dwarf-unwind.c | 14 --------------
 tools/build/feature/test-libdw.c              | 19 ++++++++++++++++++-
 tools/perf/Makefile.config                    |  8 --------
 6 files changed, 18 insertions(+), 34 deletions(-)
 delete mode 100644 tools/build/feature/test-libdw-dwarf-unwind.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 6025810cc346..db3695ec5f83 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -60,7 +60,6 @@ FEATURE_TESTS_BASIC :=                  \
         reallocarray                    \
         stackprotector-all              \
         timerfd                         \
-        libdw-dwarf-unwind              \
         zlib                            \
         lzma                            \
         get_cpuid                       \
@@ -133,7 +132,6 @@ FEATURE_DISPLAY ?=              \
          libpython              \
          libcrypto              \
          libunwind              \
-         libdw-dwarf-unwind     \
          libcapstone            \
          llvm-perf              \
          zlib                   \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 7a1c028ce40b..18f8fef5e843 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -52,7 +52,6 @@ FILES=                                          \
          test-pthread-barrier.bin		\
          test-stackprotector-all.bin            \
          test-timerfd.bin                       \
-         test-libdw-dwarf-unwind.bin            \
          test-libbabeltrace.bin                 \
          test-libcapstone.bin			\
          test-compile-32.bin                    \
@@ -317,9 +316,6 @@ $(OUTPUT)test-backtrace.bin:
 $(OUTPUT)test-timerfd.bin:
 	$(BUILD)
 
-$(OUTPUT)test-libdw-dwarf-unwind.bin:
-	$(BUILD) # -ldw provided by $(FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind)
-
 $(OUTPUT)test-libbabeltrace.bin:
 	$(BUILD) # -lbabeltrace provided by $(FEATURE_CHECK_LDFLAGS-libbabeltrace)
 
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index d60e072b6eca..863c82516433 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -98,10 +98,6 @@
 # include "test-stackprotector-all.c"
 #undef main
 
-#define main main_test_libdw_dwarf_unwind
-# include "test-libdw-dwarf-unwind.c"
-#undef main
-
 #define main main_test_zlib
 # include "test-zlib.c"
 #undef main
@@ -202,7 +198,6 @@ int main(int argc, char *argv[])
 	main_test_numa_num_possible_cpus();
 	main_test_timerfd();
 	main_test_stackprotector_all();
-	main_test_libdw_dwarf_unwind();
 	main_test_zlib();
 	main_test_pthread_attr_setaffinity_np();
 	main_test_pthread_barrier();
diff --git a/tools/build/feature/test-libdw-dwarf-unwind.c b/tools/build/feature/test-libdw-dwarf-unwind.c
deleted file mode 100644
index ed03d9505609..000000000000
--- a/tools/build/feature/test-libdw-dwarf-unwind.c
+++ /dev/null
@@ -1,14 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-
-#include <elfutils/libdwfl.h>
-
-int main(void)
-{
-	/*
-	 * This function is guarded via: __nonnull_attribute__ (1, 2).
-	 * Passing '1' as arguments value. This code is never executed,
-	 * only compiled.
-	 */
-	dwfl_thread_getframes((void *) 1, (void *) 1, NULL);
-	return 0;
-}
diff --git a/tools/build/feature/test-libdw.c b/tools/build/feature/test-libdw.c
index 8d474bd7371b..793f4ac49514 100644
--- a/tools/build/feature/test-libdw.c
+++ b/tools/build/feature/test-libdw.c
@@ -1,11 +1,28 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <dwarf.h>
 #include <elfutils/libdw.h>
+#include <elfutils/libdwfl.h>
 #include <elfutils/version.h>
 
-int main(void)
+int test_libdw(void)
 {
 	Dwarf *dbg = dwarf_begin(0, DWARF_C_READ);
 
 	return (long)dbg;
 }
+
+int test_libdw_unwind(void)
+{
+	/*
+	 * This function is guarded via: __nonnull_attribute__ (1, 2).
+	 * Passing '1' as arguments value. This code is never executed,
+	 * only compiled.
+	 */
+	dwfl_thread_getframes((void *) 1, (void *) 1, NULL);
+	return 0;
+}
+
+int main(void)
+{
+	return test_libdw() + test_libdw_unwind();
+}
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index f1e24c4ae123..fa59ecce4470 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -164,8 +164,6 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
 endif
 FEATURE_CHECK_CFLAGS-libdw := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw := $(LIBDW_LDFLAGS) $(DWARFLIBS)
-FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
-FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-dwarf_getlocations := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-dwarf_getlocations := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-dwarf_getcfi := $(LIBDW_CFLAGS)
@@ -467,12 +465,6 @@ else
       endif
     endif
   else
-    ifndef NO_LIBDW_DWARF_UNWIND
-      ifneq ($(feature-libdw-dwarf-unwind),1)
-        NO_LIBDW_DWARF_UNWIND := 1
-        $(warning No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR)
-      endif
-    endif
     ifneq ($(feature-libdw), 1)
       ifndef NO_LIBDW
         $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
-- 
2.47.0.105.g07ac214952-goog


