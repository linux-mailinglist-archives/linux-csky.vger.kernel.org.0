Return-Path: <linux-csky+bounces-1780-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDE6A31324
	for <lists+linux-csky@lfdr.de>; Tue, 11 Feb 2025 18:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DD2F3A1DA8
	for <lists+linux-csky@lfdr.de>; Tue, 11 Feb 2025 17:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35FB261572;
	Tue, 11 Feb 2025 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQ5ESFzW"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02335261563
	for <linux-csky@vger.kernel.org>; Tue, 11 Feb 2025 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295164; cv=none; b=mgnsQRJ7VJ333tGrDF3AM/vX/tIZKxqdD5BiuKzwNQXD7PoObG3b5E8Pd4RIc9l7TCHRzK6xR/ZjhWOwIJrcPzu2MbdS5D1fnVrqbRWGhJQkGLj2net1MnLwxDPY3iuwwBpD9FN8e6XMU3zUh5EsHycJMmDBWXwwHyq6y/M7KBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295164; c=relaxed/simple;
	bh=9VqB6kDe0g1j1EVbwpnZoUYoSv7oUR+TG+IB45BlCtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7nUe0RRRlyoeQfVaboKCUBKq61LVREKUyKU6ZZd2SLXyYmY4DNK6veeL0H+NQQOgT+MuY/RyJyPt9KKnydBTJcJjIZUpnKlAGoRwR4ApLbFGBqtuRrxcL5cEDziWLJYoHPUsZxz9viWqAr4LCBvT4dbNSbdxPNAhh9tJPVGXDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQ5ESFzW; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d05815e89dso179925ab.1
        for <linux-csky@vger.kernel.org>; Tue, 11 Feb 2025 09:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739295162; x=1739899962; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wQ94efDGzeP+hPazDVZ0s87mMmIX0OkL74nPRKdj5c=;
        b=vQ5ESFzWQCcv9rLjyZII8Mr5BFQQo1aJWFXvDtGYivKE4O1bJWCDt2vDkUGPg88r1C
         TnRfmNfhjuJFWYKQmrt2nyrvcGEvofx4BtIkT5kTg3pr5L35D/TgAjuDEO0mzH4FJQ7/
         jHA9bBurxhCx4CUK/MlHPdK1TcOo5otUqreYAOyhZ/WJZPO4n/CXH/9ouSlImTgHj3ez
         KfiNRG04JxI8A0qCpcF8o3Q8wXsBOQabOHbppH94M9nrsqi8u+4pPTQbi5hNBymhx30U
         1asM/XLEwrUN1Er9tQbe2WmZ4wBoEogJcKHru8SuEQu6Lhebx2vFFMgAXVEIuLNxMLLs
         yJpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739295162; x=1739899962;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wQ94efDGzeP+hPazDVZ0s87mMmIX0OkL74nPRKdj5c=;
        b=LBghrEDkKsTgseaRhBuROHE4niuNJdHZxJtkZbYgW2ve39H9CeFGhZ6MbnGZdAKjNQ
         YWeEZ+69DBIkXcpPf/0VnwF+LCsx54xzO1duI8LTaKRQdrzgxlIFO0Rx+0o2V5Ltn4S5
         aBYS91qRwVclkm/K2asVqPNglq56c2t7nQu5ql03YAd66/NFxl+fk2Xd88EZBwAHI/hS
         GnacBW6c6yqu24amlL0+JlLDqlXIygOwU+TTzHDcu/XiIj6P20bIUX9TNz9ahzSsoLvI
         nzywBt66XDTAXCYnUoykL2qMCkblnI3F202vwF2jqG76b0yfJbIsld45nFuuwxhfRNeA
         uxpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGmlcUQm6ZPBHPvLF4iOu70EvD7GZ1S03j1J32cJLLINPOG/UThujG7Leahf/aMdO/Irp+jUXVbHjI@vger.kernel.org
X-Gm-Message-State: AOJu0YyTJ5F6t2bzTCC3kctOx1ijykQVA5NKb5nV6BtYFjm6NVyHM5sf
	DHNf7Ltqsk5+8wA+YZIrB9HcZjNlXg7wZNfXbKb8RZ4ZwU3DGy3ADUWchSunYdE1vl5a8d95MnT
	2DdLYkeaB/p0URMFl3ofLmojajG3x8fPVL10d
