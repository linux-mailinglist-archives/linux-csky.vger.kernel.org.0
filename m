Return-Path: <linux-csky+bounces-89-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 287E17E93D1
	for <lists+linux-csky@lfdr.de>; Mon, 13 Nov 2023 01:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D74B7280AAC
	for <lists+linux-csky@lfdr.de>; Mon, 13 Nov 2023 00:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967DF4426;
	Mon, 13 Nov 2023 00:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2nQ34+L"
X-Original-To: linux-csky@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9F3D75
	for <linux-csky@vger.kernel.org>; Mon, 13 Nov 2023 00:58:59 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478FC1BE5
	for <linux-csky@vger.kernel.org>; Sun, 12 Nov 2023 16:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699837137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDT/Yw6MepTUY5berRyzp+iGTh5/71yTqnFQ/kYgufg=;
	b=F2nQ34+LtuVNAzyHYMhY7XKF8bKgDNlg2lTV3kPzOyfNVqMTnoyZycOp3/kc191s/cPkOT
	X9y36lz/hegBsN5yN0+KnUJa1Wh3z27wNu1V7y1dhKJHdpVpaZ/Uzz59iae17ivmd+/piC
	IaPEuDzPSDJOa3dvZmFTGJa+XSk1Ruo=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-RVioEs9HOP6-Z1HJ-3QJ4Q-1; Sun, 12 Nov 2023 19:58:56 -0500
X-MC-Unique: RVioEs9HOP6-Z1HJ-3QJ4Q-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc4cab731dso37756425ad.1
        for <linux-csky@vger.kernel.org>; Sun, 12 Nov 2023 16:58:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699837135; x=1700441935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cDT/Yw6MepTUY5berRyzp+iGTh5/71yTqnFQ/kYgufg=;
        b=XluXz9p/+TYE/wcYDSic5MtHTVzftvBwfP6BD9sX14LuJ8MJMvAVEiQttp5CqeSsny
         UHFpjiwZJX+dSaIXfa3ot2dFYahR7iZaXDtWPMt7yWg6wLycCfYvmZ6okjreKYLSoElR
         qttTRF/wLGqdsP+tzN0EKtk0+z8CzCa6N65P64Vo2qsWM8Y+DQFeNNfkCAKMYXVQ525A
         C4QcoldV9FJnPhFmoWw4bfj+44R9pG3ufV8mfsg4KD0to3sHmNkfC/HQu28s2furwxFQ
         X54OihIavYvtbGh+BShiQr1Afvahkit0hZOryjA/WLx/82M3Ml25QLuLzGpm0GHUQO/+
         4y8Q==
X-Gm-Message-State: AOJu0YwrpyFPEOgqK2DU6/DEUEVeI+pw3yPHLY0EJkT2ckPT0mozRtWZ
	IOG5vcKHODW9AYtC00MvE2ibbXvcA6Pst2tiez5q5lXzMwUr/BhnHWJi3P+yK+LpM+G93yk5AZ4
	MzXXhiDCIDxoKsLnQjqZRLg==
X-Received: by 2002:a17:903:18a:b0:1c5:d063:b70e with SMTP id z10-20020a170903018a00b001c5d063b70emr3527467plg.53.1699837134996;
        Sun, 12 Nov 2023 16:58:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEYIxs5W0nH5PRlEPeC7HszJcExOhwxIk5eQviHGK0uTrxM/8D+SW3tGS+WkqqASqjIUf7rPA==
X-Received: by 2002:a17:903:18a:b0:1c5:d063:b70e with SMTP id z10-20020a170903018a00b001c5d063b70emr3527451plg.53.1699837134747;
        Sun, 12 Nov 2023 16:58:54 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c24d00b001c5fc291ef9sm3053276plg.209.2023.11.12.16.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 16:58:54 -0800 (PST)
Message-ID: <095c2d24-735b-4ce2-ba2e-9ec2164f2237@redhat.com>
Date: Mon, 13 Nov 2023 10:58:46 +1000
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/22] drivers: base: Move cpu_dev_init() after
 node_dev_init()
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
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLV-00CTxS-QB@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JLV-00CTxS-QB@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/7/23 20:30, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> NUMA systems require the node descriptions to be ready before CPUs are
> registered. This is so that the node symlinks can be created in sysfs.
> 
> Currently no NUMA platform uses GENERIC_CPU_DEVICES, meaning that CPUs
> are registered by arch code, instead of cpu_dev_init().
> 
> Move cpu_dev_init() after node_dev_init() so that NUMA architectures
> can use GENERIC_CPU_DEVICES.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Note: Jonathan's comment still needs addressing - see
>    https://lore.kernel.org/r/20230914121612.00006ac7@Huawei.com
> ---
>   drivers/base/init.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

With Jonathan's comments addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>


