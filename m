Return-Path: <linux-csky+bounces-1779-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81664A312D6
	for <lists+linux-csky@lfdr.de>; Tue, 11 Feb 2025 18:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA86D1885562
	for <lists+linux-csky@lfdr.de>; Tue, 11 Feb 2025 17:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B44526215F;
	Tue, 11 Feb 2025 17:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1cTnQzUh"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F8C261380
	for <linux-csky@vger.kernel.org>; Tue, 11 Feb 2025 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294706; cv=none; b=IQpgxBVGF4+v1fai3m4gL46VePCTPGpqujf1VEYwX43IudPZJ/9/jLncVcJLnq5Z3LO8lha4HHeJcHOeq3FdsgPU5Kn+lNPc7Rej5ZmzgAvkSjuv4PMseJMiOWKCYlnDTJov36buklOzZiziXPw0LwYyyOKUIWzTETpberRnZEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294706; c=relaxed/simple;
	bh=OVaygMG8VlP4xBkWR28wcsQ/nkYaxyCk2untvEhVW/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qGiRrnhQIdW2zRXqdrW6bM3RLAKEVwdls5OwaJ9Bws+Diw5uaGoai6eQ1rsIPKqZsUXOPX8w1R4tBHpOhHoAecfQ3go2SxxsusOhCWRuTUMTqh95VpqmQH1VEUojZhzECIqqxc0RbJzUswuZjbdBQKMLhMxGH3Z0026FqZ0MkBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1cTnQzUh; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3d147331fb5so214325ab.0
        for <linux-csky@vger.kernel.org>; Tue, 11 Feb 2025 09:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739294704; x=1739899504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eUqaFoF/nA3myl/xKceml4ULdmxAvSOjNMKL2mIwQg=;
        b=1cTnQzUhEccrjkmLQWshEBqOBXVfIQupgovTVYdn/toiwJfDOYcBYYEn3sWt3G8fez
         up3g9EK91LB4RZretpyV2H0g8HiwlIXXH8cXcmClCGmbToSyXeFuup8k1/bQTw8oFvXU
         Vl/kPxKJImg0lMrjPhffcp9xotvjz9aarHG2MIPqNkMCma0tnUlWkp4FPRgABk4ZuzyC
         mo8J4dB0dZpSWf8qqkscyfycoRJVLfmiSDsQbCilulCnpzHIsjjaYT/8dCQWvbpmJtil
         81GlZ0NeJAyey13mPdTF2f6VzIehwiq5Ur7KDmAB34mQR3pvYFVwxYaYYfhO1fPP5VEu
         V1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739294704; x=1739899504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eUqaFoF/nA3myl/xKceml4ULdmxAvSOjNMKL2mIwQg=;
        b=vypiJOZs4gOYxEZ4z5Hs3dv3SuvDRc99oxo8tmCGFjOzMyBDE8gyOXaEicaqfJuY5C
         /JU/f30M9VQ2iHZlXu61fVZEQOQsvfP+yEJQqfrhzFgTbLlr+LjJazvgm6m/swFFHlTR
         utlybNJr/QfiHKjbJjZeb/j/afNqf8VQ7r7Kxu3xrll+y9Ngeg5QtqTNRD6/yZe2dplW
         plCwS2yW0XXk7SDxvMFt+ISx8wgK7yPO8cRwc+uZscNEnhMazDXxPnvAAc+8rv459xEy
         Z8FOqY7mLa0m561lgy7EpP9udABIAoKK3vMwuRL5m309RhKXQi/2+f5lCSLOyS2dMq2p
         oB3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBOV/Pc+DLZFHoVnhbz9wSO1l5yX7M9Q4eSCi67WfJqNVRl6OdfOUXPkQcDasTTg7gqWkklNiBUVDx@vger.kernel.org
X-Gm-Message-State: AOJu0YylBFjHQpI2hIFKIEXb4KnNke88ifHPrORJtFAYuE6jG85orLLn
	LMB7Vi+282eYZGxmdKQXtYCSGpcQae3zwdvR3L7xbSlEoLPtKAICCHEYpKaQX0JAdkyBMFFxKJy
	HhSFtdQDbHgi1Bp2EaV4+RDTqzUo1bKdlcxQE
