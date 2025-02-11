Return-Path: <linux-csky+bounces-1769-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F600A2FEF9
	for <lists+linux-csky@lfdr.de>; Tue, 11 Feb 2025 01:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417DE3A6890
	for <lists+linux-csky@lfdr.de>; Tue, 11 Feb 2025 00:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A03D3594D;
	Tue, 11 Feb 2025 00:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="XhMA8iDC"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16609191
	for <linux-csky@vger.kernel.org>; Tue, 11 Feb 2025 00:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233162; cv=none; b=cQ6VYuA4Vazk2H3uaq1ILwg3aehJMSglgEJKxa75JjLj9wq0zX9w+arRBdncxn0UXEefRTmMdCGSEDjaeIowh0aCfL1FYy719bqSJHRuKDFT1Ddooy1+Mxi+SM+psVmG2XWVmUlfRElyEawVlKZ1AdtN2WRPqnxhHIHxXrylYDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233162; c=relaxed/simple;
	bh=kn+Sr6kCAYGRQcSnadYblds5EWpA8xcU3C1dAdFoBtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7zg7iWnlwTRENojv6Wzw7ZRulZij8TSeYXAAKGhDRow9M0BYX0tgb+jfthMh1Z+pOgjKFdcAW0UWU5D1hjF/gNFHsSL4rGJeciGSv4dU454rB5ETIgEpMr6ehr9mVeq/q8odES8m7B6KwzGsJ5UJ5DPuV/WfoVr4802w+i8PSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=XhMA8iDC; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e5b1c4d14f2so4293743276.0
        for <linux-csky@vger.kernel.org>; Mon, 10 Feb 2025 16:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739233159; x=1739837959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nQH+0Qh0rnKhtt4PSdvbu7QNB9jBjNqn7by0vbd3PTY=;
        b=XhMA8iDCLXQFsZxFMSn6gBRpLkAfW4xv0IOrQHmCxSiv6JdG4E3yE3uNZY8HGxfBe8
         rMuRNngG1fECLqiYVuDf9ZnOMS9zFXL1LjiulavuLdloQVfnkSNb3VJICTm+ZYuPQYho
         pPjJk7bFCkmv+ybpynxkR9qUmzSvGf2WVuGpFFXAAm4C1q5YxZ6HUcrcgWLZseeVIHfO
         kR4DVUxjAbhdzUjo1Z2/tb+/ozwWec/tD2wmdSVoIobr4hV48g9LbjjA++y0HDeYuPjd
         LXUuVgOD64sSS3jzng32VqhzoSlp0MApUBy7tJSgLakuuc7tYwNPfElohF44shW7bolw
         RzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739233159; x=1739837959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQH+0Qh0rnKhtt4PSdvbu7QNB9jBjNqn7by0vbd3PTY=;
        b=KsqMwude1aqLFxY9eiAuwy0uSGWaviAv6IKwidCYoKQOQ+vhr1JHz1Sl8o3vVaxJtn
         YjySVlHgugEWy7MsJNFhaxVpB3oaZWxL29DJWTP5osHH493FSYtqzEyy7oQxjUkq0anO
         1HZG6RgPvmWZs4Gk61hNwEt6fa/dWMhkyg6vboT2G2zHcjrpY2dmEcWIxmkMa6xLsVqn
         zgUIjNP/drvsjuEhTfqalNQOSRNT0PZzt4TPAqbhjtbsOnNlCb6MXrnMpFDqHn5vCGPX
         E1zG5FjHQJfBdjIBcOt7IQdJYaJY7SINyY9ibMjw9a3KKejijSorUuwJqgTUNJLmR6e+
         G+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy236e6JK0cUfd4vbt3dagpkxINUPBvEYQ7UCbfPikbYOW52f8n4PQX7n0cFK8ih7gd0m7N4yIVXJZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzhyeA9uZ9nhEMK2NUoQQu3dd4fPXeaY5ssYqKxbKlU33nEK9Uv
	EYxpFT2PybD7HyUCaO0FJWhQoG57yDwBvcPzgLT11F0t+ArROflnsYJAhaGQ9SE=
