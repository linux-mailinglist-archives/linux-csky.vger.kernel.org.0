Return-Path: <linux-csky+bounces-1125-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 111B99A16A1
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 02:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D5991C21C2C
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 00:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7331710F2;
	Thu, 17 Oct 2024 00:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zp6MW2rx"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EAF101F2
	for <linux-csky@vger.kernel.org>; Thu, 17 Oct 2024 00:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124053; cv=none; b=Oq7sJ/VxBTWkmsRJqQc/Ofrujk3H12uyPqpydFqdXZq82p+PXhQfpYZa03h5MzlTKlN0ToppxqHJIuNQwb69L5DymiVQ6ESEBFU/3ibNJMam1qRHShUTs6wdkvw2/e0PkLneZoO0GrLB2PN8setDj74xuxeVEkwCoX0EdHgHMeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124053; c=relaxed/simple;
	bh=N/FNDdzSnGn6rfbPuY7fZE8oRTOSouL1X1kHuL97eWg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=JtA3c4uTX7uvLy1bqFgv1ZcEKg1R7t2chKRoBNz/uSD7/F+i9yLMPmWnKccUPJNM+bHEBIS+Ll9SB7Z6a0HSKum+UZqNtfgu3tiR4JrYKWH4cO6ydGuPWaJr2EAi1ajNuLoovrPv+339tNR481bKdf5tpfMLRd0CcuX2BlMlBA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zp6MW2rx; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e35d1d8c82so7511507b3.3
        for <linux-csky@vger.kernel.org>; Wed, 16 Oct 2024 17:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124051; x=1729728851; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vpg7UjVbvMTf2T5M8RY79W0YJsjIkpvO45Q8v0jMOdQ=;
        b=Zp6MW2rxNPZM1Y41dj1VoDB4MvuHTrhRSjQDsALG5unIbRmG3sqVM7mpfuT0D28UT8
         SYrPC02sH49eGX7sJ5GHmjbbkNi4WWzTe470fi4YounBPlcBKUMzNOg5UgNL7ZPCn5Ur
         4mUmzIg8I/3Thi25a83RfwtTcV8w7ErVkKhAxGmc3YrEMcEzHdX5saAMnHEk4VxUu39p
         dG+hQGgFMoBKQveYgj4w9vvJsRm2eifkS6ABpZaAijOPOeN9FXJYyp36WnHY4NDdlGyB
         glGqD8Kxse4GuDSaWuqj49QEVEHVep0nKs5wIeMs4sdOvIFxsV8D2ECkM5JNtuZjPNLQ
         SydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124051; x=1729728851;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vpg7UjVbvMTf2T5M8RY79W0YJsjIkpvO45Q8v0jMOdQ=;
        b=cnUuXEaGpsZRRGdTjJBp6dMrqEoIdeBcr99v1fGOQrjPjnuiX6wX3j0Pl30CfEIkWl
         TtgwIR25Z2yKGdflNMCWXJptX8p9/arjC2co2mnbO2zCmGY8HxQn95X7+Gma8UpgFQSg
         KtaHi+a+jD1pqqx63LZtCqIkq35sdur5sg2vXf/opoXUfN4B009JMwfitkb+7y7bXcny
         Bxi8zdY1gf6WEJ56l7C0xEvvo1NSIu8FfeVKRbAe8qoabvLXgDIpxjFIk9d9RxRJEAww
         NH2hOGjO7t703XumaRQbBCtNy2maaqkfsPWxiBUwfbiw2bcNbmKBKGiH0UedHL4gLKnF
         J2aw==
X-Forwarded-Encrypted: i=1; AJvYcCUlNVJb4++2pPkV3WNMiP4OIoJZ8ZGD38+sMM0E0QI55wf73FEzUrosJBfBNcCiE/XM1l7SgRNJkKTc@vger.kernel.org
X-Gm-Message-State: AOJu0YzE5YGp9bIaPwbHEvn2bEupndAV2eAXIrcvqauviwizAivsAbM2
	di0eWRX1n4TjLFSVI9Hm9mdhByZMBCKuHQ2k0JMWJosxnHGni7M2AXj2/UE0TRPWgw+a6TyKaqg
	sZr+Hpg==
X-Google-Smtp-Source: AGHT+IE02udqyL0ksFlRpgHYEs+RBRyhfL+nQeujKZ+O/NiCK6Bw9qW9/lbqOGgoYUwDeDIjpi9bLcuBC4kZ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a25:9e0a:0:b0:e29:7454:a4dd with SMTP id
 3f1490d57ef6-e29782db2aemr7708276.4.1729124050459; Wed, 16 Oct 2024 17:14:10
 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:13:46 -0700
In-Reply-To: <20241017001354.56973-1-irogers@google.com>
Message-Id: <20241017001354.56973-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017001354.56973-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 03/11] perf build: Remove defined but never used variable
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
	Albert Ou <aou@eecs.berkeley.edu>, Nick Terrell <terrelln@fb.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Changbin Du <changbin.du@huawei.com>, 
	Guilherme Amadio <amadio@gentoo.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Huacai Chen <chenhuacai@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Atish Patra <atishp@rivosinc.com>, Shenlin Liang <liangshenlin@eswincomputing.com>, 
	Anup Patel <anup@brainfault.org>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Previously NO_DWARF_UNWIND was part of conditional compilation but it
is now unused so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index cc2cfc3aab40..dd5468b8b5de 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -756,8 +756,6 @@ endif
 ifeq ($(dwarf-post-unwind),1)
   CFLAGS += -DHAVE_DWARF_UNWIND_SUPPORT
   $(call detected,CONFIG_DWARF_UNWIND)
-else
-  NO_DWARF_UNWIND := 1
 endif
 
 ifndef NO_LOCAL_LIBUNWIND
-- 
2.47.0.105.g07ac214952-goog


