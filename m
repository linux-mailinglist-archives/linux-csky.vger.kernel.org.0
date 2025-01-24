Return-Path: <linux-csky+bounces-1690-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EFDA1B68B
	for <lists+linux-csky@lfdr.de>; Fri, 24 Jan 2025 14:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1A6188E638
	for <lists+linux-csky@lfdr.de>; Fri, 24 Jan 2025 13:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66A8288CC;
	Fri, 24 Jan 2025 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="itm92gHf"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1B6224F6
	for <linux-csky@vger.kernel.org>; Fri, 24 Jan 2025 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737723672; cv=none; b=sToMMqcYMokVB4hRCS+JYD/KlNE8rv86ipdRAQRY/I+T8i1L+vahPhLXiUGsZMLFJOR2tEqIS0WSWRsg+lUN/cvdeynP8zlyvbIONYylqp/VvG8L9U9jxhRqrwiCRTfGEoY/qlSO9t+EdVqZ+ZtngP7R7A56YrkWVCvbtKiHueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737723672; c=relaxed/simple;
	bh=oAWP2ZKP4Y5sj6STdC+hjwQqWYac1Xm7fWrKlGE+1QE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyj2Np4qZqV6nYQcuUHcl9Bd32I2ju2/Q6dXIds+OdkzGXb5D3eeosvPxZaxZQ04D5tVirutaKPHEOiCSvJrI2j5m0N1VvQCoPISAzhDOTWs6oZW88xjcql9qoLevGwTqvTwnYmano9N7tIVGCvPymq7LRzewlFAAjERGa9bGVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=itm92gHf; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ee786b3277so2856736a91.1
        for <linux-csky@vger.kernel.org>; Fri, 24 Jan 2025 05:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737723670; x=1738328470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J9XmywjVHeUTjwcf5l2PXOWSUMffMYwpksAkrprwOHU=;
        b=itm92gHf5/rElwWHybvYuNjM7wztAdjdD1BkJS9S1Fa1+nYyymH1m5AHyig+5GHleJ
         7aEfReHaN7A7O8sr/TKp+vTLM/fzUV1JjfmUCAQTY4yIGJ348E0JFPI5gbyL198B9Ozr
         2v3Ft1g23wciZF1KFqtu34d1hNfZUTIAqMGAQ545vjba5Ouajr2Ui6RfJBDfuwq1AIYD
         mnc27805+4JYf6zfbTUhk+0ZDRhIFy2HMFS8OsHCKghmmk0LIQ5VXx6sxqDWl9rV99a+
         JRYg5IlNJXqjsiLzOhVHAyyzEWASGUOKdVPjOfstWqp5XVEE/IKxSdr8BisAhYaRvBTa
         d7oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737723670; x=1738328470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9XmywjVHeUTjwcf5l2PXOWSUMffMYwpksAkrprwOHU=;
        b=d8wy7sycS9B/xW7nhZIX01f4/6gohNiIE/ysC6C+Qd6hZ0ZBdMTiUIoC+iz8e5dI6G
         tpFCd5QK8p8PmIm9G9Ej1vBy+cRNUoWUDIv5yG+Ms2ir4wmf3+8TJoMIOe43QzvvhsgX
         vexKB8EcAXB/BmU/VDM/qmAxXntPj6mr2RFPIfILqeFTg8dD6x4GCW+Sbc432TY8xfWN
         UKt3qh3+7MQWnFFZLVsxJvEkf7HA6UKxMfcPPBDFk+dQzKdznkTlGpMip6+pnmxZAt9C
         X2Eg5oY/acCA8zZ4awDSH4rMSraY8F6cDDmpA9P0tEovND8gwljkLrzkQLroEIXS8tgE
         aW9Q==
X-Forwarded-Encrypted: i=1; AJvYcCU798BkWZbVIn6aiKz55sKqmlbJSeYfqwnMLYjv88OBguw8qqBn5hqwSerrFrUfy6ABDttZXqPf8j6q@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm4DrdzJTxkruzXslcBZbd6d5H4rIjob4LW6uqTZGf872weY9x
	HNTyk/qDEftM4qppS61bjF4JuOVAxeW0ccw3R2ObQPUdaeBhc4IvIGdnfX6lMOk=
