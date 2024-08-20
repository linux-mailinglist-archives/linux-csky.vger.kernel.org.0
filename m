Return-Path: <linux-csky+bounces-717-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF29957AC8
	for <lists+linux-csky@lfdr.de>; Tue, 20 Aug 2024 03:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 986BDB21D35
	for <lists+linux-csky@lfdr.de>; Tue, 20 Aug 2024 01:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FBC517BD5;
	Tue, 20 Aug 2024 01:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M8tciThC"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F9617BB4
	for <linux-csky@vger.kernel.org>; Tue, 20 Aug 2024 01:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724116306; cv=none; b=KJx7U28OE7rlY72W2sZcqNRCxLwE1VhKks8FSNoGPLXNXr9zknDdgt6o4hHaga8kfvPT4sB9u40YAkV9jZV+s07Y83hcCZRCfve8YfqCnWXZK+Q5QMMTa9Y/N4oKjfNkkEI/xEfALV8I5nTnmssSBkD8NhzDjsClCunkL26Jyjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724116306; c=relaxed/simple;
	bh=UwkZsnmFTogapUcvQLNdDygak09Kfc+DA1y61X4GWs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iIcJ21TjhMkxSKV+4gyF48dB0SwuAAzkMGKgy9GIiGmqsxSTc0P8tf+zTEUIubl4LRkPPK987/8f/yrfxRPcKt4NQP22VgYwM/yjLNeX/mmcI+aQVjpvwkDb1ij1w1WxQmHpxmY3fXafYBPYEBARseP+zCJqo14UeeXBp9cuHoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M8tciThC; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8384008482so522590966b.2
        for <linux-csky@vger.kernel.org>; Mon, 19 Aug 2024 18:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724116302; x=1724721102; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J5Wu1obaVVIh98VUfFJoSH8iTiA4TVMtHy8zZl6wgS4=;
        b=M8tciThCantUf8M8ylGjJtmxwqi0G3UDoMXXpmv6Wf9oAztIPKebEGw87434fE4sux
         2QvRjnUICjrDj22eWAdPHzOe2wT8B2XgiIjCLk+C02cdNT1ozSJtRUL+BHWiup4FGlbq
         ObpO7Pk3SNWeE8rdLjJHmrjGCvgkZikHIY92s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724116302; x=1724721102;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J5Wu1obaVVIh98VUfFJoSH8iTiA4TVMtHy8zZl6wgS4=;
        b=QPQeb9MEOxkuulrNyv41uGtPAQGRALGoe3rUMS74L1XQ4pw+tIUXgucGz1nNTq29jX
         aRMMwmQJA6D6663K07Q+gkBHugH+vXc00ULPnRl9nbplZ+EOdchINYu4QfQMI2hw40hb
         Q2nfCR6WGlTQnLUTmtKoXSFCy/00ZGGxZdIxLgtAZYZ9wkNHwd3wJ2b/s4DmfCtY2ADA
         jxaVP7MKB1hOahPn+r3yZ1wVWD+MLgYHeDtPecRUB/ifTS3dr/7susJIb6ac1jIbVv8p
         NfRzAY9A43Fy5vsG5JRxKkTMhgjz6Ey5i+Low32WVmCPWXmqWRL0/rUJTjkRtWR4Ssrm
         IvDw==
X-Forwarded-Encrypted: i=1; AJvYcCVW6Ypmk1fDO7/A0l3Krcd0pvPpdCcaawHclf99boVXDam7dbboXAU7V7YmQiDh4ov8XE2/bfqNHSSzpuyQAgE9XIV+vCzzRVZQYw==
X-Gm-Message-State: AOJu0Yy43GLoVVJQhxHDmYDYGSw/a2avJjLNhsq5dMZPrGrrHZexfpLD
	knMrJ3nrrj1tGYleGUKodZEoFNaAkGPKEGPWr/2oLHsiBZucq1bp+BE5PIFpNCz5CQd7Blxg64A
	qMDOBlg==
X-Google-Smtp-Source: AGHT+IGV3SgohcL2H78ycQI9l8CvGbEkDmOR25MO/RZjuJUiehaI7Hd9YSRiudPdzPG89jc+QbQO3Q==
X-Received: by 2002:a17:907:94d4:b0:a77:c314:d621 with SMTP id a640c23a62f3a-a864795da15mr42864466b.13.1724116302228;
        Mon, 19 Aug 2024 18:11:42 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8383947b86sm698317566b.187.2024.08.19.18.11.41
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 18:11:42 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bed0a2ae0fso3995725a12.1
        for <linux-csky@vger.kernel.org>; Mon, 19 Aug 2024 18:11:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX8XeQPdHitAo9G09zGQyedBkRCX+3Ilr/HRMk+EEfiawlLdoUbAkmFlIACQI2MPnsQfa7w5K8cnwRPYenD578I0hsqDYWMIzQY9Q==
X-Received: by 2002:a05:6402:1d50:b0:5b8:f69b:65e8 with SMTP id
 4fb4d7f45d1cf-5bf0cfbca19mr536978a12.0.1724116301657; Mon, 19 Aug 2024
 18:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com> <20240819180548.9f5dac3ac0bd09a26c0d0948@linux-foundation.org>
In-Reply-To: <20240819180548.9f5dac3ac0bd09a26c0d0948@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 18:11:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiyxQMG7gK5d=_UEcHF2PV3EoCFrENEhRvJH9Qsk7cOeA@mail.gmail.com>
Message-ID: <CAHk-=wiyxQMG7gK5d=_UEcHF2PV3EoCFrENEhRvJH9Qsk7cOeA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, christophe.leroy@csgroup.eu, jeffxu@google.com, 
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, 
	oliver.sang@intel.com, pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 18:05, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> >
> > I forgot to actually attach that "this". Here it is. For real, this time.
>
> Thanks.  Do you think your one-liner remains desirable with this fix in
> place?

That patch actually removes the whole 'legacy_special_mapping_vmops'
that my one-liner then removed the '.close' field from, so no - my
one-liner just becomes a non-issue.

NOTE! That patch of mine *will* conflict with Michael's patch series,
since my patch to remove legacy_special_mapping_vmops was done on top
of my current -git tree. But it should be an obvious conflict, in that
it just means that the addition of .close never happens.

               Linus

