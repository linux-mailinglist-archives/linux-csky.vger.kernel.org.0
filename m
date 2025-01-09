Return-Path: <linux-csky+bounces-1579-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3298A06B7E
	for <lists+linux-csky@lfdr.de>; Thu,  9 Jan 2025 03:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B8A7A0769
	for <lists+linux-csky@lfdr.de>; Thu,  9 Jan 2025 02:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B521F4E50;
	Thu,  9 Jan 2025 02:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1sBSC3sV"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA921AAE33
	for <linux-csky@vger.kernel.org>; Thu,  9 Jan 2025 02:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390233; cv=none; b=NOve8b1hrQXJaKhuFRr1TMqg35o6cb/Ad9kYdq8CuxiQ16rdVGk8585T5C/EPKPtrxb5XgB7WIwHsGsoyhvyk0Rn5C6o88iEXmY7zUtJeyFpl3XVsTfK72KaN8uM3L3DQ+LJMjNoGIT7SfNLBqaOx/Z0O3cxfmmVaB5Co7WtV0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390233; c=relaxed/simple;
	bh=1DxWrtrDP0aS/Gfe9epTRxAlgriq5hGWv0IFvaoNd/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZW5CcvC+jrW//cB2306HerALeFYdR00C14/cTLPl2to+xdon0WQjtO3uPlbGA+mIasJC82MD3ZwtipqwV8/yL2eDly0CTODx/i/P7CEefe+anotIOyPwveEJDBC9I4YJDDzLDobhPnUCqNcN74XDtKFTONkh3kOdTU9HwnYk0uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1sBSC3sV; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so748414a91.1
        for <linux-csky@vger.kernel.org>; Wed, 08 Jan 2025 18:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736390229; x=1736995029; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8uNJ/vXA7NGF0yxSiSP2RkC1jPs5fLciqUxBAB6Mg4=;
        b=1sBSC3sVudbTb0K9rmpv7Y8nOTvP575+AmrQQNzyp9TDCRcc3Odbzp8bO/FpIBSY+m
         Kn1yjp+SQ2lnx7VDbLJ+t2p0tPmOC03DSECTc0y5B9OVBxmbPVnLlr3p+KZ3mZU/v0Gs
         t9X25mODTHiQJsJ0NQvqRRw/nnPvIe3fh6G4dqTPUsbUg0fhCS5qq+6+Qht07Xttxee3
         QGrlrDmMZI+gitDag7gr65IGdtnpyhFnqhpF5Encaqujo1ioHAr3aEWsWYVocfD2RC9k
         O8ns3/KVSAOVqsGiNiw225NAvQPIPCm1ZeZEvi+6Vtje6UxUvGIm0o0+Apv17fZSA2+7
         pk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736390229; x=1736995029;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8uNJ/vXA7NGF0yxSiSP2RkC1jPs5fLciqUxBAB6Mg4=;
        b=H7PPXCE3CAcYQiuZrEShRIaGOedg5L+s31iAJIhWR+a9gIXb1ueJRjPAYQudAtThHv
         DpO71E7BM0F4DEa4BKlXmRsvNiQN3QwEpXwTDDeZYjtHnzfIWHli9ct3BJhtF2025mxj
         7kgEPmC/pmPk6iDU2+phuXseRYRkvZqqsCEHL3yQ50uVBnCQiqtvHBfRpNcXt0rzClGB
         QseX8wWfm3B4Mr17tH5z99JBpABHXEc2wKjyPJlM2bXEvGLPudfxTyiSAbySDHBDf4cV
         MhSvPGcfXzr0nTVD0232XatIsQuMJB2cba+O2ScbaRQMUEdgT0JAzl9fOo1ViCvn0x18
         JGxA==
X-Forwarded-Encrypted: i=1; AJvYcCXgJESn7wU3ikwvocqeGqv5c0vHkgRZPPD20RPlpphoVOObsMfyd1LBc/SHZjxGph5jOSbWkAqWgO1Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/QwTjeb2o1lFOrD74JT861Ww0LTSxsSytSNrtxhNe6wvSNYuZ
	PAdWp5JVORzcenk+ypK5zjP1D8jTiFKwG5uJ5ZxeKtEq1Wf7FxfjPAWIBNo8NYs=
X-Gm-Gg: ASbGncs4NTAhtw4jcRBkjYbQloO8rNDujJOvcc+3TTsR+ZelCarcQgzvNoT6Cf2mBw8
	vJ8MNoQ/dLZmAQjmm61KzECvqXG7ECO8uWuS4+r00fArqSlPEWcKBiupkTbq2+ZcNKmRdpH7rMb
	UlLKwFcRmy/0ITtNoyMMhuafVyed+yEcbFWKO+oGG3wdhHU9nz+Q2PGvLS3we4NhzqJKxfBPZdv
	0svvZW/7skGmaNV+xwBaEpDDxmHXvTHEQ3VWbS/wIdeNm7Fb99Hjg3PDsgIpaeCMbBuIfW5
X-Google-Smtp-Source: AGHT+IGVzuij+AKiFn6JZ/AhNKkDrzNH0Ndanr6WScQLIgsjOR9DqwmkL0oU+ZNwTPU4nKFihV6eJw==
X-Received: by 2002:a17:90b:2e0b:b0:2ee:45fd:34f2 with SMTP id 98e67ed59e1d1-2f548ea07d8mr7124415a91.6.1736390229221;
        Wed, 08 Jan 2025 18:37:09 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9176bed6sm1434365ad.12.2025.01.08.18.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 18:37:08 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 08 Jan 2025 18:36:28 -0800
Subject: [PATCH v6 13/16] perf tools: mips: Use generic syscall scripts
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-perf_syscalltbl-v6-13-7543b5293098@rivosinc.com>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
In-Reply-To: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
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
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3q9md7W00duOmWFLr12xKZyhs8KW/ZH1Zd1NdcdrvCYb
 cuSNTGko5SFQYyDQVZMkYXnWgNz6x39sqOiZRNg5rAygQxh4OIUgIn0bGH4n97N/vg+xwXHJm6m
 L2wzxDw25bEqd7/8dCN7WUs2h/DFdkaGzh73v3MtkmLNQ84Jt7rEf3DftWTO6q2fOCKyNry/t2c
 HDwA=
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


