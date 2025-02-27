Return-Path: <linux-csky+bounces-1839-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62586A4752F
	for <lists+linux-csky@lfdr.de>; Thu, 27 Feb 2025 06:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 060947A3CFF
	for <lists+linux-csky@lfdr.de>; Thu, 27 Feb 2025 05:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EA01F7904;
	Thu, 27 Feb 2025 05:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmH1LHP9"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802031F585D
	for <linux-csky@vger.kernel.org>; Thu, 27 Feb 2025 05:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740633869; cv=none; b=rZQgT788572/3TQFDZNYraVeKK0Qfwv43XD8LNQB8M5Ojq776J5/XttkeO0B8kW9gBpgMtqRiaCpVj2AHImi/2Z14wRkTA3kjdn4G3d2kcSJ8ntbqOGnxjzRaYY6kgNaumYZUkuLXy6kd8ag7IzwKIeslr/oA87hFizcwNbMBOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740633869; c=relaxed/simple;
	bh=47ds+4hGrY28VgZ3hza+Gb+h0Ld/NmG/YiG2BZEJFxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AwKPOFn6wq5Zw3HY9dKQdSgtNI6H/L4yZ0XNPr9ZZ97l08Eu/TJhdpuOx6H1xhcI6z5H1wZIPGZ8KoDCZRhPv/iLLDYlsE1MsbMBc714GcAVGe6+4tl1NlS5gab/1QkrqGy3Ww67jFI56YOcELRkyu2WPqoVL4neCoroRIODxPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmH1LHP9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-221ac1f849fso67565ad.1
        for <linux-csky@vger.kernel.org>; Wed, 26 Feb 2025 21:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740633866; x=1741238666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bnEz81f237FPFDdRQFlVRCVwc99gvba5x2QOCkc+RR0=;
        b=RmH1LHP9Er+ZTanjRwSRO4zB4wbaVbJkp4mK6Lb3GF7HZRTX2rYyviDZJXdljSkZD8
         9KF5gmaUQ4HHpXS+zQZPFROYE9slovw3zjDLpGxhp7VxpV7H+iN3qjh7yLCYvDPRvg+C
         S612hQODu/llEYl0Z9FM1MYdsKXm5Df9arNZ2lC0ldmDKSOC5UhI7r9+1j6vjDGr0IIn
         V+ceJTq7alZUElVRbUv2iqy+BNwue/2GL5D9rEE0Ny+s4DThi/rjaBKrNGCgLTUys5aO
         3vl1E6duYDpWsa+otbVzZnyr+boNOVIztAHwxwa09+BD6RJPiM6OYWDNWyDuAcgKTIDU
         6HFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740633866; x=1741238666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bnEz81f237FPFDdRQFlVRCVwc99gvba5x2QOCkc+RR0=;
        b=S3n8Ww8TALQ4kQ2JbFtsLPZggqBUloQhNrdZmt7gNVxoKJEvUZCptoXKVdIL5hA9Uv
         s5QIsbTbuuec6RouqLZ6dTRZiz1+zOoTRbONyNt58dFE+/9JppxjERynPIcsJVnvTCDS
         IdgIxRD4aD8gi9KABU4kSiDXDrIh7ShabnhFOdwh12hmYtKCLPnsM239dKaRxTeudAVG
         WrxAcNre7Krdr+ls1AE6P3joQJnq3kVi+KgpA6b4OIcj3/8eAXCZzjr8tZqvPTmfvwua
         D4G+DWdEKXXQFilFe/vy40YJt88OB9FQ0ha41TaP1DRxPmgu1CXx9N8GfDbSsVtdxoYb
         iPGg==
X-Forwarded-Encrypted: i=1; AJvYcCUcOCqipakuD+1lcsKMD48DEFGj+3qewjuKYFr6W+1h7D8Zw45GtD0tRPFE2kdZbObBLhDXsuoQuBWI@vger.kernel.org
X-Gm-Message-State: AOJu0YxwX34rUY4TZrkG4dMcv7NEulkNdvApTUh3lFxmbBldH8Dj0Ek7
	Xvz+SH4QGZAsPecchEIm8iSximpnSDNT/kyqBWLE3cR/b3f2c/FTCL4ayroWVb8txSxIHO6DnWP
	AJ6X4a+zUI9QM0DTTxF+3jbNxPgwaDgZpGmZT
X-Gm-Gg: ASbGncsoXZlpljJ2bOEMJoelKqGIZO7GHyO0DebJuO8izepnT6/3C19708qqNOOCmWt
	n5W3ZtbqgfZ/+mrLx64wvT+O45U8LAWW8/ur/ox4KKpQH5jAkJd/RX98R6JPIf0YOZiH5NF+H1X
	kWnwuwaMWR
