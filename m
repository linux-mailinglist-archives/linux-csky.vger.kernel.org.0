Return-Path: <linux-csky+bounces-2064-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84E8ACF68C
	for <lists+linux-csky@lfdr.de>; Thu,  5 Jun 2025 20:29:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9985916728C
	for <lists+linux-csky@lfdr.de>; Thu,  5 Jun 2025 18:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572F127A918;
	Thu,  5 Jun 2025 18:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QS3nLMoy"
X-Original-To: linux-csky@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030C91F1515
	for <linux-csky@vger.kernel.org>; Thu,  5 Jun 2025 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749148137; cv=none; b=KMhTBA7ZTE31DhBEm9htkgHj3wkiOe8fZnEfrpHMEOpeXwAEEIC3VhQJ5pUK5E7Msprqr17MsG+EPp8bpdrETKKeitgTYVxgUNhvxd5mS1ra/h5YF1Vaq5Ob45U0MBs8JL21Qj5qfidtnXde9Z23iHmL+uo0nPyi8GS3XbAg4Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749148137; c=relaxed/simple;
	bh=uWyChXu5+aF6XGqubchXdY8sPrHXGo1yBTM/RuSdgT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4WNG4D2Ha+ThYPxLEioel205Gi18Uv+fb/IKLvouWD2d9VC2+qB87dWXH/0HtpbUDGi14Rvj7pXHfEYT3F8uFJGdI+Ut9VF61P8BW1xPNNotdeVZHJxekGbMVxU+9G/7Bm3x42HJLMWpp89gAGSn02l007l69XYGiBOQS56m1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QS3nLMoy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749148132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OYjDWCep/eBDpsqey2OaAJxSsdq2V7997KWPVf7AAhg=;
	b=QS3nLMoyW0xjuroGjI9xZMkVFFz31ZMWN+zDp47Qqk6OCori95ItPVE0bm+QfKUQoqw6CD
	kcu8wVGthU+sBd0yLMDu8LlQNCEApTB9Q3jzJA4hrmb0jgTfOczsmQB89qdTb6sF65hiPg
	PuzJvuegbmHz6JrVV5kgpXcHWaG3iwc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-j-dcueYkN3i5oupmUQal1w-1; Thu, 05 Jun 2025 14:28:48 -0400
X-MC-Unique: j-dcueYkN3i5oupmUQal1w-1
X-Mimecast-MFC-AGG-ID: j-dcueYkN3i5oupmUQal1w_1749148126
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-450cb902173so7357435e9.1
        for <linux-csky@vger.kernel.org>; Thu, 05 Jun 2025 11:28:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749148126; x=1749752926;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OYjDWCep/eBDpsqey2OaAJxSsdq2V7997KWPVf7AAhg=;
        b=I4scQOwhidKXinsCdX9SUWa0qyRgZDlmSnQGCeC7/9VV/Brd1UJRTxfkY3EtIuioff
         5NTLfF7rzuQrmpTE0Z0QDxjp0CfMjP+/Uu9EAekq16utlcExSYWvakO4EDdkW4VKhpYZ
         frz0TOuZeNGPJgk7nv+lgCmCjkoE+/3lMVv8kQl1Ej4uj7JkBU6GUYy7Y8Y4B9YD3vG3
         8i8Tp7TJ4NC4UJwdy8j/HrlGnuo8Hkk73Eg8Go2s7GGULG4Bg2YFO2DFuqc4wev8D7wE
         lZHplvFrC5Aiznw3bWUqL0F4H7XtpUFW8takeAGGrWYQWyBNXgNoQdkrCmfyoyqzQj7c
         nh5w==
X-Gm-Message-State: AOJu0Yz73Ms9XUCVmMlMK2TV/rPHgcB1U+LKtT4f33hTZIgKPr++K+Dd
	VXJGVAje3rHhqHukWPfay/Dlsd/jasj6rvjQ/2WsL4Ptruk8nEBQFkIrEyzOktUXki1640apdJ7
	jXxii7WbGFrv7uFXhYpe2HT2C9nlH+583w5ZDNMlWdRi0ouI+sCZSU739+aO2wDQ=
X-Gm-Gg: ASbGncvzbnLkXpWa81Ex6jkayq35Snrm3EoSaeBj0FAup+SaTccamjy+X2KkhVeWJCh
	gHM6taRqOQXZM/A+wUeDwKFe8MyvB1umEiqkyGPw7QevBVsuZK6ufc8MUYLr8iTCGLbmFKxPYhV
	cPm8u5k8M0n29U9YqiMA8DkwP4CQSHRpMVNjJOWKJ6bjHbFWSgSGu4si+AuSfqsh5f4QwFsLarg
	HOr4ZrAUXBoriGceDx//YVd0RCmJKLWkj27mbPtmmrWYZjb9d0anXsB0+eBHfoz9dXe3sLWh7KK
	GUs1VHzQk8J5h3jG+t/uwjc3ZQ2HwC4AIbfVbxoKqn0=
