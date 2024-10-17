Return-Path: <linux-csky+bounces-1133-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73AAC9A16B0
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 02:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9720C1C21F74
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 00:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B602A382;
	Thu, 17 Oct 2024 00:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N05sPLCx"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E127AB669
	for <linux-csky@vger.kernel.org>; Thu, 17 Oct 2024 00:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124072; cv=none; b=WmEQ1h6RdJQcPDoeHLZWhuAdE6DrRcNgc+4Bq1NMB9iTIPkCoz/PrsXcmefk6dUPTBkwm4qVGB5l/lg1oea8zJkQzjiM3oXtB6dXIfk4x1hBi3YMVAjqjqWlvlWGF3k2wqnBKmnchj82oUEzDdDUcEgUly2Lb02jY511G/v4Jec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124072; c=relaxed/simple;
	bh=uTZGzDP2K1Gr+UdxyFj4+kEYNFidcL7ChzEuLmDixB8=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=lkRx55GvGpjLzAsptYj/XI1V3fGGVXQSBuIlOpEi9VDpXXdihjaoKY67ljX/BmwHYjF27NgSzkS57HLjGskDAlh664kwfAiVm78eIQOMefe2Lzgha5gRzIxanT9kZQ5SrZFO26qk4SLgu1SA/7ifY4iMgVXFy9dxgrTrKW/XNZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N05sPLCx; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e1fbe2a6b1so8999797b3.2
        for <linux-csky@vger.kernel.org>; Wed, 16 Oct 2024 17:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124070; x=1729728870; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZdCPmUKkGrBwCDxgLym0jfSR0ZKu6+x5u848gg4O+mI=;
        b=N05sPLCxImTKU5r4MDbFCUV0eRbeAr6P0ths/CfwORyHoXqxBnewwue5lNvoyFwXLq
         84y6T6K/5vBkwSEnQSzMRazXwdPjp3ZoiqAzbd47eyOySEKN8AkBl3gZ7ZkPe+ruokH5
         ZMqp3v98PxAYpw4Rq86f04chNuj2qxCmdX7TfaS7AW4WrtFXNO2Cj0laTmXnRZdMw47z
         JEFsbAMnyY4rpkJqapsguHl6Ko1bkLTWwefKxE0GoXgPKv0P/Y5aFrCMwGn2XO77ZA31
         ipZ6qDkA6QDYU2aEQP10eYsl3xXXLehuZWeCHkhAPjEadKs1tOjd7s1SFiSqle6bdk7H
         mB7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124070; x=1729728870;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdCPmUKkGrBwCDxgLym0jfSR0ZKu6+x5u848gg4O+mI=;
        b=GKXDf2JB978YOi3qxeceIlH2vKFnzpyK5roav+8C2fgUIP7DEJQWMECXvVsU/9Tgzq
         Q4tsMbEnKEXJuilomhT6cFUthWA3+1IGNbAM/SeBknFR1lHjbRyXZ4SRaE7l8cq7bNKR
         ab2XGqNvRY14jm8iJ5QY1cV6IEEFONHMDsT1ES75VFp+CBiNageGN5OYZizH2RMWKVbH
         4uQ014pq0G/SYor67JVlVUyvoYhXU9J5HRYic9ZPALh2P2R4vum2GAOKR4246lcZzrvr
         /ejJB4psKBXpEoHdpNI9ZrCG0Yr3NVAtZCHHZfUP+ZumQxBwXguBGOc+WCuRa+/RLBj9
         allA==
X-Forwarded-Encrypted: i=1; AJvYcCVrVThkHVSzXHtp5qWQe17Rupl7tXbLZiPRBgeTDe9DAOawSsHi9NHf8AT7Uh/QOJn4rwDFk1gZeeCF@vger.kernel.org
X-Gm-Message-State: AOJu0YxiGFK3BCbaPnPNoJA1DqrCBHq3hr9FlVMS3J9w6e0qOvlD1+sm
	a91Mg9QTBNcE63haA9jFajLb7BMjRKF1EkYK4ffc5+d1VAcKw3Tp6roenFOI9xRdYRZZKCgHtfz
	PcD5Qew==
