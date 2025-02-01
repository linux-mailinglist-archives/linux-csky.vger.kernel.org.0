Return-Path: <linux-csky+bounces-1705-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E06B1A24772
	for <lists+linux-csky@lfdr.de>; Sat,  1 Feb 2025 08:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E3193A86FE
	for <lists+linux-csky@lfdr.de>; Sat,  1 Feb 2025 07:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE24149DFA;
	Sat,  1 Feb 2025 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1g/FfQ4y"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE4A145B21
	for <linux-csky@vger.kernel.org>; Sat,  1 Feb 2025 07:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738394121; cv=none; b=vBzWfgcR3wDLVdyyb5fatyKRSFuP8oHI2clI4g09lUmbcK2cAVBd/B+ycdrRTjVs+mpYEP0P+Bi7jNBspEjnPMq8pN0rDFi0APf4eoDqI7uidVEg+OXWkWM1FQGnsK71WyHCPeB97OtsVvQV9LZBTqWx+dMwY4v1pzhhslIDotc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738394121; c=relaxed/simple;
	bh=IVeZCCsNxF/rtx3+zGoeR8BnENWzZmk4yY0/6NP57bo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=WynNYKkG0ftiNzTJ6UPYYRWWMWAlRYbIyFLIWAQJez1SnLeTl022AyMlzrCVAmCauiyXxhGMQE1ynskheaBOmyi8vKHxcpR+WgMHhI0d/zvci2YdxRIbhxVeFeDYDUv3D1TLmDFAgupaluC6qF+5Y4/XzOtpJzwFm904fNHs7gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1g/FfQ4y; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6f72479cd99so21909217b3.3
        for <linux-csky@vger.kernel.org>; Fri, 31 Jan 2025 23:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738394118; x=1738998918; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TthwbOZkHzMV/U+Knk4syVDpsUcxETJ0FM1uTXU17u4=;
        b=1g/FfQ4yeFOgtNXwKHGIXvx/fx0FTJoUQBEMaRtXsPid263swo/JSSHGhQqoWaAhtI
         1TRS3UBklENaI0tk+7PW1imGSgG50PKapzzkG/vEHUNwryFoBPk4KpdmDsLYBjOCdTGV
         03oC/XlULJU7jZmiH+FURaMrZyZ9ipYbYz+NxL4AaMpfDLdXZmS/KXG9MxYCi0MwlDiC
         jumxa0DP6b5VroNo9PQ8OF6H0kzIXeaH8JBf4+8I8qMvJLWoKEbNC8JZ4vsijrO3nYao
         wKyiEXzYjDtR6efZBU0ZlQv9sUiKl4z96YkR7WEJuH9wKxv6plja4meYDxLwDJ4c3ocH
         oPfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738394118; x=1738998918;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TthwbOZkHzMV/U+Knk4syVDpsUcxETJ0FM1uTXU17u4=;
        b=hJ4auLXRHwhmJzX/ubCPMc5P40GY++8I0HCvgMiNzi8FjCKjmH3+etwtWav9nN2wy0
         2S7OmdJcSH/EkVtM091RX6n8O3zNTzpG1uhR2iySiVKUUYi4u6/ZY2bXkbYTmzfbN34V
         ZR6WtmZLXoaOQEk8pAPPakBblQF7mKxb8VmwLcn5mtktwXMGl/NhrxO0lUB/dGbFugBJ
         thGKnHwakRuho1kiJVEYiYVi99NxvJtOmwyQYfKANdGDOXXdMgDTqpVXV5DS6vpUE+xR
         7ncP043Bn42I/WOeZ8da6UR6DuvVxdBr0eswR9xrNtBbTrC9tMRuxz1J9YEsbchtp9Zs
         BDUg==
X-Forwarded-Encrypted: i=1; AJvYcCUDk1eLvoIMaWPbH6C3HWKGwOdOBDAIU9bN1dg6Azx5kkFDNKbyGI9EnnRIQcFaquO6Ul8Kig3w91Wm@vger.kernel.org
X-Gm-Message-State: AOJu0YzOYrdST6pPvQ8nkyvW6LmSifIMXzuLIdbdUo24fEO/e73vXcFz
	BzPTMRTfffnnYsYvjTOzJAC40IxUG2BV2AYqhLrq3RUmHJTe2PB0I0OdM2nv5J/RTMZOZuZB1x7
	6xCaA/A==
