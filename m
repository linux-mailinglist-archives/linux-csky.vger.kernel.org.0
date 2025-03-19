Return-Path: <linux-csky+bounces-2004-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE83A68479
	for <lists+linux-csky@lfdr.de>; Wed, 19 Mar 2025 06:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23CEF3AE3B3
	for <lists+linux-csky@lfdr.de>; Wed, 19 Mar 2025 05:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D035253334;
	Wed, 19 Mar 2025 05:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mTs64ygf"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3273252915
	for <linux-csky@vger.kernel.org>; Wed, 19 Mar 2025 05:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742360901; cv=none; b=OrJ5KlyqlapYVRsGcRDwXrdxs3rDyC5W1wcvCMQW+xmt3teYgK2KQ8EgsH4hm3URNhmcPVVPLp1wZOvls4Efe09LPDfJzIR1cI/L1VXvBdf4y4pvGilkJCSqVbGGpSVWaZ/Qe2hlaSJjQJYORO1KEjWXJgR0ODfyiQEk1LAN/xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742360901; c=relaxed/simple;
	bh=FwwCUQYWW0iPLjUpMdjojzAG65ocZ3jEUzcBFQsWjIY=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=a2QcaTiq+5SoW/REj5mu8f+uFrcq+xhW8X/kqwvsmEFqbWMsRcMt+4azHRIFjiHu9RhsKknFEQG5pKidHu4yDhyBGLrqElkF/N6pSsiNDb+ttVNHRVYe0gXyJTPC1tTIh4v8XOW0a/wlOPBzpXMdvPJz0L87CtHyv+lFweQbqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mTs64ygf; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fecdb96e52so91524527b3.2
        for <linux-csky@vger.kernel.org>; Tue, 18 Mar 2025 22:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742360899; x=1742965699; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGnh5R7F2nGjibuMN1IiOugHr5YAQ01+XconQh81ims=;
        b=mTs64ygfkHOpOUAgupDi4Vjty844ukF4nAIVX11Ymk/TgNL93v9sOI72KOUy3ovoFx
         6lC2l8B2Mxg6ifGjYF2tRHE3BKppM8pYNlP8b/wvRHDP3FiHEL5V64M0vtW1NkOU7SWL
         vLtT28jgPlWb7M8PtjWtR2rJmuQIN1K3QNYTrZ8MMev9tg6ex6KeyTCb3vR8yXcz0uTj
         jnfOWCjNQZyvzgCP2mVuwKpWA8NpwRTj8puDdMIGPLZsekKpN1TBWnSwW9pb6Oa3nPBt
         Eq0UGGlD8h0K6c9Aesc4mLJqFL3X94OUGmiJhJ3C+1XWy2eHjwVMU6lf3LRWk7iHGJss
         ccbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742360899; x=1742965699;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGnh5R7F2nGjibuMN1IiOugHr5YAQ01+XconQh81ims=;
        b=MvDaW6VXpsiSqY3pOsZ3iPXGnBETZ7wiRDK/Kzn2CDPMwk7hEqJPiG+fvwaeSrQbap
         niiwRPtNlmAZBgecUnAWhOtsdPQFTmMZm0lHq07DDOu0LE9pON/2Ld5ksFrQm+ooFv10
         CiBdwjXo0rRuY6Ld0m5EqciXAYAtMFhtMSzV/nPhqc3vd/BCxCssDN6cA2T6+WhERN0t
         OaEZjVPJFjiLBSNvqCDYsvXlJMVZ7V6Ir001vjhZ3mqY/z8JSQMRfcGmhed1X0IGIDMF
         yNuVd7gBc7hDoaXw5Mx3SRV9dgVyRn+87HiNmtesERBF9uRbks35gTc0SPmnKwGT9Jn4
         fHrw==
X-Forwarded-Encrypted: i=1; AJvYcCUXzOXeKAzq4IjGLzXYeM749RDZCKOKz3UwiyTqSqBN2L0QGWecPNloTTIHmlImA200bUP0oE/dQPv6@vger.kernel.org
X-Gm-Message-State: AOJu0YypEWxqjCUGWESsKO6BIiVR6Zwl+hfVZ3uuhJUTG4n7P4S55ZJf
	ndqg8z4q/2W5K/nqr7JJnT4mciR3u+8BZQwxbi1dnFT0FZsnvZOgSGph8etarAfc2O7ezBSIVmh
	9BkgOOQ==
X-Google-Smtp-Source: AGHT+IHv1nfcfv3Ye5fOTqwhfAPWbuVvzkQzn8h4pmksBhQF9eFLTiSxCvjG8QByREOpkefDEY1DbG6A3hXY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8a11:10b5:af90:6031])
 (user=irogers job=sendgmr) by 2002:a25:dc03:0:b0:e63:699a:4e6b with SMTP id
 3f1490d57ef6-e667b41463bmr514276.4.1742360898600; Tue, 18 Mar 2025 22:08:18
 -0700 (PDT)
Date: Tue, 18 Mar 2025 22:07:41 -0700
In-Reply-To: <20250319050741.269828-1-irogers@google.com>
Message-Id: <20250319050741.269828-15-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319050741.269828-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v7 14/14] perf trace: Fix evlist memory leak
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

Leak sanitizer was reporting a memory leak in the "perf record and
replay" test. Add evlist__delete to trace__exit, also ensure
trace__exit is called after trace__record.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 1d4ad5d19b10..a102748bd0c9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5339,6 +5339,8 @@ static void trace__exit(struct trace *trace)
 		zfree(&trace->syscalls.table);
 	}
 	zfree(&trace->perfconfig_events);
+	evlist__delete(trace->evlist);
+	trace->evlist = NULL;
 #ifdef HAVE_LIBBPF_SUPPORT
 	btf__free(trace->btf);
 	trace->btf = NULL;
@@ -5719,8 +5721,10 @@ int cmd_trace(int argc, const char **argv)
 		}
 	}
 
-	if ((argc >= 1) && (strcmp(argv[0], "record") == 0))
-		return trace__record(&trace, argc-1, &argv[1]);
+	if ((argc >= 1) && (strcmp(argv[0], "record") == 0)) {
+		err = trace__record(&trace, argc-1, &argv[1]);
+		goto out;
+	}
 
 	/* Using just --errno-summary will trigger --summary */
 	if (trace.errno_summary && !trace.summary && !trace.summary_only)
-- 
2.49.0.rc1.451.g8f38331e32-goog


