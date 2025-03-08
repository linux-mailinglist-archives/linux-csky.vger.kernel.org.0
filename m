Return-Path: <linux-csky+bounces-1908-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C423FA576EF
	for <lists+linux-csky@lfdr.de>; Sat,  8 Mar 2025 01:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7D973A94B7
	for <lists+linux-csky@lfdr.de>; Sat,  8 Mar 2025 00:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F69171092;
	Sat,  8 Mar 2025 00:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q52g7LWy"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0D7165EFC
	for <linux-csky@vger.kernel.org>; Sat,  8 Mar 2025 00:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741393960; cv=none; b=HFdJHTYfT2IGSFid3kDKXmNGYaQ1oMToNZ/WRKUHuS8Sg6mwUthPSWYXkSdbBsyW4NaCx/OZvjWqK4v15NXfMu9o3cWxG36P8v6Ejqpt/kz+FjBBgDkALo0flxEFtvsEc6aRMala4+/EBRLVf3qSoR5GfiuWHMmYiVA1iw+iqGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741393960; c=relaxed/simple;
	bh=UEng1UvNcxBEzMZu5jvHA5kePc7WHOW16EAvxAQg2lE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ehjS71rVwMgLWZzPNEe2csf5IRvWdxpag87k3i10LmV6KFJlyv4LKTmcDhDgAUofh7y/DM0/krwjqnu7RF/hPbyfdTWUsT5x40IbSY41yjnJTNrd1vqewPe+J3eDlmRx9FF5w4VOeX39psS3vYKQzGDz90S2MfcM7w38Gezlq88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q52g7LWy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f2793679ebso29899017b3.0
        for <linux-csky@vger.kernel.org>; Fri, 07 Mar 2025 16:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741393957; x=1741998757; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBag0ZTpgw2jBnuqcdEe2ctv9zQnS+6XrNEn3QpM0IU=;
        b=q52g7LWymZwpca1B46+Kt4A1PN+cfwkinkRHiQlhwL5Y+RQxp1mcrl2CDQYC3iZ7OV
         +ioJ86pHyO3PRmfKtNWY13RhBbDfH31HpsObpwhStRfUyQRLUcTFBsCafcW5CHeNYJxg
         isImwELXy7Ck75nP+x4lTT2sJZsvHICxpJFXUdArocUslSh6WYFNKPH0yN3hFbM+98+B
         oTba4kqVY+qhx7WIfQTnCdtQm5N5gc/7M6PvBy65wdfjzzAw3E8btEhv/8Dm4vKCWp0n
         uTqgRhemXdOs9hpC6p74exmO+8FPEzUfYbTaT2x4467FAtYlNNAjGLWE49J8EGPg/pcC
         PG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741393957; x=1741998757;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBag0ZTpgw2jBnuqcdEe2ctv9zQnS+6XrNEn3QpM0IU=;
        b=HIMcD2w0gjZRZsV9aF6AT+J++otv2l0UAKa+R38GUKxG4raxljuuu2Qkzf3YJUUsy2
         fNT4AAVz3UHAZR7+TY22Is9ov7KoBqIxXjkvxPdE/HLlUKoa4xBO3vXXN1Gj1WU0vva3
         JGoMwuK4OcOA2g/f8U+yFEUZgSKw8/EQgIlpvtKyeklJAD4LxjryZIo83XcwPt84FZq/
         hfED26gMQTd2o1yQG1414K78U4er85Ea6eWd3Uig/sY8zD6JC5uUqjKrJbQynWJGvQHo
         WJ6cpM4PZPxt0j6yZXoIl+ufAoNF997CMOXzK2hZxywAv9ip6gCly01+ZX3/pJykkPo9
         hULA==
X-Forwarded-Encrypted: i=1; AJvYcCXz/20DYSEnN8HSoyTt6Q0hAzipa8GCGq8szpI3Aka0fNC7x1CtGbansql9wEQg4BMQfGLW79277Gz7@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/xfj6Zb6JnbduDKFzF8S/1NLavK6re+Ah31xH+y3ybHp+ArjT
	O5hGzEPXJMSq28uhlhG02tlMZhELeTa4JlxabFZDXTABlXWAGIgvp15Y18cA8SZiGE8lzsI2F4i
	zXhDsYw==
X-Google-Smtp-Source: AGHT+IGhJSVrXcuIauCCTdcdrck6v986JR4xLPN3EKMbWJDNglYuGen8NURA01YPhhzdv9BlJdEWKZRc9pFA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:1541:e490:aa80:5766])
 (user=irogers job=sendgmr) by 2002:a05:690c:2901:b0:6eb:ac7:b4bc with SMTP id
 00721157ae682-6febf2a661cmr5088337b3.2.1741393957696; Fri, 07 Mar 2025
 16:32:37 -0800 (PST)
Date: Fri,  7 Mar 2025 16:32:09 -0800
In-Reply-To: <20250308003209.234114-1-irogers@google.com>
Message-Id: <20250308003209.234114-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250308003209.234114-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v5 11/11] perf syscalltbl: Mask off ABI type for MIPS system calls
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

Arnd Bergmann described that MIPS system calls don't necessarily start
from 0 as an ABI prefix is applied:
https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.fastmail.com/
When decoding the "id" (aka system call number) for MIPS ignore values
greater-than 1000.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/syscalltbl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index db0d2b81aed1..ace66e69c1bc 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -46,6 +46,14 @@ const char *syscalltbl__name(int e_machine, int id)
 {
 	const struct syscalltbl *table = find_table(e_machine);
 
+	if (e_machine == EM_MIPS && id > 1000) {
+		/*
+		 * MIPS may encode the N32/64/O32 type in the high part of
+		 * syscall number. Mask this off if present. See the values of
+		 * __NR_N32_Linux, __NR_64_Linux, __NR_O32_Linux and __NR_Linux.
+		 */
+		id = id % 1000;
+	}
 	if (table && id >= 0 && id < table->num_to_name_len)
 		return table->num_to_name[id];
 	return NULL;
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