X-Google-Smtp-Source: AGHT+IGmCqxqV/cR4e1mDBCmPDGgT/SSooHjQkQC219R9juE6phrOXnwsqdvmP6ECvOzFqzwnY8OkCCPIcef
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:690c:2502:b0:6e2:70e:e82e with SMTP id
 00721157ae682-6e3d41cb4aamr1150577b3.6.1729124069686; Wed, 16 Oct 2024
 17:14:29 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:13:54 -0700
In-Reply-To: <20241017001354.56973-1-irogers@google.com>
Message-Id: <20241017001354.56973-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017001354.56973-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 11/11] perf build: Rename CONFIG_DWARF to CONFIG_LIBDW
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

In Makefile.config for unwinding the name dwarf implies either
libunwind or libdw. Make it clearer that CONFIG_DWARF is really just
defined when libdw is present by renaming to CONFIG_LIBDW.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config           |  2 +-
 tools/perf/arch/arm/util/Build       |  2 +-
 tools/perf/arch/arm64/util/Build     |  2 +-
 tools/perf/arch/csky/util/Build      |  2 +-
 tools/perf/arch/loongarch/util/Build |  2 +-
 tools/perf/arch/mips/util/Build      |  2 +-
 tools/perf/arch/powerpc/util/Build   |  4 ++--
 tools/perf/arch/riscv/util/Build     |  2 +-
 tools/perf/arch/s390/util/Build      |  2 +-
 tools/perf/arch/sh/util/Build        |  2 +-
 tools/perf/arch/sparc/util/Build     |  2 +-
 tools/perf/arch/x86/util/Build       |  2 +-
 tools/perf/arch/xtensa/util/Build    |  2 +-
 tools/perf/util/Build                | 12 ++++++------
 14 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index d0ad2919983c..b93ed2b7623f 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -562,7 +562,7 @@ ifndef NO_LIBELF
       CFLAGS += -DHAVE_LIBDW_SUPPORT $(LIBDW_CFLAGS)
       LDFLAGS += $(LIBDW_LDFLAGS)
       EXTLIBS += ${DWARFLIBS}
-      $(call detected,CONFIG_DWARF)
+      $(call detected,CONFIG_LIBDW)
     endif # PERF_HAVE_DWARF_REGS
   endif # NO_LIBDW
 
diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Build
index e6dd7cd79ebd..e06fea1ea8ff 100644
--- a/tools/perf/arch/arm/util/Build
+++ b/tools/perf/arch/arm/util/Build
@@ -1,6 +1,6 @@
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/util/Build
index 343ef7589a77..4387a6d6a6c3 100644
--- a/tools/perf/arch/arm64/util/Build
+++ b/tools/perf/arch/arm64/util/Build
@@ -4,7 +4,7 @@ perf-util-y += perf_regs.o
 perf-util-y += tsc.o
 perf-util-y += pmu.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
-perf-util-$(CONFIG_DWARF)     += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW)     += dwarf-regs.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/Build
index 99d83f41bf43..1325310cab6a 100644
--- a/tools/perf/arch/csky/util/Build
+++ b/tools/perf/arch/csky/util/Build
@@ -1,4 +1,4 @@
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/loongarch/util/Build b/tools/perf/arch/loongarch/util/Build
index b6b97de48233..06ff95394921 100644
--- a/tools/perf/arch/loongarch/util/Build
+++ b/tools/perf/arch/loongarch/util/Build
@@ -1,7 +1,7 @@
 perf-util-y += header.o
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_DWARF)     += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW)     += dwarf-regs.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
diff --git a/tools/perf/arch/mips/util/Build b/tools/perf/arch/mips/util/Build
index e4644f1e68a0..b328109fc16c 100644
--- a/tools/perf/arch/mips/util/Build
+++ b/tools/perf/arch/mips/util/Build
@@ -1,3 +1,3 @@
 perf-util-y += perf_regs.o
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND) += unwind-libunwind.o
diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc/util/Build
index 6c588ecdf3bd..3d979480a188 100644
--- a/tools/perf/arch/powerpc/util/Build
+++ b/tools/perf/arch/powerpc/util/Build
@@ -7,8 +7,8 @@ perf-util-y += sym-handling.o
 perf-util-y += evsel.o
 perf-util-y += event.o
 
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
-perf-util-$(CONFIG_DWARF) += skip-callchain-idx.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += skip-callchain-idx.o
 
 perf-util-$(CONFIG_LIBUNWIND) += unwind-libunwind.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/util/Build
