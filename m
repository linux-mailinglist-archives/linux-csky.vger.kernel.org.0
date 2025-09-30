Return-Path: <linux-csky+bounces-2512-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A90BAB57F
	for <lists+linux-csky@lfdr.de>; Tue, 30 Sep 2025 06:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C4F8189675E
	for <lists+linux-csky@lfdr.de>; Tue, 30 Sep 2025 04:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0032155C97;
	Tue, 30 Sep 2025 04:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TlB/uI5r"
X-Original-To: linux-csky@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91373596D
	for <linux-csky@vger.kernel.org>; Tue, 30 Sep 2025 04:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759206459; cv=none; b=C+tNMxNcJpjGXsImJHsWjthvkwXo/1t664LtRuV8OTDLOkdp8eFNlnLdt2UrNpnwdFXVASUzQgKiEfowxjfMe8I55P5rh6y1En7MfMPkVq8rHL265G2UdzR4EE25GidlJRfymxj0T1/XN/VKriZMszo5TfE5P3hYbnbgq7psStk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759206459; c=relaxed/simple;
	bh=CeklPAD1EAwZRM6eDWF+6CHr5CRiFBjMu7zBZHlAoTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bZdEtLVBByriTCNecFRBURGsNXODXr/rftG0umM8oF1w5V0j1T6xI4SfwoD7UwZH5Q+5Eda6/IvxtWjS4mBvWVqH65HgEsp0Q3D797oZsBmoKHtdP+3hSj/1exQqziRkryZQLDcMMxefHSCftX04f2ZruSs5kAyhnD19LZ9n6eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TlB/uI5r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759206456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=utL4hyQaWnCdzhUUrlBD6ZJyhvhWfn+CAzdni89roF0=;
	b=TlB/uI5rTKyza9WtXvsaiUieqhGVDIaPToQ6LKGvwyzyD81s40BEajtMWVFvGJrv3+o9cn
	l2hAZhTygEsU0KqCZTh4uGCp0aQccPjekgeVTSVTzOJYbpNWt9UgBPZAt+TdqpuGdurLm/
	T34OZ5+D4RCAOD2xISbKzJOw09kQli0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-E79Y-tXYMSeg74Z6clqAvA-1; Tue, 30 Sep 2025 00:27:34 -0400
X-MC-Unique: E79Y-tXYMSeg74Z6clqAvA-1
X-Mimecast-MFC-AGG-ID: E79Y-tXYMSeg74Z6clqAvA_1759206453
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b3c72638b5dso267632466b.3
        for <linux-csky@vger.kernel.org>; Mon, 29 Sep 2025 21:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759206453; x=1759811253;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=utL4hyQaWnCdzhUUrlBD6ZJyhvhWfn+CAzdni89roF0=;
        b=YcnLIAXjgHEA1SbpeKndAT3MX/b4N/jpkoN8KbIb/U1XX8R5BHuJ0pPztN4jH7aqvs
         UbwKk3B5Hvo9uerkZUAvk0zs+mdGjWzmYMXO5Grw7HYq1snyFuLisEi8Ue36JqzpzkMN
         4A+aDF/aqh96tIWZN3ThvRVs3GZjejcYqBpNoNm4qW92/KgJZkdDz8xdNlbzg8ZPfCPZ
         3miRMqmqMz6xZnKAsyaeeAynVcb/b0ypkoLc84JvE5j6CVYzjARd5pxB1r7ncIqpePGe
         45t1UD2ulrJmlrTic37a+KmrCnjzKXGwz2hp2QfsqNbDqP7wfZHDtc3/pTpynU0RzsHQ
         BHuA==
X-Gm-Message-State: AOJu0Ywhd3z0ANpTFHiqkftzEkQ2e9Rh48wQ0RCGU38VG2wHEVRKO3EC
	byh728j0kxo8BwHeIqwb3tcDW/FKjfsGUxcBm3sW59/lSLsMbr2PfiFjVIXhgxy9a34YypCCBU3
	CzVfwjdpGIvCspcAz2QrALIgPGVUmQY/HVjosAO2Ux8aAeByr3QOD915Kf7rwDyE=
X-Gm-Gg: ASbGncumwTKCFfCBBdGVeCd6NltcGVoVxzCyXqbjaQTgQn2FvoIpKzb59qrLzPjzqZL
	hIr1KbxYCD+FgcoKnHqCBcCmyAgQ+C5VnpcXV568RzN30mj6CPMVcOdBDuWQjk4UBfuiAruXKWe
	900VF9iPbWONZpBejQ6Am0hQa5dZFvjgR8zYC6ETuwPRbm4gUcQ/A92NujBQkqSRAjsCWyL47af
	SBxI3piWP0eQg1alWXrnQWBzmLuZOkgXX28xPm7Y3Q0/2kaXQfpWPz/C1KziPKxmutb4X9m2Vrq
	XfxVsquGe/5B16bjSwIescwXiCwpnO4/puzXCCcaHo0QOSd3laMLcE5qje8/lahCX1GjEOZSXvg
	bOVG75kR4nQ==
