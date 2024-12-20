Return-Path: <linux-csky+bounces-1421-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 978E69F9413
	for <lists+linux-csky@lfdr.de>; Fri, 20 Dec 2024 15:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AFC4188419C
	for <lists+linux-csky@lfdr.de>; Fri, 20 Dec 2024 14:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61062216E05;
	Fri, 20 Dec 2024 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="HbOHEA3e"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBEF2163A9
	for <linux-csky@vger.kernel.org>; Fri, 20 Dec 2024 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704196; cv=none; b=a0187bSZRtmmaxjkjiVwAJzKWlrqg7qBPic4evOpvZib1v5YK4q28M8GriF6k/Z/ImhtF+zLOn6ERin8IDQorn9S/f/vi8Idvhl18zikwmTjwChFtfGkZr6CbQmQWRo0SkUSSsB4XtZizhlZUcMPK7VmFLWOHZuwQZFpyJzFb58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704196; c=relaxed/simple;
	bh=s7rqpd1mjl40lUv0Se4TtYGvbPHUeMLFx/l0Mmxbw0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e1vmnw/0mtFzEen4re5gVvaH940Ufg33iwJnPx9Wmj9QnA3B5JYlKTmq2sSz5f/gVK8+RB1vSYbKJ11GNoefZiUAjbRkYoA3DbqgvSiHwhn3EiTLkQA0KjhdGdbzxBMUZPRmwjBt9t/I5jkdVuiEYPXpwl0GXzYhlj7GpIyMhJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=HbOHEA3e; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2166360285dso18781545ad.1
        for <linux-csky@vger.kernel.org>; Fri, 20 Dec 2024 06:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734704193; x=1735308993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g7iBLKI/TaFFZvOKdERySTto1DEdoOqdcbn/lUOJJc0=;
        b=HbOHEA3eps9UevBkR5bfxI6NHRSKCdiL5P9sAhdIrXCTSti9xdRA5WCjcJoT4iHje0
         5NDV0V/6cDUzO504C/ZXW3zpkIix3jXb3jjTUasD5emSo/jnJUZCRbj131hobdou2ZIY
         mFBz7gAKOTL2TCITsscBNM1vSYDV7jvsFPa8D9Uvo7BKLdNtsNQfTqxQxTOkS3w5PK2n
         +B79tKHlOJYOL/dDcQTzJP9oYIZ44MeSbNK+X/Tc9RnZdg0NUmy/7H1d2Hawz/ZcaDjt
         pzF/pzG5bkq2JHUaZL+CnqDSoeWDyFzD+BOpnBTw7fZLaVdJmWQW9UczlCM7XQOUwxBJ
         12LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734704194; x=1735308994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7iBLKI/TaFFZvOKdERySTto1DEdoOqdcbn/lUOJJc0=;
        b=qGYwUM5GpbDqaZuVaJtaAdZeeoi8nEVJUJgjUBv+OAc/KXognZrXTWuqqRjRHxURp+
         EzkBm/e7pmnHfi9z/AXxJ+8VLhlEZuFv2cWFw53EMhg/OMJk2Xj4J+4lrV67I3i+8NPs
         kgaxqeF14w/JLlzqO8GhfLT9zfQkBbYQwIUhRTj0ChaEy6I/vT5RW0VFwhMHKbMLeVhA
         Pzo9vV+nTZmm1rWDFicUWwjOZCjLTOXramGmoGjYlgSMwIAu4O6BL1TRotf3whkvo+JZ
         Syf4vrS1U0USV9vEgb4Jbpvtfy+WA5HjoNCKhTvGYaB2HZT+URAKw9iNPAKyJUTTA0Q1
         /L1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVKEff5FQugNvZH+r/lK56JtRmX+cyBqjfTr8Mnvg4LWeYGOSSWZv3ZHB/XOfXIQTkynMUeshcGGgyL@vger.kernel.org
X-Gm-Message-State: AOJu0YwctMLmgiK9AyalXzAPZ7mCZN73dNtxwuqfb7dR7otQEJ+xsyZR
	TBGP+ZEmsIMD0NsGhygmuKOE3l9My7n6dr0/Ag4SzMiQzA6xqkQgUjNsZP6BGF0=
X-Gm-Gg: ASbGncvFBEEOmYa5ux4DpU5MaiD7deS6CDcT3kTr1F9vhRynz/AmP33K+tn8c2A5SM6
	VYFD0xNDCvGxxazBHXDHOv2cmOboGOEJtdAEN6lstOYNZNMsr33qPfjpwFSANrEAcwRleg5gIOM
	TsEpDIxkMVaCIVoB4ExtPGG2D9kYX5qeIdjMuPCfRT0V4ke4I0yLTckqT/ObDeuDiBKrlqBcGAh
	uikEd/xmoZGauXiE0tks4kYGlVkawbpJFWo2O7b0SYGxkKW+2/8bKcGK++9KgXgk8CLjjRvBo5u
	LehtI8Tz+D4sYKAfrr8UK1kAQ49SnuFpibnHv7HGnE7X/FOVUEsjpqA=
