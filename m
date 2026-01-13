Return-Path: <linux-csky+bounces-2702-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 311E6D1807F
	for <lists+linux-csky@lfdr.de>; Tue, 13 Jan 2026 11:31:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64B303020E72
	for <lists+linux-csky@lfdr.de>; Tue, 13 Jan 2026 10:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E4D283FCD;
	Tue, 13 Jan 2026 10:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThSzAiAX"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857FB320CD1
	for <linux-csky@vger.kernel.org>; Tue, 13 Jan 2026 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768300186; cv=none; b=Pme2xjujXHTwXGgq61R0N1pDSnWvjffpHYYXCcDLa1I04b2mVIjYrIPQDI3qxiGrqk7Ej/WcIRDK1PEAKa4mPcIW4sCmzjLaPA5kru2e/lICqmHXXjL2lgWtaxTGErsCjLf/NwcMQrIXV7dt1005iIVj1+OBZIAJuDcornJqwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768300186; c=relaxed/simple;
	bh=39NtxAeqpXvhawaLycQSgS8a7QXmm9U/xmb9EyW+PGc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=pW7M1qNIQn5PVKpdGTRBDc5RoFF5v3Gh6QSwv+Waj051zjphm/1Gx9jb6YwusDKeXbimyO894Y9+G+YlA34eK0+ZzQFW3WmIu7fKAeHocZR5LWUZrjl8ziSgJC3BAI4saWnEdNNZw5LD6ehlVAzOlV5/FaZ8RtOBYFatyi9tSr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThSzAiAX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-59b72a1e2f0so7226610e87.0
        for <linux-csky@vger.kernel.org>; Tue, 13 Jan 2026 02:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768300183; x=1768904983; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=ThSzAiAXO+Iq1/qA5JoumwzVO1YaXFjleaZ/xKsCPHRKCMeffIPJJbToHpvogD4GEv
         R7NkLDWS0XMWkL0CLl3Kz1d81KU4ojQxlIM4eYkExcggWWT5ocs7uTThtXIpm7MeiUlI
         fcYuy2VBmatej6vOQh3MTY9eK8hdJQwiOjI9LvHZ5R1Ugq812cVKVceVk89wGd4YrgRL
         o3+yd05T0Uox+bshyewjfqCINU1nUtQU9Oj3iMkwzkqbLhTCD6agZuy2Nu5oDGgbw24A
         ar2sMuSaP+tnQByrlwBwVYlPjAAoP9H5PMODqlggLHaR+GYjztmW7pxJj9R0f1r6HxnL
         +R0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768300183; x=1768904983;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VgnN5gtqEe3Q1O0kTTet9lBrugKrM6JP8dsQeWrl1xo=;
        b=P045gGvmmGWwcG8oJy++cYfLd3Zzx0e0DORHR6OE53tN/382QzVA+soUGnQuwTvK36
         rUhr2g99yrlRVS2jWsz3E3Gc0IXpBj2LdWOARLdLBnalu7c6OB/u9lxGEZdmhJaYgpvN
         ZA9HnMTzehiRLda96mavC7jBrAMdt0E+2tEC4UtLsT3OjgEz3E7Ue+sbJHGc3JaWRMNL
         LnvwLYoSX29dznQ5ujYYrd6aXa4gDCq5q4s+OPNBtCRx/nyDkpPi4Q5iRc9ovK9RqDFt
         OTeegTk4YHAscCQ5DAvHG+VGcfut+k8lzCQtPVWJO70lu2PISW3kgO0mMP3FuKDbPgYA
         4hvg==
X-Forwarded-Encrypted: i=1; AJvYcCXmFoopzDmB7RU9KYw+wCJWLltXlTV50o6lHR3Wjjdoy+R04XLyXNQnlv6ihIScGAsR9DWstWn0hcb4@vger.kernel.org
X-Gm-Message-State: AOJu0YyDf0dDPcx/ZAdUY2jeTedn/XDc6qiJhmvHnzTiJWRm/mixA/bF
	XzaEQD4Jn/Jaz/2r01umUkKOeXW5l/wHmJjQhDsm5Itb5Pt3yKJv7Hwpjd27bA==
X-Gm-Gg: AY/fxX4CkOIZ2xGEQl0AdBlwNnvIOJLSSTTKgkqnNPAUdld6M9lh9m2HqshWowEXSHK
	fJbKvEqv7tcsGOLcEz24GWDOyDdHcHNxceaFCKWAEt1wokNpQe1ZUNf9G3+Y6v7iF2oNzUJHt/d
	C+NG/HwQrjv8n4FA2Pp0rJi4ZY8z9ZXCev2qPSBWxD3q3dXd6LlY4aMmYtVJWuu/suvfmndg9xW
	eS53Gm11g6yYbsDF+wuEHtEzFOBycrj7/P0B+7GCtWU4GfD13mDCBcUkR4l6RlWMWgY4fijvLDR
	IbQwsCC1wuci+0/NgseXyPwiGhGYQzqLWH98frfYsNMfviiEqI5x6WZTevR087dij+Wmbf8UspI
	QYGCaMJBiaNrOsQeRTbHnClhOOnZcfCnxOBq6PgXy9dXby2RlZuj8R2iQEj7Y3q0W+Np0fpwdRJ
	H7pfYuCyw3z17bSiWqJYswgl1Q/kbbGQY6BGqNWVdlfaeByfgW+lpjBr3lUQ==
X-Google-Smtp-Source: AGHT+IEOoK2sWcGzQ5k4NJjsFR/RmdeWAB9vvZrFfNJ0u+S6dsEFK74/fdYnqiqEV2XmHMt6sJ390w==
X-Received: by 2002:a05:6512:138b:b0:598:e851:1db3 with SMTP id 2adb3069b0e04-59b6ef05760mr8236951e87.11.1768293628066;
        Tue, 13 Jan 2026 00:40:28 -0800 (PST)
Received: from [172.20.10.9] (mobile-access-c1d2ca-216.dhcp.inet.fi. [193.210.202.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59b72f3ae82sm4416299e87.71.2026.01.13.00.40.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jan 2026 00:40:27 -0800 (PST)
Message-ID: <f861a1c6-7ec7-477c-bc42-f9aaf6724bed@gmail.com>
Date: Tue, 13 Jan 2026 10:40:22 +0200
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/29] arch, mm: consolidate hugetlb early reservation
From: Kalle Niemi <kaleposti@gmail.com>
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
 <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Language: en-US
In-Reply-To: <86b974d7-cabd-4913-b5f2-5b62b520e023@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/13/26 08:50, Kalle Niemi wrote:
> On 1/13/26 00:23, Andrew Morton wrote:
>> On Sun, 11 Jan 2026 10:20:34 +0200 Mike Rapoport <rppt@kernel.org> wrote:
>>
>>> v3 changes:
>>> * fix empty_zero_page initialization on arm
>>> * fix ZONE_DMA limit calculation on powerpc
>>> * add Acks
>>
>> updated, thanks.  I'll suppress the ensuing email flood.
>>
>> Kalle, can you please retest sometime, see if the BeagleBone Black boot
>> failure was fixed?
>>
>> Seems we haven't heard back from rmk regarding
>> https://lkml.kernel.org/r/aVrUDeSkqqY9ZCtS@shell.armlinux.org.uk.
> 
> Hello!
> 
> I will test this v3 patch ASAP and reply results here.
> Collective sorry for the delay; I have been busy!
> 
> BR
> Kalle

Hello!

I tried this patch by cloning 
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=hugetlb-init/v3

Boots succesfully on BeagleBone Black!

BR
Kalle

