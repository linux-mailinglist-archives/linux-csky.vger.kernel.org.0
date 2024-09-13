Return-Path: <linux-csky+bounces-863-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9129789BF
	for <lists+linux-csky@lfdr.de>; Fri, 13 Sep 2024 22:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D9A21C21693
	for <lists+linux-csky@lfdr.de>; Fri, 13 Sep 2024 20:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8D71494DC;
	Fri, 13 Sep 2024 20:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="NclhStDM"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007801474C9
	for <linux-csky@vger.kernel.org>; Fri, 13 Sep 2024 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726258544; cv=none; b=UbpmHC7xyNuMnOxqOUdmygDm/0jQCa2oDe4bFZPC9lDMqaQqY7Xa/H3rEtWM8j9VyODesoRO2DIuBje/s6vp66cbE9NuiemO6WxGnAo9drxrmASSDRWaGpKbovF24Pavpk+ocuDQYkAqy0GwlOIBjHz3SIP3ueBJ3P5w1qQsNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726258544; c=relaxed/simple;
	bh=wfj+NyO2O/69MLo77jEarnaBvuUhTtqSf9r0p1hDvRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCBEK+FEicS4WMAzNYAihz6FNfCgLSuCrmYrDNl+Ye2rM9eUPv5/iLX+0HFVNfvEM9wTsMkxjrfpj15Z2TzJUyT67MtdK9JCXf6DSpeENygoj/llpgVg0pFlRFk5gBugVl31Dqye+aCjVBd072IM5N1fbgXTDQucmP/85+daZ1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=NclhStDM; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20792913262so1364165ad.3
        for <linux-csky@vger.kernel.org>; Fri, 13 Sep 2024 13:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1726258542; x=1726863342; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w1FIyAVC28uVndIDT9MHoNGdB/uDnM+DRyhrjJeTBk0=;
        b=NclhStDMADg+8rXY3zMnZpgklTfAa14ssn3kbwcunDGIz8h6cP2BZtmssaHCmo+XOJ
         afFH5gBp913WPHfI2fXDd/ETRIKFQ2E+mhYvWTOvQlNDtgWxTG/luQK68hxQAeRIi0Yp
         3pLKyaSHb3rzRtbDj2Jhk8wgo81Y3Sg0bzWuQ6FR0l9TD95Esg0P/FPoBQwntMo27yP1
         upGpiwNQurnnkLkQpHmNZaTtbC0Pfyuwny6dPEuUbkIOzqlsayMfGeVb5jjH/nCu8+Cx
         Kw35OleCdW3SI017ABWPNVRfPB5EWupJtrF2RjuRb7jru2tnCpndmJ1x9Y1EOLLYXcHw
         il8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726258542; x=1726863342;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1FIyAVC28uVndIDT9MHoNGdB/uDnM+DRyhrjJeTBk0=;
        b=w2NqQbJBH7wPJm4zTUlaQNKLPPoSB1h0g4KI2y6t8Aj5C+wjr4NLB/g/2u0A3VB3LF
         ioHvsU1RqYIK8YVB8I2oReE1b76bccqugCu99wU5/2Z2scWX0ZuUU3t/jJaKt/MgnXKE
         s3PFHpsah2NAceQfApm4nEO1Er62GJ/empeD5zH4xVmwqSdC7siAkFBrdBpFKS//IwTD
         wkzxOLjWU9xZxKHJOHBh/gr27Nl0wCzKZGXxwv7KlK5g/N0UzbhlfXx0ap6ejIPTt7pD
         5SrXrRFb3jcXaMGvpyKumR7xvpwXuVFeX37Vgvu7QqqQWOm4VZCus6WdgEsm/XNMrZr9
         6Mxw==
X-Forwarded-Encrypted: i=1; AJvYcCUZ/zvWOUVZmNnjh1K8V+dkqzfUXIYtrcyOT2F7hLK9b6+gPeArNc9bbtNZ3vqrlYhm2LblEaJAXX9L@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+SwAw6WZLMezm/G9FAtGYMG0ySPYRVTSnkSY8yDYWXssgZ+v/
	GYIbO6Zk5/vzXza6QNMmgMtuF9SvrgFvbiYk1lWen3Ka58Y+kyiuh9wf0Gzr9n8=
