Return-Path: <linux-csky+bounces-1709-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD452A247CC
	for <lists+linux-csky@lfdr.de>; Sat,  1 Feb 2025 09:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1C21888D15
	for <lists+linux-csky@lfdr.de>; Sat,  1 Feb 2025 08:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADC6145B1B;
	Sat,  1 Feb 2025 08:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rdN/Pcu0"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B74D4315A
	for <linux-csky@vger.kernel.org>; Sat,  1 Feb 2025 08:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738399899; cv=none; b=Juf9T/A+qpgZIhPUMeil4KFkns6yptIydEIlkF2jZ4sV7ctjlT9o62Xl3Zhwyt801bJ5ybRSzO48fIkKwTcnGYvlgEuvTbBk2n2vPSvPfIfpdT36t1obatvRgms1xHsczbkzgmYw0klLq32MveaB3Mgx9JWXksxvWpLbPo1I3W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738399899; c=relaxed/simple;
	bh=wHk4hM1E2Xs597sLaiQpMT4/XnQINO/xkvfZUfLDhCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=t0kgAClfj0vZTFTb6tTUC8RiJ2f2i47fZj5STQ5WCRAlt1t9xD+p64cKtFB4pQUwcWTjnFbJWYaT8/Ulht02gJ6mmssHot9ztcnTIMbjTkoQh+qaaWT5BhnqxXnzyMBc8kpEel2JA1efXzs+9QAR+mcAIjvGZDkzAO2DmmRex/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rdN/Pcu0; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so86395ab.0
        for <linux-csky@vger.kernel.org>; Sat, 01 Feb 2025 00:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738399897; x=1739004697; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OIefE9I0jaBGB4Y4mTk2FVVd4hcyxumz66eayz6AufQ=;
        b=rdN/Pcu00aU9E+plgIOT/MizyBzdvwOpfv7OPwvW+dBe0Fxo8rD6HAD8IEW+HEetvH
         D7CmSwYuNbDo5jNQfyS9tDiU3GlLMvilaPIxvYp3QQlf/NuCW3qTK4RfOJFGUpY4LAB/
         3/LBBQLYLSwljUcsq3w2QCEJnNzscJ6SdSurvDQukaR3wDt7UvE0hyFMyS8unMXmvUgv
         jngrg2InlhUN7LJHSgL75cQDECkCiCaZGZwkdmJIQBeLDcTip4PCG4EQGAvWW/bcCsge
         Z3bA/3r2LiNEsBSRzSkgILAvmQvPm5jNDdWP+A2/ipmM9CZQ3JnHogqSumOG9oGhgklE
         vJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738399897; x=1739004697;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OIefE9I0jaBGB4Y4mTk2FVVd4hcyxumz66eayz6AufQ=;
        b=dY6XKENkFvUV8FdFsnqntKXOeD0PSIe5XPtakPC2i3dkZVwFH4rXkCx6R+mJG7/VWb
         URgo+h8hwEGCg7wfp/3Ct2RiGkC11biUVRMXU1igLkVa1o9C+u8hA1PDQJe67w+b7BT6
         o88XvWXCMuG4tkNM9vlShuiSzwYP2GmS7nZwnk/LEMCIohg0Zjejr4z/d6tCqFhMSDw/
         NQbsKJhsy01GwYi845avSy9xp+iPwXxQZ7slbGVYn8b975/b8ieu78yoLH533dA3Z6eA
         6PDdJ9PY6WfxxJm368c8ftptKZq1L1AOLiUXX3MRsnmrn5fnZpswhNUsmblniv2P/Rnt
         1ICg==
X-Forwarded-Encrypted: i=1; AJvYcCWf1kAwWqYXhQRt7e0ES1dY0ULkNrFfP/uH9Rmr6Uf+UmDaaB2/gssF98aLWJtgTDv/pvSIfUb94JmO@vger.kernel.org
X-Gm-Message-State: AOJu0YyfeTB0PIzOeSlr4ghsfC/3+gwl3Zva2y6FSxNdPQO4EWz/uhMR
	JFbC0+vLiogjf3D/fLzOy3ZAQhTeFA8LtLmGsdlVrM+IVTS/VKnJ0+p9LeK2NkMyhm7UI4LGpmX
	1nx1nKxW0JT+Jxr5tUZunLcEvtoK/VHO90WlO
X-Gm-Gg: ASbGncunD4nj60HCe1VKryN89DIeBD99d52LB8y8mOGbccP0vaKZeUauRoFZoVEdu+F
	UH52J9qRkPm50ToLduOkZM7sbxhuxDbXXBH54pIZaAOHVColMV5sovBOkaACuXoxWSYXvsfvg0w
	==
X-Google-Smtp-Source: AGHT+IFhoRz5P8nIkYHneDkKTVBakh7rtHG1dVw4obSdcvgjm+5z3V7T8nuKUGr47wUBBSm2PXOEjroFbF04NpvDEJE=
X-Received: by 2002:a05:6e02:1807:b0:3cf:c8b9:8826 with SMTP id
 e9e14a558f8ab-3d020178ad0mr2457485ab.10.1738399896951; Sat, 01 Feb 2025
 00:51:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com>
In-Reply-To: <20250201071455.718247-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Sat, 1 Feb 2025 00:51:25 -0800
X-Gm-Features: AWEUYZlh_7DpL4vGIxHF0oRogbUtw7xXXY8ZKrPktMrlaINtX7JtLXsF90u6VZI
Message-ID: <CAP-5=fVJPAEhvyV_dPHSHKJVeskCf_paFSP6V4EWmEyqACeA-w@mail.gmail.com>
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

On Fri, Jan 31, 2025 at 11:15=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> This work builds on the clean up of system call tables and removal of
> libaudit by Charlie Jenkins <charlie@rivosinc.com>.
>
> The system call table in perf trace is used to map system call numbers
> to names and vice versa. Prior to these changes, a single table
> matching the perf binary's build was present. The table would be
> incorrect if tracing say a 32-bit binary from a 64-bit version of
> perf, the names and numbers wouldn't match.
>
> Change the build so that a single system call file is built and the
> potentially multiple tables are identifiable from the ELF machine type
> of the process being examined. To determine the ELF machine type, the
> executable's header is read from /proc/pid/exe with fallbacks to using
> the perf's binary type when unknown.
>
> Remove some runtime types used by the system call tables and make
> equivalents generated at build time.
>
> Ian Rogers (7):
>   perf syscalltble: Remove syscall_table.h
>   perf trace: Reorganize syscalls
>   perf syscalltbl: Remove struct syscalltbl
>   perf thread: Add support for reading the e_machine type for a thread
>   perf trace beauty: Add syscalltbl.sh generating all system call tables
>   perf syscalltbl: Use lookup table containing multiple architectures
>   perf build: Remove Makefile.syscalls

If you are looking for the improvement this series achieves, patch 6
has sample before and after output:
https://lore.kernel.org/lkml/20250201071455.718247-7-irogers@google.com/

Thanks,
Ian