X-Gm-Gg: ASbGncuzd1qyY6n5AmGiGCKQ+DmFXMTGVRNYHyJElUh9PX0C0DW3xxDrvGqPIJK1S/B
	DKVeMnxHn3i6wrosWucKrWj9d83yYLal3zSCGSb2I46fFWJuphaoeCiGsOrVTAa6q3TrBabEI2Y
	5U9hhgQP4lynE186oksz5UQdkUsBXDF2TNhScPIsIWUVK/vB6i4xiRmbJXMNTEmvuHdwdA0R6cQ
	KOjeTcGa6KALCte1QNU5uiUn1+kSAdchKECWgEljiDrS8gC0eAhOb16hN3KeUCj3Vf0WODK/QlS
	ir4=
X-Google-Smtp-Source: AGHT+IGPbgKa18+z0Y5luTA3UrvUForoahUWDzZX1uYQaimd+qV82fPmZSfXut2G/H+aYq7dTWhb6w==
X-Received: by 2002:a05:6902:2783:b0:e5b:f5f:5960 with SMTP id 3f1490d57ef6-e5b461662f3mr14051088276.1.1739233158865;
        Mon, 10 Feb 2025 16:19:18 -0800 (PST)
Received: from ghost ([50.146.0.9])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e5b3a1f3602sm2912785276.12.2025.02.10.16.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 16:19:17 -0800 (PST)
Date: Mon, 10 Feb 2025 16:19:16 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Guo Ren <guoren@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Bibo Mao <maobibo@loongson.cn>,
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 3/7] perf syscalltbl: Remove struct syscalltbl
Message-ID: <Z6qXhAzN2uJPMiTf@ghost>
References: <20250210165108.95894-1-irogers@google.com>
 <20250210165108.95894-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210165108.95894-4-irogers@google.com>

On Mon, Feb 10, 2025 at 08:51:04AM -0800, Ian Rogers wrote:
> The syscalltbl held entries of system call name and number pairs,
> generated from a native syscalltbl at start up. As there are gaps in
> the system call number there is a notion of index into the
> table. Going forward we want the system call table to be identifiable
> by a machine type, for example, i386 vs x86-64. Change the interface
> to the syscalltbl so (1) a (currently unused machine type of EM_HOST)
> is passed (2) the index to syscall number and system call name mapping
> is computed at build time.
> 
> Two tables are used for this, an array of system call number to name,
> an array of system call numbers sorted by the system call name. The
> sorted array doesn't store strings in part to save memory and
> relocations. The index notion is carried forward and is an index into
> the sorted array of system call numbers, the data structures are
> opaque (held only in syscalltbl.c), and so the number of indices for a
> machine type is exposed as a new API.
> 
> The arrays are computed in the syscalltbl.sh script and so no start-up
> time computation and storage is necessary.

