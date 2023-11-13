Return-Path: <linux-csky+bounces-98-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F977E961C
	for <lists+linux-csky@lfdr.de>; Mon, 13 Nov 2023 05:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F79B20ABB
	for <lists+linux-csky@lfdr.de>; Mon, 13 Nov 2023 04:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28010111BC;
	Mon, 13 Nov 2023 04:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeeHkZhj"
X-Original-To: linux-csky@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ACDF9E0
	for <linux-csky@vger.kernel.org>; Mon, 13 Nov 2023 04:22:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEAB1735
	for <linux-csky@vger.kernel.org>; Sun, 12 Nov 2023 20:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699849332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XF3NQ57kyjxk1hcvqu+Pq8JhkrYu8jIWva1UTHj4B8I=;
	b=LeeHkZhjOw9rGBkKeffpqGS938JOnOYzsnYlS/4gFJL8N9/YsUrDmWTZsTrVjCa5tSCazE
	O4xw6fWgbpeP/LB/wwIl3PQJO8ubE95q+2ZPYBemBctfen3v1fWLuWbIWScnEJwTbYZXnW
	0RQHY6emzjj0cQi2JfOo5uBUeacESxI=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-Avcf8lulPoqVG9r0PfjhOA-1; Sun, 12 Nov 2023 23:22:11 -0500
X-MC-Unique: Avcf8lulPoqVG9r0PfjhOA-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b565a98473so4617500b6e.1
        for <linux-csky@vger.kernel.org>; Sun, 12 Nov 2023 20:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699849330; x=1700454130;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XF3NQ57kyjxk1hcvqu+Pq8JhkrYu8jIWva1UTHj4B8I=;
        b=NrfkxXa+IDY9NsH+bad5lt8tDMt5gT4U/lK7OTqnzAsdvuCArJwEp0CmIcMynuuxnd
         mS6O4uErxLZY80NWW+kLqFjRrDgMMBNcWvYNnjYW+GeDTBGxj4IEwYg6nzuFFzAIzlft
         LBGty+21njotN/mJnMaCMxsvpvlGhMtfcmdVQH1ARrYE8na+yq6uCA6UfXbGiLbZJNcP
         97jUFgMFfLWyNYvRBvNto8PBsBqST7n8DT+AOraOdq1MhdxKj6e3NupSm3DUHLneVfY7
         RePojJgGf06MO1kDd1/tsKr3AZ/5qm9h8GSIJBH8YG+iJZIq1CKDGEo92HPcwp/bAg97
         CWRA==
X-Gm-Message-State: AOJu0YzscC61JdxoWx/yL+/7oniiBvxGyy8Fo9gpI7+BcL9SncokwK1n
	MeLvPbiWWLOyizzGIlexHQp2i6sGRe0iaYMLKgfWh5akthhuBQ/ujOX0ps5f8dieRrOETX5Y/rh
	aV2wRz9Ltz1YBZyiLYwykQQ==
X-Received: by 2002:a05:6808:3c8a:b0:3af:e556:4602 with SMTP id gs10-20020a0568083c8a00b003afe5564602mr8733104oib.11.1699849330579;
        Sun, 12 Nov 2023 20:22:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXY595uxruxGZ6Ui5zU3loMnBcIT42OgsioZr0yKGr5XKhKsixYTlwKjcTTf2f20K0od7lOA==
X-Received: by 2002:a05:6808:3c8a:b0:3af:e556:4602 with SMTP id gs10-20020a0568083c8a00b003afe5564602mr8733096oib.11.1699849330328;
        Sun, 12 Nov 2023 20:22:10 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id fm6-20020a056a002f8600b006c4db182074sm3111661pfb.196.2023.11.12.20.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:22:09 -0800 (PST)
Message-ID: <191a356f-a9cd-4510-9676-dc28026088be@redhat.com>
Date: Mon, 13 Nov 2023 14:22:03 +1000
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 20/22] LoongArch: convert to use
 arch_cpu_is_hotpluggable()
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
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JML-00CTyV-9a@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JML-00CTyV-9a@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 20:31, Russell King (Oracle) wrote:
> Convert loongarch to use the arch_cpu_is_hotpluggable() helper rather
> than arch_register_cpu(). Also remove the export as nothing should be
> using arch_register_cpu() outside of the core kernel/acpi code.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   arch/loongarch/kernel/topology.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


