Return-Path: <linux-csky+bounces-336-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD948437FC
	for <lists+linux-csky@lfdr.de>; Wed, 31 Jan 2024 08:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F47E1F217A5
	for <lists+linux-csky@lfdr.de>; Wed, 31 Jan 2024 07:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4069A537F8;
	Wed, 31 Jan 2024 07:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qugRA3lU"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8785C52F67
	for <linux-csky@vger.kernel.org>; Wed, 31 Jan 2024 07:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706686675; cv=none; b=ruXz0KX40YFFRtDunG8+KT1YBYl3lHOg/V4Qvy7FEgqH1NLD0pnIM7SV4N4QfGwxBGS1W+CXQuKodFZW012OP2dFAp2LSuBzC/lTbODUaeyrUoDOlrE+NVW7tPvJnaPrM0sRl/NVPdw8g/8rESBSoleQSekGhNNORPwEHRpJElk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706686675; c=relaxed/simple;
	bh=TmG+rznpqqyErX4zfSJ54u90o8JuQXslthwDpqEjAiI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gjpir74ZXkMz3CJCak0VJ+GLJ8ccjrhuZ3CvfBcDH3S52K5aOmv/nWvVieIFmIrYkfCxXNQbDNEv9uec6uI7apA4pQUxhyyyjWok8dQtA+z1zZOocCSg7LtzBVXqLENTsIMORcWtsjAb2hXbt3lJn9Qv2StnmaGfWmkobzBlDbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qugRA3lU; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6040d0c9cf1so3027767b3.0
        for <linux-csky@vger.kernel.org>; Tue, 30 Jan 2024 23:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706686672; x=1707291472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmG+rznpqqyErX4zfSJ54u90o8JuQXslthwDpqEjAiI=;
        b=qugRA3lUGE+4iv2RbCrW9rOiaw+w1w3TnSsPYDomTVfsIhBg2yT8hCDktaLzV3YGPN
         WBPsoZOl2KfuIr0rENOH+XOCCEeDvC3sZczUAKUMtG7ZqIdeEaKs1yFvO/WULHi4fXYc
         QXg/hYuy920fMaLiFZcR5MURBY0NKyO505nTAXQiC2yHNPMZ2aENuRnHDJlfmFVDwVJl
         7qt9yIFqWkVfGto8L5BeZSTJ3GlnL8D6EaEgkKMbzlDnoa/G03OPi52x9soysoVd0wst
         agXaaPO1fxdI4jS0s22srNBdAFPD1+vYng+hLso2Z0EQi5ud482G+YaHuHAD5CMh49p0
         UHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706686672; x=1707291472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmG+rznpqqyErX4zfSJ54u90o8JuQXslthwDpqEjAiI=;
        b=B+dgTH4DW5t8kKvV3xh0F/kbEffiYF8cY3MWKGoYOVD9qVactLsS6kfIepdClLcRNK
         GsAUv15dfuHR5NhAWiRDK5EdaMPl8SLrQqc7OPP1PfVvJNciB0/YlUp/A+szHFPrsW1u
         koyP01LLtmaDBnGqYbMh2xs1JtMMUXHWRPV4P2GUKPQ9GOkwDCW/yffXuJWma0UAaron
         HtGZkl80suve8MvLICmtS1CynOKk895ipmNlt36Ek4fPhvdbyklaUvnCePSvjtkO4Xnk
         xzCnb3MZqNjUhAGBXjVVZGpX4jD/Fqo1a2i6UM0o9VWhvcbjVRZyEv4SmCOVAbalFsM0
         g1XA==
X-Gm-Message-State: AOJu0YyM0HGosJMYPSuqJxvikaZJQQS8hhxuG27NCHLyZ0VTOr7s1eH4
	wWHagG/+uG4fmtSmRyIlo2EX0tL+YXl91VnC/DThgBxQBbsCFgMu4/7W83uXuLN8M5bMfE2ZYVs
	vWD/nleCPA0W7ctIXIcpRGP41oEXfDpw7eJ205A==
X-Google-Smtp-Source: AGHT+IHYpXRaWLqQlh0oX2pZAjMnT3Ad18mWcU8jYVwFB0aAGnyeiCdKxqpu+uBFZ0ub/5leFryzgJhdACbtZXLSvtQ=
X-Received: by 2002:a81:c545:0:b0:5ff:a52b:55ac with SMTP id
 o5-20020a81c545000000b005ffa52b55acmr594058ywj.34.1706686672385; Tue, 30 Jan
 2024 23:37:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131055159.2506-1-yan.y.zhao@intel.com>
In-Reply-To: <20240131055159.2506-1-yan.y.zhao@intel.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 31 Jan 2024 08:37:40 +0100
Message-ID: <CACRpkdY6dS_sedemVk-fGzhsyT_B5dXAeFX-PO+GcvCrt9Je5w@mail.gmail.com>
Subject: Re: [PATCH 0/4] apply page shift to PFN instead of VA in pfn_to_virt
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: arnd@arndb.de, guoren@kernel.org, bcain@quicinc.com, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-openrisc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:25=E2=80=AFAM Yan Zhao <yan.y.zhao@intel.com> wro=
te:

> This is a tiny fix to pfn_to_virt() for some platforms.
>
> The original implementaion of pfn_to_virt() takes PFN instead of PA as th=
e
> input to macro __va, with PAGE_SHIFT applying to the converted VA, which
> is not right under most conditions, especially when there's an offset in
> __va.

Ooops that's right, I wonder why I got it wrong.
Arithmetic made it not regress :/
Thank you so much for fixing this Yan!

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Arnd: I think you can take most of them through the arch tree.

Yours,
Linus Walleij

