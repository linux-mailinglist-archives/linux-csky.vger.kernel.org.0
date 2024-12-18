Return-Path: <linux-csky+bounces-1387-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A879F6159
	for <lists+linux-csky@lfdr.de>; Wed, 18 Dec 2024 10:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDB8318951DC
	for <lists+linux-csky@lfdr.de>; Wed, 18 Dec 2024 09:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAEA156885;
	Wed, 18 Dec 2024 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="FGcglEPS"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCE195385
	for <linux-csky@vger.kernel.org>; Wed, 18 Dec 2024 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734513869; cv=none; b=q0orVlZUbRZWE6Bw/Fnk849Wwdxgw0ya2v3xVrt9LOhRfW3zJgBEW5RHvLhRhxfTVpqkq/GxsPLiZCMiekmbpqN45kksKOmil6w24Eyt37DzeO1UGzqkktj2nxQP6utZVcrXGnIk4Svbg6RRh3D7sSirzDZO6BZwVc6VxBiQVNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734513869; c=relaxed/simple;
	bh=r5X4P4KH+np4q2plC0P/nDZXhnkwoxhAfS7b7JDFHSM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=fz9ZpkRBzwyT+LUPP4CRfrhryrSwQ0OiA1altibc/DdBPJh0p8GSzk0wwhYFCqaUR6cHhhSkRm7tCTGM6oIBj6MhmOq7BfSpr0GXnbf8u1m1PD8oqXjei2zx7A3sMW+TiU+1HMAlDnwkQSXSSfvF84kPFCXVFzfjaiYPDP5Jou4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=FGcglEPS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-215770613dbso42395795ad.2
        for <linux-csky@vger.kernel.org>; Wed, 18 Dec 2024 01:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734513867; x=1735118667; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NRJha1SoH0/hFCPzxGAQ47LX039fMVOKupm0XmZAb70=;
        b=FGcglEPSutKIuHbwvVuiEN8RWsU5g1RLoTylco4CUvwfxh7T9nODlKFiVoURITMNkS
         iw2u/7UPci3elzoYEvnQq95DWMoh/2KUTKoW2/2lNmJJ05FFhKj5JZb4lhWBGhPUiI2X
         mc2VuGI8zs40IyQhn3MWgdzhVv17jgsr7HiR6P6GF8zP0oyDF49nzl6E4xCFUT2WLPed
         HrZPceVG2rRtUM26eMQnJqpnpAoLZ3MfbLj8m/T2HE7yH0sRgntSEc7qq9DX+Xfxx+QM
         utgG3TYD1t+TuYEkScN1md/O9irzsK2HYcVornKJyHprvfUdHX7FI+xA00/2VlHxo1FV
         315w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734513867; x=1735118667;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRJha1SoH0/hFCPzxGAQ47LX039fMVOKupm0XmZAb70=;
        b=SqDWtyBTBO14DCrqdbV2VIBopwKwLsgTsEajX7sUyc3hOZcrjifkJDjv2eR18lYDWs
         F7aXuJufCp68QAYUP+xgEwXAtjeisgV5tKx74AhPI5hnts0DCgqlCqe1B4JEJMnDvKb0
         sZZuLvQRIrUlWQuCiji6jrgCZces+R1WJXv0L4meARQf4eb2KO29Ps/+m6KzeuOsBSsj
         OHBcJ7HhQF7nJEUVjFPGORb8gkFNqzOHL8Y6a4TNGOvsp6Hhu+yhmpMUIRe7FI9W/MHN
         JZZoEKd3JWSGJTmVtT/3j4VJsUvQw5cNCRxNmlTaQZh/cpCfQ06pPis4FAeZXrJzdghQ
         Axrw==
X-Forwarded-Encrypted: i=1; AJvYcCWpCxF4hoJBpHl2I0Uyki7zAT1LbJx+Jfn9PvMspqc7Ux7vqR00Fw8UZFUgp7ok8oaq4u3dTLPOFYgj@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0InzDblKMrDM/F86wkWOhdx8Qw8DYjGtmd6CtAE1J3n2zOS9l
	EOk//cZpBNpRQtduAYd/9s3HG+D4jmtzbuzQ7RIirzGdWscgXVr3KdRLX22668Q=
