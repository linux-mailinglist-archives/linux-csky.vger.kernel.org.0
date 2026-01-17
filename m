Return-Path: <linux-csky+bounces-2708-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BB3D38C82
	for <lists+linux-csky@lfdr.de>; Sat, 17 Jan 2026 06:29:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DB443038362
	for <lists+linux-csky@lfdr.de>; Sat, 17 Jan 2026 05:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7E9329C60;
	Sat, 17 Jan 2026 05:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DkRIwb5U"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD5F329388
	for <linux-csky@vger.kernel.org>; Sat, 17 Jan 2026 05:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627766; cv=none; b=orvtWYR6lA9tXco0YdOc1lgTzndrG91yiU83jS5AAjjaETlvhs8WgpXVROo2QR6RRFK8GtGvLvIUIs+gqNKmAPCagv8gAWkLBYfuZOSDUcwMhLoYlLZrwS4QaWT6lwupQKOLdSpilhLtaN5ixJ98JG0CB33xYAcBhW9W0j3UHWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627766; c=relaxed/simple;
	bh=PGz82t4fQNpiLxXfLez2T61xsRU+uyF68xd2aHc7TqQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=sG4996XCjoqG/HaPB9Stqv5zWM4x5QTqRhJGYUg3y7IPL8WrJOgH1Sao/c9oj5dxl4/LZ9D6BkO7rMxj6ItkDLMEMVnfUbuE+A75Ja+8jmnbXwznZauvz/jqBGtAVtDFGI+zezPN4h9c4rCv0btTksyULzIenMEfKLRWMTR2B/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DkRIwb5U; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12339e20b66so3204696c88.0
        for <linux-csky@vger.kernel.org>; Fri, 16 Jan 2026 21:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627764; x=1769232564; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mz2w6bSYQtg03VDKQBBKJWoE2q+Ly0vxb+x/N3KKFNE=;
        b=DkRIwb5UjoEgoZv4NZCZiN6BN7sOzD1WNS55dwOlCuZCvt0sZKUnnb3aT8BuLALnMm
         EGA8022IVgxkp4ZPAT9vioBEwrDfF1IF/VZq0aIo83ftIHBQ2oJw3lhyQKBzZJ+SWNPZ
         ETwiCdE+qiHLku1uIX5y/8ecYMxiJIYwZcwi8i4vgW6fuuVueRcR08lMq9IWmN2xDBSC
         xU6CNCEgcQyUk55WwNYfDv4Fb+SXfNvvGgZp8V2Ucmoxg7Te65is4FD/VDCTR15u4S1K
         EpHNp4zXUUeYzk21JCsRqNuNyRVwFUIovCrqH/xqQ0+RD0/iJFNWQssk0YrmcgwHAH4s
         ESdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627764; x=1769232564;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mz2w6bSYQtg03VDKQBBKJWoE2q+Ly0vxb+x/N3KKFNE=;
        b=bb7gjkHr/utq7KsD1AP2FH95+sWfup/pufIGmy7eWE2oXZ+WIal/MIvurDoQ+0P80t
         9j5W8LbxsWLJ2C66UzO6WNhtZwmz2wgaxfTy192h2NjcAjuY1yHg0imfkLfgJ9MXh9fw
         /klw9l8++7qN+4jnyjnAN7pB78UzX8BJ8txzNfQVFgZFXpu+K3Yu/B7llLH0z0yzHgkF
         QWOdSuu9JHrszKkx3myHP0ArbBbEJwmrGaSeg5962TXyJewyoJpgbxEgrMLclh1LMAiG
         UJycFMDox0nCk9CawaAdbKtef2nYAHEtAhzdxpKyvEkKaZlH34T1Ki2RKS/ssQAa9tGj
         A85Q==
X-Forwarded-Encrypted: i=1; AJvYcCUfBwlx4deDt2F4TLHpfH3cRhhhO5RocicyMkpEbWdtPsYd/Ovb28QkvjDCqkM78PnEVuWgJeqoN1Ls@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi6+LkkSAEWN4bb7gkw9a/Q2sCrNUjaqVbbGC7XkAWZb15joc5
	U8SSahZOWwv4htvvhj/W91wtazMEboCW9gVswDjw0pKUN3D+d04jrXwSZhkpkwIgFWGPiuVuewd
	Y/Ni6pVi0AQ==
X-Received: from dlad13.prod.google.com ([2002:a05:701b:220d:b0:11f:330d:ed15])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1e01:b0:123:2d38:928e
 with SMTP id a92af1059eb24-1244b36d491mr3478584c88.35.1768627764374; Fri, 16
 Jan 2026 21:29:24 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:29 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-4-irogers@google.com>
Subject: [PATCH v1 03/23] perf record: Disable inline frames when marking
 build IDs
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Shimin Guo <shimin.guo@skydio.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Stephen Brennan <stephen.s.brennan@oracle.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, Chun-Tse Shao <ctshao@google.com>, 
	Aditya Bodkhe <aditya.b1@linux.ibm.com>, Haibo Xu <haibo1.xu@intel.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Mark Wielaard <mark@klomp.org>
Content-Type: text/plain; charset="UTF-8"

Marking DSOs doesn't need inline frames traversing as the inline
frames are all part of the same DSO. Disable to improve performance
and also to avoid potential issues with dwarf information.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 003e47a4fc1d..663ca3a03396 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1509,6 +1509,8 @@ static int process_buildids(struct record *rec)
 	if (perf_data__size(&rec->data) == 0)
 		return 0;
 
+	/* A single DSO is needed and not all inline frames. */
+	symbol_conf.inline_name = false;
 	/*
 	 * During this process, it'll load kernel map and replace the
 	 * dso->long_name to a real pathname it found.  In this case
@@ -1519,7 +1521,6 @@ static int process_buildids(struct record *rec)
 	 *   $HOME/.debug/.build-id/f0/6e17aa50adf4d00b88925e03775de107611551
 	 */
 	symbol_conf.ignore_vmlinux_buildid = true;
-
 	/*
 	 * If --buildid-all is given, it marks all DSO regardless of hits,
 	 * so no need to process samples. But if timestamp_boundary is enabled,
-- 
2.52.0.457.g6b5491de43-goog


