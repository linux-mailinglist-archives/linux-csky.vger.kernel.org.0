Return-Path: <linux-csky+bounces-935-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3813798F464
	for <lists+linux-csky@lfdr.de>; Thu,  3 Oct 2024 18:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5F711F222A9
	for <lists+linux-csky@lfdr.de>; Thu,  3 Oct 2024 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1656D1A7056;
	Thu,  3 Oct 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uatXi8xH"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F18119C542
	for <linux-csky@vger.kernel.org>; Thu,  3 Oct 2024 16:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727974017; cv=none; b=DRNZPhJgnceo6ihw04N/+3XXthMH2b41RQRiAKxsNn7Rp8zmvBKQQyhx3hxWLTefQK6jfKSypCCzp6K0TATn0cfH6t56Bj0fB0/wf+tmz4LNfSwZd2/zt58JYvp9SUMTXsWS/ykq+8FtDfD4zA/UqjDyUHgl0H5EIIrkagVSYEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727974017; c=relaxed/simple;
	bh=EwT3q9EsnCa7yrZWUCyRNUjVCTNH45yR8vvcQYT/i1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WacdB9RxNDrI5s8bxd7ZCO8fMk3AmmB93a27x1z7Ni3Wm8zOXzlL0SA85i7+KkDc2aBoghn1+opdjFLAzfrTIlbZJdvMeldQWo2wigyvr88zNNbLb+dShhvggR+HJwOIiVVgu4w0gmzg4sE2dL7FDqdyy+KLjaWeb8xG3VxYR8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uatXi8xH; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7e6afa8baeaso976943a12.3
        for <linux-csky@vger.kernel.org>; Thu, 03 Oct 2024 09:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727974015; x=1728578815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RW5P1Arx8XPYT/NPFqMkITFeiGycXbJcANO3qtPPvbA=;
        b=uatXi8xHkUqeCRDr5Mlfvk0MQ7i+Nps7epYpKwfgqrQRySXt99qKBhbRaMqzKGY+tS
         OIILTTs16rkouA4DCwtOCgugHYZ1rF2oUSWAOPqourYu+pstKMN50Zy6PbC5TnxhfXc8
         H0P7LVQeSJlpJsVQ6k7sQKEiG+zt7wQAmyeC1x3aH2n4rdeOKOJ/FTSqCmN1aKpRN6VV
         KfJ6kMjnomN0iZhMexd+6BBmqinzauQsPlsDnPUocmILborbu/Wn3eXu3N9HJhpQykQh
         GWosPjT/vKjbFLkWvjARTDnbRXScsqHn9e8VnprsXgwtA+/X355H36ntcB+C2fELdeeJ
         TUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727974015; x=1728578815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RW5P1Arx8XPYT/NPFqMkITFeiGycXbJcANO3qtPPvbA=;
        b=KCdQAB39DPXEfLZze9RgPipHI22CdKMoSSvNYDTflJ71bQoy627VXVKljgor5o0mvl
         CR+0O2s8ovG5Fpi2xUcKADbvexi+t29Pxx7e0Q+8DMKzFzPV1MM1T/e9lt4LKNsmpK/F
         XJHqyI4ZJ+W4PyA0s4EtJS7+zYJ+wG22XIhAMcfdlZwGiF2zZrBujaPhKK2S//nnMexd
         IQdS8ICSFWFMvkVlpYn3RBCklw6bmlhQn2jAcnEWaHSDLBXMUXySI9HcDefgtOtv9n21
         pQL1k1S66KxgmXxK4cxcrreC0NHdc6C73lw/qF+u2XW8xjSpiGCV7X79wch/ipqswnai
         t2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWJKRsIjmvhik7HBJA3fze3Lu0K2eYQ6nyp4p0wj2c/koQGI6mtEVEOOyBSe1h5hdaGOpaLx9Ws7/gR@vger.kernel.org
X-Gm-Message-State: AOJu0Yy54XoGtVsP6YfkyV12z+IXROpju3NS864XA9pIosgkZxuJ9t8q
	MZXBO4yN9AKmsBx+3+GhRhLkGOkFcE/5EpPlwUKcWZWQ8U3pyWHJoegf3LIcUw0=
X-Google-Smtp-Source: AGHT+IHrNLnq312K7GVWKGT1Vo9Ff69i9ensfXAZGMY12ruPSu/BXqZiVZ26a2jiItIAw0CUa22nFw==
X-Received: by 2002:a05:6a20:cf84:b0:1d2:e8f6:81e with SMTP id adf61e73a8af0-1d5db1bf932mr10105522637.24.1727974014772;
        Thu, 03 Oct 2024 09:46:54 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e9dbcf13b6sm1055380a12.8.2024.10.03.09.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2024 09:46:54 -0700 (PDT)
Message-ID: <a4f85184-73d4-44e4-bddd-0c1775ed9f50@linaro.org>
Date: Thu, 3 Oct 2024 09:46:50 -0700
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/10] Consolidate IO memcpy/memset into iomap_copy.c
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
 <20240930132321.2785718-2-jvetter@kalrayinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240930132321.2785718-2-jvetter@kalrayinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/24 06:23, Julian Vetter wrote:
> +void memset_io(volatile void __iomem *dst, int c, size_t count)
> +{
> +	uintptr_t qc = (u8)c;

Missed one change to 'long'

> +
> +	qc |= qc << 8;
> +	qc |= qc << 16;
> +
> +#ifdef CONFIG_64BIT
> +	qc |= qc << 32;
> +#endif

Could be 'qc *= -1ul / 0xff;'


r~

