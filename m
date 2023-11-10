Return-Path: <linux-csky+bounces-71-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0CF7E77F8
	for <lists+linux-csky@lfdr.de>; Fri, 10 Nov 2023 04:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78F371C20C96
	for <lists+linux-csky@lfdr.de>; Fri, 10 Nov 2023 03:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8091C1847;
	Fri, 10 Nov 2023 03:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WIURUzyA"
X-Original-To: linux-csky@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394F515B3
	for <linux-csky@vger.kernel.org>; Fri, 10 Nov 2023 03:27:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B984688
	for <linux-csky@vger.kernel.org>; Thu,  9 Nov 2023 19:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699586832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AaVo9IVfWLz/BqLc17ue4Q1CD1g0z57ZzeqlpNNIaz0=;
	b=WIURUzyA6M9RRENmBNZndsp8IWXr+RcE2wufYTNSRU74XAUgR4LWLE5BugBlLOZyyj9EqP
	oq9p88giGQ0wVAFII2J6rBSV2iK9HIEAUnCD0Ewz1KDMqtPhSPHmDDpNg+pgHXbX96PUqK
	0Wknqi834g0WkWp562IjoE8Uc1YfuP4=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-lBBZRDAnOjeX2Z8ZWdcGag-1; Thu, 09 Nov 2023 22:27:10 -0500
X-MC-Unique: lBBZRDAnOjeX2Z8ZWdcGag-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5b99eba29ccso3915a12.0
        for <linux-csky@vger.kernel.org>; Thu, 09 Nov 2023 19:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699586829; x=1700191629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaVo9IVfWLz/BqLc17ue4Q1CD1g0z57ZzeqlpNNIaz0=;
        b=Fd/9Goe/6BfdVqRkqGellIcYIEJQRKYGdTTUKpf769hfTmb+yBvJlr3C5eEqgEIV9O
         a8DNGRyO/V/XDnMVmzee3wcM2y/pcZxDYtvaE9xodWDimpWcINmHXMAMO6qmap+LMDny
         lz/AkgzH3z9NMHO0T3BpJYlwyFhJzOC6x+T/2OQGQMkyTzvvviQsE6ZXwP2TLt1/WTLR
         hg6Gnm+Qo2cHxjYG4Qf04lmISh4s9ikd56ECNNfAT1KXRE5L9A4hlHt7n+tFlHz7oLyd
         vdQRVoQy6gFBrFJUlf8BtVBR+aqnpp0lcTDNde7BgetBYoJtIiYmiU+P/cPN+CxV0xRU
         WXNw==
X-Gm-Message-State: AOJu0YxSYbKQS8emtBy/HhFRQrUCmUvSl44Zrrsre+MTfcOavFq2JLnP
	nbP3b9hAWmeHRiRRqVNgZ/gvS1KPeRGzlaGyZKsgk25rOC76Hi+2u56rT1V+0KWy+HdSO7Y9xXq
	55xemArH0nGHU+KIFdU2NCg==
X-Received: by 2002:a05:6a20:7d9b:b0:183:e7bb:591b with SMTP id v27-20020a056a207d9b00b00183e7bb591bmr7360666pzj.3.1699586829277;
        Thu, 09 Nov 2023 19:27:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG+bD56KpX+FmB2BSMLL1SeOrK5m+loI6ihIPtQEVukH9L6DA0riRGJoTQywaV/bE7t1yJhWw==
X-Received: by 2002:a05:6a20:7d9b:b0:183:e7bb:591b with SMTP id v27-20020a056a207d9b00b00183e7bb591bmr7360636pzj.3.1699586828966;
        Thu, 09 Nov 2023 19:27:08 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001b8a00d4f7asm4274245plb.9.2023.11.09.19.27.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 19:27:08 -0800 (PST)
Message-ID: <b594e092-0002-61d8-fdb9-74fad2285245@redhat.com>
Date: Fri, 10 Nov 2023 11:27:02 +0800
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 09/22] drivers: base: add arch_cpu_is_hotpluggable()
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
 <E1r0JLQ-00CTxK-Ln@rmk-PC.armlinux.org.uk>
Content-Language: en-US
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <E1r0JLQ-00CTxK-Ln@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/7/23 18:30, Russell King (Oracle) wrote:
> The differences between architecture specific implementations of
> arch_register_cpu() are down to whether the CPU is hotpluggable or not.
> Rather than overriding the weak version of arch_register_cpu(), provide
> a function that can be used to provide this detail instead.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   drivers/base/cpu.c  | 11 ++++++++++-
>   include/linux/cpu.h |  1 +
>   2 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 58bb86091b34..221ffbeb1c9b 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -527,9 +527,18 @@ EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
>   #ifdef CONFIG_GENERIC_CPU_DEVICES
>   DEFINE_PER_CPU(struct cpu, cpu_devices);
>   
> +bool __weak arch_cpu_is_hotpluggable(int cpu)
> +{
> +	return false;
> +}
> +
>   int __weak arch_register_cpu(int cpu)
>   {
> -	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
> +	struct cpu *c = &per_cpu(cpu_devices, cpu);
> +
> +	c->hotpluggable = arch_cpu_is_hotpluggable(cpu);
> +
> +	return register_cpu(c, cpu);
>   }
>   
>   #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index 1e982d63eae8..dcb89c987164 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -80,6 +80,7 @@ extern __printf(4, 5)
>   struct device *cpu_device_create(struct device *parent, void *drvdata,
>   				 const struct attribute_group **groups,
>   				 const char *fmt, ...);
> +extern bool arch_cpu_is_hotpluggable(int cpu);
>   extern int arch_register_cpu(int cpu);
>   extern void arch_unregister_cpu(int cpu);
>   #ifdef CONFIG_HOTPLUG_CPU

-- 
Shaoqin


