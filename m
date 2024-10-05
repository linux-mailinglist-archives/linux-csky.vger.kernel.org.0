Return-Path: <linux-csky+bounces-940-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F4991A2F
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 21:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 427081C20384
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 19:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228161714BD;
	Sat,  5 Oct 2024 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GRtLJ0BW"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D46116FF44
	for <linux-csky@vger.kernel.org>; Sat,  5 Oct 2024 19:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158170; cv=none; b=kl/jTNmP6AxiY6k7znq/p+AZKkR6d+MsvA7JAXRp757BvB7q9xNX7ookAQXm4EMB3NNkYBOQUUIyGS5LemhmB9cpMnN3Diedj8/A6dSgAmc5nT+rG8ELHfIZtiMn0wJHmdaqjk7KtIZ/8uTfWDLmxqKPIU+i6t5gcgte5S5iSsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158170; c=relaxed/simple;
	bh=8pm5i1eGHWDDXJHC4BfkaRu28Wigks0+wYzENVnnTRs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=sSrYLPNX5SLHTcEp31zs3WooFm4b9nDW0vT+NHujascbU0rIe3iQa0vAJRj8Wtn98GS4vCYHXBADVGmiAqkAuQ5s8EkOSwphI+wCp73g8uc9I5QvkYYxFnZKmO8mxTkkawHSuJ+M9NE2/B6GqLEWpxqAUc9N/3j4kJVolxtWayc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GRtLJ0BW; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e288a73e967so3672963276.1
        for <linux-csky@vger.kernel.org>; Sat, 05 Oct 2024 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158167; x=1728762967; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jKCAAT8Yq0zCoRQSEuvmwmrXtedkR549ZkEZtq8vZwU=;
        b=GRtLJ0BWrlPLkUiKJ9w/bX9CnlLyv7tGx0rjvCsH7B9y/fZniMM4SS7OPDC/8AMJdU
         jw73g+iiARnsJzvOP6WCMMs8B6oSYWzPmdor4fay82Q7afsbvYXmgz6xD1cRWmtNhilO
         eSHLp4cbHRzZ3+DjUkatZlrxvGfM7gw4NQk7U88lSiI0j2SvIb9UiPSeCXc3hZJi8WIW
         F7B2aljMv3svEkeJrCx8A20L8p27WO+giXN1hFMZ6APW98pRbGrbNSpd/D/5+nclrqMe
         53orjh5K+6QDlyYjvXLKBiQ4+Q/yRB6LB4UhHfEcfOegF5tu9zZpth97NLRfsl0iQDi6
         hIjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158167; x=1728762967;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jKCAAT8Yq0zCoRQSEuvmwmrXtedkR549ZkEZtq8vZwU=;
        b=at2Yok3GCc1MzZE7YlKD/Mv8HHq/ObO3D04VSLSxTEQ4jZuuKKz+dzh8VObyRuhLk0
         D/9JAk1w9rNKMNWWWZ9R3ogHscsGvIN2gQVYKyHpl99EOtRHYixoL1D0IKY4nmVC/StX
         lfPYjwYDcMwsQx+HFqSNenRZcvSwNPm6JDNj8P8IwLVci6M6jRKByM0n+67flX7jsJnO
         SbMUZYHKZPFHm2PKawjjUsbaTS8yrvQgMZIt8x9An/z7qIi9bLSoSyDcYr5GUnEUs3ad
         7ncbMUAhE8qfJuIQEZaubjOrwnaxxMxtypmAc1ekOvevvOZ+pCAEIv2EbJkYQeEJybQj
         akhA==
X-Forwarded-Encrypted: i=1; AJvYcCX130z/uWh+CT1s0OsNdjUPrBj6dzph72z66z80PFaN78Gej30UvQElyua8CpgAxoTKSr2MJz8I3r8j@vger.kernel.org
X-Gm-Message-State: AOJu0YwyXwsqmiqpaDTjW0W0xwAh3EjVqjBSPnKybraFLiK/YDZ9rJ3r
	wVoDrNBqFM5l32m3W1Q4UxyN1IrooaeMv7yS81iztwx7infaE1ehnr+JcYBKLWvYR4KP/z/rvTy
	uX2jZGQ==
X-Google-Smtp-Source: AGHT+IG0rU9ibGjtPmAL08yq2KEhHsCm45b7xwYMGISD4T+sjFBkBvKxulNTeU2lvZfpr29mKdjAqeZdA/VR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:adc2:0:b0:e24:9584:52d3 with SMTP id
 3f1490d57ef6-e28936b99bamr11206276.2.1728158167274; Sat, 05 Oct 2024 12:56:07
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:14 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 04/31] perf build: Rename test-dwarf to test-libdw
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

Be more intention revealing that the dwarf test is actually testing
for libdw support.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature                     |  6 +++---
 tools/build/feature/Makefile                     | 16 ++++++++--------
 tools/build/feature/test-all.c                   |  6 +++---
 .../build/feature/{test-dwarf.c => test-libdw.c} |  0
 tools/perf/Makefile.config                       |  6 +++---
 5 files changed, 17 insertions(+), 17 deletions(-)
 rename tools/build/feature/{test-dwarf.c => test-libdw.c} (100%)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index ffd117135094..6025810cc346 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -30,7 +30,7 @@ endef
 #
 FEATURE_TESTS_BASIC :=                  \
         backtrace                       \