X-Gm-Gg: ASbGncsFtvvxYwlmdBaF1IwTKE/UfgvC2XGW3Z2Dp1OmnE1nlcmbPG++md9q+2WXrR9
	RNvoqveCWbfMrYHhe5quSOb0znaInwED6+rCRUWhEqXhxRyMxBeuJEvHf4mONkpq+msuFPtWM7+
	iTPAs7YbDVwBhEOlAZQ1A+FofV1+C5CtIbA88tlPh4dLTjB7CQTczF/QzgAQQx0f2d0rfYDUOov
	t+QDTgtcFhccZAE/uGL6Ky/WiCIsujMUXEHuA8tIDq0eIxHXJ/dyxOb1zNhMQaGAs+4UMW+
X-Google-Smtp-Source: AGHT+IGR4D+hNDWJEhj5SMCJmWDe5Yk0GMudatm20Y3u8muxzsVTwGB13H7qLZBnO+a9tWVs1mqlMg==
X-Received: by 2002:a17:902:da8b:b0:216:2426:767f with SMTP id d9443c01a7336-218d725c2d5mr29562395ad.49.1734513866948;
        Wed, 18 Dec 2024 01:24:26 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e64f90sm72119995ad.241.2024.12.18.01.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:24:25 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Subject: [PATCH v4 00/16] perf tools: Use generic syscall scripts for all
 archs
Date: Wed, 18 Dec 2024 01:23:58 -0800
Message-Id: <20241218-perf_syscalltbl-v4-0-bc8caef2ca8e@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK6UYmcC/23NTQrCMBCG4atI1kby19q48h4iEtMZG6hNSUqwl
 N7dtBvFunw/mGcmEiE4iOS0m0iA5KLzXQ613xHbmO4B1NW5iWBCMc0l7SHgLY7RmrYd7i0tUVc
 1oLUlFiRf9QHQvVbxcs3duDj4MK4PEl/W1eKcqY2VOGVUm9pAYY8lBzwHl3x0nT1Y/yQLl8SHE
 FxsCZEJrKzRlUIExf4Q8psot4TMhJAamRSq4nXxQ8zz/AZvUL/BNwEAAA==
X-Change-ID: 20240913-perf_syscalltbl-6f98defcc6f5
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8126; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=r5X4P4KH+np4q2plC0P/nDZXhnkwoxhAfS7b7JDFHSM=;
 b=owGbwMvMwCHWx5hUnlvL8Y3xtFoSQ3rSlC18lXcqhZ6mOv7M/pesJ7wo5+IV8aTAXacDcuyC1
 teneSt1lLIwiHEwyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMJEYRkaGWe/TPqTc7PtSv9vV
 +Uj6Ko0GjdWJ9oq+O1QsZFf9WZNizsjwIlR0qnDP/hcaSybFH7xt8d8r3rJVwtnz6+GTPI/+7d/
 PCAA=
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

Standardize the generation of syscall headers around syscall tables.
Previously each architecture independently selected how syscall headers
would be generated, or would not define a way and fallback onto
libaudit. Convert all architectures to use a standard syscall header
generation script and allow each architecture to override the syscall
table to use if they do not use the generic table.

As a result of these changes, no architecture will require libaudit, and
so the fallback case of using libaudit is removed by this series.

Testing:

I have tested that the syscall mappings of id to name generation works
as expected for every architecture, but I have only validated that perf
trace compiles and runs as expected on riscv, arm64, and x86_64.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Ian Rogers <irogers@google.com>

On x86-64:
Tested-by: Ian Rogers <irogers@google.com>

---
Changes in v4:
- Remove audit_machine member of syscalltbl struct (Ian)
- Rebase on perf-tools-next
- Link to v3: https://lore.kernel.org/r/20241216-perf_syscalltbl-v3-0-239f032481d5@rivosinc.com

