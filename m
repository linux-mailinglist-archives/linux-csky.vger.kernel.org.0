Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0D6172EA6
	for <lists+linux-csky@lfdr.de>; Fri, 28 Feb 2020 03:13:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730445AbgB1CNZ (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 27 Feb 2020 21:13:25 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44828 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730343AbgB1CNZ (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Thu, 27 Feb 2020 21:13:25 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1120611|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.14291-0.0101709-0.846919;DS=CONTINUE|ham_system_inform|0.0302222-0.00325334-0.966524;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03310;MF=zhiwei_liu@c-sky.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.GtTcBTv_1582855997;
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com fp:SMTPD_---.GtTcBTv_1582855997)
          by smtp.aliyun-inc.com(10.147.43.95);
          Fri, 28 Feb 2020 10:13:18 +0800
Subject: Re: [PATCH v4 3/5] target/riscv: add vector index load and store
 instructions
To:     Richard Henderson <richard.henderson@linaro.org>,
        alistair23@gmail.com, chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-4-zhiwei_liu@c-sky.com>
 <30ac8dcd-a6d4-b4d6-212c-6819f914bd21@linaro.org>
From:   LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <fa363f84-33cd-5ca6-a3c7-383462665e84@c-sky.com>
Date:   Fri, 28 Feb 2020 10:13:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <30ac8dcd-a6d4-b4d6-212c-6819f914bd21@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org



On 2020/2/28 3:49, Richard Henderson wrote:
> On 2/25/20 2:35 AM, LIU Zhiwei wrote:
>> +vsxb_v     ... 011 . ..... ..... 000 ..... 0100111 @r_nfvm
>> +vsxh_v     ... 011 . ..... ..... 101 ..... 0100111 @r_nfvm
>> +vsxw_v     ... 011 . ..... ..... 110 ..... 0100111 @r_nfvm
>> +vsxe_v     ... 011 . ..... ..... 111 ..... 0100111 @r_nfvm
>> +vsuxb_v    ... 111 . ..... ..... 000 ..... 0100111 @r_nfvm
>> +vsuxh_v    ... 111 . ..... ..... 101 ..... 0100111 @r_nfvm
>> +vsuxw_v    ... 111 . ..... ..... 110 ..... 0100111 @r_nfvm
>> +vsuxe_v    ... 111 . ..... ..... 111 ..... 0100111 @r_nfvm
> These can be merged, with a comment, like
>
> # Vector ordered-indexed and unordered-indexed store insns.
> vsxb_v     ... -11 . ..... ..... 000 ..... 0100111 @r_nfvm
>
> which means you don't need these:
Good.
>> +static bool trans_vsuxb_v(DisasContext *s, arg_rnfvm* a)
>> +{
>> +    return trans_vsxb_v(s, a);
>> +}
>> +
>> +static bool trans_vsuxh_v(DisasContext *s, arg_rnfvm* a)
>> +{
>> +    return trans_vsxh_v(s, a);
>> +}
>> +
>> +static bool trans_vsuxw_v(DisasContext *s, arg_rnfvm* a)
>> +{
>> +    return trans_vsxw_v(s, a);
>> +}
>> +
>> +static bool trans_vsuxe_v(DisasContext *s, arg_rnfvm* a)
>> +{
>> +    return trans_vsxe_v(s, a);
>> +}
>> +static inline void vext_ld_index(void *vd, void *v0, target_ulong base,
>> +        void *vs2, CPURISCVState *env, uint32_t desc,
>> +        vext_get_index_addr get_index_addr,
>> +        vext_ld_elem_fn ld_elem,
>> +        vext_ld_clear_elem clear_elem,
>> +        uint32_t esz, uint32_t msz, uintptr_t ra)
> Similar comment about merging vext_ld_index and vext_st_index.
Good idea. Thanks.

Zhiwei
>
> r~

