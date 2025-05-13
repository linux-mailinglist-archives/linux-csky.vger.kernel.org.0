Return-Path: <linux-csky+bounces-2048-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED26FAB5728
	for <lists+linux-csky@lfdr.de>; Tue, 13 May 2025 16:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254B51893E8D
	for <lists+linux-csky@lfdr.de>; Tue, 13 May 2025 14:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 002F02BE0EE;
	Tue, 13 May 2025 14:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UUcAa+Qk"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1170B269D1B
	for <linux-csky@vger.kernel.org>; Tue, 13 May 2025 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747146581; cv=none; b=Q7WEOt/agwbK5+X9Zmpvrb/gqfblBIzTa15MpYD9WyXyF6k6wHoSBL59JheBZSVMErTzXpDecDTi4vCbP4mCnKXRYmuNnJn4IrbpeI5NczO7c7z3TndwZUV4h3UnIv8oYyhWFAD2ENaQzYit5rcueiPMNj/vCZSVg6Q0TaCVPJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747146581; c=relaxed/simple;
	bh=3r6EFmRwIAg4Ct9GeTXJ9nBhaVARUyeX0iflKOCi8wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cvv6Fdk+VDMwXScCIAeDbjXc+SiOrMYwannPkVEa0SnaLV5omRtqRObjF84B1j8I8rYwwRaZem3dGbPZC1+B2167oWZtPR4ie4ogH1l8Rm48kHK5S8HObjC4k00grmCCG7TPlM33oZv2QvHh+CyGynsmYloCjxBhmDk2RRxvNtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UUcAa+Qk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a0b135d18eso3305672f8f.2
        for <linux-csky@vger.kernel.org>; Tue, 13 May 2025 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747146577; x=1747751377; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5T5EVqvVCDoHXLH6Qk0C5AKC1Zmg5QpTMVhHdRjdkFc=;
        b=UUcAa+QkCp+fZPLlvv7OIr5fbXBFHoMrmO7NVPxyGuZBdlK29VO8ZL2CGQj3VU6YHj
         9HKVKeDCmtaBunrunEXcHrxxKSvKQDaw7DEogOOvxvjeQtseua4ghGwH2I28cVWGR0KA
         VmDkp0EuZj82xiRaFc2wi5ElZyF5akhnR5dqeUSiMZUrAJC4v4aX8m60QZLmlWP6C/DH
         OP82jZcNYfK+0+xn3rM90zwc6yIN9BVbAaSFTTNr835PV/xP6WZbBtHNBNlJ2mRxXh2i
         SkvaD1Bt+sU/mlpM4jmkXnpdgLxKyYP6tb7B6V9MrX0DMwUB9e3uA1lotMUeuU3V0Yjd
         IqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747146577; x=1747751377;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5T5EVqvVCDoHXLH6Qk0C5AKC1Zmg5QpTMVhHdRjdkFc=;
        b=jHlE83g36ILxRBqTpkgJAwyZQhIfSYV2QHTklwYPKHivTy0kcm0rjPbtKwWne/lPAq
         svAgVz9MAb0MjRQZmC7o2E9ou6Bj7zaWknhxDG180cF/6cMPPph+c2bslUvvE/Z3TDX+
         FTwsAL5bhSM3Ix0Q6VYJFP0kNNYUEPchTQ5PiLKtWg9OS5TelpeJR5RpUJygdwUi9OIZ
         NKnI2J7p11kxfUUVWJbDeerANKSit1RvgYjmRSwv3tT96g1iK51mAgtHxVabSwkYIht2
         E7UwbQHnuXgypqREhQzVMmo/MCK7Vi37rjUrUClo2y5o6Q/o2L0KOHfkoITBdyXzlLv9
         J1aQ==
X-Forwarded-Encrypted: i=1; AJvYcCV4CcEjjQK9caIxh4tg0xzfOa6iunljiuWzbelx84zFkJTGxR0dF0dnKWFsGClwP3DUKOILTXU0zWtC@vger.kernel.org
X-Gm-Message-State: AOJu0YyIU3XitB09ydTDhjHCAh/9o06H6i4AYXz2V/y+EU4aNcbpkvCF
	N8VrqKealqrzhhFXXV3Jth8zW+an4FO7qLrcrg1X1dDaSCA3Bh29BZ9MVnVwFuE=
X-Gm-Gg: ASbGnctX4xxmOjljq3rT0VtEDhi4aacptx6sM30kO81JoqxZqzxvacKH9QVV70vvPTP
	ClwKgukxFO1zt6tdXSJfYRGxIEu7z2fjgvqEv7SsB4xBoor6sFuiZVO18pPVWEBfrASmASodD66
	PO7qOOKqhq2zA6AdNk5fDZwZINh70CcE4x9QWLsM3q83qocR1E1bgcG+ppiOlxnesachcZbD/SY
	5W2QgTlslfWLufnrS9PEcGD/JGp0UipHMjyfY15cokMFKn0ZVaP4VVWmvbjpCK8RoegEdoc/9gC
	Q4VfxTs8olrKRSreQXBz9jj/OL2NaADlVbox8j7UWJr9nlNXIbsFYTWM8Ckb0vsSvHnanJ7GN3d
	HHw+Y18Yzj6Z3H43L11HeBxq0
X-Google-Smtp-Source: AGHT+IHNQc8VSkvMb+be4xShmhohsEns4BbUI6HrioDELteMpaN+j7jH2OMJqSpLg6IVq7ISGUZrlg==
X-Received: by 2002:a5d:5f82:0:b0:399:71d4:a2 with SMTP id ffacd0b85a97d-3a1f6430752mr14506029f8f.14.1747146577463;
        Tue, 13 May 2025 07:29:37 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58ecadfsm16347307f8f.22.2025.05.13.07.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:29:36 -0700 (PDT)
Date: Tue, 13 May 2025 16:29:34 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Guo Ren <guoren@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-csky@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: Convert csky,gx6605s-timer to DT
 schema
Message-ID: <aCNXTvpa-R6S1LZZ@mai.linaro.org>
References: <20250506022224.2586860-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506022224.2586860-1-robh@kernel.org>

On Mon, May 05, 2025 at 09:22:23PM -0500, Rob Herring wrote:
> Convert the C-SKY gx6605s timer binding to DT schema format. It's a
> straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied, thanks!

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

