Return-Path: <linux-csky+bounces-1495-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F65DA0238B
	for <lists+linux-csky@lfdr.de>; Mon,  6 Jan 2025 11:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20EDE161E68
	for <lists+linux-csky@lfdr.de>; Mon,  6 Jan 2025 10:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB351DC999;
	Mon,  6 Jan 2025 10:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="T+j+okKo"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450211DC982
	for <linux-csky@vger.kernel.org>; Mon,  6 Jan 2025 10:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736160976; cv=none; b=BayRk7WLSxGqt8yNISi6tTlD7yRdDs747Q6md30K5tsKjQtIFratuYXBCzQwWBxyR4VNQEie5xL2pJ1bCPfyS5186h1uI9wiw/f/NSo3sMsBLTR6e/bt6FkBrWs0UJVuiwRDF3dICXrPFN45T+GkdguY7VjIykPSgdjJWhG5pyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736160976; c=relaxed/simple;
	bh=r/bDpLsrew4AGrmhkoObL4mp3VlC7lbov5MqbBolj5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6HYwbdRVO+Sw7AM/Rd26NRuhLSS0UCIC9SS/f18Kk60f7RfGBL0Lj6a3dl+NnaB/Jhw8z4UuF0XthG2DyDLDbfEyz7ITw0wPil6MiPP9+RDOoNldJne47BGRxUDZydoVMIfQVvL0sSpJntDpXLDFzQQVP2v8i4N4n6C0spTPYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=T+j+okKo; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ee8e8e29f6so16486073a91.0
        for <linux-csky@vger.kernel.org>; Mon, 06 Jan 2025 02:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736160974; x=1736765774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AZLWPPKublXNhPBg34EaNBNy6TKJ9wneFJV35MDnpZc=;
        b=T+j+okKo2zRwuYSfffMrbTo6TknZew6YYiULJO+9bKi0BHmWKw7QokPt1Skt66fwlj
         eMmqN+oPD124G39eSvNTMwnUs7SB0dGpKFkK3XMEy95L7NM1VCNWV2hE5tX6oL627MK8
         wC57GG0O/2xauw2YLjCaXrrN9tye0bn0z52ql1FJe2UhsvbOiuaH7ebCTW7kfkaEPHij
         2JwZYVWxNe5uWIAiEK3PLKJG9ey+iGqLYgiBNk7skrKHCik6AMdGwrjlkHZ85MUbmTKD
         uW7ySurc3z49eojO5wjN6X21t2HrdGUgV2MIp0NgIb4Onz4+87KRMQVxwja2SMySjlyT
         cKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736160974; x=1736765774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AZLWPPKublXNhPBg34EaNBNy6TKJ9wneFJV35MDnpZc=;
        b=AXywFv+Ghu0X4oUXUMAIUaWCf9xXwob80K2u3vbdL/BcfW/txWNwzvmSmGFACM8za/
         GxWhnzH+psl9DXiOVtXdhX4d7e5F7bLQV5r5b5q+16FFxv2Gkd5gIxy3MAtvB+WVz+vv
         p5rPHpmqWrU6jSaDpGFk7osIlKkf1Y9jQA2XxvSgSWnL8lCx7K6Ll7QFyOQd5/zMD5tG
         6HNLG4hTDxDTqoihCrbJAQ/lgr8YUTQfDjvf4uoeHeRoQ6GUoPJ8FqY378BMopJ+whZB
         IM0yRUcGInnTF2j4Lgsm7t/X7fzOAPhHNToK3ISFiX9H0lfBO4EL98In/RGbIYxHTkFC
         leww==
X-Forwarded-Encrypted: i=1; AJvYcCUCFvCD3y0/YNAcOiyK2VA4ne9z9YYX2aPowdn7EbMjni8LKoAEOu6YI2YtUN+9HcWFpdR9JzimXI5I@vger.kernel.org
X-Gm-Message-State: AOJu0YywgfDeLrXOZHFKivV4r3bsgmV7lhXhcHKBsMjI0ZBThTlDlZj8
	E+ixBTuDJaY5/twA7rnekaicituGXfJLW4sv7Ka+X+mnOUhjIMOiGRu3mYx8qiY=