X-Google-Smtp-Source: AGHT+IFwWB0up1bPee2Rs6SlTWcnqrNwDU+LXavttncftVjLkVPBDKnZQmt3JTB4rN5T/puob/0R8cJH1fw7
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:de26:87db:e4d0:62b6])
 (user=irogers job=sendgmr) by 2002:a25:e0c1:0:b0:e58:a8b5:9af8 with SMTP id
 3f1490d57ef6-e58a8b59c53mr30715276.5.1738394117891; Fri, 31 Jan 2025 23:15:17
 -0800 (PST)
Date: Fri, 31 Jan 2025 23:14:52 -0800
In-Reply-To: <20250201071455.718247-1-irogers@google.com>
Message-Id: <20250201071455.718247-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Subject: [PATCH v1 4/7] perf thread: Add support for reading the e_machine
 type for a thread
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
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Use the executable from /proc/pid/exe and read the e_machine from the
ELF header. On failure use EM_HOST. Change builtin-trace syscall
functions to pass e_machine from the thread rather than EM_HOST, so
that in later patches when syscalltbl can use the e_machine the system
calls are specific to the architecture.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-trace.c | 41 ++++++++++++++++---------------
 tools/perf/util/thread.c   | 50 ++++++++++++++++++++++++++++++++++++++
 tools/perf/util/thread.h   | 14 ++++++++++-
 3 files changed, 85 insertions(+), 20 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 7e3aa2f6c5e2..d60db6a23852 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2674,16 +2674,17 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	int printed = 0;
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
-	int augmented_args_size = 0;
+	int augmented_args_size = 0, e_machine;
 	void *augmented_args = NULL;
 	/* TODO: get e_machine from thread. */
-	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
+	struct syscall *sc;
 	struct thread_trace *ttrace;
 
-	if (sc == NULL)
-		return -1;
-
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+	e_machine = thread__e_machine(thread, trace->host);
+	sc = trace__syscall_info(trace, evsel, e_machine, id);
+	if (sc == NULL)
+		goto out_put;
 	ttrace = thread__trace(thread, trace->output);
 	if (ttrace == NULL)
 		goto out_put;
@@ -2752,16 +2753,18 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
 	/* TODO: get e_machine from thread. */
-	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
+	struct syscall *sc;
 	char msg[1024];
 	void *args, *augmented_args = NULL;
-	int augmented_args_size;
+	int augmented_args_size, e_machine;
 	size_t printed = 0;
 
-	if (sc == NULL)
-		return -1;
 
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+	e_machine = thread__e_machine(thread, trace->host);
+	sc = trace__syscall_info(trace, evsel, e_machine, id);
+	if (sc == NULL)
+		return -1;
 	ttrace = thread__trace(thread, trace->output);
 	/*
 	 * We need to get ttrace just to make sure it is there when syscall__scnprintf_args()
@@ -2826,15 +2829,15 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	bool duration_calculated = false;
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0, printed = 0;
-	int alignment = trace->args_alignment;
-	/* TODO: get e_machine from thread. */
-	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
+	int alignment = trace->args_alignment, e_machine;
+	struct syscall *sc;
 	struct thread_trace *ttrace;
 
-	if (sc == NULL)
-		return -1;
-
 	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
+	e_machine = thread__e_machine(thread, trace->host);
+	sc = trace__syscall_info(trace, evsel, e_machine, id);
+	if (sc == NULL)
+		goto out_put;
 	ttrace = thread__trace(thread, trace->output);
 	if (ttrace == NULL)
 		goto out_put;
