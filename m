Return-Path: <linux-csky+bounces-2726-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F880D38C95
	for <lists+linux-csky@lfdr.de>; Sat, 17 Jan 2026 06:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CC87B3021A4A
	for <lists+linux-csky@lfdr.de>; Sat, 17 Jan 2026 05:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E2233031B;
	Sat, 17 Jan 2026 05:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dviA2s7A"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A719E330338
	for <linux-csky@vger.kernel.org>; Sat, 17 Jan 2026 05:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627801; cv=none; b=MHJrrbETNz40FMV8MYlmEDxQLuzvvVuAKjaFWnJwIU1Gm03ybI6HyRnizG10T13aKhCLngKTxhimJu+UgvnQs3ksVCI9tkaG811UJQ5W3P2SPdEy2xOtw/9rlST/6qzw+UpHyDRxiPIfvDvVD3v+scRucu7kFxLM3UfsbE3eofo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627801; c=relaxed/simple;
	bh=0CymPKudGe+KI6Wn4idJryFK+62VhKG4sXlkbqlHNWA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=JWEv8EuZo6MRpMinRmYPkDKXSf36rzmfYEkqHK3U6ISqtxarjFGxgJgS+84PhdBNPe4CxM4NQ5KYQgGNWWSMlLeDMgPlgDGOUxR6Zvpy47VD/A+f0yyKMUVAznYdkWY5+LsVo6/PGJpL5l17guLDem9r4yIL8mPjo9avDDSj1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dviA2s7A; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b6a8afb513so3064658eec.0
        for <linux-csky@vger.kernel.org>; Fri, 16 Jan 2026 21:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627799; x=1769232599; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/cI6wzc88dPba4Z3EWyEhx9YKJRNqyLJPumk+e8HfU=;
        b=dviA2s7AH5fqbMQ6hvsAk7KOaRULGBQ0N8z4yu8Ws4rg8x//KfiUTaf+LJ4w+LDOI5
         b4/MDS1AbZrB0Vn/vTxE5M3xFaqQF2fEV5jcLxA1cqCuyW6BixNRlS5EREenT59ra+w/
         KFKP0/7hvIGRYxYilpX+q0CL45R7V8h+FERgnL2IrathkiMQJgYFE5hbqEAXJHVKBQt+
         rw+WYemS4wVFaX5gKeKGN12bG3wrMXWofKFJInTtViRR40DUbxNB+hCbGajzebql83/Y
         r65AjR30r0cor19+W3CC/3+iunaT5XubBYB4uSIdDmQnEPp3rnOlx9rLr5vJuHJXL/9F
         lyTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627799; x=1769232599;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w/cI6wzc88dPba4Z3EWyEhx9YKJRNqyLJPumk+e8HfU=;
        b=vAwYa8q+j1PTOZkSRXsuNcTvWqJUWwCb/sNc+hd0a6QrgQSFHu1YxWFuj+jrRGrFXZ
         Lhx/gyFVCh28boTieuprLX4CE0FC++N15Vyn9m1HGTxjcRaS6Gsq0sUfZ/afb6h64y2o
         Ukq2Bajbg3IrkHe+c0ROoQQzoT9s3Y0t8No2Jd4zyRt4XOzEsiQ1lmNigmF3Yx2Ksfwe
         phqgaquwUtP3XklsiMGuRzT7YkL5dtTFzOXetLnPRWABLfNgoGTjQ/xS6QZn0+SR5c+4
         PmF/052AZTWeBjkNrQwOK8T2FocN/aCpi+jnonjNeMF60LK9Xm/4kbW699e9Ao/4FytX
         Dqiw==
X-Forwarded-Encrypted: i=1; AJvYcCWQC2zSN4yTVrgAwVPex3pgID02s9yYIlUg/15hEnn+MJtyHRtwGvn16Ma0+A4w1jWb7p0n78oG7YKx@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7FP0Xf1AUHOmUyNEol5HO0cUy4fUTxoFQUQYcLLs5No3/U6w+
	CzCTBPi2glzHlXITXIqfT10ONzvYNdmZu9WlQ+XdH9YK1iAWkZ65lIKpJIo2ld7HWylrnr22XC5
	UnSWxpuHP1g==
