Return-Path: <linux-csky+bounces-1723-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54D03A269F0
	for <lists+linux-csky@lfdr.de>; Tue,  4 Feb 2025 02:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099AD18830E5
	for <lists+linux-csky@lfdr.de>; Tue,  4 Feb 2025 01:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29AD139579;
	Tue,  4 Feb 2025 01:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mtAKU1Ug"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF5086330
	for <linux-csky@vger.kernel.org>; Tue,  4 Feb 2025 01:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738634324; cv=none; b=mDH+R9JhGGCikJ7FLHLD3EyKsNBmBogHe3xRQrmxq0enKa56CNN7kyKp3pFBAAMbtR6lbp8I6kkTtG2dTHmejsTkxOKjoJVTvw94CJEnBcfUZTSJSjv5wQ//u38DzzspYtYDl4GqqxWSrC1be13/on9Uaf1amRblDlT3etP8mzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738634324; c=relaxed/simple;
	bh=av7mIowXw/9z91sfKm94CO7sTInESQe4v382zCXM7Ts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ATsyGxkH216/abaJjBbQuBZxRVbMyK1UktSo4R9VpIsjyJQveZOYKcmPZsDP9rxctIwG9QtKF5gwUcbc4wFGWFFuPk/4OC9sKTPtZ+dykX5qFKhPiJqv8KbqhlZki4+1PDZzVAJMX6aokZg932T9Xb+EH9QzssAaGD49wk3JrOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mtAKU1Ug; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso25165ab.1
        for <linux-csky@vger.kernel.org>; Mon, 03 Feb 2025 17:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738634321; x=1739239121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av7mIowXw/9z91sfKm94CO7sTInESQe4v382zCXM7Ts=;
        b=mtAKU1UgSOOZExjLzjUxapaYHRwOwLMpCjFzkA9qekqT17beIJqEQQ9d9vEIGGESqd
         eel/jnewKQB+Pr01kDu0Y4WmZpgmjoeRBFeNONW6BiLDDAENupeJ0l/kqcZnZspGZFO+
         P8fh9VHYLU0oqEq/K2VbBTRsL4lfzT8LRQuCVfb3F7nBRhPxGduESwvOxbyAJ/bxYrqJ
         AyG0wjhhEqagcxIv5ctYAhLSkixMNbazgjWk7lqkqG3H4L/N9JG+G+z15hAMAKxTIFvs
         v03+fBZksaUwAUvQobHV4lWAlqNvVAuHnPdnCUgaTs3ixOUWjjdiLt3SkCtk4dFGTgLK
         8XRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738634321; x=1739239121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=av7mIowXw/9z91sfKm94CO7sTInESQe4v382zCXM7Ts=;
        b=rWU6SudrBfaLwXg0KGgSM+LlZxkLF3JNfzqOwRqGS4WX9OZPZFGPkU+JgwJXg8kK12
         s+qxQLMRL7vD7GxQhwvoIT3BIo5MzoqDPi8QW1t2UP5JTji32wgRWkMJ0UImvmowRbRJ
         agcY7Ew1a1c4dxHxMlvyWxaPr2/KYxqiyI/nyXS28NsGhFQd21/Mcvei+dy6j3OWGF0F
         FumNw/lFS8hzu13cviBGPcs4Zpo4pn0eyUsq5iqdXwAKdfEf6LafJ+XH5XSrOBtw/Hjy
         8UU+ZdsPg5bFwHkQLZUz3WN2kb1/HPDBNq1YjzS8MwQAYZI8e4X/X06nK2/+WqbAorF0
         kPVw==
X-Forwarded-Encrypted: i=1; AJvYcCVymBT5SafY4KJQ6xIFQpn0t83qNPVXz/9mnk83d8TTr5KSDr7vHQy9hd3CPxynatNb0BF/N0r2tojU@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2W5+lAmSg4J+x5yPpbOw6rzPhZYx5jHXYkX6nGud9ggi/6hGF
	GjLtRqGaeg8NDJmuh4UkNyrRM1xkUrxvzYU+sTh8kbAPY1DgWnzvI1Ea97RYqYKnjz4TV7YyMqn
	iQchtFk3ldzkuajnsw1P+x68GO9HIjxyMWhbm
X-Gm-Gg: ASbGncsYk5Onnh2J0VfC5FGmK/GwD00rJvG7+ZzS5/zVzvnohFQgSaXw7ziF6qSEeM9
	BM0ks85gQa71ji5tqwHvBqXrv6r87OOiJuymGC4avVSrNvr0FzBtXady3SgHhvcfmSUg7ZPEpow
	==
X-Google-Smtp-Source: AGHT+IFSTGGsIToVAem8d3RPstMMmOgQL91UDPwPQKGKwSo9BvPHGLa6a2hOvXGKifufQ1ktwWV2laPTQRiNavnNF4g=
X-Received: by 2002:a05:6e02:1546:b0:3cf:c825:cc6b with SMTP id
 e9e14a558f8ab-3d03fbc14ebmr1570415ab.10.1738634320753; Mon, 03 Feb 2025
 17:58:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com> <Z6EStkn-YZ8zaO7u@ghost>
 <CAP-5=fXRz_8CKNz4Fr-=0yhKbf_QE2ND+PPykSAO5p8wcUz7xA@mail.gmail.com>
 <Z6EVwaOVYaKtaK1j@ghost> <CAP-5=fX1hCNWWmGJPKYxj93S=zM1-eRucqzb4WW5fB_sZBCRLg@mail.gmail.com>
 <Z6Eh1QLuqTbUKLCc@ghost> <CAP-5=fXZr8L4Z=Lb28QDZF8cbv2eJJEHSb0H9zcqSOB9cn5-9g@mail.gmail.com>
 <Z6FLDHz6V5L-HGR7@ghost>