Changes in v3:
- Fix compiliation when OUTPUT is empty
- Correct unused headers to be .h instead of .c  (Namhyung)
- Make variable definition of supported archs (Namhyung)
- Convert += into := for syscalls headers (Namhyung)
- Link to v2: https://lore.kernel.org/r/20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com

Changes in v2:
- Rebase onto 6.13-rc2
- Fix output path so it generates to /tools/perf/arch properly
- Link to v1: https://lore.kernel.org/r/20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com

---
Charlie Jenkins (16):
      perf tools: Create generic syscall table support
      perf tools: arc: Support generic syscall headers
      perf tools: csky: Support generic syscall headers
      perf tools: arm: Support syscall headers
      perf tools: sh: Support syscall headers
      perf tools: sparc: Support syscall headers
      perf tools: xtensa: Support syscall header
      perf tools: x86: Use generic syscall scripts
      perf tools: alpha: Support syscall header
      perf tools: parisc: Support syscall header
      perf tools: arm64: Use syscall table
      perf tools: loongarch: Use syscall table
      perf tools: mips: Use generic syscall scripts
      perf tools: powerpc: Use generic syscall table scripts
      perf tools: s390: Use generic syscall table scripts
      perf tools: Remove dependency on libaudit

 Documentation/admin-guide/workload-tracing.rst     |   2 +-
 tools/build/feature/Makefile                       |   4 -
 tools/build/feature/test-libaudit.c                |  11 -
 tools/perf/Documentation/perf-check.txt            |   1 -
 tools/perf/Makefile.config                         |  39 +-
 tools/perf/Makefile.perf                           |  12 +-
 tools/perf/arch/alpha/entry/syscalls/Kbuild        |   2 +
 .../arch/alpha/entry/syscalls/Makefile.syscalls    |   5 +
 tools/perf/arch/alpha/entry/syscalls/syscall.tbl   | 504 ++++++++++++++++++++
 tools/perf/arch/alpha/include/syscall_table.h      |   2 +
 tools/perf/arch/arc/entry/syscalls/Kbuild          |   2 +
 .../perf/arch/arc/entry/syscalls/Makefile.syscalls |   3 +
 tools/perf/arch/arc/include/syscall_table.h        |   2 +
 tools/perf/arch/arm/entry/syscalls/Kbuild          |   4 +
 .../perf/arch/arm/entry/syscalls/Makefile.syscalls |   2 +
 tools/perf/arch/arm/entry/syscalls/syscall.tbl     | 483 +++++++++++++++++++
 tools/perf/arch/arm/include/syscall_table.h        |   2 +
 tools/perf/arch/arm64/Makefile                     |  22 -
 tools/perf/arch/arm64/entry/syscalls/Kbuild        |   3 +
 .../arch/arm64/entry/syscalls/Makefile.syscalls    |   6 +
 tools/perf/arch/arm64/entry/syscalls/mksyscalltbl  |  46 --
 .../perf/arch/arm64/entry/syscalls/syscall_32.tbl  | 476 +++++++++++++++++++
 .../perf/arch/arm64/entry/syscalls/syscall_64.tbl  |   1 +
 tools/perf/arch/arm64/include/syscall_table.h      |   8 +
 tools/perf/arch/csky/entry/syscalls/Kbuild         |   2 +
 .../arch/csky/entry/syscalls/Makefile.syscalls     |   3 +
 tools/perf/arch/csky/include/syscall_table.h       |   2 +
 tools/perf/arch/loongarch/Makefile                 |  22 -
 tools/perf/arch/loongarch/entry/syscalls/Kbuild    |   2 +
 .../loongarch/entry/syscalls/Makefile.syscalls     |   3 +
 .../arch/loongarch/entry/syscalls/mksyscalltbl     |  45 --
 tools/perf/arch/loongarch/include/syscall_table.h  |   2 +
 tools/perf/arch/mips/entry/syscalls/Kbuild         |   2 +
 .../arch/mips/entry/syscalls/Makefile.syscalls     |   5 +
 tools/perf/arch/mips/entry/syscalls/mksyscalltbl   |  32 --
 tools/perf/arch/mips/include/syscall_table.h       |   2 +
 tools/perf/arch/parisc/entry/syscalls/Kbuild       |   3 +
 .../arch/parisc/entry/syscalls/Makefile.syscalls   |   6 +
 tools/perf/arch/parisc/entry/syscalls/syscall.tbl  | 463 +++++++++++++++++++
 tools/perf/arch/parisc/include/syscall_table.h     |   8 +
 tools/perf/arch/powerpc/Makefile                   |  25 -
 tools/perf/arch/powerpc/entry/syscalls/Kbuild      |   3 +
 .../arch/powerpc/entry/syscalls/Makefile.syscalls  |   6 +
 .../perf/arch/powerpc/entry/syscalls/mksyscalltbl  |  39 --
 tools/perf/arch/powerpc/include/syscall_table.h    |   8 +
 tools/perf/arch/riscv/Makefile                     |  22 -
 tools/perf/arch/riscv/entry/syscalls/Kbuild        |   2 +
 .../arch/riscv/entry/syscalls/Makefile.syscalls    |   4 +
 tools/perf/arch/riscv/entry/syscalls/mksyscalltbl  |  47 --
 tools/perf/arch/riscv/include/syscall_table.h      |   8 +
 tools/perf/arch/s390/Makefile                      |  21 -
 tools/perf/arch/s390/entry/syscalls/Kbuild         |   2 +
 .../arch/s390/entry/syscalls/Makefile.syscalls     |   5 +
 tools/perf/arch/s390/entry/syscalls/mksyscalltbl   |  32 --
 tools/perf/arch/s390/include/syscall_table.h       |   2 +
 tools/perf/arch/sh/entry/syscalls/Kbuild           |   2 +
 .../perf/arch/sh/entry/syscalls/Makefile.syscalls  |   4 +
 tools/perf/arch/sh/entry/syscalls/syscall.tbl      | 472 +++++++++++++++++++
 tools/perf/arch/sh/include/syscall_table.h         |   2 +
 tools/perf/arch/sparc/entry/syscalls/Kbuild        |   3 +
 .../arch/sparc/entry/syscalls/Makefile.syscalls    |   5 +
 tools/perf/arch/sparc/entry/syscalls/syscall.tbl   | 514 +++++++++++++++++++++
 tools/perf/arch/sparc/include/syscall_table.h      |   8 +
 tools/perf/arch/x86/Build                          |   1 -
 tools/perf/arch/x86/Makefile                       |  25 -
 tools/perf/arch/x86/entry/syscalls/Kbuild          |   3 +
 .../perf/arch/x86/entry/syscalls/Makefile.syscalls |   6 +
 tools/perf/arch/x86/entry/syscalls/syscalltbl.sh   |  42 --
 tools/perf/arch/x86/include/syscall_table.h        |   8 +
 tools/perf/arch/xtensa/entry/syscalls/Kbuild       |   2 +
 .../arch/xtensa/entry/syscalls/Makefile.syscalls   |   4 +
 tools/perf/arch/xtensa/entry/syscalls/syscall.tbl  | 439 ++++++++++++++++++
 tools/perf/arch/xtensa/include/syscall_table.h     |   2 +
 tools/perf/builtin-check.c                         |   1 -
 tools/perf/builtin-help.c                          |   2 -
 tools/perf/builtin-trace.c                         |  30 --
 tools/perf/check-headers.sh                        |   9 +
 tools/perf/perf.c                                  |   6 +-
 tools/perf/scripts/Makefile.syscalls               |  61 +++
 tools/perf/scripts/syscalltbl.sh                   |  86 ++++
 tools/perf/tests/make                              |   7 +-
 tools/perf/util/env.c                              |   4 +-
 tools/perf/util/generate-cmdlist.sh                |   4 +-
 tools/perf/util/syscalltbl.c                       |  90 +---
 tools/perf/util/syscalltbl.h                       |   1 -
 tools/scripts/syscall.tbl                          | 409 ++++++++++++++++
 86 files changed, 4102 insertions(+), 620 deletions(-)
---
base-commit: e8b3012cbd8f2263777347c2e8310b3f00d494f5
change-id: 20240913-perf_syscalltbl-6f98defcc6f5
-- 
- Charlie


