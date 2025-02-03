Return-Path: <linux-csky+bounces-1714-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD200A26273
	for <lists+linux-csky@lfdr.de>; Mon,  3 Feb 2025 19:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E373A35C2
	for <lists+linux-csky@lfdr.de>; Mon,  3 Feb 2025 18:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A64520E319;
	Mon,  3 Feb 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0T+rDMc1"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7320E70D
	for <linux-csky@vger.kernel.org>; Mon,  3 Feb 2025 18:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738607337; cv=none; b=Jl9Ob2MZcHSM2Xrmf6hFMCcng23YS4tklb2SoZK8I+E1icQqy6UWtlmqdgJCUtyKaR4OEiVTqB+rjTn1wvxefVKDj+OAkmUudLRjkClqz4C8p0OP1CqIQYQR5w6VdwvJtY4lw1m8aqAR8/OmGh59GpIhqCCh4ENms0Uwa1K0JLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738607337; c=relaxed/simple;
	bh=PKPB5z8jjt3oXbFDRocWuOE6GY1Tqjmchh+Zand458k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=JJZEohkrnO/ch/F9wO0GeasGnAZiyntR5oTBeOwqbjvX5QW98IKhhy8zUzT98MCC8bLrDrGFYuNmruTbCkMyxW6k6dnC/Aeo7j7fPf2dxf4agftfApRPGj8rv1ROfLQAWcQ8ckPdA8hEtbYJhTXzIIKlGAhT+7g09Zs5BpVki9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0T+rDMc1; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so2795ab.0
        for <linux-csky@vger.kernel.org>; Mon, 03 Feb 2025 10:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738607333; x=1739212133; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QwX9yigjczno1Znsa9bRz1z0dQyr4IiRfFLwwoCxyg0=;
        b=0T+rDMc1vxZ7ATjjLM+jiGaHJciTiCdMdda7V0ljlX+ghT9p8264U0jk8ySHp60y/g
         s1XTxvVehe0XnXT1KlRBfO51jad0oXM7nl5NyQn1VSeLzKDMb45rjgPyQ3F7B0b0kZqy
         xUe2Nhg9OIdh+ES6kayOCmszXjjhtDSaoPkzweZ8xjORkTErIfcG6nh28SXQuAxShRN7
         I/s14i/Fo/Kl4k/WR6E7K3/nPg/7PlcSesoenGYK1tFMXOWbxvOxwCl59xx3mmXYq9BD
         uTqsXCts4d8PU85qPSfJQDF3q0ZbqKAtVD6BydKKAIobIoR/nfUbpQVDz/8kHTtMsj34
         cZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738607333; x=1739212133;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QwX9yigjczno1Znsa9bRz1z0dQyr4IiRfFLwwoCxyg0=;
        b=ao3LaomEjt4EbY6nYr3v31+ebexKMsmDhZPB6E17ROEGfjaAuWGDVNVwfVhMC9GWS6
         o1WpttGACru8jyvp3Dlgnn5lRQArG2AcGloBQ1DLO9ZcGIpSILAqKcigRTU245jfu6iU
         Fp1CUR/LqT7zoaDAHTJDyEXBqrsLXEMewqfQSAwJJ8DqFEtq8tqxiHkrfdVx3D04UGbT
         Fi0BKDPx37X0c9fk9OA+d2jtGXJnfo2PHl9stE6/gUGOXihvWHL0jV+CKziZBSftLLbo
         Db8/bT7/kYYAtQ9Y5ERqLguGQK/DqUiJI21NV63zWvQ6eDjYmYFgCJ124Yq/pPQidhwZ
         UWvw==
X-Forwarded-Encrypted: i=1; AJvYcCWLU0BgJDdh/C6qSLZzQOxlGUvveuP1/iKgDptm9Pv2DnY1hug/GETB2apM0MwL5XdTVqG9y9vZFyrQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxrhq3zqPpiSprsS48le0gwY91v1euhhm3cvJxzg7b3Bui6eZds
	qz9Od38+8iQ70wM7aeXBeekVKmCUEGomQLWMSb2w5HWer4+FoWqzAGFk6LUp8IEHWwuYTNya75o
	r4nlUU8bJn6DkNU5vEIJZQTM3law+vR5RBjzh
