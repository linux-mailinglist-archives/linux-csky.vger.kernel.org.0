Return-Path: <linux-csky+bounces-1861-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E8BA4D2C0
	for <lists+linux-csky@lfdr.de>; Tue,  4 Mar 2025 06:05:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E13B16DDEC
	for <lists+linux-csky@lfdr.de>; Tue,  4 Mar 2025 05:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5FE1F4624;
	Tue,  4 Mar 2025 05:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nz5yY+aK"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C631F560E
	for <linux-csky@vger.kernel.org>; Tue,  4 Mar 2025 05:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741064675; cv=none; b=CONfqEnzpr9WGLWW+G7z1QbCXBK4FojMEeQQ0WxeOG/na+HoDMkMrJm6UOKGTxXUoQG9h7oV6uP3T2E71GE4tCtRC2YVeS6B/aCiz7DYGOF8hYqj6XLKqH6X2EGJcnLJ3bFeBuYE2XocsSMWTYyKagIs0EMn7zR2qIqlXOanXHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741064675; c=relaxed/simple;
	bh=BXMEoiAoVaWuSaFivY6feOMwrzbOA1trBpUG3PDvWgs=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=J8YtdGHcuOkUfwStg4TEYpZ0v80bJ7zJck+waW6WpOrwOoyR8PQ4imveVaW7IndYzXnMtyW5GWEF1EPs8mNbNxjGWQWMIlkU+5C7pXExfxlp4YGOIPBEo7yLElxXHpYME+enfzqto09WQDLx2F4jvfYqdsjI10tTFQAkBV6NHH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nz5yY+aK; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f2737d115eso71346077b3.2
        for <linux-csky@vger.kernel.org>; Mon, 03 Mar 2025 21:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741064672; x=1741669472; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vw0UBvZfnhc2uqWgp+y05m5WXhHdzT5X2tnP9nosJy4=;
        b=nz5yY+aKvgf8qtk42gQSXRtfdsX7EaPoVPLqXYMrhDdB8/FbTB/TGGHB+/1cJv195p
         /L6/m1YnFQjgC1xw8oYZ2FMiugll7qV5ROJx2ABZhlhaDRk+P8oO8wk4GyItGhhrNKHE
         KqTKMzrELvma5lOu00ehVTppv2idzgedxGuXo9knq4s0nRslFgackQwsqJsq+wiltmHL
         MA3o3FxaWnWmFAqekfhd7sTJQfkz2t91xsgEVM9qI4E8HV+66QMC1SwhOrK3YFLBqLm3
         HgD8V9218JqZm/98TerQE1izu9NhssVt+VIdepRIe+0cTT6aEG4V89+iiji9GjF9540/
         y/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741064672; x=1741669472;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vw0UBvZfnhc2uqWgp+y05m5WXhHdzT5X2tnP9nosJy4=;
        b=m0a2LQIBfEacxSgHslr9y8ZtzLjaoyNvaVhJfl+4pByk1POMgqfk5J6+/15uqRGKih
         sS4/jkul7i6XD/Ga0n2h3sMZN62SfXofV8P0dfIlwAS79Et1GrqGiqZbeTVE4tGImgJW
         S59dnlLdz4tLcb+CDmwVhtgggCoohIB3vPCW7XOnQEWmTo027RHDGsIRdqZwqBLPCkJt
         SvH6NC6d3OUFNbhii486ryaAwJDsRGWhnvBuQxgJvQ0/l4cakb2tKxD8evdItDOJNTQT
         f1/cHXzuxtiQbQ8QfI+1Kv2z1o0BUwiqT7BIc65bF7G2mT/WnIZMRQevrKjw+p3YmExy
         jOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVdt3OUlFL1KU9MzjzIxUQdHXCj45NSXmx9rQmiYesHM9pjCgcn9RBzmjWOlVk3AGJEmExCdB4vpPm@vger.kernel.org
