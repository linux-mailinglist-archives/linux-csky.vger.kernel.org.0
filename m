Return-Path: <linux-csky+bounces-2047-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C9EAB571F
	for <lists+linux-csky@lfdr.de>; Tue, 13 May 2025 16:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3618644EF
	for <lists+linux-csky@lfdr.de>; Tue, 13 May 2025 14:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BE72BE0E1;
	Tue, 13 May 2025 14:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wF8jWugQ"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C399828DF0B
	for <linux-csky@vger.kernel.org>; Tue, 13 May 2025 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747146515; cv=none; b=Nkhv1031OvIP1IMaU6jXElwyE/IEqtRuqhC43+ZaOIjTow+FfNXhMoUPKG/uO/tAg4M4e+WcYjxVhjhH7YkAGUAE1QF+T78CfVo3x3pVcENyx6TevdvIUUabNi/LNxoACsZxL7OkJDGcpf1ELzf/onO8OLWUFRcyl3q/oS9hTFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747146515; c=relaxed/simple;
	bh=FPGcOwlz+SQQyXaiG99CmmwqOtDZlk4i0e/TjrhK74c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cefgRSN6f8NirXzMugy8IUdYOp6Zwr5sRVWR0YugeIJZELAJ1sDpkvmJjbUjNTg89Tq9TCy0ATK6cMGEVrPfk9jDEihy1QUkR/ZgC99YdOsSsdqTTGgZHSFjZo7g5x3qaRKxUYwxAL/B9ZUDNBpmQP1o8gFMzLSknvX5aMaM6Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wF8jWugQ; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a0ebf39427so4631538f8f.3
        for <linux-csky@vger.kernel.org>; Tue, 13 May 2025 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747146512; x=1747751312; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=An+gHx9DxdOFWYezZARE0iblS7iu3MVu0hRYoQkisQ8=;
        b=wF8jWugQ0GePPyf/B6+vsV8BL6n5RMiCZLruKuBZZezeSSk83ATG6WImHb/SvN6Aic
         I1DSge7XdhXUDvk5lB/pX1NAn1p05Z6xxEvcmCWw9nEKKoqfmtrDCfRombnmo2ziANWN
         iUxjjuXJNKQrwWDOp0ai5ailr//hT8EoxTurvTBfqhL9zUoavwoNj3zwXcXCskgmmzKG
         G/cC9wdk+PWgZlXGMGcVNxtFubFLo/So+5bxPPcUsPZd7Fq8T37h3qR8wKAlZJySBArT
         WLQQeYFwDy1kG39LEo2YZcy9tWPRR7FEjmX1lATvQd2BWXy2VX1MEWB5R31dqCSVa7jc
         Q1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747146512; x=1747751312;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=An+gHx9DxdOFWYezZARE0iblS7iu3MVu0hRYoQkisQ8=;
        b=jW+YhLXVbRXkTNkVrnyJ5jRJ0MNCElJb5zSypIreunSmsw8fHHwkL8TvBFhguUCA9i
         NCUJIEa8xhxmHg68v4Y1oW80CacBsEuyRzGZ94RYcqUhSdiHh7hf1ANmg5PYo0+128Se
         32b8aCZDJvdIe4C05n21yTnLlGl66AGUA5p2uBjdEmSsT5nh6jTVajzVXRdu77RD0B6v
         msyS5ivKO898ZMCEUunrOYPjexRU9UzG9bayu67ylgvAoNtBtedAyui1cmFYbraq+rcm
         KDTkiFnAS4DixObKXHjKkZcTZj80bvsTm19SdIwqP/MJNqmURv5dyQ57Q+08gmyGk5Mx
         ZBqg==
X-Forwarded-Encrypted: i=1; AJvYcCX8aRRHtdC1JdbD6NofTWFv28l2EHjP0RCZTJf8h7wz07YCSc1pxEvsYWbQeY6dKm9egffw4hnBWwDI@vger.kernel.org
X-Gm-Message-State: AOJu0YxSdEAFmBynieG/DcGsrgVxLohxOTPYKnOaXqu/uAhT7CPpFDuH
	rahrjR//+cY7jfkDlH3PX1sTkE6Q4P8kwTmlUfF0va2YBuw5DDnavg/6jjofc2c=
X-Gm-Gg: ASbGncuRGHpm4zjLZoO4sHS1hB2CM8rmqoBzWhS0SUG5AQczh6hRCiI6KYPlL3cdCUb
	VjTeBsPnxqhD/IwcNBUROOEMb2MHxJxG8+afMzJIGVcJ+H3t3XpbjYiRkzgEc4V79O/tHWtnqM3
	hArk3EI+8JJe6lykTP0RZncYycLqwu0hACIffTfn1/uoNxakTs59xmvttYjvpX6yaJKQcHm5wyJ
	fFfz4iERBMWDTDS8DgiQkyvxc1LmU4YdvToDbQgAf7fXFCeHwETsYhJeRcO3V8ZgYBKPA7K7oT6
	6BrsCOeaGzJ8svLIiHH488L19PA3y8WqLWMbH0WooD6bssbTgLFDTnFlhOnVqcZFYGdw9YOBEQf
	ici/Ag0Nw0LX1aA==
X-Google-Smtp-Source: AGHT+IG9d9Erev/kaz542q256qo4Zv5SBlOSuXgHIZpq9zVY7VQbS5IOFnwYMh2iGSxQ0nUaJtNt0g==
X-Received: by 2002:a05:6000:3102:b0:39c:cd5:4bc0 with SMTP id ffacd0b85a97d-3a1f64ae7bamr15129851f8f.52.1747146512164;
        Tue, 13 May 2025 07:28:32 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c5c5sm16693029f8f.96.2025.05.13.07.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 07:28:31 -0700 (PDT)
Date: Tue, 13 May 2025 16:28:29 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Guo Ren <guoren@kernel.org>,
	Flavio Suligoi <f.suligoi@asem.it>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-csky@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: timer: Convert csky,mptimer to DT schema
Message-ID: <aCNXDTmv5nuSEiYj@mai.linaro.org>
References: <20250506022228.2587029-1-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250506022228.2587029-1-robh@kernel.org>

On Mon, May 05, 2025 at 09:22:27PM -0500, Rob Herring wrote:
> Convert the C-SKY Multi-processor timer binding to DT schema format.
> It's a straight-forward conversion.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Applied, thanks!

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

