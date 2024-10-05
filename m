Return-Path: <linux-csky+bounces-948-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2949991A3F
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 21:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223951C21644
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 19:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC7217D34D;
	Sat,  5 Oct 2024 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h2DPOUdT"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A92B17C9AF
	for <linux-csky@vger.kernel.org>; Sat,  5 Oct 2024 19:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158188; cv=none; b=WNJcbqRVRoiPpNnmEamMm7G1phzKz/J3hGTYxDkZyrA/axWiV+GBNWo1w82UMsycA5X6kUzgZwpisD7VBlnp2x3Ty58tV63l5IUpYum+vXi+LRAK2j+XG7j3tf1o3oFSW9oSlnmdeOaSfyjNNhMhWLMMaCCbzsOMQGzvfOVtoVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158188; c=relaxed/simple;
	bh=5PAi6ooydC2034Tlqdv0mieuQRt/MPe6ihmi35Ubwc4=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=UO6qrWH1uXaHu/lSLZezReANXAi1+YDc0dseNao+5G2/eP/znsAFREHpn9DOSw86pf6QtshFLZJJVyAcrZVZ+y0Pw7cG95uyFdShCVuEKzFxsIGB2xz+/uXr1VwqsScQ5mgzVzqZ2iafbojAJ6deJNeX4eynAYl+605jCXrwDl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h2DPOUdT; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e24e37f1eeso68179497b3.0
        for <linux-csky@vger.kernel.org>; Sat, 05 Oct 2024 12:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158185; x=1728762985; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h/3DcHqmbVdZp4yWyNeZgt8hRC6twmBuki9IOXFR1Fk=;
        b=h2DPOUdTj9+Nh4C5e8DMq4W7/0lJtuevRupKExllqSegkN5xFqBnmoiGkJxWVy75AS
         r67cIoD2ZoZAo6lVXw7qK81GfiAE48Z1YqHnJUcEtOFklbwOFNjswvLVXcZobR9wE/S/
         vWJcZKd6/qNEl0jxoQiHwBTIPj5ftw1mV1Upt2y8wHLN4ZvGo8Kvzd75g/q87e6RGUF6
         0qIk/QZUqBMbWGt0B+43Q2AbMJHeP0PBBzsEYAuE/3UbdPmtHs4MCHYYMxxdKOolTc/x
         0fPrM8yCKD89w+eNhja2ih9lInGu7ny0rS/uwlH4qd7gtaabvei6XSuIfFNOuJAc2Yji
         qSeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158185; x=1728762985;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/3DcHqmbVdZp4yWyNeZgt8hRC6twmBuki9IOXFR1Fk=;
        b=I1FlqlvKsXfQc8vsa5Ppu6PwYTUcHr8+mcPJmfkXeYllQsUSIEqShOJiRFhyKKSPoi
         YOCmbDtAyiNNIm1Tyv4sBzaK65AB0sqtPfYvePFSe2gDG0ncRCiixpYcQgHfHg25fybf
         VyI4IXMALqI+0tUr0PqsqM4bI8RBXVQj9NzT7/cDUkmEpP9uqU6/jgBh9nya5rEY3fOT
         RHhPpeXhK+CXq29iL64h9cnvrCvvlZ9DCmNxbQX6hVmiGiLfueGFCO+esIwinZFTaV+h
         nZ7asS2Qxz2dwQz71BbQB9xUxJ5GwZpORefq0o+VUDRqRNWXLWYqgTwcXZjhZ9Mn/zoa
         uznA==
X-Forwarded-Encrypted: i=1; AJvYcCV7jdTE+GTSj3OOUL3dPLag8bZ/TdMy+3C331HTss7sQD0fGVfCVCFVmqBF0iNeu9TJC0wxkPdfHoA1@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6LbTOxNZuwuHHNdbghfxKcaqXpPNF2xH2QIlXbvljf5UgoUu
	OJa0kqDfRPS5AdgYoum9yrC5dXUoagYLOh2auhaTMUpNKY40eohjXYIWE7YKOFtDCQRH5gwIylq
	EbEl7Dw==
X-Google-Smtp-Source: AGHT+IFisEJrumnwhsHUHkUR8QAhAmeXxmT2VH1277V55Dcfln2xbxOQ1sJmjrLj9pgNFaHmZqxuL/PfQjiy
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a05:690c:f8b:b0:6e2:ef1:2551 with SMTP id
 00721157ae682-6e2c72af775mr523117b3.8.1728158185409; Sat, 05 Oct 2024
 12:56:25 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:22 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-13-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 12/31] perf bpf-prologue: Remove unused file
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
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, 
	Guilherme Amadio <amadio@gentoo.org>, Changbin Du <changbin.du@huawei.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, Daniel Wagner <dwagner@suse.de>, 
	Aditya Gupta <adityag@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Kajol Jain <kjain@linux.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Bibo Mao <maobibo@loongson.cn>, 
	Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>, 
	Shenlin Liang <liangshenlin@eswincomputing.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Steinar H. Gunderson" <sesse@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Chen Pei <cp0613@linux.alibaba.com>, Dima Kogan <dima@secretsauce.net>, 
	Yury Norov <yury.norov@gmail.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Commit 4a73fca22692 ("perf bpf-prologue: Remove unused file") missed
cleaning up the header file. The code was unnecessary as Commit
3d6dfae88917 ("perf parse-events: Remove BPF event support") removed
building bpf-prologue.c.

Fixes: 4a73fca22692 ("perf bpf-prologue: Remove unused file")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/bpf-prologue.h | 37 ----------------------------------
 1 file changed, 37 deletions(-)
 delete mode 100644 tools/perf/util/bpf-prologue.h

diff --git a/tools/perf/util/bpf-prologue.h b/tools/perf/util/bpf-prologue.h
deleted file mode 100644
index 66dcf751ef65..000000000000
--- a/tools/perf/util/bpf-prologue.h
+++ /dev/null
@@ -1,37 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2015, He Kuang <hekuang@huawei.com>
- * Copyright (C) 2015, Huawei Inc.
- */
-#ifndef __BPF_PROLOGUE_H
-#define __BPF_PROLOGUE_H
-
-struct probe_trace_arg;
-struct bpf_insn;
-
-#define BPF_PROLOGUE_MAX_ARGS 3
-#define BPF_PROLOGUE_START_ARG_REG BPF_REG_3
-#define BPF_PROLOGUE_FETCH_RESULT_REG BPF_REG_2
-
-#ifdef HAVE_BPF_PROLOGUE
-int bpf__gen_prologue(struct probe_trace_arg *args, int nargs,
-		      struct bpf_insn *new_prog, size_t *new_cnt,
-		      size_t cnt_space);
-#else
-#include <linux/compiler.h>
-#include <errno.h>
-
-static inline int
-bpf__gen_prologue(struct probe_trace_arg *args __maybe_unused,
-		  int nargs __maybe_unused,
-		  struct bpf_insn *new_prog __maybe_unused,
-		  size_t *new_cnt,
-		  size_t cnt_space __maybe_unused)
-{
-	if (!new_cnt)
-		return -EINVAL;
-	*new_cnt = 0;
-	return -ENOTSUP;
-}
-#endif
-#endif /* __BPF_PROLOGUE_H */
-- 
2.47.0.rc0.187.ge670bccf7e-goog


