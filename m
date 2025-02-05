Return-Path: <linux-csky+bounces-1748-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A777A2837B
	for <lists+linux-csky@lfdr.de>; Wed,  5 Feb 2025 06:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184E4188500E
	for <lists+linux-csky@lfdr.de>; Wed,  5 Feb 2025 05:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5C9C2EF;
	Wed,  5 Feb 2025 05:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eoixNFmE"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F2A25A644
	for <linux-csky@vger.kernel.org>; Wed,  5 Feb 2025 05:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738731628; cv=none; b=olo8KHJ1i+x7h/X3pEkMZHEC6yUWpp/20m2lxWfefVQ0//ccaJau4drx8SD2NAUuHzqfwiZ1Id8rjsAd8V+OPsUEGvUu2oMdNn6e3OlUytoTkvKTHqLMDVnREZequ2CkUz2qBKuerY3IxAnYyDmEhnu/CFbdzpPnfWrxfvPKoIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738731628; c=relaxed/simple;
	bh=XoHgY57qdbAKv8uWUYNfx7XWO/S0+Vz8NkbzUcrg87Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ENaBprP7HeEVhQiRGk9LDaYEIZSfuCn5tca3u6J735T843oTDjuz6ntTG2hsCUGTrhOiDsVQnVrshO8xi+5S1j4E6yo41FtiSrWsr0qqYxIe6OC1INwDyFbTXhkRpTjweOd7ofXvuAOLuzd9hYyptf432J+N92BruBbTtz9yv+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eoixNFmE; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so212575ab.0
        for <linux-csky@vger.kernel.org>; Tue, 04 Feb 2025 21:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738731625; x=1739336425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBrAJ33Lv27IH622MIOkF0t5tIX46ic8QrDeWtn4wec=;
        b=eoixNFmEX68JlxnaYLurIKdqSWOhSiGJFSzu2jmHgNx4kp9zODr2UWmTF5WgWROV+Q
         uwFpL7fpkiQRKWB+fexlIztGvecToTC4VckpUkN6yphGA7BiCZboWGN9fr5Zg1DrsPqD
         VBS1ip6QSbd4dSi+Yf8+2Dah9KFyGqKJHbqj8V0BZLtIbLQCIdcvxmzeq55QhU+4LqRV
         Nfrc6yrxVZq/l6AJ/bVD6SJoX4pOcoKmt8FBHGjZ3ZYtC+G6bS1iLmWu4jIDVhwK89vN
         5RDcVvsD1CdsPHB7XxfG1lJ32bZxpRkufBKTd2+eVT94S8VeZgXDv93+ow6Wu6yI1QmE
         Lz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738731625; x=1739336425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBrAJ33Lv27IH622MIOkF0t5tIX46ic8QrDeWtn4wec=;
        b=L84lJLgxuJClVXsg7mcizZK/9nkUxbBn5nMZp0/Gvh+hZitO3SMMYJhx7bweVRJHwM
         QjrshVrYrqNluL8Fi6/pAFLnDjun0lKPArPJTsmkcTNAp/WeDhwmo7pHqaMNVgZE1qzE
         v2ihHLRm2SouguoErSC6ybdmUdNP35In8KhDK5wJpecn1Elq025n/5eh4Y3T9QhL6X2K
         IMDAlYByFR0ekAK7REBEwo+eXq6+nQyPFKnvFmg1YCAVxv2NDOf723+4V9JYwaKYiSpu
         C+WzKYqSeWp6+T7Df4dhD3mBIIMIScGwjpp2OuERXFKXCTP2K+qt5Ue+ZgGZP8O3B83j
         HqBw==
X-Forwarded-Encrypted: i=1; AJvYcCUSBHNr9LWXnFcJLlPTm1Wk86Q+dsQXl5mjy7qzmd6/YpF5CFpIQBq1R2QMdQMfYACTt5amYLzgYDQp@vger.kernel.org
X-Gm-Message-State: AOJu0YwxTYYqgA0rOQUgIdICd/Jr09V7ZoefBN9LqG/yNDChe4K72Zox
	fKfhDOdLKux0MF4Pb01xCpdFhNO+LOtS5KSZV6W8NR9Y/HtT6VJl04zHcmv3HUI8mmNjgGkxGlZ
	jK6fvuO6D2vO2R4YDvanGXkoOO7oHyXL7VGrP
X-Gm-Gg: ASbGnctP7NecRTEbZhy8OJLr8nAMaHy+KLGwQJwJioN1YrcGCvUY22fSYmXDDzzjcHg
	OJ/7NJvZUf2Qx8zKc78tX747MUWIEiN22hkHKEBh71L96RLplfZqNXaObbKmqIvAi4BoHO1eS1Q
	==
X-Google-Smtp-Source: AGHT+IE5v6UIxUtbhZWXvQ6xeQiRfsd1Lh1y3K7nKT+DdV2MV+Ch6CX6fJX9kXWxtmkarMn0roBxr/1rIM2Ik8IIu/M=
X-Received: by 2002:a05:6e02:1f0f:b0:3cf:c98a:ceba with SMTP id
 e9e14a558f8ab-3d03fc6611dmr7494995ab.22.1738731625326; Tue, 04 Feb 2025
 21:00:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250201071455.718247-1-irogers@google.com> <20250201071455.718247-3-irogers@google.com>
 <CAH0uvogeG9rUw+1huquE=8fEq8AdJaSygS94G8a05=cHckjndg@mail.gmail.com>
In-Reply-To: <CAH0uvogeG9rUw+1huquE=8fEq8AdJaSygS94G8a05=cHckjndg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Feb 2025 21:00:14 -0800
X-Gm-Features: AWEUYZlxJYAftveNvjFByQ6RA0wq7gWZe-nwQuI2bmCaSivCz6TrVnDN2aRhlBs
Message-ID: <CAP-5=fX1bePwr5QGZQAMxWv1zvBY3dxOhbMd0H5UYQDXMrSKMQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/7] perf trace: Reorganize syscalls
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

On Tue, Feb 4, 2025 at 4:12=E2=80=AFPM Howard Chu <howardchu95@gmail.com> w=
rote:
>
> Hello Ian,
>
> Thanks for doing this.
>
> On Fri, Jan 31, 2025 at 11:15=E2=80=AFPM Ian Rogers <irogers@google.com> =
wrote:
[snip]
> > @@ -2104,11 +2123,12 @@ static int trace__read_syscall_info(struct trac=
e *trace, int id)
> >          */
> >         if (IS_ERR(sc->tp_format)) {
> >                 sc->nonexistent =3D true;
> > -               return PTR_ERR(sc->tp_format);
> > +               err =3D PTR_ERR(sc->tp_format);
> > +               sc->tp_format =3D NULL;
> > +               return err;
> >         }
> >
> > -       if (syscall__alloc_arg_fmts(sc, IS_ERR(sc->tp_format) ?
> > -                                       RAW_SYSCALL_ARGS_NUM : sc->tp_f=
ormat->format.nr_fields))
> > +       if (syscall__alloc_arg_fmts(sc, sc->tp_format->format.nr_fields=
))
>
> Makes sense because IS_ERR(sc->tp_format) is checked a few lines
> above. However, nr_fields can be 7 with the __syscall_nr prefix. I
> sent a patch to fix this, but it's not included here... Never mind,
> it's off-topic. This patch looks good.

:-) So is this a reviewed-by? What about the other patches?

Thanks,
Ian

