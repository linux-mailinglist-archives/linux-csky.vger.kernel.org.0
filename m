Return-Path: <linux-csky+bounces-90-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B747E95CF
	for <lists+linux-csky@lfdr.de>; Mon, 13 Nov 2023 05:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DEAA1C2099B
	for <lists+linux-csky@lfdr.de>; Mon, 13 Nov 2023 04:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4AD58F4D;
	Mon, 13 Nov 2023 04:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DwKRNRZa"
X-Original-To: linux-csky@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EFBC135
	for <linux-csky@vger.kernel.org>; Mon, 13 Nov 2023 04:04:08 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F9A172B
	for <linux-csky@vger.kernel.org>; Sun, 12 Nov 2023 20:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699848246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MtNFooCff3vqCOUxCEz1jHRl+QbfPpBEZibpqDAaoCg=;
	b=DwKRNRZa+xVhO5aifoyoc0a6t/eISpLe5wUxbtFP4LcrQqkzayJZKHmdeTdL06ylZVhTgB
	K57bezKSZiCH92HkQd0Gr7QunNEs2Km3Mm1hsoDZtCQm1iuCezkPgP5NwqTxOVa4TUw/wV
	Nsgkfcwkgv5XgudM9ViwrFs7N0jgDes=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-5Rns6CyrM1WDPkVq1moOAw-1; Sun, 12 Nov 2023 23:04:04 -0500
X-MC-Unique: 5Rns6CyrM1WDPkVq1moOAw-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-1cc2786a8ebso54597745ad.0
        for <linux-csky@vger.kernel.org>; Sun, 12 Nov 2023 20:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699848243; x=1700453043;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MtNFooCff3vqCOUxCEz1jHRl+QbfPpBEZibpqDAaoCg=;
        b=XMbR3VNZX7waL0l1wUoQWcikqVJdNNYnyusxmm+V0afcIkVoqFiFfktTT+YCxDAw5U
         ptDJiN89mBzYYOXI/Km16bGWUEW1AkIm7L2S/adVHGivub7/FRJebvziWjrpDaTjjp5O
         WeAVl8f+CAtVo/PjVjam19UO8qVEMcIW4jDy2KBvzNUXXSnXxxtYtSchm2Pn3mltDpBn
         y1ImtAFBiwN1jtAjZ1Ilv9bIFsrf31s5ZJBzaW1GlrKXON6vzu9+kgnMQfP0BWwkFonW
         q+KQStDdCjyMzZrohIAMGr7bF0inqF00a1uwxV46VetWltI9hEI5BrCrcfFu3HzlbTKm
         g62g==
X-Gm-Message-State: AOJu0Yx5j/hurOKoNd68fKe5qcQWPDxIvbi49zJJv9eYwvQLiWc7GwyR
	oVq3Frd16DGZ/w5wg1Zo8kOhn7OH9oF0+M4IOZb+fMLe1dilLXtBbkYGM6i2vGJAstlxV1M7sZ3
	Xx0mMZ3JKY62JmVz4eFXtOg==
X-Received: by 2002:a17:903:124b:b0:1cc:3f10:4175 with SMTP id u11-20020a170903124b00b001cc3f104175mr7395292plh.28.1699848243613;
        Sun, 12 Nov 2023 20:04:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIUBgi1/lc4Y3idUGi3EHadW6QYxPGSgwR1L+ZBVEJt2K4HesJHzLX8fXA3t0WRPADwpmGUg==
X-Received: by 2002:a17:903:124b:b0:1cc:3f10:4175 with SMTP id u11-20020a170903124b00b001cc3f104175mr7395280plh.28.1699848243280;
        Sun, 12 Nov 2023 20:04:03 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id u18-20020a170902e5d200b001c62d63b817sm3216342plf.179.2023.11.12.20.03.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:04:02 -0800 (PST)
Message-ID: <c4a0af68-153e-41a8-ae82-8ebb2b4c4bc9@redhat.com>
Date: Mon, 13 Nov 2023 14:03:53 +1000
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JLg-00CTxd-31@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 20:30, Russell King (Oracle) wrote:
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
> ---
>   drivers/base/cpu.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


