Return-Path: <linux-csky+bounces-846-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CB7974783
	for <lists+linux-csky@lfdr.de>; Wed, 11 Sep 2024 02:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2856B2889AE
	for <lists+linux-csky@lfdr.de>; Wed, 11 Sep 2024 00:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7D2182B4;
	Wed, 11 Sep 2024 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="HRG7/y+a"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D3417BD9
	for <linux-csky@vger.kernel.org>; Wed, 11 Sep 2024 00:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726015515; cv=none; b=dcYlL4+gX9xX18Ody7Z+RAgkAQzYq4eb581BEQvi8D33nIR+QngGfE/3m86JiLiR2bvXkq/0vbS1yULUcCghMc0dYHeA4YKvsFPnApM1CwKTg92iXJNM3cy7l+gn7UleQQadLmayvtm04S9bL/lzmZlsH3qvQ6A4NjPPCycb+GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726015515; c=relaxed/simple;
	bh=8uhBmyPDd+dw+VI5uhVYY1EG3bpNisgmno6ZxW+y4TE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NT2tc5pUK4Ds7068Xi5ti4R1151PTvyMgjecOmgVIDCFPEZOwu9fMKzJvG/ctcOflaU92cdCirSCDSQVsRtkJ3xpuadHrC23f5F18Fi1d76q8+eqYhugB23McNwl0UxhafmdSlWPuEaE7W1FuFR/qsfl12pI4DCFgoSkJORKpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=HRG7/y+a; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2068acc8a4fso58807595ad.1
        for <linux-csky@vger.kernel.org>; Tue, 10 Sep 2024 17:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726015513; x=1726620313; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N9UqXwHRW6ngdlKfPJV8zADUN4nB1bOhg7HrFQqhnhI=;
        b=HRG7/y+aX1MXBuj4PxCAfrJQARzvotcj/icoF4vbUzZN0X3VaPtSQAhpGkfukLxuJf
         OGWcaVOFerPLWqviXmrUTxPFQvhRFuM1MCcd0S8EMK9H0Du6nuh5Mpuxa2xLksqKZCHL
         EwEdRZB6gFHzy3tNDLeWGmXTQW874dnEa1W4JPqaD3gYXhMsBlhk2nZlD/75wrLIOKXK
         qQKs2husBROsrfAkb15B2yWo/Q+BbAWJG7P2I6cv7jy7N2tKWqKUREjM9xt+/3PTTxGU
         7jBrbdNwyu+VbnJO6Dj5QYrcg9xWRPBfKKBvT+V12UGZyUTXl3lt9IhOO7aUqicV3OLH
         gqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726015513; x=1726620313;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9UqXwHRW6ngdlKfPJV8zADUN4nB1bOhg7HrFQqhnhI=;
        b=WSVNqiTIwKhFoSvC6HY49Hso4N7o1BwzrxILicf4AJw+/qoPXok07Rrz6P2Sb31JiS
         Ldzkh45P0jlXLR15EQ2LyiUs0tJ2ZoDUG0TNWx4TKIMkyrctSv35x7asYrwv6IvqfqtJ
         VEnjgD7/Js6nWnOuzd8DwypYwKLYJ+n8ztM+FoxIL6N9eNo1HudgZ+kU9/5MkIZYxjEs
         orCD+TkBcGA120Yml4u9JgZIugsRyRxJ9jMw7Kz+iproltED/6eWX3p8hhpkut1LFubv
         5nLHBwNYd+w7GPkd/UfOCJ57/nqWwn4B6cL/x2LL+reqAq74AnmQrT4GNaXPYNQDugcK
         xa1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWoNz+3wf8LYxscAk4y6srBEafK5Ii+OMu2tTOBYMLp940w80jCoJUvZLvdFXs5pbyhBtFjnutPal18@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3VaTj40fgYO7DpAd1x0o5W7gBNzpHpVE7A6BdIS1rj9WLX9eH
	W0axGGBxuXga/zo5RvqbGt5y0MqiPgBSSI4IWyW1Q+ElpVsQrLuNKTa7hlHHByQ=
X-Google-Smtp-Source: AGHT+IFSjrtRoDoL7sPwVRBWFNV85MfE4DpNXnElb7X54mGXN2iqCTI2uhxpyL/CAIcKh7QAswSthg==
X-Received: by 2002:a17:902:d2ce:b0:205:5427:2231 with SMTP id d9443c01a7336-2074c6a338fmr45444085ad.47.1726015512680;
        Tue, 10 Sep 2024 17:45:12 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710eef1f2sm53832165ad.145.2024.09.10.17.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 17:45:11 -0700 (PDT)
