Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEB2F17CBEB
	for <lists+linux-csky@lfdr.de>; Sat,  7 Mar 2020 05:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgCGE3q (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 6 Mar 2020 23:29:46 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:47526 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726368AbgCGE3p (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 6 Mar 2020 23:29:45 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07448132|-1;CH=green;DM=||false|;DS=CONTINUE|ham_regular_dialog|0.0308801-0.000130499-0.968989;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16378;MF=zhiwei_liu@c-sky.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.GxPv1Mv_1583555381;
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com fp:SMTPD_---.GxPv1Mv_1583555381)
          by smtp.aliyun-inc.com(10.147.41.138);
          Sat, 07 Mar 2020 12:29:42 +0800
Subject: Re: [PATCH v4 2/5] target/riscv: add vector stride load and store
 instructions
To:     Richard Henderson <richard.henderson@linaro.org>,
        alistair23@gmail.com, chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-3-zhiwei_liu@c-sky.com>
 <0e806ca9-7991-baf7-58d1-50cddf9ce4ef@linaro.org>
From:   LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <3257fc99-8c07-550d-151e-0f88ab46840d@c-sky.com>
Date:   Sat, 7 Mar 2020 12:29:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <0e806ca9-7991-baf7-58d1-50cddf9ce4ef@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org



On 2020/2/28 3:36, Richard Henderson wrote:
> On 2/25/20 2:35 AM, LIU Zhiwei wrote:
>> +GEN_VEXT_LD_ELEM(vlsb_v_b, int8_t,  int8_t,  H1, ldsb)
>> +GEN_VEXT_LD_ELEM(vlsb_v_h, int8_t,  int16_t, H2, ldsb)
>> +GEN_VEXT_LD_ELEM(vlsb_v_w, int8_t,  int32_t, H4, ldsb)
>> +GEN_VEXT_LD_ELEM(vlsb_v_d, int8_t,  int64_t, H8, ldsb)
>> +GEN_VEXT_LD_ELEM(vlsh_v_h, int16_t, int16_t, H2, ldsw)
>> +GEN_VEXT_LD_ELEM(vlsh_v_w, int16_t, int32_t, H4, ldsw)
>> +GEN_VEXT_LD_ELEM(vlsh_v_d, int16_t, int64_t, H8, ldsw)
>> +GEN_VEXT_LD_ELEM(vlsw_v_w, int32_t, int32_t, H4, ldl)
>> +GEN_VEXT_LD_ELEM(vlsw_v_d, int32_t, int64_t, H8, ldl)
>> +GEN_VEXT_LD_ELEM(vlse_v_b, int8_t,  int8_t,  H1, ldsb)
>> +GEN_VEXT_LD_ELEM(vlse_v_h, int16_t, int16_t, H2, ldsw)
>> +GEN_VEXT_LD_ELEM(vlse_v_w, int32_t, int32_t, H4, ldl)
>> +GEN_VEXT_LD_ELEM(vlse_v_d, int64_t, int64_t, H8, ldq)
>> +GEN_VEXT_LD_ELEM(vlsbu_v_b, uint8_t,  uint8_t,  H1, ldub)
>> +GEN_VEXT_LD_ELEM(vlsbu_v_h, uint8_t,  uint16_t, H2, ldub)
>> +GEN_VEXT_LD_ELEM(vlsbu_v_w, uint8_t,  uint32_t, H4, ldub)
>> +GEN_VEXT_LD_ELEM(vlsbu_v_d, uint8_t,  uint64_t, H8, ldub)
>> +GEN_VEXT_LD_ELEM(vlshu_v_h, uint16_t, uint16_t, H2, lduw)
>> +GEN_VEXT_LD_ELEM(vlshu_v_w, uint16_t, uint32_t, H4, lduw)
>> +GEN_VEXT_LD_ELEM(vlshu_v_d, uint16_t, uint64_t, H8, lduw)
>> +GEN_VEXT_LD_ELEM(vlswu_v_w, uint32_t, uint32_t, H4, ldl)
>> +GEN_VEXT_LD_ELEM(vlswu_v_d, uint32_t, uint64_t, H8, ldl)
> Why do you need to define new functions identical to the old ones?  Are you
> doing this just to make the names match up?
>
>
>> +GEN_VEXT_ST_ELEM(vssb_v_b, int8_t,  H1, stb)
>> +GEN_VEXT_ST_ELEM(vssb_v_h, int16_t, H2, stb)
>> +GEN_VEXT_ST_ELEM(vssb_v_w, int32_t, H4, stb)
>> +GEN_VEXT_ST_ELEM(vssb_v_d, int64_t, H8, stb)
>> +GEN_VEXT_ST_ELEM(vssh_v_h, int16_t, H2, stw)
>> +GEN_VEXT_ST_ELEM(vssh_v_w, int32_t, H4, stw)
>> +GEN_VEXT_ST_ELEM(vssh_v_d, int64_t, H8, stw)
>> +GEN_VEXT_ST_ELEM(vssw_v_w, int32_t, H4, stl)
>> +GEN_VEXT_ST_ELEM(vssw_v_d, int64_t, H8, stl)
>> +GEN_VEXT_ST_ELEM(vsse_v_b, int8_t,  H1, stb)
>> +GEN_VEXT_ST_ELEM(vsse_v_h, int16_t, H2, stw)
>> +GEN_VEXT_ST_ELEM(vsse_v_w, int32_t, H4, stl)
>> +GEN_VEXT_ST_ELEM(vsse_v_d, int64_t, H8, stq)
> Likewise.
>
>> +static void vext_st_stride(void *vd, void *v0, target_ulong base,
>> +        target_ulong stride, CPURISCVState *env, uint32_t desc,
>> +        vext_st_elem_fn st_elem, uint32_t esz, uint32_t msz, uintptr_t ra)
>> +{
>> +    uint32_t i, k;
>> +    uint32_t nf = vext_nf(desc);
>> +    uint32_t vm = vext_vm(desc);
>> +    uint32_t mlen = vext_mlen(desc);
>> +    uint32_t vlmax = vext_maxsz(desc) / esz;
>> +
>> +    /* probe every access*/
>> +    for (i = 0; i < env->vl; i++) {
>> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
>> +            continue;
>> +        }
>> +        probe_write_access(env, base + stride * i, nf * msz, ra);
>> +    }
>> +    /* store bytes to guest memory */
>> +    for (i = 0; i < env->vl; i++) {
>> +        k = 0;
>> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
>> +            continue;
>> +        }
>> +        while (k < nf) {
>> +            target_ulong addr = base + stride * i + k * msz;
>> +            st_elem(env, addr, i + k * vlmax, vd, ra);
>> +            k++;
>> +        }
>> +    }
>> +}
> Similar comments wrt unifying the load and store helpers.
>
> I'll also note that vext_st_stride and vext_st_us_mask could be unified by
> passing sizeof(ETYPE) as stride, and vm = true as a parameter.
Maybe it is msz * nf as stride.

For element index  i,  the base load memory address for stride load is 
"i * stride".
For unit stride load ,  the base load memory address is "i * nf * msz".

Zhiwei
>
> r~

