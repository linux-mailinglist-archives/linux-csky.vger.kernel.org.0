Return-Path: <linux-csky+bounces-182-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE180023A
	for <lists+linux-csky@lfdr.de>; Fri,  1 Dec 2023 04:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365BAB211D1
	for <lists+linux-csky@lfdr.de>; Fri,  1 Dec 2023 03:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4509E468F;
	Fri,  1 Dec 2023 03:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GwcEOei/"
X-Original-To: linux-csky@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0518171C
	for <linux-csky@vger.kernel.org>; Thu, 30 Nov 2023 19:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701402446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Q5xYcnLhhl5wab+9SUNf2YG1+1AQAaLiKPAT2IR83M=;
	b=GwcEOei/lLwIZ/h+Dr/DDXabPaXge2yF8NXZJtnkWdFkRFCs/BEo3rWlfGt5EsnmOuIw7I
	pE3UVLoxAXp8MM2oChDKxulXc0D80IbODC+VH4HyLfE+23VH2gy9qiyZfHlZPje6L0hc9t
	AUb3M1dfHjkq1enR5+TKmGsmpYNKBZc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-4A9941mfOku2uN7pTGunKw-1; Thu, 30 Nov 2023 22:47:23 -0500
X-MC-Unique: 4A9941mfOku2uN7pTGunKw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5c6072bc218so122263a12.1
        for <linux-csky@vger.kernel.org>; Thu, 30 Nov 2023 19:47:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701402442; x=1702007242;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Q5xYcnLhhl5wab+9SUNf2YG1+1AQAaLiKPAT2IR83M=;
        b=nOuIktq0gr3Zde2tTT5Fcg66m+85/dfjonyhfvq34YJuONUijdQv51ecC7C+Dva5sq
         UUZVo6I0rcYOCbyUATrb3B0k+Rs/dfvQqZF8CXy2NeLpxfWJDR7p5MGMQV0VRx4ZB4t4
         lIRB+16fSXTDSBZ/C5CBNd5VGXepWf/dLGGv9pUHRdae056YodVT9et0edUG19dreBfX
         lQFeJrPW6t4OoT3Ov8xi4tUzNZMutn2XyQPbN3zJtHehd4QzvbGU7gmDTV4+aHcEPvLK
         zQTfNbsP1BdhNF46WQ/Vt69znyQnMcqf9rLlxs384re9mpSBRJSIxwXbjOQwxO1tKxir
         xcpw==
X-Gm-Message-State: AOJu0Yx9m4cBWsOqNNAJv/a5ZAl6pJjQsTftIfPmgRrPeLPRy4TwKS2S
	a5l+Yll4J8N7/+ZEXbWnSD9D7pqjNjishqvE/CNZztzCzzIDiyqiS041Gl746BWGlBhH0xnV/NY
	gL536v7j+LCkjNyvnmfNiXA==
X-Received: by 2002:a17:902:d2cb:b0:1cf:de3e:e4c9 with SMTP id n11-20020a170902d2cb00b001cfde3ee4c9mr23769910plc.29.1701402442620;
        Thu, 30 Nov 2023 19:47:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFc/FRI9UHJwfBJxYeFRAhPaME7NIPXUpzMmMZaQsrSUZaHXjj5IgT1PfH3h0ARxutVZDmxg==
X-Received: by 2002:a17:902:d2cb:b0:1cf:de3e:e4c9 with SMTP id n11-20020a170902d2cb00b001cfde3ee4c9mr23769867plc.29.1701402442296;
        Thu, 30 Nov 2023 19:47:22 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902e74500b001cfc1a593f7sm2185691plf.217.2023.11.30.19.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 19:47:21 -0800 (PST)
Message-ID: <8c3ca6c7-fa5f-4f45-b36d-1c7d9d94c918@redhat.com>
Date: Fri, 1 Dec 2023 14:47:11 +1100
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/21] drivers: base: Implement weak arch_unregister_cpu()
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
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
 <E1r5R3H-00CszC-2n@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r5R3H-00CszC-2n@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/22/23 00:44, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Add arch_unregister_cpu() to allow the ACPI machinery to call
> unregister_cpu(). This is enough for arm64, riscv and loongarch, but
> needs to be overridden by x86 and ia64 who need to do more work.
> 
> CC: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> An open question remains from the RFC v2 posting: should we provide a
> __weak stub for !HOTPLUG_CPU as well, since in later patches ACPI may
> reference this if the compiler doesn't optimise as we expect?
> 
> Changes since v1:
>   * Added CONFIG_HOTPLUG_CPU ifdeffery around unregister_cpu
> Changes since RFC v2:
>   * Move earlier in the series
> ---
>   drivers/base/cpu.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