index f865cb0489ec..8f93091b8345 100644
--- a/tools/perf/arch/riscv/util/Build
+++ b/tools/perf/arch/riscv/util/Build
@@ -2,5 +2,5 @@ perf-util-y += perf_regs.o
 perf-util-y += header.o
 
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/Build
index 1ac830030ff3..787410f99bb3 100644
--- a/tools/perf/arch/s390/util/Build
+++ b/tools/perf/arch/s390/util/Build
@@ -2,7 +2,7 @@ perf-util-y += header.o
 perf-util-$(CONFIG_LIBTRACEEVENT) += kvm-stat.o
 perf-util-y += perf_regs.o
 
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 
 perf-util-y += machine.o
diff --git a/tools/perf/arch/sh/util/Build b/tools/perf/arch/sh/util/Build
index 32f44fc4ab98..2337a0b710a2 100644
--- a/tools/perf/arch/sh/util/Build
+++ b/tools/perf/arch/sh/util/Build
@@ -1 +1 @@
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
diff --git a/tools/perf/arch/sparc/util/Build b/tools/perf/arch/sparc/util/Build
index 32f44fc4ab98..2337a0b710a2 100644
--- a/tools/perf/arch/sparc/util/Build
+++ b/tools/perf/arch/sparc/util/Build
@@ -1 +1 @@
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Build
index 2607ed5c4296..9705cda4f240 100644
--- a/tools/perf/arch/x86/util/Build
+++ b/tools/perf/arch/x86/util/Build
@@ -12,7 +12,7 @@ perf-util-y += evsel.o
 perf-util-y += iostat.o
 perf-util-y += env.o
 
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
 perf-util-$(CONFIG_BPF_PROLOGUE) += dwarf-regs.o
 
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind.o
diff --git a/tools/perf/arch/xtensa/util/Build b/tools/perf/arch/xtensa/util/Build
index e813e618954b..2d1a48696ad9 100644
--- a/tools/perf/arch/xtensa/util/Build
+++ b/tools/perf/arch/xtensa/util/Build
@@ -1 +1 @@
-perf-$(CONFIG_DWARF) += dwarf-regs.o
+perf-$(CONFIG_LIBDW) += dwarf-regs.o
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index fa508e113dd0..1eedead5f2f2 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -200,11 +200,11 @@ ifndef CONFIG_SETNS
 perf-util-y += setns.o
 endif
 
-perf-util-$(CONFIG_DWARF) += probe-finder.o
-perf-util-$(CONFIG_DWARF) += dwarf-aux.o
-perf-util-$(CONFIG_DWARF) += dwarf-regs.o
-perf-util-$(CONFIG_DWARF) += debuginfo.o
-perf-util-$(CONFIG_DWARF) += annotate-data.o
+perf-util-$(CONFIG_LIBDW) += probe-finder.o
+perf-util-$(CONFIG_LIBDW) += dwarf-aux.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
+perf-util-$(CONFIG_LIBDW) += debuginfo.o
+perf-util-$(CONFIG_LIBDW) += annotate-data.o
 
 perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) += unwind-libdw.o
 perf-util-$(CONFIG_LOCAL_LIBUNWIND)    += unwind-libunwind-local.o
@@ -235,7 +235,7 @@ perf-util-$(CONFIG_LIBLLVM) += llvm-c-helpers.o
 ifdef CONFIG_JITDUMP
 perf-util-$(CONFIG_LIBELF) += jitdump.o
 perf-util-$(CONFIG_LIBELF) += genelf.o
-perf-util-$(CONFIG_DWARF) += genelf_debug.o
+perf-util-$(CONFIG_LIBDW) += genelf_debug.o
 endif
 
 perf-util-y += perf-hooks.o
-- 
2.47.0.105.g07ac214952-goog


