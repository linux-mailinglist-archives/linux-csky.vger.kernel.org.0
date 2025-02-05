Return-Path: <linux-csky+bounces-1749-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0B25A28385
	for <lists+linux-csky@lfdr.de>; Wed,  5 Feb 2025 06:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA1C16380D
	for <lists+linux-csky@lfdr.de>; Wed,  5 Feb 2025 05:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27E321D01D;
	Wed,  5 Feb 2025 05:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sMScZ1yZ"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B30925A638
	for <linux-csky@vger.kernel.org>; Wed,  5 Feb 2025 05:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738732201; cv=none; b=UNPoHIBkec9CoTAFl0BA8a2YQBA0HYVpIBXl24EXZrD67HLKbTS3c7c6I9HgOCma8E4tEoYdwVt/ZQPxjxHirCYqDZkqF1c+FQtKMLv8Bydc9DAGAS9i9bn1hTRMsIKfBK5Ft2lWcSFLkZVNTQBWIxr5q+DdswMP8RXXNzu3FJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738732201; c=relaxed/simple;
	bh=AJ6K3GggRFW9VIFweZfPywQUJCi8xRD/BHVIf9ccKLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bTa6cFlIPMgReqab1Eys23QE1dpsxNhzyYTzFgvg/NFwB42VTYFFsPKbcRKpfDSAUqp7WyPMGV8Y+sJSc8iTd69g/mJUyg/JMxKFcuYHZicsoMdTID7jPlkgEn55yPqZZiKgOOxg0nNid2F3qfrbQn9RB64x/HBJtiflUgbAr8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sMScZ1yZ; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so213775ab.0
        for <linux-csky@vger.kernel.org>; Tue, 04 Feb 2025 21:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738732198; x=1739336998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJTXV5yDycJv8raAF3uFNXNCVIK8L0Jn+Jz97vzfyAc=;
        b=sMScZ1yZamDaP19oYUfPO35s2v2lluXHR7wSanQGUNUdOjRBbi9ZL8RRO7DjdgyZUv
         QEIvIBp7QtaARySqA4iSY9D9ispHitWe4lQ/ZlOjVO9Pzgg8gzjY8XwGR0ujhz/KUh3g
         ynPAPiJ9V2GGXMCZ1HZh277mgIeUDArlW149hnTnq3b4T8eRj7p+JIwdMMwdEAO3os4X
         0uB5BbkSME6jxdL/o+MH5wI98eZnJGf9OAW+RE1qTigoeu9b4K6L1Nk6wlgSBkgoV4xA
         hVBE9A7beDMzceLd6FYnbM3QHBb6W1FjdM4KIBoe5YafXigccgulNuq8ymIml0zlB01L
         DEvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738732198; x=1739336998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJTXV5yDycJv8raAF3uFNXNCVIK8L0Jn+Jz97vzfyAc=;
        b=N95owhhgWXVV8g451Lt+Cu5RjhsQMA9WBXNPgi4wZvDDQjg0GjJana6BT12FMMRMBc
         YZu3zWJCP6vxi06A+ncJcnyHooqlyLZoiEpb+GyVO9Lz2oZz84LfTmypwRz0oDfeoMvn
         9SGV6b/qHMpnVOWaG8Bh0VgmAf4DfKFp7Y2Azm2iIoZNYkPSGRIkjGQ702sjcYzxLd/T
         Yeo4YHBRKYGO96InoCqVZWzOZ3Iepy/SkSb6pV6xH3BSpfh+alt7KpnNdZl++tqY6OBy
         e0+inpayY3EPFriahzKG8oVpp/TCghdvaR1MJk6J0uk0C2Py2dRaivg8cQbM7RlN2KYP
         LoWA==
X-Forwarded-Encrypted: i=1; AJvYcCXA3Ufvs0OunMrbkHHbnR775nXimjEms0MHrv0+Tf70YA6DOWi0CyM+5x9VUj2XXEXgyJsKZuolvsz0@vger.kernel.org
X-Gm-Message-State: AOJu0YxyLNVenNiyOQLnoztFmBFVDN+W5Ft2r5LhqKviklPVPhPSPp+s
	mui3BQH/4ske4Tic0wkzRG+CTeNaHAHSBoxos7kGVsq21MIb/8g4oiAlz8AY+r8RqM09tL5acwu
	uV/fHU4gTrNapY5jTCwNkKa4n8J+mY53eAbj8
