Return-Path: <linux-csky+bounces-630-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AAB916FF4
	for <lists+linux-csky@lfdr.de>; Tue, 25 Jun 2024 20:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31022812A3
	for <lists+linux-csky@lfdr.de>; Tue, 25 Jun 2024 18:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C01178390;
	Tue, 25 Jun 2024 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ilfeOTiW"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8000B143882
	for <linux-csky@vger.kernel.org>; Tue, 25 Jun 2024 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719339296; cv=none; b=aJw3KC+y3mcjinYFJXJjFozNQGa5jieoyTXEpbhrsZBKohgMYQtHA5qglJovez4FWrY11Kn9JNroQCN3lYpCJK9gIncp+uktRQn//tCrTGi80JXr8S2HFTNE38XrvCHMhN9/jw91JGpTew1dbSzLAY1jYacBmSuhBhWHIQPp0L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719339296; c=relaxed/simple;
	bh=cdQG2QH6nCCll3rEP3ihKpXMBl8SgxnP/VREmcfD5Ao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e928lYVsSCdKuumUZMOUklFN66QIeUWWw5ugdiKO+QxBaaWLWD+/AFSjTN0gZ1KVox/niv8/ewLpASA3l/u0i+FPPL6XDMcQccXZlS4RsW3CHhCuRBsEZYGSMh3hvSLkr4Al+r+vkpJfPoBhg5RboV6r2UGex/u1QGq5d8vw+J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ilfeOTiW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fa3086cf25so17375ad.1
        for <linux-csky@vger.kernel.org>; Tue, 25 Jun 2024 11:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719339294; x=1719944094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHQujU8w2HsPdHSeJ+eNtyrJA2jnQulGAF+h4XWMpkg=;
        b=ilfeOTiWWiDCkMojlYgXzyqB+pgSXFWG0HocVT5g04vZ4yrJq0EA5qjbmKSEKSnu+q
         5s359fkGoLtsanHQSSR5jp5chQv3/LGsFN3Ek3u9+NlvN8IfYtvdMfiYQwaZToZ5sLs0
         2LUNchm10K1JoitnEcmKkK1mDo22zJE3VsM+sl+DeI1jxT2xD6fJoyT7/6bgGNCKyrzy
         rrp3RimpRH+scvHiNkGoYGZbUHo9tz7cx7O8xcUpMecsT39cAQXHPnKz9isg0Utt4xye
         8PS+K/h5H10mwg+Zk5+LhUZvJ81KI3HfRU4H3dVg4dNWcAtkaAUlnedLWxM/6HLvYFLt
         kNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719339294; x=1719944094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHQujU8w2HsPdHSeJ+eNtyrJA2jnQulGAF+h4XWMpkg=;
        b=RRnxlF0m/iP73oPJjWAI1F3dG5X5m01ikVPYgw+dBLBLCaGBVDoABf/l+jWSD/cp71
         NDYGd2CewViwBep5bP+w8IWZxV26StHJQUvsAwhSqMxBuNLdbLKTH3xIctfgEXHXY28P
         VCNN+XUJycKCWMhV+CaqOKU2EZmzOpiafQzQuiOYSO6+9/9k03LP1W9t43GbiDnKWZUH
         EbOLwXSRpN14yQEVY2cALedMoE2TgZrnsK2t5qMiWDTAlLiaXeZ0KbzuILiZcLejviRb
         5sEw4ZkS0cewve7v3zHPPI9m+299XrT0eQfr+7CCiKui0nFPC2UBrPVeLgBE+CFtWtKP
         yV0w==
X-Forwarded-Encrypted: i=1; AJvYcCX+4uRaYIyaVBSDPdmPRfppA5D46rUOQS6K6VIYJxphkX8/KmeDL5lgZtRoaVJdwqBDYs/NdklMt2ahaq2sFU0/mVauElEeB6lAKw==
X-Gm-Message-State: AOJu0YzlwUScz45k2psjuFWR+riFCob3JJP4jKzsbGxRDfCKhp3fj51L
	TfbhRaG9f0ejXhYgeWXSStZ1uA6NRXm6W3kIfXuLChAt5+twfsHo0O78CYRFU7NQE/mjxERqJNP
	VLpmxi1L8RbAl8sgRvziyAjlFlb7VTr3VoLZh
