Return-Path: <linux-csky+bounces-2720-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A8BD38C9A
	for <lists+linux-csky@lfdr.de>; Sat, 17 Jan 2026 06:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 08BB73082EDF
	for <lists+linux-csky@lfdr.de>; Sat, 17 Jan 2026 05:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE8332E73D;
	Sat, 17 Jan 2026 05:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bqrvWrE8"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A132E13B
	for <linux-csky@vger.kernel.org>; Sat, 17 Jan 2026 05:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627791; cv=none; b=GDsWTGnTWEKJGzvsI1zfAhfnk+xAd2SpYrfVRj/dW/ROsnd0Ek7YZFelfOqGHN/eFr1VdAp0HEpvrfq/j5V9HlzZyuj7VhW8vRxklOb4LjyWwQFsdBgtLTsUpdCLpZoNgfXQv5weXqxkzkuh2J0TmsWXFxTGC81O72QLovFJHNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627791; c=relaxed/simple;
	bh=y+7xwECacuSecCHUYo0NfRyFbUfHA3IiYvvx0zQIYLg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=IH8spB08hjOJSeS7dDGjj602RAoKgIM8MnrL8+l3g+G+7iqBd15jBycYPXgIVFODSNUefed9rExbbDDGY3S7JT9sciCk1uKH7yPm6/AfH4Hp9m9DFWtKdwYHK6Wut/ic2bICQQPaoCYdjKJFdh/KSirhuRV3DqriiOChDrd9Kj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bqrvWrE8; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-123840bf029so6319094c88.1
        for <linux-csky@vger.kernel.org>; Fri, 16 Jan 2026 21:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627789; x=1769232589; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6lN+KscSViLQGaAIPX8L5X1lA4liB4Ix5iRxCo6bIiA=;
        b=bqrvWrE8ZVN47imdOv26FYuG1P/Co382Zh+avN095lahKUODQItRD9u+n5dkO+tkem
         7Y7hqULDi6TgiKMmnTKtFPgXZt0Ipd1zyitbgvfbApHk3g0eW9EgQ/vbOILJi9QFhS2S
         rthK7l/h6kSTwW2o0zHY6dpB1r3/4DhGXtRXNdZocHR6WhOuAgHolV5UBkUsfXI5sBFt
         PJHNw8iIW+Ap5yvvTm74dAB6M6f6i3gOz1pRVOU6t3a4oXap5cEDCLQ0kwXOIaPtABNx
         nHkdoFrYZURr8idx7ofb4IXgSBNd3qWCtvVQtgt9FbE53yKwPdofq5k1TWHF2P6sMj8v
         6DRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627789; x=1769232589;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6lN+KscSViLQGaAIPX8L5X1lA4liB4Ix5iRxCo6bIiA=;
        b=Nd8iEvwuEJbkqB15JhlsOLofRqRacSsK88i8yTnn/mg+nHNYGO6grDrWTLri+VU1h0
         q/PIvjMDguhVdtbm2VjlKUp1BJ6l3gRXt9PWd8xpfsoQNM3cEi5msjIIBYAfMH7cG9xx
         e/fHlcZ+TxypQJ28uEoQ0iFCcdxvfwUGZJMSPLGx/ZCNjsgo0HiyElDCuSgs9YXxtyTD
         tNLarsL19+6CuLVPhxDmdUDF9N3oMQwKUfXchEjZV2xBvm1Pi1i4kyN/8vK6qPCKZJ9c
         HWiB8NxvGT2tbCMNhpEegWXv89ogRtpf/FCWxOIRW66NWwVdAW3qovNIreBiTDH8o5Ww
         GTMg==
X-Forwarded-Encrypted: i=1; AJvYcCXXUXTKAuEDBDhcWHGC8RUWkfbyGFEWbrTz899WhJL+fLk3hDEA19nRyWaIsv1FD/B54K3bU4XV+lQ0@vger.kernel.org
X-Gm-Message-State: AOJu0YwwZv46JS27nhV9FEfOWdWZ0GUyVjDaanMoYIBhPo4j9dGn9hHg
	xU/EuxAlGUq9+VGxMW0UA1LH7+C2OWnI+Fc0AjXmMYa8urjvyzqbkPMoTYdVzbY4/7EEhny4ZWW
	O3DrDeWEryA==