X-Gm-Gg: ASbGncuJUtVy3+gQHI8xzqtcI7ZgXKWgdMLPRRufJFVBeRH5oAe8WfVKtWU+rwrzmTU
	TwxB95/nzJVJ2OGwbL08wk6AoCVV1Y1N9F/1VP8HM9f8toiKkvSjxlLxl3ucVoXmJhI3e3W8wbc
	2qb+WSWiWevfsT82wSrmY8jkIA
X-Google-Smtp-Source: AGHT+IHulOePOuHEHSpuFuNYO6P65ObrRZws2+5sl7jc3tR3t7l3NjrSWpuzOe7Ugxsa9ph5ihwoodwYrD5QTsiZGu4=
X-Received: by 2002:a92:c54b:0:b0:3cf:c075:da88 with SMTP id
 e9e14a558f8ab-3d171e3baa4mr3301595ab.23.1739294703579; Tue, 11 Feb 2025
 09:25:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210165108.95894-1-irogers@google.com> <20250210165108.95894-6-irogers@google.com>
 <d47c35dd-9c52-48e7-a00d-135572f11fbb@app.fastmail.com>
In-Reply-To: <d47c35dd-9c52-48e7-a00d-135572f11fbb@app.fastmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Feb 2025 09:24:51 -0800
X-Gm-Features: AWEUYZklUe5R5QefRSuHohckz8hNxM22lvM3Gxp2M1QMZ2_uE8brpR7qpIuJFYo
Message-ID: <CAP-5=fUi4RYebxCGYZVHVEt0BpWVmUA6+-vDQfbai25_KJRs7A@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] perf trace beauty: Add syscalltbl.sh generating
 all system call tables
To: Arnd Bergmann <arnd@arndb.de>, Arnaldo Carvalho de Melo <acme@kernel.org>, Howard Chu <howardchu95@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
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
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 12:09=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrot=
e:
>
> On Mon, Feb 10, 2025, at 17:51, Ian Rogers wrote:
>
> > +# Each line of the syscall table should have the following format:
> > +#
> > +# NR ABI NAME [NATIVE] [COMPAT]
> > +#
> > +# NR       syscall number
> > +# ABI      ABI name
> > +# NAME     syscall name
> > +# NATIVE   native entry point (optional)
> > +# COMPAT   compat entry point (optional)
>
> On x86, there is now a sixth optional field.

Thanks, I'll add and repost a v3. I had some other questions below so
I'll try to do everything together to avoid noise.

> > +#if defined(ALL_SYSCALLTBL) || defined(__arm__) || defined(__aarch64__=
)
> > +EOF
> > +build_tables "$tools_dir/perf/arch/arm/entry/syscalls/syscall.tbl"
> > "$outfile" common,32,oabi EM_ARM
> > +build_tables
>
> The oabi syscalls probably shouldn't be part of the default set here.
> Technically these are two separate ABIs, though EABI is a subset of
> OABI for the most most part. Some of the calling conventions are
> also different.

Ack. I was carrying forward:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/arch/arm/entry/syscalls/Kbuild#n3
but noticed that we weren't adding this for arm64:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/too=
ls/perf/arch/arm64/entry/syscalls/Kbuild
I'm happy to drop and have the ARM64 behavior. I'll make it a separate
patch in case there is a desire from someone to revert.

> > "$tools_dir/perf/arch/arm64/entry/syscalls/syscall_64.tbl" "$outfile"
> > common,64,renameat,rlimit,memfd_secret EM_AARCH64
> > +cat >> "$outfile" <<EOF
> > +#endif // defined(ALL_SYSCALLTBL) || defined(__arm__) ||
> > defined(__aarch64__)
>
> Hardcoding the set of ABIs in the middle of the script seems
> too fragile to me, I'm worried that these get out of sync quickly.

I agree, again this is carrying forward a behavior and at least after
these changes the location is just one place. Do you have any
suggestions on how to do better?

Fwiw, I wonder a related problem/question that has come up primarily
with Arnaldo and Howard is in having a way to determine system call
argument types so that perf trace can pretty print them. For example,
if via BTF it is found an argument is a "const char*" then it is
assumed to be a string, but a "char *" is not as it may just be an out
argument. There's a source for more information in the syzkaller
project:
https://github.com/google/syzkaller/blob/master/sys/linux/sys.txt
Perhaps there's a way to generate this information from the Linux
build and feed it into perf's build. It is out-of-scope for what I'm
trying to do here, but I thought it worth a mention given my general
ignorance on wider things.

