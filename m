Return-Path: <linux-csky+bounces-528-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CC990689B
	for <lists+linux-csky@lfdr.de>; Thu, 13 Jun 2024 11:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4837B20E76
	for <lists+linux-csky@lfdr.de>; Thu, 13 Jun 2024 09:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2A813E020;
	Thu, 13 Jun 2024 09:27:26 +0000 (UTC)
X-Original-To: linux-csky@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D6313A3E3;
	Thu, 13 Jun 2024 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718270846; cv=none; b=olCol8EoK3YzkT1KyQV5VbTOAoHvGyFQZ0bCrPyf4wxrKMqaJ9HRncymJeCkiIEUVjRdiLhYcB+1rgCHYny3NlIGJRR38Qjmb61KBcPUsTkEJeygyp67VrWXjL+Wxm15vjR/xNCLoT3A6soN/XIufW1QHV4qOkGfwoTLj+2B+Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718270846; c=relaxed/simple;
	bh=vxAPeb2Mts0r+X8CEYqNf06SKswc4GRuspVbQUOuPS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=JWwnbme+yK8WiV0VbXA8R5KZLHe94n5qYp3heut5dUp8XwhHQGvSXuLGoVMy68Rtes9K+q22seIZMxnrZW2bWOVTaQ/prqFjxa/0sQHQ7h3FYNXKNu388ZoMVxYFU+Z2veBP/efIGXe2DNA1BA8VYrutl3y5aBFTphHNw1Vk0a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED0ED1063;
	Thu, 13 Jun 2024 02:27:46 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F0333F5A1;
	Thu, 13 Jun 2024 02:27:17 -0700 (PDT)
Message-ID: <bdf1ab6e-b887-4182-a0ae-7653bd835907@arm.com>
Date: Thu, 13 Jun 2024 10:27:15 +0100
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/7] Refactor perf python module build
To: Ian Rogers <irogers@google.com>
References: <20240612183205.3120248-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
 Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, Nick Terrell <terrelln@fb.com>,
 Ravi Bangoria <ravi.bangoria@amd.com>, Kees Cook <keescook@chromium.org>,
 Andrei Vagin <avagin@google.com>, Athira Jajeev
 <atrajeev@linux.vnet.ibm.com>, Oliver Upton <oliver.upton@linux.dev>,
 Ze Gao <zegao2021@gmail.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
 coresight@lists.linaro.org, rust-for-linux@vger.kernel.org,
 bpf@vger.kernel.org
From: James Clark <james.clark@arm.com>
In-Reply-To: <20240612183205.3120248-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/06/2024 19:31, Ian Rogers wrote:
> Refactor the perf python module build to instead of building C files
> it links libraries. To support this make static libraries for tests,
> ui, util and pmu-events. Doing this allows fewer functions to be
> stubbed out, importantly parse_events is no longer stubbed out which
> will improve the ability to work with heterogeneous cores.
> 
> Patches 1 to 5 add static libraries for existing parts of the perf
> build.
> 
> Patch 6 adds the python build using libraries rather than C source
> files.
> 
> Patch 7 cleans up the python dependencies and removes the no longer
> needed python-ext-sources.
> 

Reviewed-by: James Clark <james.clark@arm.com>

It does require a clean build to avoid some -fPIC errors presumably
because not everything that requires it gets rebuilt, for anyone who
gets stuck on that.

> Ian Rogers (7):
>   perf ui: Make ui its own library
>   perf pmu-events: Make pmu-events a library
>   perf test: Make tests its own library
>   perf bench: Make bench its own library
>   perf util: Make util its own library
>   perf python: Switch module to linking libraries from building source
>   perf python: Clean up build dependencies
> 
>  tools/perf/Build                              |  14 +-
>  tools/perf/Makefile.config                    |   5 +
>  tools/perf/Makefile.perf                      |  66 ++-
>  tools/perf/arch/Build                         |   4 +-
>  tools/perf/arch/arm/Build                     |   4 +-
>  tools/perf/arch/arm/tests/Build               |   8 +-
>  tools/perf/arch/arm/util/Build                |  10 +-
>  tools/perf/arch/arm64/Build                   |   4 +-
>  tools/perf/arch/arm64/tests/Build             |   8 +-
>  tools/perf/arch/arm64/util/Build              |  20 +-
>  tools/perf/arch/csky/Build                    |   2 +-
>  tools/perf/arch/csky/util/Build               |   6 +-
>  tools/perf/arch/loongarch/Build               |   2 +-
>  tools/perf/arch/loongarch/util/Build          |   8 +-
>  tools/perf/arch/mips/Build                    |   2 +-
>  tools/perf/arch/mips/util/Build               |   6 +-
>  tools/perf/arch/powerpc/Build                 |   4 +-
>  tools/perf/arch/powerpc/tests/Build           |   6 +-
>  tools/perf/arch/powerpc/util/Build            |  24 +-
>  tools/perf/arch/riscv/Build                   |   2 +-
>  tools/perf/arch/riscv/util/Build              |   8 +-
>  tools/perf/arch/s390/Build                    |   2 +-
>  tools/perf/arch/s390/util/Build               |  16 +-
>  tools/perf/arch/sh/Build                      |   2 +-
>  tools/perf/arch/sh/util/Build                 |   2 +-
>  tools/perf/arch/sparc/Build                   |   2 +-
>  tools/perf/arch/sparc/util/Build              |   2 +-
>  tools/perf/arch/x86/Build                     |   6 +-
>  tools/perf/arch/x86/tests/Build               |  20 +-
>  tools/perf/arch/x86/util/Build                |  42 +-
>  tools/perf/bench/Build                        |  46 +-
>  tools/perf/scripts/Build                      |   4 +-
>  tools/perf/scripts/perl/Perf-Trace-Util/Build |   2 +-
>  .../perf/scripts/python/Perf-Trace-Util/Build |   2 +-
>  tools/perf/tests/Build                        | 140 +++----
>  tools/perf/tests/workloads/Build              |  12 +-
>  tools/perf/ui/Build                           |  18 +-
>  tools/perf/ui/browsers/Build                  |  14 +-
>  tools/perf/ui/tui/Build                       |   8 +-
>  tools/perf/util/Build                         | 394 +++++++++---------
>  tools/perf/util/arm-spe-decoder/Build         |   2 +-
>  tools/perf/util/cs-etm-decoder/Build          |   2 +-
>  tools/perf/util/hisi-ptt-decoder/Build        |   2 +-
>  tools/perf/util/intel-pt-decoder/Build        |   2 +-
>  tools/perf/util/perf-regs-arch/Build          |  18 +-
>  tools/perf/util/python-ext-sources            |  53 ---
>  tools/perf/util/python.c                      | 271 +++++-------
>  tools/perf/util/scripting-engines/Build       |   4 +-
>  tools/perf/util/setup.py                      |  33 +-
>  49 files changed, 612 insertions(+), 722 deletions(-)
>  delete mode 100644 tools/perf/util/python-ext-sources
> 