X-Received: by 2002:a17:907:9447:b0:b2d:28fd:c6bd with SMTP id a640c23a62f3a-b34ba450e21mr1962075566b.36.1759206452790;
        Mon, 29 Sep 2025 21:27:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu735iGcFOuhbMmqk9d0E0YK4V5iAOtIlcKsJ9M9s5Xv7Q4A/7aIWh6gDUBak6ZWE6AH8rQA==
X-Received: by 2002:a17:907:9447:b0:b2d:28fd:c6bd with SMTP id a640c23a62f3a-b34ba450e21mr1962073966b.36.1759206452357;
        Mon, 29 Sep 2025 21:27:32 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-056.pools.arcor-ip.net. [47.64.114.56])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b3544fd0a9esm1077231266b.84.2025.09.29.21.27.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 21:27:31 -0700 (PDT)
Message-ID: <8586069f-d9bd-43b2-bfb3-2b9cd1ccf999@redhat.com>
Date: Tue, 30 Sep 2025 06:27:30 +0200
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/41] csky: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 non-uapi headers
To: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-12-thuth@redhat.com>
 <5e154fcc-6102-414d-a7a6-53cbf366e224@redhat.com>
 <CAJF2gTRzRycsYeDAs8YZ_h-E2-i0CVLakix6zteuTcZi_6G6_A@mail.gmail.com>
 <6ac94cd5-3617-4f3c-9b12-b97922c0e9c4@redhat.com>
 <CAJF2gTQsuPtvz3T_TTbrrd=sCn6wGukYTrs5He7dx4XzmMjZiQ@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAJF2gTQsuPtvz3T_TTbrrd=sCn6wGukYTrs5He7dx4XzmMjZiQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/06/2025 09.20, Guo Ren wrote:
