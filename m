Return-Path: <linux-csky+bounces-1857-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1038A4D2BB
	for <lists+linux-csky@lfdr.de>; Tue,  4 Mar 2025 06:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0FE83ADDA7
	for <lists+linux-csky@lfdr.de>; Tue,  4 Mar 2025 05:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8893C1F4706;
	Tue,  4 Mar 2025 05:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+Xtz0A+"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E041F4276
	for <linux-csky@vger.kernel.org>; Tue,  4 Mar 2025 05:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741064665; cv=none; b=AEuWR+ADR+BdcniFa8D39Y3I1jfZvHkIZlq8nBtkXR8BE/3a3/dda1SyFocQPCgVwMc7o8x1UBl+9cJpWXQEfifiXxcpBKvzOHGTUaM/DlP3ReiMiyvarFcVB0VwvE9VG5bC1fDq+L3K0yIkV5Hsv81hf6+SfkO53qs2eKKOnUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741064665; c=relaxed/simple;
	bh=KrPBT2BP1FIt1HzmJhzqOiRjmGa314IsSEmR7HsAVPw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=QoRxP1vOdI5ZbsBLuQtVVzpcJBHUR7Plr40YO2gg40cV6evNYmvZR0PYUxBfpVs14bFFwti2TP3S7NZ5sfK/7g3tbkXwPvSr72V5ehsP1pIk9YRfQ+CVKwBnadBv+sa7ZRrJ2Y9hROoVjKzKX2CPPqqb22cRjZNWI+8Mj0j23aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+Xtz0A+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e60a3bf26a8so6647933276.1
        for <linux-csky@vger.kernel.org>; Mon, 03 Mar 2025 21:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741064662; x=1741669462; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DvRfiETt9/vf5K0lL/pnBeyo0XjXyN5OT4Sb89ZDY2A=;
        b=G+Xtz0A+f2Q0anmeUeFbxp3jUm4cKmlgXxBMV6gRKJUQlpo8fE7wBCmkZVum00NL0x
         WDxWCzMgOu9fXNee1xKK/AqkQNfz88y1SlUX6anYkGnjoAaxjRNTx3PLSEYyYhlt0uPg
         3hlxGotLI3535bUatV1IUQh4E53k4R/y//KM4i3rWNrq1UvRWV4ge4OyXqVYCu6Me5bQ
         B+AkYoWmG7KU6EHTWh9k6TfyoFmF6MdlY4ZFoNz1oTviP5oF1H6/gZS33JaV4dmpObZc
         zR0qtBH/9vRp3KTui23MYHLtlOWEYsFUltD3yRG1q9aFPu+PAQoiJCJqohcSNVEef3tQ
         b5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741064662; x=1741669462;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DvRfiETt9/vf5K0lL/pnBeyo0XjXyN5OT4Sb89ZDY2A=;
        b=IhTbBsxo9tuDcMbzjW1/hVguHtG4Zl1+O3xYvlNfgVVv/lzMikOqsf7f/IWro9w6Rb
         jTLcBx8plaBge/nbMV8Jw4fUygGKtETi/qBj80IHeKCsSQWfgtmLOOQSucoy/zdFlfq7
         WwTSr9r5hbfIpUoJC1l/js/RcSjcaqtncq5KqgQ9Wns2dnOPssQBPGc4zK6XFcDnVLwt
         gddXrLRajxOsOws+leSRD4RmZ72CwRpHjjbgd+EQ6FBlQ6F8o/S/Xez979mlr/7Qefl7
         FJ+v2oA0EajMazXi6dH+E8JER/WfZpbISoZqPzXUrEuoQRUDAJi1OZF2Ju+uLfGPcIHr
         uWhg==
X-Forwarded-Encrypted: i=1; AJvYcCWcRq50gsyTilfvsTZJPmAYy3yrd2qSMTVeh8bvolGGKP9F/FbP9i2HcJ4GGtYsKfcwLtztnWbiH6MA@vger.kernel.org
X-Gm-Message-State: AOJu0YyHRsXLySpM9XjeTllZwBMVyiBLycB0p5h0Fv+9IYd7oqs/UE0R
	LpF+7laaJif9/oub4KuMAsuAosmqnmc063ItWGXil+EUewh9eUv59kaiQbwtXeCKGEmpyfJcRrx
	TiklYqQ==
X-Google-Smtp-Source: AGHT+IGBQB6dZZ9Csl0mZ1y8IMIjXPBoV0Vt7a8kIB2h5g+5h/WV1kubj5dpIBkqnpDzwoAkqybaXtIaN5v8
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8af9:d1f7:bca9:da2])
 (user=irogers job=sendgmr) by 2002:a25:7104:0:b0:e5e:1496:7371 with SMTP id
 3f1490d57ef6-e610c1e48d9mr214030276.0.1741064661618; Mon, 03 Mar 2025
 21:04:21 -0800 (PST)
Date: Mon,  3 Mar 2025 21:02:55 -0800
In-Reply-To: <20250304050305.901167-1-irogers@google.com>
Message-Id: <20250304050305.901167-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304050305.901167-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v4 01/11] perf dso: Move libunwind dso_data variables into ifdef
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

The variables elf_base_addr, debug_frame_offset, eh_frame_hdr_addr and
eh_frame_hdr_offset are only accessed in unwind-libunwind-local.c
which is conditionally built on having libunwind support. Make the
variables conditional on libunwind support too.

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
2.48.1.711.g2feabab25a-goog


