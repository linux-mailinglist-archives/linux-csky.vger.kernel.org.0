Return-Path: <linux-csky+bounces-1535-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B8FA05040
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jan 2025 03:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1AB9164AAF
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jan 2025 02:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871C21AA1D9;
	Wed,  8 Jan 2025 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="A1g01yRr"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F441A9B58
	for <linux-csky@vger.kernel.org>; Wed,  8 Jan 2025 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302123; cv=none; b=ENub2ZsVvfMv9QVZt5qSa3HXVUYpIn4jRJSDtRNg4nMLq9GJBV4IXEBp90p59zntXP2168cKq37tntQVFnVxlOK0rpbGotxE6lRh7NI0n8/6w+8Lf6zyFPypcNgNEJXyDzyUY9eo3Z5z05V/qvrzw4Hr6OicqwpuKdl3GOj9iHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302123; c=relaxed/simple;
	bh=1DxWrtrDP0aS/Gfe9epTRxAlgriq5hGWv0IFvaoNd/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tFWNLLFy4GOsZ8uOPsF3YpOZH6EOJNp8khOiKfw2KN1FVNATxdhiQCOjYclaLCCOX7US0LnT1+f48hXdhEKKH5cMJYX9fH+kTWW5ovtnfKZz4NUFhNACWEeudbyV1vg7Xwh6VzMljlprOlvrKnhA8p71BcRI/MRUcghBD9ibJMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=A1g01yRr; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2164b662090so211144035ad.1
        for <linux-csky@vger.kernel.org>; Tue, 07 Jan 2025 18:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736302121; x=1736906921; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8uNJ/vXA7NGF0yxSiSP2RkC1jPs5fLciqUxBAB6Mg4=;
        b=A1g01yRr4OGolRWKgbrTPHlLD1DE9Fo1fP0OSr9anYUL/QaAjmuXsFPuJw3d7sD+JF
         VgSlHalAZCg5cTQYnJV+5QGdwACWgPxZAn2N71v3PBHEcRpEYPhIMsAmJy26VpJWXstg
         /fysczTiW+vCo4rC/jAEqvsjMOmv73lT6Eiq8HfLJMn8VFKtE2sjCMfOfMhxNFczYleu
         OCQz0E2Yhrvql2Bi/tiaK/pyzdS1m9kwIjQXjlNswpRasMA7uJX2lrug+rnkOzqmlgz4
         SvzVKE9of9i4/Kg7NDNx9Q61FxF4zSU+7XsYfAnISKwULnyB8CKV9K8BggUNrIAKXQL5
         JgAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736302121; x=1736906921;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8uNJ/vXA7NGF0yxSiSP2RkC1jPs5fLciqUxBAB6Mg4=;
        b=vHsAXQa5Q90SV5srbqYNMfQxmvo4IgmU407YS+/RTrcyiEmDajhFXIbHgSAjMT3sRk
         9x7EVc5U3CQQYrD5UfLu4eqYIVJERjgOKxA+OMcyd9JNdM2twYVtjZT2zFlxtqFv5I9B
         bT3fg4dmD8KuwkcVK5s0dkfDTfrprKZSBBltPDbGhEJJ0nvrOmrtGChezdXqxAuY1eN1
         K5Zhru9PbjG3r64PtbvsqdP6uGJgf98x0SA/AwIjbwLfw0R7ktrOqRh178IWySEEYg8t
         KmHG0q26bJq3qlP17wd6darAcKWZfF1Pfm4XmccZYj3AByBR6bQ+jbaRUbs2yTNE+baG
         v2Ig==
X-Forwarded-Encrypted: i=1; AJvYcCWhVPRVLsxq9jV3Jj/FGLMUerfvy06JhIzwERTHR4IXP/aBKmqx4v8Jg6Lzm0HuLM0uYCsr/lSRVUo3@vger.kernel.org
X-Gm-Message-State: AOJu0YzTRr2W7jJnFj04x19ZzR/8FHdbYzh3X7mIIOfOgOPCFvr2Ut2g
	x1vPft81kIwwgm/H6AfGbvpVuacJ35W+n4c4DS+1n1Y+Is3zNi+rGRoCjD8W4IE=
X-Gm-Gg: ASbGncuYh/EwrbQNVtewXXvc5SpsBSRece3ZniGr4s8eOHAPdLwU74s9CDLNHWwX2jI
	VvRKTKRSQsONfYuMZ1PT+7jYYTLPDDCa2EThZX0bLH54tyOCb6wOadhAemYKG7gHtKN36KG58oD
	XtvDcYbL5JkVF5v262DJHCdOq/f3xIpCOU09q/MrKt8Ufwdr7ROxInR1/7In59nKlNgN1hwDI60
	CvQYTvflLuXn6W1BWaiVDnkPtpEYssh6pbP2jDqcmfiUc2o8A0Z1+eSkJpMeeTJzZUfsbDj
X-Google-Smtp-Source: AGHT+IFDydFgEV/GNLZvcTlJ2ShF70+JdSjTRhD9Fjo1he6KAYSzA0gH3X1xLwKHfEXLdhfx9ra61A==
X-Received: by 2002:a17:902:ec8f:b0:211:efa9:a4e6 with SMTP id d9443c01a7336-21a83f5d8b7mr15310275ad.23.1736302120625;
        Tue, 07 Jan 2025 18:08:40 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca0282fsm316662405ad.259.2025.01.07.18.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:08:39 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 Jan 2025 18:08:01 -0800