@@ -3181,8 +3184,8 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 
 	if (evsel == trace->syscalls.events.bpf_output) {
 		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
-		/* TODO: get e_machine from thread. */
-		struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
+		int e_machine = thread ? thread__e_machine(thread, trace->host) : EM_HOST;
+		struct syscall *sc = trace__syscall_info(trace, evsel, e_machine, id);
 
 		if (sc) {
 			fprintf(trace->output, "%s(", sc->name);
@@ -4760,6 +4763,7 @@ static size_t trace__fprintf_thread(FILE *fp, struct thread *thread, struct trac
 {
 	size_t printed = 0;
 	struct thread_trace *ttrace = thread__priv(thread);
+	int e_machine = thread__e_machine(thread, trace->host);
 	double ratio;
 
 	if (ttrace == NULL)
@@ -4779,8 +4783,7 @@ static size_t trace__fprintf_thread(FILE *fp, struct thread *thread, struct trac
 	else if (fputc('\n', fp) != EOF)
 		++printed;
 
-	/* TODO: get e_machine from thread. */
-	printed += thread__dump_stats(ttrace, trace, EM_HOST, fp);
+	printed += thread__dump_stats(ttrace, trace, e_machine, fp);
 
 	return printed;
 }
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 0ffdd52d86d7..a07446a280ed 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -1,5 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
+#include <elf.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <string.h>
@@ -16,6 +18,7 @@
 #include "symbol.h"
 #include "unwind.h"
 #include "callchain.h"
+#include "dwarf-regs.h"
 
 #include <api/fs/fs.h>
 
@@ -51,6 +54,7 @@ struct thread *thread__new(pid_t pid, pid_t tid)
 		thread__set_ppid(thread, -1);
 		thread__set_cpu(thread, -1);
 		thread__set_guest_cpu(thread, -1);
+		thread__set_e_machine(thread, EM_NONE);
 		thread__set_lbr_stitch_enable(thread, false);
 		INIT_LIST_HEAD(thread__namespaces_list(thread));
 		INIT_LIST_HEAD(thread__comm_list(thread));
@@ -423,6 +427,52 @@ void thread__find_cpumode_addr_location(struct thread *thread, u64 addr,
 	}
 }
 
+static uint16_t read_proc_e_machine_for_pid(pid_t pid)
+{
+	char path[6 /* "/proc/" */ + 11 /* max length of pid */ + 5 /* "/exe\0" */];
+	int fd;
+	uint16_t e_machine = EM_NONE;
+
+	snprintf(path, sizeof(path), "/proc/%d/exe", pid);
+	fd = open(path, O_RDONLY);
+	if (fd >= 0) {
+		_Static_assert(offsetof(Elf32_Ehdr, e_machine) == 18, "Unexpected offset");
+		_Static_assert(offsetof(Elf64_Ehdr, e_machine) == 18, "Unexpected offset");
+		if (pread(fd, &e_machine, sizeof(e_machine), 18) != sizeof(e_machine))
+			e_machine = EM_NONE;
+		close(fd);
+	}
+	return e_machine;
+}
+
+uint16_t thread__e_machine(struct thread *thread, struct machine *machine)
+{
+	pid_t tid, pid;
+	uint16_t e_machine = RC_CHK_ACCESS(thread)->e_machine;
+
+	if (e_machine != EM_NONE)
+		return e_machine;
+
+	tid = thread__tid(thread);
+	pid = thread__pid(thread);
+	if (pid != tid) {
+		struct thread *parent = machine__findnew_thread(machine, pid, pid);
+
+		if (parent) {
+			e_machine = thread__e_machine(parent, machine);
+			thread__set_e_machine(thread, e_machine);
+			return e_machine;
+		}
+		/* Something went wrong, fallback. */
+	}
+	e_machine = read_proc_e_machine_for_pid(pid);
+	if (e_machine != EM_NONE)
+		thread__set_e_machine(thread, e_machine);
+	else
+		e_machine = EM_HOST;
+	return e_machine;
+}
+
 struct thread *thread__main_thread(struct machine *machine, struct thread *thread)
 {
 	if (thread__pid(thread) == thread__tid(thread))
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index 6cbf6eb2812e..cd574a896418 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -60,7 +60,11 @@ DECLARE_RC_STRUCT(thread) {
 	struct srccode_state	srccode_state;
 	bool			filter;
 	int			filter_entry_depth;
-
+	/**
+	 * @e_machine: The ELF EM_* associated with the thread. EM_NONE if not
+	 * computed.
+	 */
+	uint16_t		e_machine;
 	/* LBR call stack stitch */
 	bool			lbr_stitch_enable;
 	struct lbr_stitch	*lbr_stitch;
@@ -302,6 +306,14 @@ static inline void thread__set_filter_entry_depth(struct thread *thread, int dep
 	RC_CHK_ACCESS(thread)->filter_entry_depth = depth;
 }
 
+uint16_t thread__e_machine(struct thread *thread, struct machine *machine);
+
+static inline void thread__set_e_machine(struct thread *thread, uint16_t e_machine)
+{
+	RC_CHK_ACCESS(thread)->e_machine = e_machine;
+}
+
+
 static inline bool thread__lbr_stitch_enable(const struct thread *thread)
 {
 	return RC_CHK_ACCESS(thread)->lbr_stitch_enable;
-- 
2.48.1.362.g079036d154-goog