X-Gm-Gg: ASbGncuL58hLjXYZDtVgWDA47f/aMPUWQMFnxaFzDthrd7Nkk0vvYTXjdbCu+U6XD2v
	qjYUzY1Tq3gcjPudPSYUbauTuzfB9vJ+x376meixNpN2AHlVFbbv6hR4YNHetr6dgB2MWOr3l1O
	fbktxmUFRz517NPp2nff7D/DFc
X-Google-Smtp-Source: AGHT+IFx7gQLpljuW0IlQHJkC2sPOgwjKNSe/p6Gvj27OoKy/WP45l1TbYOsmf4dkw4zbjr78o/5BoHNMYA6pqf60WY=
X-Received: by 2002:a92:c848:0:b0:3d1:7959:1793 with SMTP id
 e9e14a558f8ab-3d179591827mr1211895ab.25.1739295161966; Tue, 11 Feb 2025
 09:32:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250210165108.95894-1-irogers@google.com> <20250210165108.95894-4-irogers@google.com>
 <07c5c3ad-5a6d-4eda-95f2-ed16e7504d4c@app.fastmail.com> <CAP-5=fV0AVEp1uEtKjAqOmwqKSRuUzTwrXnBiqc=Lopfj4hBSA@mail.gmail.com>
 <8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.fastmail.com>
In-Reply-To: <8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.fastmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 11 Feb 2025 09:32:30 -0800
X-Gm-Features: AWEUYZkcknJc_ecEWZmGNLleCOMX5hjRpYX4QmTXwPuP9BwndmjrpXk_kZmIMOQ
Message-ID: <CAP-5=fWjJbg_q3xN0iytcqdBzSuRX+PD7CKp9+rHvFxB1VYxhw@mail.gmail.com>
Subject: Re: [PATCH v2 3/7] perf syscalltbl: Remove struct syscalltbl
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
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
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 11, 2025 at 8:34=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Feb 11, 2025, at 17:18, Ian Rogers wrote:
> > On Mon, Feb 10, 2025 at 11:48=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:
>
> >> The syscall numbers on mips (and previously on ia64) are offset by
> >> a large number depending on the ABI (o32/n32/n64). I assume what
> >> we want here is to have the small numbers without the offset in
> >> syscall_num_to_name[], but that requires adding the offset during
> >> the lookup. Can you check if this is handled correctly?
> >
> > Thanks Arnd! I agree the tables are large and can be sparse, they'll
> > also be full of relocations. MIPS doesn't look like an outlier to me
> > here:
>
> Sorry, I should have been clearer what I meant, see
> arch/mips/include/uapi/asm/unistd.h:
>
> #if _MIPS_SIM =3D=3D _MIPS_SIM_NABI32
> #define __NR_Linux      6000
> #include <asm/unistd_n32.h>
> #endif
>
> and
> arch/mips/include/generated/uapi/asm/unistd_n32.h
>
> #define __NR_read (__NR_Linux + 0)
> #define __NR_write (__NR_Linux + 1)
> #define __NR_open (__NR_Linux + 2)
>
> These offsets are 4000/5000/6000 respectively.
>
> > ```
> > #if defined(ALL_SYSCALLTBL) || defined(__mips__)
> > static const char *const syscall_num_to_name_EM_MIPS[] =3D {
> >        [0] =3D "read",
> >        [1] =3D "write",
> >        [2] =3D "open",
> > ...
> >         [465] =3D "listxattrat",
> >         [466] =3D "removexattrat",
> > };
>
> This means the array is not sparse, but the numbers
> here do not match the syscall number argument register.
>
> The question is whether tracing on mips adds the same
> per-ABI offset again, or if it tries and fails to look
> up index 6002 for 'open'.

Thanks for clarifying. I believe it will use 6002 and be broken. I
believe that'd be true without these changes too. I'm not testing on
MIPS so it'd be nice to have a fix targeted at making it work. Ideally
we wouldn't use __NR_Linux and instead fudge the id/system call number
based on e_machine/e_flags. I think it is follow on work, especially
because I don't find MIPS a very motivating use-case.

Thanks,
Ian