X-Received: from dybmj1.prod.google.com ([2002:a05:7301:e01:b0:2ac:3545:743c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6d1f:b0:2b0:4e86:8157
 with SMTP id 5a478bee46e88-2b6b46eb100mr4487390eec.17.1768627798660; Fri, 16
 Jan 2026 21:29:58 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:47 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-22-irogers@google.com>
Subject: [PATCH v1 21/23] perf build: Remove NO_LIBDW_DWARF_UNWIND option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"

Libdw unwinding support is present for every architecture that has a
perf_regs.h - perf registers are needed for the initial frame to
unwind. Elfutils also supports sparc, arc and m68k but there is no
support in the Linux kernel for perf registers on these
architectures. As the perf supported dwarf unwinding architectures are
a subset of the elfutils ones, remove NO_LIBDW_DWARF_UNWIND as there
isn't a case of elfutils lacking the support need for perf.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 19 +------------------
 tools/perf/tests/make      |  3 +--
 tools/perf/util/Build      |  3 +--
 3 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 6f2c7bd36e74..5e4ae775987f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -118,14 +118,6 @@ ifeq ($(ARCH),mips)
   endif
 endif
 
-# So far there's only x86 and arm libdw unwind support merged in perf.
-# Disable it on all other architectures in case libdw unwind
-# support is detected in system. Add supported architectures
-# to the check.
-ifneq ($(SRCARCH),$(filter $(SRCARCH),x86 arm arm64 powerpc s390 csky riscv loongarch))
-  NO_LIBDW_DWARF_UNWIND := 1
-endif
-
 ifneq ($(LIBUNWIND),1)
   NO_LIBUNWIND := 1
 endif
@@ -456,7 +448,6 @@ endif
 ifdef NO_LIBELF
   NO_LIBDW := 1
   NO_LIBUNWIND := 1
-  NO_LIBDW_DWARF_UNWIND := 1
   NO_LIBBPF := 1
   NO_JVMTI := 1
 else
@@ -504,10 +495,6 @@ ifeq ($(feature-libaio), 1)
   endif
 endif
 
-ifdef NO_LIBDW
-  NO_LIBDW_DWARF_UNWIND := 1
-endif
-
 ifeq ($(feature-scandirat), 1)
   # Ignore having scandirat with memory sanitizer that lacks an interceptor.
   ifeq ($(filter s% -fsanitize=memory%,$(EXTRA_CFLAGS),),)
@@ -757,7 +744,7 @@ dwarf-post-unwind-text := BUG
 
 # setup DWARF post unwinder
 ifdef NO_LIBUNWIND
-  ifdef NO_LIBDW_DWARF_UNWIND
+  ifdef NO_LIBDW
     $(warning Disabling post unwind, no support found.)
     dwarf-post-unwind := 0
   else
@@ -767,10 +754,6 @@ ifdef NO_LIBUNWIND
 else
   dwarf-post-unwind-text := libunwind
   $(call detected,CONFIG_LIBUNWIND)
-  # Enable libunwind support by default.
-  ifndef NO_LIBDW_DWARF_UNWIND
-    NO_LIBDW_DWARF_UNWIND := 1
-  endif
 endif
 
 ifeq ($(dwarf-post-unwind),1)
diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 36411b4b6d2b..767ad9e147a8 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -83,7 +83,6 @@ make_no_demangle    := NO_DEMANGLE=1
 make_no_libelf      := NO_LIBELF=1
 make_no_libdw       := NO_LIBDW=1
 make_libunwind      := LIBUNWIND=1
-make_no_libdw_dwarf_unwind := NO_LIBDW_DWARF_UNWIND=1
 make_no_backtrace   := NO_BACKTRACE=1
 make_no_libcapstone := NO_CAPSTONE=1
 make_no_libnuma     := NO_LIBNUMA=1
@@ -120,7 +119,7 @@ make_static         := LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX3
 make_minimal        := NO_LIBPYTHON=1 NO_GTK2=1
 make_minimal        += NO_DEMANGLE=1 NO_LIBELF=1 NO_BACKTRACE=1
 make_minimal        += NO_LIBNUMA=1 NO_LIBBIONIC=1 NO_LIBDW=1
-make_minimal        += NO_LIBDW_DWARF_UNWIND=1 NO_LIBBPF=1
+make_minimal        += NO_LIBBPF=1
 make_minimal        += NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
 make_minimal        += NO_LIBCAP=1 NO_CAPSTONE=1
 
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 3cb1edd263cf..c30ff257f8b4 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -223,9 +223,8 @@ perf-util-$(CONFIG_LIBDW) += dwarf-regs-arch/
 perf-util-$(CONFIG_LIBDW) += debuginfo.o
 perf-util-$(CONFIG_LIBDW) += annotate-data.o
 perf-util-$(CONFIG_LIBDW) += libdw.o
+perf-util-$(CONFIG_LIBDW) += unwind-libdw.o
 
-perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
-perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw-arch/
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
 perf-util-$(CONFIG_LIBUNWIND)          += unwind-libunwind.o
 perf-util-$(CONFIG_LIBUNWIND_X86)      += libunwind/x86_32.o
-- 
2.52.0.457.g6b5491de43-goog


