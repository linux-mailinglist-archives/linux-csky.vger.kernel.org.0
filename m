Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D44F173094
	for <lists+linux-csky@lfdr.de>; Fri, 28 Feb 2020 06:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbgB1FqK (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 28 Feb 2020 00:46:10 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:43503 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1FqK (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 28 Feb 2020 00:46:10 -0500
Received: by mail-pf1-f193.google.com with SMTP id s1so1129975pfh.10
        for <linux-csky@vger.kernel.org>; Thu, 27 Feb 2020 21:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X/CDTICnOQDVAz0nY10LYxi3q9hIm0vSU74A26OqRXI=;
        b=RWzlXSmhBiVWDO2Nw+rzWJ92MdlcZtHs6IqWA8pEyDyY8IUYQFwiqlrczkHR4mVpZd
         /dVK7sVgmoO0/luytriYMCskXmCMOulhGahmaZYLv1xHxVcJXRnCsWS6U9O9vA279oPd
         r+IiWvht1/iceHKex1+NbKqONs78R3lAT3IdooOLOFktoFtrZgtDDJZw8ie9aCkJ7MOm
         c/2HEI8G79Viu06G/1w88yyu9V/YrmyhCXHG2zPVanYfiQWFwyJQ5kwIFy6ECeO5h4ri
         XiqjkbkGGzifWuoM0tJ0em+uzExwOimex2DB2EXKzZLav7IfzwiwcejnfwboTV1P35Fd
         +0kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X/CDTICnOQDVAz0nY10LYxi3q9hIm0vSU74A26OqRXI=;
        b=EJJatNT4LtC6W7xtECJ14TFgUTupD7vmUxWE7UgkArYTdkNhP1TybLdAXsy89mVTuj
         qfy0WiUnu0vrHoebD46bob7dISJSUJMbCivc0oRJdpgyb7y8XC6rwM/Y4upEkvizSx6w
         VFjoyD8l8sx4HS39ybd1k6kO1gjcsK6EqdVJiv+XtQBCg2Qs7qMtBnow+789/s/x2AyT
         AaDROAviwcvvQXgizsC14Jd7L4btu72htMoh5s2kMsPfbwYxMO02n1d2cFKglOriCRXi
         GJkckdTGUtZT6MOEVzK+kJPG1PoZ+2/khrJ1uhgcAYmUf5gV79YAc/1c/fPAdyLpouEo
         KDqg==
X-Gm-Message-State: APjAAAVcfZViB3JfQ5ViOHnRIfb/3yjvaLJF8QrN8+p9h1K/7ghlj606
        CtG9WazHk7Pr0wR2Hv/vvfPsfw==
X-Google-Smtp-Source: APXvYqwnh/rXSpfOMRXBABV8lrH7MQ9VQ401lIwvEdln4lrqsG25873fDezYtYK0rqUkBUESpPs7ng==
X-Received: by 2002:a65:4c82:: with SMTP id m2mr2821414pgt.432.1582868769589;
        Thu, 27 Feb 2020 21:46:09 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
        by smtp.gmail.com with ESMTPSA id m12sm556399pjf.25.2020.02.27.21.46.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 21:46:08 -0800 (PST)
Subject: Re: [PATCH v3 1/1] target/riscv: add vector integer operations
To:     LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
        chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
References: <20200226024352.7719-1-zhiwei_liu@c-sky.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d47523ad-52e3-b0a8-a47d-c91442fbe48d@linaro.org>
Date:   Thu, 27 Feb 2020 21:46:06 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226024352.7719-1-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 2/25/20 6:43 PM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  target/riscv/helper.h                   |  395 +++++++
>  target/riscv/insn32.decode              |  127 +++
>  target/riscv/insn_trans/trans_rvv.inc.c |  671 +++++++++++-
>  target/riscv/vector_helper.c            | 1308 ++++++++++++++++++++++-
>  4 files changed, 2462 insertions(+), 39 deletions(-)

This patch is too large and needs splitting.

> -static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm)
> +static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm,
> +    bool widen)
>  {
> -    return !(s->lmul > 1 && vm == 0 && vd == 0);
> +    return (vm != 0 || vd != 0) ? true : (!widen && (s->lmul == 0));
>  }
>  

Best to move the addition of widen back to the patch that introduced this function.

The "? true :" is a funny way to write ||.


r~
