Return-Path: <linux-csky+bounces-1449-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB4989FE28F
	for <lists+linux-csky@lfdr.de>; Mon, 30 Dec 2024 06:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEE83A192B
	for <lists+linux-csky@lfdr.de>; Mon, 30 Dec 2024 05:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F285176AA1;
	Mon, 30 Dec 2024 05:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AVwYCuks"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06063161310
	for <linux-csky@vger.kernel.org>; Mon, 30 Dec 2024 05:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534907; cv=none; b=LLk5D5oNpkFcbR163jBIEmJSbumFYoVQO/Mht4kaHEYCjE7TvE2eRvZJlVCY/a3n7fRPETGmXidmVisl1lvzq677nZa6HxaXXp4S9eqzIL/tPP7d3PqgtS4VLMjpKOJAFqyLwbxne7kuw20wiSEHs4QC6DI05iU955pB69Xj/fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534907; c=relaxed/simple;
	bh=piyHCVVAMwS1wQEyd4KrwKqNTu7KlhnDsmo79+H7v/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7BGSoZP+V6LSGE9dDikaujfpT/faaUPBfKry1zbiM5qjsdpnBGAflbXZmlahMakagRz5uft2DuDC0yPgA8xvr6UoIG9ArSTUBw8o4ZoddkYyrQ48Rapo7tYIe1/b4RRmaidWQ6idvPO6Ggq7u/k/cFO6TStgXJAlWMharsLq30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AVwYCuks; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21670dce0a7so14276145ad.1
        for <linux-csky@vger.kernel.org>; Sun, 29 Dec 2024 21:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735534904; x=1736139704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z71RF7AQSzzvF96cC/aV2tD8Znb4DG916rBbscUdZ1I=;
        b=AVwYCuksyL4MWKNaOrcPqCsZHjP15dUO7Ft7whW/+MGucPq2CCF41ayT8HETt/nEMO
         INyXiKOGq8dtgD/nwAjk5Uvbn/UNo6jLG8qZLyqXrnJTAdRzC7Kamk4u5TtkyRp8o3/A
         +1Rvh7mPtO96ubOzkKZmD+51Gvtwp7vYJNHB3SEvUmi7l+9dL+Z3crf/xHOccAuBwsfd
         k1c3oolBT037qU5KPaOm4MllAPqW3k8jlJDhTFXsAr7VPyZz5sI+gBdqLOmCO810bvI/
         2VnuL99Nd7JF3vQY+V7vuf4tXweQBDZ0VLv7S4ip/DrVWjK5G//bmm3zSbnYRAqLIFvz
         XWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735534904; x=1736139704;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z71RF7AQSzzvF96cC/aV2tD8Znb4DG916rBbscUdZ1I=;
        b=YIgbi75CoYOM4Bm5b1s9fTsee7pdAGdgHKPWpWl4ENlI/1FR9iXyoeKtyNfiLYXcLV
         ADXd031/wPAKYkSb0MbVwfj6SgxOB0Zug8814Njk3zW+KOTvIZyl86pLXNOysKsRpJQz
         u8Ti9LIl/SJAxsN+7Ew+N2A+OTmetNkKlfkzT10CjoSNxP+KUoA2mOHwAUYgFyz5AmXo
         WpDMSjfHZWEY1or65X8BmDwRRFhUUk4wJvUOb8Fu5SPzWWCkFh7S6sZcFaFeaZIf0P0F
         CWIWrlXZcZlTHkKL8KGj+DqbwKMTOttQUjx6WyYNJRcyUIxyPHVEgkG9xGhDOIq7l0zR
         NIxg==
X-Forwarded-Encrypted: i=1; AJvYcCUxeCmLUAbmnl+ny1JnNsoi47DG59B7LXTd3cO/lvUYSHpYawCqJ6CndcZE+qnAcOFdQK8BVG+f9AJo@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4fjG4E6ZInPFjyP8dsnjFqZoejIYwaKy/tHcwAEwVBXuc3EBY
	wafnC26bEnqvTGYy4SFkLY6kMgDKqjsubBLfMwlJUA6SkMenitBiB/y4BekAMF4=
X-Gm-Gg: ASbGncu/UhUGAWjp4L6oZuwD/V2B6QhHYge3T35BLUzngk+1LMMebXfEmHUQJfNYA8t
	yFftiAT0k15lIccsB4z2puI0WDmlxSsa6TPdt0fk7/6j3imKIK98glNAdshnVzdE4oybsot+jPo
	nvhAoMtqoA92ioFBBuWzAWUYyLwTYHHgnQOfES1KNHuA/IMpDhhAYwf10jM6y6f1qfs8+laB5HY
	5V2SaDVe98qntEJ6UsuYzQqCUY2xhtm7JnX1U+cPL8s7oPxYQg0Cz6Qt4TXxvGBXVMNMUEMDY11
	r92TPQ==
X-Google-Smtp-Source: AGHT+IGNJA4bVLowcqsTNcTKWXSt9C1oo/1EXH42Qr0z5K3kcPv3AzGfuER3K4niOaxH4y3G0nd6hA==
X-Received: by 2002:a17:902:ce86:b0:215:a57e:88e7 with SMTP id d9443c01a7336-219e6e89215mr362710865ad.3.1735534904325;
        Sun, 29 Dec 2024 21:01:44 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba7325csm16914771a12.7.2024.12.29.21.01.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Dec 2024 21:01:43 -0800 (PST)
Message-ID: <efd81018-f637-4925-9104-c9586fef688c@bytedance.com>
Date: Mon, 30 Dec 2024 13:01:29 +0800
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/17] mm: pgtable: remove tlb_remove_page_ptdesc()
Content-Language: en-US
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>, kevin.brodsky@arm.com,
 peterz@infradead.org, agordeev@linux.ibm.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, rientjes@google.com, vishal.moola@gmail.com,
 arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
 <b37435768345e0fcf7ea358f69b4a71767f0f530.1734945104.git.zhengqi.arch@bytedance.com>
 <Z2_EPmOTUHhcBegW@kernel.org>
 <9cac5690-c570-4d43-a6bc-2b59b85497ae@bytedance.com>
 <20241229205545.e4fa797886f30cb20c38ad06@linux-foundation.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20241229205545.e4fa797886f30cb20c38ad06@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2024/12/30 12:55, Andrew Morton wrote:
> On Mon, 30 Dec 2024 11:12:00 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>>> For now struct ptdesc overlaps struct page, but the goal is to have them
>>> separate and always operate on struct ptdesc when working with page tables.
>>
>> OK, so tlb_remove_page_ptdesc() and tlb_remove_ptdesc() are somewhat
>> intermediate products of the project.
>>
>> Hi Andrew, can you help remove [PATCH v3 15/17], [PATCH v3 16/17] and
>> [PATCH v3 17/17] from the mm-unstable branch?
>>
>> For [PATCH v3 17/17], I can send it separately later, or Kevin Brodsky
>> can help do this in his patch series. ;)
> 
> I think it would be best if you were to send a v4 series.  Please
> ensure that the changelogs are appropriately updated to reflect these
> (and any other) changes.

Got it. Will send a v4 ASAP (remove [PATCH v3 15/17] and
[PATCH v3 16/17], keep [PATCH v3 17/17]).

Thanks!

> 

