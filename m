Return-Path: <linux-csky+bounces-1340-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A789F00DE
	for <lists+linux-csky@lfdr.de>; Fri, 13 Dec 2024 01:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEAA6188D143
	for <lists+linux-csky@lfdr.de>; Fri, 13 Dec 2024 00:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09684182D9;
	Fri, 13 Dec 2024 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BsxPjUM2"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3733EDDBE
	for <linux-csky@vger.kernel.org>; Fri, 13 Dec 2024 00:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734049995; cv=none; b=f56PPv6EKpFoYrkhbm/DrYshQ/eGZBUYBQ8ZHy/18z3c0/YazPh4R28hZ3WVR2w8imDQJZ47qozJEzzL+8sp7vZLGLhR75OtMroMkDWTl570/UEcp+y18Cq+Fl1uYgbeD+PvYhvC6BPE3IDc4X7D6eJx/WRSEsBbFInUeZCiCDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734049995; c=relaxed/simple;
	bh=IQtfuUT0+eGZ51OwwywtWIPS5QSw2EsnD9K86OE9bhw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WpB5vp9z4rb8/RbYh6SnBR8VrTjYhw5IPA309Xh1YwXVIkG2rjyklGoR0erD0qlOp9m2mjQ5MnoLhXoCkUOGN5geWWgVbeZ5qSSErEKh4KpsiXRcggX0W3F0LVz1cpUwyLhDVKe83oeAae89osHwOb+nM3dorDNqaC0LVQUJH4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BsxPjUM2; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso990658b3a.0
        for <linux-csky@vger.kernel.org>; Thu, 12 Dec 2024 16:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734049993; x=1734654793; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x/t4tAnrXs8dbqT90IARLfldAs+rJPVA/lhEFBD44es=;
        b=BsxPjUM2rRrUQUQ0leQAsyEBnudUfLUiSscfanhA3lw9tM15qIZ1pTrWZ8V58Js6JW
         4x0oLX4nCVVG5srsUvkF3yG604MecM6lLevn4wUtvarZElKXk2TtQyZkIc56iAVqEAX0
         2tUpyx6EmGid4CQqJHpvpysbvMn+QYi5L5puj/1cvp6875vA0FlAmoMC/35OJFKHOCSl
         gU6CnoNPWTGDh311cgOj3PdY7AHoqo+iVIT82NKIMJn2nFh7FdLrGUoTD30fNcmaxoZ/
         p3YeFy68G7mOU8efe++wUALhLvuJz7BtvpFp6jT6H5En91tm4R8ST4TA4tnE7LjZb+E5
         y4+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734049993; x=1734654793;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/t4tAnrXs8dbqT90IARLfldAs+rJPVA/lhEFBD44es=;
        b=ag06hHkl5wXrPuf8/t0paxNQpgpi2aqen+q/zzS1yu3zO+o3G7Rlh6jK6PbJYHLetN
         bA4MxsbH63W5ITG7e3bX4q2qNNbB2MDJj5hDR2sKjrEuRIdqApesSScHk7uVgt4sDLHI
         bovKTkRoadP7ojNzZl+EpzsAqTL+YWu6FQgQCEeRHBMVIhEww6cf+F9tsycSsWveSVxg
         XrBLgxYnMHXFZpPLBMqTPQai2PfXXSGm++wH3mLQ33YzZcxVmo6R+xeoNdkttKWQqN4h
         CPvAv0myjma8pBARhKemTcyXFeD3jnktHChH6XwiuLd6oo0fuJBG9POykmg7HLB7wdzw
         b4Yg==
X-Forwarded-Encrypted: i=1; AJvYcCU0FfjmeZpTVrekfZ0622rX9uVT6DuAL/xY2XlUxjWFf+ZEwPPDxGkZL0KBln/DVCTb1mkS6cjjv1oe@vger.kernel.org
X-Gm-Message-State: AOJu0YyiT/oaL0vUI13GoL117Fi9emgnXN+Vg6t+FG9nPHVj0senyabP
	5z+c88FYf45QASyKfX7+2mGSHM8WMzBovLoQ5xB9quvlTKKrCkDqIXGg797N7pA=
X-Gm-Gg: ASbGnctkbaWakux5XcrGVRlPF+s/6/xsgGTFOiwmQPtB2VaJf98GNq55WFxIrV/DC4H
	qe/KzSgQAPjzAfHNVMhxjYy2+dh/WmF/3BM34uJsNj6hcKn9/bJ8oZcydKRZWU2rCSfSlsAraP7
	os0l8s6Z5uSi53zzd242us1dv6IK4NYVRiVHMIbeEdxOV9AIhndPnZuhaP5gVCws6NnKcB8KgCy
	h/dHZ+yXKs5R6T+sKGz98Jsxnm1V08Ycudv7Ibp37wyHeIhnUyl2VkOcm96gRW6ak8QKBi3
X-Google-Smtp-Source: AGHT+IEd23eNeza65b/mFf2Ef1epXFx4Y/eggrgjqxpS7nxWsumxa7/TVE+fCJ8K+wC5TazJMd2/IA==
X-Received: by 2002:a17:90b:54c7:b0:2ee:c9b6:c26a with SMTP id 98e67ed59e1d1-2f28fb68ef6mr1014242a91.11.1734049993490;
        Thu, 12 Dec 2024 16:33:13 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142e0ce50sm1934462a91.39.2024.12.12.16.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 16:33:12 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 12 Dec 2024 16:32:52 -0800
Subject: [PATCH v2 02/16] perf tools: arc: Support generic syscall headers
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-perf_syscalltbl-v2-2-f8ca984ffe40@rivosinc.com>
References: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
In-Reply-To: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2767; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=IQtfuUT0+eGZ51OwwywtWIPS5QSw2EsnD9K86OE9bhw=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3p0w97f96cdWBjf3P5j8qf/XPecPv058Sizvjb1nfH/N
 DZe06qojlIWBjEOBlkxRRaeaw3MrXf0y46Klk2AmcPKBDKEgYtTACby9R8jw6mSmU2bFY+3Lfy/
 XOjNdrf3s3MDnGu57qrvuLzXbt28jB+MDKsnS+vzMHHtjLyR+cPn56XF7vwGb3eaLjRf//zjQ7t
 NKlwA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Arc uses the generic syscall table, use that in perf instead of
requiring libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.config                           | 2 +-
 tools/perf/Makefile.perf                             | 2 +-
 tools/perf/arch/arc/entry/syscalls/Kbuild            | 2 ++
 tools/perf/arch/arc/entry/syscalls/Makefile.syscalls | 3 +++
 tools/perf/arch/arc/include/syscall_table.h          | 2 ++
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index a72f25162714f0117a88d94474da336814d4f030..3959a9c9972999f6d1bb85e8c1d7dc5dce92fd09 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -36,7 +36,7 @@ ifneq ($(NO_SYSCALL_TABLE),1)
   endif
 
   # architectures that use the generic syscall table scripts
-  ifeq ($(SRCARCH),riscv)
+  ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))
     NO_SYSCALL_TABLE := 0
     CFLAGS += -DGENERIC_SYSCALL_TABLE
     CFLAGS += -I$(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index f5278ed9f778f928436693a14e016c5c3c5171c1..3b463b42b0e3982e74056e672b2ee6adad5a3f0e 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-ifeq ($(SRCARCH),riscv)
+ifeq ($(SRCARCH),$(filter $(SRCARCH),riscv arc))
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