Subject: [PATCH v5 13/16] perf tools: mips: Use generic syscall scripts
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-perf_syscalltbl-v5-13-935de46d3175@rivosinc.com>
References: <20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com>
In-Reply-To: <20250107-perf_syscalltbl-v5-0-935de46d3175@rivosinc.com>
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
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5143; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=1DxWrtrDP0aS/Gfe9epTRxAlgriq5hGWv0IFvaoNd/w=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rtPRaB/fOFNls6FczkSz3MpCSqyeyls1BXYAa77crlJ
 bZTVzt1lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMBG1WYwMy8XtnnNkt+hdMRGS
 Svh87YrKTpnHVr33JzwoXXcg++d2XkaGWQqTA/YWbrivetC0JuesdYuWsxBT06cXH+uDtcIUpz9
 jAQA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Use the generic scripts to generate headers from the syscall table for
mips.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                         |  3 +-
 tools/perf/Makefile.perf                           |  2 +-
 tools/perf/arch/mips/entry/syscalls/Kbuild         |  2 ++
 .../arch/mips/entry/syscalls/Makefile.syscalls     |  5 ++++
 tools/perf/arch/mips/entry/syscalls/mksyscalltbl   | 32 ----------------------
 tools/perf/arch/mips/include/syscall_table.h       |  2 ++
 tools/perf/util/syscalltbl.c                       |  4 ---
 7 files changed, 11 insertions(+), 39 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 8b0595da9402c7d69aef1e120e815d320ecf006c..e053a2304f40f6cd06a9fd022ba863b5bf2efa5e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -31,7 +31,7 @@ $(call detected_var,SRCARCH)
 ifneq ($(NO_SYSCALL_TABLE),1)
   NO_SYSCALL_TABLE := 1
 
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390 mips))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),powerpc s390))
     NO_SYSCALL_TABLE := 0
   endif
 
@@ -95,7 +95,6 @@ ifeq ($(ARCH),s390)
 endif
 
 ifeq ($(ARCH),mips)
-  CFLAGS += -I$(OUTPUT)arch/mips/include/generated
   ifndef NO_LIBUNWIND
     LIBUNWIND_LIBS = -lunwind -lunwind-mips
   endif
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 558f1425a09d536c3b85798840e173067c3da463..84d23f147365d5a57c83fe16a2faedf45f4e2f70 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch
+generic_syscall_table_archs := riscv arc csky arm sh sparc xtensa x86 alpha parisc arm64 loongarch mips
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
diff --git a/tools/perf/arch/mips/entry/syscalls/Kbuild b/tools/perf/arch/mips/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..9a41e3572c3afd4f202321fd9e492714540e8fd3
--- /dev/null
+++ b/tools/perf/arch/mips/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_64.h
diff --git a/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls b/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..9ee914bdfb05860fdd37a49f1ced03fcf2c9ed78
--- /dev/null
+++ b/tools/perf/arch/mips/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_64 += n64
+
+syscalltbl = $(srctree)/tools/perf/arch/mips/entry/syscalls/syscall_n64.tbl
diff --git a/tools/perf/arch/mips/entry/syscalls/mksyscalltbl b/tools/perf/arch/mips/entry/syscalls/mksyscalltbl
deleted file mode 100644
index c0d93f959c4e1b8c12edcb5624bbc131231df7e3..0000000000000000000000000000000000000000
--- a/tools/perf/arch/mips/entry/syscalls/mksyscalltbl
+++ /dev/null
@@ -1,32 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-#
-# Generate system call table for perf. Derived from
-# s390 script.
-#
-# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
-# Changed by: Tiezhu Yang <yangtiezhu@loongson.cn>
-
-SYSCALL_TBL=$1
-
-if ! test -r $SYSCALL_TBL; then
-	echo "Could not read input file" >&2
-	exit 1
-fi
-
-create_table()
-{
-	local max_nr nr abi sc discard
-
-	echo 'static const char *const syscalltbl_mips_n64[] = {'
-	while read nr abi sc discard; do
-		printf '\t[%d] = "%s",\n' $nr $sc
-		max_nr=$nr
-	done
-	echo '};'
-	echo "#define SYSCALLTBL_MIPS_N64_MAX_ID $max_nr"
-}
-
-grep -E "^[[:digit:]]+[[:space:]]+(n64)" $SYSCALL_TBL	\
-	|sort -k1 -n					\
-	|create_table
diff --git a/tools/perf/arch/mips/include/syscall_table.h b/tools/perf/arch/mips/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..b53e31c15805319a01719c22d489c4037378b02b
--- /dev/null
+++ b/tools/perf/arch/mips/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_64.h>
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 3001386e13a502be5279aa6e4742af0b96202b35..675702d686d0d1b53dd3ee2017cc9695686b9c63 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -26,10 +26,6 @@ static const char *const *syscalltbl_native = syscalltbl_powerpc_64;
 #include <asm/syscalls_32.c>
 const int syscalltbl_native_max_id = SYSCALLTBL_POWERPC_32_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl_powerpc_32;
-#elif defined(__mips__)
-#include <asm/syscalls_n64.c>
-const int syscalltbl_native_max_id = SYSCALLTBL_MIPS_N64_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl_mips_n64;
 #elif defined(GENERIC_SYSCALL_TABLE)
 #include <syscall_table.h>
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;

-- 
2.34.1


