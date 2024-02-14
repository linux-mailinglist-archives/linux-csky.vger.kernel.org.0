Return-Path: <linux-csky+bounces-368-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDBF854893
	for <lists+linux-csky@lfdr.de>; Wed, 14 Feb 2024 12:40:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC871C21842
	for <lists+linux-csky@lfdr.de>; Wed, 14 Feb 2024 11:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 794371A731;
	Wed, 14 Feb 2024 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i6yVSl6u"
X-Original-To: linux-csky@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5118E0E
	for <linux-csky@vger.kernel.org>; Wed, 14 Feb 2024 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707910816; cv=none; b=l+wMQN+6e3RxJ47MCJkZzMiNL4aqIqjgS4wpcJ28G6wDB7vI4Ljt6mzXT4n04HXBE/XXxAZKNhQlBOcxOWmDJrc715sO3UU5Vaa0xjnfGjYRKYFKemEiwtUktC0I/M7J2se1dUHggHHrpeCQ6ORHVXQx5E53DqYqFTQGCk/cG1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707910816; c=relaxed/simple;
	bh=WNSlR33tBViXu08xbrYk0ySUbQI6bmCyn/fNCHmqg6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i5DzlFAHzQ/LQPbsqzPGeAXa78dkZNeWkvk+GWsa3bQDJ8to2427fU+VwBWEDPDKrX+BoWzUnAtBfc73ZzCF4BBeeQOySJCdwfo2gkfMyFdpK0mt/e7cOGbsbrZC40He/tXFoOOamc59FK5l2luYZ+oWx+J+dcGjahiDOalzQJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i6yVSl6u; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707910810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uT81D9JadSG4shnyPAzeCNq5QuDdA42vAVAwALPxupk=;
	b=i6yVSl6uTdkrx6HNLprqf5oHzRLgtC5JZQkJuQR6agOvHCg/AMST2eLGx1vFU3A00TNMDc
	W6HIk/+HvpVx4AhZasgIvsCQXJOr/PttA4KuQJETrVo5d3VvyVx4r36xtpuK4BnKIJ1efl
	CE0D7myb/TkQwGbDq2rSHjzxZkTlhhI=
From: Leo Yan <leo.yan@linux.dev>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	James Clark <james.clark@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ming Wang <wangming01@loongson.cn>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Leo Yan <leo.yan@linux.dev>
Subject: [PATCH v1 0/4] perf parse-regs: Cleanup config and building
Date: Wed, 14 Feb 2024 19:39:43 +0800
Message-Id: <20240214113947.240957-1-leo.yan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Currently, the perf building enables register parsing based on the
target architecture has supported register feature.

Furthermore, the perf building system needs to maintain a variable
'NO_PERF_REGS' and defines macro 'HAVE_PERF_REGS_SUPPORT' for statically
compiling the tool.

As a result, the perf has no flexibilty for parsing register if an
architecture doesn't support it. And the source files use the macro
'HAVE_PERF_REGS_SUPPORT' to switch on and off the register parsing
related code, which is not a good practice.

This series is to remove the static building for register parsing. In
theory, we should can dynamically detect if an arch has support this
feature and functions can return errors when the feature is not
supported.

The first patch is to remove unused build configuration
CONFIG_PERF_REGS.

The second patch is to build perf register functions, without using the
macro 'HAVE_PERF_REGS_SUPPORT' to statically turn on or off code.

The third patch is to introduce a weak function arch__sample_reg_masks(),
this function can allow the target arch to return its sample register
list.  With this change, we can totally remove the macro
'HAVE_PERF_REGS_SUPPORT' in the source file.

The forth patch is to clean up the Makefile for removing relevant
configuration and macro definition, as they are not useful anymore.

I tested this patch set on Arm64 and x86 for building and did a cross
register parsing ('perf record' on Arm64 and 'perf report' on x86).


Leo Yan (4):
  perf build: Remove unused CONFIG_PERF_REGS
  perf parse-regs: Always build perf register functions
  perf parse-regs: Introduce a weak function arch__sample_reg_masks()
  perf build: Cleanup perf register configuration

 tools/perf/Makefile.config                    | 25 --------------
 tools/perf/arch/arm/util/perf_regs.c          |  7 +++-
 tools/perf/arch/arm64/util/machine.c          |  2 ++
 tools/perf/arch/arm64/util/perf_regs.c        |  7 +++-
 tools/perf/arch/csky/util/perf_regs.c         |  7 +++-
 tools/perf/arch/loongarch/util/perf_regs.c    |  7 +++-
 tools/perf/arch/mips/util/perf_regs.c         |  7 +++-
 tools/perf/arch/powerpc/util/perf_regs.c      |  7 +++-
 tools/perf/arch/riscv/util/perf_regs.c        |  7 +++-
 tools/perf/arch/s390/util/perf_regs.c         |  7 +++-
 tools/perf/arch/x86/util/perf_regs.c          |  7 +++-
 tools/perf/util/parse-regs-options.c          |  8 ++---
 .../util/perf-regs-arch/perf_regs_aarch64.c   |  4 ---
 .../perf/util/perf-regs-arch/perf_regs_arm.c  |  4 ---
 .../perf/util/perf-regs-arch/perf_regs_csky.c |  4 ---
 .../util/perf-regs-arch/perf_regs_loongarch.c |  4 ---
 .../perf/util/perf-regs-arch/perf_regs_mips.c |  4 ---
 .../util/perf-regs-arch/perf_regs_powerpc.c   |  4 ---
 .../util/perf-regs-arch/perf_regs_riscv.c     |  4 ---
 .../perf/util/perf-regs-arch/perf_regs_s390.c |  4 ---
 .../perf/util/perf-regs-arch/perf_regs_x86.c  |  4 ---
 tools/perf/util/perf_regs.c                   | 11 ++++--
 tools/perf/util/perf_regs.h                   | 34 +------------------
 23 files changed, 67 insertions(+), 112 deletions(-)

-- 
2.34.1


