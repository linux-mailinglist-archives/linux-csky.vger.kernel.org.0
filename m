Return-Path: <linux-csky+bounces-1154-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8718F9A1716
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 02:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 136DE1F213EB
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 00:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F92282EE;
	Thu, 17 Oct 2024 00:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sz/ctqxK"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FCD18C936
	for <linux-csky@vger.kernel.org>; Thu, 17 Oct 2024 00:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124781; cv=none; b=EKLUpwy5gZQ5ULeFuviKH5K16MuE290OxBNpUEGvRj+YZ4H/VF8lwUW5SAmAmImcyDWspBH7f186VtmP/mB25Y0w/k06Vo/1dIpPBQnc8YyNUHLzwaz+nXdeDWussGn/zM6uVFgcna13+1WCsNeL+Avpo4mj8w5pIAIGQDCt5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124781; c=relaxed/simple;
	bh=atImUl0FotF7zSp+sUCObNt0Nr4nOLPdsoGiee7Bvjg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=YEEqycsLMXDshJOlB4Hp00y2+p8RZfaqO/aOogcsqonQ97kVD2WKkojG8zhppvV+FTrZaxsnb+Z31P4urUx60g+3BiRrw/Jzmgm8oJEVKg4IiYBq8dP0Akv+pwLcSbbJ5HngvpiCyTsQHYD9kFZ/NwLQbrbJHa/383T6DvOwAU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Sz/ctqxK; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e292d801e59so774852276.0
        for <linux-csky@vger.kernel.org>; Wed, 16 Oct 2024 17:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124779; x=1729729579; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SquaAPD0AcQIjNNI8ogmi7jeRDo2TBHiGE7l1NG90xo=;
        b=Sz/ctqxK3yKIJqd7v9wcFgQDQ7/ELhOIRWc7X1/QRjuwXTrf4hj+4CmmI9pj9bYbT3
         Gat1T2/cFoC2ZuESRWRPP+rhdoD9Tfvn5etO2N6hIRRhypebs43vF5DTOFYfN7akbFSM
         ia4iYOE2HkWcQ/lX8bwX8ISD/92yNq8tWA2Zlqy0QKGzTs107WcRWpzqYJKI6qF5O/WY
         5RD/EoT8O1jQQ9kqNpEdUlC851qnDk/VD/nu/ATApHy0W9h+rDja6XiQDQkWRsACPly+
         mg4+bEyw+JOwM+L8celfLrWf1Li9zgqNPMnu4lLZElgd/Cr/5IXj4zMriatcN3+UrNBH
         uMwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124779; x=1729729579;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SquaAPD0AcQIjNNI8ogmi7jeRDo2TBHiGE7l1NG90xo=;
        b=wRN+4kSLb5k5pweQjJJ14HlX6u4fUPl/wEQVm8IynRJ9RXENEpSW6rc7qd7ZnYsKbN
         U/KC8P8hxy2xDS7U7sNY0SM9lIFynH5ZR+OcAdkUKltl+aXBf/Zh2ASxX2EKMsDroZiU
         zBaLRBdcq644WyiH9I75uQSrNKEJ6zTgiDxWw0fQx/1PTwO1dBlQes2Ff8oo6C0wg1Lo
         fMvgXxS5FWvCY2KIHNF+le+48GxXyJNXxKrFLFkW8bOD7NcUl6bdA4J4zHKnUsoVfBAA
         G1CY74S6mxavCUVagNG7NtHwl5KyrdrEWtNIXdB4Vj9Shs8x2+KljKnt4HY2af1qWOr3
         DmtA==
X-Forwarded-Encrypted: i=1; AJvYcCWcjnHE4xsq41RCYNOLIre/0SWuU5hHrp+BRbgqkElg7N9WWeLZpxZAxNrG4Pfdh1BGH2CFJJW5tqLx@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ8SBFVRBD9ByQXr6p0C8/TR6Iy/1snTcwNSPWNkn40A6OsAuu
	1taXO+5Pth5foTbl+GH4l72x1x3ARPIhPysHjpmWNEGFN6j8y5R2ewAA0LvoLka2w27XYwNiTwy
	xuJT1og==
X-Google-Smtp-Source: AGHT+IGs4WdpXIM0biaGJT8f6W/Ar64INlqNJ5uuSoIpjWhZg3wOMLE81Q/Ij8NPQT52fZqpf6BkfGWtnGFO
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:26c4:0:b0:e28:ef6f:3624 with SMTP id
 3f1490d57ef6-e2978319b29mr3216276.5.1729124778489; Wed, 16 Oct 2024 17:26:18
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:25:20 -0700
In-Reply-To: <20241017002520.59124-1-irogers@google.com>
Message-Id: <20241017002520.59124-21-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017002520.59124-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 20/20] perf build: Remove PERF_HAVE_DWARF_REGS
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

PERF_HAVE_DWARF_REGS was true when an architecture had a dwarf-regs.c
file. There are no more architecture dwarf-regs.c files, selection is
done using constants from the ELF file rather than conditional
compilation. When removing PERF_HAVE_DWARF_REGS was the only variable
in the Makefile, remove the Makefile.