X-Gm-Message-State: AOJu0YxaFjU/uXloP9qmTsg67tRuaLqpIm1KXdrNeFVJavpx80RiITOw
	EQ3FxkCJlVQ/jm7N4mpyshMVpGY/7TfavJDx7pTpTYbiE2EJUvQ/iIqgyI4ESZBdEBCs2hY2x+W
	5UcwF0Q==
X-Google-Smtp-Source: AGHT+IEU8ZkOoiFux9e5NP2q0qurBZjFLqqfHXXswmh8WyetOv8al7o9NQVtPhPFuxOBzxPTLkf+nuZUaVfp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8af9:d1f7:bca9:da2])
 (user=irogers job=sendgmr) by 2002:a0d:d147:0:b0:6f9:98c3:a191 with SMTP id
 00721157ae682-6fd49fb12b9mr10378557b3.2.1741064671650; Mon, 03 Mar 2025
 21:04:31 -0800 (PST)
Date: Mon,  3 Mar 2025 21:02:59 -0800
In-Reply-To: <20250304050305.901167-1-irogers@google.com>
Message-Id: <20250304050305.901167-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250304050305.901167-1-irogers@google.com>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Subject: [PATCH v4 05/11] perf syscalltbl: Remove struct syscalltbl
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

The syscalltbl held entries of system call name and number pairs,
generated from a native syscalltbl at start up. As there are gaps in
the system call number there is a notion of index into the
table. Going forward we want the system call table to be identifiable
by a machine type, for example, i386 vs x86-64. Change the interface
to the syscalltbl so (1) a (currently unused machine type of EM_HOST)
is passed (2) the index to syscall number and system call name mapping
is computed at build time.

Two tables are used for this, an array of system call number to name,
an array of system call numbers sorted by the system call name. The
sorted array doesn't store strings in part to save memory and
relocations. The index notion is carried forward and is an index into
the sorted array of system call numbers, the data structures are
opaque (held only in syscalltbl.c), and so the number of indices for a
machine type is exposed as a new API.

