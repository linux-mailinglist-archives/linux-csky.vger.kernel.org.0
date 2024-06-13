Return-Path: <linux-csky+bounces-546-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A684907F62
	for <lists+linux-csky@lfdr.de>; Fri, 14 Jun 2024 01:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D65DB2211C
	for <lists+linux-csky@lfdr.de>; Thu, 13 Jun 2024 23:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60AF14F9ED;
	Thu, 13 Jun 2024 23:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jAeHHMty"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1EB811E0
	for <linux-csky@vger.kernel.org>; Thu, 13 Jun 2024 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718321501; cv=none; b=aHfc9LIIZRHspEtXHFIViD0HjX//XfdywHH0u+PLj9stkHuBbcEl32yeLeRq9nkBNLiBaLeR09BXJc7cmolIOSBYQuVVShQq/DHXbTLPlUFBuZJlM5dqQWP2m6ofCMbY5ekYFAJt5qaEHWBjjqpsQg0n13J4aOE9lmKqlWayCU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718321501; c=relaxed/simple;
	bh=ABOAU2K5glRCpGOq5xujWwNgIlUPYqmruIjqw8FdZs0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=gjcBvVKEiv9hA70ngWd8U8HjgPufRnszcDLoxbdjTaVOTA38H/yXUHCS9MGp47F+5JoLqUa8z0dTdziMKcaR93sqzGJCIq8R/8bY3MqPZ8txeXiu3szZv6mTUsuAZdi/8PORl127YRI9WTmPuggtE9kuYNHlUV/tCNKgOvboyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jAeHHMty; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dff189c7e65so264196276.1
        for <linux-csky@vger.kernel.org>; Thu, 13 Jun 2024 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718321498; x=1718926298; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bv/Fm1C1sIcT67jHqqKPUxG1mSp4iG3kEZiVQMnNilI=;
        b=jAeHHMtyuAyFgB/ygZ6TqeTHnxMJfcJiuIizWet7iiyUy+k3/SW7bBBzZqz7DtP3mq
         tKMkrFdM9dCnMFz8awAGXylw0eXA2Zo1DI3kigyKzUNu8o9OUUv47Yy0laR4wr9Rdfe+
         A5pCrJhAQa1PnvF1rXy5TB+EYRbG0eKZAp4/5H6+cF8K1qtLolxYMD9HtRXIKYWpOc+L
         gLXeFoDohvL++ODw2mIQUxd5U7IXWeg0bjHIf/y4Ck52iXllmOqGGB7shhXtaGn6hGyD
         s11Zuda+RP+ETK2Gc6eyJ+SiS9XPze22RpBRHmNs+mJ+hil+0BqpFu+g6IkRI0jAsTbY
         DrbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718321498; x=1718926298;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bv/Fm1C1sIcT67jHqqKPUxG1mSp4iG3kEZiVQMnNilI=;
        b=a9fdENUueIQmHZ0ReGSNGvECQUBE7VTYUlvOy56tYcvN5jNHxB3pWooW0yfa3q2TgV
         c9SCe7QUGrt/rNZfwpfO7H9f/qjoIYkN9oDJMiRCaY7FrXG1LMf4bNr7km5NyyRbJIUw
         fcSgIdyv+NC9uAfHLX/PHmONmDSbCa27+DHZkdMxF7jDd8ysZ6H4Po+X/1UVz06qpIYz
         pbWKbgpRqRtqpwccKEqaaX2Wjb5i79y5IWqTAQ5W9fb3N25Y2ErjWBr9bWgFvouLPK+t
         K4iT7hE6WCQKC0Yv2xC9WS07zoDVlR/DjVJK0pCkfcy/eL4D+2L7cEtCQZWth6sHA+l7
         O30Q==
X-Forwarded-Encrypted: i=1; AJvYcCUQF2c626Wnh50+R4lw1mjkLWzbxlgDAGe8slgk2w8xtbQCn8ZaAKHvtMO9sJ6KBmOcOyEIVjsz3pUgTX7DobwZ+Fwq1lxTI2o5Cg==
X-Gm-Message-State: AOJu0YxbTiYnn89GEZBxRGZO8uEsz4qPLwTEHQUeZd+0cwTbqfAZHOY+
	Ti+KESNdqagJpZuHIZZ1lBBU8zOkgMeV4jL0dmIOTkSm8wMHRknPHscHBbiGEk4rimonuP7/33E
	+6kwJrA==
X-Google-Smtp-Source: AGHT+IEeElc3Y5HxcuYVce8c3qaAQhtxoPOeS2i+52eehdbxjLd+idIerVIBEsPYYq9g+NtXzt+B6SE6V2RK
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:96dd:26a6:1493:53c8])
 (user=irogers job=sendgmr) by 2002:a05:6902:2988:b0:dfa:4b20:bdaf with SMTP
 id 3f1490d57ef6-dff15470dfdmr79758276.13.1718321498506; Thu, 13 Jun 2024
 16:31:38 -0700 (PDT)