X-Google-Smtp-Source: AGHT+IF+aNQZr3gdahRoQqk9W7f54mB5JjUQKc3RHBzDdb3qrFRnfek72JEtbqkZMIR2o3KSJzgpeA==
X-Received: by 2002:a17:902:dad1:b0:205:8407:6321 with SMTP id d9443c01a7336-20781b4740dmr63844425ad.9.1726258541784;
        Fri, 13 Sep 2024 13:15:41 -0700 (PDT)
Received: from ghost ([50.145.13.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207945db10csm315195ad.53.2024.09.13.13.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 13:15:41 -0700 (PDT)
Date: Fri, 13 Sep 2024 13:15:35 -0700
From: Charlie Jenkins <charlie@rivosinc.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
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
Message-ID: <ZuSdZ2bi1JvLJVYe@ghost>
References: <CAJF2gTTVX9CFM3oRZZP3hGExwVwA_=n1Lrq_0DQKWA+-ZbOekg@mail.gmail.com>
 <f23b18c6-1856-4b59-9ba3-59809b425c81@app.fastmail.com>
 <Ztrq8PBLJ3QuFJz7@arm.com>
 <oshwto46wbbgneiayj63umllyozm3c4267rvpszqzaopwnt2l7@6mxl5vydtons>
 <ZuDoExckq21fePoe@ghost>
 <ZuHfp0_tAQhaymdy@arm.com>
 <ZuKHpFB+uWuJe2xm@ghost>
 <ZuLIPZId9aHcAY2j@arm.com>
 <ZuNaD+zAXiAulc0n@ghost>
 <ZuQPF7Gbcqzq0U6N@arm.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuQPF7Gbcqzq0U6N@arm.com>

On Fri, Sep 13, 2024 at 11:08:23AM +0100, Catalin Marinas wrote:
> On Thu, Sep 12, 2024 at 02:15:59PM -0700, Charlie Jenkins wrote:
> > On Thu, Sep 12, 2024 at 11:53:49AM +0100, Catalin Marinas wrote:
> > > On Wed, Sep 11, 2024 at 11:18:12PM -0700, Charlie Jenkins wrote:
> > > > Opting-in to the higher address space is reasonable. However, it is not
> > > > my preference, because the purpose of this flag is to ensure that
> > > > allocations do not exceed 47-bits, so it is a clearer ABI to have the
> > > > applications that want this guarantee to be the ones setting the flag,
> > > > rather than the applications that want the higher bits setting the flag.
> > > 
> > > Yes, this would be ideal. Unfortunately those applications don't know
> > > they need to set a flag in order to work.
> > 
> > It's not a regression, the applications never worked (on platforms that
> > do not have this default). The 47-bit default would allow applications
> > that didn't work to start working at the cost of a non-ideal ABI. That
> > doesn't seem like a reasonable tradeoff to me.  If applications want to
> > run on new hardware that has different requirements, shouldn't they be
> > required to update rather than expect the kernel will solve their
> > problems for them?
> 
> That's a valid point but it depends on the application and how much you
> want to spend updating user-space. OpenJDK is fine, if you need a JIT
> you'll have to add support for that architecture anyway. But others are
> arch-agnostic, you just recompile to your target. It's not an ABI
> problem, more of an API one.

The arch-agnosticism is my hope with this personality flag, it can be
added arch-agnostic userspace code and allow the application to work
everywhere, but it does have the downside of requiring that change to
user-space code.

> 
> The x86 case (and powerpc/arm64) was different, the 47-bit worked for a
> long time before expanding it. So it made a lot of sense to keep the
> same default.

Yes it is very reasonable that this solution was selected for those
architectures since the support for higher address spaces evolved in the
manner that it did!

- Charlie

> 
> Anyway, the prctl() can go both ways, either expanding or limiting the
> default address space. So I'd be fine with such interface.
> 
> -- 
> Catalin

