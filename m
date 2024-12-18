Return-Path: <linux-csky+bounces-1389-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 068CF9F6165
	for <lists+linux-csky@lfdr.de>; Wed, 18 Dec 2024 10:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8AEF189614E
	for <lists+linux-csky@lfdr.de>; Wed, 18 Dec 2024 09:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6010519AA72;
	Wed, 18 Dec 2024 09:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="sjFErZ6T"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC3B198A1A
	for <linux-csky@vger.kernel.org>; Wed, 18 Dec 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513875; cv=none; b=dN0vh+nF6iznJbVqGgQQmVtCbQNVXBGvjcUkfXRW9i1ld6twI4DeQ634fvew8tDWEKDBymq3gDZN6mHtH1+fDA+IjyrcnnlUwkBwCbkpNhJ3OHM5voH6yal9tErUldVErczmh87T0RDMCvOSxjhpcrsdFFgeEN+u1+LafDIZI8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513875; c=relaxed/simple;
	bh=X0SL5q6fWt+9GQtD73LJR9GwlfHvHpAQdAMzHn+mSzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C1RZsYrEQuKF8Z9P4ROBA5CsMj1Abi0oT4HhdErfCZawKV6D6G+D1PcXBRM5R45HUDCPEKO9hKB8eJOe5NeaCBgCs9NmtlUecjLOOjt+b5iexI1x3Y/HAN4qm5QynqN5VUGhw1SAbZlF1iFaRq1+ciMaOFX3Ww27XduXsfUY3so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=sjFErZ6T; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-216281bc30fso64694095ad.0
        for <linux-csky@vger.kernel.org>; Wed, 18 Dec 2024 01:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734513872; x=1735118672; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nj6/YILuiSz3bRgw8K5LxLTzKJz30pINSFnQS/0yP28=;
        b=sjFErZ6T5EkllPXwT26PlcvmoAiFrxAeiGxHkHg7eTsPVS9yD8vnMypL4yHYId9QPt
         hjmecVfHTyeiI0ozfy3wVxs4U69Bt5zTo79Glv0P0hKuc4X96uT74Z0dp/EdrQL3F1xT
         osaTV0jgKabdXF9AXc/qmaXERzPk/iv47zWOISnL4QkUHVT0Fo7wKs3rT5lbW6ewliJ2
         p1XJts2wQU1yBabvcVbiI4BBh5KnfOs/8E6O/XpcJu4TJw283iAozBlVaipaiJQAH3e4
         yQWZ+bGHrRIi6Br6JDUNln9urrj0A6UcfJkST2q65IhvOgNHfJ8oD5np8B2W/8pa4CNM
         r8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734513872; x=1735118672;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nj6/YILuiSz3bRgw8K5LxLTzKJz30pINSFnQS/0yP28=;
        b=UAMhiGU+InSKbu+iNAFxElW1mp1p3aMcRskuFM1omoJPJkqejEcU+i7dxqcq79NOmv
         +Czo7Lb75mU3Q08DJflUAOhNGpMvF2woDqWF6zc1yQ8K1+VFHZ82SqQL1rcOtTbaIdhR
         MHcuWMtNrmg3pVfIeTUlGCYJTV+fVw92Su3Ec5QPziHf2JHpi/lKpt6Hv5OHMR7ydML2
         Puhjoh6MG5klDtlh5wzTd6z8fbDadAU4teZZWMkO33Vix4dtrz6Ndw8NScCUi4zPKtT/
         EB8ZXEUolNJPb2Zc/PRB5Rp9MUJT1uyxrpHpatz/bM9X3Ylb+y16m9lUSMStBs+hyV4i
         ZQWg==