X-Gm-Gg: ASbGncvDoexIXZZVp4JFiJtSxyvZVSYcA9J3oij+MDP86OA+tym2hMn78Ozo4VTHs3S
	AQ3ZQf77obDRcHXZkzrINq/4biDviM7f4yY6HmAxeRSUSWNCRXmcxeNYY9tpYKKYFVAK1bPLJTo
	We4vvAOFjHcqA5uEpVAH5cBHt0AQ97VSq/7btCpHK81EW+48NcEyxieZpKqyKbAaJhjTkvpWJbE
	RDg9pgBKSznd7ppzYIY+y05IgZetLAHnACkFuJJ+9Zzhx+lDaUsXokyrmWbhhKnKNg3bqO7SaAj
	Gaavzw==
X-Google-Smtp-Source: AGHT+IHHEGVNBdeeeMKsfSrtRayn5rgDW+sVv93AHdkC2kua4+TBudPLJJX1AZ3o0AE+Wq0oFkgydg==
X-Received: by 2002:a17:90b:5347:b0:2ee:3fa7:ef4d with SMTP id 98e67ed59e1d1-2f452ec37bamr85837306a91.24.1736160973647;
        Mon, 06 Jan 2025 02:56:13 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc96ead1sm290125115ad.91.2025.01.06.02.56.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 02:56:13 -0800 (PST)
Message-ID: <e1de887c-6193-48ee-a9b3-04c8a0cdda45@bytedance.com>
Date: Mon, 6 Jan 2025 18:55:58 +0800
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] mm: pgtable: introduce pagetable_dtor()
Content-Language: en-US
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <8ada95453180c71b7fca92b9a9f11fa0f92d45a6.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uxwiEhYHDqdTh3@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3uxwiEhYHDqdTh3@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/6 18:34, Alexander Gordeev wrote:
> On Mon, Dec 30, 2024 at 05:07:42PM +0800, Qi Zheng wrote:
>> The pagetable_p*_dtor() are exactly the same except for the handling of
>> ptlock. If we make ptlock_free() handle the case where ptdesc->ptl is
>> NULL and remove VM_BUG_ON_PAGE() from pmd_ptlock_free(), we can unify
>> pagetable_p*_dtor() into one function. Let's introduce pagetable_dtor()
>> to do this.
>>
>> Later, pagetable_dtor() will be moved to tlb_remove_ptdesc(), so that
>> ptlock and page table pages can be freed together (regardless of whether
>> RCU is used). This prevents the use-after-free problem where the ptlock
>> is freed immediately but the page table pages is freed later via RCU.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ...
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 5d82f42ddd5cc..cad11fa10c192 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2992,6 +2992,15 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>>   static inline void ptlock_free(struct ptdesc *ptdesc) {}
>>   #endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
>>   
>> +static inline void pagetable_dtor(struct ptdesc *ptdesc)
>> +{
>> +	struct folio *folio = ptdesc_folio(ptdesc);
>> +
>> +	ptlock_free(ptdesc);
>> +	__folio_clear_pgtable(folio);
>> +	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>> +}
>> +
> 
> If I am not mistaken, it is just pagetable_pte_dtor() rename.
> What is the point in moving the code around?

No, this is to unify pagetable_p*_dtor() into pagetable_dtor(), so
that we can move pagetable_dtor() to __tlb_remove_table(), and then
ptlock and PTE page can be freed together through RCU, which is
also the main purpose of this patch series.

Thanks!

> 
>>   static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
>>   {
>>   	struct folio *folio = ptdesc_folio(ptdesc);
>> @@ -3003,15 +3012,6 @@ static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
>>   	return true;
>>   }
>>   
>> -static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
>> -{
>> -	struct folio *folio = ptdesc_folio(ptdesc);
>> -
>> -	ptlock_free(ptdesc);
>> -	__folio_clear_pgtable(folio);
>> -	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>> -}
>> -
>>   pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
>>   static inline pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr,
>>   			pmd_t *pmdvalp)

