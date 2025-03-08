Return-Path: <linux-csky+bounces-1898-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E39A576DD
	for <lists+linux-csky@lfdr.de>; Sat,  8 Mar 2025 01:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 818D5189AF1A
	for <lists+linux-csky@lfdr.de>; Sat,  8 Mar 2025 00:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB71182CD;
	Sat,  8 Mar 2025 00:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2nRQ8Mfe"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B23DDCD
	for <linux-csky@vger.kernel.org>; Sat,  8 Mar 2025 00:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741393938; cv=none; b=E3MFIlxVKfZlvDkTuOagMxv5DVkcdqDaQXnXT9onh7AYW0YUMSOTcdose/9Zph9wVyoXWTzAddlFZF1ERK1LoMjf+myHX9ujJvEYLKMXA83flmpy3Tn4ABsIJ0QEY9TOxS0F+vCBV6Hxb6I10sHjUNojbbT/Qd1VLaHKSjA1C9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741393938; c=relaxed/simple;
	bh=itceXzcWP1atjoAHUjimAtWQITJXd7w88z0cdHciNBg=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=B2puj/my8UNPjQyIyFlnGP5ZmGg85E+wUwKC+pfAwhE5GUAUIOHky3Z6HyhMEKHvXt5E+RzEkAy6p+XUxyhd+d0oARsuwqk9635iCDOuYF4IEmMwxpqM8srxDW8beqlDpNiknfoyTlnVjp4y6O7S9ad+alMOfnIO09neWJt2aZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2nRQ8Mfe; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f2bc451902so39918877b3.3
        for <linux-csky@vger.kernel.org>; Fri, 07 Mar 2025 16:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741393935; x=1741998735; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ivnbhuhI/ixgKyNuqtV9wf0AaXG2gqT9U4XDml1DXZU=;
        b=2nRQ8MfeNrUSJ6y6rPfcxnWaA8gwbOXfckKIHh2z79iH8cNP+tmWFrBknL4/jecJmA
         UK6kDxjQdQ74SkrzHNgVJY1arDHjnBo3e6MTtUg+aPMvayhaSvl+r2rt6UI6phukmIeP
         5FPgsx53FkBsGKk4QOHZRhGBBUOeUFDkjxRo6QNkabpM5CVR7NaDnzNnuqvzPbhRYpMo
         Lnzu//CR6TVKKKQnBxcEy0vy0qLuBg9tx1YDVEuqRAFtnBAqvQOaPO0Pemmk3mA1cwHw
         u+WgC2GuFWwTp96+c7MqBoZUR722Yx+Ga5iL6d6n63EjBlOigfey8ruilN2PjguTwRlM
         h3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741393935; x=1741998735;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ivnbhuhI/ixgKyNuqtV9wf0AaXG2gqT9U4XDml1DXZU=;
        b=eugJfIrAs+z8hnVkTX5cox6hD5wCnInSXhnMjIj4rHRuMB9wSD3VBRTOHny35tEmwR
         dPTLDQ/HUBwx2GxG+dOhkuyrFU1IWWxtwvcix9WLgdX8n9ZR4+TIJR/0XnM9zjKOnc1m
         3FMcNkq0EPzxa85Y5NC0vx8Nn594i2IJbATHXCWEhX2pRqWTW7QBAQTD4mSwSrf6nUmB
         Nx2Kn8/IdK5Udr1o12nYR0lrKk2GrK7mXRG4yrKnBH2TzfJ7V1S6zjWBVq9mkkLNjh0F
         7TOfVkjgYLWxgNx+xH+EbhFgrzGcBEa+rvvJeCpdN7Ldndv1B29XlfufF502e2LpRT60
         2EQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0ZFQ995ZO3yWN3zKYO6jlu8nUYuSJi282iRA5a4QXgzXj+UuI1ACHewpp0K82rCmJClfNyg+Fpro0@vger.kernel.org
X-Gm-Message-State: AOJu0YxRfQoqwgvKM/em4rKoQ3xudNyTS58T3e6lJED8fAxlj6oSd8pj
	X6sUsESzvXoplmJDy35BvEZYR4Cii14GZ2e/kzKEqa/XbJQ3bi/LxtbL+ZReCxScSX6SgzrSRMt
	4vT6Gdg==
X-Google-Smtp-Source: AGHT+IG6YNEzBmSnRkSpppexP7sY3bjIUwdOpxoYGty73UlROUhquWw1r9gEA9sFFMJohI1jVlJGdzxY77PY
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:1541:e490:aa80:5766])
 (user=irogers job=sendgmr) by 2002:a25:728a:0:b0:e60:96b9:bee8 with SMTP id
 3f1490d57ef6-e635c1ecad7mr49692276.7.1741393934929; Fri, 07 Mar 2025 16:32:14
 -0800 (PST)
Date: Fri,  7 Mar 2025 16:31:59 -0800
In-Reply-To: <20250308003209.234114-1-irogers@google.com>
Message-Id: <20250308003209.234114-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250308003209.234114-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v5 01/11] perf dso: Move libunwind dso_data variables into ifdef
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
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"

The variables elf_base_addr, debug_frame_offset, eh_frame_hdr_addr and
eh_frame_hdr_offset are only accessed in unwind-libunwind-local.c
which is conditionally built on having libunwind support. Make the
variables conditional on libunwind support too.

Reviewed-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index bb8e8f444054..dfd763a0bd9d 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -154,10 +154,12 @@ struct dso_data {
 	int		 status;
 	u32		 status_seen;
 	u64		 file_size;
+#ifdef HAVE_LIBUNWIND_SUPPORT
 	u64		 elf_base_addr;
 	u64		 debug_frame_offset;
 	u64		 eh_frame_hdr_addr;
 	u64		 eh_frame_hdr_offset;
+#endif
 };
 
 struct dso_bpf_prog {
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


