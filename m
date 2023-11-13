Return-Path: <linux-csky+bounces-95-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 891D57E9608
	for <lists+linux-csky@lfdr.de>; Mon, 13 Nov 2023 05:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2980AB20ADA
	for <lists+linux-csky@lfdr.de>; Mon, 13 Nov 2023 04:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23CEC8C3;
	Mon, 13 Nov 2023 04:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUvvdqty"
X-Original-To: linux-csky@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD61C8DB
	for <linux-csky@vger.kernel.org>; Mon, 13 Nov 2023 04:16:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806A173E
	for <linux-csky@vger.kernel.org>; Sun, 12 Nov 2023 20:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699849002;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7aB5COy4QAe+eFccHV1YqyKzO84zBoVzPy0R2GMj01o=;
	b=hUvvdqtyCi5jfCJAKsSc3amNcmqs75DzyhnEXm2yR4dCpZbhn2M+esF3MxLinCeDvm2Phx
	NgVLtePNho+Yaj3S842B+tbcaqKxflS85S+am333fUu0TFTGLPMVNpkut5hfaHPsYQeHrb
	3QMH8fcLL7iTc0t15ClwyWDCW2Vykxw=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-3Y4IdiBXMACBtRO-PSwQag-1; Sun, 12 Nov 2023 23:16:40 -0500
X-MC-Unique: 3Y4IdiBXMACBtRO-PSwQag-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-28043db47ebso3780346a91.1
        for <linux-csky@vger.kernel.org>; Sun, 12 Nov 2023 20:16:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848999; x=1700453799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aB5COy4QAe+eFccHV1YqyKzO84zBoVzPy0R2GMj01o=;
        b=XDpEgSKLpGHLW6fANSjC+vvl2XL06cOXnvYJAe3hO8qwTjatvoHuQ+NI/x6tT5txR4
         cAImzcpH1QkZ0MVAXyeGcb1xVVrB4PQPFrZOSu/xlJ85HVuXMZke6PraY92FUTjGX4bE
         eZaR3ZhirqgTFnczGhomNGJJTYuMHIT5qbR7DFCOTgWosd8JYjD15gh4+ecDMt242o1p
         euftswfhyWtCKVzVsaIz8u5/EWHNcruUQxO0YDA5JOaf92BjyrohvByRqDvtRGSAf2lu
         /cDfHTsQYOvxSe5hJSt8iZxdk/DNVRXOvfn1vPqcF0Ig1x/ChBjq3TTX9i0nw1WdCowY
         aVEQ==
X-Gm-Message-State: AOJu0YyIUze1NqXmAy2S7O/kVxAte3NGdVKWlj90gwssN19LQ9V5AtQF
	7iQIg72NJ8oEOUiVCff8AwgNZfdHXHkZsStcJsCsUJsb4Oo5NB/bbzgaaHQxPKluXx3HsZLP4fj
	BclpBxEjST4BatqrvtZOEAg==
X-Received: by 2002:a17:90b:4b90:b0:27f:fc2f:4831 with SMTP id lr16-20020a17090b4b9000b0027ffc2f4831mr3808825pjb.13.1699848999530;
        Sun, 12 Nov 2023 20:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExSJF7Sr4fxZ4SaXBfj45m19uu6J8O0+tvnJdz59Xz+72h6hZwy5AtBFfiTF4Ru6jPNTRc+w==
X-Received: by 2002:a17:90b:4b90:b0:27f:fc2f:4831 with SMTP id lr16-20020a17090b4b9000b0027ffc2f4831mr3808799pjb.13.1699848999237;
        Sun, 12 Nov 2023 20:16:39 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id mg5-20020a17090b370500b00282ec3582f1sm2976159pjb.34.2023.11.12.20.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:16:38 -0800 (PST)
Message-ID: <fa717944-2f92-48f6-ad70-1c58ffe61b86@redhat.com>
Date: Mon, 13 Nov 2023 14:16:29 +1000
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 16/22] x86/topology: use weak version of
 arch_unregister_cpu()
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
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JM0-00CTy7-NL@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JM0-00CTy7-NL@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 20:30, Russell King (Oracle) wrote:
> Since the x86 version of arch_unregister_cpu() is the same as the weak
> version, drop the x86 specific version.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v3:
>   * Adapt to removal of EXPORT_SYMBOL()s
> ---
>   arch/x86/kernel/topology.c | 5 -----
>   1 file changed, 5 deletions(-)
> 

PATCH[16/22] can be folded to PATCH[15/22] since arch_unregister_cpu() was just
added in PATCH[15/22]. Anyway, the changes make sense to me.

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
> index c2ed3145a93b..211863cb5b81 100644
> --- a/arch/x86/kernel/topology.c
> +++ b/arch/x86/kernel/topology.c
> @@ -43,9 +43,4 @@ int arch_register_cpu(int cpu)
>   	c->hotpluggable = cpu > 0;
>   	return register_cpu(c, cpu);
>   }
> -
> -void arch_unregister_cpu(int num)
> -{
> -	unregister_cpu(&per_cpu(cpu_devices, num));
> -}
>   #endif /* CONFIG_HOTPLUG_CPU */