The arrays are computed in the syscalltbl.sh script and so no start-up
time computation and storage is necessary.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Howard Chu <howardchu95@gmail.com>
Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/perf/builtin-trace.c       | 106 +++++++++++++++++------------
 tools/perf/scripts/syscalltbl.sh |  36 ++++------
 tools/perf/util/syscalltbl.c     | 113 ++++++++++---------------------
 tools/perf/util/syscalltbl.h     |  22 ++----
 4 files changed, 117 insertions(+), 160 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f7d035dc0e00..cfc8cb8cbef8 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -149,7 +149,6 @@ enum summary_mode {
 
 struct trace {
 	struct perf_tool	tool;
-	struct syscalltbl	*sctbl;
 	struct {
 		/** Sorted sycall numbers used by the trace. */
 		struct syscall  *table;
@@ -188,6 +187,14 @@ struct trace {
 		pid_t		*entries;
 		struct bpf_map  *map;
 	}			filter_pids;
+	/*
+	 * TODO: The map is from an ID (aka system call number) to struct
+	 * syscall_stats. If there is >1 e_machine, such as i386 and x86-64
+	 * processes, then the stats here will gather wrong the statistics for
+	 * the non EM_HOST system calls. A fix would be to add the e_machine
+	 * into the key, but this would make the code inconsistent with the
+	 * per-thread version.
+	 */
 	struct hashmap		*syscall_stats;
 	double			duration_filter;
 	double			runtime_ms;
@@ -2141,7 +2148,7 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
 		return 0;
 	}
 
-	name = syscalltbl__name(trace->sctbl, sc->id);
+	name = syscalltbl__name(sc->e_machine, sc->id);
 	if (name == NULL) {
 		sc->nonexistent = true;
 		return -EEXIST;
@@ -2241,10 +2248,14 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 
 	strlist__for_each_entry(pos, trace->ev_qualifier) {
 		const char *sc = pos->s;
-		int id = syscalltbl__id(trace->sctbl, sc), match_next = -1;
+		/*
+		 * TODO: Assume more than the validation/warnings are all for
+		 * the same binary type as perf.
+		 */
+		int id = syscalltbl__id(EM_HOST, sc), match_next = -1;
 
 		if (id < 0) {
-			id = syscalltbl__strglobmatch_first(trace->sctbl, sc, &match_next);
+			id = syscalltbl__strglobmatch_first(EM_HOST, sc, &match_next);
 			if (id >= 0)
 				goto matches;
 
@@ -2264,7 +2275,7 @@ static int trace__validate_ev_qualifier(struct trace *trace)
 			continue;
 
 		while (1) {
-			id = syscalltbl__strglobmatch_next(trace->sctbl, sc, &match_next);
+			id = syscalltbl__strglobmatch_next(EM_HOST, sc, &match_next);
 			if (id < 0)
 				break;
 			if (nr_allocated == nr_used) {
@@ -2720,6 +2731,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
 	int augmented_args_size = 0;
 	void *augmented_args = NULL;
+	/* TODO: get e_machine from thread. */
 	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
 	struct thread_trace *ttrace;
 
@@ -2794,6 +2806,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
 	struct thread_trace *ttrace;
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
+	/* TODO: get e_machine from thread. */
 	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
 	char msg[1024];
 	void *args, *augmented_args = NULL;
@@ -2869,6 +2882,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
 	struct thread *thread;
 	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0, printed = 0;
 	int alignment = trace->args_alignment;
+	/* TODO: get e_machine from thread. */
 	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
 	struct thread_trace *ttrace;
 
@@ -3222,6 +3236,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
 
 	if (evsel == trace->syscalls.events.bpf_output) {
 		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
+		/* TODO: get e_machine from thread. */
 		struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
 
 		if (sc) {
@@ -3729,9 +3744,9 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace, str
 	return trace->skel->progs.syscall_unaugmented;
 }
 
-static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
+static void trace__init_syscall_bpf_progs(struct trace *trace, int e_machine, int id)
 {
-	struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, id);
+	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
 
 	if (sc == NULL)
 		return;
@@ -3740,22 +3755,22 @@ static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
 	sc->bpf_prog.sys_exit  = trace__find_syscall_bpf_prog(trace, sc, sc->fmt ? sc->fmt->bpf_prog_name.sys_exit  : NULL,  "exit");
 }
 
-static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int id)
+static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int e_machine, int id)
 {
-	struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, id);
+	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
 	return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) : bpf_program__fd(trace->skel->progs.syscall_unaugmented);
 }
 
-static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
+static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int e_machine, int id)
 {
-	struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, id);
+	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
 	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(trace->skel->progs.syscall_unaugmented);
 }
 
-static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int key, unsigned int *beauty_array)
+static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, int key, unsigned int *beauty_array)
 {
 	struct tep_format_field *field;
-	struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, key);
+	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, key);
 	const struct btf_type *bt;
 	char *struct_offset, *tmp, name[32];
 	bool can_augment = false;
@@ -3851,9 +3866,9 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 	return NULL;
 
 try_to_find_pair:
-	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
-		int id = syscalltbl__id_at_idx(trace->sctbl, i);
-		struct syscall *pair = trace__syscall_info(trace, NULL, EM_HOST, id);
+	for (int i = 0, num_idx = syscalltbl__num_idx(sc->e_machine); i < num_idx; ++i) {
+		int id = syscalltbl__id_at_idx(sc->e_machine, i);
+		struct syscall *pair = trace__syscall_info(trace, NULL, sc->e_machine, id);
 		struct bpf_program *pair_prog;
 		bool is_candidate = false;
 
@@ -3937,7 +3952,7 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
 	return NULL;
 }
 
