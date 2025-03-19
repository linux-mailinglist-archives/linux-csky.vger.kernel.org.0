Return-Path: <linux-csky+bounces-1993-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60BC5A6846A
	for <lists+linux-csky@lfdr.de>; Wed, 19 Mar 2025 06:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F19B9421276
	for <lists+linux-csky@lfdr.de>; Wed, 19 Mar 2025 05:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9732500C5;
	Wed, 19 Mar 2025 05:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ko1tMgpT"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD15210F4D
	for <linux-csky@vger.kernel.org>; Wed, 19 Mar 2025 05:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742360877; cv=none; b=soiN/YIpkgu/oZX+sZsXGkp2rDxHgD3drgOhXG05FMoj4rVQVE2qwSY2L+AlHux2yHfp0Bvx4vepyJR1mvXzbzbDTGiiAtcWBPZ53XAzBov0keLh4ZVdt0kAAJthqX6O3I8B+sI74841ZZ9NBe/6LG+CA9G/HC0IO56sN9My37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742360877; c=relaxed/simple;
	bh=V6Z1VaaZvWtk/tEXjKtJfP6Ld5lnXtv1c/u2guFja8I=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=aEd//9FR33PHh/6okxJl6XdALw5XoCEdLjhjGWNQ/AaveveloTIlDMuD18d0x4IpGgLPTJCiAq0IWeec9kxlR0feTJwUmpymqMSoIdLWs90Wnqi8/UHKBknaxWMOIFwZfOiYvRkXp/lux7BMAusrVdwh6tfJMFvlZBqSH2U9riE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ko1tMgpT; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f2737d115eso84464297b3.2
        for <linux-csky@vger.kernel.org>; Tue, 18 Mar 2025 22:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742360872; x=1742965672; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NFFalelwH8VoySEJuALgzWg3CwByqG22Rt5iA2R562U=;
        b=Ko1tMgpT2YtsU8LO5jJnpH+Owwr/0+KGz427sbxefTKdF0FHZZemRgV1cxECOyEXrH
         5QrqAON3GYj/J3EWMI/z3iY3kTglgzPZ/BigQSsTM9Z0aQZoIP1dmqIm0pJFvVWZ1sKN
         r42wDUIML4IJMJQRMoDGABtQmwsmLetcONv3enZjc0+5OlZtVCX2nEvtxLfoj38XMa2d
         yatYdaLI/Fqh/MrMX95+0WNIGBTE6LoM2oTECZGqTLZLaHQZMXDBEIhaRYyfDG6jmdfX
         K2xFoXnl9OTqILGlT4G4gJ6KhOCLvEda+tW4z+P5r2O+9DG9Xa3kFNWsvt9+tzQyoI1l
         2UbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742360872; x=1742965672;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NFFalelwH8VoySEJuALgzWg3CwByqG22Rt5iA2R562U=;
        b=RHKeT6IBwf9VJI0YdK4zc9E1EikABCI3dnCCCaslkYg3bQn9iP76hqXQ9v6jj00biy
         KJWlWXkxLK+1/83JlYTUvKqCdHgr03Rm0lxKFTKLAkK2D+3x54C//EcfVsvwu+ULFYI6
         hE3gCBJOdScgWgAdi3HnpPvGr3ReuJfhz1Btj9JJQGAIQkprxq8HQF2GHHXynpChhFbV
         B+WNv1SR1RFJzZsZvmUp1WJvg4EFPqaJTZcJgT3e7iYLZbLDROLzd4TasEIag5DCAspa
         KISoIJegShv4R/E+OaCvkztXAAkph4NuAAhhMK+Yc1/OJm+1Umds8vDkw7dgZyHuPOM/
         2tGw==
X-Forwarded-Encrypted: i=1; AJvYcCU8vfLs2wvmw5WV35YGzHpwicY2f9P0Hti9Q/VjgBJC2YPKexUauq5fcoysBghkh1UW2exDSZirz8Qk@vger.kernel.org
X-Gm-Message-State: AOJu0YymsnnKeIkBjnigyYTsKx7ExE6SIMLTQXidbMabyWQiPEaxqZGV
	bAvOH4wEZWM2dx8dqiFri9z357MO0nLUKKugZBmSL8IsdaYk1LjQY2z3ccG9mDfK8fpIPOFF/fo
	qj4UltA==
X-Google-Smtp-Source: AGHT+IHKXcOcoX7oZFC1oFuGYiGGZ0j+MiBzxCOjCKBtTzivPnb3bP0kfvlmCNy9iQaR8bqAcvFNPd6Extds
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8a11:10b5:af90:6031])
 (user=irogers job=sendgmr) by 2002:a5b:a87:0:b0:e60:8793:89b3 with SMTP id
 3f1490d57ef6-e667b456b9amr515276.8.1742360872036; Tue, 18 Mar 2025 22:07:52
 -0700 (PDT)