Date: Thu, 13 Jun 2024 16:31:14 -0700
Message-Id: <20240613233122.3564730-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Subject: [PATCH v3 0/8] Refactor perf python module build
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Nick Terrell <terrelln@fb.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Kees Cook <keescook@chromium.org>, Andrei Vagin <avagin@google.com>, 
	Athira Jajeev <atrajeev@linux.vnet.ibm.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	coresight@lists.linaro.org, rust-for-linux@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Refactor the perf python module build to instead of building C files
it links libraries. To support this make static libraries for tests,
ui, util and pmu-events. Doing this allows fewer functions to be
stubbed out, importantly parse_events is no longer stubbed out which
will improve the ability to work with heterogeneous cores.

By not building .c files for the python module and for the build of
perf, this should also help build times.

Patch 1 adds '*.a' cleanup to the clean target.

Patches 2 to 6 add static libraries for existing parts of the perf
build.

Patch 7 adds the python build using libraries rather than C source
files.

Patch 8 cleans up the python dependencies and removes the no longer
needed python-ext-sources.

v3: Add missed xtensa directory for the util build. Remove adding the
    arch directory to perf-y as it creates an empty object file that
    breaks with GCC and LTO.
v2: Add '*.a' cleanup to clean target. Add reviewed-by James Clark.

Ian Rogers (8):
  perf build: Add '*.a' to clean targets
  perf ui: Make ui its own library
  perf pmu-events: Make pmu-events a library
  perf test: Make tests its own library
  perf bench: Make bench its own library
  perf util: Make util its own library
  perf python: Switch module to linking libraries from building source
  perf python: Clean up build dependencies

 tools/perf/Build                              |  14 +-
 tools/perf/Makefile.config                    |   5 +
 tools/perf/Makefile.perf                      |  83 +++-
 tools/perf/arch/Build                         |   5 +-
 tools/perf/arch/arm/Build                     |   4 +-
 tools/perf/arch/arm/tests/Build               |   8 +-
 tools/perf/arch/arm/util/Build                |  10 +-
 tools/perf/arch/arm64/Build                   |   4 +-
 tools/perf/arch/arm64/tests/Build             |   8 +-
 tools/perf/arch/arm64/util/Build              |  20 +-
 tools/perf/arch/csky/Build                    |   2 +-
 tools/perf/arch/csky/util/Build               |   6 +-
 tools/perf/arch/loongarch/Build               |   2 +-
 tools/perf/arch/loongarch/util/Build          |   8 +-
 tools/perf/arch/mips/Build                    |   2 +-
 tools/perf/arch/mips/util/Build               |   6 +-
 tools/perf/arch/powerpc/Build                 |   4 +-
 tools/perf/arch/powerpc/tests/Build           |   6 +-
 tools/perf/arch/powerpc/util/Build            |  24 +-
 tools/perf/arch/riscv/Build                   |   2 +-
 tools/perf/arch/riscv/util/Build              |   8 +-
 tools/perf/arch/s390/Build                    |   2 +-
 tools/perf/arch/s390/util/Build               |  16 +-
 tools/perf/arch/sh/Build                      |   2 +-
 tools/perf/arch/sh/util/Build                 |   2 +-
 tools/perf/arch/sparc/Build                   |   2 +-
 tools/perf/arch/sparc/util/Build              |   2 +-
 tools/perf/arch/x86/Build                     |   6 +-
 tools/perf/arch/x86/tests/Build               |  20 +-
 tools/perf/arch/x86/util/Build                |  42 +-
 tools/perf/arch/xtensa/Build                  |   2 +-
 tools/perf/bench/Build                        |  46 +-
 tools/perf/scripts/Build                      |   4 +-
 tools/perf/scripts/perl/Perf-Trace-Util/Build |   2 +-
 .../perf/scripts/python/Perf-Trace-Util/Build |   2 +-
 tools/perf/tests/Build                        | 140 +++----
 tools/perf/tests/workloads/Build              |  12 +-
 tools/perf/ui/Build                           |  18 +-
 tools/perf/ui/browsers/Build                  |  14 +-
 tools/perf/ui/tui/Build                       |   8 +-
 tools/perf/util/Build                         | 394 +++++++++---------
 tools/perf/util/arm-spe-decoder/Build         |   2 +-
 tools/perf/util/cs-etm-decoder/Build          |   2 +-
 tools/perf/util/hisi-ptt-decoder/Build        |   2 +-
 tools/perf/util/intel-pt-decoder/Build        |   2 +-
 tools/perf/util/perf-regs-arch/Build          |  18 +-
 tools/perf/util/python-ext-sources            |  53 ---
 tools/perf/util/python.c                      | 271 +++++-------
 tools/perf/util/scripting-engines/Build       |   4 +-
 tools/perf/util/setup.py                      |  33 +-
 50 files changed, 625 insertions(+), 729 deletions(-)
 delete mode 100644 tools/perf/util/python-ext-sources

-- 
2.45.2.627.g7a2c4fd464-goog