X-Gm-Gg: ASbGnct8vY8JD24inCR97E6Bh3uNsx24eQSa59ulEv0ptDp+S6Ct4ilre3T6ETv8Cgb
	3Yyt2N6UCXQsuTxRjVCZAXR0gT0nHIxvP1KwJRKjrEZpVwtXG+3FkjYsyl3yy7w5wGugPHjI87S
	7ZLALx3c3MKDPAZrppWejLK3lrJjxGdF2He5zJOq+pA0GHdPGOYCEe0sklKx+VQpFuwa14fresM
	unqikrcRQRQYo7InilCrCTnGJWArLrfBy42hMQNPcbMoeQE9FqJ6IDSCwjwgkiNFrn3Dor8mpZn
	ndk45je6YkMJtUlCgstuhPKGFTruxVwAeJkAHY1eRI5jlpdvhEmG2Hpnrr3zDQGDsVZv7a4rDDf
	JhiV7
X-Google-Smtp-Source: AGHT+IErpp3kusfvXhlhlaUEnTbjj0q85I8IgEHut5MJR7L8i7tS+ZolAw1OFFdRR3HhDghe0oVaNg==
X-Received: by 2002:a17:90b:2e41:b0:2ee:b875:6d30 with SMTP id 98e67ed59e1d1-2f782c779d1mr44385106a91.9.1737723669817;
        Fri, 24 Jan 2025 05:01:09 -0800 (PST)
Received: from ?IPV6:240e:370:8b13:5250:f0b9:2326:6cb0:b423? ([240e:370:8b13:5250:f0b9:2326:6cb0:b423])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa6b269sm1606110a91.24.2025.01.24.05.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 05:01:09 -0800 (PST)
Message-ID: <45651097-c056-49e3-9cc8-c289c1c0030d@bytedance.com>
Date: Fri, 24 Jan 2025 21:00:58 +0800
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] x86: pgtable: unconditionally use tlb_remove_table()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: kevin.brodsky@arm.com, riel@surriel.com, vishal.moola@gmail.com,
 david@redhat.com, jannh@google.com, hughd@google.com, willy@infradead.org,
 yuzhao@google.com, muchun.song@linux.dev, akpm@linux-foundation.org,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, arnd@arndb.de,
 dave.hansen@linux.intel.com, rppt@kernel.org, alexghiti@rivosinc.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 linux-riscv@lists.infradead.org
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
 <00bf7935d65826eee547ac195d7854b1c946dbc5.1737637631.git.zhengqi.arch@bytedance.com>
 <20250124113854.GA15996@noisy.programming.kicks-ass.net>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250124113854.GA15996@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/24 19:38, Peter Zijlstra wrote:
> On Thu, Jan 23, 2025 at 09:26:17PM +0800, Qi Zheng wrote:
>> If the CONFIG_MMU_GATHER_TABLE_FREE is disabled, the tlb_remove_table()
>> will fall back to pagetable_dtor() + tlb_remove_page(). So let's use
>> tlb_remove_table() unconditionally to free page table pages.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I think we can clean up more :-)

Yes, but Rik van Riel has already done the same thing in his patch 
series [1], so I was originally planning to wait for his patch to be
merged into the linux-next branch, and then rebase this series onto his
patch.

[1]. https://lore.kernel.org/lkml/20250120024104.1924753-1-riel@surriel.com/

Thanks!

