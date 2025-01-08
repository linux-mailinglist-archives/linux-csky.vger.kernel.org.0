Return-Path: <linux-csky+bounces-1525-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F5BA0500A
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jan 2025 03:09:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB216674F
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jan 2025 02:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34AD19C542;
	Wed,  8 Jan 2025 02:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="OTZHjyHA"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD41158D96
	for <linux-csky@vger.kernel.org>; Wed,  8 Jan 2025 02:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302098; cv=none; b=BAE4TDFijL2vpN99Kq36HMcI1dGtCyp0yVOqsWWs4L2R19AD/Moq5xSdEdwH+pO1MtyVWelvnhH1ajux3RIPdnMwZXd7kil6ijS7u8+1s278BH3o5SKNuFg51M7VFf3YjqZNOHebw3yZXNY8qw5IQl2aq6cA7fCJ9oozepZZ5Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302098; c=relaxed/simple;
	bh=ChjCi+WDWxIeAEQr9uB+RlwWvFzZ2k5NiZ20md8SwKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+VRDVTdGlYeVxTrB8Ojv0XBS4I8PICrFR3VOOo2mfQ/5tpKMnhKOrhPWGYMbHvzZj4LIwPruy7AgS2ORl/Qabq1afBeKg9rokyPGDWoWKA+RUpFleI5WQPdVk25eQegTdIOcx57J/0vRKEVNekPDs2g6dNVIFg8HZ8lUzOFlpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=OTZHjyHA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21661be2c2dso219493585ad.1
        for <linux-csky@vger.kernel.org>; Tue, 07 Jan 2025 18:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736302095; x=1736906895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05wirhUQV9Km8dQngc0z5Y797cbCbqNKIhJCCOZ4z1g=;
        b=OTZHjyHAqOQ5vnA6sweEHgQGMyVzHRVXV4UKdUqK8bGL6pRHrxeqxc0E0OpPa51sd/
         pzkKdmX5TgHArzBulCWqpI15TLFm3oQLm+58sx0VqiRrCDIIBD2Yt/1+jkRYc8s+4iFh
         V+2fFgoZehZJl0rGSrSz5zmUMhlshI9adlJn9OO7HzzLMFkhG8wciQrkCxgboeQ8A6p2
         ep9h187kyRwp9/zrKFhai2QvIh0Nu9SY/EXApq7XUUZw4InlGBb+aMcbf2xih2PVMhjc
         5P6D44FMnBmMEUIyTgqUuwj3rFjoqkim4yMp6ipRGKfQ4lLy40QLEDpVav4B5STy0F2f
         p/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736302095; x=1736906895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05wirhUQV9Km8dQngc0z5Y797cbCbqNKIhJCCOZ4z1g=;
        b=R0h/Zefvn9nUl3g6jMlZQJdgI0ByFdFsE8hIuuyOWFSa3TVBnPnQhPoEfM7pPafVuJ
         e7DepNFshRpkS7Cifsn45BfPc32jkRQ7dqReujP1cEVb9MbaaZHb1FtQA5EJ1GFyTQqm
         zADWwqcmTZJMOBb4N+VJE/sltCfgVm1AA+Q3KlGJsMcTOIfEqMEQqPg3fY0dXsUKCqt+
         wjS44/ksLjP95yZKpiHFI/CRMirjLwpUNtax27OIREJ581qE+u9OCiifk8K/3S7/kfa0
         4DG4d11XEDQd9XlegnYyfuh1TZBnwqUKqjL6fBh0pB++6HJlcqOdhvt3W1PZFUxNfbbr
         toYg==
X-Forwarded-Encrypted: i=1; AJvYcCXwzOVtTCzdRrR1X79w6MvRfTratUiZZ2nkOk5+jTApaUCH9sfUkYZRa4DV5tXnoSi3nOCF4O5IjyMV@vger.kernel.org
X-Gm-Message-State: AOJu0YzM8SFl+SVEFpJXWlsdjqUQ8LRnFvTso5Yh3ndcW3lNeXE0Tq6L
	vDUyLO+aNgYgtkyVCo5jpvfxb9V0MhVNPrD/LbT/gzo61mLQ4/AUrXNOPA6E1Og=