-static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
+static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_machine)
 {
 	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
 	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
@@ -3945,27 +3960,27 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 	int err = 0;
 	unsigned int beauty_array[6];
 
-	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
-		int prog_fd, key = syscalltbl__id_at_idx(trace->sctbl, i);
+	for (int i = 0, num_idx = syscalltbl__num_idx(e_machine); i < num_idx; ++i) {
+		int prog_fd, key = syscalltbl__id_at_idx(e_machine, i);
 
 		if (!trace__syscall_enabled(trace, key))
 			continue;
 
-		trace__init_syscall_bpf_progs(trace, key);
+		trace__init_syscall_bpf_progs(trace, e_machine, key);
 
 		// It'll get at least the "!raw_syscalls:unaugmented"
-		prog_fd = trace__bpf_prog_sys_enter_fd(trace, key);
+		prog_fd = trace__bpf_prog_sys_enter_fd(trace, e_machine, key);
 		err = bpf_map_update_elem(map_enter_fd, &key, &prog_fd, BPF_ANY);
 		if (err)
 			break;
-		prog_fd = trace__bpf_prog_sys_exit_fd(trace, key);
+		prog_fd = trace__bpf_prog_sys_exit_fd(trace, e_machine, key);
 		err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
 		if (err)
 			break;
 
 		/* use beauty_map to tell BPF how many bytes to collect, set beauty_map's value here */
 		memset(beauty_array, 0, sizeof(beauty_array));
-		err = trace__bpf_sys_enter_beauty_map(trace, key, (unsigned int *)beauty_array);
+		err = trace__bpf_sys_enter_beauty_map(trace, e_machine, key, (unsigned int *)beauty_array);
 		if (err)
 			continue;
 		err = bpf_map_update_elem(beauty_map_fd, &key, beauty_array, BPF_ANY);
@@ -4001,9 +4016,9 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
 	 * first and second arg (this one on the raw_syscalls:sys_exit prog
 	 * array tail call, then that one will be used.
 	 */
-	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
-		int key = syscalltbl__id_at_idx(trace->sctbl, i);
-		struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, key);
+	for (int i = 0, num_idx = syscalltbl__num_idx(e_machine); i < num_idx; ++i) {
+		int key = syscalltbl__id_at_idx(e_machine, i);
+		struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, key);
 		struct bpf_program *pair_prog;
 		int prog_fd;
 
@@ -4449,8 +4464,13 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 		goto out_error_mem;
 
 #ifdef HAVE_BPF_SKEL
-	if (trace->skel && trace->skel->progs.sys_enter)
-		trace__init_syscalls_bpf_prog_array_maps(trace);
+	if (trace->skel && trace->skel->progs.sys_enter) {
+		/*
+		 * TODO: Initialize for all host binary machine types, not just
+		 * those matching the perf binary.
+		 */
+		trace__init_syscalls_bpf_prog_array_maps(trace, EM_HOST);
+	}
 #endif
 
 	if (trace->ev_qualifier_ids.nr > 0) {
@@ -4475,7 +4495,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 	 *  So just disable this beautifier (SCA_FD, SCA_FDAT) when 'close' is
 	 *  not in use.
 	 */
-	trace->fd_path_disabled = !trace__syscall_enabled(trace, syscalltbl__id(trace->sctbl, "close"));
+	/* TODO: support for more than just perf binary machine type close. */
+	trace->fd_path_disabled = !trace__syscall_enabled(trace, syscalltbl__id(EM_HOST, "close"));
 
 	err = trace__expand_filters(trace, &evsel);
 	if (err)
@@ -4788,7 +4809,7 @@ static struct syscall_entry *syscall__sort_stats(struct hashmap *syscall_stats)
 	return entry;
 }
 
-static size_t syscall__dump_stats(struct trace *trace, FILE *fp,
+static size_t syscall__dump_stats(struct trace *trace, int e_machine, FILE *fp,
 				  struct hashmap *syscall_stats)
 {
 	size_t printed = 0;
@@ -4819,7 +4840,7 @@ static size_t syscall__dump_stats(struct trace *trace, FILE *fp,
 			pct = avg ? 100.0 * stddev_stats(&stats->stats) / avg : 0.0;
 			avg /= NSEC_PER_MSEC;
 
-			sc = trace__syscall_info(trace, /*evsel=*/NULL, EM_HOST, entry->syscall);
+			sc = trace__syscall_info(trace, /*evsel=*/NULL, e_machine, entry->syscall);
 			if (!sc)
 				continue;
 
@@ -4846,14 +4867,14 @@ static size_t syscall__dump_stats(struct trace *trace, FILE *fp,
 }
 
 static size_t thread__dump_stats(struct thread_trace *ttrace,
-				 struct trace *trace, FILE *fp)
+				 struct trace *trace, int e_machine, FILE *fp)
 {
-	return syscall__dump_stats(trace, fp, ttrace->syscall_stats);
+	return syscall__dump_stats(trace, e_machine, fp, ttrace->syscall_stats);
 }
 
-static size_t system__dump_stats(struct trace *trace, FILE *fp)
+static size_t system__dump_stats(struct trace *trace, int e_machine, FILE *fp)
 {
-	return syscall__dump_stats(trace, fp, trace->syscall_stats);
+	return syscall__dump_stats(trace, e_machine, fp, trace->syscall_stats);
 }
 
 static size_t trace__fprintf_thread(FILE *fp, struct thread *thread, struct trace *trace)
@@ -4879,7 +4900,8 @@ static size_t trace__fprintf_thread(FILE *fp, struct thread *thread, struct trac
 	else if (fputc('\n', fp) != EOF)
 		++printed;
 
-	printed += thread__dump_stats(ttrace, trace, fp);
+	/* TODO: get e_machine from thread. */
+	printed += thread__dump_stats(ttrace, trace, EM_HOST, fp);
 
 	return printed;
 }
@@ -4940,7 +4962,8 @@ static size_t trace__fprintf_total_summary(struct trace *trace, FILE *fp)
 	else if (fputc('\n', fp) != EOF)
 		++printed;
 
-	printed += system__dump_stats(trace, fp);
+	/* TODO: get all system e_machines. */
+	printed += system__dump_stats(trace, EM_HOST, fp);
 
 	return printed;
 }
@@ -5132,8 +5155,9 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
 			*sep = '\0';
 
 		list = 0;
-		if (syscalltbl__id(trace->sctbl, s) >= 0 ||
-		    syscalltbl__strglobmatch_first(trace->sctbl, s, &idx) >= 0) {
+		/* TODO: support for more than just perf binary machine type syscalls. */
+		if (syscalltbl__id(EM_HOST, s) >= 0 ||
+		    syscalltbl__strglobmatch_first(EM_HOST, s, &idx) >= 0) {
 			list = 1;
 			goto do_concat;
 		}
@@ -5286,7 +5310,6 @@ static void trace__exit(struct trace *trace)
 			syscall__exit(&trace->syscalls.table[i]);
 		zfree(&trace->syscalls.table);
 	}
-	syscalltbl__delete(trace->sctbl);
 	zfree(&trace->perfconfig_events);
 }
 
@@ -5435,9 +5458,8 @@ int cmd_trace(int argc, const char **argv)
 	sigaction(SIGCHLD, &sigchld_act, NULL);
 
 	trace.evlist = evlist__new();
-	trace.sctbl = syscalltbl__new();
 
-	if (trace.evlist == NULL || trace.sctbl == NULL) {
+	if (trace.evlist == NULL) {
 		pr_err("Not enough memory to run!\n");
 		err = -ENOMEM;
 		goto out;
diff --git a/tools/perf/scripts/syscalltbl.sh b/tools/perf/scripts/syscalltbl.sh
index 1ce0d5aa8b50..a39b3013b103 100755
--- a/tools/perf/scripts/syscalltbl.sh
+++ b/tools/perf/scripts/syscalltbl.sh
@@ -50,37 +50,27 @@ fi
 infile="$1"
 outfile="$2"
 
-nxt=0
-
-syscall_macro() {
-    nr="$1"
-    name="$2"
-
-    echo "	[$nr] = \"$name\","
-}
-
-emit() {
-    nr="$1"
-    entry="$2"
-
-    syscall_macro "$nr" "$entry"
-}
-
-echo "static const char *const syscalltbl[] = {" > $outfile
-
 sorted_table=$(mktemp /tmp/syscalltbl.XXXXXX)
 grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | sort -n > $sorted_table
 
-max_nr=0
+echo "static const char *const syscall_num_to_name[] = {" > $outfile
 # the params are: nr abi name entry compat
 # use _ for intentionally unused variables according to SC2034
 while read nr _ name _ _; do
-    emit "$nr" "$name" >> $outfile
-    max_nr=$nr
+	echo "	[$nr] = \"$name\"," >> $outfile
 done < $sorted_table
+echo "};" >> $outfile
 
-rm -f $sorted_table
+echo "static const uint16_t syscall_sorted_names[] = {" >> $outfile
 
+# When sorting by name, add a suffix of 0s upto 20 characters so that system
+# calls that differ with a numerical suffix don't sort before those
+# without. This default behavior of sort differs from that of strcmp used at
+# runtime. Use sed to strip the trailing 0s suffix afterwards.
+grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | awk '{printf $3; for (i = length($3); i < 20; i++) { printf "0"; }; print " " $1}'| sort | sed 's/\([a-zA-Z1-9]\+\)0\+ \([0-9]\+\)/\1 \2/' > $sorted_table
+while read name nr; do
+	echo "	$nr,	/* $name */" >> $outfile
+done < $sorted_table
 echo "};" >> $outfile
 
-echo "#define SYSCALLTBL_MAX_ID ${max_nr}" >> $outfile
+rm -f $sorted_table
diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index 2f76241494c8..760ac4d0869f 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <asm/bitsperlong.h>
 #include <linux/compiler.h>
+#include <linux/kernel.h>
 #include <linux/zalloc.h>
 
 #include <string.h>
@@ -20,112 +21,66 @@
   #include <asm/syscalls_32.h>
 #endif
 
-const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;
-static const char *const *syscalltbl_native = syscalltbl;
+const char *syscalltbl__name(int e_machine __maybe_unused, int id)
+{
+	if (id >= 0 && id <= (int)ARRAY_SIZE(syscall_num_to_name))
+		return syscall_num_to_name[id];
+	return NULL;
+}
 
-struct syscall {
-	int id;
+struct syscall_cmp_key {
 	const char *name;
+	const char *const *tbl;
 };
 
 static int syscallcmpname(const void *vkey, const void *ventry)
 {
-	const char *key = vkey;
-	const struct syscall *entry = ventry;
+	const struct syscall_cmp_key *key = vkey;
+	const uint16_t *entry = ventry;
 
-	return strcmp(key, entry->name);
+	return strcmp(key->name, key->tbl[*entry]);
 }
 
-static int syscallcmp(const void *va, const void *vb)
+int syscalltbl__id(int e_machine __maybe_unused, const char *name)
 {
-	const struct syscall *a = va, *b = vb;
-
-	return strcmp(a->name, b->name);
+	struct syscall_cmp_key key = {
+		.name = name,
+		.tbl = syscall_num_to_name,
+	};
+	const int *id = bsearch(&key, syscall_sorted_names,
+				ARRAY_SIZE(syscall_sorted_names),
+				sizeof(syscall_sorted_names[0]),
+				syscallcmpname);
+
+	return id ? *id : -1;
 }
 
-static int syscalltbl__init_native(struct syscalltbl *tbl)
+int syscalltbl__num_idx(int e_machine __maybe_unused)
 {
-	int nr_entries = 0, i, j;
-	struct syscall *entries;
-
-	for (i = 0; i <= syscalltbl_native_max_id; ++i)
-		if (syscalltbl_native[i])
-			++nr_entries;
-
-	entries = tbl->syscalls.entries = malloc(sizeof(struct syscall) * nr_entries);
-	if (tbl->syscalls.entries == NULL)
-		return -1;
-
-	for (i = 0, j = 0; i <= syscalltbl_native_max_id; ++i) {
-		if (syscalltbl_native[i]) {
-			entries[j].name = syscalltbl_native[i];
-			entries[j].id = i;
-			++j;
-		}
-	}
-
-	qsort(tbl->syscalls.entries, nr_entries, sizeof(struct syscall), syscallcmp);
-	tbl->syscalls.nr_entries = nr_entries;
-	tbl->syscalls.max_id	 = syscalltbl_native_max_id;
-	return 0;
+	return ARRAY_SIZE(syscall_sorted_names);
 }
 
-struct syscalltbl *syscalltbl__new(void)
+int syscalltbl__id_at_idx(int e_machine __maybe_unused, int idx)
 {
-	struct syscalltbl *tbl = malloc(sizeof(*tbl));
-	if (tbl) {
-		if (syscalltbl__init_native(tbl)) {
-			free(tbl);
-			return NULL;
-		}
-	}
-	return tbl;
-}
-
-void syscalltbl__delete(struct syscalltbl *tbl)
-{
-	zfree(&tbl->syscalls.entries);
-	free(tbl);
-}
-
-const char *syscalltbl__name(const struct syscalltbl *tbl __maybe_unused, int id)
-{
-	return id <= syscalltbl_native_max_id ? syscalltbl_native[id]: NULL;
-}
-
-int syscalltbl__id(struct syscalltbl *tbl, const char *name)
-{
-	struct syscall *sc = bsearch(name, tbl->syscalls.entries,
-				     tbl->syscalls.nr_entries, sizeof(*sc),
-				     syscallcmpname);
-
-	return sc ? sc->id : -1;
-}
-
-int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx)
-{
-	struct syscall *syscalls = tbl->syscalls.entries;
-
-	return idx < tbl->syscalls.nr_entries ? syscalls[idx].id : -1;
+	return syscall_sorted_names[idx];
 }
 
-int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *syscall_glob, int *idx)
+int syscalltbl__strglobmatch_next(int e_machine __maybe_unused, const char *syscall_glob, int *idx)
 {
-	int i;
-	struct syscall *syscalls = tbl->syscalls.entries;
+	for (int i = *idx + 1; i < (int)ARRAY_SIZE(syscall_sorted_names); ++i) {
+		const char *name = syscall_num_to_name[syscall_sorted_names[i]];
 
-	for (i = *idx + 1; i < tbl->syscalls.nr_entries; ++i) {
-		if (strglobmatch(syscalls[i].name, syscall_glob)) {
+		if (strglobmatch(name, syscall_glob)) {
 			*idx = i;
-			return syscalls[i].id;
+			return syscall_sorted_names[i];
 		}
 	}
 
 	return -1;
 }
 
-int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_glob, int *idx)
+int syscalltbl__strglobmatch_first(int e_machine, const char *syscall_glob, int *idx)
 {
 	*idx = -1;
-	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
+	return syscalltbl__strglobmatch_next(e_machine, syscall_glob, idx);
 }
diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.h
index 362411a6d849..2bb628eff367 100644
--- a/tools/perf/util/syscalltbl.h
+++ b/tools/perf/util/syscalltbl.h
@@ -2,22 +2,12 @@
 #ifndef __PERF_SYSCALLTBL_H
 #define __PERF_SYSCALLTBL_H
 
-struct syscalltbl {
-	struct {
-		int max_id;
-		int nr_entries;
-		void *entries;
-	} syscalls;
-};
+const char *syscalltbl__name(int e_machine, int id);
+int syscalltbl__id(int e_machine, const char *name);
+int syscalltbl__num_idx(int e_machine);
+int syscalltbl__id_at_idx(int e_machine, int idx);
 
-struct syscalltbl *syscalltbl__new(void);
-void syscalltbl__delete(struct syscalltbl *tbl);
-
-const char *syscalltbl__name(const struct syscalltbl *tbl, int id);
-int syscalltbl__id(struct syscalltbl *tbl, const char *name);
-int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx);
-
-int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_glob, int *idx);
-int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *syscall_glob, int *idx);
+int syscalltbl__strglobmatch_first(int e_machine, const char *syscall_glob, int *idx);
+int syscalltbl__strglobmatch_next(int e_machine, const char *syscall_glob, int *idx);
 
 #endif /* __PERF_SYSCALLTBL_H */
-- 
2.48.1.711.g2feabab25a-goog