> 
> 
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index cc8c3bd0e7c2..1f7c3082a36d 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -239,5 +239,4 @@ void hyperv_setup_mmu_ops(void)
>   
>   	pr_info("Using hypercall for remote TLB flush\n");
>   	pv_ops.mmu.flush_tlb_multi = hyperv_flush_tlb_multi;
> -	pv_ops.mmu.tlb_remove_table = tlb_remove_table;
>   }
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 041aff51eb50..38a632a282d4 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -91,11 +91,6 @@ static inline void __flush_tlb_multi(const struct cpumask *cpumask,
>   	PVOP_VCALL2(mmu.flush_tlb_multi, cpumask, info);
>   }
>   
> -static inline void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
> -{
> -	PVOP_VCALL2(mmu.tlb_remove_table, tlb, table);
> -}
> -
>   static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
>   {
>   	PVOP_VCALL1(mmu.exit_mmap, mm);
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index fea56b04f436..e26633c00455 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -134,8 +134,6 @@ struct pv_mmu_ops {
>   	void (*flush_tlb_multi)(const struct cpumask *cpus,
>   				const struct flush_tlb_info *info);
>   
> -	void (*tlb_remove_table)(struct mmu_gather *tlb, void *table);
> -
>   	/* Hook for intercepting the destruction of an mm_struct. */
>   	void (*exit_mmap)(struct mm_struct *mm);
>   	void (*notify_page_enc_status_changed)(unsigned long pfn, int npages, bool enc);
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 7a422a6c5983..3be9b3342c67 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -838,7 +838,6 @@ static void __init kvm_guest_init(void)
>   #ifdef CONFIG_SMP
>   	if (pv_tlb_flush_supported()) {
>   		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
> -		pv_ops.mmu.tlb_remove_table = tlb_remove_table;
>   		pr_info("KVM setup pv remote TLB flush\n");
>   	}
>   
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 527f5605aa3e..2aa251d0b308 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -180,7 +180,6 @@ struct paravirt_patch_template pv_ops = {
>   	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
>   	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
>   	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
> -	.mmu.tlb_remove_table	= tlb_remove_table,
>   
>   	.mmu.exit_mmap		= paravirt_nop,
>   	.mmu.notify_page_enc_status_changed	= paravirt_nop,
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 3bc8ad282b27..b1c1f72c1fd1 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -18,14 +18,6 @@ EXPORT_SYMBOL(physical_mask);
>   #define PGTABLE_HIGHMEM 0
>   #endif
>   
> -#ifndef CONFIG_PARAVIRT
> -static inline
> -void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
> -{
> -	tlb_remove_table(tlb, table);
> -}
> -#endif /* !CONFIG_PARAVIRT */
> -
>   gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
>   
>   pgtable_t pte_alloc_one(struct mm_struct *mm)
> @@ -53,7 +45,7 @@ early_param("userpte", setup_userpte);
>   void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
>   {
>   	paravirt_release_pte(page_to_pfn(pte));
> -	paravirt_tlb_remove_table(tlb, page_ptdesc(pte));
> +	tlb_remove_table(tlb, page_ptdesc(pte));
>   }
>   
>   #if CONFIG_PGTABLE_LEVELS > 2
> @@ -67,21 +59,21 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
>   #ifdef CONFIG_X86_PAE
>   	tlb->need_flush_all = 1;
>   #endif
> -	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(pmd));
> +	tlb_remove_table(tlb, virt_to_ptdesc(pmd));
>   }
>   
>   #if CONFIG_PGTABLE_LEVELS > 3
>   void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
>   {
>   	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
> -	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(pud));
> +	tlb_remove_table(tlb, virt_to_ptdesc(pud));
>   }
>   
>   #if CONFIG_PGTABLE_LEVELS > 4
>   void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
>   {
>   	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
> -	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(p4d));
> +	tlb_remove_table(tlb, virt_to_ptdesc(p4d));
>   }
>   #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
>   #endif	/* CONFIG_PGTABLE_LEVELS > 3 */
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index 2c70cd35e72c..a0b371557125 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -2141,7 +2141,6 @@ static const typeof(pv_ops) xen_mmu_ops __initconst = {
>   		.flush_tlb_kernel = xen_flush_tlb,
>   		.flush_tlb_one_user = xen_flush_tlb_one_user,
>   		.flush_tlb_multi = xen_flush_tlb_multi,
> -		.tlb_remove_table = tlb_remove_table,
>   
>   		.pgd_alloc = xen_pgd_alloc,
>   		.pgd_free = xen_pgd_free,

