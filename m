Return-Path: <linux-csky+bounces-527-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5BE1905B20
	for <lists+linux-csky@lfdr.de>; Wed, 12 Jun 2024 20:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54EBDB2214B
	for <lists+linux-csky@lfdr.de>; Wed, 12 Jun 2024 18:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB7485279;
	Wed, 12 Jun 2024 18:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rP/sws8v"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBF284DE6
	for <linux-csky@vger.kernel.org>; Wed, 12 Jun 2024 18:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718217225; cv=none; b=MPMv+QkWESaNV5CIaBU5KoHuxxRuGgoFIVCqCzPxEmaMFG9BDuwl5mPcaZibJn7R9y+efCz9CfypOJKGGerMSqCRC2F97AWR9QAMTlEkShNthxrqOLeiXIyVe6ZB5shEU5T12h8+0T/BnC50kBF+OcKjZFfrneSjSw35Jqe75+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718217225; c=relaxed/simple;
	bh=/Y3F4sCd7/hxoSnGLA3j5vPDaNT/PzOL30m0ArVq/VY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=k0xDCtSYBehx4r9Yl78PnFFITD/TbnJjCk8GngkbuLVNThrIwk//WKOt8cGo035ISmu12w1UrHfxXVCwlFV+jSHvMnXz0BDc/Lm4+eK5UbT84raK4VsJpaQ3gVnfiMvgXxqjSzw69/zFa/Xh3bZZQ6pHmsWI/oXas5j6e6KXTl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rP/sws8v; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-627dd6a56caso2717027b3.3
        for <linux-csky@vger.kernel.org>; Wed, 12 Jun 2024 11:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718217223; x=1718822023; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qcvOQ2AYZ7WMCcNf48y0Z4WIFFdDS7XM+Tp2DrQsPX4=;
        b=rP/sws8vcz6H1pxHy8tHHDH0Rk57fIR3h3Zo8Qchjpvy5rLlMggauUc1OF79xyXUGQ
         wfBkC47pVUG+d+2HeRET01bquauFbdzzKTF/hdrD0x2en8s1rvpz2JDrx4usTZzXRUrV
         P3+cmDWt9u962ezC0pV1xMINUx0InDc4R2R1DbnviG2E7ffRVDydbaT792Dk4nOvcjT8
         UQ57n+RF8/mCN33Qcn8WEZYFfbnz66uaFt0zVIINbmM1O+Mb5oWlSHqWMPoudT9d6xQ6
         MiaeRTiaomH3yI37BcYDAR2OOUeldVnSqoxaJcutMimYBG896v4VUW2hQ92CuOVr9N8+
         gLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718217223; x=1718822023;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qcvOQ2AYZ7WMCcNf48y0Z4WIFFdDS7XM+Tp2DrQsPX4=;
        b=g6udtYX/ODICRtucI7r1dNLgoTpZGDsao9ozwhpsL8Pv15tUyuzIzk7Su2ZQ+1d9Bz
         0uJWCsNRyUTVvnEv1p2PvxofjvhhEfbOEq4wiO/GhoqTkiFX3KV7sCmNWWoMSPAQl4MM
         mofES3sY8rvUag0QLGZ66LfLv7ZrBBvCz8NCGZj3gPoXBZ9dcO4SD6S7/LfwP7dqxYY1
         lK2VO5bq+MV3MDKUIrdtygKGgo3REHe6rpoiHDiuy9+ZDEfozIM63CHqly0VYfBzr0qy
         Nj+cyrSA2QkOWvhDYl9s3oxXfqrAgJ/dz3cdRSmr8TxBUXs9TR9q5IXrNJ4p/9SscJW2
         JaMw==
X-Forwarded-Encrypted: i=1; AJvYcCVcE6LLhUS1VcT2m5gXUaBt2//BF6gj1BIYwOo4UI7bAWt+quk61r1PmaUBPysr6yH3YFNngissjMdMKTLWfOOPWG0PGvSZm6HolQ==
X-Gm-Message-State: AOJu0Yw5Hcn+SfqkJeC8DKPjb3Wo/na8nLkhfC5MnFjKGlFOCEW7f4Jy
	MSLX/9C273nSxzcV+/17ciuPI6oJED4WGE8HWTwZ+lfZFgJlJl7FIt5JKnazp08SIQRDG7l9hYL
	vARzVlw==
