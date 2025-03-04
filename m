Return-Path: <linux-csky+bounces-1867-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F01A4A4D2CF
	for <lists+linux-csky@lfdr.de>; Tue,  4 Mar 2025 06:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E4A170695
	for <lists+linux-csky@lfdr.de>; Tue,  4 Mar 2025 05:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4021F8BC9;
	Tue,  4 Mar 2025 05:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0RL2eoUX"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF69E1F891C
	for <linux-csky@vger.kernel.org>; Tue,  4 Mar 2025 05:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741064691; cv=none; b=SJVeXM8TkJ/twl6kKu9CRfVsuForvk46rZtVzcxp8vzeQQkqAwwlQJXDczCTizj6Ev5tvT2IRo9YKrAK6F61KHYW7HzmV/sebqZowIHXbkgqYOubnkNdHGi4meYx/Qk6maHQ5f59ecSh3c1wGY/s98iCbEmJ4h/GXCR8cfhL33I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741064691; c=relaxed/simple;
	bh=nhCPtbgEZDkd1Kvn3UPUrTlm5xI1UpW+IfGhCPsfYms=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=bYMRvioE5xqua6xaKSWupgstEurh29YISidx2i/xFpAVIWqdBNrcE8b5qOpJpJn8foGoOiOi28a8t5bFrq7JO7Pk/1sljcG/T1tumMyQfr8VbydhyK1EnZDYRHUDFqP1oLNc1/3q6LgXzSvodVgJg7n4AS7gW76cLOSN1S89t6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0RL2eoUX; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fd3503faf8so71898667b3.3
        for <linux-csky@vger.kernel.org>; Mon, 03 Mar 2025 21:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741064688; x=1741669488; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tzAqyNBDcatrD/dNYr5THRvvcwinanMOXL+SW4MgEks=;
        b=0RL2eoUX7RIfqZXCSjM5SQhU/z4TknpBx6tfJnMTpIjku5f9aHfQIGDExbZKHZSzQH
         zuNtG8qkuxoM+tLl+A5zLimPhqq74v4XiBT9AFpPR//UQkAnMcUL3W8x6FkJkVZWUYez
         rJu1rucnNPFRjJPZ6nc8XaINgE7XOCp0abzB0wNYqG47Rs03cNW34m9TzjXbmlze1cSv
         EysktXmM3R3eALOHxbj5WkaEBpsGKfK+IO+Tv+WZ0cjR+ZdFszFHxgnsNIlZNiJVr3Up
         qHRo7bMI4+xCFSZKIcGX0qgOKdBvIwrXSm5Dvynm19ifKhLjGYtBBcn81kh6upR/Ey7e
         976Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741064688; x=1741669488;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tzAqyNBDcatrD/dNYr5THRvvcwinanMOXL+SW4MgEks=;
        b=M7TdWiWyzy3JmemeSm2nmwmqbfasX31fEry14NSqJTkZPtlKkr4fKn80EjhDao/Mk4
         Hswtn1pVt0nDphfno7PtSIaqGAQDxVPm9RrU7Zj0KryUpJmOmiytDcXth+c2iNZJeN+c
         2WAKLpFenD/ujcf4B+/uUx7QeQZL9JnIfHJpFt3NQKXUc1SfELmk72CvBNuVDXvS5vPR
         aXdidfmEjkbgFs+157yOZH7I7mmL2WIFJzkgSqBkkFfNyEIgCPRFV1cWOJ99Zscv+cNw
         EURQvAj3qfuIc8dlgzRuLgVeXKLeo3p6+7oBC7pPLxoElPNYCqYkCj1HyW4O3CUuz8Xs
         MLHg==
X-Forwarded-Encrypted: i=1; AJvYcCU/5ljJKB6CvfQkpjjX8ZHS7DiSaE/VLx+ibpOoAbJkQnEcjsv0ejqjBYg0UadPG2Hwu/JkEyxxAU//@vger.kernel.org
X-Gm-Message-State: AOJu0YyT7G8xEfgIUhdvv8J6OLOWwi8f69A6ELW3RlRrlAKEjwjLqtLk
	uXt+OtR6SlombSFCPFQj4b5dvjtvVretWFoRJSO5sQwVT+zyRQ2rLcwZNc25PibRaTUIM/tYBuX
	t/v+X4Q==
X-Google-Smtp-Source: AGHT+IGcXI4xtcRg7TZCt539wnaKT0i5MXbKrcmjSAdt+8/cOoexhcuHk6pVgzO15AtSpOO1xbrgGJNcQRci
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8af9:d1f7:bca9:da2])
 (user=irogers job=sendgmr) by 2002:a05:690c:2a81:b0:6f9:ad6e:5945 with SMTP
 id 00721157ae682-6fd49e2336dmr19606227b3.0.1741064687649; Mon, 03 Mar 2025
 21:04:47 -0800 (PST)
Date: Mon,  3 Mar 2025 21:03:05 -0800
In-Reply-To: <20250304050305.901167-1-irogers@google.com>
Message-Id: <20250304050305.901167-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304050305.901167-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v4 11/11] perf syscalltbl: Mask off ABI type for MIPS system calls
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
2.48.1.711.g2feabab25a-goog


