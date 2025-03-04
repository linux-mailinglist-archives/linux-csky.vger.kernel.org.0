Return-Path: <linux-csky+bounces-1862-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6780BA4D2C5
	for <lists+linux-csky@lfdr.de>; Tue,  4 Mar 2025 06:05:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B57E3AE687
	for <lists+linux-csky@lfdr.de>; Tue,  4 Mar 2025 05:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2951F5843;
	Tue,  4 Mar 2025 05:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XGzVE3H0"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD821F582F
	for <linux-csky@vger.kernel.org>; Tue,  4 Mar 2025 05:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741064677; cv=none; b=hRPoxSNxw4Dn2oO6IQpK/Sgg3aBKzosjTmd6BGK2/Jq9QR4F28wvafquphsPOJSn1mXIAkXwZxpL9PQF2EYYl+N2kRkAo5d7KEjhejX3uk/PjVtTloZj5KafH2mVfRnuFE1z9BTx7rddUb9z3AxTN4XsCN6VS14nLe4dzMeSDf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741064677; c=relaxed/simple;
	bh=A0sEW1yrS2eUc2FB8WS5vLeQRiLW1DtJexiOaK+uE1c=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=E7oq0q+aPcL5ol+fxtF6jVqoP5zMy6JS2wJmv757IesX7mnjpHpK2FU+TkDrc4jJbttgySYcrtAcXrGFIoAaSjLdkB2R72lfGAd846uZdlVTgE4GZY7S74qVSmtg6MIXkqwo/DZHY0qmObUHTyPSPXUcs8mtgF1iJM9/lwApz/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XGzVE3H0; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fd68bb531dso19595617b3.3
        for <linux-csky@vger.kernel.org>; Mon, 03 Mar 2025 21:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741064674; x=1741669474; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3HrWq55URAvKiiWxGVqUqLNqZvZQb6ypA4Z1urQ/vII=;
        b=XGzVE3H0laB9tyX/COOlrSrAhsc+2S3rCHwHh8TGSdb0xHYdvC59PJbm2O935iTqau
         FzVfalRfi6Rwl5+ChCvWegsKZKZU78k5+x0efWq8ymO/4HBsMz3sz2Ol7HhDZB9JgfmG
         Y4BbXgoF/FxkWQ3hmFvE5CqCXpZWYxuNGzEEuPZpGCy604AQqtwTWrZoIKEzFRNoE9Ei
         r7eRUqIFjcNqmxtcQpXInmucJaeHWlORniqn5m2+l4tK1zDqM9ZOLuNdikHIsHHTsak0
         tmPFz2NBOZWr86DN+2wt7sFhriEFjO9skHQ/LMIqwrifzvy16PwcjmO7SAk+MkPJc9t+
         zdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741064674; x=1741669474;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3HrWq55URAvKiiWxGVqUqLNqZvZQb6ypA4Z1urQ/vII=;
        b=MagKBX+1msodtCZ8XyjpfbGNWLx1Zb+fypkHWRHPbTbdIAfv+FN0IwMeB7CXPZn8Yq
         2NN5tTBnGUuSGC/ZcBC2PaPt1OFM9mod7wc1OWoESB1+a/vCxDZsKSWd4w7Ju3fobh/N
         bT71Mp3SJzX6wa5R/kyteakNjPhk2bPC9u9HRo6g2qY8LpV05cRmYtGK9RAhwZ7Sz+tk
         3LNYUBwMlYttK3OUNzLbGqmRB6h/qAu7I2JuJa3bqFNM6Af0kAH/PirXkDZ5DqKMX+iN
         nWiZuL4TFW5pvqb2sDq/zDOXFGIux9rXuWNHjNpo6oofTre2LoNbLhd6x0xZLCMpmfyZ
         MLVg==
X-Forwarded-Encrypted: i=1; AJvYcCUQC3EH//6Ajx0+Fjvpkz+2SSgGOqhM74CtkLnQJf7K5UCU9ymf3Skg0ANGB+bER/Z+vIF9JIw8WaGt@vger.kernel.org
X-Gm-Message-State: AOJu0YyYr+Eu/H4Vl9aD3lnRuOCXCBS8liSdgtSGCQNRghrXHwRipakA
	vY97P44ISOLCq/vPhVi9xbsdU2kJDJ5WiMI3SDeD70NCCGuqiMs18agnmkQOmVPvNM/pVFGdwYz
	8yOzYbA==
