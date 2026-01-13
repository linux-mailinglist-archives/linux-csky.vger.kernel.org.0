Return-Path: <linux-csky+bounces-2701-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2433DD16E5B
	for <lists+linux-csky@lfdr.de>; Tue, 13 Jan 2026 07:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF9A53019B6D
	for <lists+linux-csky@lfdr.de>; Tue, 13 Jan 2026 06:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27850363C56;
	Tue, 13 Jan 2026 06:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDminwzO"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7763F369229
	for <linux-csky@vger.kernel.org>; Tue, 13 Jan 2026 06:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768287054; cv=none; b=nfZCKDyrUloljOrBj+CTSueuuvlI5SuoyuKtbj3WNRpAeKCdIlUfcOY2oPtnmBssa1BV4gpkALKOY/IQ/Mb4Qgp9/gyv+xI9bZqLKp8bISKWOT2x059zUpgzlSzmS1POwtx4twIXAOhtxnHXpDQSgy+Fs5O4rwSHVwpr9HvKRzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768287054; c=relaxed/simple;
	bh=aDB3sdHl8yEvBSscr99tVhZre5iBP2s4Ktcd0fugEGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWIye15Z8VMFAsJ557EQqfdANiJhMGp3WkZcxM7TTnHoHlxEkgJ87D97a/HOpTSDetf4OAppPqEVjkpr3j4Arjm/HyAiI8xvGFp7X3g/QcJjQ3lfxH4JVt/aO2G3b2X4HEk5KiYXijm5VUUDRWsQaMJj3QcRJGUYRl048lH7ZBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDminwzO; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88fe44cce7eso56304186d6.3
        for <linux-csky@vger.kernel.org>; Mon, 12 Jan 2026 22:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768287051; x=1768891851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vX59/flKMUDb8zjb/CqTAfKlTuGyJwgf2lJ9POWv81Y=;
        b=aDminwzOmtGELvrpXwoJuF8Vised+qClS8KGMqtYTJiKEfsIaa5dWb3jmtAob22nDv
         twjz1EHrcgyDKfjRZ3Twgh4sHntR+paZs4j/WrWXcezBL5h9pZB+Y35Rpaoqj94bzJLH
         LzUJJDummWcO7+Fu9vmEXHAqMtN/RgAVNL3HVVVJ/KA9KgjbQbJw9SJjv2T+owOdJrSI
         gKtqBri2R3YLCNaWnzW1ZZwYkw5Kz5JavRwotg7jJ9otywgfhsKptyFtV2uULx+3+Hx6
         ffuyj5L+UjDyfUNovCLPg1y4mFHEIYGqp2qIrLLjXqPRk7VyPT1s4YT3HU1to52g4vnP
         AqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768287051; x=1768891851;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vX59/flKMUDb8zjb/CqTAfKlTuGyJwgf2lJ9POWv81Y=;
        b=R0ZA8P9nbqJJAZPLdzOxAI7LYxJjNWSYjppdO0t1Vw0XXSkYGyl7N4oX88eGyRW5wi
         oM6ORYBp9MQVNfAU855DD8yi/XhB0RAh+llHxZ+pm6Mx7Jt9+5G9lVCzP0Mbeeofn/rP
         4xTUxIpQCLU7lP9dY/JdY0CUlcPHYYNa+iars5SRwWbP042qCkdFwcTSgAKZsDfotuaO
         bsJWdFuCQqZb2nTnZQ0QLGzeTzCctmfJ9H9Z8rDJ2z/qpFqcsdB1X3l2d2aMG9ygHdUI
         Kpj2f6uL2ga36e7SlTxW0FGQKPjQVn6v5+cFPE62yw3lSmgqXOFb3Fc+2IW0W1RApeg5
         pHYA==
