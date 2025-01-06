Return-Path: <linux-csky+bounces-1506-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DD6A0285E
	for <lists+linux-csky@lfdr.de>; Mon,  6 Jan 2025 15:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E321165546
	for <lists+linux-csky@lfdr.de>; Mon,  6 Jan 2025 14:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF901E009B;
	Mon,  6 Jan 2025 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AOENsm2R"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1E31DFE06
	for <linux-csky@vger.kernel.org>; Mon,  6 Jan 2025 14:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736174677; cv=none; b=kttgcV2pYW8mUi1uEBlxX+NS3SH4ZRCoF8P5dV2aChLMcSKbrSY4dyG2IABIWGmf+VQndyQTrkAUGdGF6f8wzgYs5eoeBlTYbdb9HDM3eoM3bAt4g/YsLEbdTrQQLjYN3QSUPztOWYmsSD6d9KM99o9coXpChJBnBhzOiXnF6+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736174677; c=relaxed/simple;
	bh=FT+GsbrHFNytgmVw9pS4MWUyG9GELMc2aWIALV4R5HM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WVXUXSLT44ffKVDNr3iIfc5EHWytLRBybuAXgaMMXefGNniuBeECSKIUTS+EIwhcVvXpQ7wKGPF87AND4ZbuB5pXLwhoOX6GgHhKiElbqyJqUj/OFyXPdkm+eAVVuLZ1/D59rfpfzfCttxglFEN8ToPHSPE7fauTeEV9HaSsxcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AOENsm2R; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2161eb95317so214336605ad.1
        for <linux-csky@vger.kernel.org>; Mon, 06 Jan 2025 06:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736174674; x=1736779474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NViglkR77PlL2AqsFJ9M2rA8vsy0VBtzEibmSHACi+I=;
        b=AOENsm2RWVESkj+tEE8NednRuNGe+HrlfMpqdMmB96TFPb1M05S6p2+RrKZ6kOJ2r6
         2m1ghhviUlJEv7uX2tL/vtDm1POjsFwB5CCUwKifHrGiN6wAdyKGQ9X2oL3piluKNYb0
         I3X+PpobzTtVz7/hTPrBW0pImZItQ99bJssa2FVL4Lrrjx7q1lNsJd7rELXfXFDMcswv
         aXqs85gh+NKJfwv3V9Dy+ZrYnXCasR3YIZbwRcM0jNsQdZ/dg9IB1W+XfduD1DKb5HNn
         zxq03RDCixKBfv9y4elRxUNAap32HNjC1W6uJzlwSMZFFa8MSUhCPMDJQ1aCRNa6iLgr
         188g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174674; x=1736779474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NViglkR77PlL2AqsFJ9M2rA8vsy0VBtzEibmSHACi+I=;
        b=p4Nz4IcrDmr0LCEh1++x/1UPuHtIU5fFbsOuYC9MeVz13A4E/Va+JETkdXSaxP4/GP
         4/AHJeq792WCW9gN5jERYqwytA9EaiDD5QCyXWSSeQVVTCAaS5e7YFkOpDoEQas4ZZbT
         dxxOP0asJue9nzP8oBigaHaU7mVUKDzySZvX4xfL21fKH9pT5UXcFr9WTkSmt0aGgoz+
         WJiwHXxdBwvLEsMdq29inkxBZaDlJHhFDp70jSngwGo5A6xFmDukuSjPGzzSm/77sLq1
         0459NydJhOf6MY/U83wiZRhGLLuawVV2OgHRTk8wnKpM/AOj7ie8vpR7COI+tDnWY0wa
         mFcw==
X-Forwarded-Encrypted: i=1; AJvYcCW4wHCYezBXWmTrvjX6GjzutrL1QLYxWAgKuONCJq/fB5Od39j58X49LZCfA40MJKG/Xf+jfHq+bEqq@vger.kernel.org
X-Gm-Message-State: AOJu0YzLIUp7hNo0FfH2TLJJ2vQLq1Dj2mluoXzLyWYMXhKZbGjnLD5e
	r8PhmO5CgRgzl4Yp2Gc14xSaMoB+kxpQxxStBRDwF/1ftThkWGwC0DG539urwpA=
X-Gm-Gg: ASbGncvLEaHf8tJOeMSCZRwsoz04idlnE7vPqfIiu+le/Agey3EITOgyEoyyjHMx/T+
	3b3x6mg1TOygZ/mnhidHeuWY36g4pboqvgTzLCKeALCZn61FmpCBOjaAAvuDqz0bz6FQGtOPjej
	7C1o6JGWKQ24sWLUJiDykogw6xBDJMWV9ryDxauzU+XtL/x9vy6V6FpqK58rpl0J5x6h2UQghvP
	CE6H9kzxl4gDlpkpBmIzVA9c2WRQ1eLoR8EoxQjqXtivnEQ2siol9D9Kg6mcPqvzyl3AcGGqQog
	P6HAE2XF1Z1DNT6y8wLzxbj0GjtA6FCI/X7fDvaymdtxIvbcdL19
X-Google-Smtp-Source: AGHT+IHfRKlSBRBXUw7mHIW0SQFNESOEWbBrtQcBXd7/ffhetsdlBCZHRjeTrMJdIBfoDiMG7l+wRg==
X-Received: by 2002:a05:6a00:ac3:b0:726:f7c9:7b1e with SMTP id d2e1a72fcca58-72abddcadd6mr82367083b3a.13.1736174674262;
        Mon, 06 Jan 2025 06:44:34 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:d64:296c:a8f3:f81e:f88b? ([2409:8a28:f44:d64:296c:a8f3:f81e:f88b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad815804sm31532588b3a.32.2025.01.06.06.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 06:44:33 -0800 (PST)
Message-ID: <dbcbf4c3-f86a-4414-be52-8ac02dae5b6b@bytedance.com>
Date: Mon, 6 Jan 2025 22:44:21 +0800
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] s390: pgtable: also move pagetable_dtor() of PxD
 to __tlb_remove_table()
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
 <ad21b9392096336cf15aee46f68f9989a9cf877e.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uyJ2BjslzsjkZI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <2d16f0fe-9c7f-4229-b7b5-ffa3ab1b1143@bytedance.com>
 <Z3vQHplZqtHf6Td8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <57ea8193-2fd9-41a9-85b4-7af924f900f4@bytedance.com>
 <Z3vqHXdwIMBVQ2GT@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3vqHXdwIMBVQ2GT@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/6 22:35, Alexander Gordeev wrote:
> On Mon, Jan 06, 2025 at 09:34:55PM +0800, Qi Zheng wrote:
>> OK, will change the subject and description to:
>>
>> s390: pgtable: also move pagetable_dtor() of PxD to pagetable_dtor_free()
>>
>> To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
>> PMD|PUD|P4D to pagetable_dtor_free().
>>
>> But pagetable_dtor_free() is newly introduced in this patch, should it
>> be changed to 'move ... to pagetable_pte_dtor_free()'? But this seems
>> strange. :(
> 
> s390: pgtable: consolidate PxD and PTE TLB free paths
> 
> Call pagetable_dtor() for PMD|PUD|P4D tables just before ptdesc is
> freed - same as it is done for PTE tables. That allows consolidating
> TLB free paths for all table types.
> 
> Makes sense?

Ah, make sense. Many thanks to you!

Will do it in v5.

> 
>> Thanks!
> 
> Thank you!