-        dwarf                           \
+        libdw                           \
         dwarf_getlocations              \
         dwarf_getcfi                    \
         eventfd                         \
@@ -120,7 +120,7 @@ ifeq ($(FEATURE_TESTS),all)
 endif
 
 FEATURE_DISPLAY ?=              \
-         dwarf                  \
+         libdw                  \
          dwarf_getlocations     \
          glibc                  \
          libbfd                 \
@@ -233,7 +233,7 @@ endef
 
 #
 # generates feature value assignment for name, like:
-#   $(call feature_assign,dwarf) == feature-dwarf=1
+#   $(call feature_assign,libdw) == feature-libdw=1
 #
 feature_assign = feature-$(1)=$(feature-$(1))
 
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 5938cf799dc6..bece326ac93b 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -5,7 +5,7 @@ FILES=                                          \
          test-all.bin                           \
          test-backtrace.bin                     \
          test-bionic.bin                        \
-         test-dwarf.bin                         \
+         test-libdw.bin                         \
          test-dwarf_getlocations.bin            \
          test-dwarf_getcfi.bin                  \
          test-eventfd.bin                       \
@@ -168,9 +168,9 @@ $(OUTPUT)test-libopencsd.bin:
 	$(BUILD) # -lopencsd_c_api -lopencsd provided by
 		 # $(FEATURE_CHECK_LDFLAGS-libopencsd)
 
-DWARFLIBS := -ldw
+DWLIBS := -ldw
 ifeq ($(findstring -static,${LDFLAGS}),-static)
-  DWARFLIBS += -lelf -lz -llzma -lbz2 -lzstd
+  DWLIBS += -lelf -lz -llzma -lbz2 -lzstd
 
   LIBDW_VERSION := $(shell $(PKG_CONFIG) --modversion libdw)
   LIBDW_VERSION_1 := $(word 1, $(subst ., ,$(LIBDW_VERSION)))
@@ -179,18 +179,18 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
   # Elfutils merged libebl.a into libdw.a starting from version 0.177,
   # Link libebl.a only if libdw is older than this version.
   ifeq ($(shell test $(LIBDW_VERSION_2) -lt 177; echo $$?),0)
-    DWARFLIBS += -lebl
+    DWLIBS += -lebl
   endif
 endif
 
-$(OUTPUT)test-dwarf.bin:
-	$(BUILD) $(DWARFLIBS)
+$(OUTPUT)test-libdw.bin:
+	$(BUILD) $(DWLIBS)
 
 $(OUTPUT)test-dwarf_getlocations.bin:
-	$(BUILD) $(DWARFLIBS)
+	$(BUILD) $(DWLIBS)
 
 $(OUTPUT)test-dwarf_getcfi.bin:
-	$(BUILD) $(DWARFLIBS)
+	$(BUILD) $(DWLIBS)
 
 $(OUTPUT)test-libelf-getphdrnum.bin:
 	$(BUILD) -lelf
diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-all.c
index 6f4bf386a3b5..d60e072b6eca 100644
--- a/tools/build/feature/test-all.c
+++ b/tools/build/feature/test-all.c
@@ -38,8 +38,8 @@
 # include "test-glibc.c"
 #undef main
 
-#define main main_test_dwarf
-# include "test-dwarf.c"
+#define main main_test_libdw
+# include "test-libdw.c"
 #undef main
 
 #define main main_test_dwarf_getlocations
@@ -187,7 +187,7 @@ int main(int argc, char *argv[])
 	main_test_get_current_dir_name();
 	main_test_gettid();
 	main_test_glibc();
-	main_test_dwarf();
+	main_test_libdw();
 	main_test_dwarf_getlocations();
 	main_test_eventfd();
 	main_test_libelf_getphdrnum();
diff --git a/tools/build/feature/test-dwarf.c b/tools/build/feature/test-libdw.c
similarity index 100%
rename from tools/build/feature/test-dwarf.c
rename to tools/build/feature/test-libdw.c
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 182e14e39cd5..c8e157cc0c5e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -159,8 +159,8 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
     DWARFLIBS += -lebl
   endif
 endif
-FEATURE_CHECK_CFLAGS-dwarf := $(LIBDW_CFLAGS)
-FEATURE_CHECK_LDFLAGS-dwarf := $(LIBDW_LDFLAGS) $(DWARFLIBS)
+FEATURE_CHECK_CFLAGS-libdw := $(LIBDW_CFLAGS)
+FEATURE_CHECK_LDFLAGS-libdw := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-dwarf_getlocations := $(LIBDW_CFLAGS)
@@ -470,7 +470,7 @@ else
         $(warning No libdw DWARF unwind found, Please install elfutils-devel/libdw-dev >= 0.158 and/or set LIBDW_DIR)
       endif
     endif
-    ifneq ($(feature-dwarf), 1)
+    ifneq ($(feature-libdw), 1)
       ifndef NO_LIBDW
         $(warning No libdw.h found or old libdw.h found or elfutils is older than 0.138, disables dwarf support. Please install new elfutils-devel/libdw-dev)
         NO_LIBDW := 1
-- 
2.47.0.rc0.187.ge670bccf7e-goog


