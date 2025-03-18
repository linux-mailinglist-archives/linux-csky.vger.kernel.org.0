Return-Path: <linux-csky+bounces-1986-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A57A66771
	for <lists+linux-csky@lfdr.de>; Tue, 18 Mar 2025 04:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AFC73BFC7E
	for <lists+linux-csky@lfdr.de>; Tue, 18 Mar 2025 03:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8C71BD4F7;
	Tue, 18 Mar 2025 03:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="un0dzwLv"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20BB1DE4D9
	for <linux-csky@vger.kernel.org>; Tue, 18 Mar 2025 03:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742268748; cv=none; b=c4Y/D/PSIggrN6PLSCxOBzcu6+DbTwn6bdiMsSfwM723zt197qOiwGWnTcQ4GVbZ6dpCA/kWBoKiNja9l5Cq8eS5a376yO3YnkFcS7IZUl2YMu/KuOc+oz93raBJl9YQcLkzKVSjCKZWAsIXwCG+AVe4w2qo7qJFAJKrZx+DG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742268748; c=relaxed/simple;
	bh=X4cVGKjddUrT1hh6NkP/YFyNfnEK9oIiaFfoZniet0k=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=pGgomeZQ7fePW2jMVtGB5K96BNIaaj+hA26hpt0oK7Cg+UcH/MFWBCHu04ilU5+m57vpI1Tpit80cVgLUiwc1omb0XmuMxA0DRKPMRN0k1XoV3qkQbPxL1STHwcMvMcY0wfwfKU8Fvj2D1BGrOwzRAsam9HgC9Z/ihjyP5DhAsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=un0dzwLv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e6372bafb96so7886913276.2
        for <linux-csky@vger.kernel.org>; Mon, 17 Mar 2025 20:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742268746; x=1742873546; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQo9te7ZzJhvscCqCJ9snuZUA/U+ZRpIQMTgL/AyPbA=;
        b=un0dzwLvY6tnVQeaXE1d6veu7ouRB+bsRHu350+W/ZBofJ8zZgdVEZVr+YLTFLw8qx
         /vvD+GnvNLajwkicKCdfl7IvxVKII0Op/tZ0Fd795AD1yxnB6T+5xc/gGs+AKRogGpDG
         oM3CVadx+qPHHErcvMmRqzvIxjUeZbECMMh8evU8/kGgPr8xopK/G5Z12AdGn0PxOAB6
         N1SVY5SsqQpu1nIf4orqX/DoGN9vV9Ug5KUUa/0mHZjGCohLpKqnAHGpKHfxHkoHSaIi
         4jfWYBVRmQ9RDEbMkp3YJqGw8lKazXh0VJ1xBH+LDUwOyb5bIRwNcZ+axOfR2ilNrCjB
         HmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742268746; x=1742873546;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQo9te7ZzJhvscCqCJ9snuZUA/U+ZRpIQMTgL/AyPbA=;
        b=c7xDJe78qFihYCQOFV0hejUSTmmqESMtZVqIs2g5sEJNawybgaBBwxThTOVCabx3lC
         P8+yxpje1fw7J5DWjybAjqHkF3cnzaxLn0RIzf4RMuJdWpjS5iCuZ34XHLbqhW3ACe3G
         fIxA6TXhKe5ZLw/FfiCcjbhijL8+OAi5U/IDq45Rc+GBNX1auSrX2Nv7Ltdzrx2A+p94
         xaep3i8WmUhHSe80hYUF1R+n8TblHeRp/DgJuUrkdau7p5GHwu9QbHz69JwTb2D3WqzG
         lcWvag2RoBq4FrC4y4+BNw23FjBIXXrOJrn84N2eDjn95tXa1aWJo3jyVido8hNkd9iv
         ClwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYjF0WMBtngKKkL8w7OhRSfMG1jwyafBPodpGEKRui2dp6ZGLURhpIjs9n/jVz7Wqkf9RYGgBJ9WTM@vger.kernel.org
X-Gm-Message-State: AOJu0YxnWWm/8yMSSeju3JqyBv6PNhN2PKzeP7YFmitW7eDoehgXbdyE
	j2ts6M9IIqdJfc/S7zn293YuL4StNDP3oiz14eI/E4nzhSNA5nFrZxn+IZXs+l2TrsWmRzp6l22
	vk8gTOw==
X-Google-Smtp-Source: AGHT+IGRlVl7Gw//953kKsnqnEm7y8Rwpz1NXG8HWXbHdCQFY9o6z5zJFDv6lHgSfJyidVHvfm/4CNW4I8zo
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ef29:15ce:a42a:b69f])
 (user=irogers job=sendgmr) by 2002:a25:8209:0:b0:e5b:f74:f5a with SMTP id
 3f1490d57ef6-e63f65f1718mr7472276.8.1742268745758; Mon, 17 Mar 2025 20:32:25
 -0700 (PDT)
Date: Mon, 17 Mar 2025 20:31:50 -0700
In-Reply-To: <20250318033150.119174-1-irogers@google.com>
Message-Id: <20250318033150.119174-14-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318033150.119174-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v6 13/13] perf trace: Fix BTF memory leak
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

Add missing btf__free in trace__exit.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index a5f31472980b..d4bbb6a1e817 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -5339,6 +5339,12 @@ static void trace__exit(struct trace *trace)
 		zfree(&trace->syscalls.table);
 	}
 	zfree(&trace->perfconfig_events);
+#ifdef HAVE_LIBBPF_SUPPORT
+	if (trace->btf != NULL) {
+		btf__free(trace->btf);
+		trace->btf = NULL;
+	}
+#endif
 }
 
 #ifdef HAVE_BPF_SKEL
-- 
2.49.0.rc1.451.g8f38331e32-goog


