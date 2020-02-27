Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A253217292E
	for <lists+linux-csky@lfdr.de>; Thu, 27 Feb 2020 21:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729611AbgB0UD6 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 27 Feb 2020 15:03:58 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:34890 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729441AbgB0UD5 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 27 Feb 2020 15:03:57 -0500
Received: by mail-pj1-f68.google.com with SMTP id q39so255960pjc.0
        for <linux-csky@vger.kernel.org>; Thu, 27 Feb 2020 12:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2WBG2RTr0qjTefzGTgfeJN1oG1HTTmoJ+yNPM/A6T10=;
        b=l8ZXOsYvG5faDbzB6+SADiSTbHsop8RnEdbFCEQh5/bOP8yBUa+XbvWAtvPk5qH8uH
         9zcRSqcn15d8RNblNSs17FJMKJwN7V0Hxgdq9f/V6I8FFR9RWuALTzMN22bgk2JdnHDJ
         w6ILVZIM9S1pWBihQzKBWn3u8d8i2OcOTUOfRyi6PpYOviTjcw+M367ejppTCbXPZeee
         EARhTKVXvvQhJfD4ohw+LMAnjTv25O2n586VceIl/xexvefHQTwq1Rk4u+sE7m47Zkb3
         2aF7zvhksEysO1AOUG+jRpxXh8PdOKHgsnqmztbGE/H0WPXUttbgctvQCK+t3S6t+k5q
         PVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2WBG2RTr0qjTefzGTgfeJN1oG1HTTmoJ+yNPM/A6T10=;
        b=enAkUE9TCxgHUZHI8i+0tt8oDMtG1UdLtS2uLftgW7T+81pc1IDRLQxpNmrfkNRTnl
         7u2h797LVsN4/vYMm8DpuDRzE2n0jm24qbbBvsvsgILNdPbwCqpYIeRSeZTqlykfa/Mn
         /E2K5fjrZcLrjivkaFyZwr8vVNcAQpC42SKWEPPszUiWZiGSsonWB7JJbH0E5xkjFrxc
         20DgINQoWMAd6OeAx0VBHxXhUP44B9On1P6kKYN3Ahk5yXC23nWqZaCefjt06Z9GqmUr
         INliVvgSigrxQb1nWFC7JyZHg+YKo3R7VSSqEtuvKMug5JX1Zwfot0chxFh4oQ4VYmQz
         qLyQ==
X-Gm-Message-State: APjAAAXhauHrO6E7waPhqkQCf8MxXUGhl05P6Xo/+nBVhD49CgjklWQD
        IVtWb57b+X08stWZzj8b+TxV6A==
X-Google-Smtp-Source: APXvYqyyoR6u4iTvjBo3zec75zYzVUCXcFwHVh61O+y1jSA18KzXIJdckFBffqPn4HAigPtdkybDqg==
X-Received: by 2002:a17:902:504:: with SMTP id 4mr403983plf.276.1582833835735;
        Thu, 27 Feb 2020 12:03:55 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
        by smtp.gmail.com with ESMTPSA id x4sm8341657pff.143.2020.02.27.12.03.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 12:03:55 -0800 (PST)
Subject: Re: [PATCH v4 4/5] target/riscv: add fault-only-first unit stride
 load
To:     LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
        chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-5-zhiwei_liu@c-sky.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2b7d7af1-61ee-edf6-5e57-1108428f920c@linaro.org>
Date:   Thu, 27 Feb 2020 12:03:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225103508.7651-5-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 2/25/20 2:35 AM, LIU Zhiwei wrote:
> +GEN_VEXT_LD_ELEM(vlbff_v_b, int8_t,  int8_t,  H1, ldsb)
> +GEN_VEXT_LD_ELEM(vlbff_v_h, int8_t,  int16_t, H2, ldsb)
> +GEN_VEXT_LD_ELEM(vlbff_v_w, int8_t,  int32_t, H4, ldsb)
> +GEN_VEXT_LD_ELEM(vlbff_v_d, int8_t,  int64_t, H8, ldsb)
> +GEN_VEXT_LD_ELEM(vlhff_v_h, int16_t, int16_t, H2, ldsw)
> +GEN_VEXT_LD_ELEM(vlhff_v_w, int16_t, int32_t, H4, ldsw)
> +GEN_VEXT_LD_ELEM(vlhff_v_d, int16_t, int64_t, H8, ldsw)
> +GEN_VEXT_LD_ELEM(vlwff_v_w, int32_t, int32_t, H4, ldl)
> +GEN_VEXT_LD_ELEM(vlwff_v_d, int32_t, int64_t, H8, ldl)
> +GEN_VEXT_LD_ELEM(vleff_v_b, int8_t,  int8_t,  H1, ldsb)
> +GEN_VEXT_LD_ELEM(vleff_v_h, int16_t, int16_t, H2, ldsw)
> +GEN_VEXT_LD_ELEM(vleff_v_w, int32_t, int32_t, H4, ldl)
> +GEN_VEXT_LD_ELEM(vleff_v_d, int64_t, int64_t, H8, ldq)
> +GEN_VEXT_LD_ELEM(vlbuff_v_b, uint8_t,  uint8_t,  H1, ldub)
> +GEN_VEXT_LD_ELEM(vlbuff_v_h, uint8_t,  uint16_t, H2, ldub)
> +GEN_VEXT_LD_ELEM(vlbuff_v_w, uint8_t,  uint32_t, H4, ldub)
> +GEN_VEXT_LD_ELEM(vlbuff_v_d, uint8_t,  uint64_t, H8, ldub)
> +GEN_VEXT_LD_ELEM(vlhuff_v_h, uint16_t, uint16_t, H2, lduw)
> +GEN_VEXT_LD_ELEM(vlhuff_v_w, uint16_t, uint32_t, H4, lduw)
> +GEN_VEXT_LD_ELEM(vlhuff_v_d, uint16_t, uint64_t, H8, lduw)
> +GEN_VEXT_LD_ELEM(vlwuff_v_w, uint32_t, uint32_t, H4, ldl)
> +GEN_VEXT_LD_ELEM(vlwuff_v_d, uint32_t, uint64_t, H8, ldl)

We definitely should not have a 3rd copy of these.


> +        if (i == 0) {
> +            probe_read_access(env, addr, nf * msz, ra);
> +        } else {
> +            /* if it triggles an exception, no need to check watchpoint */

triggers.

> +            offset = -(addr | TARGET_PAGE_MASK);
> +            remain = nf * msz;
> +            while (remain > 0) {
> +                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmuidx);
> +                if (host) {
> +#ifdef CONFIG_USER_ONLY
> +                    if (page_check_range(addr, nf * msz, PAGE_READ) < 0) {
> +                        vl = i;
> +                        goto ProbeSuccess;
> +                    }
> +#else
> +                    probe_read_access(env, addr, nf * msz, ra);
> +#endif

Good job finding all of the corner cases.  I should invent a new cputlb
function that handles this better.  For now, this is the best we can do.


r~
