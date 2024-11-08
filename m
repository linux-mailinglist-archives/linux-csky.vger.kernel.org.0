Return-Path: <linux-csky+bounces-1259-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BC29C2841
	for <lists+linux-csky@lfdr.de>; Sat,  9 Nov 2024 00:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7996281C8E
	for <lists+linux-csky@lfdr.de>; Fri,  8 Nov 2024 23:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2110B2071E4;
	Fri,  8 Nov 2024 23:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iVOIJpsJ"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31E1F427F
	for <linux-csky@vger.kernel.org>; Fri,  8 Nov 2024 23:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731109576; cv=none; b=jUMNiOPBDbZEwKWdXq9cQGrVUudiBFo0+7i5+8LCogtGYuC83w1dvnIw7+HWlNMBwiiUkXT16kgAGeVlrPh+G3Mka82cZ5l2lfkBmsNCuQb1veesuZd4ZglwG2EnN0eJa1cmS+4jnQhf67xiNcJsI+IKCrWUI4e9M/jv9i5oT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731109576; c=relaxed/simple;
	bh=LPLAfjacKdfDpjocqpboSdEuhv5wpAtxMgZmDHl3E4E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=dBi3z0hfcyXDMvNLzuzJju/YiIN6TNxI6bwXQU44woW5KfBZL7UmkIotCHo8pQjE2AKkvGjgzJLZ9nKgj71ykIQwWyyK+y8ClLwfcmZ/ydkpXCU6CrPTifQa4UjyAQdq6O3l1oLAIBA9aMdV1JjRQDwSymUMSLc4Yd9upulmyEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iVOIJpsJ; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eaa08a6fdbso49349797b3.3
        for <linux-csky@vger.kernel.org>; Fri, 08 Nov 2024 15:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731109572; x=1731714372; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DzvCoj1xeTqTB7wBlJpyRYc+Iy1lxysKbVEC5FnZGzs=;
        b=iVOIJpsJNVixH5uRc8S/ya7xJWLjBMJZ6l70GiIsy+zwSiITe003uo8yv1nxPXY15V
         UKaemDRp2SEac8LgIB7lcHHjpDP6dU8ddNfz+FnC64zw6NAEldBUgJi3wta55T1cW5Er
         A/Ca2I6alc307kvkIt9d2zrBc1ER41nDT3C9WW0i+t6C/3bJELhCO8rkqdHx4VE83ysW
         MNolF5WNdriLYmJyGAztbL7lRnM6vPQ8SAOucZuSx60Ar0VUUCieBmHo3fswZrG8NW06
         OR6QPYmHmiMgps1gtr2lwjdR1AXD4Q0BG/GtJDRBuxQRM/oIh803dlIlojfdXUjQMFVM
         Uj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731109572; x=1731714372;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzvCoj1xeTqTB7wBlJpyRYc+Iy1lxysKbVEC5FnZGzs=;
        b=wnCHG0jurp78gKJnKq6wLqKTFve0YuWQTOStNz1MNkhnJvUE/rUu0+pBvr4rAxPWVR
         eH0XxnmHesrEQoll2izmFMsTAmdG0o/erc6AELwPrLGCbwummMNe4X6Wlyo1qLKeRzqK
         Ik2SE1yeY7k2/qW0O/2vXgAZb/L+6C5Q9dyTraAWaXXIjRuGUU9NIiQZBFQAtz70Gton
         T3PFbWzndTW00yUbW0DC3qxsLDQFSk9ucP4QnVzf3HbLr2hvXR24S/RLN8fkRBzKJKHu
         KwH3IVgoAlcH9YHUlDYOG/JggGFeRa2AzT4o4eEjZgrwe+mhJFfPJ6D8O35x1HHpY3Es
         Vnsg==
X-Forwarded-Encrypted: i=1; AJvYcCWb3M2yPbtgIjUSyxN2OYKyOzWvEwmvnlNtqkZwzIT/QPqgYdUP/0EH0ReLRKVuJLEx4yNC5IJvxyO3@vger.kernel.org
X-Gm-Message-State: AOJu0YwsKLOQE85+G2kD5VnRIkI+O5QyUb+i+u1OV7Pl86dYf09JmOoM
	lkHM2NFbZTR6rRxJL5WjZribiYTIy5nkW5rdr0pfjrFn9YMS0Py0JjFx2fNcJyazK/4mvjPsply
	EhHbu+g==
X-Google-Smtp-Source: AGHT+IGiEURxVyZkRgDVPez0reOEsDnj5mtQIuymDAi91H+shA48+bNTCoiPk5eRO07f4EEtxrSuPDE6Z9oo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:6fd2:1e36:6d8c:7c49])
 (user=irogers job=sendgmr) by 2002:a0d:ed43:0:b0:6ea:7c90:41f2 with SMTP id
 00721157ae682-6eaddfbb341mr180017b3.6.1731109572636; Fri, 08 Nov 2024
 15:46:12 -0800 (PST)
Date: Fri,  8 Nov 2024 15:45:46 -0800
In-Reply-To: <20241108234606.429459-1-irogers@google.com>
Message-Id: <20241108234606.429459-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241108234606.429459-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Subject: [PATCH v4 01/20] perf bpf-prologue: Remove unused file
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

Commit 4a73fca22692 ("perf bpf-prologue: Remove unused file") missed
cleaning up the header file. The code was unnecessary as Commit
3d6dfae88917 ("perf parse-events: Remove BPF event support") removed
building bpf-prologue.c.

Fixes: 4a73fca22692 ("perf bpf-prologue: Remove unused file")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
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
2.47.0.277.g8800431eea-goog