X-Gm-Gg: ASbGnctlLEJwNcWfDwTlVZI+SkGDLgaMNfRPWm90ghhaxxZ0uis7kXAfEDw/uBVdwRd
	QDtn4OoPPOvGdzOVCevkDLxyes7fr1EQ5PKosLcSEO7MUAaVH08PTPPvDlUNFP8e0Mv9THlsSDV
	LkCBctojBZ6YEjvwnx8EK7/4k=
X-Google-Smtp-Source: AGHT+IH+A9TihiG72yU0Vq5EiYylzTrE/IWJEUJYg00EcqiTZKQbwizmjhExw2bHiq41772gYqefQvOo1dSun9QKKsQ=
X-Received: by 2002:a05:6e02:152b:b0:3a7:e3b3:2e3 with SMTP id
 e9e14a558f8ab-3d03eef69e2mr568275ab.17.1738607331812; Mon, 03 Feb 2025
 10:28:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com> <CAP-5=fVJPAEhvyV_dPHSHKJVeskCf_paFSP6V4EWmEyqACeA-w@mail.gmail.com>
In-Reply-To: <CAP-5=fVJPAEhvyV_dPHSHKJVeskCf_paFSP6V4EWmEyqACeA-w@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Feb 2025 10:28:40 -0800
X-Gm-Features: AWEUYZk2d0_RD-bETg-4iKC_pajIBGhSvw_oeuucHt_WAGp1zkLzZrIkQ1Y7lrI
Message-ID: <CAP-5=fX2BtFzhGLCSqO1QszqfX=HT8RrTdG_5Ttp5Gw4seSstA@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] perf: Support multiple system call tables in the build
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
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 1, 2025 at 12:51=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Fri, Jan 31, 2025 at 11:15=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
> >
> > This work builds on the clean up of system call tables and removal of
> > libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> >
> > The system call table in perf trace is used to map system call numbers
> > to names and vice versa. Prior to these changes, a single table
> > matching the perf binary's build was present. The table would be
> > incorrect if tracing say a 32-bit binary from a 64-bit version of
> > perf, the names and numbers wouldn't match.
> >
> > Change the build so that a single system call file is built and the
> > potentially multiple tables are identifiable from the ELF machine type
> > of the process being examined. To determine the ELF machine type, the
> > executable's header is read from /proc/pid/exe with fallbacks to using
> > the perf's binary type when unknown.
> >
> > Remove some runtime types used by the system call tables and make
> > equivalents generated at build time.
> >
> > Ian Rogers (7):
> >   perf syscalltble: Remove syscall_table.h
> >   perf trace: Reorganize syscalls
> >   perf syscalltbl: Remove struct syscalltbl
> >   perf thread: Add support for reading the e_machine type for a thread
> >   perf trace beauty: Add syscalltbl.sh generating all system call table=
s
> >   perf syscalltbl: Use lookup table containing multiple architectures
> >   perf build: Remove Makefile.syscalls
>
> If you are looking for the improvement this series achieves, patch 6
> has sample before and after output:
> https://lore.kernel.org/lkml/20250201071455.718247-7-irogers@google.com/

I think there is a follow up to these patches to clean up the notion
of "arch" and its "name" member:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/disasm.h?h=3Dperf-tools-next#n20
The name on x86-64 has the value "x86" and isn't known to be i386 or
x86-64, causing ambiguity to work around:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/disasm.c?h=3Dperf-tools-next#n1898
It feels likely that rather than recording (in env) a string based on
uname and bashing it around:
https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tr=
ee/tools/perf/util/env.c?h=3Dperf-tools-next#n440
It would be better to record the e_machine values for the set of
threads in the record, or just a set of potential e_machine values. We
can get rid of name in arch, use e_machine from some dso helper, and
then deal with this as appropriate without needing to carry around
is_64bit to deal with ambiguity.

A change like this would need its own feature flag, and helpers
between the old name and e_machine so all notions of the old style
name could be removed, etc. It may be convenient to duplicate arch
tables for i386/x86-64 rather than have disasm's arch deal with a set
of e_machines.

Thanks,
Ian

