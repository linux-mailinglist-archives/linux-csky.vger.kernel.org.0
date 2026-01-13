Return-Path: <linux-csky+bounces-2704-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E06E3D18BB6
	for <lists+linux-csky@lfdr.de>; Tue, 13 Jan 2026 13:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 506C83008144
	for <lists+linux-csky@lfdr.de>; Tue, 13 Jan 2026 12:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721F638F94B;
	Tue, 13 Jan 2026 12:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCrBvpZe"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCB138BF9E
	for <linux-csky@vger.kernel.org>; Tue, 13 Jan 2026 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307610; cv=none; b=I7kU7grP24jErIpB7bszTZ0lzC5+bndnPIGbKyY/CKP1Nhghn9qaIYqPsQOTh81TVcCjskBTKK+Q46QBkrR3uo8lfVps9DzuOjXolY/P0ryvcS/KK71gCvzCoRQJA/6SQtroVWJPL10Ivp4wH+H6kLiITxN3phA3q9FSQFHIIq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307610; c=relaxed/simple;
	bh=c2pQGNsmx4TXSTG4ks/OmiO2LMby6F7I6nhF1Yls93E=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=HZenKxVEGwtPIZUh5K9lNqSJ9Bj33kS0TMJJ4sjS0PxaGIjYUAOY/Ee+iWSMbOdEoUDWJRYUKugz+WhAUC4zGXt2SbUTdyjzKOg/Dh/f+j2iK2ifQN/8wpvg1ORh1dhow8RjmARw3WLM5vg2ruW/wu7pK+n+uA/gFKWe5jaEJ9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCrBvpZe; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34c27d14559so4255628a91.2
        for <linux-csky@vger.kernel.org>; Tue, 13 Jan 2026 04:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768307607; x=1768912407; darn=vger.kernel.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j4BCb4tuwUydlXX/lekB/MWAbo5xTWmBY98lhxIZgCk=;
        b=GCrBvpZeucBOdNpJseUbRKNa77J3jEjSKSr2rQltUiOSzioURb4448Kr9GVdc4A4M6
         EeRxRTsOfiRVNkUEGN4mkvBWr7+cqibFBBnbNCpse52V2sMsMNI9lEm95Cnlek63otZl
         syjrb7MRSUA4zfswNNSYnSNoKl7QdqKysebTzPHBsCeNlTTSfvgjmp0e0FuW/B95Alst
         oe/iuaWn7B8uGt+o/gTqlwZd0wTuqVGIQR6mFwzUCdAVrz2qHLtEl1u3M5lND7sa/YIo
         WJVxnqKjY+DdRZteDSadMj1yuf/MI2IqhwEjkDmLAD+876PYUwT4dDvY2csrpor9dpk1
         na4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768307607; x=1768912407;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j4BCb4tuwUydlXX/lekB/MWAbo5xTWmBY98lhxIZgCk=;
        b=pNTwv9jNawmw60xetqiQWnAOn3sBI3DIvBg2x66VdPC724uvH4hSDmbLOBnGvCjAYv
         4hgViGCx70Hc0m/3sBzn309L2VU8J6CQp78X2dfaHI4tjlMC2aYW0U4Eihwx0A7fuRVu
         eDfVvmqCwKAneeH/JCIpQNt1k72iAyfElyZxJoMBdrchl9IcJ3ZRtLBdTJN685Wi/bgs
         C0cPjAB4sCVwCcZ5KQ3phsjDaTsFCebbVnlVQ4/1t5PYhef4QRV95/zrscdmbAZplWK7
         44nHs2HefyKbRz5R5mWheUEOuUxYXQ0Vg1DR4kOZgKTNFzWTgYvitnTdP/rtygw3pKjB
         GvhA==
X-Forwarded-Encrypted: i=1; AJvYcCVS93cF+YZ4Vxd7MYRGPOhJTHo8jU6GnYkgCl1ePg2mpzZZK+fh5LvPVz1Bia565e8oxt2D8MW1LICK@vger.kernel.org
X-Gm-Message-State: AOJu0YxesUqtXRXxriLIBK5ehTzwm0dNtnGp0unebO7+o0LXj12jwuHo
	VjoPfxbPLBRGwrKhD923bHUCdVgrQ8rgvYcF2kUWnAJT49n61IJZh8II
X-Gm-Gg: AY/fxX7OoApAKkM3UiJpZf4MG7QxwqLSf1res1jzZ0Rksc2K4vz2By2NA4GlzyEj3so
	bGlrtfXsNa7BLVCgYeykE6+kOI4P/PM40+HZbQ0286FwDv7YjgVDRWmxvjMwFkZo1keeRUESrPL
	jaSN6mpcRQn77HpAAQh8NMvjlxtAzl1Zz7TDixt8pdaF/bv7Qldlr1E4atgoHS7YsdnAl5sk7xH
	KbwINb+/SU8S0h2Abew7ETdrZ9utwbeQoie9SaG+7a7mACtzKqy0qA/IVBpISERyEiQEI/5Bm0m
	+Wax/B/xZGGJMZ24NiU4GPn9B5ijJuxDEAuftucJm9ybklrzWDaKvVDLhwC+80m+iuldHZGqCtD
	au/zDJrT+CloDil4ZOcvLWEQ2i+tKJkO/5cH9nIdi38DwZ4pr1spL5y48sqCO3L8OMgU3f0Z7Mu
	fxHSe8
X-Google-Smtp-Source: AGHT+IFw8NQUhXWsNFLNcy9VnhtaeqSccMp4bageDierszWlx1Kxyih6osyfD1+uAcqTN4o2oK4SYQ==
X-Received: by 2002:a17:90b:3ccc:b0:340:9ba6:8af4 with SMTP id 98e67ed59e1d1-34f68c47f0amr18570023a91.35.1768307607428;
        Tue, 13 Jan 2026 04:33:27 -0800 (PST)
Received: from dw-tp ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-350fd6e343bsm1428958a91.1.2026.01.13.04.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 04:33:26 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	Klara Modin <klarasmodin@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 15/29] powerpc: introduce arch_zone_limits_init()
In-Reply-To: <20260111082105.290734-16-rppt@kernel.org>
Date: Tue, 13 Jan 2026 17:59:49 +0530
Message-ID: <87zf6hu24i.ritesh.list@gmail.com>
References: <20260111082105.290734-1-rppt@kernel.org> <20260111082105.290734-16-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mike Rapoport <rppt@kernel.org> writes:

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Move calculations of zone limits to a dedicated arch_zone_limits_init()
> function.
>
> Later MM core will use this function as an architecture specific callback
> during nodes and zones initialization and thus there won't be a need to
> call free_area_init() from every architecture.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/powerpc/mm/mem.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)

This v2 looks good to me. 
I have also done a basic bootup testing using Linux PPC CI.

Please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

