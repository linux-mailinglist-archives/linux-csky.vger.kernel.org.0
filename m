Return-Path: <linux-csky+bounces-1236-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352DD9BC022
	for <lists+linux-csky@lfdr.de>; Mon,  4 Nov 2024 22:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAAA4282859
	for <lists+linux-csky@lfdr.de>; Mon,  4 Nov 2024 21:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1DD1FCC7E;
	Mon,  4 Nov 2024 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="uKqG2jrk"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070061FCC6C
	for <linux-csky@vger.kernel.org>; Mon,  4 Nov 2024 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755979; cv=none; b=n7OCnH6L/dYgqbaboyEZrb14huUGK77oIBVVILV2NN8N9jiW+Em7dmo3h2zAD53AQZ5TXH+AZhYtLJsT2waw2ld/zKB+5Z/tSuATbh3gk/7rJD7u8udHyWspQ3kALn1O2h88iaaJ7DFaCSwpcnUBny2XwpNETew7rKaYRaNIU3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755979; c=relaxed/simple;
	bh=fdBVewMiYACcHTkjuVH8eoAcByaa4rdMJHtffZ8NRzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CirRnbjRuj+EmxV+3d4meLQAPm7pEpHoRjeuDf0v6Oqr206qEzWox9SK2mHT35k72wIh9Pof5LkCUMcFoGn56Ac+z9o75LdG443dTPuv4EUM/LpUGf96erkXPEVHX4oWVqAlhJsXTi/aNTZGxQnMnvM970z5tuCMCLJd0be9LEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=uKqG2jrk; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-720be27db27so3767365b3a.2
        for <linux-csky@vger.kernel.org>; Mon, 04 Nov 2024 13:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1730755977; x=1731360777; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EzIIL5jV51s8QxZDArUoUfDkcHu/NNqV1EZULNrSbms=;
        b=uKqG2jrkpUbqp9onmjHwE05Gj/mClK5YVTKtwVC640w8OrdgAtBYJhzbhQ+BndMu5j
         qMcRQfAtI/EgCWGBZhLufrqBlbWL57fGQXTh624wUksdZHq9Mp3unmS7p8RHhT/rFPAS
         En20N+I9K4R2J0+bJ/ofplkIffJjBNNLpzqq8a4E1G3r3aQ0IKG9uBF50TGzax9RFBhf
         ZmyERaLGBfwetqYNL7vLn6PJ2O0rgqgPDtDeItioJ5bXCGhgmJXoG0Li/6AktWNwj39P
         TJfCH3emoc/2U0mowVBjsGTXg+gyAcXCbPENsK1OmLyNfPDzpNhpaEt/4WxLg3k4bxpt
         tvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755977; x=1731360777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzIIL5jV51s8QxZDArUoUfDkcHu/NNqV1EZULNrSbms=;
        b=eUqqrbDN9hwGSOnaXYMRlhghAoYG7Yl+4UZcM8Tlk8s1I7GTyWO5NTZ5hyWdfp3gjk
         wGpYDHrrexrWqpTcEF25tLJRZSb5+0NpzYgqV33xElu2vHYkOcNBgqMgExOGmr+mJOpm
         4E+OWpkqVLk5Lge6NpknkjuxoV/WIZOmdsZ1K6bIbA3q1dWIOfKi+Mc066Mg/A3hpULB
         Rkye0QnMmBf8tbSCKdr8WSJiSYfyXhKd+5IbnFP8Y0Ujnn5QeQDIOrn3STg2VTicaugX
         OOXbf7DlPHHopF+XJHir+zPeIKoInDIgvQTYmGi3WPEUDwCz15ChS4U8dblVzWh6HkzG
         GJig==
X-Forwarded-Encrypted: i=1; AJvYcCVvRb+k4flYTfcr/6kYAHmFwctS2zmnUv1MiAn3yhFToMd9ymChY+EMWbsRrjPcWjoaN3JQ9mRCP1Kg@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Zs80NIke4nK4+/Px86ZTCxjoMwBM43paM7qbwAugo8++5qCj
	0yqreq7xdNMd9LU47jY+rz6ZS+O4VaRjINY8zbtnjGZeUjww3JY7GLzr3H2Dwko=
X-Google-Smtp-Source: AGHT+IE1gCnZHDhbNSzOxIsLAwqp2zm4KQPfqsRjT/TyxizeRL+Gzx/ZXVxE+GJ5uzuO8nBhG5XzOQ==
X-Received: by 2002:a05:6a21:9993:b0:1db:d8df:8c4e with SMTP id adf61e73a8af0-1dbd8dfc276mr7417523637.12.1730755977373;
        Mon, 04 Nov 2024 13:32:57 -0800 (PST)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1ef7d9sm8114469b3a.83.2024.11.04.13.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 13:32:56 -0800 (PST)
Date: Mon, 4 Nov 2024 13:32:53 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>, guoren <guoren@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFT 00/16] perf tools: Use generic syscall scripts for
 all archs
Message-ID: <Zyk9hX8CB_2rbWsi@ghost>
References: <20241104-perf_syscalltbl-v1-0-9adae5c761ef@rivosinc.com>
 <3b56fc50-4c6c-4520-adba-461797a3b5ec@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3b56fc50-4c6c-4520-adba-461797a3b5ec@app.fastmail.com>

On Mon, Nov 04, 2024 at 10:13:18PM +0100, Arnd Bergmann wrote:
> On Mon, Nov 4, 2024, at 22:06, Charlie Jenkins wrote:
> > Standardize the generation of syscall headers around syscall tables.
> > Previously each architecture independently selected how syscall headers
> > would be generated, or would not define a way and fallback onto
> > libaudit. Convert all architectures to use a standard syscall header
> > generation script and allow each architecture to override the syscall
> > table to use if they do not use the generic table.
> >
> > As a result of these changes, no architecture will require libaudit, and
> > so the fallback case of using libaudit is removed by this series.
> >
> > Testing:
> >
> > I have tested that the syscall mappings of id to name generation works
> > as expected for every architecture, but I have only validated that perf
> > trace compiles and runs as expected on riscv, arm64, and x86_64.
> >
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> Thanks for doing this, I had plans to do this myself, but hadn't
> completed that bit so far. I'm travelling at the moment, so I'm
> not sure I have time to look at it in enough detail this week.
> 
> One problem I ran into doing this previously was the incompatible
> format of the tables for x86 and s390, which have conflicting
> interpretations of what the '-' character means. It's possible
> that this is only really relevant for the in-kernel table,
> not the version in tools.
> 

I don't think that is an issue for this usecase because the only
information that is taken from the syscall table is the number and the
name of the syscall. '-' doesn't appear in either of these columns! 

- Charlie

>      Arnd

