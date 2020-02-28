Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3254D1730ED
	for <lists+linux-csky@lfdr.de>; Fri, 28 Feb 2020 07:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgB1GT3 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 28 Feb 2020 01:19:29 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:32905 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgB1GT3 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Fri, 28 Feb 2020 01:19:29 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1877446|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.466779-0.0217452-0.511476;DS=CONTINUE|ham_regular_dialog|0.423602-0.000318491-0.57608;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03293;MF=zhiwei_liu@c-sky.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.GtZudvR_1582870761;
Received: from 192.168.43.249(mailfrom:zhiwei_liu@c-sky.com fp:SMTPD_---.GtZudvR_1582870761)
          by smtp.aliyun-inc.com(10.147.41.120);
          Fri, 28 Feb 2020 14:19:22 +0800
Subject: Re: [PATCH v3 1/1] target/riscv: add vector integer operations
To:     Richard Henderson <richard.henderson@linaro.org>,
        alistair23@gmail.com, chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
References: <20200226024352.7719-1-zhiwei_liu@c-sky.com>
 <d47523ad-52e3-b0a8-a47d-c91442fbe48d@linaro.org>
From:   LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <e25d6bea-65ae-2cfc-906e-f149f4c200b7@c-sky.com>
Date:   Fri, 28 Feb 2020 14:19:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <d47523ad-52e3-b0a8-a47d-c91442fbe48d@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org



On 2020/2/28 13:46, Richard Henderson wrote:
> On 2/25/20 6:43 PM, LIU Zhiwei wrote:
>> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
>> ---
>>   target/riscv/helper.h                   |  395 +++++++
>>   target/riscv/insn32.decode              |  127 +++
>>   target/riscv/insn_trans/trans_rvv.inc.c |  671 +++++++++++-
>>   target/riscv/vector_helper.c            | 1308 ++++++++++++++++++++++-
>>   4 files changed, 2462 insertions(+), 39 deletions(-)
> This patch is too large and needs splitting.
OK.
>> -static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm)
>> +static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm,
>> +    bool widen)
>>   {
>> -    return !(s->lmul > 1 && vm == 0 && vd == 0);
>> +    return (vm != 0 || vd != 0) ? true : (!widen && (s->lmul == 0));
>>   }
>>   
> Best to move the addition of widen back to the patch that introduced this function.
>
> The "? true :" is a funny way to write ||.
Oh yes. I did not notice it.
>
> r~

