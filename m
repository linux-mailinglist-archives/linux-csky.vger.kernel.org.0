Return-Path: <linux-csky+bounces-1221-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 489CB9BBF57
	for <lists+linux-csky@lfdr.de>; Mon,  4 Nov 2024 22:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BDE61C204F6
	for <lists+linux-csky@lfdr.de>; Mon,  4 Nov 2024 21:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F33C1FB3C9;
	Mon,  4 Nov 2024 21:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="KoWLTJ32"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EC61FAEF0
	for <linux-csky@vger.kernel.org>; Mon,  4 Nov 2024 21:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730754413; cv=none; b=l4yePdL8QWyR6hleUzKlo2qyt4GUC7TkktGdGaTEIhHupIB2uBhH6kvDip5Ohk1blrkPY2+CM63xsePxzNNLRzxgQENXBDHdiNs87DNzU1z+6vkqgoHQ4LSjFIRJovzacVXxsCt8Mmqq9jKmzKlr5pH1Nk1SiK4Q7ECLGVURhlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730754413; c=relaxed/simple;
	bh=ZitlmStPUDyqE42TaZ1/Aw7xZREQZHuveVKJPTTwCSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J5Zmc6ZX+1O4Mq42474L1hMLuqI6I+kNRLk2giPrDc3PFVYyFQZiffQLDTlii1S8uT3zJCMncb5JS1R4hoXG0M4ZPx+pn+lNWHH1xhNAQKgK7uuAnWwRtuOfVfhDAs9CujM3vJtefCGh6d797VUdR1yK9LvOoAW66CsK+BGW2lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=KoWLTJ32; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71e5a62031aso3803436b3a.1
        for <linux-csky@vger.kernel.org>; Mon, 04 Nov 2024 13:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730754410; x=1731359210; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+963qXEwYm2XJW7YS60AKfnebwcLNYV8rSqgqXSlsc=;
        b=KoWLTJ32jbqoNjinww4vRlZ3HHgt7MYgMJ52xGcry7wXQzaI1E+gI2vO6HdeQukCWn
         ss3FHBvF9CXLUIuZIaMCKwb/SEelmP8BZKrZvFs5bspJl+gxXiwKdtkLBdCBA08XWU9m
         T4XmfzBRSyBkzPj7udAKSuowzA+piu0M8RJU22o1/Lfaaqkw5s4olZB9LY/spFNbREWa
         NyGBgaqDG1aKHtlw6MMiJqMdNLmD94K+HhW4DEnVL0jRdBLEFMOq+5+S4TVtXNnMi2ig
         SjHlpa3P8GVAWZwsdtjPMPO2kWGrTCTzvPFrfjmsjDujRqQ6VHAokkA47nluml2wXPjc
         qwXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730754410; x=1731359210;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+963qXEwYm2XJW7YS60AKfnebwcLNYV8rSqgqXSlsc=;
        b=BxDNFnWKOi304EYfWbxgVWDoPHdHlgvZNUeSV9foQ6QCtpCPmovhb5qVWPb5VvKZgC
         jy5P4uTT7mn+d7BxgpDHa62wq/i5U7DWx+1F7QxA3cnDp17z0ziSUsEtA/oHA/u53vxE
         sRSFabM7GAPMvGxWJ4HBp46WW+1VL910KjOENF7uLXVU4XcjusbNurMj8yyBxVkS54xu
         LfWsCW3vniZlZfuvIQz8IrTu6oGY9S7n0ej9Mf3+RNe58CjjT27q7NbXbZJF1pHBuftw
         wwUoAcOVuXSz1f430lclXaQ8DBSGH49SKXYFz/JAbcv1Lz9xcAcAcivqytDSef//SzNV
         HiwA==
X-Forwarded-Encrypted: i=1; AJvYcCVp83CIdZGP9+FI/8C8rmxfzj7J7gBX0ITFQvMnuRjB3oNnA8A2P4eoeeD9B7ASrnEZGCzB5uj3nUYW@vger.kernel.org
X-Gm-Message-State: AOJu0YxXjx3aFdN9OP0D/dDOVyJKRFpl3Xnb4lV7oBY9eElfhSsCK2uy
	gpveaIiSTBXeh0ZmtYO5OomewA/0nB+GdBAp0edYAjf94jvk0Jr2iD13xKgT0yE=
X-Google-Smtp-Source: AGHT+IF56vX4uXLDm1AHdM0OyBuJkwT7LeC8FxDJ053gvmIEUtUOVtkQSjLnyUylcTDwbzpxIp0ndA==
X-Received: by 2002:a05:6a20:3d88:b0:1db:ec5c:cae7 with SMTP id adf61e73a8af0-1dbec5ccb0bmr2012154637.40.1730754410022;
        Mon, 04 Nov 2024 13:06:50 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee490e08f4sm7248293a12.40.2024.11.04.13.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:06:49 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 04 Nov 2024 13:06:05 -0800
Subject: [PATCH RFT 03/16] perf tools: csky: Support generic syscall
 headers
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241104-perf_syscalltbl-v1-3-9adae5c761ef@rivosinc.com>
References: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
In-Reply-To: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
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
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2542; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=ZitlmStPUDyqE42TaZ1/Aw7xZREQZHuveVKJPTTwCSY=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ7qmebSPvJLnlxCDzruxNWwTI9QuWXrtCxerXi23pumc1
 TmjYJuOUhYGMQ4GWTFFFp5rDcytd/TLjoqWTYCZw8oEMoSBi1MAJnLnEMNf2dTNCj4yGg/ju9Z/
 PpMy3XOKlK28r5DDSzEJ47VhC9v5GBn+SDgfyNnayyra/erw82XVu80mWx/ya+lR2ioWWRZ7/x4
 HAA==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

csky uses the generic syscall table, use that in perf instead of
requiring libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                            | 2 +-
 tools/perf/Makefile.perf                              | 2 +-
 tools/perf/arch/csky/entry/syscalls/Kbuild            | 2 ++
 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls | 3 +++
 tools/perf/arch/csky/include/syscall_table.h          | 2 ++
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 504d762cc572..a19c59c8cd3b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -36,7 +36,7 @@ ifneq ($(NO_SYSCALL_TABLE),1)
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky))
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)arch/$(SRCARCH)/include/generated
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 02ff3f2fcf12..7c5fba39d8e6 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))
+ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc csky))
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
 include Makefile.config
diff --git a/tools/perf/arch/csky/entry/syscalls/Kbuild b/tools/perf/arch/csky/entry/syscalls/Kbuild
new file mode 100644
index 000000000000..11707c481a24
--- /dev/null
+++ b/tools/perf/arch/csky/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls b/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
new file mode 100644
index 000000000000..ea2dd10d0571
--- /dev/null
+++ b/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += csky time32 stat64 rlimit
diff --git a/tools/perf/arch/csky/include/syscall_table.h b/tools/perf/arch/csky/include/syscall_table.h
new file mode 100644
index 000000000000..4c942821662d
--- /dev/null
+++ b/tools/perf/arch/csky/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_32.h>

-- 
2.34.1