> > +#if defined(ALL_SYSCALLTBL) || defined(__mips__)
> > +EOF
> > +build_tables
> > "$tools_dir/perf/arch/mips/entry/syscalls/syscall_n64.tbl" "$outfile"
> > common,64,n64 EM_MIPS
> > +cat >> "$outfile" <<EOF
> > +#endif // defined(ALL_SYSCALLTBL) || defined(__mips__)
>
> What about n32/o32? The syscall tables are completely different here.

So perf hasn't historically supported them and no one is asking for
support. Generating more tables isn't the problem, but we need to have
some way of determining which table to use for n32/o32. I see
EF_MIPS_ABI_O32 and EF_MIPS_ABI_O64, so we could add support by
extending the lookup of the table to be both of e_machine and e_flags.
I'm less clear on choosing n32. That said, back in the 90s I was
working to port MIPS code to Itanium via binary translation. Given now
Itanium is obsolete, I'm not sure it is worth adding complexity for
the sake of MIPS. I'm happy to do what others feel is best here, but
my default position is just to carry what the existing behavior is
forward.

> > +#if defined(ALL_SYSCALLTBL) || defined(__powerpc__) ||
> > defined(__powerpc64__)
> > +EOF
> > +build_tables "$tools_dir/perf/arch/powerpc/entry/syscalls/syscall.tbl"
> > "$outfile" common,32,nospu EM_PPC
> > +build_tables "$tools_dir/perf/arch/powerpc/entry/syscalls/syscall.tbl"
> > "$outfile" common,64,nospu EM_PPC64
> > +cat >> "$outfile" <<EOF
> > +#endif // defined(ALL_SYSCALLTBL) || defined(__powerpc__) ||
> > defined(__powerpc64__)
>
> This skips the SPU table, but I think that's fine.
>
> > +EOF
> > +build_tables "$tools_dir/perf/arch/s390/entry/syscalls/syscall.tbl"
> > "$outfile" common,64,renameat,rlimit,memfd_secret EM_S390
> > +cat >> "$outfile" <<EOF
> > +#endif // defined(ALL_SYSCALLTBL) || defined(__s390x__)
>
> This skips the 32-bit table, though I think that one is already
> planned to be discontinued in the future.

Thankfully we have awesome s390 devs on the mailing list, hopefully
they'll shout out if I'm doing things wrong.

> > +#if defined(ALL_SYSCALLTBL) || defined(__i386__) || defined(__x86_64__=
)
> > +EOF
> > +build_tables "$tools_dir/perf/arch/x86/entry/syscalls/syscall_32.tbl"
> > "$outfile" common,32,i386 EM_386
> > +build_tables "$tools_dir/perf/arch/x86/entry/syscalls/syscall_64.tbl"
> > "$outfile" common,64 EM_X86_64
> > +cat >> "$outfile" <<EOF
> > +#endif // defined(ALL_SYSCALLTBL) || defined(__i386__) ||
> > defined(__x86_64__)
>
> This misses the x32 table.

Again I'm carrying forward a behavior. Would it be worth adding x32?

Context: I handled x86 on Android over 10 years ago. x86 phones were
64-bit long before ARM or Apple phones, the kernel was 64-bit but the
userland was forced to be 32-bit. ARM32 has R15 be the program
counter, Sophie Wilson's idea, and when Android's security folks
experimented with ASLR they found it to be free as a consequence of
ARM32. On x86 not x32 then you're in the land of thunk bx, losing a
register and extra instructions. We never did x32 on Android as it
became irrelevant when I brought up x86-64 on Android. The desire for
x32 was for RIP encoding to fix the ASLR issue, not so much the extra
registers, and because Android used to mandate a 32-bit user land
(this was so extreme that even the developer's C to generally ARM
cross-compilers were built as 32-bit binaries). Given x32 was done for
Android, Android never used it, I have a hard time thinking we should
be adding support to perf. That said there is likely other context
that I'm unaware of as I'm surprised x32 still exists. Fwiw, it
saddens me that the x32 experience means that for APX we're still
getting the x86-64 ABI moved forward and silly things like the var
args convention on %al (there for C80 compatibility I once believed -
not really an issue today). On ARM64 registers there are at least 8
callee-save general purpose and floating point registers, so the x86
model of pretty much everything is caller-save means function calls
are expensive and you may need aggressive inlining. Anyway, sorry for
going on so much.

Thanks,
Ian