X-Google-Smtp-Source: AGHT+IEEYygST4Gz03iGTM9RRiblbKn1x180pLztYOSIYhLMIpPKwcn4PYi8F34LVLcH4FrG3CDhdg==
X-Received: by 2002:a17:902:d481:b0:216:770e:f46 with SMTP id d9443c01a7336-219e6f26692mr39017935ad.54.1734704193630;
        Fri, 20 Dec 2024 06:16:33 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:3764:dc48:fb1b:dd06:cba7? ([2409:8a28:f44:3764:dc48:fb1b:dd06:cba7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc972734sm29423545ad.88.2024.12.20.06.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 06:16:33 -0800 (PST)
Message-ID: <33ce9b58-4787-49cd-a7f2-34272cb3ecf7@bytedance.com>
Date: Fri, 20 Dec 2024 22:16:22 +0800
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm: Move common parts of pagetable_*_[cd]tor to
 helpers
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Ryan Roberts
 <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 loongarch@lists.linux.dev, x86@kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
 <20241219164425.2277022-2-kevin.brodsky@arm.com>
 <20241219171920.GB26279@noisy.programming.kicks-ass.net>
 <75cb4ff8-eb0c-4519-a30a-f8be717ba278@arm.com>
 <0daabd32-cba4-4345-baa8-e8c66bc899ff@bytedance.com>
 <2f65f93e-9d44-4acc-b63c-8f5a35f59699@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <2f65f93e-9d44-4acc-b63c-8f5a35f59699@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/12/20 21:50, Kevin Brodsky wrote:
> On 20/12/2024 12:46, Qi Zheng wrote:
>> Hi Kevin,
>>
>> On 2024/12/20 18:49, Kevin Brodsky wrote:
>>> [...]
>>>
>>> Qi, shall we collaborate to make our series complementary? I believe my
>>> series covers patch 2 and 4 of your series, but it goes further by
>>> covering all levels and all architectures, and patches introducing
>>> ctor/dtor are already split as Alexander suggested on your series. So my
>>> suggestion would be:
>>>
>>> * Remove patch 1 in my series - I'd just introduce
>>> pagetable_{p4d,pgd}_[cd]tor with the same implementation as
>>> pagetable_pud_[cd]tor.
>>> * Remove patch 2 and 4 from your series and rebase it on mine.
>>
>> I quickly went through your patch series. It looks like my patch 2 and
>> your patch 6 are duplicated, so you want me to remove my patch 2.
>>
>> But I think you may not be able to simple let arm64, riscv and x86 to
>> use generic p4d_{alloc_one,free}(). Because even if
>> CONFIG_PGTABLE_LEVELS > 4, the pgtable_l5_enabled() may not be true.
>>
>> For example, in arm64:
>>
>> #if CONFIG_PGTABLE_LEVELS > 4
>>
>> static __always_inline bool pgtable_l5_enabled(void)
>> {
>>      if (!alternative_has_cap_likely(ARM64_ALWAYS_BOOT))
>>          return vabits_actual == VA_BITS;
>>      return alternative_has_cap_unlikely(ARM64_HAS_VA52);
>> }
> 
> Correct. That's why the implementation of p4d_free() I introduce in
> patch 6 checks mm_p4d_folded(), which is implemented as
> !pgtable_l5_enabled() on those architectures (see last paragraph in
> commit message). In fact it turns out Alexander suggested exactly this
> approach [2].

OK, I see.

> 
>>
>> Did I miss something?
>>
>> My patch series is not only for cleanup, but also for fixes of
>> UAF issue [1], so is it possible to rebase your patch series onto
>> mine? I can post v3 ASAP.
> 
> I see, yours should be merged first then. The issue is that yours would
> depend on some of the patches in mine, not the other way round.
> 
> My suggestion would then be for you to take patch 5, 6 and 7 from my
> series, as they match Alexander's suggestions (and patch 5 is I think a
> useful simplification), and replace patch 2 in your series with those. I
> would then rebase my series on top and adapt it accordingly. Does that
> sound reasonable?

Sounds good. But maybe just patch 5 and 6. Because I actually did
the work of your patch 7 in my patch 2 and 4.

So, is it okay to do something like the following?

1. I separate the ctor()/dtor() part from my patch 2, and then replace
    the rest with your patch 6.
2. take your patch 5 form your series

If it's ok, I will post the v3 next Monday. ;)

Thanks!

> 
> - Kevin
> 
> [2]
> https://lore.kernel.org/all/Z2RKpdv7pL34MIEt@tuxmaker.boeblingen.de.ibm.com/
> 