X-Received: from dlad21.prod.google.com ([2002:a05:701b:2215:b0:119:49ca:6ba4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:a82:b0:11e:f6ef:4988
 with SMTP id a92af1059eb24-1244a768b4fmr4946929c88.36.1768627788672; Fri, 16
 Jan 2026 21:29:48 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:42 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-17-irogers@google.com>
Subject: [PATCH v1 16/23] perf dwarf-regs: Add loongarch perf to dwarf
 register number mapping functions
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

These functions allow the generic initial register state code in
unwind-libdw to be used.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dwarf-regs-arch/Build         |  1 +
 .../dwarf-regs-arch/dwarf-regs-loongarch.c    | 12 ++++
 tools/perf/util/dwarf-regs.c                  |  3 +
 tools/perf/util/include/dwarf-regs.h          |  1 +
 tools/perf/util/unwind-libdw-arch/Build       |  1 -
 .../unwind-libdw-loongarch.c                  | 57 -------------------
 tools/perf/util/unwind-libdw.c                |  5 +-
 tools/perf/util/unwind-libdw.h                |  1 -
 8 files changed, 18 insertions(+), 63 deletions(-)
 create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-loongarch.c
 delete mode 100644 tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c

diff --git a/tools/perf/util/dwarf-regs-arch/Build b/tools/perf/util/dwarf-regs-arch/Build
index 3f19a9ec47c7..188359376ea5 100644
--- a/tools/perf/util/dwarf-regs-arch/Build
+++ b/tools/perf/util/dwarf-regs-arch/Build
@@ -1,5 +1,6 @@
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-arm64.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-arm.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-csky.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-loongarch.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-loongarch.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-loongarch.c
new file mode 100644
index 000000000000..203077b740a0
--- /dev/null
+++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-loongarch.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <errno.h>
+#include <dwarf-regs.h>
+#include "../../../arch/loongarch/include/uapi/asm/perf_regs.h"
+
+int __get_dwarf_regnum_for_perf_regnum_loongarch(int perf_regnum)
+{
+	if (perf_regnum < 0 || perf_regnum >= PERF_REG_LOONGARCH_MAX)
+		return -ENOENT;
+
+	return perf_regnum;
+}
diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
index 7fa0930fd298..033218f14b36 100644
--- a/tools/perf/util/dwarf-regs.c
+++ b/tools/perf/util/dwarf-regs.c
@@ -205,6 +205,9 @@ int get_dwarf_regnum_for_perf_regnum(int perf_regnum, unsigned int machine,
 	case EM_CSKY:
 		reg = __get_dwarf_regnum_for_perf_regnum_csky(perf_regnum, flags);
 		break;
+	case EM_LOONGARCH:
+		reg = __get_dwarf_regnum_for_perf_regnum_loongarch(perf_regnum);
+		break;
 	default:
 		pr_err("ELF MACHINE %x is not supported.\n", machine);
 		return -ENOENT;
diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/include/dwarf-regs.h
index 7780bc07e70e..bec15fb53e73 100644
--- a/tools/perf/util/include/dwarf-regs.h
+++ b/tools/perf/util/include/dwarf-regs.h
@@ -109,6 +109,7 @@ int __get_dwarf_regnum_for_perf_regnum_arm(int perf_regnum);
 int __get_dwarf_regnum_for_perf_regnum_arm64(int perf_regnum);
 
 int __get_dwarf_regnum_for_perf_regnum_csky(int perf_regnum, unsigned int flags);
+int __get_dwarf_regnum_for_perf_regnum_loongarch(int perf_regnum);
 
 /*
  * get_dwarf_regnum - Returns DWARF regnum from register name
diff --git a/tools/perf/util/unwind-libdw-arch/Build b/tools/perf/util/unwind-libdw-arch/Build
index 5fa1754fca8d..62a4cbf2dca8 100644
--- a/tools/perf/util/unwind-libdw-arch/Build
+++ b/tools/perf/util/unwind-libdw-arch/Build
@@ -1,4 +1,3 @@
-perf-util-y += unwind-libdw-loongarch.o
 perf-util-y += unwind-libdw-powerpc.o
 perf-util-y += unwind-libdw-riscv.o
 perf-util-y += unwind-libdw-s390.o
diff --git a/tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c b/tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
deleted file mode 100644
index 5fca673508be..000000000000
--- a/tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
+++ /dev/null
@@ -1,57 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/* Copyright (C) 2020-2023 Loongson Technology Corporation Limited */
-
-#include <elfutils/libdwfl.h>
-#include "../arch/loongarch/include/uapi/asm/perf_regs.h"
-#include "util/unwind-libdw.h"
-#include "util/perf_regs.h"
-#include "util/sample.h"
-
-bool libdw_set_initial_registers_loongarch(Dwfl_Thread *thread, void *arg)
-{
-	struct unwind_info *ui = arg;
-	struct regs_dump *user_regs = perf_sample__user_regs(ui->sample);
-	Dwarf_Word dwarf_regs[PERF_REG_LOONGARCH_MAX];
-
-#define REG(r) ({							\
-	Dwarf_Word val = 0;						\
-	perf_reg_value(&val, user_regs, PERF_REG_LOONGARCH_##r);	\
-	val;								\
-})
-
-	dwarf_regs[0]  = 0;
-	dwarf_regs[1]  = REG(R1);
-	dwarf_regs[2]  = REG(R2);
-	dwarf_regs[3]  = REG(R3);
-	dwarf_regs[4]  = REG(R4);
-	dwarf_regs[5]  = REG(R5);
-	dwarf_regs[6]  = REG(R6);
-	dwarf_regs[7]  = REG(R7);
-	dwarf_regs[8]  = REG(R8);
-	dwarf_regs[9]  = REG(R9);
-	dwarf_regs[10] = REG(R10);
-	dwarf_regs[11] = REG(R11);
-	dwarf_regs[12] = REG(R12);
-	dwarf_regs[13] = REG(R13);
-	dwarf_regs[14] = REG(R14);
-	dwarf_regs[15] = REG(R15);
-	dwarf_regs[16] = REG(R16);
-	dwarf_regs[17] = REG(R17);
-	dwarf_regs[18] = REG(R18);
-	dwarf_regs[19] = REG(R19);
-	dwarf_regs[20] = REG(R20);
-	dwarf_regs[21] = REG(R21);
-	dwarf_regs[22] = REG(R22);
-	dwarf_regs[23] = REG(R23);
-	dwarf_regs[24] = REG(R24);
-	dwarf_regs[25] = REG(R25);
-	dwarf_regs[26] = REG(R26);
-	dwarf_regs[27] = REG(R27);
-	dwarf_regs[28] = REG(R28);
-	dwarf_regs[29] = REG(R29);
-	dwarf_regs[30] = REG(R30);
-	dwarf_regs[31] = REG(R31);
-	dwfl_thread_state_register_pc(thread, REG(PC));
-
-	return dwfl_thread_state_registers(thread, 0, PERF_REG_LOONGARCH_MAX, dwarf_regs);
-}
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index a193163da707..9c8dad643cd0 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -292,16 +292,13 @@ static const Dwfl_Thread_Callbacks callbacks_generic = {
 	.set_initial_registers = libdw_set_initial_registers_generic,
 };
 
-DEFINE_DWFL_THREAD_CALLBACKS(loongarch);
 DEFINE_DWFL_THREAD_CALLBACKS(powerpc);
 DEFINE_DWFL_THREAD_CALLBACKS(riscv);
 DEFINE_DWFL_THREAD_CALLBACKS(s390);
 
 static const Dwfl_Thread_Callbacks *get_thread_callbacks(const char *arch)
 {
-	if (!strcmp(arch, "loongarch"))
-		return &callbacks_loongarch;
-	else if (!strcmp(arch, "powerpc"))
+	if (!strcmp(arch, "powerpc"))
 		return &callbacks_powerpc;
 	else if (!strcmp(arch, "riscv"))
 		return &callbacks_riscv;
diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-libdw.h
index ee56f1e827e5..9d177d70f15c 100644
--- a/tools/perf/util/unwind-libdw.h
+++ b/tools/perf/util/unwind-libdw.h
@@ -9,7 +9,6 @@ struct machine;
 struct perf_sample;
 struct thread;
 
-bool libdw_set_initial_registers_loongarch(Dwfl_Thread *thread, void *arg);
 bool libdw_set_initial_registers_mips(Dwfl_Thread *thread, void *arg);
 bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *arg);
 bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg);
-- 
2.52.0.457.g6b5491de43-goog