X-Forwarded-Encrypted: i=1; AJvYcCUdlLZy0MRrjksB4pXLEyjJ0at7XD40oQyGoskekzLL1+2iAVcxfaUbJzaNUL2PtuAimlSKDRVlyFML@vger.kernel.org
X-Gm-Message-State: AOJu0YxdBIh+sVG04Ddf0pwyOcRD42KjaeenmBDLSG8REdiGIqkSj/bt
	9qdjIjERFDxZ69Rn3zMHnKqL/WQxHn70XoUgwNDe9daTy5D/JLsgscbw
X-Gm-Gg: AY/fxX6LIcNFWUcd7aNUOHzI4yFImhr0jodWk2i1sQsZnVh5/EqvFzel1mkeGAxRL92
	+ThB7Ox808wb2c4c+3U5ULXOMK8Cq3apTLmw/N36RbXeMM18Qd8mZSAXCxNNB7c9cebynmVnPiM
	SZP4kKwCW8ReXR9rIYLrUpWHTXLjv5MhADIIue5ba7F2Jz+5P28UuOc5Q4DEw0VWqHWmQ1TI4kE
	bUjMSPRYNVpmD2/Uj1jRzrFkXWqPeLdIpTcqv9MgPV6sCMknHuVOTMzJgwijfP79jOtppdjNSeh
	TlDuERn9yg0HPY6vuP3+7PeyxL8SnmPNyNSLr7aBHyM2M8izwTL4ETl/gK5YmuPNP6OBHKE8mtG
	fNHGeMCRqNFmY3dhzi2UxRDnp37+op900nQUoDLTnhbm+FFw9gJRT9mUicdcijJ3YCGOtp0OKqD
	ZTvXGYlbXCtwZQjPN4J2D+8Vi5Ki+8IpgjIuwtWwdMPxh3QshZVCKhtcQEDw==
X-Google-Smtp-Source: AGHT+IFA85MjM1cnTGL5nks8UTBaUTRvSeGOw/MqVWENdA/8we2okwkLgNeF33lCoaLlOIlw7RP7mg==
X-Received: by 2002:a05:6214:4291:b0:888:81f1:a05e with SMTP id 6a1803df08f44-890842d1be9mr273660036d6.60.1768287051243;
        Mon, 12 Jan 2026 22:50:51 -0800 (PST)
Received: from [172.20.10.9] (mobile-access-c1d2ca-216.dhcp.inet.fi. [193.210.202.216])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-890770cdfb0sm152433806d6.6.2026.01.12.22.50.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jan 2026 22:50:50 -0800 (PST)
Message-ID: <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Date: Tue, 13 Jan 2026 08:50:33 +0200
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/29] arch, mm: consolidate hugetlb early reservation
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>,
 Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Jonathan Corbet <corbet@lwn.net>, Klara Modin <klarasmodin@gmail.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>,
 Richard Weinberger <richard@nod.at>, Ritesh Harjani <ritesh.list@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-alpha@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-mm@kvack.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
 sparclinux@vger.kernel.org
References: <20260111082105.290734-1-rppt@kernel.org>
 <20260112142323.495fc43e662e7d276b0fa371@linux-foundation.org>
Content-Language: en-US
From: Kalle Niemi <kaleposti@gmail.com>
In-Reply-To: <20260112142323.495fc43e662e7d276b0fa371@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/13/26 00:23, Andrew Morton wrote:
> On Sun, 11 Jan 2026 10:20:34 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> 
>> v3 changes:
>> * fix empty_zero_page initialization on arm
>> * fix ZONE_DMA limit calculation on powerpc
>> * add Acks
> 
> updated, thanks.  I'll suppress the ensuing email flood.
> 
> Kalle, can you please retest sometime, see if the BeagleBone Black boot
> failure was fixed?
> 
> Seems we haven't heard back from rmk regarding
> https://lkml.kernel.org/r/aVrUDeSkqqY9ZCtS@shell.armlinux.org.uk.

Hello!

I will test this v3 patch ASAP and reply results here.
Collective sorry for the delay; I have been busy!

BR
Kalle

