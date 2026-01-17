Return-Path: <linux-csky+bounces-2711-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED524D38C86
	for <lists+linux-csky@lfdr.de>; Sat, 17 Jan 2026 06:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A34CE30319F9
	for <lists+linux-csky@lfdr.de>; Sat, 17 Jan 2026 05:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF49329373;
	Sat, 17 Jan 2026 05:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1dgbXtye"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE8B32A3C5
	for <linux-csky@vger.kernel.org>; Sat, 17 Jan 2026 05:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627772; cv=none; b=YOGOOcOWe7vP9vTuivfFJHPe/afsFjzQy8JsvT5cTmzXsR24SNujPBeQBTsPxqxUP9M0T1GMSp1/EfVwDWUZfEvyO290reUVbRez3SsMlRFcUfG1G3goag+jUF6M0M3PLmXJtuv/0F21JV5JoYBqmY6/sUYp16XclAy5uuDl4zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627772; c=relaxed/simple;
	bh=EoPQ7WynTCg6GroJnz0Pg1g63qxtVub92bvS+5rAy78=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=a3dkWLOyngqQB1JUxnWYOdvdGtXhReYTKmnp9T79worPY5MEBKDAo8ULr0o70T3nH0SirBcTP/Xe8Qzpcu3AEltql03l+QFKz0U0h5h9++nRR3mzn9WxoABwrw2oPTlVrWRPnmjDA1WG11wnAzEpRN1vyWe9F6aujmvd8Fq0/J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1dgbXtye; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-123377038f9so1362828c88.0
        for <linux-csky@vger.kernel.org>; Fri, 16 Jan 2026 21:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627770; x=1769232570; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vqg+qXSoRLfoai7ZDLIZjszxPa5Zftw8iNvGyqINItg=;
        b=1dgbXtyeCh+P8pJeSq6juxC3XBAKygWW3t89wAYzoRifBoj1ANZul8nLmoFx00TC0r
         chMUnsQ8idwNDDw5WxEq+IDNDEyaZG5okG+7c+O++UZVJFW50OT1HTb9HF2KjDXaXtEV
         vS9Jn7/rRP/KqxeVRwWsw0USUBJELMqiw4qc98BPLAnX5GxQ2PGXWq9W7POdY/iU/Pcr
         SLG+v6uq+J3l4+9LRM3VqP5P48Su0MjraBRpz9oxFZTjbUMlJVquPiRr9R0Q/0GmxoA0
         pVM6mA3b5iUikKGcU9AqLslQFmhcqezmsaooWHxGW3gD2Itsf2sG2MstzYqX6/OAmMUn
         Abag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627770; x=1769232570;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vqg+qXSoRLfoai7ZDLIZjszxPa5Zftw8iNvGyqINItg=;
        b=X0fSZCKhWIi9d8xgZW+e6POoF0nmnieuVyXa6mgRQON0ER5MqGPW/VkowCsmKt8Pba
         GppaUa3e0smORbEaVRRgLhCt4yjLvrZU48+27RdQ1+BMhehcNc/TJ6EUuUY+5Zy7G0n+
         OE4vLbq48mgq4kpAhVZnbYkJcY2J3+SN8i/XcSN6VO4/2fcxo5q9l+yBuQww15bTd0tR
         nlUMwoM2WAu/phnjMETJ1dJBvDvn68qt5wbYQXguPeKomteMpTt2Hx5aUIYrMZzukHno
         lrE18xUC1/ALHmH7TTXFAUt/kjEUnNolwrMTzeI617lFd0YGAenY7ReTyNBxQDHIPFCS
         yWaA==
X-Forwarded-Encrypted: i=1; AJvYcCU7y//Xftxk3L4At8g6eVfCU4morHhVhMNqDKIDayvBFMsdHNuUL0BYtRq7LlIsFh74KwzHX2CGRU8/@vger.kernel.org
X-Gm-Message-State: AOJu0YyTaqYjEA/COsRbn1kVVq4+wGq5eK/Gh3kUJhGfd9ZpzpmS4LHF
	inz0BS0Ac2EtXgi+tupUsmLWUhS4U15Dn+muVfgno7t02Cu1sQgz8N22yTl9n7Cr1+t8BArqEOv
	KEd+6UWIY9g==
X-Received: from dlbui3.prod.google.com ([2002:a05:7022:3d03:b0:11d:cfca:1df5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:438b:b0:11b:9386:7ecf
 with SMTP id a92af1059eb24-1244a75c5c6mr4763418c88.44.1768627770088; Fri, 16
 Jan 2026 21:29:30 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:32 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-7-irogers@google.com>
Subject: [PATCH v1 06/23] perf unwind-libdw: Correct argument to dwfl_attach_state
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

Argument is a pointer but EM_NONE (0) was being passed. Correct by
passing NULL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/unwind-libdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index b2e194a8be39..dc882f17f52d 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -339,7 +339,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *arg,
 	if (!callbacks)
 		goto out;
 
-	err = !dwfl_attach_state(ui->dwfl, EM_NONE, thread__tid(thread), callbacks, ui);
+	err = !dwfl_attach_state(ui->dwfl, /*elf=*/NULL, thread__tid(thread), callbacks, ui);
 	if (err)
 		goto out;
 
-- 
2.52.0.457.g6b5491de43-goog


