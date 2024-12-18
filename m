Return-Path: <linux-csky+bounces-1399-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E117A9F61A1
	for <lists+linux-csky@lfdr.de>; Wed, 18 Dec 2024 10:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24BA31896A66
	for <lists+linux-csky@lfdr.de>; Wed, 18 Dec 2024 09:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0631B043F;
	Wed, 18 Dec 2024 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OLMpKfX2"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A241ACECF
	for <linux-csky@vger.kernel.org>; Wed, 18 Dec 2024 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513902; cv=none; b=khJOtooAxeFcKp29E6/w4vM+dYcNQHorCpQm4BoSS3PDvqXCloi5KJsIDOo+3kFESz/kfCJApSiUJWOYRzEicmF9MOrj3yyFL+KzcNsRtcnvcRfM24nwb6YoKAvYLMDG72tjuWLXpUAv22R9Qu1o9vFJ8DlcjoIYEFVWmZBqgaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513902; c=relaxed/simple;
	bh=8zaNBLsWCcfauluN9i4LFC13erUU3m5MbHaCxvxxTaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bxqc/MuVlea/uL4tvDsIy3K6Rw6vh2BdrBEljJWKd6fhWGbp0J8oV4wvjDtSGR6VbDryNR48OhAD1H9Y0usNPDku70BMYYA9ZFUyuoXXr5jNETpKaoOYanYx0Ma2drmYvmjyXdZv+wYXPqQhLMJNG/R/GAyGph8pJlaM2vAMeWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OLMpKfX2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2162c0f6a39so4921325ad.0
        for <linux-csky@vger.kernel.org>; Wed, 18 Dec 2024 01:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734513898; x=1735118698; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+Q2z3RiH+Cxmha3T/07fxqh9kG8swBDg6SVk5HdbKg=;
        b=OLMpKfX2XLY6vHCqXeLFTm2xjm7ftZFG2K/wm0mT9FBHC6WzDMj8naUsp7/E0jNpJw
         2rycm+Gtc3wi02DCMnkvQTcl07ZBRfmf2fIoMJxMQ77QWEW5B79QAqoDtAEtSSOA7MUz
         A70lmFG0gifp6uLLLn6enis91PQd6Ptz9ShkSxOAynyS1gJuI4KUhrhR4CGIowo0xOjy
         dWC8yuA3cPCN/qPGg+bxAVJ8PWxN4EOrnhBbSUlJLMvrG06nQPJoE7oS9+DdXBsE7ONS
         6c43HL8FQAlgQK34rfNQN3nXqx4ZexEPBZxEwwTSE/E/yn8Np/yOLGlLbFZE82vRwyZ9
         Umhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734513898; x=1735118698;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e+Q2z3RiH+Cxmha3T/07fxqh9kG8swBDg6SVk5HdbKg=;
        b=sCsAO1cFGmDVKVJdf4RQLG83FeFd1Q9EfHJDBlE2zNXkGwzp66E/k+gqikdUWwoB5O
         nnaiJgKPWLx5EO/O8N72eJubMlP5BIdkXHeu+3z13U5iLYAEdt4tkWx94DytS2KFmnDQ
         C9ZsZX8H9nqvTL/V53BC0sC+6C5QGRKLXHiQMyiVTniI6xWvCPmm/8Tjl+jvOzzYJ0WO
         PxE9qOnudVzzbP9hguohvHBMOL3chqwwJUeMWjblDtsZ0EJSSkDM53RBTQdheMcme6ok
         4rCOmXPK+9slFJIC3BvQP/nTrRTezavUQbPyA2u/Q17kl6yPxGuUyzi8dV8ERxFTv2CJ
         87Xg==
X-Forwarded-Encrypted: i=1; AJvYcCUX/NKV3s44RSXPOE8z9Iy+5LZLhH53vMdOIH8rinINismm1LnHq1dAMzVg7zOoof6VxUAmPgGujLSp@vger.kernel.org
X-Gm-Message-State: AOJu0YzNgsIcKK3FvllNSAjHoO+cdTjfm28hQPHgdYE23wKN8sWIzL+N
	AzpKgL9zUYBt7NPSqoaoJi31gscTcpfI1V+7BKfA5Ey6M8swUltFG/EryXtQsjo=