Date: Tue, 18 Mar 2025 22:07:30 -0700
In-Reply-To: <20250319050741.269828-1-irogers@google.com>
Message-Id: <20250319050741.269828-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319050741.269828-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v7 03/14] perf syscalltbl: Remove syscall_table.h
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The definition of "static const char *const syscalltbl[] = {" is done
in a generated syscalls_32.h or syscalls_64.h that is architecture
dependent. In order to include the appropriate file a syscall_table.h
is found via the perf include path and it includes the syscalls_32.h
or syscalls_64.h as appropriate.

To support having multiple syscall tables, one for 32-bit and one for
64-bit, or for different architectures, an include path cannot be
used. Remove syscall_table.h because of this and inline what it does
into syscalltbl.c.

For architectures without a syscall_table.h this will cause a failure
to include either syscalls_32.h or syscalls_64.h rather than a failure
to include syscall_table.h. For architectures that only included one
or other, the behavior matches BITS_PER_LONG as previously done on
architectures supporting both syscalls_32.h and syscalls_64.h.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Howard Chu <howardchu95@gmail.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/arch/alpha/include/syscall_table.h     | 2 --
 tools/perf/arch/arc/include/syscall_table.h       | 2 --
 tools/perf/arch/arm/include/syscall_table.h       | 2 --
 tools/perf/arch/arm64/include/syscall_table.h     | 8 --------
 tools/perf/arch/csky/include/syscall_table.h      | 2 --
 tools/perf/arch/loongarch/include/syscall_table.h | 2 --
 tools/perf/arch/mips/include/syscall_table.h      | 2 --
 tools/perf/arch/parisc/include/syscall_table.h    | 8 --------
 tools/perf/arch/powerpc/include/syscall_table.h   | 8 --------
 tools/perf/arch/riscv/include/syscall_table.h     | 8 --------
 tools/perf/arch/s390/include/syscall_table.h      | 2 --
 tools/perf/arch/sh/include/syscall_table.h        | 2 --
 tools/perf/arch/sparc/include/syscall_table.h     | 8 --------
 tools/perf/arch/x86/include/syscall_table.h       | 8 --------
 tools/perf/arch/xtensa/include/syscall_table.h    | 2 --
 tools/perf/util/syscalltbl.c                      | 8 +++++++-
 16 files changed, 7 insertions(+), 67 deletions(-)
 delete mode 100644 tools/perf/arch/alpha/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arm/include/syscall_table.h
 delete mode 100644 tools/perf/arch/arm64/include/syscall_table.h
 delete mode 100644 tools/perf/arch/csky/include/syscall_table.h
 delete mode 100644 tools/perf/arch/loongarch/include/syscall_table.h
 delete mode 100644 tools/perf/arch/mips/include/syscall_table.h
 delete mode 100644 tools/perf/arch/parisc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/powerpc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/riscv/include/syscall_table.h
 delete mode 100644 tools/perf/arch/s390/include/syscall_table.h
 delete mode 100644 tools/perf/arch/sh/include/syscall_table.h
 delete mode 100644 tools/perf/arch/sparc/include/syscall_table.h
 delete mode 100644 tools/perf/arch/x86/include/syscall_table.h
 delete mode 100644 tools/perf/arch/xtensa/include/syscall_table.h

