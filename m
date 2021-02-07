Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D06312335
	for <lists+linux-csky@lfdr.de>; Sun,  7 Feb 2021 10:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhBGJab (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sun, 7 Feb 2021 04:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbhBGJab (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sun, 7 Feb 2021 04:30:31 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C44C06174A
        for <linux-csky@vger.kernel.org>; Sun,  7 Feb 2021 01:29:48 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id b3so13424546wrj.5
        for <linux-csky@vger.kernel.org>; Sun, 07 Feb 2021 01:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UL89vnp+Ah7/ei61uQ/cC1UZ5VSPsshw07hBlWMQIhU=;
        b=lU7YfPFMZJCqtk6AnTii2fYNDezcQW7DfFPsoPbvXwew/AgP9bducx1IClkSLNQvoq
         NodCSkMritojUbrX/aBtF3o6G2OXAehvcNf+58LiAanO3AQBkb+n8Eqybu1Aq0m7hUiZ
         0Jlmc/gYmUTUKMQS1SoMER8pZCY+SAszaPzCTRZf0JpVCGdYHGCqoeiSxOH98CIzJUnY
         9NGgVrh4LQy878DNx2irmodSghFh7emf1mcPo+wkj3U7IHOJejacHNjf4xNWeo5r+lIM
         4mL/jSfq1jHhn0Gt0Kc9gdQ0XH2IunEgQzMVsxW1uz0zdNefY+xPOhwxbML9M4AKoIj+
         WFKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UL89vnp+Ah7/ei61uQ/cC1UZ5VSPsshw07hBlWMQIhU=;
        b=nY6Pe3wxwO5SppSwKQwWcrWIo5QJuilci6edg6476O3rkI1PvXxbp2gu0mVS1xSZ5L
         E1rTvBU21jJRG42d6k1XFhYoUm9O9Po7R4U6QOmfO2ITDlhWsp1vDr2F7a4rjF8QZVEE
         2PMTDC3WqlKDf96wc6zG5lV7TQVD+nfFw3kuZU4emrLGcFD7OBTxtqyhfP4rI+56YtAT
         fuQtIpC6lI97PiOctrvEux0Sp8X/atl7F+HFL/6fdZp8LnI44v9CQwk/SN3HE4FOM68F
         0rWvgdeujIsHPlMJiH9EQL6ly12dX8MQFpg4c6P7CLc3B4RjG3SRsWLJ6a4goB1DXnSc
         PcSg==
X-Gm-Message-State: AOAM533x7EIBzCDT/N/zZ+60/zqWRgpgdSC7zJJHcGQ47QX1kzn2A+fZ
        /bZZSzDeO51O9gSDf4ZdGnQiOIzsiNTXwA==
X-Google-Smtp-Source: ABdhPJzUVGbU/bEL9iOkuX699SCDThqbdIpM5atlgB62a/y3bFUZAjbzj3xUB59DqLqOj9TuILweyQ==
X-Received: by 2002:a5d:664c:: with SMTP id f12mr14160049wrw.61.1612690187515;
        Sun, 07 Feb 2021 01:29:47 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:c5af:e183:bc03:d8f5? ([2a01:e34:ed2f:f020:c5af:e183:bc03:d8f5])
        by smtp.googlemail.com with ESMTPSA id o18sm6762181wmp.19.2021.02.07.01.29.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Feb 2021 01:29:46 -0800 (PST)
Subject: Re: [PATCH v2 2/2] drivers/clocksource: Fixup csky,mptimer compile
 error with CPU_CK610
To:     Guo Ren <guoren@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
References: <20210204074609.3553018-1-guoren@kernel.org>
 <20210204074609.3553018-2-guoren@kernel.org>
 <c36b816b-6d80-9542-45fc-507c5cc302fb@linaro.org>
 <CAJF2gTSe7GUzPRvk6bK8AfQFp2uxae1Oo0w-ZtrtmcJmMWCqPw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <973602b9-83d1-8e22-60bf-cd77d606a126@linaro.org>
Date:   Sun, 7 Feb 2021 10:29:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTSe7GUzPRvk6bK8AfQFp2uxae1Oo0w-ZtrtmcJmMWCqPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 07/02/2021 04:31, Guo Ren wrote:
> Hi Daniel,
> 
> On Thu, Feb 4, 2021 at 4:48 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 04/02/2021 08:46, guoren@kernel.org wrote:
>>> From: Guo Ren <guoren@linux.alibaba.com>
>>>
>>> The timer-mp-csky.c only could support CPU_CK860 and it will
>>> compile error with CPU_CK610.
>>>
>>> It has been selected in arch/csky/Kconfig.
>>
>> It would be better if you fix the root cause of the compilation error.
> The timer-mp-csky.c has used specific instructions which only
> supported by CK860 and timer-mp-csky.c is only design for CK860.

I guess you are referring to mfcr() ?

> In arch/csky/Konfig we only select it with CK860.
>         select CSKY_MPINTC if CPU_CK860
>         select CSKY_MP_TIMER if CPU_CK860
> 
> So here let's select timer-mp-csky.c in arch/csky/Kconfig, not in
> drivers/clocksource/Kconfig.

The COMPILE_TEST option is there to let other architecture to compile
drivers and increase the compilation test coverage.

The proposed change just removes the driver from this coverage.

Ideally, it would be better to keep it with the COMPILE_TEST option, so
changes impacting all the drivers can be caught before submitting the
patches.

By just adding

#ifndef mfcr
#define mfcr(a) 0
#endif

shoud fix the compilation issue, no ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
