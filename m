Return-Path: <linux-csky+bounces-1805-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E331A3C82E
	for <lists+linux-csky@lfdr.de>; Wed, 19 Feb 2025 20:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63D2F188C990
	for <lists+linux-csky@lfdr.de>; Wed, 19 Feb 2025 18:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F32217F54;
	Wed, 19 Feb 2025 18:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DFLC7nez"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80AF217701
	for <linux-csky@vger.kernel.org>; Wed, 19 Feb 2025 18:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739991450; cv=none; b=HOET35NSzhpySwrHK2RLHlKm8C1NjEOPNjSPMtlk2ySD3szQhK7V4pbwFsLAcePf246gu9BbPV7zveUQoOyDaPjIH8CcXt3TlzV0rOzgziJU/SPClqqyRHuKqs4GOcStEMHyzUvo4r357N9aw2rNLpwYzknUDcFSo+PrrIOj4TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739991450; c=relaxed/simple;
	bh=ly9ScmKJMVA6q31ptFJQo64X6QGUOGrxOWC9a86NvwQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=gcf7azL3qgRjFckDQ7K2xYXPC2Ag7ZRA/MpMd0MRkwbEixaww0c7U98tOV9MGlmnAvOXtbckPY9fdp47vuerNJPVpmswWuxxlxPTdkAx64FwU61ZNmcWno+cvE2svZ68RygR40G+HVMLMJX4m42rE5phTojZuaLnVNJh1pLqz98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DFLC7nez; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fb467ed948so707717b3.1
        for <linux-csky@vger.kernel.org>; Wed, 19 Feb 2025 10:57:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739991447; x=1740596247; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XIzMGizCa0TqJAjUgJqlPFZGjy2pOOpFJSWoUD2uhWM=;
        b=DFLC7nezGn3GhKf2LE07CrPcbk/Qa4uZRlXc/n8BPlTjTU29o4qEzeQhbDiIdARZ1q
         67+BYUmsWl+OTs1k+GP8N5h4FYmYr67xiPJPd8kWiybPwun8aJVmWPu2cPB8eZ7xQ7ur
         gWsFkD6d/HZCbup1AeLSXOi5zBuvXWUJnBp2edyW5Xr3kwnTHG0G800xPts8yCJ1RKj6
         gKfKXaFnXspTNV6bgHyGx8w3epIFcFylmu+SmyyBNt2e8HLBUkJOA6hVfMDmFYsgKA6e
         7OaXoFroUWGtRGI/fYceCxKDuaoASj6WOUiCMdokfDER3kp2EtatIN4lzdwOrTes7wI9
         6niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739991447; x=1740596247;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XIzMGizCa0TqJAjUgJqlPFZGjy2pOOpFJSWoUD2uhWM=;
        b=jC8f3MkLm22A7l6T6L/JV2HqPOsmt0cTC9xZe4T4I1fUjUVELIGE7N0vpXL1fPuf0F
         cclACa0sVEkE0ndFoDVL0uo0suFUMCnlaRebD+FP/xpaXLW2t7KeRvm7skt+faVeYlqh
         j11PP3t8IuwPbUJSiDYaDYOzfFMPezqR9WMkxvSWb5kc7jWuMNKoWr+y2zV1bVo1ftXF
         5YuGpsLurIV0SfEIN2yk87e4PMnNRL7hzY7N9ex8Uh6zuKM9SeWSqSY1VzULJEuhCoAS
         +Z61I0YDPFLn3HCiaJvndmibmaSpsOSstJg13nywr5rWssUXQoiWhgS6Kf9rvRKPcFLn
         1Hgg==
X-Forwarded-Encrypted: i=1; AJvYcCUlD5HJoLMx97zZRN8y/IiXaAXVy6OyiTuizfxDTrPg71+LJz8GPkaqbhVfgwkIxFMhsgXpaMh12KF+@vger.kernel.org
X-Gm-Message-State: AOJu0YzixRrIux/Q7WuC2L1pw5G1Np7MzZQUS9f2/6t42QCoB1cnT3BV
	Iok+sdt1NvO5ow8fAAf9VEcDtCWosh0uUwd5OW3JZ7TUH0iRsDJdcVKAy80lXhPrQQX73MVLbYp
	A7zZa6g==
X-Google-Smtp-Source: AGHT+IHBIqCbWM4vcI984nDuEzZSczl9Bby3fcXaZ7gK0bV5Lnp/HxnIbC0vqnoo+ZtzSlf5EYQ7UBrYNZ0b
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:c57b:86f0:c166:3061])
 (user=irogers job=sendgmr) by 2002:a05:690c:2f81:b0:6ea:ecc3:ec61 with SMTP
 id 00721157ae682-6fb582571c3mr2102467b3.1.1739991447284; Wed, 19 Feb 2025
 10:57:27 -0800 (PST)
Date: Wed, 19 Feb 2025 10:56:57 -0800
In-Reply-To: <20250219185657.280286-1-irogers@google.com>
Message-Id: <20250219185657.280286-9-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250219185657.280286-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.601.g30ceb7b040-goog
Subject: [PATCH v3 8/8] perf syscalltbl: Mask off ABI type for MIPS system calls
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
	linux-mips@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
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
2.48.1.601.g30ceb7b040-goog


