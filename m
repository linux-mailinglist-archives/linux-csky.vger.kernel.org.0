Return-Path: <linux-csky+bounces-64-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5B87E6786
	for <lists+linux-csky@lfdr.de>; Thu,  9 Nov 2023 11:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E23280DCD
	for <lists+linux-csky@lfdr.de>; Thu,  9 Nov 2023 10:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A644168D4;
	Thu,  9 Nov 2023 10:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQVVPWjJ"
X-Original-To: linux-csky@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7257F15AC1
	for <linux-csky@vger.kernel.org>; Thu,  9 Nov 2023 10:13:43 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC842D71
	for <linux-csky@vger.kernel.org>; Thu,  9 Nov 2023 02:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699524822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3rYhpoB4lYmS4MLIzZUo4ZMf6R8bUZVPeYV6RdLZieo=;
	b=NQVVPWjJqELKLpSGCsq5RCplSGdIJC/P3taGBNX6GM6zUIRVE1A/NKouiUP1yK9hZnV3J6
	q3MrYkE12TSUNZYiMrBi4QE6M8q0dqP/e7o19p75oD3gt+nBsd6btkC+yaM1+ibtvMCzw7
	EKMIMjQuX3kFRa0AAnO7blxVwkfPpWY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-7H_m5zMKOfWewA8aqSdLwg-1; Thu, 09 Nov 2023 05:13:39 -0500
X-MC-Unique: 7H_m5zMKOfWewA8aqSdLwg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2800be2d781so188017a91.1
        for <linux-csky@vger.kernel.org>; Thu, 09 Nov 2023 02:13:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524814; x=1700129614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rYhpoB4lYmS4MLIzZUo4ZMf6R8bUZVPeYV6RdLZieo=;
        b=FezDHJ4DxUQGr9SoysSeVtCSrN8NQKtMOW8rW6ScwlCymcjoI+I4dtTojybCx4ZzyZ
         DmOx4ou+d6a6ypsc3FW4Uw3UyMOLb/vU7FBDGVQSOPrOXgyvzuGcyFdlktIFeZJPVCm3
         Rf5iYGheW/ii8tKgAtyVg3o0I6PBj3wSLdfexvjNnk8dT12ywrqbODDaEKaf89jyIKSQ
         RFfu6TbeoOT/2p+gX6u8c8u6y7XcmdXna8HyJHo+S5HTrm3dL6+vwnkZ9VV5TIsUY/gi
         dQAOt5gxlaYF9cJ0FHXP/zw4gtAxlmZvvbqe5FPRnW+uOpAKtJzESWaphYJ0eC/WE0N3
         s3pg==
X-Gm-Message-State: AOJu0Yx/+r4Y8KIKAvd+/LxSF/edD+gWj8SRGzOGcCxz1kU4BatVPeZw
	5y4SQqTb91AM4JOMiAh4G9P/K6DAIeKRzKghIME6fIlrCGsu846dYu9uWN9H84WvkJ6sdi5/t4z
	9C2xhdsau4ECBUhkEwemJEg==
X-Received: by 2002:a17:903:120e:b0:1cc:ebe:5547 with SMTP id l14-20020a170903120e00b001cc0ebe5547mr5043358plh.0.1699524813773;
        Thu, 09 Nov 2023 02:13:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMYccyPUYXdRLbiWAt/Rrr2lff8DkVfjHrlmnPr9rVOEThxcSXfzeRdAMTZ0+vEY8CCgW5xw==
X-Received: by 2002:a17:903:120e:b0:1cc:ebe:5547 with SMTP id l14-20020a170903120e00b001cc0ebe5547mr5043330plh.0.1699524813447;
        Thu, 09 Nov 2023 02:13:33 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p2-20020a170902e74200b001c60a2b5c61sm3165370plf.134.2023.11.09.02.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 02:13:33 -0800 (PST)
Message-ID: <6341a77d-ba42-3f3a-4a2a-b598fb5c0e20@redhat.com>
Date: Thu, 9 Nov 2023 18:13:26 +0800
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 07/22] drivers: base: Allow parts of
 GENERIC_CPU_DEVICES to be overridden
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org,
 linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com,
 justin.he@arm.com, James Morse <james.morse@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLG-00CTx8-CG@rmk-PC.armlinux.org.uk>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <E1r0JLG-00CTx8-CG@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/7/23 18:29, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Architectures often have extra per-cpu work that needs doing
> before a CPU is registered, often to determine if a CPU is
> hotpluggable.
> 
> To allow the ACPI architectures to use GENERIC_CPU_DEVICES, move
> the cpu_register() call into arch_register_cpu(), which is made __weak
> so architectures with extra work can override it.
> This aligns with the way x86, ia64 and loongarch register hotplug CPUs
> when they become present.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
> Changes since RFC:
>   * Dropped __init from x86/ia64 arch_register_cpu()
> Changes since RFC v2:
>   * Dropped unnecessary Loongarch asm/cpu.h changes
> ---
>   drivers/base/cpu.c  | 14 ++++++++++----
>   include/linux/cpu.h |  4 ++++
>   2 files changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 34b48f660b6b..579064fda97b 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -525,19 +525,25 @@ bool cpu_is_hotpluggable(unsigned int cpu)
>   EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
>   
>   #ifdef CONFIG_GENERIC_CPU_DEVICES
> -static DEFINE_PER_CPU(struct cpu, cpu_devices);
> +DEFINE_PER_CPU(struct cpu, cpu_devices);
> +
> +int __weak arch_register_cpu(int cpu)
> +{
> +	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
> +}
>   #endif
>   
>   static void __init cpu_dev_register_generic(void)
>   {
> -#ifdef CONFIG_GENERIC_CPU_DEVICES
>   	int i;
>   
> +	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
> +		return;
> +
>   	for_each_present_cpu(i) {
> -		if (register_cpu(&per_cpu(cpu_devices, i), i))
> +		if (arch_register_cpu(i))
>   			panic("Failed to register CPU device");
>   	}
> -#endif
>   }
>   
>   #ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index fc8094419084..1e982d63eae8 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -88,6 +88,10 @@ extern ssize_t arch_cpu_probe(const char *, size_t);
>   extern ssize_t arch_cpu_release(const char *, size_t);
>   #endif
>   
> +#ifdef CONFIG_GENERIC_CPU_DEVICES
> +DECLARE_PER_CPU(struct cpu, cpu_devices);
> +#endif
> +
>   /*
>    * These states are not related to the core CPU hotplug mechanism. They are
>    * used by various (sub)architectures to track internal state

-- 
Shaoqin


