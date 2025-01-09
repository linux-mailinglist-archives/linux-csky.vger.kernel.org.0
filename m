Return-Path: <linux-csky+bounces-1569-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B50D6A06B47
	for <lists+linux-csky@lfdr.de>; Thu,  9 Jan 2025 03:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BA241649E5
	for <lists+linux-csky@lfdr.de>; Thu,  9 Jan 2025 02:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F189E17333D;
	Thu,  9 Jan 2025 02:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="xNx6tpQ6"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935816D9DF
	for <linux-csky@vger.kernel.org>; Thu,  9 Jan 2025 02:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736390204; cv=none; b=pU02ql4RlsIBgRXfqSQv0UpzlEWqK68YKoQVEsXM0AFTQWUFbySavD6EOL2yumXU/OsjmozsX4UAUBON492KlVveRvsy9rRw0XdEI8j3E9ByCoVjBiF+5vNJT48iq/rHYxHiQcgfkR83bMa374haiO0lSW23niLYhQ32VdresJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736390204; c=relaxed/simple;
	bh=ChjCi+WDWxIeAEQr9uB+RlwWvFzZ2k5NiZ20md8SwKA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QHv8lsV3w2yFs4xpqxPvSGNN++T70+QcZVMgNua7KsT2jkAIMqMfUX0h1fBKk/5jDx+H6/rzvTSj6AYz1ZycUXi1ZwOO+lulaYQCmA6+yEgBHk2wvyywOaE/iA9bB2btq8255J527Njx5RO6hvNpbkkl0ZJ470kIrNNJXfqzmeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=xNx6tpQ6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-215770613dbso4271625ad.2
        for <linux-csky@vger.kernel.org>; Wed, 08 Jan 2025 18:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736390202; x=1736995002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=05wirhUQV9Km8dQngc0z5Y797cbCbqNKIhJCCOZ4z1g=;
        b=xNx6tpQ6gk1GyqIrSuQkt2CF9+PFhIKbDMZb/FokDFqDTAwSRfMZdWNqkKyWTDx//q
         4uV0bGFlBniDg+t01I2WZh54h2gehYERaY2ON1QEKUqOkuzLzgD8WKlV9fqiKLh1tbn3
         knl0Q5ROcyDdLk7pHVlnmMSzIU0LhKW++Owv0He5T8rwifE9gE1aqEsOe9jE8uMVqNW8
         Ykix98zmPCMPmFqo7V+0eVGbZwqmIDsxlUdptIvUCKYqRnGBzxUBHjCC77ITOa4/ghGu
         QmaJEqZQ2/G7W3TRFn0/81wdKiCwK1gUtJxGgxc5ht7aGlK8e3vZ6yS+/dUvM1d7ERYI
         ngFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736390202; x=1736995002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=05wirhUQV9Km8dQngc0z5Y797cbCbqNKIhJCCOZ4z1g=;
        b=ZZnlLVd8Y9CzJAUHR9lOacYr1kTVvkVLPhUXikpiAOTxwNFgASKGgfV8JEpJc5hb0T
         +fkdnybr54IpGJJX3fUrb4gwKCoeAORh1y9YXaoTWICB3syKCjRPzNSaYE4uC2eAtufE
         1RbOum2HMGQEx5uf2aofC36reF/YaoZlUODIlzcnZPYyrfoOgrWU+PaGMYGepNR38kjE
         UVkG/CtPbiQHMqznIFaCbgHJBqnsAMmYTMFf48HDhVPbmH9IRCe6XblTMYCYGQns7aRt
         4vTpNoCRzDgUVQAo4Hkn+I4DQ7qz3twraylT/7CJDEQUrgREq+WpK5d9gsabw1tocvxy
         M+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXy/ju1uUAZtUAyN399QRGfY225Z092l8OxeSI0Ys8C+FK9UPhlytE654bN0nRPbg7SbkYjm2IZg1q/@vger.kernel.org
X-Gm-Message-State: AOJu0Yz17lSMWb/Xnq3OkzDnbfNZHWN/M2t8uR8xgu9iF8TsoKpD3kC2
	rI90Sli4tC783seYM1mGDT8K2AjoZiWvLvXmEqtNP/M5tw5lT1oY/CvvFR55IGY=
X-Gm-Gg: ASbGncupzcRftux5K6zCt8ns7T89jrN3l9VMJfWDlxaMXhnvJRS1bVpChNqejKay+WU
	qiGyGDy9z+WqrTRJ7lSHXQWS4B30EAfQkO4TWZx08YPuc+7puoSMM3PO+8rHp8Ubu5AJ5yZfE2r
	6oy5uy2xJZlwZDWzvRAi/VUg3vKZ4xbpifkmgNC7XRtqbF0+1fDd6fWNsyb+ufJ7xOCaJgWDLlp
	FGBZVu6RVuCjyFRRWXB3o47Glx5PWMK1fykNSbFNA/an2fhbsMmKJpdpigd/YE5s4b0ds09
X-Google-Smtp-Source: AGHT+IFiR6AClEYyCeay/hplxruI5zUWl8aXWQv5HrmktLRGxcP+45E5k67qNfXZ2vQHsxEzKTLuZw==
X-Received: by 2002:a17:902:e74e:b0:215:aee1:7e3e with SMTP id d9443c01a7336-21a83f36d48mr71977845ad.5.1736390202400;
        Wed, 08 Jan 2025 18:36:42 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9176bed6sm1434365ad.12.2025.01.08.18.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 18:36:41 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 08 Jan 2025 18:36:18 -0800
Subject: [PATCH v6 03/16] perf tools: csky: Support generic syscall headers
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-perf_syscalltbl-v6-3-7543b5293098@rivosinc.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2180; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=ChjCi+WDWxIeAEQr9uB+RlwWvFzZ2k5NiZ20md8SwKA=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3q9mU4tJ+sitVdXi50kly5mevw4wyvfdsnPgvhdN/OkF
 E6FMH/uKGVhEONgkBVTZOG51sDceke/7Kho2QSYOaxMIEMYuDgFYCICIQy/2RdYF5ldWF8zbd2d
 Iy57ZizXVH5wpIj5cMz+BVkp0tNW72D4K6jHKPDXw2RxwY/fvdLvimzW+CzMzizzXBKnqnNhe9M
 KHgA=
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