Date: Tue, 10 Sep 2024 17:45:07 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Arnd Bergmann <arnd@arndb.de>, guoren <guoren@kernel.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>, Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
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
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	shuah <shuah@kernel.org>, Christoph Hellwig <hch@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	"Kirill A. Shutemov" <kirill@shutemov.name>,
	Chris Torek <chris.torek@gmail.com>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org,
	linux-abi-devel@lists.sourceforge.net
Subject: Re: [PATCH RFC v3 1/2] mm: Add personality flag to limit address to
 47 bits
Message-ID: <ZuDoExckq21fePoe@ghost>
References: <20240905-patches-below_hint_mmap-v3-0-3cd5564efbbb@rivosinc.com>
 <20240905-patches-below_hint_mmap-v3-1-3cd5564efbbb@rivosinc.com>
 <9fc4746b-8e9d-4a75-b966-e0906187e6b7@app.fastmail.com>
 <CAJF2gTTVX9CFM3oRZZP3hGExwVwA_=n1Lrq_0DQKWA+-ZbOekg@mail.gmail.com>
 <f23b18c6-1856-4b59-9ba3-59809b425c81@app.fastmail.com>
 <Ztrq8PBLJ3QuFJz7@arm.com>
 <oshwto46wbbgneiayj63umllyozm3c4267rvpszqzaopwnt2l7@6mxl5vydtons>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <oshwto46wbbgneiayj63umllyozm3c4267rvpszqzaopwnt2l7@6mxl5vydtons>

On Tue, Sep 10, 2024 at 03:08:14PM -0400, Liam R. Howlett wrote:
> * Catalin Marinas <catalin.marinas@arm.com> [240906 07:44]:
> > On Fri, Sep 06, 2024 at 09:55:42AM +0000, Arnd Bergmann wrote:
> > > On Fri, Sep 6, 2024, at 09:14, Guo Ren wrote:
> > > > On Fri, Sep 6, 2024 at 3:18 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > > >> It's also unclear to me how we want this flag to interact with
> > > >> the existing logic in arch_get_mmap_end(), which attempts to
> > > >> limit the default mapping to a 47-bit address space already.
> > > >
> > > > To optimize RISC-V progress, I recommend:
> > > >
> > > > Step 1: Approve the patch.
> > > > Step 2: Update Go and OpenJDK's RISC-V backend to utilize it.
> > > > Step 3: Wait approximately several iterations for Go & OpenJDK
> > > > Step 4: Remove the 47-bit constraint in arch_get_mmap_end()
> > > 
> > > I really want to first see a plausible explanation about why
> > > RISC-V can't just implement this using a 47-bit DEFAULT_MAP_WINDOW
> > > like all the other major architectures (x86, arm64, powerpc64),
> > 
> > FWIW arm64 actually limits DEFAULT_MAP_WINDOW to 48-bit in the default
> > configuration. We end up with a 47-bit with 16K pages but for a
> > different reason that has to do with LPA2 support (I doubt we need this
> > for the user mapping but we need to untangle some of the macros there;
> > that's for a separate discussion).
> > 
> > That said, we haven't encountered any user space problems with a 48-bit
> > DEFAULT_MAP_WINDOW. So I also think RISC-V should follow a similar
> > approach (47 or 48 bit default limit). Better to have some ABI
> > consistency between architectures. One can still ask for addresses above
> > this default limit via mmap().
> 
> I think that is best as well.
> 
> Can we please just do what x86 and arm64 does?
> 
> Thanks,
> Liam

I responded to Arnd in the other thread, but I am still not convinced
that the solution that x86 and arm64 have selected is the best solution.
The solution of defaulting to 47 bits does allow applications the
ability to get addresses that are below 47 bits. However, due to
differences across architectures it doesn't seem possible to have all
architectures default to the same value. Additionally, this flag will be
able to help users avoid potential bugs where a hint address is passed
that causes upper bits of a VA to be used.

The other issue I have with this is that if there is not a hint address
specified to be greater than 47 bits on x86, then mmap() may return an
address that is greater than 47-bits. The documentation in
Documentation/arch/x86/x86_64/5level-paging.rst says:

"If hint address set above 47-bit, but MAP_FIXED is not specified, we try
to look for unmapped area by specified address. If it's already
occupied, we look for unmapped area in *full* address space, rather than
from 47-bit window."

arm64 on the other hand defines this as only being able to opt-into the
52-bit VA space with the hint address, and my understanding is that
mmap() will not fall back to the 52-bit address space. Please correct me
if I am wrong. From Documentation/arch/arm64/memory.rst:

"To maintain compatibility with software that relies on the ARMv8.0
VA space maximum size of 48-bits, the kernel will, by default,
return virtual addresses to userspace from a 48-bit range.

"Software can "opt-in" to receiving VAs from a 52-bit space by
specifying an mmap hint parameter that is larger than 48-bit."

This is an inconsistency I am trying to solve with this personality
flag.

- Charlie


