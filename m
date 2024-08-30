Return-Path: <linux-csky+bounces-751-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A7D965487
	for <lists+linux-csky@lfdr.de>; Fri, 30 Aug 2024 03:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E775B2487B
	for <lists+linux-csky@lfdr.de>; Fri, 30 Aug 2024 01:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD1E20B20;
	Fri, 30 Aug 2024 01:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wG/GnapE"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEC5219ED
	for <linux-csky@vger.kernel.org>; Fri, 30 Aug 2024 01:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724980284; cv=none; b=NRS9ef8rh5RURvGI7YNAj6bMh5NyjIRZjYINsP7uU5a7lfQq9R+9j1OQRzMNBp+hbpJmMsVMJ4Q8nkhYuigYnsX1/rIdh98KL8Dozew3e1bpFDJRB7cNl8gd07u6iHD2gLxLvaDi7wPoxJLxWTNWGMXrUZnJSlySHrvhgVa+Vqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724980284; c=relaxed/simple;
	bh=MrgzYaNv9tfxCz/b25set1/A6ngJCYD0Yc3OqKIklYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxCC9wz5NDKuXpuhkU+YvK3va/7/MriS6zxtfn3pmfhsEjciTY3jGTS5FpWPlukqzGpnd/M8inIaJNZniZEmghAoYWlDKgyEx6GREldxROE4QI4PSOBh6KQ5RwkbEdC9OAVS/pl7y3b9Uj2f77X/yp9zFMifli2LpeF5Fgo4ktw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wG/GnapE; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7141feed424so1110095b3a.2
        for <linux-csky@vger.kernel.org>; Thu, 29 Aug 2024 18:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724980282; x=1725585082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Tq7LnGnCY31W8p33KfA4sDocR34ueQ+QZ1h3PRF4p6w=;
        b=wG/GnapEwLHbEyKcJmzxvKtRGmYjwGVysg7PJHif3TqN8a56GUiYQQAEi1x1py/YTA
         FV8qOSmf7cCUDSAYsgWssRsqgwgjT+R+C3lw5AcW/D4F3WB8DP3glfG4Ox25MLA2d57l
         cN8mBspujDVd4gdg7iDR1eSRtVj4b7VDzIbpU8W4LGXYuodYbjWLiB8LBavzFwpGPMtZ
         YodNZWH3+K7o8gza9mJmw2lbJTYFBzCX/Zi2Y38frEDDG6PxqXtloZjl1Kl2RW0UiLlR
         TblUInA9DOnSmUVJZfpRVWt3wgpNcR26OgnEe0zyhCji44W3zhItWcjNckWQx4Ev0rYM
         /NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724980282; x=1725585082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tq7LnGnCY31W8p33KfA4sDocR34ueQ+QZ1h3PRF4p6w=;
        b=YywIaPDmjWf/2d+9NAIHCAvqEK4Wa56Bl8OwqYNorm6Rgjeg/R1iGYdM/KmrGD4wJA
         sGb5TuvLBxIC8u9sgWeqNoyhocVZIXInjk9Z8UI0eP/HhncHyBuce8y2Wx207eMjHEs6
         VHbbFVnxwCIsVU4uipeE2pWz2fZpBq9wxbZUbKMx3Z0jWNt/AdVOaEtHPPNebvC42nlZ
         nQla/nUokPNtj4GvorAw7hZe0Pko/U8r3YB5z5ThT90YCPSSapDeUQ5ID5FpsAphkfFq
         a6YpGtG00UgvGUP8mfMFN+Yn2cV3QzZ0YR9NkVxqh8fXrE/UCBsH1gAIHL6OoOhotuE8
         nHFA==
X-Forwarded-Encrypted: i=1; AJvYcCUDKSoIMXyJOeBAdL+ejYarP8ihaM9JGEAutKg9wEzTCWkqSCk9Q8KVYSeDybj6zXKu7CqOm+87hocv@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm6JUOCuaQByMC7uRFB/HcvMn12UZ0gyHFSeE/SK3XrihpiTUN
	a+6k5NDU0F0ky7gV+5kgcZTUWv+H90d3HM/JfqnvPXn/yiZMi6WElMixYJxStBU=
X-Google-Smtp-Source: AGHT+IE/hxSbHJa0ey/qUAU4qMZr2Egy89hZiorh32Md7TMXE2itSwqfJ21BnW0A2NKOMSU/XYMAJQ==
X-Received: by 2002:a05:6a20:c78e:b0:1c0:e49a:6900 with SMTP id adf61e73a8af0-1cce0fea52bmr4390650637.7.1724980281696;
        Thu, 29 Aug 2024 18:11:21 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d8445e8f72sm4900654a91.20.2024.08.29.18.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 18:11:21 -0700 (PDT)
Date: Thu, 29 Aug 2024 18:11:17 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>, Guo Ren <guoren@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Shuah Khan <shuah@kernel.org>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC v2 2/4] mm: Add hint and mmap_flags to struct
 vm_unmapped_area_info
Message-ID: <ZtEcNfNMfNTzkHEF@ghost>
References: <20240829-patches-below_hint_mmap-v2-0-638a28d9eae0@rivosinc.com>
 <20240829-patches-below_hint_mmap-v2-2-638a28d9eae0@rivosinc.com>
 <0454187e-3e01-4af7-b193-07468ffa8934@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0454187e-3e01-4af7-b193-07468ffa8934@lucifer.local>

On Thu, Aug 29, 2024 at 09:48:44AM +0100, Lorenzo Stoakes wrote:
> On Thu, Aug 29, 2024 at 12:15:59AM GMT, Charlie Jenkins wrote:
> 
> [snip]
> 
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index d0dfc85b209b..34ba0db23678 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1796,6 +1796,9 @@ generic_get_unmapped_area(struct file *filp, unsigned long addr,
> >  	struct vm_unmapped_area_info info = {};
> >  	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
> >
> > +	info.hint = addr;
> > +	info.mmap_flags = flags;
> > +
> >  	if (len > mmap_end - mmap_min_addr)
> >  		return -ENOMEM;
> >
> > @@ -1841,6 +1844,9 @@ generic_get_unmapped_area_topdown(struct file *filp, unsigned long addr,
> >  	struct vm_unmapped_area_info info = {};
> >  	const unsigned long mmap_end = arch_get_mmap_end(addr, len, flags);
> >
> > +	info.hint = addr;
> > +	info.mmap_flags = flags;
> > +
> >  	/* requested length too big for entire address space */
> >  	if (len > mmap_end - mmap_min_addr)
> >  		return -ENOMEM;
> >
> 
> These line numbers suggest you're working against Linus's tree, mm/mmap.c
> has changed a lot recently, so to avoid conflicts please base your changes
> on mm-unstable in Andrew's tree (if looking to go through that) or at least
> -next.

I will make sure that I base off of mm-unstable for future revisions.

- Charlie

> 
> > --
> > 2.45.0
> >

