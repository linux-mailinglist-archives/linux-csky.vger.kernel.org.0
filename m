Return-Path: <linux-csky+bounces-1368-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1689F43FB
	for <lists+linux-csky@lfdr.de>; Tue, 17 Dec 2024 07:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85E6E16ACEE
	for <lists+linux-csky@lfdr.de>; Tue, 17 Dec 2024 06:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B7E1DE89B;
	Tue, 17 Dec 2024 06:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NcbyOVJs"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ECD1DDC3F
	for <linux-csky@vger.kernel.org>; Tue, 17 Dec 2024 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734417565; cv=none; b=XIi8ZcFAksVQ6ua2gFuOC781l8cDkVlDQhlJHmwIJuBAmYgq//s1zaYGOORb5nY5lbw1Jw7FBvDXi47IXqS3wJRPg4Hm/C5sLZZDC86f2EVEqLUDgvtQpNP+b0G3Rbnav6jjQchgl8MVpQRIpNEtSJIAxOqp2UEaJlLYjixgiRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734417565; c=relaxed/simple;
	bh=G5z4ZauX9QfJoBAuCbuGuwLJbsOqwLsh16GJRVCk8oE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cm9MRbkq8Kl5PZO4TOnkWnSoGJH4QFnWA6tZiegAUsbbUN2VRoigaNoe0RtKSSoVD8hDhcHvws1ypscNLqEEF/CkmoNOjP6Dygj/752cQri/6XDTqr3eGz5oeJ2bqGBX0g663qNyASAIvr6jZuMgq2ly56VtDKfGXs3HHgcdBlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NcbyOVJs; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee74291415so3413735a91.3
        for <linux-csky@vger.kernel.org>; Mon, 16 Dec 2024 22:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734417562; x=1735022362; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euJl9W34MyY1TVJyYJNiwzcX7XKHzg3BpRu6zirxvZk=;
        b=NcbyOVJsPu8tYgKbFq/qoe1na/Jh8+JuJE1wBNL5Qi3sYArgktacCSGZL3Hl2My3VW
         TY4LX6UluL89XOdBEOYPGX1MA/UimZM8wN0L9BuCP/93s4YlUeDluHXtdtQq/7FCZw5Q
         e6qNxkRRbwZIyGoizSePDl6cASBn32ZSDqR0FXFT+W2sUlDRLcy8k4TWMO5XqzaS+fog
         Bxsdsyre81vHMR/G1dF7TuBMmZLiuwF7kcYo3Yg6xbr3BNHqQfXmg2kRhM56NwHzMRCQ
         XVDSJiB68/n0tTWP1OTcrsK2vlG4lSRwRxU0ZuwuGMuD+4Z+yFmAgAjOHdL5P25gBic7
         d54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734417562; x=1735022362;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=euJl9W34MyY1TVJyYJNiwzcX7XKHzg3BpRu6zirxvZk=;
        b=qIhCg7WAtz/gYHkXFbWOlcLcUdKCqvzSEXu7RLL/7sApjluGdC1EosFHcLk6XsfB3X
         ZdlDKs/IiyTDBB9IHAo0eBDt1mHuxCsY6BaET3uvFeNEhVdbR32VXGoM03CgAfq//QHX
         D2uRWAbEjypPTVxx87lp/TUx5orbjp6LpEFVipMt+0M1Fs4xmFkRZ+jr6eiyRqzOcs4I
         J1Nr2VtFLwUUfp4JcvBT3u18v+oArC5SJpRhPIvgxziAjXXHVqXsN37FS5DdfFezTXSR
         5663Qop+G28XxxoaILzGyYmFrkVgj578373t1VxtyFYIa3OPEyGV/j1MMAHqgTj4Aja2
         NC9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXH6ejUcnud4VikApMVvIZAF86XFw/q07zoiLhtbPRAaFxxtOU28Hi/fRLpYTxqdOFWTgqKtlAZNBFR@vger.kernel.org
X-Gm-Message-State: AOJu0YzhjmCFsfyWdS2CCrn6a766ny4JRdoDmIjqeOkp22mhg0grXUBS
	BiyvNxZUW4Bq1x9E2Pia2ujChVGy+YE4eCGqjInjk/Tb/Ez1KjLcF2YMBGm38fc=
X-Gm-Gg: ASbGncurvbccGAuVN/WroV9aI5xPtaoKUY4baaVIWoWR5hnsr5iBvzEtXaHHljD3mPp
	SzELU8gdvX/Mw0bO74r0KK/kiH9vurpOTeom5eLsLID5uMfN84O8IUYuoqqH7wbzJB1cKdMz3O2
	DUZa2wKSYilUh1d8JT+TcpS110wSKKOrL6a1RRqt6S+qLbaSDeeFc/9SniBpZV29SI3spCsHkZP
	5+odnWk7PBmsBw7kmh2fT0YljK567yItM9hsItGhFwiXfO84qe5rge5d+k5TDlTipsB4GRu
X-Google-Smtp-Source: AGHT+IGqlnl/b+gh5FmvpZNT+WBF1msYf06NK1q7eNepM4VuIgvGGzEtp129msaKSOCVAB+ecLoVyw==
X-Received: by 2002:a17:90b:2744:b0:2ef:33a4:ae6e with SMTP id 98e67ed59e1d1-2f2d7d9fd46mr4370548a91.12.1734417562182;
        Mon, 16 Dec 2024 22:39:22 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142d90d6bsm9179551a91.2.2024.12.16.22.39.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 22:39:21 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 16 Dec 2024 22:32:47 -0800
Subject: [PATCH v3 02/16] perf tools: arc: Support generic syscall headers
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241216-perf_syscalltbl-v3-2-239f032481d5@rivosinc.com>
References: <20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com>
In-Reply-To: <20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com>
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
 Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2837; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=G5z4ZauX9QfJoBAuCbuGuwLJbsOqwLsh16GJRVCk8oE=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3qiTO+vlgO3Hd8++fViiVLG/IlH+7/5Pp7K4MmiKel2X
 aiKIWFbRykLgxgHg6yYIgvPtQbm1jv6ZUdFyybAzGFlAhnCwMUpABOJbmX4n6Qqum7v/HWGU0TK
 lj0Q0FOekfquOuv3QimdqgXvDh96e4Xhn8WStvWdm9++S/nnaXA8SPuaC1uTSdu/mMqt82V2nD+
 swQIA
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
index 6e4d0ef58ccb40da793f3ab8cca77d620d258bb4..d3c12c6ba6764e9a8b12acee603a0509154f2c74 100644
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