X-Google-Smtp-Source: AGHT+IFL0x8xC/y2wFw3FqFrNIsftTveHeL/EEuR1YjkCALZ8KeNdylP7gyqiXAiPSfCe/J/KCIvusNGceBR
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8af9:d1f7:bca9:da2])
 (user=irogers job=sendgmr) by 2002:a05:690c:74c9:b0:6fb:451d:3409 with SMTP
 id 00721157ae682-6fd49e96116mr12079757b3.0.1741064674376; Mon, 03 Mar 2025
 21:04:34 -0800 (PST)
Date: Mon,  3 Mar 2025 21:03:00 -0800
In-Reply-To: <20250304050305.901167-1-irogers@google.com>
Message-Id: <20250304050305.901167-7-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304050305.901167-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v4 06/11] perf dso: Add support for reading the e_machine type
 for a dso
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

For ELF file dsos read the e_machine from the ELF header. For kernel
types assume the e_machine matches the perf tool. In other cases
return EM_NONE.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c | 54 +++++++++++++++++++++++++++++++++++++++++++
 tools/perf/util/dso.h |  1 +
 2 files changed, 55 insertions(+)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 5c6e85fdae0d..7f2f1af4f73b 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1170,6 +1170,60 @@ ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 	return data_read_write_offset(dso, machine, offset, data, size, true);
 }
 
+uint16_t dso__e_machine(struct dso *dso, struct machine *machine)
+{
+	uint16_t e_machine = EM_NONE;
+	int fd;
+
+	switch (dso__binary_type(dso)) {
+	case DSO_BINARY_TYPE__KALLSYMS:
+	case DSO_BINARY_TYPE__GUEST_KALLSYMS:
+	case DSO_BINARY_TYPE__VMLINUX:
+	case DSO_BINARY_TYPE__GUEST_VMLINUX:
+	case DSO_BINARY_TYPE__GUEST_KMODULE:
+	case DSO_BINARY_TYPE__GUEST_KMODULE_COMP:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_KMODULE_COMP:
+	case DSO_BINARY_TYPE__KCORE:
+	case DSO_BINARY_TYPE__GUEST_KCORE:
+	case DSO_BINARY_TYPE__BPF_PROG_INFO:
+	case DSO_BINARY_TYPE__BPF_IMAGE:
+	case DSO_BINARY_TYPE__OOL:
+	case DSO_BINARY_TYPE__JAVA_JIT:
+		return EM_HOST;
+	case DSO_BINARY_TYPE__DEBUGLINK:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE:
+	case DSO_BINARY_TYPE__BUILD_ID_CACHE_DEBUGINFO:
+	case DSO_BINARY_TYPE__SYSTEM_PATH_DSO:
+	case DSO_BINARY_TYPE__OPENEMBEDDED_DEBUGINFO:
+	case DSO_BINARY_TYPE__FEDORA_DEBUGINFO:
+	case DSO_BINARY_TYPE__UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__MIXEDUP_UBUNTU_DEBUGINFO:
+	case DSO_BINARY_TYPE__BUILDID_DEBUGINFO:
+		break;
+	case DSO_BINARY_TYPE__NOT_FOUND:
+	default:
+		return EM_NONE;
+	}
+
+	pthread_mutex_lock(&dso__data_open_lock);
+
+	/*
+	 * dso__data(dso)->fd might be closed if other thread opened another
+	 * file (dso) due to open file limit (RLIMIT_NOFILE).
+	 */
+	try_to_open_dso(dso, machine);
+	fd = dso__data(dso)->fd;
+	if (fd >= 0) {
+		_Static_assert(offsetof(Elf32_Ehdr, e_machine) == 18, "Unexpected offset");
+		_Static_assert(offsetof(Elf64_Ehdr, e_machine) == 18, "Unexpected offset");
+		if (pread(fd, &e_machine, sizeof(e_machine), 18) != sizeof(e_machine))
+			e_machine = EM_NONE;
+	}
+	pthread_mutex_unlock(&dso__data_open_lock);
+	return e_machine;
+}
+
 /**
  * dso__data_read_addr - Read data from dso address
  * @dso: dso object
diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
index f3ca2a5e7670..ba9b83db061a 100644
--- a/tools/perf/util/dso.h
+++ b/tools/perf/util/dso.h
@@ -818,6 +818,7 @@ int dso__data_file_size(struct dso *dso, struct machine *machine);
 off_t dso__data_size(struct dso *dso, struct machine *machine);
 ssize_t dso__data_read_offset(struct dso *dso, struct machine *machine,
 			      u64 offset, u8 *data, ssize_t size);
+uint16_t dso__e_machine(struct dso *dso, struct machine *machine);
 ssize_t dso__data_read_addr(struct dso *dso, struct map *map,
 			    struct machine *machine, u64 addr,
 			    u8 *data, ssize_t size);
-- 
2.48.1.711.g2feabab25a-goog


