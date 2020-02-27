Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAE71728EE
	for <lists+linux-csky@lfdr.de>; Thu, 27 Feb 2020 20:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgB0TtF (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 27 Feb 2020 14:49:05 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36664 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727159AbgB0TtF (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 27 Feb 2020 14:49:05 -0500
Received: by mail-pg1-f195.google.com with SMTP id d9so229829pgu.3
        for <linux-csky@vger.kernel.org>; Thu, 27 Feb 2020 11:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5yN6sH6PQyT2zWxZQXjM0a62AyWsU4lD3wudwbpMNcQ=;
        b=eU6LFt042wGzY4/cSfnJuWAHQ/73aMWgnM3j6qj9gbXp8h5qwvtb+GzG5cHrPMmX+n
         U3YKJiLN8eV0d7MRizBN5JJx/xhOv+KwtqR6nxljZBvCh2kS4/OMMSwJgPS+E7j37ahw
         F8JkgjTj+nZjeuqefmqxvy7lQmPRUL5CIEnRJoMHjoirIdUFOi54iZUJKJ6Oe6yPb8Kk
         hpg4qY9myI9DGpl+sYk0RXlJL5gsywsves8g0oEuG54S2l7OyOgYaozW8gFNRkd4Oa9E
         /EPw0T4fQtHNeTYr39kf0eHYb4EXem94o0vSyuJ9MaSvmfUo93ibHNYPlzf15nljgk0Y
         8NhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5yN6sH6PQyT2zWxZQXjM0a62AyWsU4lD3wudwbpMNcQ=;
        b=K8RcWm/8gyTaQtzKEZ6/cTTZi5HQ0xrj0+1myFwUBtjhPdumQZv9SJXIj7AH5ZcTFc
         FRRD37AsRa7qJmVj1xPuy8ZPuwYC52yjKDlz5D+viBL4XzOgOsNc/gX8jXLZZwRbc6T/
         i6z65AitvXKGY4EADKR+pSil34pJa/+LGA6rOYHkqwto1KsBgLCFYLUnCpDTRkegA8Vc
         YN4++1SBZi3GureO8h19kFj3XQhvdRPsxzT+tPdSnC8sFpS+OOFTbvp7/TcgDeGizMqN
         rEoMomDS0qNI3dHeX8K3PpaCvkISpn/IA8dPYPU4GaLrTSQ474tQJ9KMANTyqONYClHR
         Mu6Q==
X-Gm-Message-State: APjAAAUnOF/ycmC7kWXyYbRxi0LVoJFZkTHgJnpYFuv+PvYSq0pjiiEz
        nGEOev25s0B5A/d+5kiFwvMuftrUk9U=
X-Google-Smtp-Source: APXvYqyomvcL6FS7utxlqRTE2UGXlv3vGzIut3Nt363K04DlCt7BPoo0beMALHABzUs3iTPCXExQDQ==
X-Received: by 2002:a63:e509:: with SMTP id r9mr990070pgh.274.1582832944247;
        Thu, 27 Feb 2020 11:49:04 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
        by smtp.gmail.com with ESMTPSA id k9sm7332755pjo.19.2020.02.27.11.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 11:49:03 -0800 (PST)
Subject: Re: [PATCH v4 3/5] target/riscv: add vector index load and store
 instructions
To:     LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
        chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-4-zhiwei_liu@c-sky.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <30ac8dcd-a6d4-b4d6-212c-6819f914bd21@linaro.org>
Date:   Thu, 27 Feb 2020 11:49:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225103508.7651-4-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 2/25/20 2:35 AM, LIU Zhiwei wrote:
> +vsxb_v     ... 011 . ..... ..... 000 ..... 0100111 @r_nfvm
> +vsxh_v     ... 011 . ..... ..... 101 ..... 0100111 @r_nfvm
> +vsxw_v     ... 011 . ..... ..... 110 ..... 0100111 @r_nfvm
> +vsxe_v     ... 011 . ..... ..... 111 ..... 0100111 @r_nfvm
> +vsuxb_v    ... 111 . ..... ..... 000 ..... 0100111 @r_nfvm
> +vsuxh_v    ... 111 . ..... ..... 101 ..... 0100111 @r_nfvm
> +vsuxw_v    ... 111 . ..... ..... 110 ..... 0100111 @r_nfvm
> +vsuxe_v    ... 111 . ..... ..... 111 ..... 0100111 @r_nfvm

These can be merged, with a comment, like

# Vector ordered-indexed and unordered-indexed store insns.
vsxb_v     ... -11 . ..... ..... 000 ..... 0100111 @r_nfvm

which means you don't need these:

> +static bool trans_vsuxb_v(DisasContext *s, arg_rnfvm* a)
> +{
> +    return trans_vsxb_v(s, a);
> +}
> +
> +static bool trans_vsuxh_v(DisasContext *s, arg_rnfvm* a)
> +{
> +    return trans_vsxh_v(s, a);
> +}
> +
> +static bool trans_vsuxw_v(DisasContext *s, arg_rnfvm* a)
> +{
> +    return trans_vsxw_v(s, a);
> +}
> +
> +static bool trans_vsuxe_v(DisasContext *s, arg_rnfvm* a)
> +{
> +    return trans_vsxe_v(s, a);
> +}

> +static inline void vext_ld_index(void *vd, void *v0, target_ulong base,
> +        void *vs2, CPURISCVState *env, uint32_t desc,
> +        vext_get_index_addr get_index_addr,
> +        vext_ld_elem_fn ld_elem,
> +        vext_ld_clear_elem clear_elem,
> +        uint32_t esz, uint32_t msz, uintptr_t ra)

Similar comment about merging vext_ld_index and vext_st_index.


r~