> On Fri, Jun 6, 2025 at 1:31 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 06/06/2025 04.23, Guo Ren wrote:
>>> On Fri, Jun 6, 2025 at 2:28 AM Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> On 14/03/2025 08.09, Thomas Huth wrote:
>>>>> While the GCC and Clang compilers already define __ASSEMBLER__
>>>>> automatically when compiling assembly code, __ASSEMBLY__ is a
>>>>> macro that only gets defined by the Makefiles in the kernel.
>>>>> This can be very confusing when switching between userspace
>>>>> and kernelspace coding, or when dealing with uapi headers that
>>>>> rather should use __ASSEMBLER__ instead. So let's standardize on
>>>>> the __ASSEMBLER__ macro that is provided by the compilers now.
>>>>>
>>>>> This is a completely mechanical patch (done with a simple "sed -i"
>>>>> statement).
>>>>>
>>>>> Cc: Guo Ren <guoren@kernel.org>
>>>>> Cc: linux-csky@vger.kernel.org
>>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>>> ---
>>>>>     arch/csky/abiv1/inc/abi/regdef.h    | 2 +-
>>>>>     arch/csky/abiv2/inc/abi/regdef.h    | 2 +-
>>>>>     arch/csky/include/asm/barrier.h     | 4 ++--
>>>>>     arch/csky/include/asm/cache.h       | 2 +-
>>>>>     arch/csky/include/asm/ftrace.h      | 4 ++--
>>>>>     arch/csky/include/asm/jump_label.h  | 4 ++--
>>>>>     arch/csky/include/asm/page.h        | 4 ++--
>>>>>     arch/csky/include/asm/ptrace.h      | 4 ++--
>>>>>     arch/csky/include/asm/string.h      | 2 +-
>>>>>     arch/csky/include/asm/thread_info.h | 4 ++--
>>>>>     10 files changed, 16 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/arch/csky/abiv1/inc/abi/regdef.h b/arch/csky/abiv1/inc/abi/regdef.h
>>>>> index 7b386fd670702..c75ecf2cafd7c 100644
>>>>> --- a/arch/csky/abiv1/inc/abi/regdef.h
>>>>> +++ b/arch/csky/abiv1/inc/abi/regdef.h
>>>>> @@ -3,7 +3,7 @@
>>>>>     #ifndef __ASM_CSKY_REGDEF_H
>>>>>     #define __ASM_CSKY_REGDEF_H
>>>>>
>>>>> -#ifdef __ASSEMBLY__
>>>>> +#ifdef __ASSEMBLER__
>>>>>     #define syscallid   r1
>>>>>     #else
>>>>>     #define syscallid   "r1"
>>>>> diff --git a/arch/csky/abiv2/inc/abi/regdef.h b/arch/csky/abiv2/inc/abi/regdef.h
>>>>> index 0933addbc27b7..fc08d56ccdbe1 100644
>>>>> --- a/arch/csky/abiv2/inc/abi/regdef.h
>>>>> +++ b/arch/csky/abiv2/inc/abi/regdef.h
>>>>> @@ -3,7 +3,7 @@
>>>>>     #ifndef __ASM_CSKY_REGDEF_H
>>>>>     #define __ASM_CSKY_REGDEF_H
>>>>>
>>>>> -#ifdef __ASSEMBLY__
>>>>> +#ifdef __ASSEMBLER__
>>>>>     #define syscallid   r7
>>>>>     #else
>>>>>     #define syscallid   "r7"
>>>>> diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
>>>>> index 15de58b10aece..c33fdcfe3770c 100644
>>>>> --- a/arch/csky/include/asm/barrier.h
>>>>> +++ b/arch/csky/include/asm/barrier.h
>>>>> @@ -3,7 +3,7 @@
>>>>>     #ifndef __ASM_CSKY_BARRIER_H
>>>>>     #define __ASM_CSKY_BARRIER_H
>>>>>
>>>>> -#ifndef __ASSEMBLY__
>>>>> +#ifndef __ASSEMBLER__
>>>>>
>>>>>     #define nop()       asm volatile ("nop\n":::"memory")
>>>>>
>>>>> @@ -84,5 +84,5 @@
>>>>>
>>>>>     #include <asm-generic/barrier.h>
>>>>>
>>>>> -#endif /* __ASSEMBLY__ */
>>>>> +#endif /* __ASSEMBLER__ */
>>>>>     #endif /* __ASM_CSKY_BARRIER_H */
>>>>> diff --git a/arch/csky/include/asm/cache.h b/arch/csky/include/asm/cache.h
>>>>> index 4b5c09bf1d25e..d575482e0fcec 100644
>>>>> --- a/arch/csky/include/asm/cache.h
>>>>> +++ b/arch/csky/include/asm/cache.h
>>>>> @@ -10,7 +10,7 @@
>>>>>
>>>>>     #define ARCH_DMA_MINALIGN   L1_CACHE_BYTES
>>>>>
>>>>> -#ifndef __ASSEMBLY__
>>>>> +#ifndef __ASSEMBLER__
>>>>>
>>>>>     void dcache_wb_line(unsigned long start);
>>>>>
>>>>> diff --git a/arch/csky/include/asm/ftrace.h b/arch/csky/include/asm/ftrace.h
>>>>> index 00f9f7647e3f3..21532f2180587 100644
>>>>> --- a/arch/csky/include/asm/ftrace.h
>>>>> +++ b/arch/csky/include/asm/ftrace.h
>>>>> @@ -11,7 +11,7 @@
>>>>>
>>>>>     #define MCOUNT_ADDR ((unsigned long)_mcount)
>>>>>
>>>>> -#ifndef __ASSEMBLY__
>>>>> +#ifndef __ASSEMBLER__
>>>>>
>>>>>     extern void _mcount(unsigned long);
>>>>>
>>>>> @@ -28,5 +28,5 @@ struct dyn_arch_ftrace {
>>>>>     void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
>>>>>                            unsigned long frame_pointer);
>>>>>
>>>>> -#endif /* !__ASSEMBLY__ */
>>>>> +#endif /* !__ASSEMBLER__ */
>>>>>     #endif /* __ASM_CSKY_FTRACE_H */
>>>>> diff --git a/arch/csky/include/asm/jump_label.h b/arch/csky/include/asm/jump_label.h
>>>>> index ef2e37a10a0fe..603b0caa80249 100644
>>>>> --- a/arch/csky/include/asm/jump_label.h
>>>>> +++ b/arch/csky/include/asm/jump_label.h
>>>>> @@ -3,7 +3,7 @@
>>>>>     #ifndef __ASM_CSKY_JUMP_LABEL_H
>>>>>     #define __ASM_CSKY_JUMP_LABEL_H
>>>>>
>>>>> -#ifndef __ASSEMBLY__
>>>>> +#ifndef __ASSEMBLER__
>>>>>
>>>>>     #include <linux/types.h>
>>>>>
>>>>> @@ -48,5 +48,5 @@ void arch_jump_label_transform_static(struct jump_entry *entry,
>>>>>                                       enum jump_label_type type);
>>>>>     #define arch_jump_label_transform_static arch_jump_label_transform_static
>>>>>
>>>>> -#endif  /* __ASSEMBLY__ */
>>>>> +#endif  /* __ASSEMBLER__ */
>>>>>     #endif      /* __ASM_CSKY_JUMP_LABEL_H */
>>>>> diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
>>>>> index 4911d0892b71d..76774dbce8697 100644
>>>>> --- a/arch/csky/include/asm/page.h
>>>>> +++ b/arch/csky/include/asm/page.h
>>>>> @@ -26,7 +26,7 @@
>>>>>
>>>>>     #define PHYS_OFFSET_OFFSET (CONFIG_DRAM_BASE & (SSEG_SIZE - 1))
>>>>>
>>>>> -#ifndef __ASSEMBLY__
>>>>> +#ifndef __ASSEMBLER__
>>>>>
>>>>>     #include <linux/pfn.h>
>>>>>
>>>>> @@ -84,5 +84,5 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
>>>>>     #include <asm-generic/memory_model.h>
>>>>>     #include <asm-generic/getorder.h>
>>>>>
>>>>> -#endif /* !__ASSEMBLY__ */
>>>>> +#endif /* !__ASSEMBLER__ */
>>>>>     #endif /* __ASM_CSKY_PAGE_H */
>>>>> diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptrace.h
>>>>> index 0634b7895d81d..5f01839e11843 100644
>>>>> --- a/arch/csky/include/asm/ptrace.h
>>>>> +++ b/arch/csky/include/asm/ptrace.h
>>>>> @@ -8,7 +8,7 @@
>>>>>     #include <linux/types.h>
>>>>>     #include <linux/compiler.h>
>>>>>
>>>>> -#ifndef __ASSEMBLY__
>>>>> +#ifndef __ASSEMBLER__
>>>>>
>>>>>     #define PS_S        0x80000000 /* Supervisor Mode */
>>>>>
>>>>> @@ -98,5 +98,5 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
>>>>>
>>>>>     asmlinkage int syscall_trace_enter(struct pt_regs *regs);
>>>>>     asmlinkage void syscall_trace_exit(struct pt_regs *regs);
>>>>> -#endif /* __ASSEMBLY__ */
>>>>> +#endif /* __ASSEMBLER__ */
>>>>>     #endif /* __ASM_CSKY_PTRACE_H */
>>>>> diff --git a/arch/csky/include/asm/string.h b/arch/csky/include/asm/string.h
>>>>> index a0d81e9d6b8f6..82e99f52b547c 100644
>>>>> --- a/arch/csky/include/asm/string.h
>>>>> +++ b/arch/csky/include/asm/string.h
>>>>> @@ -3,7 +3,7 @@
>>>>>     #ifndef _CSKY_STRING_MM_H_
>>>>>     #define _CSKY_STRING_MM_H_
>>>>>
>>>>> -#ifndef __ASSEMBLY__
>>>>> +#ifndef __ASSEMBLER__
>>>>>     #include <linux/types.h>
>>>>>     #include <linux/compiler.h>
>>>>>     #include <abi/string.h>
>>>>> diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
>>>>> index b5ed788f0c681..fdd4f8ad45acf 100644
>>>>> --- a/arch/csky/include/asm/thread_info.h
>>>>> +++ b/arch/csky/include/asm/thread_info.h
>>>>> @@ -3,7 +3,7 @@
>>>>>     #ifndef _ASM_CSKY_THREAD_INFO_H
>>>>>     #define _ASM_CSKY_THREAD_INFO_H
>>>>>
>>>>> -#ifndef __ASSEMBLY__
>>>>> +#ifndef __ASSEMBLER__
>>>>>
>>>>>     #include <asm/types.h>
>>>>>     #include <asm/page.h>
>>>>> @@ -51,7 +51,7 @@ static inline struct thread_info *current_thread_info(void)
>>>>>         return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
>>>>>     }
>>>>>
>>>>> -#endif /* !__ASSEMBLY__ */
>>>>> +#endif /* !__ASSEMBLER__ */
>>>>>
>>>>>     #define TIF_SIGPENDING              0       /* signal pending */
>>>>>     #define TIF_NOTIFY_RESUME   1       /* callback before returning to user */
>>>>
>>>> Friendly ping!
>>>>
>>>> Guo Ren, could you maybe pick this (and the previous patch) up via your csky
>>>> tree? (x86 and parisc already got merge via their respective architecture
>>>> trees, so I guess the same should happen for this patch here, too).
>>>>
>>>>     Thanks,
>>>>      Thomas
>>>>
>>> How about riscv?
>>
>> The riscv patch
>> (https://lore.kernel.org/all/20250314071013.1575167-30-thuth@redhat.com/)
>> needs a rebase since it does not apply cleanly anymore. I'll try to do that
>> in the next couple of days.
> Thanks for the info, I would take the patch after the other
> architecture is approved. It's not a rush job.

The riscv patch has now been merged. Could you please pick up the csky patch 
now?

  Thanks,
   Thomas


