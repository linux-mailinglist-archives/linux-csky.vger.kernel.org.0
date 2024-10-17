Return-Path: <linux-csky+bounces-1123-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 891209A169E
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 02:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EF01F214B3
	for <lists+linux-csky@lfdr.de>; Thu, 17 Oct 2024 00:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2853379C0;
	Thu, 17 Oct 2024 00:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YTuZwr5l"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013742594
	for <linux-csky@vger.kernel.org>; Thu, 17 Oct 2024 00:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729124049; cv=none; b=cxTU7VZv6K/FSucS+NTofYE5YtVaaNyfLr3wo/7bvQjd5eLLIzckUKW5wm390TxKbubTg9vE93TrHnpLzQC3hBVOQmgtF/nUWR7lM+lQbot1FM6i5LlQVOH6H9qLh7cuQKbnoGSWjYWdBOLLf9PkhucEjYkZ2cRX7Evf8w9BHIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729124049; c=relaxed/simple;
	bh=EOP5l6y1kUpRzEu33igUG4tAL/TMJqk/jq6xRto8d7g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=EbDIkuqIpkD1W8ejM5TKIoxVJjTcBC4bowMHu66b9ACWhsszvIRUJlGrkMnaFhj8t998wAqcxMrYCb7lMr+LaMQxLmzSIBSa3ok8SuL2BafBVJhsbk/650HSrFQf33xOw0fW3mM+7apR91G2Kk+cIaXZQfoPNJsBPGXd6uGwoY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YTuZwr5l; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e28fea2adb6so499473276.3
        for <linux-csky@vger.kernel.org>; Wed, 16 Oct 2024 17:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729124046; x=1729728846; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Zgjnj0m5GCDK5RZDSEvmChYUUBqnb9Kjcf22Xw9GZo=;
        b=YTuZwr5ln2aetB1xztLNVhC6vLuiQXJ9CzX7ZpiUXM2LFAJzXsY+p9WRNIxV+HJLMt
         4nEhLFJXtmH8WXW66NuvdUBemQ1xlsM3NioMgLlW5ODeev6SFSm24+1+cBZtJrnDiUcp
         yfbJUC5pOhPBPP6Gb0/KVdlyxdnRAq5ey7A7S9Oqy58ffvHXli4PHhkSm5Kvbgbyv601
         kYtq1TzYWLLQJb8hTBG2Tw6qcNZqS0YtI4ua0xlH9jZz7FdCZmRjANBuiywLHGWrRrv0
         HcJ3VJN9Y3YWoNcVr+0YbYk8iwWClr4RMTeQ8nsovQeyCr1kD+DWIxjn/N8LuyPqekXw
         ZA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729124046; x=1729728846;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zgjnj0m5GCDK5RZDSEvmChYUUBqnb9Kjcf22Xw9GZo=;
        b=TtZr+nuacBPsONgEdtqnBQVyGRfmKtMR8A4GmojdnNceqg8WaMJqYdEbuJgZK1jfCM
         +FYofUGJEU5U7KqAJfWTEcbAQxDohCxLsqYpPP6UiA45m+f9BNCdf0cNlkStIYYl0NBF
         9oEWBbatPZ5ajBKsFBj3qKRTWu6oOrprb8hpHPOscZ7ZxwLMWC77TcCc7ovvS6WTtnQq
         O5try3P5ZFHta746Y1MORZjQLB0ANsoEylzP2eKjobzuF/LzENIOOGLtMaJpL+FkCpsk
         Bn1HoNT1uPf+XAUumTTDRc+SAKswQx7PmxYWK1xzEjoE8hRqDagIO88Kt4Sg8tBMql4D
         wN9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVCxrc4GncNLEk43daeCSvdp+Lx/I8z+Scuz26NAU3pvheFrnQgjSilanRZgDdB9qON610nPPPW+hKE@vger.kernel.org
X-Gm-Message-State: AOJu0YwWOqyrFvuIRWn3xWVTW0sKeK8ZGvOLzZ/KSpGeSNXD6aoSLEAa
	H2ka3AyvGJiIziSF0LK4UkaIKMoT1LT2nfXIfqE2MP1SMPkp4N6PKrh6rYhF6rlk5SfU336uMm3
	9+wdSEg==
X-Google-Smtp-Source: AGHT+IG4yOEShi7bfA//zRBXm0HyxwcMrNGTLY2U0O7sKDY8krpaQf7LbxB/HvXewatFXm/5ipRsL7HiuJQ8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:a00a:f237:9bc0:79c])
 (user=irogers job=sendgmr) by 2002:a05:6902:2d08:b0:e1d:912e:9350 with SMTP
 id 3f1490d57ef6-e2978559a74mr9642276.6.1729124045785; Wed, 16 Oct 2024
 17:14:05 -0700 (PDT)
Date: Wed, 16 Oct 2024 17:13:44 -0700
In-Reply-To: <20241017001354.56973-1-irogers@google.com>
Message-Id: <20241017001354.56973-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241017001354.56973-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH v3 01/11] perf build: Fix LIBDW_DIR
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

Testing with a LIBDW_DIR showed that in Makefile.config the dwarf
feature tests need the LIBDW_DIR setting in the CFLAGS/LDFLAGS.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4ddb27a48eed..c1c7c25887a7 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -162,8 +162,14 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
   # Must put -ldl after -lebl for dependency
   DWARFLIBS += -ldl
 endif
+FEATURE_CHECK_CFLAGS-dwarf := $(LIBDW_CFLAGS)
+FEATURE_CHECK_LDFLAGS-dwarf := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 FEATURE_CHECK_CFLAGS-libdw-dwarf-unwind := $(LIBDW_CFLAGS)
 FEATURE_CHECK_LDFLAGS-libdw-dwarf-unwind := $(LIBDW_LDFLAGS) $(DWARFLIBS)
+FEATURE_CHECK_CFLAGS-dwarf_getlocations := $(LIBDW_CFLAGS)
+FEATURE_CHECK_LDFLAGS-dwarf_getlocations := $(LIBDW_LDFLAGS) $(DWARFLIBS)
+FEATURE_CHECK_CFLAGS-dwarf_getcfi := $(LIBDW_CFLAGS)
+FEATURE_CHECK_LDFLAGS-dwarf_getcfi := $(LIBDW_LDFLAGS) $(DWARFLIBS)
 
 # for linking with debug library, run like:
 # make DEBUG=1 LIBBABELTRACE_DIR=/opt/libbabeltrace/
-- 
2.47.0.105.g07ac214952-goog


