Return-Path: <linux-csky+bounces-99-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D820B7E9625
	for <lists+linux-csky@lfdr.de>; Mon, 13 Nov 2023 05:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D7911F20F70
	for <lists+linux-csky@lfdr.de>; Mon, 13 Nov 2023 04:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4099E575;
	Mon, 13 Nov 2023 04:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VG+F68yK"
X-Original-To: linux-csky@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990A611709
	for <linux-csky@vger.kernel.org>; Mon, 13 Nov 2023 04:23:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7051991
	for <linux-csky@vger.kernel.org>; Sun, 12 Nov 2023 20:23:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699849432;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MDzN//cB8A0tsFhYQj2uRkfSHm3F/Ien9J3CTjaN2xA=;
	b=VG+F68yKrS/JhmJCO4dCDhBlogYFX/SOJfnBjxPhXGnhTqMfoMP9spIGSoRDO1JVZID8IM
	lS/Lj2Uxnst0xlrihEDtx1sIFUY7sm3CotstcKXTwiLLSi5aHDhq1eZGmP2LrWce7CyoRq
	gVaHwPV77s+IZkhJc2vvHcSKM98LPYs=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-WNJtJDYPM3qQlz9cxH5stQ-1; Sun, 12 Nov 2023 23:23:50 -0500
X-MC-Unique: WNJtJDYPM3qQlz9cxH5stQ-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5be3799791fso2608087a12.3
        for <linux-csky@vger.kernel.org>; Sun, 12 Nov 2023 20:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699849429; x=1700454229;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDzN//cB8A0tsFhYQj2uRkfSHm3F/Ien9J3CTjaN2xA=;
        b=SEzGsVMVyYj7dabZ4TSnwj6xuT7rdRGyNDGBQ1+J/XrsJLxxQkX/e3hQY/rWWgwdXj
         4/JdXQaCglBZCtvGZAjToklCc+A7aqRwwETdwYywLl6dwrDM2TsxGJQcBHpstiP97nvR
         pOrXk130MEq/uZZCKBQ+/Pf0Vtn32UUl/xsrsDhLFtq4kj9lDKSe2ZCYEKeCFsrL93Xo
         4BOJtWt/0NcLd/IyzUTCr7yj6l2agwa0L0HeuHlUS4DflINZBU7hLvbTSmKEsyBhpWr9
         RJV05LwHeis/UP7OejE0TcebkvxrmNpdphkEkm8izhLgSq7Rb2rliNIyTUboJ5zzrJj8
         Xkzg==
X-Gm-Message-State: AOJu0Yy7ZL7QgCpClNZ08IBiUunc3UCnjoa2yVOQZ0UuQ6TPzUp0BvAu
	6VmKn1OwbnfreIcKzLgUueuTluPIGMjiP2o2+qQIUUBm6XbEMEpdo5mYF2iJHGQw5OvevCA+gEr
	gl9TIiUO1DMeRrRPJ7Sf0xpU/jf5CVA==
X-Received: by 2002:a05:6a20:7292:b0:177:690a:7978 with SMTP id o18-20020a056a20729200b00177690a7978mr7173307pzk.33.1699849429677;
        Sun, 12 Nov 2023 20:23:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFskzK66afv7E0dvEEzwtWe0LILd1YSCQ10I8JNRY4PU48BJW4/+U8P1g/k7SE3CEH/9dkMnA==
X-Received: by 2002:a05:6a20:7292:b0:177:690a:7978 with SMTP id o18-20020a056a20729200b00177690a7978mr7173300pzk.33.1699849429425;
        Sun, 12 Nov 2023 20:23:49 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id fm6-20020a056a002f8600b006c4db182074sm3111661pfb.196.2023.11.12.20.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:23:48 -0800 (PST)
Message-ID: <9dc3a438-930f-4503-af91-12771bdb7738@redhat.com>
Date: Mon, 13 Nov 2023 14:23:41 +1000
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 21/22] riscv: Switch over to GENERIC_CPU_DEVICES
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
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JMQ-00CTyb-Ee@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JMQ-00CTyb-Ee@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 20:31, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
> overridden by the arch code, switch over to this to allow common code
> to choose when the register_cpu() call is made.
> 
> This allows topology_init() to be removed.
> 
> This is an intermediate step to the logic being moved to drivers/acpi,
> where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.
> 
> This patch also has the effect of moving the registration of CPUs from
> subsys to driver core initialisation, prior to any initcalls running.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
>   * Add note about initialisation order change.
> ---
>   arch/riscv/Kconfig        |  1 +
>   arch/riscv/kernel/setup.c | 19 ++++---------------
>   2 files changed, 5 insertions(+), 15 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


