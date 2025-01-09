Return-Path: <linux-csky+bounces-1589-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF55A0820B
	for <lists+linux-csky@lfdr.de>; Thu,  9 Jan 2025 22:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EC2A166A99
	for <lists+linux-csky@lfdr.de>; Thu,  9 Jan 2025 21:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC52204C35;
	Thu,  9 Jan 2025 21:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="R0YnG8Cd"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C86204088
	for <linux-csky@vger.kernel.org>; Thu,  9 Jan 2025 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736457276; cv=none; b=KwKAnLVOBOn3tcJByFbeWcVaf1Om47mnPjXAILKSVNllKQG3Kl5t5eORaMN3oQBoHFYScIKiCJeYr/ydCMZvxNU4Bc2AJ+VIYVm7eHojx3CPOVG7m2TsA62jNNCAXAgNMsSPv+EcukDTzSByBlcmLkD/mtZTJtD0NYIveDEzHbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736457276; c=relaxed/simple;
	bh=eYzvAapvrXbZXgh9jcwIv3jWk//AlYNgrkVgN3CMHpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Efjq05CkYZLlUiUmvRqrziQA7jVCo9+dWptauT8C9SV/PLP/ehzW9RxjWDBMQ2aGW2yz2iwa6mDl1qAD7CUvuI+vGKDmwr2k6tV/qQYnB+JAjcaYkBPw8NuLt8L7IpLoAc88QcNh2ca8UH5VAS5OmJU69tb7n0pLtAztZH7VaRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=R0YnG8Cd; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ef8c012913so1840359a91.3
        for <linux-csky@vger.kernel.org>; Thu, 09 Jan 2025 13:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1736457274; x=1737062074; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rWi0Eghj3xi161PysLI0KrpGNdQD8oYgIL/QlYOb5cw=;
        b=R0YnG8Cd03KerAHlX2oRKaYHqn8UXUNqY1Kbdg/Wh5RM8yrMp7yeCQWeSO3CSqzruF
         FgACscr9401LBSlZD2DiZ5lrr6brdqokDeRVJy137hFHePapiRhQKDpA39XoThklfnuN
         ApbG5FTMlhmRIULuoSQl3uyOUdDCoPvXYhX2vnaNPKO9wXI83hUIi0KkSNbjQ2ahvl4q
         hEwNIcf7dmv9XpX8lCKggPicGUxsUAmdfa7Q4a+vj6+afo3zvvVt3QKxUgVpBVTI1y9i
         VO7CSLRfuJttSVLwyiEYVK2SdN+t1OyK0efCibNObANRqYdvB2SK2338jbh84+RymfJO
         7krA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736457274; x=1737062074;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rWi0Eghj3xi161PysLI0KrpGNdQD8oYgIL/QlYOb5cw=;
        b=YES7DPQUTMQoKQQYv+gljDaKS7esXbrL9RCTm4iXt63zKXxQiVvrB9/+rccWscln2Q
         r2+x6PnvDk0uszm8SvPgW1cnDJ97izMJUyn6AQ/IWeRg/EkVsK6CO98nruOuVFDnzKHj
         TbUJz0eUU8sVRq9OpkDMxBggMPskpTpCC/VacN7X6FcdR4Lt+jQX357+EByLdPFnEbWG
         s99TJUDQox0G2HZ4t2bWeknGBusewd5mXY1rCoO3vXNr7GCIP2jxwwvKWthNfweVdGko
         48taDbTIqQXB7E2C7+oGQ+VO56pB7qG4ogcP+lyKvpZn9Ofqq2dAMy42TcGbcxpIVrZD
         TkQg==
X-Forwarded-Encrypted: i=1; AJvYcCWyy8KT/MXf7eZvR2BH9zcqiP54qsnIYUtZ2fi85cuBwZohEMvAOMYE+7nhejpnQve18/JYy8iKN5Af@vger.kernel.org
X-Gm-Message-State: AOJu0YwvxtUw00tKuwGAyVh2eoqmpKmsWzWUqfWieD+Ta9V1iSBP5iJ4
	c5So1zDdYTcAhXFQYx6WgfKvFE1K3zu++wL7xLnkpZvwkpa8zeFhauT1ZQXR5/s=
