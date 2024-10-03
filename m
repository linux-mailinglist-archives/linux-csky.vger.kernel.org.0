Return-Path: <linux-csky+bounces-934-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788D098F1CC
	for <lists+linux-csky@lfdr.de>; Thu,  3 Oct 2024 16:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6FC31F21EEF
	for <lists+linux-csky@lfdr.de>; Thu,  3 Oct 2024 14:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB2219F410;
	Thu,  3 Oct 2024 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XCR/1Z3l"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA1B19D07D
	for <linux-csky@vger.kernel.org>; Thu,  3 Oct 2024 14:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966995; cv=none; b=baJIE5GWxEHo6OEOXIbhnxPrGbNfSdXNb2RGCQsLrbp1VW8gCz3WUJrPGbwQhW8IbmsdZjQfKEyhv3AY1umAJcNkJ9pSDaSTAdAqBvVwoALB5SFobWR9QTjh9i6U8C9qSsW4fy2DIRhNunumJQ/qB2R7R7Sc++WqY/eWBli06jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966995; c=relaxed/simple;
	bh=YSJKGbAVsaG9FB5YYybhcFMUlGKkb5YfLZFQUI0JNHM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErN1fUJSgBCljlOh/R+Y4AkQ0XsVH3emuczPYUD7m6reSZgo6w37bH8ZgmZNtabp/eyfXhrE7zLwtjFnjauErINp/g25vqpqYTMbL/7bpkGYsFWBovY7P9b5iqBOe8mDZuDri9keE2/S0VighYz9+YIVzYQiwUt+sc7l1P03FRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XCR/1Z3l; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20aff65aa37so8295995ad.1
        for <linux-csky@vger.kernel.org>; Thu, 03 Oct 2024 07:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727966993; x=1728571793; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WdndKVp/SXRSmiqlbx9yFx2IrKrWcsly5j+I0V4+Xpc=;
        b=XCR/1Z3luNu4iyG21zC+1hPOpD4cVY4SOxG7ZE14jKuAVKUszIxCEsp99KJRY2STCM
         BisslfPzFWWF5E+9EvZZNQFdFS/DajbQSiy0a3fRAEwcrKsLsX+Q014Q4exDwjZV6eHe
         xTFAk+5TEvT4oWvfm4No0i+D3IirBtDvQV29qIluZRJQ7RipFJM0jzruT0bifzV0r9me
         nrcRKlv9SMTymGnU2bRnYBcwCSvZv2mSboqoEbLBf4mZbRP+c8nFfljxlEXNPqPmNPCR
         +DQ8h6KvJpgHAQqaLThzM6qzCl9WwTSIGp84ZU1U1hmzEj+2bzNUuuILnmU/FypdMY5W
         u74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727966993; x=1728571793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdndKVp/SXRSmiqlbx9yFx2IrKrWcsly5j+I0V4+Xpc=;
        b=R6ACW6Qm5Xr0jgfmZiJ9+0BaFUBGGAn+0Ap/vmCGMQDyKHVv2rYQVAMneE11wtBqmv
         rcNkd6ajhv53Y42hjgJwLdiEcelE6i3FZyK23oGIm2/f9vFPcpDbu15f9ntFZRAVuAIJ
         QFr5dV1mC7LofbxWTRe6pbSrvpw7T5IQkiyVx2S5xBa0iiioDIZRwywgpKoCb0IWIK/b
         s0oluFflfC9Kkx7LalXl/WPDkRJ6rPW6xI+SfaT0Ujtz/cDoAKX0nNJiBYd2nl7soNzZ
         FFsw8mY0pYPxMjOqvBr+8nNnbX6HnowX+NdW0+vUEZf/UdBTwSfIk/Hf4UkND3hxVMMs
         iBHA==
X-Forwarded-Encrypted: i=1; AJvYcCVk22xm8LVWlycbJAu9HsEdKEDMGGby68qfDvbbuNM7S9uytYrx4KuCG4Vuf043AFwgCcTIwjpTq5cN@vger.kernel.org
X-Gm-Message-State: AOJu0YzhT0YGHKlw8w/3mB72bCOziPvWKfR+iWeoix2cqzm09p5yQvR2
	TWt6nrSqjy4ZAQIs/5hgC6mYMI+DqZYCQSQV6OnTPEEdDc3+hsxaG31MJFzwu0A=
X-Google-Smtp-Source: AGHT+IGo1/5wmvT+S3lgxo2dZaET0mITukuMWSSrKrQoA9kwkNrpn/E6uNgdsnyYgFqETska12PKbQ==
X-Received: by 2002:a17:903:1105:b0:20b:b455:eb72 with SMTP id d9443c01a7336-20bc59f0768mr101644085ad.8.1727966993424;
        Thu, 03 Oct 2024 07:49:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20beeee42f6sm9722015ad.123.2024.10.03.07.49.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 07:49:52 -0700 (PDT)
Message-ID: <238ace80-c5b4-4c8c-bcd9-8a06f99a3aa7@linaro.org>
Date: Thu, 3 Oct 2024 07:49:50 -0700
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 07/10] parisc: Align prototypes of IO memcpy/memset
To: Julian Vetter <jvetter@kalrayinc.com>, Arnd Bergmann <arnd@arndb.de>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Andrew Morton <akpm@linux-foundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-alpha@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 Yann Sionneau <ysionneau@kalrayinc.com>
References: <20240930132321.2785718-1-jvetter@kalrayinc.com>
 <20240930132321.2785718-8-jvetter@kalrayinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240930132321.2785718-8-jvetter@kalrayinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 06:23, Julian Vetter wrote:
> -void memset_io(volatile void __iomem *addr, unsigned char val, int count)
> +void memset_io(volatile void __iomem *addr, int val, size_t count)
>   {
>   	u32 val32 = (val << 24) | (val << 16) | (val << 8) | val;

Mask of val now required.


r~