X-Received: by 2002:a05:600c:225a:b0:43d:174:2668 with SMTP id 5b1f17b1804b1-451f83a0621mr32836115e9.0.1749148126431;
        Thu, 05 Jun 2025 11:28:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwCKkZcbCfwlLFWkIEecS4+rhLyYwoRKr3Ai+HVWPjsQ/kxf/t0e0LcYU7wCSzoimAXqcpVg==
X-Received: by 2002:a05:600c:225a:b0:43d:174:2668 with SMTP id 5b1f17b1804b1-451f83a0621mr32836025e9.0.1749148125993;
        Thu, 05 Jun 2025 11:28:45 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-42-50-214.web.vodafone.de. [109.42.50.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45209ce1583sm1090325e9.9.2025.06.05.11.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 11:28:45 -0700 (PDT)
Message-ID: <5e154fcc-6102-414d-a7a6-53cbf366e224@redhat.com>
Date: Thu, 5 Jun 2025 20:28:44 +0200
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
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250314071013.1575167-12-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14/03/2025 08.09, Thomas Huth wrote:
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, or when dealing with uapi headers that
> rather should use __ASSEMBLER__ instead. So let's standardize on
> the __ASSEMBLER__ macro that is provided by the compilers now.
> 
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).
> 
> Cc: Guo Ren <guoren@kernel.org>
> Cc: linux-csky@vger.kernel.org
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   arch/csky/abiv1/inc/abi/regdef.h    | 2 +-
>   arch/csky/abiv2/inc/abi/regdef.h    | 2 +-
>   arch/csky/include/asm/barrier.h     | 4 ++--
>   arch/csky/include/asm/cache.h       | 2 +-
>   arch/csky/include/asm/ftrace.h      | 4 ++--
>   arch/csky/include/asm/jump_label.h  | 4 ++--
>   arch/csky/include/asm/page.h        | 4 ++--
>   arch/csky/include/asm/ptrace.h      | 4 ++--
>   arch/csky/include/asm/string.h      | 2 +-
>   arch/csky/include/asm/thread_info.h | 4 ++--
>   10 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/csky/abiv1/inc/abi/regdef.h b/arch/csky/abiv1/inc/abi/regdef.h
> index 7b386fd670702..c75ecf2cafd7c 100644
> --- a/arch/csky/abiv1/inc/abi/regdef.h
> +++ b/arch/csky/abiv1/inc/abi/regdef.h
> @@ -3,7 +3,7 @@
>   #ifndef __ASM_CSKY_REGDEF_H
>   #define __ASM_CSKY_REGDEF_H
>   
> -#ifdef __ASSEMBLY__
> +#ifdef __ASSEMBLER__
>   #define syscallid	r1
>   #else
>   #define syscallid	"r1"
> diff --git a/arch/csky/abiv2/inc/abi/regdef.h b/arch/csky/abiv2/inc/abi/regdef.h
> index 0933addbc27b7..fc08d56ccdbe1 100644
> --- a/arch/csky/abiv2/inc/abi/regdef.h
> +++ b/arch/csky/abiv2/inc/abi/regdef.h
> @@ -3,7 +3,7 @@
>   #ifndef __ASM_CSKY_REGDEF_H
>   #define __ASM_CSKY_REGDEF_H
>   
> -#ifdef __ASSEMBLY__
> +#ifdef __ASSEMBLER__
>   #define syscallid	r7
>   #else
>   #define syscallid	"r7"
> diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/barrier.h
> index 15de58b10aece..c33fdcfe3770c 100644
> --- a/arch/csky/include/asm/barrier.h
> +++ b/arch/csky/include/asm/barrier.h
> @@ -3,7 +3,7 @@
>   #ifndef __ASM_CSKY_BARRIER_H
>   #define __ASM_CSKY_BARRIER_H
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   #define nop()	asm volatile ("nop\n":::"memory")
>   
> @@ -84,5 +84,5 @@
>   
>   #include <asm-generic/barrier.h>
>   
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   #endif /* __ASM_CSKY_BARRIER_H */
> diff --git a/arch/csky/include/asm/cache.h b/arch/csky/include/asm/cache.h
> index 4b5c09bf1d25e..d575482e0fcec 100644
> --- a/arch/csky/include/asm/cache.h
> +++ b/arch/csky/include/asm/cache.h
> @@ -10,7 +10,7 @@
>   
>   #define ARCH_DMA_MINALIGN	L1_CACHE_BYTES
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   void dcache_wb_line(unsigned long start);
>   
> diff --git a/arch/csky/include/asm/ftrace.h b/arch/csky/include/asm/ftrace.h
> index 00f9f7647e3f3..21532f2180587 100644
> --- a/arch/csky/include/asm/ftrace.h
> +++ b/arch/csky/include/asm/ftrace.h
> @@ -11,7 +11,7 @@
>   
>   #define MCOUNT_ADDR	((unsigned long)_mcount)
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   extern void _mcount(unsigned long);
>   
> @@ -28,5 +28,5 @@ struct dyn_arch_ftrace {
>   void prepare_ftrace_return(unsigned long *parent, unsigned long self_addr,
>   			   unsigned long frame_pointer);
>   
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>   #endif /* __ASM_CSKY_FTRACE_H */
> diff --git a/arch/csky/include/asm/jump_label.h b/arch/csky/include/asm/jump_label.h
> index ef2e37a10a0fe..603b0caa80249 100644
> --- a/arch/csky/include/asm/jump_label.h
> +++ b/arch/csky/include/asm/jump_label.h
> @@ -3,7 +3,7 @@
>   #ifndef __ASM_CSKY_JUMP_LABEL_H
>   #define __ASM_CSKY_JUMP_LABEL_H
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   #include <linux/types.h>
>   
> @@ -48,5 +48,5 @@ void arch_jump_label_transform_static(struct jump_entry *entry,
>   				      enum jump_label_type type);
>   #define arch_jump_label_transform_static arch_jump_label_transform_static
>   
> -#endif  /* __ASSEMBLY__ */
> +#endif  /* __ASSEMBLER__ */
>   #endif	/* __ASM_CSKY_JUMP_LABEL_H */
> diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
> index 4911d0892b71d..76774dbce8697 100644
> --- a/arch/csky/include/asm/page.h
> +++ b/arch/csky/include/asm/page.h
> @@ -26,7 +26,7 @@
>   
>   #define PHYS_OFFSET_OFFSET (CONFIG_DRAM_BASE & (SSEG_SIZE - 1))
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   #include <linux/pfn.h>
>   
> @@ -84,5 +84,5 @@ static inline unsigned long virt_to_pfn(const void *kaddr)
>   #include <asm-generic/memory_model.h>
>   #include <asm-generic/getorder.h>
>   
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>   #endif /* __ASM_CSKY_PAGE_H */
> diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptrace.h
> index 0634b7895d81d..5f01839e11843 100644
> --- a/arch/csky/include/asm/ptrace.h
> +++ b/arch/csky/include/asm/ptrace.h
> @@ -8,7 +8,7 @@
>   #include <linux/types.h>
>   #include <linux/compiler.h>
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   #define PS_S	0x80000000 /* Supervisor Mode */
>   
> @@ -98,5 +98,5 @@ static inline unsigned long regs_get_register(struct pt_regs *regs,
>   
>   asmlinkage int syscall_trace_enter(struct pt_regs *regs);
>   asmlinkage void syscall_trace_exit(struct pt_regs *regs);
> -#endif /* __ASSEMBLY__ */
> +#endif /* __ASSEMBLER__ */
>   #endif /* __ASM_CSKY_PTRACE_H */
> diff --git a/arch/csky/include/asm/string.h b/arch/csky/include/asm/string.h
> index a0d81e9d6b8f6..82e99f52b547c 100644
> --- a/arch/csky/include/asm/string.h
> +++ b/arch/csky/include/asm/string.h
> @@ -3,7 +3,7 @@
>   #ifndef _CSKY_STRING_MM_H_
>   #define _CSKY_STRING_MM_H_
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   #include <linux/types.h>
>   #include <linux/compiler.h>
>   #include <abi/string.h>
> diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
> index b5ed788f0c681..fdd4f8ad45acf 100644
> --- a/arch/csky/include/asm/thread_info.h
> +++ b/arch/csky/include/asm/thread_info.h
> @@ -3,7 +3,7 @@
>   #ifndef _ASM_CSKY_THREAD_INFO_H
>   #define _ASM_CSKY_THREAD_INFO_H
>   
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>   
>   #include <asm/types.h>
>   #include <asm/page.h>
> @@ -51,7 +51,7 @@ static inline struct thread_info *current_thread_info(void)
>   	return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
>   }
>   
> -#endif /* !__ASSEMBLY__ */
> +#endif /* !__ASSEMBLER__ */
>   
>   #define TIF_SIGPENDING		0	/* signal pending */
>   #define TIF_NOTIFY_RESUME	1       /* callback before returning to user */

Friendly ping!

Guo Ren, could you maybe pick this (and the previous patch) up via your csky 
tree? (x86 and parisc already got merge via their respective architecture 
trees, so I guess the same should happen for this patch here, too).

  Thanks,
   Thomas