diff --git a/tools/perf/arch/alpha/include/syscall_table.h b/tools/perf/arch/alpha/include/syscall_table.h
deleted file mode 100644
index b53e31c15805..000000000000
--- a/tools/perf/arch/alpha/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_64.h>
diff --git a/tools/perf/arch/arc/include/syscall_table.h b/tools/perf/arch/arc/include/syscall_table.h
deleted file mode 100644
index 4c942821662d..000000000000
--- a/tools/perf/arch/arc/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_32.h>
diff --git a/tools/perf/arch/arm/include/syscall_table.h b/tools/perf/arch/arm/include/syscall_table.h
deleted file mode 100644
index 4c942821662d..000000000000
--- a/tools/perf/arch/arm/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_32.h>
diff --git a/tools/perf/arch/arm64/include/syscall_table.h b/tools/perf/arch/arm64/include/syscall_table.h
deleted file mode 100644
index 7ff51b783000..000000000000
--- a/tools/perf/arch/arm64/include/syscall_table.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/bitsperlong.h>
-
-#if __BITS_PER_LONG == 64
-#include <asm/syscalls_64.h>
-#else
-#include <asm/syscalls_32.h>
-#endif
diff --git a/tools/perf/arch/csky/include/syscall_table.h b/tools/perf/arch/csky/include/syscall_table.h
deleted file mode 100644
index 4c942821662d..000000000000
--- a/tools/perf/arch/csky/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_32.h>
diff --git a/tools/perf/arch/loongarch/include/syscall_table.h b/tools/perf/arch/loongarch/include/syscall_table.h
deleted file mode 100644
index 9d0646d3455c..000000000000
--- a/tools/perf/arch/loongarch/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscall_table_64.h>
diff --git a/tools/perf/arch/mips/include/syscall_table.h b/tools/perf/arch/mips/include/syscall_table.h
deleted file mode 100644
index b53e31c15805..000000000000
--- a/tools/perf/arch/mips/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_64.h>
diff --git a/tools/perf/arch/parisc/include/syscall_table.h b/tools/perf/arch/parisc/include/syscall_table.h
deleted file mode 100644
index 7ff51b783000..000000000000
--- a/tools/perf/arch/parisc/include/syscall_table.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/bitsperlong.h>
-
-#if __BITS_PER_LONG == 64
-#include <asm/syscalls_64.h>
-#else
-#include <asm/syscalls_32.h>
-#endif
diff --git a/tools/perf/arch/powerpc/include/syscall_table.h b/tools/perf/arch/powerpc/include/syscall_table.h
deleted file mode 100644
index 7ff51b783000..000000000000
--- a/tools/perf/arch/powerpc/include/syscall_table.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/bitsperlong.h>
-
-#if __BITS_PER_LONG == 64
-#include <asm/syscalls_64.h>
-#else
-#include <asm/syscalls_32.h>
-#endif
diff --git a/tools/perf/arch/riscv/include/syscall_table.h b/tools/perf/arch/riscv/include/syscall_table.h
deleted file mode 100644
index 7ff51b783000..000000000000
--- a/tools/perf/arch/riscv/include/syscall_table.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/bitsperlong.h>
-
-#if __BITS_PER_LONG == 64
-#include <asm/syscalls_64.h>
-#else
-#include <asm/syscalls_32.h>
-#endif
diff --git a/tools/perf/arch/s390/include/syscall_table.h b/tools/perf/arch/s390/include/syscall_table.h
deleted file mode 100644
index b53e31c15805..000000000000
--- a/tools/perf/arch/s390/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_64.h>
diff --git a/tools/perf/arch/sh/include/syscall_table.h b/tools/perf/arch/sh/include/syscall_table.h
deleted file mode 100644
index 4c942821662d..000000000000
--- a/tools/perf/arch/sh/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_32.h>
diff --git a/tools/perf/arch/sparc/include/syscall_table.h b/tools/perf/arch/sparc/include/syscall_table.h
deleted file mode 100644
index 7ff51b783000..000000000000
--- a/tools/perf/arch/sparc/include/syscall_table.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/bitsperlong.h>
-
-#if __BITS_PER_LONG == 64
-#include <asm/syscalls_64.h>
-#else
-#include <asm/syscalls_32.h>
-#endif
diff --git a/tools/perf/arch/x86/include/syscall_table.h b/tools/perf/arch/x86/include/syscall_table.h
deleted file mode 100644
index 7ff51b783000..000000000000
--- a/tools/perf/arch/x86/include/syscall_table.h
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/bitsperlong.h>
-
-#if __BITS_PER_LONG == 64
-#include <asm/syscalls_64.h>
-#else
-#include <asm/syscalls_32.h>
-#endif
diff --git a/tools/perf/arch/xtensa/include/syscall_table.h b/tools/perf/arch/xtensa/include/syscall_table.h
deleted file mode 100644
index 4c942821662d..000000000000
--- a/tools/perf/arch/xtensa/include/syscall_table.h
+++ /dev/null
@@ -1,2 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <asm/syscalls_32.h>
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 928aca4cd6e9..2f76241494c8 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -7,13 +7,19 @@
 
 #include "syscalltbl.h"
 #include <stdlib.h>
+#include <asm/bitsperlong.h>
 #include <linux/compiler.h>
 #include <linux/zalloc.h>
 
 #include <string.h>
 #include "string2.h"
 
-#include <syscall_table.h>
+#if __BITS_PER_LONG == 64
+  #include <asm/syscalls_64.h>
+#else
+  #include <asm/syscalls_32.h>
+#endif
+
 const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;
 static const char *const *syscalltbl_native = syscalltbl;
 
-- 
2.49.0.rc1.451.g8f38331e32-goog


