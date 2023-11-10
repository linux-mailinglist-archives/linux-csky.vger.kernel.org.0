Return-Path: <linux-csky+bounces-72-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E877E7811
	for <lists+linux-csky@lfdr.de>; Fri, 10 Nov 2023 04:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E813BB20DBF
	for <lists+linux-csky@lfdr.de>; Fri, 10 Nov 2023 03:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E43F1841;
	Fri, 10 Nov 2023 03:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFdj44xq"
X-Original-To: linux-csky@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708115C5
	for <linux-csky@vger.kernel.org>; Fri, 10 Nov 2023 03:35:52 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783BD468C
	for <linux-csky@vger.kernel.org>; Thu,  9 Nov 2023 19:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699587350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x8WQrDz3BrUoKfY/uV/CbjAH9j1WTdOdEvBMB5Ml9tk=;
	b=OFdj44xqUo5zv+73SqGjbHOMu1b1K3H8FyC6puIbWDHsm4CvChgrdqO7JOijDpUoekpjU8
	EsxADa76GP+2mkITBbLeSe2JWj31fG1F7HiQWtukjcCR1ZEyDZnCOERsuUBZpnog8UzT+b
	nxLPEPs7z0lcx3qtfifJyPpi7rakuPE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-sLRntAblPHqkUShBYGfhlQ-1; Thu, 09 Nov 2023 22:35:48 -0500
X-MC-Unique: sLRntAblPHqkUShBYGfhlQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6bc52d2c204so44682a34.0
        for <linux-csky@vger.kernel.org>; Thu, 09 Nov 2023 19:35:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699587348; x=1700192148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8WQrDz3BrUoKfY/uV/CbjAH9j1WTdOdEvBMB5Ml9tk=;
        b=lPITz8X37p4jby+B9zv4EofNcycwxfSDYTRFP9Ck6r5KZ8NDsYzw+bmrtXK04g9PZ0
         r0X3hcZ1pcuB3LAVzEHuq9p+jZ42Q5icYqg7SH1BjQ9ox5UPYpgtgaGuIS5yncrt/zrQ
         Z4oX6/WS5ssao+++tYr8EribMqd/68wZnG11rEgz/zeUDvsJhYGjDz0DeaGH4WPWcfpw
         6e7KU5Lnrg3MMVB6xky7EJldBPoQvCk8zX6XiE6WfAc5B8HBFGU+LI5FQ5QG9P7Hf9iI
         hpanw3L6dm3JG7Qk9XrcI7voUPuAsWONrhGuEfPI9dsNNyu6f1vYI83wMe6hJQnYawpl
         4ZdA==
X-Gm-Message-State: AOJu0YwuVOqL5Amja0O3h6OtCzlDC1zu6japhBdyJiKpA+zAmpxVWSLC
	6gpCubAyEh8cks/yk0OInX4hx7PpwWUuzFfBesxCU+NayPfSSSSOwpK3Yo01oAS2oWij4rfmYFA
	ku55/ryrzqcWIskL8TNh43Q==
X-Received: by 2002:a05:6870:468d:b0:1d6:4c63:7ba9 with SMTP id a13-20020a056870468d00b001d64c637ba9mr8173645oap.3.1699587348151;
        Thu, 09 Nov 2023 19:35:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG0g1U5gqarx8cH0olNuMl9/UtKi0J1uyvc150ksgK2KoqY7BLV3KVCaBNiaCGerDe5ChRrSA==
X-Received: by 2002:a05:6870:468d:b0:1d6:4c63:7ba9 with SMTP id a13-20020a056870468d00b001d64c637ba9mr8173626oap.3.1699587347881;
        Thu, 09 Nov 2023 19:35:47 -0800 (PST)
Received: from [10.66.61.39] ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id gu6-20020a056a004e4600b0068fe7e07190sm11450826pfb.3.2023.11.09.19.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Nov 2023 19:35:47 -0800 (PST)
Message-ID: <534c2679-6a2b-455f-d60c-2f80207ef118@redhat.com>
Date: Fri, 10 Nov 2023 11:35:40 +0800
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH RFC 12/22] drivers: base: Print a warning instead of
 panic() when register_cpu() fails
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
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLg-00CTxd-31@rmk-PC.armlinux.org.uk>
From: Shaoqin Huang <shahuang@redhat.com>
In-Reply-To: <E1r0JLg-00CTxd-31@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/7/23 18:30, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> loongarch, mips, parisc, riscv and sh all print a warning if
> register_cpu() returns an error. Architectures that use
> GENERIC_CPU_DEVICES call panic() instead.
> 
> Errors in this path indicate something is wrong with the firmware
> description of the platform, but the kernel is able to keep running.
> 
> Downgrade this to a warning to make it easier to debug this issue.
> 
> This will allow architectures that switching over to GENERIC_CPU_DEVICES
> to drop their warning, but keep the existing behaviour.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> ---
>   drivers/base/cpu.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
> index 221ffbeb1c9b..82b6a76125f5 100644
> --- a/drivers/base/cpu.c
> +++ b/drivers/base/cpu.c
> @@ -551,14 +551,15 @@ void __weak arch_unregister_cpu(int num)
>   
>   static void __init cpu_dev_register_generic(void)
>   {
> -	int i;
> +	int i, ret;
>   
>   	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
>   		return;
>   
>   	for_each_present_cpu(i) {
> -		if (arch_register_cpu(i))
> -			panic("Failed to register CPU device");
> +		ret = arch_register_cpu(i);
> +		if (ret)
> +			pr_warn("register_cpu %d failed (%d)\n", i, ret);
>   	}
>   }
>   

-- 
Shaoqin


