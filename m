Return-Path: <linux-csky+bounces-1844-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428CCA48ED6
	for <lists+linux-csky@lfdr.de>; Fri, 28 Feb 2025 03:44:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 075DB16CAF7
	for <lists+linux-csky@lfdr.de>; Fri, 28 Feb 2025 02:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B93613DDB9;
	Fri, 28 Feb 2025 02:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="cdGvg9LM"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFAE139E
	for <linux-csky@vger.kernel.org>; Fri, 28 Feb 2025 02:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740710676; cv=none; b=b1/2MPMvNVxTuIH12yfIm1YrvYCokwJ6cK8lFIQ3NWmz3+1zOcTu1yxfrvT1kJoqkqUfZ/Z3rhoVkUxZ9FMYfTF9StYLMC6trzk5wTwOBKIckYEC3oj+pDR5sgbobjMaF+M1vnEfij6EQaATrpykd7hwxupdzLxfjd3t3WOzCxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740710676; c=relaxed/simple;
	bh=0fz6H8dlUgf8ko9N18YypQHlBg79eNoT5rDDE25IBq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cA0RFFqLSScOWXqYfgvbqXaRFeMaZ9o3kcy5Rh3lBwF2gYLBpXYT6nh/QbSAQBBOQA5mmFyS7fz21DlBDamXgFodKuD76u/B6UOkyboD80DJai6voI/oSrfS6O1rI8dKkN0zO6D8akXhuayKvAbQqCmQzNjmp2WoVAQSp308vME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=cdGvg9LM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-22334203781so40777655ad.0
        for <linux-csky@vger.kernel.org>; Thu, 27 Feb 2025 18:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740710673; x=1741315473; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KrHEppDznEYNt+aFJHMFnsD9ySUlfKEU8kXo3t7+HP0=;
        b=cdGvg9LMCPgA86eF1veU8MttIzjFc4M9bOp1Q+ej90hvu2aZr7uyASxs7uRlr3D8kE
         YQQQANN+KG+nVURDCNJSv5gXBZoaa0W0i35WiZlp+mcBPmLoJfGx/iPTsUQgBx1Od+bK
         riOJ/vkAG14G2L8zko8aUF3QwPxJv+wmmzqITfAAwEEj6QVyvyt382VqOYTnBuj9KJAU
         HZNHwiMw671NsErHZxT6yRYWcQ8PvZzb/ikpwi5VOwlvOlu3HTNLh12KwEYvo2mJ8GYP
         PjXRKUtbafnl+V/PCk7t9Iw7EHZB8TYDo5psvQDupJbFjo70IVyq0wgSs20gO+qgyNoS
         eNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740710673; x=1741315473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KrHEppDznEYNt+aFJHMFnsD9ySUlfKEU8kXo3t7+HP0=;
        b=najLMjpx9erxt92t3FC0goVVJKtBvQIrj5TqCAgebPS7PllYAnMRkzjg6lGW63t9ky
         1deXJFfVbJ3BCHsYjxAh9ogek/JBviAKGCxtkAYNnBsxdxmi0J/18kAZsY4kbfzkwULS
         cUNdiwGPUBo+K99aSijAgGkAOdHn5KmDBYX2B2zn6fZpFnIaK2v3w221InIP1Axrq3Ih
         m3mu3EY6ZkU75HzowemY38DED1yGpu9eXhZ4/Rfzy+8Ftf8OQ7OqUL/epvTyUdL/Mfct
         PAa8nuNeC4OPzYTFPVT09PpnHo6cZ07boIuMdD90Xr6lFVslLg7WIjJ7g8kz/kU96wWv
         Oqvg==
X-Forwarded-Encrypted: i=1; AJvYcCUPn5qjiITFkpvdcY/jU2883pfNGswayP/GZjtxCdPOZG4VgF5ayBNQCVLlYCTwAKbQHB9Gfx3+9SE2@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9l4tR9TcRxrOyRJ8hpfhU6l2Kjgc96BFwaN152Gh/l/1o0SwN
	rV7dZmYIvS0xa1nBk3wkm0Nrs2KJbY2qb4iR7ZjBqXvIC8xg/6y23I15oFpIiic=
