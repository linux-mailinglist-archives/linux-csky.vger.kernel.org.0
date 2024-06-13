Return-Path: <linux-csky+bounces-531-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C52089078D9
	for <lists+linux-csky@lfdr.de>; Thu, 13 Jun 2024 18:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76A2F1F24152
	for <lists+linux-csky@lfdr.de>; Thu, 13 Jun 2024 16:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A014D1420BC;
	Thu, 13 Jun 2024 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a+7sFHAQ"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134DC1494AB
	for <linux-csky@vger.kernel.org>; Thu, 13 Jun 2024 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718297731; cv=none; b=p0QZb0R0p0zw5AB6rfrG7m5JzIMtbnDPtyW0KfLAmpd9lYsTMwdfVDS1bnAKYsyj/UJ+2lJc2VybS5yykj88IQoezhr9fTnM5w/JfmYKBdOcDhRDHNtOgol8yjLuknT7lic17mbvjAtZAUPNUjr2icUBlto4Qwq3N2805+BM3iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718297731; c=relaxed/simple;
	bh=gWJSlhXJZjDMSCMnTQA00bSbjWncOwR7ylrZc7+pEaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onMNqx6FeAMjpYjfK6CP6AooNnfugmpGoXlHk8wzP3BNtjL3ap/SE7PjMcrNscTLbphYjx3pStaT0Ff4k4CsOwG3qGYeCklKkFIh4thAXdrU/6GMUDAiihr0cs38gqVQF4O3B50xCIRht841nn+AUWHcktkd8E4oZ+kFM0kCNBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a+7sFHAQ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-375acf90c58so1235ab.0
        for <linux-csky@vger.kernel.org>; Thu, 13 Jun 2024 09:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718297729; x=1718902529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWJSlhXJZjDMSCMnTQA00bSbjWncOwR7ylrZc7+pEaA=;
        b=a+7sFHAQC6BxlkC/FLvXzSfHGQWV9f3dO45WncwWzrqJ8Wt82v+YWXTAaTou56zTey
         NAf4jxOWxKvEDuWZUtEdUusU8iut/VTxTgtnc5rLZXfjt2fFs7+kxyVumjfmgi2PzVKq
         +lWcpZI0elX8sWgH16QEUv6x0MZFQJ4G5NOIDmQj5EbkSgCnFXA4RBKB8NaxeDxNnzMG
         OTaYompsV+5MeXQIH58S1PUSdlhHYuPUoqtYgOBLztN2NFydHaaf0XddiAiy21tg27DG
         YFq0xQSfdjAMGzmZTlMByVssT/+HLjTqzz4aEYv+ZJxlxJZCOv66Gc/+I4Yh7CZIYytg
         PsNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718297729; x=1718902529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWJSlhXJZjDMSCMnTQA00bSbjWncOwR7ylrZc7+pEaA=;
        b=urYD7XYducQQnrQv42nOX5MgWhfTPKunhmdrzJTTB6E/3lXRdweUT4/V/Z3GcfC21P
         yVLGX5QFWlmYsFJhL2Q3B2Cacjc28+R0wZw0b0I7D9NHWc5/Pn4OVyLPohAWc54kR5OH
         SzqupnRfPGRgDwir3axTvBqx0CTNVQ+ZE5Iv3gcg9Y63vckxvwgSwAjLX0OIG/+EvCgZ
         rHvWDtvFKVLMoHpBZMYh88H3xaEyAV+uME6EuyRiI4du3PSURjph9vIEimV3WnvTYb2k
         kmnwlnGs2m6j3DeGsDUO55fUHzgrPs/fwQqWnm7Qj+rsQjK3sIAO+iteTlXxF85fBU3g
         xGog==
X-Forwarded-Encrypted: i=1; AJvYcCVvjN4Ux3KCPrPqlJOyzTiv1JKPtthRLAaNsbvLhRpClJhLWb20zBv07jJ6Qx3TdcHrVyswBW79Gq/gC/amqeC7D7Y6pqESW31hRQ==
X-Gm-Message-State: AOJu0YxbCkrnpUCssX26nMyawWGWlQ+nSF0o5yM/5nxCkxq/zJdj7RmT
	9Wey469hywOaMGuE9FjD9Jmr8NELHqdVRaQHCmEvFj6Xq/Ka+04d4MPybPXYnVkRnm1i4t5eJNq
	P5pVJ1TLnoQFs1TAirh2t4w1Qp9S7fEL91B2R
X-Google-Smtp-Source: AGHT+IEbV5W9YTxiRK3k2IN1ZbR6jqHOarV+ilqCrXqD33J5SW1vK2cChNhC77IN9rseAhu6xuSDZG9NUZAelZRNrZU=
X-Received: by 2002:a05:6e02:2689:b0:375:bb49:930d with SMTP id
 e9e14a558f8ab-375d73f700fmr2575015ab.23.1718297729092; Thu, 13 Jun 2024
 09:55:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612183205.3120248-1-irogers@google.com> <bdf1ab6e-b887-4182-a0ae-7653bd835907@arm.com>
 <Zmr_CfhYsvKePZFt@x1> <9814866a-8f9d-4d82-ad2d-4b36203aa196@arm.com>
In-Reply-To: <9814866a-8f9d-4d82-ad2d-4b36203aa196@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 13 Jun 2024 09:55:17 -0700
Message-ID: <CAP-5=fV9DW0X+BD0qZEkHJg4-JrLD+yttqQm1mw2NKAY19rPZA@mail.gmail.com>
Subject: Re: [PATCH v1 0/7] Refactor perf python module build
To: James Clark <james.clark@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
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

On Thu, Jun 13, 2024 at 8:10=E2=80=AFAM James Clark <james.clark@arm.com> w=
rote:
[...]
> >> Reviewed-by: James Clark <james.clark@arm.com>
> >>
> >> It does require a clean build to avoid some -fPIC errors presumably
> >> because not everything that requires it gets rebuilt, for anyone who
> >> gets stuck on that.
> >
> > We need to find a way to avoid requiring the 'make clean' :-/
> >
> > - Arnaldo
> >
>
> Do we need to make it so that if any of the Makefiles are touched it
> does a clean? I'm assuming that was the cause of the issue I experienced
> here and that the Makefile and/or Build files aren't mentioned as
> dependencies of any target.

Perhaps we can do something with the FEATURE_DUMP. It'd be nice to
detect build argument changes and rebuild when that occurs. I'm used
to doing lots of `make clean` due to sanitizer builds, something we
should probably capture through features and/or `perf version
--build-options`. Anyway, out-of-scope for these patches.

I need to cut a v2 due to failing to add the new `.a` files to the clean ta=
rget.

Thanks for the review,
Ian

