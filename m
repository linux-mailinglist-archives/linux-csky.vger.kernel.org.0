Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6CF1728C2
	for <lists+linux-csky@lfdr.de>; Thu, 27 Feb 2020 20:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729833AbgB0Tgp (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 27 Feb 2020 14:36:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42075 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbgB0Tgp (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 27 Feb 2020 14:36:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id u3so198968plr.9
        for <linux-csky@vger.kernel.org>; Thu, 27 Feb 2020 11:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RR7Rmmcf+FIgzkY0kiQKmj0flCfQOy2YCZTrv/2dkWE=;
        b=pxIXBzLoXb0v69ORAB1R6HPunPvUDVaRFjPJUZp/gcNEdOKoYd9NJdO1NbcRf3Xh6r
         mZn2+2XO15tQ/YhGa1YOTAYNmjb1tRcEiTezyI69EV+uw2ABdwnnOrIey/f9SXyq5DZq
         dJD5JGjaPVkPHJ43y68tCXWsj32CzgXBYw/YqjiWen6CrOIVhtsLiQ++XdyxTEZwRu+i
         1PvLoF2tIgG0feADCv8rjjcpskFm+5mRGZZCHVNe2rhpdxvJAMiU5/tN+CaXKMnf98Zl
         Wgb8fHvPM3Xi9LjvtCNB/GbjTKsJjjffDawiM9TQxAMgzN0kpWhe8rrA9FbJLGCrk1A9
         hRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RR7Rmmcf+FIgzkY0kiQKmj0flCfQOy2YCZTrv/2dkWE=;
        b=cW7bdUopHNgXa/p4QkzwEnVceNyPdVoR/+V6Z446wtLnGddvBkRKs/5CgblDN60ufi
         XytzsfaZuT9kehTvb0BFfXaXyjdwhMxsJbquD4c6+zYSrB7nvkVvs0R3gNDVnowBFj4a
         2janb1YN9T0Za/Xx2iAc+fzP3NiXtW6VrNjJNAddMoBlXgUyakryBlrBbZ/vlitAucid
         qhDf/V3V5a8rltQtcT7fZxK7RT8eTmDYckyml78DtxvEwrTZBxD49FwaGnEThOxKvZyc
         vwMJPo7NsetIJ5Cn6kHvzZmz5yHDD2rHpaodM0cchAjSdV0Eaa0ajQLhMbolgSmHj3na
         gxFg==
X-Gm-Message-State: APjAAAX8lrJprEIL76qWH0UXGSd5/ZmR5FtfeVsoIsYJMea/Q0v0r9oF
        Ijmlm1p2ob8K3l4wsSQB8H6tmQ==
X-Google-Smtp-Source: APXvYqx7Pzed3kqw3CzPRyLvp/Z6N7kxHXzr7DRK3TC8BNiTn4RW45cVAWOL+W/UokvdAlSflaH9hA==
X-Received: by 2002:a17:902:463:: with SMTP id 90mr335342ple.213.1582832204463;
        Thu, 27 Feb 2020 11:36:44 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
        by smtp.gmail.com with ESMTPSA id w189sm7896561pfw.157.2020.02.27.11.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 11:36:43 -0800 (PST)
Subject: Re: [PATCH v4 2/5] target/riscv: add vector stride load and store
 instructions
To:     LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
        chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-3-zhiwei_liu@c-sky.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0e806ca9-7991-baf7-58d1-50cddf9ce4ef@linaro.org>
Date:   Thu, 27 Feb 2020 11:36:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225103508.7651-3-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 2/25/20 2:35 AM, LIU Zhiwei wrote:
> +GEN_VEXT_LD_ELEM(vlsb_v_b, int8_t,  int8_t,  H1, ldsb)
> +GEN_VEXT_LD_ELEM(vlsb_v_h, int8_t,  int16_t, H2, ldsb)
> +GEN_VEXT_LD_ELEM(vlsb_v_w, int8_t,  int32_t, H4, ldsb)
> +GEN_VEXT_LD_ELEM(vlsb_v_d, int8_t,  int64_t, H8, ldsb)
> +GEN_VEXT_LD_ELEM(vlsh_v_h, int16_t, int16_t, H2, ldsw)
> +GEN_VEXT_LD_ELEM(vlsh_v_w, int16_t, int32_t, H4, ldsw)
> +GEN_VEXT_LD_ELEM(vlsh_v_d, int16_t, int64_t, H8, ldsw)
> +GEN_VEXT_LD_ELEM(vlsw_v_w, int32_t, int32_t, H4, ldl)
> +GEN_VEXT_LD_ELEM(vlsw_v_d, int32_t, int64_t, H8, ldl)
> +GEN_VEXT_LD_ELEM(vlse_v_b, int8_t,  int8_t,  H1, ldsb)
> +GEN_VEXT_LD_ELEM(vlse_v_h, int16_t, int16_t, H2, ldsw)
> +GEN_VEXT_LD_ELEM(vlse_v_w, int32_t, int32_t, H4, ldl)
> +GEN_VEXT_LD_ELEM(vlse_v_d, int64_t, int64_t, H8, ldq)
> +GEN_VEXT_LD_ELEM(vlsbu_v_b, uint8_t,  uint8_t,  H1, ldub)
> +GEN_VEXT_LD_ELEM(vlsbu_v_h, uint8_t,  uint16_t, H2, ldub)
> +GEN_VEXT_LD_ELEM(vlsbu_v_w, uint8_t,  uint32_t, H4, ldub)
> +GEN_VEXT_LD_ELEM(vlsbu_v_d, uint8_t,  uint64_t, H8, ldub)
> +GEN_VEXT_LD_ELEM(vlshu_v_h, uint16_t, uint16_t, H2, lduw)
> +GEN_VEXT_LD_ELEM(vlshu_v_w, uint16_t, uint32_t, H4, lduw)
> +GEN_VEXT_LD_ELEM(vlshu_v_d, uint16_t, uint64_t, H8, lduw)
> +GEN_VEXT_LD_ELEM(vlswu_v_w, uint32_t, uint32_t, H4, ldl)
> +GEN_VEXT_LD_ELEM(vlswu_v_d, uint32_t, uint64_t, H8, ldl)

Why do you need to define new functions identical to the old ones?  Are you
doing this just to make the names match up?


> +GEN_VEXT_ST_ELEM(vssb_v_b, int8_t,  H1, stb)
> +GEN_VEXT_ST_ELEM(vssb_v_h, int16_t, H2, stb)
> +GEN_VEXT_ST_ELEM(vssb_v_w, int32_t, H4, stb)
> +GEN_VEXT_ST_ELEM(vssb_v_d, int64_t, H8, stb)
> +GEN_VEXT_ST_ELEM(vssh_v_h, int16_t, H2, stw)
> +GEN_VEXT_ST_ELEM(vssh_v_w, int32_t, H4, stw)
> +GEN_VEXT_ST_ELEM(vssh_v_d, int64_t, H8, stw)
> +GEN_VEXT_ST_ELEM(vssw_v_w, int32_t, H4, stl)
> +GEN_VEXT_ST_ELEM(vssw_v_d, int64_t, H8, stl)
> +GEN_VEXT_ST_ELEM(vsse_v_b, int8_t,  H1, stb)
> +GEN_VEXT_ST_ELEM(vsse_v_h, int16_t, H2, stw)
> +GEN_VEXT_ST_ELEM(vsse_v_w, int32_t, H4, stl)
> +GEN_VEXT_ST_ELEM(vsse_v_d, int64_t, H8, stq)

Likewise.

> +static void vext_st_stride(void *vd, void *v0, target_ulong base,
> +        target_ulong stride, CPURISCVState *env, uint32_t desc,
> +        vext_st_elem_fn st_elem, uint32_t esz, uint32_t msz, uintptr_t ra)
> +{
> +    uint32_t i, k;
> +    uint32_t nf = vext_nf(desc);
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t mlen = vext_mlen(desc);
> +    uint32_t vlmax = vext_maxsz(desc) / esz;
> +
> +    /* probe every access*/
> +    for (i = 0; i < env->vl; i++) {
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
> +            continue;
> +        }
> +        probe_write_access(env, base + stride * i, nf * msz, ra);
> +    }
> +    /* store bytes to guest memory */
> +    for (i = 0; i < env->vl; i++) {
> +        k = 0;
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
> +            continue;
> +        }
> +        while (k < nf) {
> +            target_ulong addr = base + stride * i + k * msz;
> +            st_elem(env, addr, i + k * vlmax, vd, ra);
> +            k++;
> +        }
> +    }
> +}

Similar comments wrt unifying the load and store helpers.

I'll also note that vext_st_stride and vext_st_us_mask could be unified by
passing sizeof(ETYPE) as stride, and vm = true as a parameter.


r~