Thank you for also generating the sorted table, that is a very nice
addition.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/builtin-trace.c       |  88 +++++++++++++-----------
>  tools/perf/scripts/syscalltbl.sh |  36 ++++------
>  tools/perf/util/syscalltbl.c     | 113 ++++++++++---------------------
>  tools/perf/util/syscalltbl.h     |  22 ++----
>  4 files changed, 103 insertions(+), 156 deletions(-)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 916a51df236b..4b77c2ab3dba 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -143,7 +143,6 @@ struct syscall_fmt {
>  
>  struct trace {
>  	struct perf_tool	tool;
> -	struct syscalltbl	*sctbl;
>  	struct {
>  		/** Sorted sycall numbers used by the trace. */
>  		struct syscall  *table;
> @@ -2100,7 +2099,7 @@ static int syscall__read_info(struct syscall *sc, struct trace *trace)
>  		return 0;
>  	}
>  
> -	name = syscalltbl__name(trace->sctbl, sc->id);
> +	name = syscalltbl__name(sc->e_machine, sc->id);
>  	if (name == NULL) {
>  		sc->nonexistent = true;
>  		return -EEXIST;
> @@ -2200,10 +2199,14 @@ static int trace__validate_ev_qualifier(struct trace *trace)
>  
>  	strlist__for_each_entry(pos, trace->ev_qualifier) {
>  		const char *sc = pos->s;
> -		int id = syscalltbl__id(trace->sctbl, sc), match_next = -1;
> +		/*
> +		 * TODO: Assume more than the validation/warnings are all for
> +		 * the same binary type as perf.
> +		 */
> +		int id = syscalltbl__id(EM_HOST, sc), match_next = -1;
>  
>  		if (id < 0) {
> -			id = syscalltbl__strglobmatch_first(trace->sctbl, sc, &match_next);
> +			id = syscalltbl__strglobmatch_first(EM_HOST, sc, &match_next);
>  			if (id >= 0)
>  				goto matches;
>  
> @@ -2223,7 +2226,7 @@ static int trace__validate_ev_qualifier(struct trace *trace)
>  			continue;
>  
>  		while (1) {
> -			id = syscalltbl__strglobmatch_next(trace->sctbl, sc, &match_next);
> +			id = syscalltbl__strglobmatch_next(EM_HOST, sc, &match_next);
>  			if (id < 0)
>  				break;
>  			if (nr_allocated == nr_used) {
> @@ -2677,6 +2680,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
>  	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
>  	int augmented_args_size = 0;
>  	void *augmented_args = NULL;
> +	/* TODO: get e_machine from thread. */
>  	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
>  	struct thread_trace *ttrace;
>  
> @@ -2751,6 +2755,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
>  	struct thread_trace *ttrace;
>  	struct thread *thread;
>  	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
> +	/* TODO: get e_machine from thread. */
>  	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
>  	char msg[1024];
>  	void *args, *augmented_args = NULL;
> @@ -2826,6 +2831,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
>  	struct thread *thread;
>  	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0, printed = 0;
>  	int alignment = trace->args_alignment;
> +	/* TODO: get e_machine from thread. */
>  	struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
>  	struct thread_trace *ttrace;
>  
> @@ -3179,6 +3185,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
>  
>  	if (evsel == trace->syscalls.events.bpf_output) {
>  		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
> +		/* TODO: get e_machine from thread. */
>  		struct syscall *sc = trace__syscall_info(trace, evsel, EM_HOST, id);
>  
>  		if (sc) {
> @@ -3682,9 +3689,9 @@ static struct bpf_program *trace__find_syscall_bpf_prog(struct trace *trace, str
>  	return trace->skel->progs.syscall_unaugmented;
>  }
>  
> -static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
> +static void trace__init_syscall_bpf_progs(struct trace *trace, int e_machine, int id)
>  {
> -	struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, id);
> +	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
>  
>  	if (sc == NULL)
>  		return;
> @@ -3693,22 +3700,22 @@ static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
>  	sc->bpf_prog.sys_exit  = trace__find_syscall_bpf_prog(trace, sc, sc->fmt ? sc->fmt->bpf_prog_name.sys_exit  : NULL,  "exit");
>  }
>  
> -static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int id)
> +static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int e_machine, int id)
>  {
> -	struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, id);
> +	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
>  	return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) : bpf_program__fd(trace->skel->progs.syscall_unaugmented);
>  }
>  
> -static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
> +static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int e_machine, int id)
>  {
> -	struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, id);
> +	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, id);
>  	return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_program__fd(trace->skel->progs.syscall_unaugmented);
>  }
>  
> -static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int key, unsigned int *beauty_array)
> +static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_machine, int key, unsigned int *beauty_array)
>  {
>  	struct tep_format_field *field;
> -	struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, key);
> +	struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, key);
>  	const struct btf_type *bt;
>  	char *struct_offset, *tmp, name[32];
>  	bool can_augment = false;
> @@ -3804,9 +3811,9 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
>  	return NULL;
>  
>  try_to_find_pair:
> -	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
> -		int id = syscalltbl__id_at_idx(trace->sctbl, i);
> -		struct syscall *pair = trace__syscall_info(trace, NULL, EM_HOST, id);
> +	for (int i = 0, num_idx = syscalltbl__num_idx(sc->e_machine); i < num_idx; ++i) {
> +		int id = syscalltbl__id_at_idx(sc->e_machine, i);
> +		struct syscall *pair = trace__syscall_info(trace, NULL, sc->e_machine, id);
>  		struct bpf_program *pair_prog;
>  		bool is_candidate = false;
>  
> @@ -3890,7 +3897,7 @@ static struct bpf_program *trace__find_usable_bpf_prog_entry(struct trace *trace
>  	return NULL;
>  }
>  
> -static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
> +static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace, int e_machine)
>  {
>  	int map_enter_fd = bpf_map__fd(trace->skel->maps.syscalls_sys_enter);
>  	int map_exit_fd  = bpf_map__fd(trace->skel->maps.syscalls_sys_exit);
> @@ -3898,27 +3905,27 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
>  	int err = 0;
>  	unsigned int beauty_array[6];
>  
> -	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
> -		int prog_fd, key = syscalltbl__id_at_idx(trace->sctbl, i);
> +	for (int i = 0, num_idx = syscalltbl__num_idx(e_machine); i < num_idx; ++i) {
> +		int prog_fd, key = syscalltbl__id_at_idx(e_machine, i);
>  
>  		if (!trace__syscall_enabled(trace, key))
>  			continue;
>  
> -		trace__init_syscall_bpf_progs(trace, key);
> +		trace__init_syscall_bpf_progs(trace, e_machine, key);
>  
>  		// It'll get at least the "!raw_syscalls:unaugmented"
> -		prog_fd = trace__bpf_prog_sys_enter_fd(trace, key);
> +		prog_fd = trace__bpf_prog_sys_enter_fd(trace, e_machine, key);
>  		err = bpf_map_update_elem(map_enter_fd, &key, &prog_fd, BPF_ANY);
>  		if (err)
>  			break;
> -		prog_fd = trace__bpf_prog_sys_exit_fd(trace, key);
> +		prog_fd = trace__bpf_prog_sys_exit_fd(trace, e_machine, key);
>  		err = bpf_map_update_elem(map_exit_fd, &key, &prog_fd, BPF_ANY);
>  		if (err)
>  			break;
>  
>  		/* use beauty_map to tell BPF how many bytes to collect, set beauty_map's value here */
>  		memset(beauty_array, 0, sizeof(beauty_array));
> -		err = trace__bpf_sys_enter_beauty_map(trace, key, (unsigned int *)beauty_array);
> +		err = trace__bpf_sys_enter_beauty_map(trace, e_machine, key, (unsigned int *)beauty_array);
>  		if (err)
>  			continue;
>  		err = bpf_map_update_elem(beauty_map_fd, &key, beauty_array, BPF_ANY);
> @@ -3954,9 +3961,9 @@ static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trace)
>  	 * first and second arg (this one on the raw_syscalls:sys_exit prog
>  	 * array tail call, then that one will be used.
>  	 */
> -	for (int i = 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
> -		int key = syscalltbl__id_at_idx(trace->sctbl, i);
> -		struct syscall *sc = trace__syscall_info(trace, NULL, EM_HOST, key);
> +	for (int i = 0, num_idx = syscalltbl__num_idx(e_machine); i < num_idx; ++i) {
> +		int key = syscalltbl__id_at_idx(e_machine, i);
> +		struct syscall *sc = trace__syscall_info(trace, NULL, e_machine, key);
>  		struct bpf_program *pair_prog;
>  		int prog_fd;
>  
> @@ -4393,8 +4400,13 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  		goto out_error_mem;
>  
>  #ifdef HAVE_BPF_SKEL
> -	if (trace->skel && trace->skel->progs.sys_enter)
> -		trace__init_syscalls_bpf_prog_array_maps(trace);
> +	if (trace->skel && trace->skel->progs.sys_enter) {
> +		/*
> +		 * TODO: Initialize for all host binary machine types, not just
> +		 * those matching the perf binary.
> +		 */
> +		trace__init_syscalls_bpf_prog_array_maps(trace, EM_HOST);
> +	}
>  #endif
>  
>  	if (trace->ev_qualifier_ids.nr > 0) {
> @@ -4419,7 +4431,8 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
>  	 *  So just disable this beautifier (SCA_FD, SCA_FDAT) when 'close' is
>  	 *  not in use.
>  	 */
> -	trace->fd_path_disabled = !trace__syscall_enabled(trace, syscalltbl__id(trace->sctbl, "close"));
> +	/* TODO: support for more than just perf binary machine type close. */
> +	trace->fd_path_disabled = !trace__syscall_enabled(trace, syscalltbl__id(EM_HOST, "close"));
>  
>  	err = trace__expand_filters(trace, &evsel);
>  	if (err)
> @@ -4692,8 +4705,7 @@ DEFINE_RESORT_RB(syscall_stats, a->msecs > b->msecs,
>  	entry->msecs   = stats ? (u64)stats->stats.n * (avg_stats(&stats->stats) / NSEC_PER_MSEC) : 0;
>  }
>  
> -static size_t thread__dump_stats(struct thread_trace *ttrace,
> -				 struct trace *trace, FILE *fp)
> +static size_t thread__dump_stats(struct thread_trace *ttrace, struct trace *trace, int e_machine, FILE *fp)
>  {
>  	size_t printed = 0;
>  	struct syscall *sc;
> @@ -4721,7 +4733,7 @@ static size_t thread__dump_stats(struct thread_trace *ttrace,
>  			pct = avg ? 100.0 * stddev_stats(&stats->stats) / avg : 0.0;
>  			avg /= NSEC_PER_MSEC;
>  
> -			sc = trace__syscall_info(trace, /*evsel=*/NULL, EM_HOST,
> +			sc = trace__syscall_info(trace, /*evsel=*/NULL, e_machine,
>  						 syscall_stats_entry->syscall);
>  			if (!sc)
>  				continue;
> @@ -4771,7 +4783,8 @@ static size_t trace__fprintf_thread(FILE *fp, struct thread *thread, struct trac
>  	else if (fputc('\n', fp) != EOF)
>  		++printed;
>  
> -	printed += thread__dump_stats(ttrace, trace, fp);
> +	/* TODO: get e_machine from thread. */
> +	printed += thread__dump_stats(ttrace, trace, EM_HOST, fp);
>  
>  	return printed;
>  }
> @@ -5003,8 +5016,9 @@ static int trace__parse_events_option(const struct option *opt, const char *str,
>  			*sep = '\0';
>  
>  		list = 0;
> -		if (syscalltbl__id(trace->sctbl, s) >= 0 ||
> -		    syscalltbl__strglobmatch_first(trace->sctbl, s, &idx) >= 0) {
> +		/* TODO: support for more than just perf binary machine type syscalls. */
> +		if (syscalltbl__id(EM_HOST, s) >= 0 ||
> +		    syscalltbl__strglobmatch_first(EM_HOST, s, &idx) >= 0) {
>  			list = 1;
>  			goto do_concat;
>  		}
> @@ -5140,7 +5154,6 @@ static void trace__exit(struct trace *trace)
>  			syscall__exit(&trace->syscalls.table[i]);
>  		zfree(&trace->syscalls.table);
>  	}
> -	syscalltbl__delete(trace->sctbl);
>  	zfree(&trace->perfconfig_events);
>  }
>  
> @@ -5286,9 +5299,8 @@ int cmd_trace(int argc, const char **argv)
>  	sigaction(SIGCHLD, &sigchld_act, NULL);
>  
>  	trace.evlist = evlist__new();
> -	trace.sctbl = syscalltbl__new();
>  
> -	if (trace.evlist == NULL || trace.sctbl == NULL) {
> +	if (trace.evlist == NULL) {
>  		pr_err("Not enough memory to run!\n");
>  		err = -ENOMEM;
>  		goto out;
> diff --git a/tools/perf/scripts/syscalltbl.sh b/tools/perf/scripts/syscalltbl.sh
> index 1ce0d5aa8b50..a39b3013b103 100755
> --- a/tools/perf/scripts/syscalltbl.sh
> +++ b/tools/perf/scripts/syscalltbl.sh
> @@ -50,37 +50,27 @@ fi
>  infile="$1"
>  outfile="$2"
>  
> -nxt=0
> -
> -syscall_macro() {
> -    nr="$1"
> -    name="$2"
> -
> -    echo "	[$nr] = \"$name\","
> -}
> -
> -emit() {
> -    nr="$1"
> -    entry="$2"
> -
> -    syscall_macro "$nr" "$entry"
> -}
> -
> -echo "static const char *const syscalltbl[] = {" > $outfile
> -
>  sorted_table=$(mktemp /tmp/syscalltbl.XXXXXX)
>  grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | sort -n > $sorted_table
>  
> -max_nr=0
> +echo "static const char *const syscall_num_to_name[] = {" > $outfile
>  # the params are: nr abi name entry compat
>  # use _ for intentionally unused variables according to SC2034
>  while read nr _ name _ _; do
> -    emit "$nr" "$name" >> $outfile
> -    max_nr=$nr
> +	echo "	[$nr] = \"$name\"," >> $outfile
>  done < $sorted_table
> +echo "};" >> $outfile
>  
> -rm -f $sorted_table
> +echo "static const uint16_t syscall_sorted_names[] = {" >> $outfile
>  
> +# When sorting by name, add a suffix of 0s upto 20 characters so that system
> +# calls that differ with a numerical suffix don't sort before those
> +# without. This default behavior of sort differs from that of strcmp used at
> +# runtime. Use sed to strip the trailing 0s suffix afterwards.
> +grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | awk '{printf $3; for (i = length($3); i < 20; i++) { printf "0"; }; print " " $1}'| sort | sed 's/\([a-zA-Z1-9]\+\)0\+ \([0-9]\+\)/\1 \2/' > $sorted_table
> +while read name nr; do
> +	echo "	$nr,	/* $name */" >> $outfile
> +done < $sorted_table
>  echo "};" >> $outfile
>  
> -echo "#define SYSCALLTBL_MAX_ID ${max_nr}" >> $outfile
> +rm -f $sorted_table
> diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
> index 2f76241494c8..760ac4d0869f 100644
> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -9,6 +9,7 @@
>  #include <stdlib.h>
>  #include <asm/bitsperlong.h>
>  #include <linux/compiler.h>
> +#include <linux/kernel.h>
>  #include <linux/zalloc.h>
>  
>  #include <string.h>
> @@ -20,112 +21,66 @@
>    #include <asm/syscalls_32.h>
>  #endif
>  
> -const int syscalltbl_native_max_id = SYSCALLTBL_MAX_ID;
> -static const char *const *syscalltbl_native = syscalltbl;
> +const char *syscalltbl__name(int e_machine __maybe_unused, int id)
> +{
> +	if (id >= 0 && id <= (int)ARRAY_SIZE(syscall_num_to_name))
> +		return syscall_num_to_name[id];
> +	return NULL;
> +}
>  
> -struct syscall {
> -	int id;
> +struct syscall_cmp_key {
>  	const char *name;
> +	const char *const *tbl;
>  };
>  
>  static int syscallcmpname(const void *vkey, const void *ventry)
>  {
> -	const char *key = vkey;
> -	const struct syscall *entry = ventry;
> +	const struct syscall_cmp_key *key = vkey;
> +	const uint16_t *entry = ventry;
>  
> -	return strcmp(key, entry->name);
> +	return strcmp(key->name, key->tbl[*entry]);
>  }
>  
> -static int syscallcmp(const void *va, const void *vb)
> +int syscalltbl__id(int e_machine __maybe_unused, const char *name)
>  {
> -	const struct syscall *a = va, *b = vb;
> -
> -	return strcmp(a->name, b->name);
> +	struct syscall_cmp_key key = {
> +		.name = name,
> +		.tbl = syscall_num_to_name,
> +	};
> +	const int *id = bsearch(&key, syscall_sorted_names,
> +				ARRAY_SIZE(syscall_sorted_names),
> +				sizeof(syscall_sorted_names[0]),
> +				syscallcmpname);
> +
> +	return id ? *id : -1;
>  }
>  
> -static int syscalltbl__init_native(struct syscalltbl *tbl)
> +int syscalltbl__num_idx(int e_machine __maybe_unused)
>  {
> -	int nr_entries = 0, i, j;
> -	struct syscall *entries;
> -
> -	for (i = 0; i <= syscalltbl_native_max_id; ++i)
> -		if (syscalltbl_native[i])
> -			++nr_entries;
> -
> -	entries = tbl->syscalls.entries = malloc(sizeof(struct syscall) * nr_entries);
> -	if (tbl->syscalls.entries == NULL)
> -		return -1;
> -
> -	for (i = 0, j = 0; i <= syscalltbl_native_max_id; ++i) {
> -		if (syscalltbl_native[i]) {
> -			entries[j].name = syscalltbl_native[i];
> -			entries[j].id = i;
> -			++j;
> -		}
> -	}
> -
> -	qsort(tbl->syscalls.entries, nr_entries, sizeof(struct syscall), syscallcmp);
> -	tbl->syscalls.nr_entries = nr_entries;
> -	tbl->syscalls.max_id	 = syscalltbl_native_max_id;
> -	return 0;
> +	return ARRAY_SIZE(syscall_sorted_names);
>  }
>  
> -struct syscalltbl *syscalltbl__new(void)
> +int syscalltbl__id_at_idx(int e_machine __maybe_unused, int idx)
>  {
> -	struct syscalltbl *tbl = malloc(sizeof(*tbl));
> -	if (tbl) {
> -		if (syscalltbl__init_native(tbl)) {
> -			free(tbl);
> -			return NULL;
> -		}
> -	}
> -	return tbl;
> -}
> -
> -void syscalltbl__delete(struct syscalltbl *tbl)
> -{
> -	zfree(&tbl->syscalls.entries);
> -	free(tbl);
> -}
> -
> -const char *syscalltbl__name(const struct syscalltbl *tbl __maybe_unused, int id)
> -{
> -	return id <= syscalltbl_native_max_id ? syscalltbl_native[id]: NULL;
> -}
> -
> -int syscalltbl__id(struct syscalltbl *tbl, const char *name)
> -{
> -	struct syscall *sc = bsearch(name, tbl->syscalls.entries,
> -				     tbl->syscalls.nr_entries, sizeof(*sc),
> -				     syscallcmpname);
> -
> -	return sc ? sc->id : -1;
> -}
> -
> -int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx)
> -{
> -	struct syscall *syscalls = tbl->syscalls.entries;
> -
> -	return idx < tbl->syscalls.nr_entries ? syscalls[idx].id : -1;
> +	return syscall_sorted_names[idx];
>  }
>  
> -int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *syscall_glob, int *idx)
> +int syscalltbl__strglobmatch_next(int e_machine __maybe_unused, const char *syscall_glob, int *idx)
>  {
> -	int i;
> -	struct syscall *syscalls = tbl->syscalls.entries;
> +	for (int i = *idx + 1; i < (int)ARRAY_SIZE(syscall_sorted_names); ++i) {
> +		const char *name = syscall_num_to_name[syscall_sorted_names[i]];
>  
> -	for (i = *idx + 1; i < tbl->syscalls.nr_entries; ++i) {
> -		if (strglobmatch(syscalls[i].name, syscall_glob)) {
> +		if (strglobmatch(name, syscall_glob)) {
>  			*idx = i;
> -			return syscalls[i].id;
> +			return syscall_sorted_names[i];
>  		}
>  	}
>  
>  	return -1;
>  }
>  
> -int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_glob, int *idx)
> +int syscalltbl__strglobmatch_first(int e_machine, const char *syscall_glob, int *idx)
>  {
>  	*idx = -1;
> -	return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
> +	return syscalltbl__strglobmatch_next(e_machine, syscall_glob, idx);
>  }
> diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.h
> index 362411a6d849..2bb628eff367 100644
> --- a/tools/perf/util/syscalltbl.h
> +++ b/tools/perf/util/syscalltbl.h
> @@ -2,22 +2,12 @@
>  #ifndef __PERF_SYSCALLTBL_H
>  #define __PERF_SYSCALLTBL_H
>  
> -struct syscalltbl {
> -	struct {
> -		int max_id;
> -		int nr_entries;
> -		void *entries;
> -	} syscalls;
> -};
> +const char *syscalltbl__name(int e_machine, int id);
> +int syscalltbl__id(int e_machine, const char *name);
> +int syscalltbl__num_idx(int e_machine);
> +int syscalltbl__id_at_idx(int e_machine, int idx);
>  
> -struct syscalltbl *syscalltbl__new(void);
> -void syscalltbl__delete(struct syscalltbl *tbl);
> -
> -const char *syscalltbl__name(const struct syscalltbl *tbl, int id);
> -int syscalltbl__id(struct syscalltbl *tbl, const char *name);
> -int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx);
> -
> -int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char *syscall_glob, int *idx);
> -int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *syscall_glob, int *idx);
> +int syscalltbl__strglobmatch_first(int e_machine, const char *syscall_glob, int *idx);
> +int syscalltbl__strglobmatch_next(int e_machine, const char *syscall_glob, int *idx);
>  
>  #endif /* __PERF_SYSCALLTBL_H */
> -- 
> 2.48.1.502.g6dc24dfdaf-goog
> 

