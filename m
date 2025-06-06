Return-Path: <linux-csky+bounces-2066-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82936ACFC3B
	for <lists+linux-csky@lfdr.de>; Fri,  6 Jun 2025 07:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB6A41892939
	for <lists+linux-csky@lfdr.de>; Fri,  6 Jun 2025 05:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECD21E9906;
	Fri,  6 Jun 2025 05:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBX0XdlK"
X-Original-To: linux-csky@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7C34683
	for <linux-csky@vger.kernel.org>; Fri,  6 Jun 2025 05:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749187905; cv=none; b=jvRc4JWUPmqhj0n4PFjxm5iGby4kLT+bkSaph80msd1Pf8Sj2Er+X74f7+GZ1cKPJ/jw/9YOz5tbuyj1QkoX8f/eKGH8zOrynAe49dOqnhYvk5d8vcp52m+Hjv8wzgVYJmixzoEr21JCyuizJ1HJ6mCEy3idxrtsjzxWuXo5o4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749187905; c=relaxed/simple;
	bh=crILWHATz3myKufQM2oqMhNID6fhd80hRpTLtdHnPV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oflTRfl0cIYZCmhd/62JolooC930cNSmOsLV7fePfrpCijVPwqK1ChpxA9ZZ2gktj5Gh4tNZLBursaEmH8Xh7TlB18+9PGCPAbKJ/YYuQqG7M7eou0rhEIafe8r/a+265RM/Vg3nI0AL1T60RnhmQ2RuSnRA/MlcupILjHXSD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBX0XdlK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749187902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ifs1gVMsFDFHQcnD6sgGmGgrQardixLKh1qiRCBgYjw=;
	b=BBX0XdlKtJUpzErzd/YuEqbJo7AYAv91Puah68xw6spyalaQNBQBf+7wHRH368MfPvKydS
	ZmCi3MYmBmf+YjEy8o5Q7DAolvIdq5D1VaexKR1ERC0Qi7uLZVcKKuqOR3ajKgPNmE7Ms1
	Apx63qKKGCqJPsIMm4wWrh/sn2SLaLY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-q-ibptuJOYKfUkIbKiGb5Q-1; Fri, 06 Jun 2025 01:31:40 -0400
X-MC-Unique: q-ibptuJOYKfUkIbKiGb5Q-1
X-Mimecast-MFC-AGG-ID: q-ibptuJOYKfUkIbKiGb5Q_1749187899
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6077af4c313so186561a12.0
        for <linux-csky@vger.kernel.org>; Thu, 05 Jun 2025 22:31:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749187899; x=1749792699;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ifs1gVMsFDFHQcnD6sgGmGgrQardixLKh1qiRCBgYjw=;
        b=Pp6swVmn1SCzYsEV2x+CWxb2v/P6h9B9iqN3LTHNnQ0UkifxWNRBoGpQrU1gIGrLrv
         9+USaFOBiJQ8XGfuk2+AImRHEotBlvFnlHWVy57yz0FOvcjGhA4lFFNUpTFucP+o+gkw
         mqC1ZBivC5OmI7XITEz+qMWEns3hDUq1hLEiOMs76s2M3NRH6IIdzh2wmE2uk42uzSxm
         x7L8nK5DTpon3w654fgxjrIRG4IRvnSmfv7J55NYtMeTObLtgLha3Uvt5pVU9GSfVPZA
         Ve5VkWIX31pfAcVrrl3+IL8EEW+oYlIZsUmDh0GuJG3mKESE4H6vRzIdQZWASxAgAlnt
         hWGg==
X-Gm-Message-State: AOJu0YwCSkn2ZqO/Yhnbp57Ge2k4ufNNMvAR8ybC9QcCW++5/BqMxaDx
	VBasykb42UxH5dvaSuf0wUa+A3lq8wQQ5iH9WrGH+CdlxGoeZpve56lOy2pPLcN05nSAOSLI83i
	tz99e2tg0FrJ11o6j91W4IzxOrt+OR6xFOaLpmbnOGsmbVoKZaQZF5WG5B75DqL0=
