Return-Path: <linux-csky+bounces-1691-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286C2A1B695
	for <lists+linux-csky@lfdr.de>; Fri, 24 Jan 2025 14:04:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3DA03A1655
	for <lists+linux-csky@lfdr.de>; Fri, 24 Jan 2025 13:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02393524F;
	Fri, 24 Jan 2025 13:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WcolCWBh"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD536AA1
	for <linux-csky@vger.kernel.org>; Fri, 24 Jan 2025 13:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737723856; cv=none; b=CAvHUSe2HTegEXMxcvtaC6J+3P8n2npd/UAFauNkUAOUEfNfXeQpmHtgDgjaCnzSLt4OPNZSN+tKKEbwItl44dn+xtUD+tf1KW+ewk63vH4vEDtfVKOlqFJxxhpfoKxn8ou0DF1WThqA6Bn5YokDNbQR+tBQvPVjavu6OJBPEUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737723856; c=relaxed/simple;
	bh=6DUwB+hCjWKh6+gmJpLDb9ZpCQfqoZDHN+wZTg6VGKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ktnr7oJHFcLWo2VjvLqh0lRwJXxdcZG2Q/uu+WHxgrl6Ibtb3/A2Dy1Srz4ypNMj1MepS4gnI+ue7lf61PgkVIUm/tQEFRoA/+gQU5oB0C0/QDncKzZki2dS/REkvNUs/SZzfTzcBs1FXSQ7YDbcFeUEWoJvylhJy92QmdHsGcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WcolCWBh; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ee8aa26415so3730308a91.1
        for <linux-csky@vger.kernel.org>; Fri, 24 Jan 2025 05:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737723855; x=1738328655; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dId7b4yz8t9ytNzoIMZDzDyU9S5trP6VQ+ykZ7MFw3k=;
        b=WcolCWBh+lB0KK8J6dDDEpKKfAjF2Cm6vBH1qSPgHiLw2VU81OIi3krrtfSEFWD9yO
         AqbnVBZZnFSp0SPjfB+kIjYMWdslGMdkpPA8S5gjdvQI0f3VZiAJxhLNERNL31UgWYG1
         guI1Xi3e/gDfb11BNupzOJ66yAMX1m75bZ2tUhpWXuVS99UyoZF3GgEiASJS8eG+qVcR
         pXuFs342QbpqHYxe6z9BMnhI2d+BMUx/R6mfINhNwZUur1HPSJBAvu4z16axZqcOpgqq
         xgHgWHkOffIZbVLnZWBABUNqZkmDgkdZw0TrtFP+pM+6syIFaocruvc2yOk22b7S+9Pu
         8P0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737723855; x=1738328655;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dId7b4yz8t9ytNzoIMZDzDyU9S5trP6VQ+ykZ7MFw3k=;
        b=Dlj0vpRneUkOUntLL0fA+Vo0oq6FOEglUXSMfw6yoKK1BqDAE1SgPgvgbJoc+4HoEf
         WskIzEcmC1nrV0OtvJWvvw1pq22uG+2/1mOWbMpQq4pQJAgbFX1hg8iBtS4MB/0h4Vh/
         i2+cYb8EW13mQzHuYI9k/JD4H4RPD93FSx7i7JqQ5TYyiLRbBmT046ZWIGS9Jv+nNPQ0
         rRn5bMj+UMF+PKnO2HLkvShq5ftWHtqBjtix+r0YsfwTY3XgKf7oBd4FAfE9wsvlHzgz
         l5Fo31fKu9va/5ap3m1rAZVwdX3iYsjwpfLRgZI8MSHGLSntRnOydmzwnqB9LuolvMQL
         +/GQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVvH78aWWjLtAOKWliBzM6IJ+XG+U63Q0iGG5ZYD3RVcnM7KAarlC/33XoiU8ZqyQoW9hJ5PyaGp4r@vger.kernel.org
X-Gm-Message-State: AOJu0YwiDVSmLgHtJRovqVP4u537PtEO1PrdAcgtPyyOvQykUhcUl8VK
	IsisWj8pAqqGnTWy2Xcd27uEruIG6E+64VgDm4dyfjDOTSldq2L1mWWJSuBbhWQ=
X-Gm-Gg: ASbGncvxVyRBSDlC7ixKnKVo7gje051b1M2jWmJDJCcUuuUM0RmTuRXnptKLGmEu+dR
	Qrpe9ebmcRCHqKra3lq/0+nX73a6Ezb986JjiHleeNthElANDcijWASOJ54MUbwFz2V/qBy+uDB
	DO8d5c7A+TlTTtcbwUZ45q57UoQpBQ0u5wyWoACIy7LJTwRLXwBMVgUshJuhMEN1hRV07tPWIDz
	M+YjiXX1AD047ETuCLOZLJjk2kfAF84quZju5O40kDxh94s9BjOgfLjWefjFMd8fjN6v1E2UgO4
	W6NbgdAjEv1bTCXK67sYk+aavDKrJdhvb4tXjkIVjoxG1AdOohlrzF4kuZxxkni5c4mAw4svFcl
	mzvgQ
X-Google-Smtp-Source: AGHT+IGZTgGY31e/1k/dTmcJmo/YDWxdXL7RglCap7bUypXHuwXLFHjK5+LGZw2OAN+HVTY4hEX3Xw==
X-Received: by 2002:a17:90b:2d88:b0:2f2:a664:df1a with SMTP id 98e67ed59e1d1-2f782c628bbmr47170073a91.2.1737723854887;
        Fri, 24 Jan 2025 05:04:14 -0800 (PST)
Received: from ?IPV6:240e:370:8b13:5250:f0b9:2326:6cb0:b423? ([240e:370:8b13:5250:f0b9:2326:6cb0:b423])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa5a975sm1776638a91.15.2025.01.24.05.04.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 05:04:13 -0800 (PST)
Message-ID: <65710478-4ee0-499e-9f66-dff81e226042@bytedance.com>
Date: Fri, 24 Jan 2025 21:04:02 +0800
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] remove tlb_remove_page_ptdesc()
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
 <20250124114759.GB15996@noisy.programming.kicks-ass.net>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250124114759.GB15996@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/24 19:47, Peter Zijlstra wrote:
> On Thu, Jan 23, 2025 at 09:26:13PM +0800, Qi Zheng wrote:
>> Hi all,
>>
>> As suggested by Peter Zijlstra below [1], this series aims to remove
>> tlb_remove_page_ptdesc().
>>
>> : Fundamentally tlb_remove_page() is about removing *pages* as from a PTE,
>> : there should not be a page-table anywhere near here *ever*.
>> :
>> : Yes, some architectures use tlb_remove_page() for page-tables too, but
>> : that is more or less an implementation detail that can be fixed.
>>
>> After this series, all architectures use tlb_remove_table() or tlb_remove_ptdesc()
>> to remove the page table pages. In the future, once all architectures using
>> tlb_remove_table() have also converted to using struct ptdesc (eg. powerpc), it
>> may be possible to use only tlb_remove_ptdesc().
> 
> Right, so I don't think Sparc and Power care to use ptdesc, they're
> using non page page-tables.
> 
> At the very least we should do something like this, the only point of
> having tlb_remove_ptdesc() is type safety, there really is no benefit
> from it in any other way.
> 
> ---
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index dec030cb1210..a6731328db6f 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -504,7 +504,7 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
>   	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
>   }
>   
> -static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
> +static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
>   {
>   	tlb_remove_table(tlb, pt);
>   }

Ah, make sense. I think this can be added to the patch #1.

Thanks!


