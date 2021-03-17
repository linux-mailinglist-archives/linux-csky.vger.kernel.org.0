Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0899C33ECB3
	for <lists+linux-csky@lfdr.de>; Wed, 17 Mar 2021 10:15:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhCQJPC (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 17 Mar 2021 05:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhCQJPB (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 17 Mar 2021 05:15:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C03C06174A
        for <linux-csky@vger.kernel.org>; Wed, 17 Mar 2021 02:14:50 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id j4-20020a05600c4104b029010c62bc1e20so841554wmi.3
        for <linux-csky@vger.kernel.org>; Wed, 17 Mar 2021 02:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3+HI/szBQ5FOTyD8Qug4Foc8OSZhCyYiT6v5FkPNKc8=;
        b=jeHJzjXWMszguZe7MoOivSMUVkwfy3EYx2A2MqbLsl+1PdJgoyYc39we0KfZe9tKxS
         uwGsA6QFEQ7TiQt6NbHQGhxkUUgppZ2JuMnVlI4uCaBRl70txyvrEaCzfhNFgK4TEFiQ
         4Ccbhy8TcLH41EQrKS8+0/IXvGx3xYDg2X9W7kQ5Cy3J4F235hwbNN3ac6cIEVMD+oKL
         hZGoTZFsvK7FY1tNpOoyBQEY+INJv2SITH6y13iP0cxAIiayHxD4ZJePbKi5AOw1crIw
         /0cz7nCmI1Ldm4OkCutFVGSOqfGnR9TohqECuM6vK2SGyrbuKzKLiQHEmjhaKu4Z6p71
         ADUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3+HI/szBQ5FOTyD8Qug4Foc8OSZhCyYiT6v5FkPNKc8=;
        b=TxLrKPSuoo5UDyViWzTqoRHQ9M0jy2ggbaIGqhhdBYYWut8eJ2fKrVir3dltZA+cDC
         R+LzcfQjAIwqIolmdqIDnbihXLmlDzPY7zGkUcfhsDMxiJUi8zbXcMyhvArCXATWPl0l
         Q85ZEcjYJCULvgeKdCgPG8NFx3oFxN56+j9t0UxapNvA0QgpRtLh0EIrYFwlpdjT+v76
         6uZV2XScH4qkxfvBlil/zN6+W3/gTJ/wh3zY56PlfjtyFNmPGFaWrbCB8txrZ0btbrQt
         OTcUVmN1e8kn1dhhdpnhF1+LFzZv6AHngHJZTeJaz8TERyVBLahOM7+z0ba4GWoeBDUJ
         r9pg==
X-Gm-Message-State: AOAM531AjyKOyDaiZuNB34p+uqIUZctMCLlQRvory9UmBuYi7+mluhAJ
        WdGW8sRmp8vcpbnW1B4FTpoJ5Q==
X-Google-Smtp-Source: ABdhPJwV4NfelpdpRCyF9uOCtCgelxHcUPbS1hKlsP3rXiknagWHrC5091KByav6fHAr2xdUa6cLag==
X-Received: by 2002:a05:600c:4844:: with SMTP id j4mr2685735wmo.179.1615972489089;
        Wed, 17 Mar 2021 02:14:49 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:94c7:f1f0:53fd:90e4? ([2a01:e34:ed2f:f020:94c7:f1f0:53fd:90e4])
        by smtp.googlemail.com with ESMTPSA id l4sm24546688wrt.60.2021.03.17.02.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Mar 2021 02:14:48 -0700 (PDT)
Subject: Re: [PATCH 1/2] csky: Enable generic clockevent broadcast
To:     guoren@kernel.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20210307022446.63732-1-guoren@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <4e57c0f2-c718-01c1-032a-8e4934496b17@linaro.org>
Date:   Wed, 17 Mar 2021 10:14:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210307022446.63732-1-guoren@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 07/03/2021 03:24, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> When percpu-timers are stopped by deep power saving mode, we need
> system timer help to broadcast IPI_TIMER.
> 
> This is first introduced by broken x86 hardware, where the local apic
> timer stops in C3 state. But many other architectures(powerpc, mips,
> arm, hexagon, openrisc, sh) have supported the infrastructure to
> deal with Power Management issues.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