X-Gm-Gg: ASbGnctrnu/zXLV4hXEIpDc8F5AJBTbdjrk0MrvS5fwgVgYey/BQdQq/RLaFLqdkQm3
	+KDBF/xxXesZMaOhP4M1kS3P7ZK0/OuAeE8T3PkCSJBlk5PdAcG7UeXodAJoWRRPJ/2Vi7gp/Ep
	Ztc1Gx2zrA7kzuLL5VEy7tePvC+kcKk++DIaLp9f/1VyZbT88PBFE7QrRY0Q7vgDaezLt1pAwWO
	E6AYc5a6uKpzRAvJ4xpQyNGxUz1Ys9x8YTW13H4wC3+dBxFtwnhEDWIU9IQhuL8TfHEM9s+kWRm
	C+VoDq+ekG7Z1WTRLHA0WXbXGy2gJrZXVbtrUS1BTfgoVaLnxWMp1w==
X-Received: by 2002:a05:6402:35ce:b0:600:129:444e with SMTP id 4fb4d7f45d1cf-60772a65fd1mr1582934a12.4.1749187899235;
        Thu, 05 Jun 2025 22:31:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1yoB+ouioGhKTx9m+Z09LS1wyN705Vuqc5O+5yVOZd1A9gvzoUFs6r3A8n8Bovkg51RuS/Q==