X-Gm-Gg: ASbGncv0w9pDsAyiLh95Zl1JOJCKF3Zs38/OytHJCBcsyxQJMnpo6/2WxB+dlkLiI/G
	AgojlwQYpB91iytrooh9kqdtG5SFPLgz3sViChSy8eTBgTBvq4hT0KUZSupE14uYuaPgtHxvUXF
	hcnyU+CvCd8vj1C3I8WNnf7w4h/rGlWb7kPuT4TMe3p2BM93RoAIPdrG8Kz9ojjDslF/Qf8It27
	nNob3ME03BoikVnnk/918fNEHoBOymabFO87w337V3p2kzc5zrF
X-Google-Smtp-Source: AGHT+IGGpIFpDMCF6QbYUycaFsLmnN4FCC576ZSX1GeEVOuZ9RO46wvil+eTCx3t+IaGa75ky/Kjtw==
X-Received: by 2002:a17:90b:520e:b0:2f2:ab09:c256 with SMTP id 98e67ed59e1d1-2f548f424b1mr12478961a91.33.1736457273807;
        Thu, 09 Jan 2025 13:14:33 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:691c:638a:ff10:3765])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a2ad3b7sm4117850a91.31.2025.01.09.13.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 13:14:33 -0800 (PST)
Date: Thu, 9 Jan 2025 13:14:29 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>, Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 00/16] perf tools: Use generic syscall scripts for all
 archs
Message-ID: <Z4A8NU02WVBDGrYZ@ghost>
References: <20250108-perf_syscalltbl-v6-0-7543b5293098@rivosinc.com>
 <Z3_ybwWW3QZvJ4V6@x1>
 <Z4AoFA974kauIJ9T@ghost>
 <Z4A2Y269Ffo0ERkS@x1>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4A2Y269Ffo0ERkS@x1>

On Thu, Jan 09, 2025 at 05:49:39PM -0300, Arnaldo Carvalho de Melo wrote:
> On Thu, Jan 09, 2025 at 11:48:36AM -0800, Charlie Jenkins wrote:
> > On Thu, Jan 09, 2025 at 12:59:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > > ⬢ [acme@toolbox perf-tools-next]$ git log --oneline -1 ; time make -C tools/perf build-test
> > > d06826160a982494 (HEAD -> perf-tools-next) perf tools: Remove dependency on libaudit
> > > make: Entering directory '/home/acme/git/perf-tools-next/tools/perf'
> > > - tarpkg: ./tests/perf-targz-src-pkg .
> > >                  make_static: cd . && make LDFLAGS=-static NO_PERF_READ_VDSO32=1 NO_PERF_READ_VDSOX32=1 NO_JVMTI=1 NO_LIBTRACEEVENT=1 NO_LIBELF=1 -j28  DESTDIR=/tmp/tmp.JJT3tvN7bV
> > >               make_with_gtk2: cd . && make GTK2=1 -j28  DESTDIR=/tmp/tmp.BF53V2qpl3
> > > - /home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP: cd . && make FEATURE_DUMP_COPY=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP  feature-dump
> > > cd . && make FEATURE_DUMP_COPY=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP feature-dump
> > >          make_no_libbionic_O: cd . && make NO_LIBBIONIC=1 FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.KZuQ0q2Vs6 DESTDIR=/tmp/tmp.0sxMyH91gS
> > >            make_util_map_o_O: cd . && make util/map.o FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.Y0Mx3KLREI DESTDIR=/tmp/tmp.wg9HCVVLHE
> > >               make_install_O: cd . && make install FEATURES_DUMP=/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j28 O=/tmp/tmp.P0LEBAkW1X DESTDIR=/tmp/tmp.agTavZndFN
> > >   failed to find: etc/bash_completion.d/perf
> > 
> > Is this something introduced by this patch?
> 
> I don't think so.
> 
> BTW this series is already pushed out to perf-tools-next:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/log/?h=perf-tools-next
> 
> Thanks!
> 
> - Arnaldo

Thank you!

- Charlie