X-Google-Smtp-Source: AGHT+IESGHDEUIPVrjNTh39ynN60aQSgX7N+PvnUqhcTHIKp7IZB5bqsgXo3vv32FxrjQl6qmhQtj7bSXHofxTNEMow=
X-Received: by 2002:a17:902:f7cc:b0:200:97b5:dc2b with SMTP id
 d9443c01a7336-223517240a4mr1111615ad.15.1740633866391; Wed, 26 Feb 2025
 21:24:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219185657.280286-1-irogers@google.com> <Z702_CQ7nMx9fZQn@google.com>
 <CAP-5=fWYiQP84BMjm69xud4vYaRrutRG-RASKbxQaGSisRm7jA@mail.gmail.com> <Z7-rN8iGUpPe6b-1@google.com>
In-Reply-To: <Z7-rN8iGUpPe6b-1@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 26 Feb 2025 21:24:15 -0800
X-Gm-Features: AQ5f1JpYoEre35TWzYAHXMZBSPsriPeINrD-jPxutBzlTEFdOvLRV6EZPh8_ULw
Message-ID: <CAP-5=fVAuCF4i8HQEGYx_ApcSuBg82pXCsgk98oU9-2Gm=NOcw@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] perf: Support multiple system call tables in the build
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	linux-mips@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 26, 2025 at 4:00=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Mon, Feb 24, 2025 at 08:22:50PM -0800, Ian Rogers wrote:
> > On Mon, Feb 24, 2025 at 7:20=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Wed, Feb 19, 2025 at 10:56:49AM -0800, Ian Rogers wrote:
> > > > This work builds on the clean up of system call tables and removal =
of
> > > > libaudit by Charlie Jenkins <charlie@rivosinc.com>.
> > > >
> > > > The system call table in perf trace is used to map system call numb=
ers
> > > > to names and vice versa. Prior to these changes, a single table
> > > > matching the perf binary's build was present. The table would be
> > > > incorrect if tracing say a 32-bit binary from a 64-bit version of
> > > > perf, the names and numbers wouldn't match.
> > > >
> > > > Change the build so that a single system call file is built and the
> > > > potentially multiple tables are identifiable from the ELF machine t=
ype
> > > > of the process being examined. To determine the ELF machine type, t=
he
> > > > executable's header is read from /proc/pid/exe with fallbacks to us=
ing
> > > > the perf's binary type when unknown.
> > >
> > > Hmm.. then this is limited to live mode and potentially detect wrong
> > > machine type if it reads an old data, right?
> > >
> > > Also IIUC fallback to the perf binary means it cannot use cross-machi=
ne
> > > table.  For example, it cannot process data from ARM64 on x86, no?  I=
t
> > > seems it should use perf_env.arch.
> >
> > The perf env arch is kind of horrid. On x86 it has the value x86 and
> > then there is an extra 64bit flag, who knows how x32 should be encoded
> > - but we barely support x32 as-is. I'd rather we added a new feature
> > for the e_machine/e_flags of the executable and worked with those, but
> > it is kind of weird with doing system wide mode. I didn't want to drag
> > that into this patch series anyway as there is already enough here.
>
> Right, I don't know how to handle x32 properly.  Maybe we can just
> ignore it for now.
>
> But anyway looking at /proc/PID for recorded data doesn't seem correct.
> Can you please add a flag to do that only from trace__run() and just use
> EM_HOST for trace__replay()?

So I was hoping at some later point the e_machine on the thread could
be populated from the data file - hence the accessor being on thread
and not part of the trace code. We could add a global flag to thread
to disable the reading from /proc but we do similar reading in
machine.c for /proc/version, /proc/kallsyms, /proc/modules, etc. I
think the chance a pid is recycled and the process has a different
e_machine are remote enough that it is similar in nature. Adding the
flag means we need to go and fix up all uses, we only need to set the
flag in builtin-trace.c currently, but we've been historically bad at
setting these globals and bugs creep in. I also don't think
record/replay is working well and I didn't want the syscalltbl cleanup
to turn into a perf trace record/replay fixing exercise.

Thanks,
Ian

> Later, we may need to add a misc flag or so to PERF_RECORD_FORK (and
> PERF_RECORD_COMM with MISC_COMM_EXEC) to indicate non-standard ABI for a
> new thread.  But it's not clear how to make it arch-independent.
>
> >
> > > One more concern is BPF.  The BPF should know about the ABI of the
> > > current process so that it can augment the syscall arguments correctl=
y.
> > > Currently it only checks the syscall number but it can be different o=
n
> > > 32-bit and 64-bit.
> >
> > That's right. This change is trying to clean up
> > tools/perf/util/syscalltbl.c and the perf trace usage. I didn't go as
> > far as making BPF programs pair system call number with e_machine and
> > e_flags, there is enough here and the behavior after these patches
> > matches the behavior before - that is to assume the system call ABI
> > matches that of the perf binary.
>
> Right, the next step would be adding a BPF kfunc to identify the current
> ABI.
>
> Thanks,
> Namhyung
>

