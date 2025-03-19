Return-Path: <linux-csky+bounces-2001-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D323EA6847B
	for <lists+linux-csky@lfdr.de>; Wed, 19 Mar 2025 06:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F3A8421623
	for <lists+linux-csky@lfdr.de>; Wed, 19 Mar 2025 05:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5714C24F599;
	Wed, 19 Mar 2025 05:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0SeleJNv"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD625178A
	for <linux-csky@vger.kernel.org>; Wed, 19 Mar 2025 05:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742360894; cv=none; b=bZHymSY48oRrFkJyM8vpnEidnyBCXO1TH+s3zvQ0GURFDyyJNyydYEpBmp9Sm8YoQxgmFUck5Ym3gbiLsnDCvWsL5atKurlCfS+j39zHY/DPAAOZ8BjwpNrvaW9n4CIuMZsO/YtjHt3fp+XnzC5AZzVVJJiVgoto1hmsG98pvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742360894; c=relaxed/simple;
	bh=3uu7CB6A8C3yWHCi12pQmud6FUTrY1STEruRjCdoigM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qA3eghNMNE47qj7hGb6hu2she/+sTqSb3TxbiaICtJIKLpTGpCCbSEkvlBa56Z0bkk1f2WMCntGzAXYAPa6t/MIrhw1YSACvEhRXq3gHoJGacMy/hzJy1jsT58vgV5weSf/M8CRXnPz6co+N7VyxJjkTuLljSwyzOplB5YcEO6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0SeleJNv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fed889e353so102181067b3.3
        for <linux-csky@vger.kernel.org>; Tue, 18 Mar 2025 22:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742360891; x=1742965691; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ncdSM+lbXMb9xe65qVg6II6RWpGKh15ceN/q8SVr8Hw=;
        b=0SeleJNvxxWnXXSrOY/Xgfr6Zax5pF4XwRqQRai5S1/gVjgztBe1yxwoB0q2d6Ef00
         pedwSaPGfjf18aydB51XZQ7zxDgfOGXSC7L++reIRvqm75+9oqrylEcdZ3Pr+8AH8dTR
         MzgD9o/IkscTFHUCjGiTLmKYBjaNrlSVmV2hkmhvNfAV57Sifmy2Zjt2KdtpApMyogl6
         ogaHKTPiVsaJidy7hHRB6e6pYSRp5+5gVJ2bugvtJpgiQNdUnPN32OZQtRfC/HMESj5B
         e/uETKpygwoC2osce+jkhe5NiHJJhymcDVDXkcQ/j6WdALh7pBWf7QYD+mAOI7PyvY0K
         HtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742360891; x=1742965691;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncdSM+lbXMb9xe65qVg6II6RWpGKh15ceN/q8SVr8Hw=;
        b=kdxLKrw8pj9QVRT25CHuT2oz5fOlrDs+Cp5WIsH85ti6BR+2N1CQPMB2k1w+U1Eq/Y
         RYTbKuxSEkwWEcnWwQXqkh0sO0YITdOG/wSfsBcUoWzBlQrTqz+e/56MU6u4mpQvicb5
         8WXrypBg8ptd53A38IYEVj1zLyJQ92XUeisDb0uFqOd5TchZ3zXWUWfEyPVFY1wTDXUX
         4iMkJUSVGMUJYNNxm4AZZNH/xO8wpIhDS2UiYd0ilUamODV1AUMD8xKTh49OyJGHBYlz
         4wiL4wqngMOk8NGT6ldmyO7k69yzJKDgEN7SMJK4nDmOMMLkli4GMjb4/LTxfpOKu0ts
         WRoQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5NSnFRYehkoobalwifzVr63MbVnNkeZjDvVzGN3tUzdD0f4ZnjcAOLH3qQpRItIxjU4QyuBb3vsvI@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa6UB3gMZpeoeLfrYnQkpvDd6sT3Np6AMyyfurREVnc9sBMyQK
	wLG0uzXvtptSQZCUQzZrPkz+Pie7wHeqK5ByPq0Pl9gGhLlMLvNAn4E+plAEYxlYklhciLPpY7c
	h7v7tDA==
X-Google-Smtp-Source: AGHT+IE7t62G3L9y/1w7Zr4bPbVHFfW94O8jbx7xn/oloQNZ3Xii0SOFszp47Hze8CWLQYL2UBnV/ggmaf2X
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8a11:10b5:af90:6031])
 (user=irogers job=sendgmr) by 2002:a05:690c:6501:b0:6ff:1fac:c4fd with SMTP
 id 00721157ae682-7009bf39905mr12697b3.2.1742360891193; Tue, 18 Mar 2025
 22:08:11 -0700 (PDT)
Date: Tue, 18 Mar 2025 22:07:38 -0700
In-Reply-To: <20250319050741.269828-1-irogers@google.com>
Message-Id: <20250319050741.269828-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319050741.269828-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v7 11/14] perf syscalltbl: Mask off ABI type for MIPS system calls
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
index 4e6018e2e0b3..67a8ec10e9e4 100644
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
2.49.0.rc1.451.g8f38331e32-goog


