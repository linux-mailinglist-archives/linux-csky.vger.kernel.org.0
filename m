Return-Path: <linux-csky+bounces-1759-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB7FA2F42A
	for <lists+linux-csky@lfdr.de>; Mon, 10 Feb 2025 17:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5203A16448D
	for <lists+linux-csky@lfdr.de>; Mon, 10 Feb 2025 16:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85172586EE;
	Mon, 10 Feb 2025 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JML+cLbu"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC962586D4
	for <linux-csky@vger.kernel.org>; Mon, 10 Feb 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206278; cv=none; b=GgZ7qM0LmHPDRwAinvdE2tTCetivuvEnlRWx/mVbPJIKsN2ogOd+XDw9vFREed9J42ocJyiUnAHbD6H39/07lBkrXxJSH/bH4ZNIoXE848WSjNQav4wmT1PMnwvWlKQ80Rq1ezOWEB0665gisTKVHutk4iX4IQZ8beONvSzlhQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206278; c=relaxed/simple;
	bh=YT8KlPL9wtk8Q8VP6p5i62j+YN3+9mtkfyQRAssUQ6o=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qeDNdwCPZK+tbSpZ6DHSf91DkBC30o6lsjqpUz7sIvkgJHWhtMRqwrBv4qWLXCQ4MlefgRMtgJ4aXPQRUMSGVY1PvKewtEXHBQ/DFhtx2fGc4XMTocq9qLSFa32NTmUzsQ7lgIQlPi1ag5Qj1lFxxacB/4zI2BtRLi9RB/jp4rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JML+cLbu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f9ab3a12dfso38134807b3.1
        for <linux-csky@vger.kernel.org>; Mon, 10 Feb 2025 08:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739206275; x=1739811075; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RirwOEvFTr+iQTMC7nBuBTQw9Ik098EayI6xPJbtYXE=;
        b=JML+cLbuMGcRQD1+FsuVMZMXyRELGvUkNo0e9HJPXzISrFaxnIqt3imoWhf+0WaolH
         MS+saG0FoZ+oGvH0UYOiFTSA1JCK0FV7fcdKTGPYilEQgA38fbjFanhItn5KdlwgqXPI
         cs5fyeLfMitaXfWUP60w/VScw6aAI/zfwuDmGNFmRBrk28TNKuk4+xRSVkiKywZlp+tc
         U6mtariMRQZZh+X3n478axHqT2vskpoCzTZk9kGgMd1587EhaP2pXrfCY6I3DFbCaxO/
         PYgQ98St5f6crIOOLu9YfPt0NZOvlnHBCDgrO+lO61SBw7rGOMgMYWbcx+h6CrOZ+NG6
         5G8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739206275; x=1739811075;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RirwOEvFTr+iQTMC7nBuBTQw9Ik098EayI6xPJbtYXE=;
        b=u3EiHFPbwYvSZLCZvju2CGejVkm9P8mHH14sMDV+jsJeK/IP11haAUEhDNZLyaaZJr
         j9ZDNe02LXI2DPiz+GNrhK5ttkKOgd7w+jWHzSj2sjVVaMzGrY8rNQ4npvxqDH6WN0Wl
         CgOhMMq3EhyDHjqV2PtMXheiikXRMCflAH1adgMK28Hd1LntTeY2d4Xgqef/gdiiLJXe
         AXNoCk34qE4CrhdcsxtUUduAhZic258cKMyFBse1izYWpzkqJi1SgmtgeFCdKSoDYwjH
         VlZhCvlgfvvK1V2NBWG+MNNIWDSvXaoauVTSe605g9Y6pOodj0jKcXEkFYit5KHkt6af
         2LJA==
X-Forwarded-Encrypted: i=1; AJvYcCUl6++rJl1v+piKWYxeMeCi0WFOtRvwtDiVNrkNBJmpX38VNF+eJV4O35gFpm1WrZd3F0rEllMLtDbZ@vger.kernel.org
X-Gm-Message-State: AOJu0YxYgYNAXcgQBb0OuUCWN7846SiCKisedA4FQfEblSIZuBcm9Iwv
	xVd0KDW5u4SX4i6ZJ/fL3EKYl7WBTTT6ASZqmEyn7xI2PdDXYTtBPPtXBRBhLF7v4IfslUMsX8t
	iFB2ZFw==
X-Google-Smtp-Source: AGHT+IFBo0WplPY5u0KSXjidUMV7aHm6r7XcZJoSM+fjgBwnWdxloP3RVTRtYLfmNJD2vikuitPsOYqh8Bzj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c64e:af58:30d4:168d])
 (user=irogers job=sendgmr) by 2002:a05:690c:3349:b0:6ee:3f39:493e with SMTP
 id 00721157ae682-6f99a877225mr2402777b3.5.1739206275113; Mon, 10 Feb 2025
 08:51:15 -0800 (PST)
Date: Mon, 10 Feb 2025 08:51:02 -0800
In-Reply-To: <20250210165108.95894-1-irogers@google.com>
Message-Id: <20250210165108.95894-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250210165108.95894-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
Subject: [PATCH v2 1/7] perf syscalltble: Remove syscall_table.h
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
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
2.48.1.502.g6dc24dfdaf-goog