X-Gm-Gg: ASbGnctM6LGjdQloZNMQE2rqdf2OaeJPS6RvyHcs4AyyjKSqFMFsV8Ik3z77RjBb5sd
	6jMomO3Q3dJz2IlraG1EqjXxHtPLlGkAGS5nVAVZsSzpw5WFVz7xKzs0vgpmD1wIPQ3JJHo7XQi
	bGDTxgS93uCqw43XKYtMB9oxAhXbRaIpq+ziT3dP1UpCErj1Db6nV7/nS22pOaCLobluVcAXg86
	emo2rnXRB+si1tTdAiU8b3saw33Ax0dqXPSMrovipFKl7l8DKS52AjbFDBJtgEMBLhqEPEl
X-Google-Smtp-Source: AGHT+IHbJHhDW5HIGosLfjTa4TBEb7HdXsptGQd5VzT9LSUe70yM0oJDHxUo2rOfZ2gS0Kvb23LnIQ==
X-Received: by 2002:a17:903:2c8:b0:215:8847:4377 with SMTP id d9443c01a7336-218d73b30d6mr32003395ad.15.1734513897636;
        Wed, 18 Dec 2024 01:24:57 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e64f90sm72119995ad.241.2024.12.18.01.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:24:56 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 18 Dec 2024 01:24:10 -0800
Subject: [PATCH v4 12/16] perf tools: loongarch: Use syscall table
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-perf_syscalltbl-v4-12-bc8caef2ca8e@rivosinc.com>
References: <20241218-perf_syscalltbl-v4-0-bc8caef2ca8e@rivosinc.com>
In-Reply-To: <20241218-perf_syscalltbl-v4-0-bc8caef2ca8e@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
 Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>, 
 John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
 James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
 Leo Yan <leo.yan@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>, 
 Arnd Bergmann <arnd@arndb.de>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6453; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=8zaNBLsWCcfauluN9i4LFC13erUU3m5MbHaCxvxxTaY=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rSlOMzf5cFKv9RrMqQ95fdUJv36ofcevlN89xOXhA1d
 igJVv3TUcrCIMbBICumyMJzrYG59Y5+2VHRsgkwc1iZQIYwcHEKwETSnjAy3NB6J731fH2oaGw9
 b9s69e57/woeLJ35tjw9rb36S6grL8MfrmNCgXznN6VZVjBuuzgtN+ykW8TR26Z/n274cH+36gN
 GfgA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

loongarch uses a syscall table, use that in perf instead of using unistd.h.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  3 +-
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/loongarch/Makefile                 | 22 -----------
 tools/perf/arch/loongarch/entry/syscalls/Kbuild    |  2 +
 .../loongarch/entry/syscalls/Makefile.syscalls     |  3 ++
 .../arch/loongarch/entry/syscalls/mksyscalltbl     | 45 ----------------------
 tools/perf/arch/loongarch/include/syscall_table.h  |  2 +
 tools/perf/util/syscalltbl.c                       |  4 --
 8 files changed, 9 insertions(+), 74 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 83ed03f16209b2edff3e81d4e8a79fa058c35a48..dd1a5409e65ef38eb4132cd74c2e18dd2c8af920 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,7 +31,7 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390 mips loongarch))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390 mips))
     NO_SYSCALL_TABLE := 0
   endif
 
@@ -85,7 +85,6 @@ ifeq ($(SRCARCH),arm64)
 endif
 
 ifeq ($(SRCARCH),loongarch)
-  CFLAGS += -I$(OUTPUT)arch/loongarch/include/generated
   ifndef NO_LIBUNWIND
     LIBUNWIND_LIBS = -lunwind -lunwind-loongarch64
   endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index bedf58d2a10f1faccb3579c023d5722cfeaae4cf..c85262db770d18828fc3d9dc65eca00733645d41 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64
+generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
diff --git a/tools/perf/arch/loongarch/Makefile b/tools/perf/arch/loongarch/Makefile
index 52544d59245bab5a0fb2baa1e962b2ad4bf25332..087e099fb453a9236db34878077a51f711881ce0 100644
--- a/tools/perf/arch/loongarch/Makefile
+++ b/tools/perf/arch/loongarch/Makefile
@@ -1,25 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 PERF_HAVE_JITDUMP := 1
 HAVE_KVM_STAT_SUPPORT := 1
-
-#
-# Syscall table generation for perf
-#
-
-out    := $(OUTPUT)arch/loongarch/include/generated/asm
-header := $(out)/syscalls.c
-incpath := $(srctree)/tools
-sysdef := $(srctree)/tools/arch/loongarch/include/uapi/asm/unistd.h
-sysprf := $(srctree)/tools/perf/arch/loongarch/entry/syscalls/
-systbl := $(sysprf)/mksyscalltbl
-
-# Create output directory if not already present
-$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
-
-$(header): $(sysdef) $(systbl)
-	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
-
-clean::
-	$(call QUIET_CLEAN, loongarch) $(RM) $(header)
-
-archheaders: $(header)
diff --git a/tools/perf/arch/loongarch/entry/syscalls/Kbuild b/tools/perf/arch/loongarch/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..9a41e3572c3afd4f202321fd9e492714540e8fd3
--- /dev/null
+++ b/tools/perf/arch/loongarch/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls b/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..47d32da2aed8d67a7ac026271600e84723031a6b
--- /dev/null
+++ b/tools/perf/arch/loongarch/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_64 +=
diff --git a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl b/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
deleted file mode 100755
index c10ad3580aef25e48ff0682eca4217cbafdfa333..0000000000000000000000000000000000000000
--- a/tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
+++ /dev/null
@@ -1,45 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Generate system call table for perf. Derived from
-# powerpc script.
-#
-# Author(s):  Ming Wang <wangming01@loongson.cn>
-# Author(s):  Huacai Chen <chenhuacai@loongson.cn>
-# Copyright (C) 2020-2023 Loongson Technology Corporation Limited
-
-gcc=$1
-hostcc=$2
-incpath=$3
-input=$4
-
-if ! test -r $input; then
-	echo "Could not read input file" >&2
-	exit 1
-fi
-
-create_sc_table()
-{
-	local sc nr max_nr
-
-	while read sc nr; do
-		printf "%s\n" "	[$nr] = \"$sc\","
-		max_nr=$nr
-	done
-
-	echo "#define SYSCALLTBL_LOONGARCH_MAX_ID $max_nr"
-}
-
-create_table()
-{
-	echo "#include \"$input\""
-	echo "static const char *const syscalltbl_loongarch[] = {"
-	create_sc_table
-	echo "};"
-}
-
-$gcc -E -dM -x c -I $incpath/include/uapi $input \
-	|awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
-		sub("^#define __NR(3264)?_", "");
-		print | "sort -k2 -n"}' \
-	|create_table
diff --git a/tools/perf/arch/loongarch/include/syscall_table.h b/tools/perf/arch/loongarch/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..9d0646d3455cdaf1a3db8c8565af8eba9a8df8c6
--- /dev/null
+++ b/tools/perf/arch/loongarch/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscall_table_64.h>
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index b7c0a4b9245a94b3b245fea59af79081b1f91081..3001386e13a502be5279aa6e4742af0b96202b35 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -30,10 +30,6 @@ static const char *const *syscalltbl_native = syscalltbl_powerpc_32;
 #include <asm/syscalls_n64.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_MIPS_N64_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_mips_n64;
-#elif defined(__loongarch__)
-#include <asm/syscalls.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_loongarch;
 #elif defined(GENERIC_SYSCALL_TABLE)
 #include <syscall_table.h>
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;

-- 
2.34.1


