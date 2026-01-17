Return-Path: <linux-csky+bounces-2714-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 29967D38C8E
	for <lists+linux-csky@lfdr.de>; Sat, 17 Jan 2026 06:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF6C33059A7D
	for <lists+linux-csky@lfdr.de>; Sat, 17 Jan 2026 05:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A79332ABD0;
	Sat, 17 Jan 2026 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4X8FJQxr"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A5232AABE
	for <linux-csky@vger.kernel.org>; Sat, 17 Jan 2026 05:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627778; cv=none; b=gQCpEZSgaScgs5L+4t/+e6iMZZvb5Y2I0pp3Lsn2JsPlY+7jrOU66eleXvSN8ytQ5Vu5Eufv62bWMtn8BMsRVS7VqxTGvPy6HHtchViV4WLmfxqawfrgjrJ+BgjlZofULTLsbS0LNMuk7B/R5vXo6ZpRJoQLjh4t1AR9sacdfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627778; c=relaxed/simple;
	bh=MGf9/co0ByLS5RAptUdqGlKafVazCJHcso+1xccCN4Y=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=CVda8FBXrjLTWDgz1dGvwxdMRl1RcF8/TOzk/gFFFko4PIm/2uLJFBAPYrbWag4tikCWMNaTloZaYs0IiUUsMtNd90kaSoPen2RlGcg5ze+QV5fcX/d9eqyoX1ZB1er0zO7qqUgiwvEJiRenoQThrf7P1TehzcaKwODxDBIlZzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4X8FJQxr; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b6a8b32fa9so10173171eec.1
        for <linux-csky@vger.kernel.org>; Fri, 16 Jan 2026 21:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627776; x=1769232576; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4TCvh4Vl2F2EFt/f91KAA0cLNnhh1VtUSP6qDYdHXzE=;
        b=4X8FJQxrbBns0sfNzAJvxisb2QMVjihCq0Y9IV6ARbP3+Y3L2S9NeIoYbrlE10GUdG
         2pY8L8723Ih+Eg9H7cHUocrF3Sq8LNOzH11z+M700SN7p9h/oTpaxMQQcN47COvkF2HB
         OM8RRFQ87PFC1dW4beF4EY0/vmQeYrvif1Wf5TS3eK8uDwVaHP2BAeUByrZoE4bSBmHF
         eZTO7UUazxhTyZ13q7HGQ8YqBFdJ5WJm9vQiVETaE+DJu83ZhutT78Q4QvZEAq0PhPPW
         pIKLnvJ48OiwBpxbV9SDgFu3BEjrcOIeC4JarlqLMCl2l/goaOoRGc0rX41Ddmzuw0wN
         FH3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627776; x=1769232576;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4TCvh4Vl2F2EFt/f91KAA0cLNnhh1VtUSP6qDYdHXzE=;
        b=Sly3xXCsv4iQiwehJIpN2OfbH6aU1zfwHbOR3C11ULPl9+xAHxkQOZFy3BkKP3EBWd
         FWVUhWsczYih3LouXrLs6GebFd9LD7gErh7MVOmGDKq5rD8BURcHZdJDQdVclBk1VZt6
         V1303hK5mBnleuZrxuDzkYxWcnPvBTe+czTczHypXUZ29G2DJLDvVFklISFMat9C0K7U
         MjHqPp3+u5kNIGuYFRtO02mQ3gRLv2h7XkXoFEmAVlWT1gHMKmHuzx+cUlZR2wY7W+ym
         H2GPeQ5R/O+f8/MJuQw1dNRzUnSeWc67UqvrTmgHQYSDcEhNqKQClo+G9GZlMXOcwqu7
         VfhA==
X-Forwarded-Encrypted: i=1; AJvYcCVgVWUg7RR3cAMJIe70zbiCEI6q5btaHWaW10+7+EsKt9wP7QoTs9RQYVvbfD8zaLKNv3OpJty8exFm@vger.kernel.org
X-Gm-Message-State: AOJu0YyXi49UhqLPtQJoJipbgv03Txau/CWRLPQa+z9erlQaQXaR+VN9
	LVdldNlj4NmZava7xq5inwKQXtnqaukGvMVq/AwwK5NSFcSo3unGV0ViuTWnM1S2G9G25fWZ6XF
	edbvlOSP7WQ==
X-Received: from dybut9.prod.google.com ([2002:a05:7301:e0c9:b0:2b6:c085:52ca])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:50c:b0:2b0:4c56:be16
 with SMTP id 5a478bee46e88-2b6b41016d0mr4300841eec.29.1768627775839; Fri, 16
 Jan 2026 21:29:35 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:35 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-10-irogers@google.com>
Subject: [PATCH v1 09/23] perf dwarf-regs: Add util/dwarf-regs-arch for
 consistency with perf-regs
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

perf_regs.h has cross architecture functions for operating with the
differing perf register constants. dwarf-regs.h is similar but for
cross architecture dwarf notions of registers. For consistency move
the arch parts of dwarf-regs out of util and into its own directory.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/Build                                      | 4 +---
 tools/perf/util/dwarf-regs-arch/Build                      | 3 +++
 tools/perf/util/{ => dwarf-regs-arch}/dwarf-regs-csky.c    | 0
 tools/perf/util/{ => dwarf-regs-arch}/dwarf-regs-powerpc.c | 0
 tools/perf/util/{ => dwarf-regs-arch}/dwarf-regs-x86.c     | 0
 5 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 tools/perf/util/dwarf-regs-arch/Build
 rename tools/perf/util/{ => dwarf-regs-arch}/dwarf-regs-csky.c (100%)
 rename tools/perf/util/{ => dwarf-regs-arch}/dwarf-regs-powerpc.c (100%)
 rename tools/perf/util/{ => dwarf-regs-arch}/dwarf-regs-x86.c (100%)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 5efec73be474..3cb1edd263cf 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -219,9 +219,7 @@ endif
 perf-util-$(CONFIG_LIBDW) += probe-finder.o
 perf-util-$(CONFIG_LIBDW) += dwarf-aux.o
 perf-util-$(CONFIG_LIBDW) += dwarf-regs.o
-perf-util-$(CONFIG_LIBDW) += dwarf-regs-csky.o
-perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
-perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-arch/
 perf-util-$(CONFIG_LIBDW) += debuginfo.o
 perf-util-$(CONFIG_LIBDW) += annotate-data.o
 perf-util-$(CONFIG_LIBDW) += libdw.o
diff --git a/tools/perf/util/dwarf-regs-arch/Build b/tools/perf/util/dwarf-regs-arch/Build
new file mode 100644
index 000000000000..98bec0032606
--- /dev/null
+++ b/tools/perf/util/dwarf-regs-arch/Build
@@ -0,0 +1,3 @@
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-csky.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-powerpc.o
+perf-util-$(CONFIG_LIBDW) += dwarf-regs-x86.o
diff --git a/tools/perf/util/dwarf-regs-csky.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
similarity index 100%
rename from tools/perf/util/dwarf-regs-csky.c
rename to tools/perf/util/dwarf-regs-arch/dwarf-regs-csky.c
diff --git a/tools/perf/util/dwarf-regs-powerpc.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c
similarity index 100%
rename from tools/perf/util/dwarf-regs-powerpc.c
rename to tools/perf/util/dwarf-regs-arch/dwarf-regs-powerpc.c
diff --git a/tools/perf/util/dwarf-regs-x86.c b/tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
similarity index 100%
rename from tools/perf/util/dwarf-regs-x86.c
rename to tools/perf/util/dwarf-regs-arch/dwarf-regs-x86.c
-- 
2.52.0.457.g6b5491de43-goog


