Return-Path: <linux-csky+bounces-2530-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17FF0BE1C9E
	for <lists+linux-csky@lfdr.de>; Thu, 16 Oct 2025 08:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81BD51A601A4
	for <lists+linux-csky@lfdr.de>; Thu, 16 Oct 2025 06:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892432DE1E3;
	Thu, 16 Oct 2025 06:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f4bJPn/D"
X-Original-To: linux-csky@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639BC7494
	for <linux-csky@vger.kernel.org>; Thu, 16 Oct 2025 06:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760596947; cv=none; b=sTpbaDH3aD9uZgYq6uXq6turSdXG4RHHgW7o7ihU5TFrsR6Q+ovKuMIhUtTaQhi6Q7tMCmL3lwSAd5cFg2WkQaHnZNfbLWrdxXDNm2X0qCm6Ht1yO+3zYPz+8tJvpvY0Upjrj8o9KAiREvAWl9f/xoKCvl3OHH12lO1+ezOksOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760596947; c=relaxed/simple;
	bh=Xwymle1RI5deN1YZysEWyTkaWWkdCc1UvMTlc0d69Rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=krMKZMa+kltRRbsGIZW6e6vcq85rcapFLfYuyoPgeY6Ay5YtVJT5Y1L3YDExECbkamgx7/HL93mBcvRqkNX9Enzt6hwSKX1jIbiWBmFS42Vr4MjWY3HBu48XyWg0UjTE9BKj3QbR24Ua5JaGGoOwnsr22+9WtcYZHh1AP/L9kMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f4bJPn/D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE8C1C116B1
	for <linux-csky@vger.kernel.org>; Thu, 16 Oct 2025 06:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760596947;
	bh=Xwymle1RI5deN1YZysEWyTkaWWkdCc1UvMTlc0d69Rs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=f4bJPn/DpnUgA7kotw1MXERFp/4DM7MKCgNaU6MFBEUIc0ONsK0C8ggnZbDxnGrgF
	 tR2OtQxrBnPYCWinlOtBtwtDjSl020CPuvLETp5fANNiTf5Bfs6Hzdnoyl9CKyrtgQ
	 NzrcYMsDv/UemkZFTBxEg8VFiAxfpttKdmCV8dC8nWl0zkkLZay3Yg35RkRyqRTkyT
	 J85LosJyuWOck/ArSWO8v8f/gMj+bHLbA4LL5uK/xViAQyWaWRTYfCGAM5ZFR9Y3e9
	 Sb9riU0oWUI9afqOU9oSYVjpwZxELTn2HusteZWC1lYj7dzuXvGR9k8oX05iQj5nt0
	 9FsKAr7t4tSJQ==
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-42421b1514fso168395f8f.2
        for <linux-csky@vger.kernel.org>; Wed, 15 Oct 2025 23:42:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXCZF/2zlvar+Dmtc1RCYkncycl8EhgqO9mvBZWQ5+QQ3Zi5idKvxIsAyqPQq8H7XM8jrgwCuUi9oYy@vger.kernel.org
X-Gm-Message-State: AOJu0YzqEY9+3aI3cVsc5pnOQqy/RNP7MD81kS8UT/AMO1BwcU79q+dU
	Nk4BpwIY7TUgIUKhOc+Zyv2WhHMY6JFzwP5LCErnkF6Iq8g1Xnnp9s/UNETeTsetvxa9jcsMSqx
	2LW6l4lCf6LKbooNfwNmsOsxrDpf6WVU=
X-Google-Smtp-Source: AGHT+IGMu6/5tkdwgl3TJA54YC+DSQnG+626+3ajWtF+4ixc5KZNJofj28aYCYE+Pd1fkwBRWHURZ3ViZoPyv4GSZyg=
X-Received: by 2002:a05:6000:2385:b0:426:d57a:da9d with SMTP id
 ffacd0b85a97d-426d57adaa3mr11257702f8f.59.1760596945568; Wed, 15 Oct 2025
 23:42:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251015064759.2993842-1-rppt@kernel.org> <CAJF2gTTgG2DhqLC2B6URsNusjzcwCaxi-k=MUZTc1FTEHbaf+g@mail.gmail.com>
 <aO-O_2lhxZ8I78cl@casper.infradead.org>
In-Reply-To: <aO-O_2lhxZ8I78cl@casper.infradead.org>
From: Guo Ren <guoren@kernel.org>
Date: Thu, 16 Oct 2025 14:42:12 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ0mcU56XKFcXcxDPv0bXGWm5WXHHpTP9YE2GK67XF7Pg@mail.gmail.com>
X-Gm-Features: AS18NWAu7sEuMJK-AO5mkdGBB98AzUtrOqZ7rI9LP75NnkmgevB_U4njX0yf2U0
Message-ID: <CAJF2gTQ0mcU56XKFcXcxDPv0bXGWm5WXHHpTP9YE2GK67XF7Pg@mail.gmail.com>
Subject: Re: [PATCH] csky/mm: fix build errors cause by folio flags changes
To: Matthew Wilcox <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 8:09=E2=80=AFPM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Wed, Oct 15, 2025 at 03:51:53PM +0800, Guo Ren wrote:
> > Thanks for the fixup. If you want to go through your tree, please add t=
he tag:
> > Acked-by: Guo Ren <guoren@kernel.org>
>
> Why haven't you merged the original patch from October 6th?

Sorry, I didn't pick that patch up and just replied to the acked-by.

I'll investigate it tonight.

>
> Message-Id: <20251006-csky-folio-flags-v1-1-a91dcbdbf988@linutronix.de>
>


--=20
Best Regards
 Guo Ren