X-Google-Smtp-Source: AGHT+IHUWVP8jMWtzNNtwGhAuozDrDLNiGYVxTa6bvSAKS2s/Xp4TEwNkFy5eyfDDb3O7LxCBZEQyj5jnib9lTc8oa8=
X-Received: by 2002:a17:903:603:b0:1f7:3764:1e19 with SMTP id
 d9443c01a7336-1fa8886e8d6mr213265ad.20.1719339293473; Tue, 25 Jun 2024
 11:14:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613233122.3564730-1-irogers@google.com> <20240613233122.3564730-8-irogers@google.com>
 <Znnyi2IPC79jMd9y@google.com> <1fdf637d-3571-4145-8008-f2b5f8fc8bca@arm.com> <CAM9d7cjy8+Ys-Y_35V7O=KGQL0v3+B9z6hhytmAiKKN9pO9yow@mail.gmail.com>
In-Reply-To: <CAM9d7cjy8+Ys-Y_35V7O=KGQL0v3+B9z6hhytmAiKKN9pO9yow@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Jun 2024 11:14:42 -0700
Message-ID: <CAP-5=fXKLxo9VufpsvjNJ-Z+oA+6k7zYOz6qH69xSAiRA2K8zg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] perf python: Switch module to linking libraries
 from building source
To: Namhyung Kim <namhyung@kernel.org>
Cc: James Clark <james.clark@arm.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Yicong Yang <yangyicong@hisilicon.com>, Jonathan Cameron <jonathan.cameron@huawei.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Nick Terrell <terrelln@fb.com>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, Kees Cook <keescook@chromium.org>, 
	Andrei Vagin <avagin@google.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Oliver Upton <oliver.upton@linux.dev>, Ze Gao <zegao2021@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-riscv@lists.infradead.org, coresight@lists.linaro.org, 
	rust-for-linux@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 10:48=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Tue, Jun 25, 2024 at 5:24=E2=80=AFAM James Clark <james.clark@arm.com>=
 wrote:
> >
> >
> >
> > On 24/06/2024 23:26, Namhyung Kim wrote:
> > > On Thu, Jun 13, 2024 at 04:31:21PM -0700, Ian Rogers wrote:
> > >> setup.py was building most perf sources causing setup.py to mimic th=
e
> > >> Makefile logic as well as flex/bison code to be stubbed out, due to
> > >> complexity building. By using libraries fewer functions are stubbed
> > >> out, the build is faster and the Makefile logic is reused which shou=
ld
> > >> simplify updating. The libraries are passed through LDFLAGS to avoid
> > >> complexity in python.
> > >>
> > >> Force the -fPIC flag for libbpf.a to ensure it is suitable for linki=
ng
> > >> into the perf python module.
> > >>
> > >> Signed-off-by: Ian Rogers <irogers@google.com>
> > >> Reviewed-by: James Clark <james.clark@arm.com>
> > >> ---
> > >>  tools/perf/Makefile.config |   5 +
> > >>  tools/perf/Makefile.perf   |   6 +-
> > >>  tools/perf/util/python.c   | 271 ++++++++++++++--------------------=
---
> > >>  tools/perf/util/setup.py   |  33 +----
> > >>  4 files changed, 110 insertions(+), 205 deletions(-)
> > >>
> > >> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > >> index 7f1e016a9253..639be696f597 100644
> > >> --- a/tools/perf/Makefile.config
> > >> +++ b/tools/perf/Makefile.config
> > >> @@ -910,6 +910,11 @@ else
> > >>           endif
> > >>           CFLAGS +=3D -DHAVE_LIBPYTHON_SUPPORT
> > >>           $(call detected,CONFIG_LIBPYTHON)
> > >> +     ifeq ($(filter -fPIC,$(CFLAGS)),)
> > >
> > > Nitpick: mixed TAB and SPACEs.

Will fix it in v2.

> > >
> > >
> > >> +           # Building a shared library requires position independen=
t code.
> > >> +           CFLAGS +=3D -fPIC
> > >> +           CXXFLAGS +=3D -fPIC
> > >> +         endif
> > >
> > >
> > > I'm curious if it's ok for static libraries too..
> > >
> > > Thanks,
> > > Namhyung
> > >
> >
> > I think I tested the whole set with a static build so it should be ok.
>
> Ok, thanks for checking that!

Even with a static build it is often the case that the executable is
position independent (-fPIE, and related compiler options) and so
would need this too.

Thanks,
Ian

> Namhyung