In-Reply-To: <Z6FLDHz6V5L-HGR7@ghost>
From: Ian Rogers <irogers@google.com>
Date: Mon, 3 Feb 2025 17:58:29 -0800
X-Gm-Features: AWEUYZl4VPDQDYEEJe2b_m05PnnWBufqWLrhyYXjVGpczvYgfi2M8V9it8-CAj4
Message-ID: <CAP-5=fVk6N=FVXsJ9xRJZhYSh2sbmUkEPr5HqRd-pR7mbGts+w@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] perf: Support multiple system call tables in the build
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Bibo Mao <maobibo@loongson.cn>, 
	Arnd Bergmann <arnd@arndb.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 3, 2025 at 3:02=E2=80=AFPM Charlie Jenkins <charlie@rivosinc.co=
m> wrote:
> On Mon, Feb 03, 2025 at 12:54:59PM -0800, Ian Rogers wrote:
[snip]
> > I think it makes sense in the kernel, as the built binary doesn't have
> > cross-platform concerns. This is probably also the reason why the perf
> > tool has an arch directory. Let me know what you think is the right
> > direction for the perf tool syscall table code.
>
> I am hesitant about moving all of the arch-specific syscall generation
> flags into a single file.

In these changes I had a single file to build up a mapping from ELF
machine to syscall table in an array and I wanted to keep the logic to
build the array alongside the logic to build up the components of the
array - so the ifdefs were visually the same. As the scope is a single
file and the variables are static, this can give useful C compiler
"unused definition" warnings. You can trick the linker to give similar
warnings at the scope of a file, so this isn't a deal breaker.

> There is currently a really clean separation
> between the architectures and it's possible to generate all of the
> syscall tables for all of the architecutures based on the paths to the
> syscall table.

This doesn't happen currently as the build of the arch directory is to
add in $(SRCARCH) only. So
tools/perf/arch/arm64/entry/syscalls/Makefile.syscalls will only be
included into the build if SRCARCH=3D=3Darm64. As I've said I'm against
the idea of the arch directory as it nearly always causes cross
platform problems - not an issue in a Linux kernel build. We recently
eliminated dwarf-regs for this reason (and hopefully fixing up cross
platform disassembly issues as a consequence):
https://lore.kernel.org/all/20241108234606.429459-1-irogers@google.com/
We could have the syscall table logic not under arch and generate
multiple files, but we'd be adding extra logic to pull things apart to
then pull things back together again, which feels like unnecessary
complexity.

It seems in your changes the Kbuild and Makefile.syscalls are running
in the arch directory - this feels like a lot of peculiar and
separated build logic for just iterating over a bunch of arch
directory names and calling a shell function on them - albeit with
some arch specific parameters. There's also an extra C helper
executable in your code. I kind of like that I get a single header
that is the same across all architectures and with no more build
system requirements than to support ifdefs - in fact the ifdefs are
just there to keep the code size down there is a #define to make them
all have no effect. I hear your "clean separation" but I also think
separation across files can make things harder to read, state is in >1
place. I've tried to cleanly separate within the script.

I do think there is some tech debt in both changes. My:
```
#if defined(ALL_SYSCALLTBL) || defined(__riscv)
#if __BITS_PER_LONG !=3D 64
EOF
build_tables "$tools_dir/scripts/syscall.tbl" "$outfile"
common,32,riscv,memfd_secret EM_RISCV
echo "#else" >> "$outfile"
build_tables "$tools_dir/scripts/syscall.tbl" "$outfile"
common,64,riscv,rlimit,memfd_secret EM_RISC
V
cat >> "$outfile" <<EOF
#endif //__BITS_PER_LONG !=3D 64
```
means the perf binary word size determines the syscall table support.
This is because the e_machine in the ELF header isn't unique in these
two cases and having both tables would have no effect. You've moved
this into the env arch name handling, but I think having >1 way to
encode a binary type is suboptimal. There are some ELF flag ABI bits
that resolve disassembler things on csky, so perhaps a resolution is
to pass ELF flags along with the machine type. I'm not clear in your
change how "32_riscv" is generated to solve the same problem. Imo,
it'd kind of be nice not to introduce notions like "64_arm64" as we
seem to be always mapping/normalizing/... these different notions and
they feel inherently brittle.

> What causes the arch directory to be a pain for Bazel? I
> guess I am mostly confused why it makes sense to change the kernel
> Makefiles in order to accomidate a rewrite of the build system in Bazel
> that isn't planned to be used upstream.

It's just software and so the issues are resolvable, ie I don't think
bazel should be determining what happens upstream - it motivates me to
some extent. For the bazel build I need to match the Makefile behavior
with bits of script called genrule, the scope and quantity of these
increase with the arch directory model, extra executables to have in
the build etc. I also imagine cross platform stuff will add
complexity, like mapping blaze's notions of machine type to those
introduced in your change. It is all a lot of stuff and I think what's
in these changes keeps things about as simple as they can be. It'd be
nice to integrate the best features of both changes and I think some
of the e_machine stuff here can be added onto your change to get the
i386/x86-64 case to work. I'm not sold on the complexity of the build
in your changes though, multiple files, Kbuild and Makefile.syscalls,
the arch directory not optionally being built, helper executables.
Ultimately it is the same shell logic in both changes, and your
previous work laid out all the ground work for this (I'm very grateful
for it :-) ).

Thanks,
Ian