X-Forwarded-Encrypted: i=1; AJvYcCVpq5Pp1QsbsvEvGaphDNnIdYAE1ShIgTZWcInyn8KNqNuqObzwbgo+5WaPahf2o6wyj3McgTUOx0z4@vger.kernel.org
X-Gm-Message-State: AOJu0YzsjRtOiHcW9hsNzn46s31TdlJtxwP3cB1IQKwpYwPqjKmwex5P
	SqvC3zHHoZGBSzMMSCjlRO3uuxuTISpsA1b/EO8kCcttB7/SE2qpKxq0Z8OZVSY=
X-Gm-Gg: ASbGncsrPDUdJm+XSrAkjPVdNmV8xuIN2xub+0oPPXZgrfyMMOZv5NtCMJsRiwUwd9F
	gqQHdvhHnifDF584MAU6UIdlfd/napg/8lytN0GH5IDdQsNvpaP6PWkATYcpPLP7jTdBVMto9qA
	dWM7ohFBvfqqla3feWzecHiBigydZ9ymBO64YWb1cYp90rjhLtq+aZ9eoLiodZVXOxC7vYg4nZf
	754z7481lQ6Tbiz8Wpfbng3c6kJ73A7IG+B2VwimMoj5pTM4fTnLY0MJyNhRSUE2hYhOB8S
X-Google-Smtp-Source: AGHT+IEhtkJNUuqYcOVKrRhInclVGwI1wduL0wL1bhvLdKVEYtre3SXMJ70XIRjbVO+NQVZb+hCRFA==
X-Received: by 2002:a17:902:c94f:b0:216:281f:820d with SMTP id d9443c01a7336-218d6fd4bdamr25342235ad.11.1734513872495;
        Wed, 18 Dec 2024 01:24:32 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e64f90sm72119995ad.241.2024.12.18.01.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:24:31 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 18 Dec 2024 01:24:00 -0800
Subject: [PATCH v4 02/16] perf tools: arc: Support generic syscall headers
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241218-perf_syscalltbl-v4-2-bc8caef2ca8e@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=X0SL5q6fWt+9GQtD73LJR9GwlfHvHpAQdAMzHn+mSzc=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rSlCMr3t06b/vMLCnUT+ixhjTPiRNtF3rMD5lN+pdQu
 1GO76F1RykLgxgHg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABOZv5yRYXLJ4uXMjxPM2m1z
 WA9IJoRaS/P+MD9gVm/TntmiH35CgOGf2Wmt09vZeLQusHcJKKy+n+q0J8/Vo3zyXh/u44VuD/g
 5AA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Arc uses the generic syscall table, use that in perf instead of
requiring libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                           | 2 +-
 tools/perf/Makefile.perf                             | 3 ++-
 tools/perf/arch/arc/entry/syscalls/Kbuild            | 2 ++
 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls | 3 +++
 tools/perf/arch/arc/include/syscall_table.h          | 2 ++
 5 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 9ff49aeb4fa5d6015dea068f23ea3a135155eb6e..a09e2245a9ba00db79cf3a65e8772a6cb9b6c78e 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -36,7 +36,7 @@ ifneq ($(NO_SYSCALL_TABLE),1)
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),riscv)
+  ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)tools/perf/arch/$(SRCARCH)/include/generated
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f5278ed9f778f928436693a14e016c5c3c5171c1..f717e4628d9e4632f53fed16524a659a3e4feea5 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,8 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),riscv)
+generic_syscall_table_archs := riscv arc
+ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
 include Makefile.config
diff --git a/tools/perf/arch/arc/entry/syscalls/Kbuild b/tools/perf/arch/arc/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..11707c481a24ecf4e220e51eb1aca890fe929a13
--- /dev/null
+++ b/tools/perf/arch/arc/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..391d30ab7a831b72d2ed3f2e7966fdbf558a9ed7
--- /dev/null
+++ b/tools/perf/arch/arc/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += arc time32 renameat stat64 rlimit
diff --git a/tools/perf/arch/arc/include/syscall_table.h b/tools/perf/arch/arc/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..4c942821662d95216765b176a84d5fc7974e1064
--- /dev/null
+++ b/tools/perf/arch/arc/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_32.h>

-- 
2.34.1