X-Received: by 2002:a05:6402:35ce:b0:600:129:444e with SMTP id 4fb4d7f45d1cf-60772a65fd1mr1582919a12.4.1749187898808;
        Thu, 05 Jun 2025 22:31:38 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-42-50-214.web.vodafone.de. [109.42.50.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607783e682dsm561520a12.76.2025.06.05.22.31.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 22:31:38 -0700 (PDT)
Message-ID: <6ac94cd5-3617-4f3c-9b12-b97922c0e9c4@redhat.com>
Date: Fri, 6 Jun 2025 07:31:37 +0200
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
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAJF2gTRzRycsYeDAs8YZ_h-E2-i0CVLakix6zteuTcZi_6G6_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 06/06/2025 04.23, Guo Ren wrote:
> On Fri, Jun 6, 2025 at 2:28 AM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 14/03/2025 08.09, Thomas Huth wrote:
>>> While the GCC and Clang compilers already define __ASSEMBLER__
>>> automatically when compiling assembly code, __ASSEMBLY__ is a
>>> macro that only gets defined by the Makefiles in the kernel.
>>> This can be very confusing when switching between userspace
>>> and kernelspace coding, or when dealing with uapi headers that
>>> rather should use __ASSEMBLER__ instead. So let's standardize on
>>> the __ASSEMBLER__ macro that is provided by the compilers now.
>>>
>>> This is a completely mechanical patch (done with a simple "sed -i"
>>> statement).
>>>
>>> Cc: Guo Ren <guoren@kernel.org>
>>> Cc: linux-csky@vger.kernel.org
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>    arch/csky/abiv1/inc/abi/regdef.h    | 2 +-
>>>    arch/csky/abiv2/inc/abi/regdef.h    | 2 +-
>>>    arch/csky/include/asm/barrier.h     | 4 ++--
>>>    arch/csky/include/asm/cache.h       | 2 +-
>>>    arch/csky/include/asm/ftrace.h      | 4 ++--
>>>    arch/csky/include/asm/jump_label.h  | 4 ++--
>>>    arch/csky/include/asm/page.h        | 4 ++--
>>>    arch/csky/include/asm/ptrace.h      | 4 ++--
>>>    arch/csky/include/asm/string.h      | 2 +-
>>>    arch/csky/include/asm/thread_info.h | 4 ++--
>>>    10 files changed, 16 insertions(+), 16 deletions(-)
>>>
>>> diff --git a/arch/csky/abiv1/inc/abi/regdef.h b/arch/csky/abiv1/inc/abi/regdef.h
>>> index 7b386fd670702..c75ecf2cafd7c 100644
>>> --- a/arch/csky/abiv1/inc/abi/regdef.h
>>> +++ b/arch/csky/abiv1/inc/abi/regdef.h
>>> @@ -3,7 +3,7 @@
>>>    #ifndef __ASM_CSKY_REGDEF_H
>>>    #define __ASM_CSKY_REGDEF_H
>>>
>>> -#ifdef __ASSEMBLY__
>>> +#ifdef __ASSEMBLER__
>>>    #define syscallid   r1
>>>    #else
>>>    #define syscallid   "r1"
>>> diff --git a/arch/csky/abiv2/inc/abi/regdef.h b/arch/csky/abiv2/inc/abi/regdef.h
>>> index 0933addbc27b7..fc08d56ccdbe1 100644
>>> --- a/arch/csky/abiv2/inc/abi/regdef.h
>>> +++ b/arch/csky/abiv2/inc/abi/regdef.h
>>> @@ -3,7 +3,7 @@
>>>    #ifndef __ASM_CSKY_REGDEF_H
>>>    #define __ASM_CSKY_REGDEF_H
>>>
>>> -#ifdef __ASSEMBLY__
>>> +#ifdef __ASSEMBLER__
>>>    #define syscallid   r7
>>>    #else
>>>    #define syscallid   "r7"
>>> diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
>>> index 15de58b10aece..c33fdcfe3770c 100644
>>> --- a/arch/csky/include/asm/barrier.h
>>> +++ b/arch/csky/include/asm/barrier.h
>>> @@ -3,7 +3,7 @@
>>>    #ifndef __ASM_CSKY_BARRIER_H
>>>    #define __ASM_CSKY_BARRIER_H
>>>
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>
>>>    #define nop()       asm volatile ("nop\n":::"memory")
>>>
>>> @@ -84,5 +84,5 @@
>>>
>>>    #include <asm-generic/barrier.h>
>>>
>>> -#endif /* __ASSEMBLY__ */
>>> +#endif /* __ASSEMBLER__ */
>>>    #endif /* __ASM_CSKY_BARRIER_H */
>>> diff --git a/arch/csky/include/asm/cache.h b/arch/csky/include/asm/cache.h
>>> index 4b5c09bf1d25e..d575482e0fcec 100644
>>> --- a/arch/csky/include/asm/cache.h
>>> +++ b/arch/csky/include/asm/cache.h
>>> @@ -10,7 +10,7 @@
>>>
>>>    #define ARCH_DMA_MINALIGN   L1_CACHE_BYTES
>>>
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>
>>>    void dcache_wb_line(unsigned long start);
>>>
>>> diff --git a/arch/csky/include/asm/ftrace.h b/arch/csky/include/asm/ftrace.h
>>> index 00f9f7647e3f3..21532f2180587 100644
>>> --- a/arch/csky/include/asm/ftrace.h
>>> +++ b/arch/csky/include/asm/ftrace.h
>>> @@ -11,7 +11,7 @@
>>>
>>>    #define MCOUNT_ADDR ((unsigned long)_mcount)
>>>
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>
>>>    extern void _mcount(unsigned long);
>>>
>>> @@ -28,5 +28,5 @@ struct dyn_arch_ftrace {
>>>    void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
>>>                           unsigned long frame_pointer);
>>>
>>> -#endif /* !__ASSEMBLY__ */
>>> +#endif /* !__ASSEMBLER__ */
>>>    #endif /* __ASM_CSKY_FTRACE_H */
>>> diff --git a/arch/csky/include/asm/jump_label.h b/arch/csky/include/asm/jump_label.h
>>> index ef2e37a10a0fe..603b0caa80249 100644
>>> --- a/arch/csky/include/asm/jump_label.h
>>> +++ b/arch/csky/include/asm/jump_label.h
>>> @@ -3,7 +3,7 @@
>>>    #ifndef __ASM_CSKY_JUMP_LABEL_H
>>>    #define __ASM_CSKY_JUMP_LABEL_H
>>>
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>
>>>    #include <linux/types.h>
>>>
>>> @@ -48,5 +48,5 @@ void arch_jump_label_transform_static(struct jump_entry *entry,
>>>                                      enum jump_label_type type);
>>>    #define arch_jump_label_transform_static arch_jump_label_transform_static
>>>
>>> -#endif  /* __ASSEMBLY__ */
>>> +#endif  /* __ASSEMBLER__ */
>>>    #endif      /* __ASM_CSKY_JUMP_LABEL_H */
>>> diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
>>> index 4911d0892b71d..76774dbce8697 100644
>>> --- a/arch/csky/include/asm/page.h
>>> +++ b/arch/csky/include/asm/page.h
>>> @@ -26,7 +26,7 @@
>>>
>>>    #define PHYS_OFFSET_OFFSET (CONFIG_DRAM_BASE & (SSEG_SIZE - 1))
>>>
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>
>>>    #include <linux/pfn.h>
>>>
>>> @@ -84,5 +84,5 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
>>>    #include <asm-generic/memory_model.h>
>>>    #include <asm-generic/getorder.h>
>>>
>>> -#endif /* !__ASSEMBLY__ */
>>> +#endif /* !__ASSEMBLER__ */
>>>    #endif /* __ASM_CSKY_PAGE_H */
>>> diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptrace.h
>>> index 0634b7895d81d..5f01839e11843 100644
>>> --- a/arch/csky/include/asm/ptrace.h
>>> +++ b/arch/csky/include/asm/ptrace.h
>>> @@ -8,7 +8,7 @@
>>>    #include <linux/types.h>
>>>    #include <linux/compiler.h>
>>>
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>
>>>    #define PS_S        0x80000000 /* Supervisor Mode */
>>>
>>> @@ -98,5 +98,5 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
>>>
>>>    asmlinkage int syscall_trace_enter(struct pt_regs *regs);
>>>    asmlinkage void syscall_trace_exit(struct pt_regs *regs);
>>> -#endif /* __ASSEMBLY__ */
>>> +#endif /* __ASSEMBLER__ */
>>>    #endif /* __ASM_CSKY_PTRACE_H */
>>> diff --git a/arch/csky/include/asm/string.h b/arch/csky/include/asm/string.h
>>> index a0d81e9d6b8f6..82e99f52b547c 100644
>>> --- a/arch/csky/include/asm/string.h
>>> +++ b/arch/csky/include/asm/string.h
>>> @@ -3,7 +3,7 @@
>>>    #ifndef _CSKY_STRING_MM_H_
>>>    #define _CSKY_STRING_MM_H_
>>>
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>    #include <linux/types.h>
>>>    #include <linux/compiler.h>
>>>    #include <abi/string.h>
>>> diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
>>> index b5ed788f0c681..fdd4f8ad45acf 100644
>>> --- a/arch/csky/include/asm/thread_info.h
>>> +++ b/arch/csky/include/asm/thread_info.h
>>> @@ -3,7 +3,7 @@
>>>    #ifndef _ASM_CSKY_THREAD_INFO_H
>>>    #define _ASM_CSKY_THREAD_INFO_H
>>>
>>> -#ifndef __ASSEMBLY__
>>> +#ifndef __ASSEMBLER__
>>>
>>>    #include <asm/types.h>
>>>    #include <asm/page.h>
>>> @@ -51,7 +51,7 @@ static inline struct thread_info *current_thread_info(void)
>>>        return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
>>>    }
>>>
>>> -#endif /* !__ASSEMBLY__ */
>>> +#endif /* !__ASSEMBLER__ */
>>>
>>>    #define TIF_SIGPENDING              0       /* signal pending */
>>>    #define TIF_NOTIFY_RESUME   1       /* callback before returning to user */
>>
>> Friendly ping!
>>
>> Guo Ren, could you maybe pick this (and the previous patch) up via your csky
>> tree? (x86 and parisc already got merge via their respective architecture
>> trees, so I guess the same should happen for this patch here, too).
>>
>>    Thanks,
>>     Thomas
>>
> How about riscv?

The riscv patch 
(https://lore.kernel.org/all/20250314071013.1575167-30-thuth@redhat.com/) 
needs a rebase since it does not apply cleanly anymore. I'll try to do that 
in the next couple of days.

  Thomas