X-Gm-Gg: ASbGncvdlQOERYBLwoWb2XLo/9fIfhT7DOxzrX5ClozA9HQPAI6Jft/wgwBo/qzl6M5
	EErde/dn013511/uNJZY0cYt1PioRrt8+tEGXM5bXgnBuOkXmL5C7iQOeqLbLzC2zGFCWyS0sz2
	TtiWs2NO/3l/0leIRuv4kVmMNBwA4U6POopI0f/IW9kJtokGUOVdFkKSO/T+oJx+WIYTx2kn/MP
	IHEoYcobB89HujHO6KH/WFmud6iFvrK7ngA8UGWYbLpqGu0/eVO5MhmdkyPQ4A4ohI8GQyi
X-Google-Smtp-Source: AGHT+IFi2PqHlIH+52R3oy0dD5sKhEOY4OR/hJLyrqZkUQEHEQ6USqVAO5de5/oV21XIKeSPaGh+ig==
X-Received: by 2002:a17:902:e544:b0:216:414e:aa53 with SMTP id d9443c01a7336-21a83fffc58mr17459665ad.52.1736302095071;
        Tue, 07 Jan 2025 18:08:15 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca0282fsm316662405ad.259.2025.01.07.18.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 18:08:14 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 07 Jan 2025 18:07:51 -0800
Subject: [PATCH v5 03/16] perf tools: csky: Support generic syscall headers
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250107-perf_syscalltbl-v5-3-935de46d3175@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=ChjCi+WDWxIeAEQr9uB+RlwWvFzZ2k5NiZ20md8SwKA=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rtPYaYTbPWX7C8HZuyJozv7X4R1uVCB48EzF6yUXjjl
 D1XvJ5qd5SyMIhxMMiKKbLwXGtgbr2jX3ZUtGwCzBxWJpAhDFycAjCRGGtGhvmPtZbqs372ft3t
 f3r+x3QFvTiZJQeTJ2WLT61ljLxlYMnI0LT179QtLo0678tvatco14VN2jjx7SvJk5ekOM6lrVi
 VyAEA
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

csky uses the generic syscall table, use that in perf instead of
requiring libaudit.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/Makefile.perf                              | 2 +-
 tools/perf/arch/csky/entry/syscalls/Kbuild            | 2 ++
 tools/perf/arch/csky/entry/syscalls/Makefile.syscalls | 3 +++
 tools/perf/arch/csky/include/syscall_table.h          | 2 ++
 4 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 44b9e33b9568f638ba12ad688833fdb661c16c16..3fe47bd21c0ea39473c584c82383ca5d4daf580f 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -311,7 +311,7 @@ FEATURE_TESTS := all
 endif
 endif
 # architectures that use the generic syscall table
-generic_syscall_table_archs := riscv arc
+generic_syscall_table_archs := riscv arc csky
 ifneq ($(filter $(SRCARCH), $(generic_syscall_table_archs)),)
 include $(srctree)/tools/perf/scripts/Makefile.syscalls
 endif
diff --git a/tools/perf/arch/csky/entry/syscalls/Kbuild b/tools/perf/arch/csky/entry/syscalls/Kbuild
new file mode 100644
index 0000000000000000000000000000000000000000..11707c481a24ecf4e220e51eb1aca890fe929a13
--- /dev/null
+++ b/tools/perf/arch/csky/entry/syscalls/Kbuild
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+syscall-y += syscalls_32.h
diff --git a/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls b/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
new file mode 100644
index 0000000000000000000000000000000000000000..ea2dd10d0571df464574a9c0232ada0ac1f79a3f
--- /dev/null
+++ b/tools/perf/arch/csky/entry/syscalls/Makefile.syscalls
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+syscall_abis_32 += csky time32 stat64 rlimit
diff --git a/tools/perf/arch/csky/include/syscall_table.h b/tools/perf/arch/csky/include/syscall_table.h
new file mode 100644
index 0000000000000000000000000000000000000000..4c942821662d95216765b176a84d5fc7974e1064
--- /dev/null
+++ b/tools/perf/arch/csky/include/syscall_table.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <asm/syscalls_32.h>

-- 
2.34.1