X-Google-Smtp-Source: AGHT+IEdZtuxFCkd4xeaZMVA0551v1r2/AOz8THV3+MN9PWe9shK7np3c1wiSt7RmdoT82E3zDdATSpfd0ve
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:959d:4302:db0e:d12a])
 (user=irogers job=sendgmr) by 2002:a05:690c:88:b0:62f:22cd:7082 with SMTP id
 00721157ae682-62fbb7f3b47mr6200647b3.5.1718217222801; Wed, 12 Jun 2024
 11:33:42 -0700 (PDT)
Date: Wed, 12 Jun 2024 11:32:05 -0700
In-Reply-To: <20240612183205.3120248-1-irogers@google.com>
Message-Id: <20240612183205.3120248-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240612183205.3120248-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Subject: [PATCH v1 7/7] perf python: Clean up build dependencies
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

The python build now depends on libraries and doesn't use
python-ext-sources except for the util/python.c dependency. Switch to
just directly depending on that file and util/setup.py. This allows
the removal of python-ext-sources.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf           | 10 +-----
 tools/perf/util/python-ext-sources | 53 ------------------------------
 2 files changed, 1 insertion(+), 62 deletions(-)
 delete mode 100644 tools/perf/util/python-ext-sources

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 6f66d3a7ffb2..918b851b2e0d 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -380,14 +380,6 @@ python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT
 # Use the detected configuration
 -include $(OUTPUT).config-detected
 
-ifeq ($(CONFIG_LIBTRACEEVENT),y)
-  PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)
-else
-  PYTHON_EXT_SRCS := $(shell grep -v ^\#\\\|util/trace-event.c\\\|util/trace-event-parse.c util/python-ext-sources)
-endif
-
-PYTHON_EXT_DEPS := util/python-ext-sources util/setup.py $(LIBAPI)
-
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH))
 
 PROGRAMS += $(OUTPUT)perf
@@ -715,7 +707,7 @@ all: shell_compatibility_test $(ALL_PROGRAMS) $(LANG_BINDINGS) $(OTHER_PROGRAMS)
 # Create python binding output directory if not already present
 $(shell [ -d '$(OUTPUT)python' ] || mkdir -p '$(OUTPUT)python')
 
-$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): $(PYTHON_EXT_SRCS) $(PYTHON_EXT_DEPS) $(PERFLIBS)
+$(OUTPUT)python/perf$(PYTHON_EXTENSION_SUFFIX): util/python.c util/setup.py $(PERFLIBS)
 	$(QUIET_GEN)LDSHARED="$(CC) -pthread -shared" \
         CFLAGS='$(CFLAGS)' LDFLAGS='$(LDFLAGS) $(LIBS)' \
 	  $(PYTHON_WORD) util/setup.py \
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
deleted file mode 100644
index 1bec945f4838..000000000000
--- a/tools/perf/util/python-ext-sources
+++ /dev/null
@@ -1,53 +0,0 @@
-#
-# List of files needed by perf python extension
-#
-# Each source file must be placed on its own line so that it can be
-# processed by Makefile and util/setup.py accordingly.
-#
-
-util/python.c
-../lib/ctype.c
-util/cap.c
-util/evlist.c
-util/evsel.c
-util/evsel_fprintf.c
-util/perf_event_attr_fprintf.c
-util/cpumap.c
-util/memswap.c
-util/mmap.c
-util/namespaces.c
-../lib/bitmap.c
-../lib/find_bit.c
-../lib/list_sort.c
-../lib/hweight.c
-../lib/string.c
-../lib/vsprintf.c
-util/thread_map.c
-util/util.c
-util/cgroup.c
-util/parse-branch-options.c
-util/rblist.c
-util/counts.c
-util/print_binary.c
-util/strlist.c
-util/trace-event.c
-util/trace-event-parse.c
-../lib/rbtree.c
-util/string.c
-util/symbol_fprintf.c
-util/units.c
-util/affinity.c
-util/rwsem.c
-util/hashmap.c
-util/perf_regs.c
-util/fncache.c
-util/rlimit.c
-util/perf-regs-arch/perf_regs_aarch64.c
-util/perf-regs-arch/perf_regs_arm.c
-util/perf-regs-arch/perf_regs_csky.c
-util/perf-regs-arch/perf_regs_loongarch.c
-util/perf-regs-arch/perf_regs_mips.c
-util/perf-regs-arch/perf_regs_powerpc.c
-util/perf-regs-arch/perf_regs_riscv.c
-util/perf-regs-arch/perf_regs_s390.c
-util/perf-regs-arch/perf_regs_x86.c
-- 
2.45.2.505.gda0bf45e8d-goog