X-Gm-Gg: ASbGncvIVCucfMAbGoGsgacr49t7GlNVbE0KXawkHHekfx7n4k4PHU6YDHDGzogWjkA
	KOWaSmHvMO0lUsr1xgl7ZCKEVrsQYQiGQ9O21TCxSQtCSGCpXr1ZosZl5jpr5Um+7LRnSklkAtQ
	==
X-Google-Smtp-Source: AGHT+IFFGxxkYhMQKVfYDnm7XsyyRreWF85HLpXoENay+/diLyLSAteEHMQPK0Mtl3rY5ZU6wGPxFOo5w7eaD7uEgcE=
X-Received: by 2002:a05:6e02:de5:b0:3d0:51e0:14af with SMTP id
 e9e14a558f8ab-3d051e01979mr722355ab.10.1738732198047; Tue, 04 Feb 2025
 21:09:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com> <20250201071455.718247-4-irogers@google.com>
 <CAH0uvoi8J3mg8UxpiuHrCpH07jyGNkSfDFybs7EFcxgOoxYx7g@mail.gmail.com>
In-Reply-To: <CAH0uvoi8J3mg8UxpiuHrCpH07jyGNkSfDFybs7EFcxgOoxYx7g@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 21:09:46 -0800
X-Gm-Features: AWEUYZmNUtmeqhYy_2pBb03-ke8v-cQ-bbjSct3xaz2BDX5EuOA3zo279OFHR34
Message-ID: <CAP-5=fVO9aQoCHKHud1GFQH9JnPEcPyU2d+3=_eMo1PJnmSTSQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] perf syscalltbl: Remove struct syscalltbl
To: Howard Chu <howardchu95@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 4:18=E2=80=AFPM Howard Chu <howardchu95@gmail.com> w=
rote:
>
> Hello Ian,
>
> On Fri, Jan 31, 2025 at 11:15=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > The syscalltbl held entries of system call name and number pairs,
> > generated from a native syscalltbl at start up. As there are gaps in
> > the system call number there is a notion of index into the
> > table. Going forward we want the system call table to be identifiable
> > by a machine type, for example, i386 vs x86-64. Change the interface
> > to the syscalltbl so (1) a (currently unused machine type of EM_HOST)
> > is passed (2) the index to syscall number and system call name mapping
> > is computed at build time.
> >
> > Two tables are used for this, an array of system call number to name,
> > an array of system call numbers sorted by the system call name. The
> > sorted array doesn't store strings in part to save memory and
> > relocations. The index notion is carried forward and is an index into
> > the sorted array of system call numbers, the data structures are
> > opaque (held only in syscalltbl.c), and so the number of indices for a
> > machine type is exposed as a new API.
> >
> > The arrays are computed in the syscalltbl.sh script and so no start-up
> > time computation and storage is necessary.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/builtin-trace.c       |  88 +++++++++++++-----------
> >  tools/perf/scripts/syscalltbl.sh |  36 ++++------
> >  tools/perf/util/syscalltbl.c     | 113 ++++++++++---------------------
> >  tools/perf/util/syscalltbl.h     |  22 ++----
> >  4 files changed, 103 insertions(+), 156 deletions(-)
> >
> > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > index 10d3ad0d21f7..7e3aa2f6c5e2 100644
> > --- a/tools/perf/builtin-trace.c
> > +++ b/tools/perf/builtin-trace.c
> > @@ -143,7 +143,6 @@ struct syscall_fmt {
> >
> >  struct trace {
> >         struct perf_tool        tool;
> > -       struct syscalltbl       *sctbl;
> >         struct {
> >                 /** Sorted sycall numbers used by the trace. */
> >                 struct syscall  *table;
> > @@ -2100,7 +2099,7 @@ static int syscall__read_info(struct syscall *sc,=
 struct trace *trace)
> >                 return 0;
> >         }
> >
> > -       name =3D syscalltbl__name(trace->sctbl, sc->id);
> > +       name =3D syscalltbl__name(sc->e_machine, sc->id);
> >         if (name =3D=3D NULL) {
> >                 sc->nonexistent =3D true;
> >                 return -EEXIST;
> > @@ -2196,10 +2195,14 @@ static int trace__validate_ev_qualifier(struct =
trace *trace)
> >
> >         strlist__for_each_entry(pos, trace->ev_qualifier) {
> >                 const char *sc =3D pos->s;
> > -               int id =3D syscalltbl__id(trace->sctbl, sc), match_next=
 =3D -1;
> > +               /*
> > +                * TODO: Assume more than the validation/warnings are a=
ll for
> > +                * the same binary type as perf.
> > +                */
> > +               int id =3D syscalltbl__id(EM_HOST, sc), match_next =3D =
-1;
> >
> >                 if (id < 0) {
> > -                       id =3D syscalltbl__strglobmatch_first(trace->sc=
tbl, sc, &match_next);
> > +                       id =3D syscalltbl__strglobmatch_first(EM_HOST, =
sc, &match_next);
> >                         if (id >=3D 0)
> >                                 goto matches;
> >
> > @@ -2219,7 +2222,7 @@ static int trace__validate_ev_qualifier(struct tr=
ace *trace)
> >                         continue;
> >
> >                 while (1) {
> > -                       id =3D syscalltbl__strglobmatch_next(trace->sct=
bl, sc, &match_next);
> > +                       id =3D syscalltbl__strglobmatch_next(EM_HOST, s=
c, &match_next);
> >                         if (id < 0)
> >                                 break;
> >                         if (nr_allocated =3D=3D nr_used) {
> > @@ -2673,6 +2676,7 @@ static int trace__sys_enter(struct trace *trace, =
struct evsel *evsel,
> >         int id =3D perf_evsel__sc_tp_uint(evsel, id, sample), err =3D -=
1;
> >         int augmented_args_size =3D 0;
> >         void *augmented_args =3D NULL;
> > +       /* TODO: get e_machine from thread. */
> >         struct syscall *sc =3D trace__syscall_info(trace, evsel, EM_HOS=
T, id);
> >         struct thread_trace *ttrace;
> >
> > @@ -2747,6 +2751,7 @@ static int trace__fprintf_sys_enter(struct trace =
*trace, struct evsel *evsel,
> >         struct thread_trace *ttrace;
> >         struct thread *thread;
> >         int id =3D perf_evsel__sc_tp_uint(evsel, id, sample), err =3D -=
1;
> > +       /* TODO: get e_machine from thread. */
> >         struct syscall *sc =3D trace__syscall_info(trace, evsel, EM_HOS=
T, id);
> >         char msg[1024];
> >         void *args, *augmented_args =3D NULL;
> > @@ -2822,6 +2827,7 @@ static int trace__sys_exit(struct trace *trace, s=
truct evsel *evsel,
> >         struct thread *thread;
> >         int id =3D perf_evsel__sc_tp_uint(evsel, id, sample), err =3D -=
1, callchain_ret =3D 0, printed =3D 0;
> >         int alignment =3D trace->args_alignment;
> > +       /* TODO: get e_machine from thread. */
> >         struct syscall *sc =3D trace__syscall_info(trace, evsel, EM_HOS=
T, id);
> >         struct thread_trace *ttrace;
> >
> > @@ -3175,6 +3181,7 @@ static int trace__event_handler(struct trace *tra=
ce, struct evsel *evsel,
> >
> >         if (evsel =3D=3D trace->syscalls.events.bpf_output) {
> >                 int id =3D perf_evsel__sc_tp_uint(evsel, id, sample);
> > +               /* TODO: get e_machine from thread. */
> >                 struct syscall *sc =3D trace__syscall_info(trace, evsel=
, EM_HOST, id);
> >
> >                 if (sc) {
> > @@ -3678,9 +3685,9 @@ static struct bpf_program *trace__find_syscall_bp=
f_prog(struct trace *trace, str
> >         return trace->skel->progs.syscall_unaugmented;
> >  }
> >
> > -static void trace__init_syscall_bpf_progs(struct trace *trace, int id)
> > +static void trace__init_syscall_bpf_progs(struct trace *trace, int e_m=
achine, int id)
> >  {
> > -       struct syscall *sc =3D trace__syscall_info(trace, NULL, EM_HOST=
, id);
> > +       struct syscall *sc =3D trace__syscall_info(trace, NULL, e_machi=
ne, id);
> >
> >         if (sc =3D=3D NULL)
> >                 return;
> > @@ -3689,22 +3696,22 @@ static void trace__init_syscall_bpf_progs(struc=
t trace *trace, int id)
> >         sc->bpf_prog.sys_exit  =3D trace__find_syscall_bpf_prog(trace, =
sc, sc->fmt ? sc->fmt->bpf_prog_name.sys_exit  : NULL,  "exit");
> >  }
> >
> > -static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int id)
> > +static int trace__bpf_prog_sys_enter_fd(struct trace *trace, int e_mac=
hine, int id)
> >  {
> > -       struct syscall *sc =3D trace__syscall_info(trace, NULL, EM_HOST=
, id);
> > +       struct syscall *sc =3D trace__syscall_info(trace, NULL, e_machi=
ne, id);
> >         return sc ? bpf_program__fd(sc->bpf_prog.sys_enter) : bpf_progr=
am__fd(trace->skel->progs.syscall_unaugmented);
> >  }
> >
> > -static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int id)
> > +static int trace__bpf_prog_sys_exit_fd(struct trace *trace, int e_mach=
ine, int id)
> >  {
> > -       struct syscall *sc =3D trace__syscall_info(trace, NULL, EM_HOST=
, id);
> > +       struct syscall *sc =3D trace__syscall_info(trace, NULL, e_machi=
ne, id);
> >         return sc ? bpf_program__fd(sc->bpf_prog.sys_exit) : bpf_progra=
m__fd(trace->skel->progs.syscall_unaugmented);
> >  }
> >
> > -static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int ke=
y, unsigned int *beauty_array)
> > +static int trace__bpf_sys_enter_beauty_map(struct trace *trace, int e_=
machine, int key, unsigned int *beauty_array)
> >  {
> >         struct tep_format_field *field;
> > -       struct syscall *sc =3D trace__syscall_info(trace, NULL, EM_HOST=
, key);
> > +       struct syscall *sc =3D trace__syscall_info(trace, NULL, e_machi=
ne, key);
> >         const struct btf_type *bt;
> >         char *struct_offset, *tmp, name[32];
> >         bool can_augment =3D false;
> > @@ -3800,9 +3807,9 @@ static struct bpf_program *trace__find_usable_bpf=
_prog_entry(struct trace *trace
> >         return NULL;
> >
> >  try_to_find_pair:
> > -       for (int i =3D 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
> > -               int id =3D syscalltbl__id_at_idx(trace->sctbl, i);
> > -               struct syscall *pair =3D trace__syscall_info(trace, NUL=
L, EM_HOST, id);
> > +       for (int i =3D 0, num_idx =3D syscalltbl__num_idx(sc->e_machine=
); i < num_idx; ++i) {
> > +               int id =3D syscalltbl__id_at_idx(sc->e_machine, i);
> > +               struct syscall *pair =3D trace__syscall_info(trace, NUL=
L, sc->e_machine, id);
> >                 struct bpf_program *pair_prog;
> >                 bool is_candidate =3D false;
> >
> > @@ -3886,7 +3893,7 @@ static struct bpf_program *trace__find_usable_bpf=
_prog_entry(struct trace *trace
> >         return NULL;
> >  }
> >
> > -static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trac=
e)
> > +static int trace__init_syscalls_bpf_prog_array_maps(struct trace *trac=
e, int e_machine)
> >  {
> >         int map_enter_fd =3D bpf_map__fd(trace->skel->maps.syscalls_sys=
_enter);
> >         int map_exit_fd  =3D bpf_map__fd(trace->skel->maps.syscalls_sys=
_exit);
> > @@ -3894,27 +3901,27 @@ static int trace__init_syscalls_bpf_prog_array_=
maps(struct trace *trace)
> >         int err =3D 0;
> >         unsigned int beauty_array[6];
> >
> > -       for (int i =3D 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
> > -               int prog_fd, key =3D syscalltbl__id_at_idx(trace->sctbl=
, i);
> > +       for (int i =3D 0, num_idx =3D syscalltbl__num_idx(e_machine); i=
 < num_idx; ++i) {
> > +               int prog_fd, key =3D syscalltbl__id_at_idx(e_machine, i=
);
> >
> >                 if (!trace__syscall_enabled(trace, key))
> >                         continue;
> >
> > -               trace__init_syscall_bpf_progs(trace, key);
> > +               trace__init_syscall_bpf_progs(trace, e_machine, key);
> >
> >                 // It'll get at least the "!raw_syscalls:unaugmented"
> > -               prog_fd =3D trace__bpf_prog_sys_enter_fd(trace, key);
> > +               prog_fd =3D trace__bpf_prog_sys_enter_fd(trace, e_machi=
ne, key);
> >                 err =3D bpf_map_update_elem(map_enter_fd, &key, &prog_f=
d, BPF_ANY);
> >                 if (err)
> >                         break;
> > -               prog_fd =3D trace__bpf_prog_sys_exit_fd(trace, key);
> > +               prog_fd =3D trace__bpf_prog_sys_exit_fd(trace, e_machin=
e, key);
> >                 err =3D bpf_map_update_elem(map_exit_fd, &key, &prog_fd=
, BPF_ANY);
> >                 if (err)
> >                         break;
> >
> >                 /* use beauty_map to tell BPF how many bytes to collect=
, set beauty_map's value here */
> >                 memset(beauty_array, 0, sizeof(beauty_array));
> > -               err =3D trace__bpf_sys_enter_beauty_map(trace, key, (un=
signed int *)beauty_array);
> > +               err =3D trace__bpf_sys_enter_beauty_map(trace, e_machin=
e, key, (unsigned int *)beauty_array);
> >                 if (err)
> >                         continue;
> >                 err =3D bpf_map_update_elem(beauty_map_fd, &key, beauty=
_array, BPF_ANY);
> > @@ -3950,9 +3957,9 @@ static int trace__init_syscalls_bpf_prog_array_ma=
ps(struct trace *trace)
> >          * first and second arg (this one on the raw_syscalls:sys_exit =
prog
> >          * array tail call, then that one will be used.
> >          */
> > -       for (int i =3D 0; i < trace->sctbl->syscalls.nr_entries; ++i) {
> > -               int key =3D syscalltbl__id_at_idx(trace->sctbl, i);
> > -               struct syscall *sc =3D trace__syscall_info(trace, NULL,=
 EM_HOST, key);
> > +       for (int i =3D 0, num_idx =3D syscalltbl__num_idx(e_machine); i=
 < num_idx; ++i) {
> > +               int key =3D syscalltbl__id_at_idx(e_machine, i);
> > +               struct syscall *sc =3D trace__syscall_info(trace, NULL,=
 e_machine, key);
> >                 struct bpf_program *pair_prog;
> >                 int prog_fd;
> >
> > @@ -4389,8 +4396,13 @@ static int trace__run(struct trace *trace, int a=
rgc, const char **argv)
> >                 goto out_error_mem;
> >
> >  #ifdef HAVE_BPF_SKEL
> > -       if (trace->skel && trace->skel->progs.sys_enter)
> > -               trace__init_syscalls_bpf_prog_array_maps(trace);
> > +       if (trace->skel && trace->skel->progs.sys_enter) {
> > +               /*
> > +                * TODO: Initialize for all host binary machine types, =
not just
> > +                * those matching the perf binary.
> > +                */
> > +               trace__init_syscalls_bpf_prog_array_maps(trace, EM_HOST=
);
> > +       }
> >  #endif
> >
> >         if (trace->ev_qualifier_ids.nr > 0) {
> > @@ -4415,7 +4427,8 @@ static int trace__run(struct trace *trace, int ar=
gc, const char **argv)
> >          *  So just disable this beautifier (SCA_FD, SCA_FDAT) when 'cl=
ose' is
> >          *  not in use.
> >          */
> > -       trace->fd_path_disabled =3D !trace__syscall_enabled(trace, sysc=
alltbl__id(trace->sctbl, "close"));
> > +       /* TODO: support for more than just perf binary machine type cl=
ose. */
> > +       trace->fd_path_disabled =3D !trace__syscall_enabled(trace, sysc=
alltbl__id(EM_HOST, "close"));
> >
> >         err =3D trace__expand_filters(trace, &evsel);
> >         if (err)
> > @@ -4688,8 +4701,7 @@ DEFINE_RESORT_RB(syscall_stats, a->msecs > b->mse=
cs,
> >         entry->msecs   =3D stats ? (u64)stats->stats.n * (avg_stats(&st=
ats->stats) / NSEC_PER_MSEC) : 0;
> >  }
> >
> > -static size_t thread__dump_stats(struct thread_trace *ttrace,
> > -                                struct trace *trace, FILE *fp)
> > +static size_t thread__dump_stats(struct thread_trace *ttrace, struct t=
race *trace, int e_machine, FILE *fp)
> >  {
> >         size_t printed =3D 0;
> >         struct syscall *sc;
> > @@ -4717,7 +4729,7 @@ static size_t thread__dump_stats(struct thread_tr=
ace *ttrace,
> >                         pct =3D avg ? 100.0 * stddev_stats(&stats->stat=
s) / avg : 0.0;
> >                         avg /=3D NSEC_PER_MSEC;
> >
> > -                       sc =3D trace__syscall_info(trace, /*evsel=3D*/N=
ULL, EM_HOST,
> > +                       sc =3D trace__syscall_info(trace, /*evsel=3D*/N=
ULL, e_machine,
> >                                                  syscall_stats_entry->s=
yscall);
> >                         if (!sc)
> >                                 continue;
> > @@ -4767,7 +4779,8 @@ static size_t trace__fprintf_thread(FILE *fp, str=
uct thread *thread, struct trac
> >         else if (fputc('\n', fp) !=3D EOF)
> >                 ++printed;
> >
> > -       printed +=3D thread__dump_stats(ttrace, trace, fp);
> > +       /* TODO: get e_machine from thread. */
> > +       printed +=3D thread__dump_stats(ttrace, trace, EM_HOST, fp);
> >
> >         return printed;
> >  }
> > @@ -4999,8 +5012,9 @@ static int trace__parse_events_option(const struc=
t option *opt, const char *str,
> >                         *sep =3D '\0';
> >
> >                 list =3D 0;
> > -               if (syscalltbl__id(trace->sctbl, s) >=3D 0 ||
> > -                   syscalltbl__strglobmatch_first(trace->sctbl, s, &id=
x) >=3D 0) {
> > +               /* TODO: support for more than just perf binary machine=
 type syscalls. */
> > +               if (syscalltbl__id(EM_HOST, s) >=3D 0 ||
> > +                   syscalltbl__strglobmatch_first(EM_HOST, s, &idx) >=
=3D 0) {
> >                         list =3D 1;
> >                         goto do_concat;
> >                 }
> > @@ -5136,7 +5150,6 @@ static void trace__exit(struct trace *trace)
> >                         syscall__exit(&trace->syscalls.table[i]);
> >                 zfree(&trace->syscalls.table);
> >         }
> > -       syscalltbl__delete(trace->sctbl);
> >         zfree(&trace->perfconfig_events);
> >  }
> >
> > @@ -5282,9 +5295,8 @@ int cmd_trace(int argc, const char **argv)
> >         sigaction(SIGCHLD, &sigchld_act, NULL);
> >
> >         trace.evlist =3D evlist__new();
> > -       trace.sctbl =3D syscalltbl__new();
> >
> > -       if (trace.evlist =3D=3D NULL || trace.sctbl =3D=3D NULL) {
> > +       if (trace.evlist =3D=3D NULL) {
> >                 pr_err("Not enough memory to run!\n");
> >                 err =3D -ENOMEM;
> >                 goto out;
> > diff --git a/tools/perf/scripts/syscalltbl.sh b/tools/perf/scripts/sysc=
alltbl.sh
> > index 1ce0d5aa8b50..a39b3013b103 100755
> > --- a/tools/perf/scripts/syscalltbl.sh
> > +++ b/tools/perf/scripts/syscalltbl.sh
> > @@ -50,37 +50,27 @@ fi
> >  infile=3D"$1"
> >  outfile=3D"$2"
> >
> > -nxt=3D0
> > -
> > -syscall_macro() {
> > -    nr=3D"$1"
> > -    name=3D"$2"
> > -
> > -    echo "     [$nr] =3D \"$name\","
> > -}
> > -
> > -emit() {
> > -    nr=3D"$1"
> > -    entry=3D"$2"
> > -
> > -    syscall_macro "$nr" "$entry"
> > -}
> > -
> > -echo "static const char *const syscalltbl[] =3D {" > $outfile
> > -
> >  sorted_table=3D$(mktemp /tmp/syscalltbl.XXXXXX)
> >  grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | sort -n > $sorted_table
> >
> > -max_nr=3D0
> > +echo "static const char *const syscall_num_to_name[] =3D {" > $outfile
> >  # the params are: nr abi name entry compat
> >  # use _ for intentionally unused variables according to SC2034
> >  while read nr _ name _ _; do
> > -    emit "$nr" "$name" >> $outfile
> > -    max_nr=3D$nr
> > +       echo "  [$nr] =3D \"$name\"," >> $outfile
> >  done < $sorted_table
> > +echo "};" >> $outfile
> >
> > -rm -f $sorted_table
> > +echo "static const uint16_t syscall_sorted_names[] =3D {" >> $outfile
> >
> > +# When sorting by name, add a suffix of 0s upto 20 characters so that =
system
> > +# calls that differ with a numerical suffix don't sort before those
> > +# without. This default behavior of sort differs from that of strcmp u=
sed at
> > +# runtime. Use sed to strip the trailing 0s suffix afterwards.
> > +grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | awk '{printf $3; for (i=
 =3D length($3); i < 20; i++) { printf "0"; }; print " " $1}'| sort | sed '=
s/\([a-zA-Z1-9]\+\)0\+ \([0-9]\+\)/\1 \2/' > $sorted_table
> > +while read name nr; do
> > +       echo "  $nr,    /* $name */" >> $outfile
> > +done < $sorted_table
> >  echo "};" >> $outfile
> >
> > -echo "#define SYSCALLTBL_MAX_ID ${max_nr}" >> $outfile
> > +rm -f $sorted_table
> > diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.=
c
> > index 2f76241494c8..760ac4d0869f 100644
> > --- a/tools/perf/util/syscalltbl.c
> > +++ b/tools/perf/util/syscalltbl.c
> > @@ -9,6 +9,7 @@
> >  #include <stdlib.h>
> >  #include <asm/bitsperlong.h>
> >  #include <linux/compiler.h>
> > +#include <linux/kernel.h>
> >  #include <linux/zalloc.h>
> >
> >  #include <string.h>
> > @@ -20,112 +21,66 @@
> >    #include <asm/syscalls_32.h>
> >  #endif
> >
> > -const int syscalltbl_native_max_id =3D SYSCALLTBL_MAX_ID;
> > -static const char *const *syscalltbl_native =3D syscalltbl;
> > +const char *syscalltbl__name(int e_machine __maybe_unused, int id)
> > +{
> > +       if (id >=3D 0 && id <=3D (int)ARRAY_SIZE(syscall_num_to_name))
> > +               return syscall_num_to_name[id];
> > +       return NULL;
> > +}
> >
> > -struct syscall {
> > -       int id;
> > +struct syscall_cmp_key {
> >         const char *name;
> > +       const char *const *tbl;
> >  };
> >
> >  static int syscallcmpname(const void *vkey, const void *ventry)
> >  {
> > -       const char *key =3D vkey;
> > -       const struct syscall *entry =3D ventry;
> > +       const struct syscall_cmp_key *key =3D vkey;
> > +       const uint16_t *entry =3D ventry;
> >
> > -       return strcmp(key, entry->name);
> > +       return strcmp(key->name, key->tbl[*entry]);
> >  }
> >
> > -static int syscallcmp(const void *va, const void *vb)
> > +int syscalltbl__id(int e_machine __maybe_unused, const char *name)
> >  {
> > -       const struct syscall *a =3D va, *b =3D vb;
> > -
> > -       return strcmp(a->name, b->name);
> > +       struct syscall_cmp_key key =3D {
> > +               .name =3D name,
> > +               .tbl =3D syscall_num_to_name,
> > +       };
> > +       const int *id =3D bsearch(&key, syscall_sorted_names,
> > +                               ARRAY_SIZE(syscall_sorted_names),
> > +                               sizeof(syscall_sorted_names[0]),
> > +                               syscallcmpname);
>
> This has puzzled me several times lol. Searching in
> syscall_sorted_names returns an int id... I get that it's sorted by
> name, but maybe call it syscall_ids_sorted_by_name, syscall_ids, or
> syscall_ids_sorted instead?
>
> > +
> > +       return id ? *id : -1;
> >  }
> >
> > -static int syscalltbl__init_native(struct syscalltbl *tbl)
> > +int syscalltbl__num_idx(int e_machine __maybe_unused)
>
> I haven't found many instances of *num_idx in the source tree
> indicating the length of an array. Are you okay with
> syscalltbl__nr_idx()?
>
> Otherwise LGTM.

So the idx rather than id (wish it were called syscall_nr) logic is
used with handling command line system call filters. You can see it in
the glob code:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/syscalltbl.c?h=3Dperf-tools-next#n106
The code wants to iterate over syscalls with no NULLs, as the name to
syscall number table doesn't contain NULLs it serves the same purpose
and is also sorted the same way.

Thanks,
Ian



> Thanks,
> Howard
> >  {
> > -       int nr_entries =3D 0, i, j;
> > -       struct syscall *entries;
> > -
> > -       for (i =3D 0; i <=3D syscalltbl_native_max_id; ++i)
> > -               if (syscalltbl_native[i])
> > -                       ++nr_entries;
> > -
> > -       entries =3D tbl->syscalls.entries =3D malloc(sizeof(struct sysc=
all) * nr_entries);
> > -       if (tbl->syscalls.entries =3D=3D NULL)
> > -               return -1;
> > -
> > -       for (i =3D 0, j =3D 0; i <=3D syscalltbl_native_max_id; ++i) {
> > -               if (syscalltbl_native[i]) {
> > -                       entries[j].name =3D syscalltbl_native[i];
> > -                       entries[j].id =3D i;
> > -                       ++j;
> > -               }
> > -       }
> > -
> > -       qsort(tbl->syscalls.entries, nr_entries, sizeof(struct syscall)=
, syscallcmp);
> > -       tbl->syscalls.nr_entries =3D nr_entries;
> > -       tbl->syscalls.max_id     =3D syscalltbl_native_max_id;
> > -       return 0;
> > +       return ARRAY_SIZE(syscall_sorted_names);
> >  }
> >
> > -struct syscalltbl *syscalltbl__new(void)
> > +int syscalltbl__id_at_idx(int e_machine __maybe_unused, int idx)
> >  {
> > -       struct syscalltbl *tbl =3D malloc(sizeof(*tbl));
> > -       if (tbl) {
> > -               if (syscalltbl__init_native(tbl)) {
> > -                       free(tbl);
> > -                       return NULL;
> > -               }
> > -       }
> > -       return tbl;
> > -}
> > -
> > -void syscalltbl__delete(struct syscalltbl *tbl)
> > -{
> > -       zfree(&tbl->syscalls.entries);
> > -       free(tbl);
> > -}
> > -
> > -const char *syscalltbl__name(const struct syscalltbl *tbl __maybe_unus=
ed, int id)
> > -{
> > -       return id <=3D syscalltbl_native_max_id ? syscalltbl_native[id]=
: NULL;
> > -}
> > -
> > -int syscalltbl__id(struct syscalltbl *tbl, const char *name)
> > -{
> > -       struct syscall *sc =3D bsearch(name, tbl->syscalls.entries,
> > -                                    tbl->syscalls.nr_entries, sizeof(*=
sc),
> > -                                    syscallcmpname);
> > -
> > -       return sc ? sc->id : -1;
> > -}
> > -
> > -int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx)
> > -{
> > -       struct syscall *syscalls =3D tbl->syscalls.entries;
> > -
> > -       return idx < tbl->syscalls.nr_entries ? syscalls[idx].id : -1;
> > +       return syscall_sorted_names[idx];
> >  }
> >
> > -int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *=
syscall_glob, int *idx)
> > +int syscalltbl__strglobmatch_next(int e_machine __maybe_unused, const =
char *syscall_glob, int *idx)
> >  {
> > -       int i;
> > -       struct syscall *syscalls =3D tbl->syscalls.entries;
> > +       for (int i =3D *idx + 1; i < (int)ARRAY_SIZE(syscall_sorted_nam=
es); ++i) {
> > +               const char *name =3D syscall_num_to_name[syscall_sorted=
_names[i]];
> >
> > -       for (i =3D *idx + 1; i < tbl->syscalls.nr_entries; ++i) {
> > -               if (strglobmatch(syscalls[i].name, syscall_glob)) {
> > +               if (strglobmatch(name, syscall_glob)) {
> >                         *idx =3D i;
> > -                       return syscalls[i].id;
> > +                       return syscall_sorted_names[i];
> >                 }
> >         }
> >
> >         return -1;
> >  }
> >
> > -int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char =
*syscall_glob, int *idx)
> > +int syscalltbl__strglobmatch_first(int e_machine, const char *syscall_=
glob, int *idx)
> >  {
> >         *idx =3D -1;
> > -       return syscalltbl__strglobmatch_next(tbl, syscall_glob, idx);
> > +       return syscalltbl__strglobmatch_next(e_machine, syscall_glob, i=
dx);
> >  }
> > diff --git a/tools/perf/util/syscalltbl.h b/tools/perf/util/syscalltbl.=
h
> > index 362411a6d849..2bb628eff367 100644
> > --- a/tools/perf/util/syscalltbl.h
> > +++ b/tools/perf/util/syscalltbl.h
> > @@ -2,22 +2,12 @@
> >  #ifndef __PERF_SYSCALLTBL_H
> >  #define __PERF_SYSCALLTBL_H
> >
> > -struct syscalltbl {
> > -       struct {
> > -               int max_id;
> > -               int nr_entries;
> > -               void *entries;
> > -       } syscalls;
> > -};
> > +const char *syscalltbl__name(int e_machine, int id);
> > +int syscalltbl__id(int e_machine, const char *name);
> > +int syscalltbl__num_idx(int e_machine);
> > +int syscalltbl__id_at_idx(int e_machine, int idx);
> >
> > -struct syscalltbl *syscalltbl__new(void);
> > -void syscalltbl__delete(struct syscalltbl *tbl);
> > -
> > -const char *syscalltbl__name(const struct syscalltbl *tbl, int id);
> > -int syscalltbl__id(struct syscalltbl *tbl, const char *name);
> > -int syscalltbl__id_at_idx(struct syscalltbl *tbl, int idx);
> > -
> > -int syscalltbl__strglobmatch_first(struct syscalltbl *tbl, const char =
*syscall_glob, int *idx);
> > -int syscalltbl__strglobmatch_next(struct syscalltbl *tbl, const char *=
syscall_glob, int *idx);
> > +int syscalltbl__strglobmatch_first(int e_machine, const char *syscall_=
glob, int *idx);
> > +int syscalltbl__strglobmatch_next(int e_machine, const char *syscall_g=
lob, int *idx);
> >
> >  #endif /* __PERF_SYSCALLTBL_H */
> > --
> > 2.48.1.362.g079036d154-goog
> >