X-Gm-Gg: ASbGncv9PQDUAYS3mXG4nJFWWyCuBxPClbywAWBug45A1UFLJoWDBl3QY+1FFDltMm9
	RTcLgQMHuII656OFVoHbaA3pkqHBMuhHVVYv+acWflQ6Z/KKqBqEki5SEZXhXntknWKeG1c0TRn
	8Gqh9mHkaPj5jEZdPq9MRlsU7kJrkVMcEniYCTXGcQQoM2ZIp9DtOJC9GpNS5080x+OVl4LC94d
	jUrUfK+xFJ1/jFIilfvkOR6SQ50CpiBhJ5Qdeeh+cj4+C9TvNKxDVN34yHVBSKRhOffuCFDdL/g
	qj8e2XerwrV7dxsYVGI2v/eifoekj1jUiVUCtiJKng+/GHr4lA==
X-Google-Smtp-Source: AGHT+IF4hsdZRiz/aSbemK655CZrsY9ZUuvu4Xu2ENST8y9hxHTSO7PJo35OmCgDgimYWycuvOakGg==
X-Received: by 2002:a05:6a20:1591:b0:1ee:d19c:45f9 with SMTP id adf61e73a8af0-1f2f3e11f86mr2902815637.19.1740710672736;
        Thu, 27 Feb 2025 18:44:32 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7349fe514besm2559832b3a.71.2025.02.27.18.44.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 18:44:32 -0800 (PST)
Message-ID: <e5f4e310-5bcd-4901-8ec3-757cf55dfa64@bytedance.com>
Date: Fri, 28 Feb 2025 10:44:21 +0800
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] mm: pgtable: convert some architectures to use
 tlb_remove_ptdesc()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com,
 vishal.moola@gmail.com, david@redhat.com, jannh@google.com,
 hughd@google.com, willy@infradead.org, yuzhao@google.com,
 muchun.song@linux.dev, akpm@linux-foundation.org, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, arnd@arndb.de,
 dave.hansen@linux.intel.com, rppt@kernel.org, alexghiti@rivosinc.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 linux-riscv@lists.infradead.org
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
 <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
 <CAMuHMdU8ttibKCiUPxSNBpJyrtBbrt1CqLa++jq6CpJFbFCwAg@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAMuHMdU8ttibKCiUPxSNBpJyrtBbrt1CqLa++jq6CpJFbFCwAg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/25 9:21 PM, Geert Uytterhoeven wrote:
> Hi Qi,
> 
> On Tue, 25 Feb 2025 at 04:46, Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>> Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
>> nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
>> and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
>> tlb_remove_page()). This is the same as the implementation of
>> tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
>> convert these architectures to use tlb_remove_ptdesc().
>>
>> The ultimate goal is to make the architecture only use tlb_remove_ptdesc()
>> or tlb_remove_table() for page table pages.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Thanks for your patch!
> 
>>   arch/m68k/include/asm/sun3_pgalloc.h | 3 +--
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k

Thanks for your review.

> 
>> --- a/arch/m68k/include/asm/sun3_pgalloc.h
>> +++ b/arch/m68k/include/asm/sun3_pgalloc.h
>> @@ -19,8 +19,7 @@ extern const char bad_pmd_string[];
>>
>>   #define __pte_free_tlb(tlb, pte, addr)                         \
>>   do {                                                           \
>> -       pagetable_dtor(page_ptdesc(pte));                       \
>> -       tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));        \
>> +       tlb_remove_ptdesc((tlb), page_ptdesc(pte));             \
>>   } while (0)
>>
> 
> With only a single statement remaining, you can remove the do { ... }
> while construct, too.

Ah, right. Will do in the next version.

Thanks!

> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 


