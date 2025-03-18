Return-Path: <linux-csky+bounces-1985-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070BA6676F
	for <lists+linux-csky@lfdr.de>; Tue, 18 Mar 2025 04:35:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 950B53BEF75
	for <lists+linux-csky@lfdr.de>; Tue, 18 Mar 2025 03:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9741B424D;
	Tue, 18 Mar 2025 03:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Oyb6ZVN/"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D51DC070
	for <linux-csky@vger.kernel.org>; Tue, 18 Mar 2025 03:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742268743; cv=none; b=LaxzDIbGOtNiqAVHonAodn1dLY9r5ht2aWXicNJAmqeJwhzUwCCTEvaEWaRzLEaL7cyxPusZuPpGtlDjmYBRQ3NMuKscKkD4qiNCPsJ9wpROGml7IX9N0rpRxj9582yiOAFtw3vCqnn3rSccYLd/8niAgf+16k9lu6PPUNTUNyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742268743; c=relaxed/simple;
	bh=3uu7CB6A8C3yWHCi12pQmud6FUTrY1STEruRjCdoigM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pNXltZEfpqeBTV7Su0Gq6rvqfhW/Blix+oO61geL8su3KWw0eL8zEmxEdhiYbx2NIFFfLfS1VxSI8vgPLXzWtzfoec8MhgRxdn1YBKtU2GHJyVJgzRyeWG/OBYNPX7iM2Nxjf/uJztZ+Dgn9GPUAg6FvJD/JuKW3zOBXTXXJ7Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Oyb6ZVN/; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e6373b4cbcfso7957402276.3
        for <linux-csky@vger.kernel.org>; Mon, 17 Mar 2025 20:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742268741; x=1742873541; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ncdSM+lbXMb9xe65qVg6II6RWpGKh15ceN/q8SVr8Hw=;
        b=Oyb6ZVN/DguZcz1U0QL4icwKpyJUd9M3t+PF5p18kKL78Lidos0a5/2Y3/LrHGJgnB
         3hTH7YGimpGSTuwLrtHJVV7mmgn5sPU6zN5Zb47IlQt9GJQlm+VIwEVS8L94SZ7eFygD
         KXQvnG9WrKlzoXwsOetM6qOugBUwND4Uw1PYnwfUUs0LJE3qZ0CgBl2maxm21V2CehUZ
         QHEPgNPDjYsUfpXuWC6HhAsR6mRJVJGNtzuLa9Dtvzvf4Chf7Myu9tgHIzxLiGfrXlD6
         zKaVqjOKqwaEmAgutvvdO5L3HaNdVwS9BJxgxNVYXQ8IIQH0/aRAgmLaFgKPW/B2z9YZ
         ZMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742268741; x=1742873541;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ncdSM+lbXMb9xe65qVg6II6RWpGKh15ceN/q8SVr8Hw=;
        b=GV8C28RHQ+6s/489slNOnZA4qa6M4pduupoR5SxIJfvFwSRQQQMljSWEj/HoOHLWDI
         FAo4KTVcP3sfiGRnmdBE3RGt9qrIqkBs9Nr6O231xNbJC+pmCwkJcWIXxarCRZuPPF2A
         c2gSVNvKk1BzYSdpA6ragZHBlcq1eoFShDk6gQl2LBiolodiT8uyd90d8wQTR8BHV/Zc
         85G9m5P8XAQq1jRiJ5OVHraE9WTHBu3nf/IklLUkA+gmwW04RhD8FCn8/qu6OYxW7nmw
         ICJLNPdYHd2aDkJuCaSdCrG4QHBdIEtRwCtbKmix9jY3kGSGGaNQrY5tP20qhvxfdutG
         Vmww==
X-Forwarded-Encrypted: i=1; AJvYcCVrRR39IJhIluQmgN0YMvqHm3yhtKayLrtw/rKMZziIt5kR9INM8wX6miH0NXFTy9Q5q0TSTNY1fxwI@vger.kernel.org
X-Gm-Message-State: AOJu0YybD2tCr5IaUDgbW4sTjS/m6pThOOrMI4G80zf3f9xMQpTRvIRU
	WzBESJWzW1mBoJyJo3ZMorfe/pRDIPKTC/J7I+XJuaMB9vbZBLM4VRFZ79lQPRtXwnAo7bnqouo
	z7cveYw==
X-Google-Smtp-Source: AGHT+IFff6zTrm/qdBPCcW4VzBl/8HVEtmJ31hx7NBMcpMHrGakVqIIkkB68EE2nkLWCDeZliwqsntSQnLqE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ef29:15ce:a42a:b69f])
 (user=irogers job=sendgmr) by 2002:a25:3d47:0:b0:e63:c603:37d2 with SMTP id
 3f1490d57ef6-e63f65f7ddfmr17773276.7.1742268741220; Mon, 17 Mar 2025 20:32:21
 -0700 (PDT)
Date: Mon, 17 Mar 2025 20:31:48 -0700
In-Reply-To: <20250318033150.119174-1-irogers@google.com>
Message-Id: <20250318033150.119174-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318033150.119174-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v6 11/13] perf syscalltbl: Mask off ABI type for MIPS system calls
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