Add missing SPDX for RISC-V Makefile.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config         | 13 ++++---------
 tools/perf/arch/arm/Makefile       |  3 ---
 tools/perf/arch/arm64/Makefile     |  3 ---
 tools/perf/arch/csky/Makefile      |  4 ----
 tools/perf/arch/loongarch/Makefile |  3 ---
 tools/perf/arch/mips/Makefile      |  4 ----
 tools/perf/arch/powerpc/Makefile   |  4 ----
 tools/perf/arch/riscv/Makefile     |  4 +---
 tools/perf/arch/s390/Makefile      |  3 ---
 tools/perf/arch/sh/Makefile        |  4 ----
 tools/perf/arch/sparc/Makefile     |  4 ----
 tools/perf/arch/x86/Makefile       |  3 ---
 tools/perf/arch/xtensa/Makefile    |  4 ----
 13 files changed, 5 insertions(+), 51 deletions(-)
 delete mode 100644 tools/perf/arch/csky/Makefile
 delete mode 100644 tools/perf/arch/sh/Makefile
 delete mode 100644 tools/perf/arch/xtensa/Makefile

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 1d3f7dcc6b66..87dae64c0501 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -551,15 +551,10 @@ ifndef NO_LIBELF
   endif
 
   ifndef NO_LIBDW
-    ifeq ($(origin PERF_HAVE_DWARF_REGS), undefined)
-      $(warning DWARF register mappings have not been defined for architecture $(SRCARCH), DWARF support disabled)
-      NO_LIBDW := 1
-    else
-      CFLAGS += -DHAVE_LIBDW_SUPPORT $(LIBDW_CFLAGS)
-      LDFLAGS += $(LIBDW_LDFLAGS)
-      EXTLIBS += ${DWARFLIBS}
-      $(call detected,CONFIG_LIBDW)
-    endif # PERF_HAVE_DWARF_REGS
+    CFLAGS += -DHAVE_LIBDW_SUPPORT $(LIBDW_CFLAGS)
+    LDFLAGS += $(LIBDW_LDFLAGS)
+    EXTLIBS += ${DWARFLIBS}
+    $(call detected,CONFIG_LIBDW)
   endif # NO_LIBDW
 
   ifndef NO_LIBBPF
diff --git a/tools/perf/arch/arm/Makefile b/tools/perf/arch/arm/Makefile
index 9b164d379548..8b59ce8efb89 100644
--- a/tools/perf/arch/arm/Makefile
+++ b/tools/perf/arch/arm/Makefile
@@ -1,5 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/arm64/Makefile b/tools/perf/arch/arm64/Makefile
index ca2e35961287..91570d5d428e 100644
--- a/tools/perf/arch/arm64/Makefile
+++ b/tools/perf/arch/arm64/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
 
diff --git a/tools/perf/arch/csky/Makefile b/tools/perf/arch/csky/Makefile
deleted file mode 100644
index 119b06a64bed..000000000000
--- a/tools/perf/arch/csky/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
index 79b432744296..52544d59245b 100644
--- a/tools/perf/arch/loongarch/Makefile
+++ b/tools/perf/arch/loongarch/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
 
diff --git a/tools/perf/arch/mips/Makefile b/tools/perf/arch/mips/Makefile
index 733f7b76f52d..827168f1077a 100644
--- a/tools/perf/arch/mips/Makefile
+++ b/tools/perf/arch/mips/Makefile
@@ -1,8 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
-
 # Syscall table generation for perf
 out    := $(OUTPUT)arch/mips/include/generated/asm
 header := $(out)/syscalls_n64.c
diff --git a/tools/perf/arch/powerpc/Makefile b/tools/perf/arch/powerpc/Makefile
index ae05727835d8..dc8f4fb8e324 100644
--- a/tools/perf/arch/powerpc/Makefile
+++ b/tools/perf/arch/powerpc/Makefile
@@ -1,8 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
-
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
 
diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
index f01ab2171fd0..087e099fb453 100644
--- a/tools/perf/arch/riscv/Makefile
+++ b/tools/perf/arch/riscv/Makefile
@@ -1,5 +1,3 @@
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
+# SPDX-License-Identifier: GPL-2.0
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 58e79f5b67a4..c431c21b11ef 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
 
diff --git a/tools/perf/arch/sh/Makefile b/tools/perf/arch/sh/Makefile
deleted file mode 100644
index 119b06a64bed..000000000000
--- a/tools/perf/arch/sh/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
diff --git a/tools/perf/arch/sparc/Makefile b/tools/perf/arch/sparc/Makefile
index 7741184894c8..8b59ce8efb89 100644
--- a/tools/perf/arch/sparc/Makefile
+++ b/tools/perf/arch/sparc/Makefile
@@ -1,6 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
-
 PERF_HAVE_JITDUMP := 1
diff --git a/tools/perf/arch/x86/Makefile b/tools/perf/arch/x86/Makefile
index 51cf267f4d85..a6b6e0a9308a 100644
--- a/tools/perf/arch/x86/Makefile
+++ b/tools/perf/arch/x86/Makefile
@@ -1,7 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
 HAVE_KVM_STAT_SUPPORT := 1
 PERF_HAVE_JITDUMP := 1
 
diff --git a/tools/perf/arch/xtensa/Makefile b/tools/perf/arch/xtensa/Makefile
deleted file mode 100644
index 119b06a64bed..000000000000
--- a/tools/perf/arch/xtensa/Makefile
+++ /dev/null
@@ -1,4 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-ifndef NO_LIBDW
-PERF_HAVE_DWARF_REGS := 1
-endif
-- 
2.47.0.105.g07ac214952-goog


