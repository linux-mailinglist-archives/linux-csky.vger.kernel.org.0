Return-Path: <linux-csky+bounces-2706-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5F4D38C7D
	for <lists+linux-csky@lfdr.de>; Sat, 17 Jan 2026 06:29:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE34E30312FF
	for <lists+linux-csky@lfdr.de>; Sat, 17 Jan 2026 05:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1533A328B45;
	Sat, 17 Jan 2026 05:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H1bGZTB9"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51EC326920
	for <linux-csky@vger.kernel.org>; Sat, 17 Jan 2026 05:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768627763; cv=none; b=cgw8vcItWMdeAWgLMg5klE3nGXzxkq9z/YSypGiEAsBGYOsPKWzQlK2x+i52AfCb3a4MVcoYfiYFl3B6Qvz0JMHmB0yMzsSY0X6vfe3hqx+kO5nbQgGuKEAokDZJwJrSCUztM8cqCnwDvY9h8PrpmiOz5IRqfAhQ/lwAc8QsurQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768627763; c=relaxed/simple;
	bh=gbFw65gKDB9Q7CSGbuP34AO5oPVulM2chbHXMkIGkC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=bYwef2oYHkfA2poEtHLIp1GbHAOPEcYM8A7biw/YlG0UIEYmKrvu/oy5ukKKaoX2+Z+rkYgoSX3c7nZ+3GAAp+SDH/7T1ZDv6woBuyVaixqpihzmeCG6cIJLStBrG2FHbTvbUG1K+7yV+KQwWutbqMLClFA/kBnWxmx1JbuWr1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H1bGZTB9; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2b21d136010so4465041eec.1
        for <linux-csky@vger.kernel.org>; Fri, 16 Jan 2026 21:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768627761; x=1769232561; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7OS8+jcXChzbawXYGLy5k5VOyetH1gbj+eqgOcCR0OU=;
        b=H1bGZTB9/sYMy7T9/JjX2ZVtV5ZK1u2ryhz88RYKQUHOZRtrLax2Y9p87nXXaXHr9Q
         4p8mChrMEdd3RMgx+A80yNCgZtEmGM3Ss6TffX/ltIqUnLhXU3/FWI1daTRwIdQop/v2
         lQaw1Oge1f+2n/yAXFG4xep/0YB0IlqiaAOyZ3IJFqoIshZAf+OHbQG1FmKqUrhCtABD
         3es8irDPceXBV92FBnF3XWbc8hivatbsjzV2vqFOPh+ec8N4PJcKM1arMtU2I1sbCGDt
         p4bAbsdX0Bm3nFpWuUr+cb2LnhwmO+sfQgqyPKinzB43TujVWsq92IW/Kw6gdf3j4xOs
         nenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768627761; x=1769232561;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7OS8+jcXChzbawXYGLy5k5VOyetH1gbj+eqgOcCR0OU=;
        b=Nrjyd0FaS7KMy9dxIR0lxqJ6zfYs+P6ZwVy82zeEsZVbXLtwQ5X4UeqhNP5baGhirK
         mhhCuC2QR2Ht2qw0Ks/d6zuavEXEZW+D1ZdphMokYaDHa+euBMBhwteaF75QGxtFR9kG
         IFPLl8A8f0bzQLG6cYgyhIWwmqpmA9jCs9QvJ7+qHPFXpK/RHTlebJ4Ohu2S3du8R/2A
         OC97xThGS/Xhrqw1aYN+BFLG4UKRLfowvUCHbGA94Fnbfo+IbmbBifnI4nUS8aA1hu/S
         OYDtegAg4gsD112qj8lZjJXC4UD6G2VvKzvG2/WJBWVaG9G+xYFfimqX2sXC3GUj5eaK
         rWOw==
X-Forwarded-Encrypted: i=1; AJvYcCWlwu9ZSbhAlRhSU1ZC4lK3/H0shk9HD4aUU7H1KlbT5lnc2VXtf22r5eTeLU/LAxdcswOvH6LM2iwI@vger.kernel.org
X-Gm-Message-State: AOJu0YwGEPD2kHeeJZsZWvjfUL+CqoAZHVMPfdsX7dThTWLVowdSo/ZP
	AGDcwhT13YB4/WcIIvyKeP2VTCzs2DQzjRMcVxTyBrie7nVCFshGYLiMic292Xu8cberMyHkCbl
	fpxOdZyFySg==
X-Received: from dlbrh14.prod.google.com ([2002:a05:7022:f30e:b0:11a:44f1:daa3])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:dc04:b0:2ae:5b71:d226
 with SMTP id 5a478bee46e88-2b6b3ed9044mr3890490eec.3.1768627760880; Fri, 16
 Jan 2026 21:29:20 -0800 (PST)
Date: Fri, 16 Jan 2026 21:28:27 -0800
In-Reply-To: <20260117052849.2205545-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260117052849.2205545-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260117052849.2205545-2-irogers@google.com>
Subject: [PATCH v1 01/23] perf symbol-elf: Fix leak of ELF files with GNU debugdata
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

The processing of DSO_BINARY_TYPE__GNU_DEBUGDATA in symsrc__init
happens with an open ELF file but the error path only closes the
associate fd. Fix the goto so that the ELF file is also ended and
memory released.

Fixes: b10f74308e13 ("perf symbol: Support .gnu_debugdata for symbols")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/symbol-elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index b8fea12997a0..76912c62b6a0 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1173,7 +1173,7 @@ int symsrc__init(struct symsrc *ss, struct dso *dso, const char *name,
 		Elf *embedded = read_gnu_debugdata(dso, elf, name, &new_fd);
 
 		if (!embedded)
-			goto out_close;
+			goto out_elf_end;
 
 		elf_end(elf);
 		close(fd);
-- 
2.52.0.457.g6b5491de43-goog


