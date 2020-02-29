Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E854174705
	for <lists+linux-csky@lfdr.de>; Sat, 29 Feb 2020 14:16:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgB2NQ1 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 29 Feb 2020 08:16:27 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33673 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726944AbgB2NQ1 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Sat, 29 Feb 2020 08:16:27 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07439639|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.420502-0.00878351-0.570714;DS=CONTINUE|ham_regular_dialog|0.0798981-0.00281304-0.917289;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03299;MF=zhiwei_liu@c-sky.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.Gu9hB46_1582982174;
Received: from 30.0.153.10(mailfrom:zhiwei_liu@c-sky.com fp:SMTPD_---.Gu9hB46_1582982174)
          by smtp.aliyun-inc.com(10.147.41.187);
          Sat, 29 Feb 2020 21:16:14 +0800
Subject: Re: [PATCH v4 5/5] target/riscv: add vector amo operations
To:     Richard Henderson <richard.henderson@linaro.org>,
        alistair23@gmail.com, chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-6-zhiwei_liu@c-sky.com>
 <03bf483e-d6bb-9de4-9934-12bfa7093ad3@linaro.org>
 <6d008841-4356-b0f1-ece2-df8323ad8254@c-sky.com>
 <a3a614d1-aa54-046b-2c14-b6e517f1fbf0@linaro.org>
From:   LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <11e36778-50c8-64a9-35ab-bb3e2bdeb92e@c-sky.com>
Date:   Sat, 29 Feb 2020 21:16:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <a3a614d1-aa54-046b-2c14-b6e517f1fbf0@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org



On 2020/2/29 2:46, Richard Henderson wrote:
> On 2/28/20 1:19 AM, LIU Zhiwei wrote:
>>>> +#define GEN_VEXT_AMO_NOATOMIC_OP(NAME, ETYPE, MTYPE, H, DO_OP, SUF)      \
>>>> +static void vext_##NAME##_noatomic_op(void *vs3, target_ulong addr,      \
>>>> +        uint32_t wd, uint32_t idx, CPURISCVState *env, uintptr_t retaddr)\
>>>> +{                                                                        \
>>>> +    ETYPE ret;                                                           \
>>>> +    target_ulong tmp;                                                    \
>>>> +    int mmu_idx = cpu_mmu_index(env, false);                             \
>>>> +    tmp = cpu_ld##SUF##_mmuidx_ra(env, addr, mmu_idx, retaddr);          \
>>>> +    ret = DO_OP((ETYPE)(MTYPE)tmp, *((ETYPE *)vs3 + H(idx)));            \
>>>> +    cpu_st##SUF##_mmuidx_ra(env, addr, ret, mmu_idx, retaddr);           \
>>>> +    if (wd) {                                                            \
>>>> +        *((ETYPE *)vs3 + H(idx)) = (target_long)(MTYPE)tmp;              \
>>> The target_long cast is wrong; should be ETYPE.
>> "If the AMO memory element width is less than SEW, the value returned from memory
>>   is sign-extended to fill SEW"
>>
>> So just use (target_long) to sign-extended. As you see, instructions like
>>
>> vamominud
>>
>> have the uint64_t as ETYPE.  And it can't sign-extend the value from memory by
>> (ETYPE)(MTYPE)tmp.
> Casting to target_long doesn't help -- it becomes signed at a variable size,
> possibly larger than MTYPE.
>
> In addition, I think you're performing the operation at the wrong length.
>   The
> text of the ISA document could be clearer, but
>
>    # If SEW > 32 bits, the value returned from memory
>    # is sign-extended to fill SEW.
>
> You are performing the operation in ETYPE, but it should be done in MTYPE and
> only afterward extended to ETYPE.
Yes, I  made a mistake.It should be MTYPE.
> For minu/maxu, you're right that you need an unsigned for the operation.  But
> then you need a signed type of the same width for the extension.
>
> One possibility is to *always* make MTYPE a signed type, but for the two cases
> that require an unsigned type, provide it.  E.g.
>
> #define GEN_VEXT_AMO_NOATOMIC_OP(NAME, ESZ, MSZ, H, DO_OP, SUF)
> static void vext_##NAME##_noatomic_op(void *vs3,
>      target_ulong addr, uint32_t wd, uint32_t idx,
>      CPURISCVState *env, uintptr_t retaddr)
> {
>      typedef int##ESZ##_t ETYPE;
>      typedef int##MSZ##_t MTYPE;
>      typedef uint##MSZ##_t UMTYPE;
>      ETYPE *pe3 = (ETYPE *)vs3 + H(idx);
>      MTYPE a = *pe3, b = cpu_ld##SUF##_data(env, addr);
>      a = DO_OP(a, b);
>      cpu_st##SUF##_data(env, addr, a);
>      if (wd) {
>          *pe3 = a;
>      }
> }
>
> /* Signed min/max */
> #define DO_MAX(N, M)  ((N) >= (M) ? (N) : (M))
> #define DO_MIN(N, M)  ((N) >= (M) ? (M) : (N))
>
> /* Unsigned min/max */
> #define DO_MAXU(N, M) DO_MAX((UMTYPE)N, (UMTYPE)M)
> #define DO_MINU(N, M) DO_MIN((UMTYPE)N, (UMTYPE)M)
>
> GEN_VEXT_AMO_NOATOMIC_OP(vamomaxuw_v_d, 64, 32, H8, DO_MAXU, l)
> GEN_VEXT_AMO_NOATOMIC_OP(vamomaxud_v_d, 64, 64, H8, DO_MAXU, q)
Perfect. I will try it.

>
>>> The missing aligned address check is the only remaining exception that the
>>> helper_atomic_* functions would raise, since you have properly checked for
>>> read+write.  So it might be possible to get away with using the helpers, but I
>>> don't like it.
>> Do you mean write my own helpers to implement atomic operations?
>>
>> What's the meaning of " but I don't like it. "?
> I don't like re-using helpers in an incorrect way.
>
>>> But I do think it would be better to write your own helpers for the atomic
>>> paths.  They need not check quite so much, since we have already done the
>>> validation above.  You pretty much only need to use tlb_vaddr_to_host.
>>>
>>> If that gets too ugly, we can talk about rearranging
>>> accel/tcg/atomic_template.h so that it could be reused.
>> Good idea.  Perhaps use tlb_vaddr_to_host instead of atomic_mmu_lookup
>> to define another macro like GEN_ATOMIC_HELPER?
>>> Alternately, we could simply *always* use the non-atomic helpers, and raise
>>> exit_atomic if PARALLEL.
>> Yes, it's the simplest way.
>> However I prefer try to define something like GEN_ATOMIC_HELPER in
>> vector_helper.c.
> I'll think about this some more.
> In the short-term, I think non-atomic is the best we can do.
I will accept your advice. Thanks.

Best Regards,
Zhiwei
>
> r~

