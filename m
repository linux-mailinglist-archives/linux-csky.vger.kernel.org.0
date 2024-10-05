Return-Path: <linux-csky+bounces-937-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAA8991A29
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 21:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 347F5B21B44
	for <lists+linux-csky@lfdr.de>; Sat,  5 Oct 2024 19:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E607161914;
	Sat,  5 Oct 2024 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L+TZhidI"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BFE16087B
	for <linux-csky@vger.kernel.org>; Sat,  5 Oct 2024 19:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728158163; cv=none; b=RCdX3oXk/PJMk2/kpbIJgEgWNq51DRefwl5wGTt/J2lxBnxG4EjnIJiOoeEgN9NT8TDKARzbJBV38H620MfCee9zKjquZ6UllhFleXrLLONWO1Czd6h5g9KTFEati+Xg1jdLcOCed1RMPSttSUty/fZquTfOqaz2DDpvD2E4xaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728158163; c=relaxed/simple;
	bh=Nd6RHayxE7oTIZe/nTOAsaRSjloYkVrh9oX/tOULgio=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=SAboxHXIFkRUgsWEHGMvNxxU4iKmXU6v7VOUsiacbuE8LAmUlCkBZodtrTs2gA7XO6dJWhy+Gj7n/kSKfu+XxqAa4OU/qOVuxnjCgHsL1tL3RT5jpApiN1snyLucTEQ4Ny970f3U28ul6O/pTpr+LIKx/H2nPy2CbC+0DFC3blU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L+TZhidI; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e25cfee6581so5568450276.2
        for <linux-csky@vger.kernel.org>; Sat, 05 Oct 2024 12:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728158161; x=1728762961; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=51NaLIW8tkOJtUxwqHcUszT78OCapOaZVU3wITST3Jk=;
        b=L+TZhidI+7fp5JoVCb2OtHADuQmMsDZEwYQCbr/Dnm/DHaXZyhAMncg3aRkbAxhfcf
         TqnQe/ycWd5aSxJAwLjfke8kEL5q8CLMLhT+Ejwt/5wQ8aiE6Ow9Xb5f2Uf7XfNvkDcQ
         AnTfUyudKerR9UGGaH4zwYZev2wzPb2TIGww1xDCeb7OXLyXp4N4oMLcPWuRjazwp3Zi
         VocjJ3SOoO0nnR1nwhdaTkNzWVtSBhijB/B10V2RP5eEyc0ofllBnxvIOkEDCmKSJsVu
         eKMzd9+kqYxkw9GBn/g7o9dAK9agWfbtNuWTKtjbirUMR/nWAtbeTIQHXKbmCFhyW+Ru
         1nhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728158161; x=1728762961;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=51NaLIW8tkOJtUxwqHcUszT78OCapOaZVU3wITST3Jk=;
        b=CjTLUfOK2rwTuGztS+We1n9B/xLJkXkq9pOVM3sURW36dvwGn9z0q2Bdicyae7dLnX
         fthJutNryxmo94L5n/2CW/c21EFziMLBpi1b43YNbuafWni393SedZJ3VX5d2QxFbVuf
         borcYO60WPjiLpe/WL844mFbREyG1Af45+yeI/KFKNj9PLH4qeQhDSB7Xis/sPd0EsNG
         22fBY1a/45xxiIDRE8cAqXheNcMs4Xx8Lg6PwzXWhqVa0gQXfSl504W5hZxOmLlgFTPb
         VgQCXwDAsPJy9AinSMALPFSGgEOQxTEEagTFswbM8m/q59aYP53p7tMG3pPZuaoNaK7Z
         +pnA==
X-Forwarded-Encrypted: i=1; AJvYcCUG0XEpqaD7VNmVaVJpj4Fwq7HBh1XM2xVc1+5hTVIY/TknGmW+A79AUvf06chXjGP23gFgLK0TCRYb@vger.kernel.org
X-Gm-Message-State: AOJu0YxB3Azdtv+rM0SCN3BTOQUfypfRo6Dlz9Uw5AaKtr7Jewyqy6pA
	wlw0em1sdAvun9R7hQz78fM8ph3gi/X4azIVafUJRiJyGrcU1eQqe+8+xQsqR/xDNNqAiFJbidS
	5MMur1Q==
X-Google-Smtp-Source: AGHT+IFpB52T3N6GTujE7GYOdQ2rq5N60dCtmqvE7W4eZxrgo/OkvusaceR/GdwO/vSP+j8IGglTUnlNtHZl
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4c2:5b4d:8797:7249])
 (user=irogers job=sendgmr) by 2002:a25:ce0b:0:b0:e25:c8fc:b78c with SMTP id
 3f1490d57ef6-e289393997bmr4258276.9.1728158160211; Sat, 05 Oct 2024 12:56:00
 -0700 (PDT)
Date: Sat,  5 Oct 2024 12:55:11 -0700
In-Reply-To: <20241005195541.380070-1-irogers@google.com>
Message-Id: <20241005195541.380070-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241005195541.380070-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Subject: [PATCH v2 01/31] perf build: Fix !HAVE_DWARF_GETLOCATIONS_SUPPORT
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

Testing with a LIBDW_DIR showed some issues. In dwarf-aux.h if
HAVE_DWARF_GETLOCATIONS_SUPPORT isn't defined then the code uses an
undefined errno value, so add errno.h.
In Makefile.config the dwarf feature tests need the LIBDW_DIR setting
in the CFLAGS/LDFLAGS.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.config  | 6 ++++++
 tools/perf/util/dwarf-aux.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 4dcf7a0fd235..5e26d3a91b36 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -159,8 +159,14 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
     DWARFLIBS += -lebl
   endif
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
diff --git a/tools/perf/util/dwarf-aux.h b/tools/perf/util/dwarf-aux.h
index 336a3a183a78..925a9bb9fb15 100644
--- a/tools/perf/util/dwarf-aux.h
+++ b/tools/perf/util/dwarf-aux.h
@@ -177,6 +177,7 @@ void die_collect_vars(Dwarf_Die *sc_die, struct die_var_type **var_types);
 void die_collect_global_vars(Dwarf_Die *cu_die, struct die_var_type **var_types);
 
 #else /*  HAVE_DWARF_GETLOCATIONS_SUPPORT */
+#include <errno.h>
 
 static inline int die_get_var_range(Dwarf_Die *sp_die __maybe_unused,
 				    Dwarf_Die *vr_die __maybe_unused,
-- 
2.47.0.rc0.187.ge670bccf7e-goog


