Return-Path: <linux-csky+bounces-100-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E6D7E9629
	for <lists+linux-csky@lfdr.de>; Mon, 13 Nov 2023 05:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0C56B20A8D
	for <lists+linux-csky@lfdr.de>; Mon, 13 Nov 2023 04:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C6611700;
	Mon, 13 Nov 2023 04:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXh1g17s"
X-Original-To: linux-csky@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A90EF9E2
	for <linux-csky@vger.kernel.org>; Mon, 13 Nov 2023 04:24:39 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BB810FA
	for <linux-csky@vger.kernel.org>; Sun, 12 Nov 2023 20:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699849477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XpkXMncYpwBWWz5YM4lExGVyIZbJdd8k4LtapRIRSU=;
	b=RXh1g17s0v9QLbmObujbvZFUHUA3NxBhNtKnE8bCnEdC9434/jC/s8AEuoGHctgN/O3CaG
	GxrIEo+PuC3w3v26mfpDQdngI5hVFUZ8wE6yE3Jf3k4lvEwFFcuPDPLC6poArw4LlKApcK
	PeRL/88Xg896MctltwL7zoZXcjVvAcc=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-6cj-fZVxMzSZIoMVi69u4A-1; Sun, 12 Nov 2023 23:24:36 -0500
X-MC-Unique: 6cj-fZVxMzSZIoMVi69u4A-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b3e601436cso4676690b6e.1
        for <linux-csky@vger.kernel.org>; Sun, 12 Nov 2023 20:24:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699849475; x=1700454275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XpkXMncYpwBWWz5YM4lExGVyIZbJdd8k4LtapRIRSU=;
        b=igHGBqIXyiZs5Lv5Spfn62C/2K/H/uuasf3u4aKz3L/MeHsYK+8MsvJ06B251SyoPF
         JoHjQVYaNJ+/NiEQYjIG5UgyX9FZXd0RD+WTFON8QkyF8ewWhpPRTpgFD+VbNzhlza6m
         W4M0HegiHpZ8T6USdetoU/EIV3sb0ML2b0Z2AcGthGaEPYXUanktwRncHLYEotP7Oj8O
         1/p8P+TDXWnAIDXBB9ppeGbUNh5BHl6XUr5qbLWnH57O3PrkgVqB5/Dp17CyX7vOCA3h
         M9pyhQtdtYJNppmaJBrUzGyKfx2tTyeZ9MWGTXmOGhlYrcGNIGIw73cqt1CbaTX4vsMz
         kw+g==
X-Gm-Message-State: AOJu0YxDABnGHDKCcAfp6XWKRBwGyuOlrvCYyRLDS4V7GMq2jLslQS9n
	TEnrj/ssP/h3LtrK9pht1EvfpMhF6VEyrLxPtmF8ZCKfRkXaFgyMngDPc0/nNDf5JvaRfWTEeMQ
	TyG8puyr77EtGuHsnfFMq+A==
X-Received: by 2002:a05:6808:1907:b0:3b2:a9bd:c38f with SMTP id bf7-20020a056808190700b003b2a9bdc38fmr8909972oib.37.1699849475414;
        Sun, 12 Nov 2023 20:24:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGpLquY73YkMUU9Mlaw3xcZEgmE+1wMz9SoOzUS3eERBYDajACgA3kg4BM9OvwoIC+iQZINQ==
X-Received: by 2002:a05:6808:1907:b0:3b2:a9bd:c38f with SMTP id bf7-20020a056808190700b003b2a9bdc38fmr8909944oib.37.1699849475200;
        Sun, 12 Nov 2023 20:24:35 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id fm6-20020a056a002f8600b006c4db182074sm3111661pfb.196.2023.11.12.20.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:24:34 -0800 (PST)
Message-ID: <d07a9e11-9752-4155-bbaf-b759ec4f99ac@redhat.com>
Date: Mon, 13 Nov 2023 14:24:27 +1000
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 22/22] riscv: convert to use
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
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JMV-00CTyh-It@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JMV-00CTyh-It@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 20:31, Russell King (Oracle) wrote:
> Convert riscv to use the arch_cpu_is_hotpluggable() helper rather than
> arch_register_cpu().
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   arch/riscv/kernel/setup.c | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


