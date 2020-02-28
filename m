Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7627B1730EA
	for <lists+linux-csky@lfdr.de>; Fri, 28 Feb 2020 07:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgB1GRE (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 28 Feb 2020 01:17:04 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:34517 "EHLO
        smtp2200-217.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbgB1GRE (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Fri, 28 Feb 2020 01:17:04 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1105056|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.668689-0.00268013-0.328631;DS=CONTINUE|ham_system_inform|0.01643-0.000390589-0.983179;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03309;MF=zhiwei_liu@c-sky.com;NM=1;PH=DS;RN=9;RT=9;SR=0;TI=SMTPD_---.GtZaCA3_1582870620;
Received: from 192.168.43.249(mailfrom:zhiwei_liu@c-sky.com fp:SMTPD_---.GtZaCA3_1582870620)
          by smtp.aliyun-inc.com(10.147.44.145);
          Fri, 28 Feb 2020 14:17:01 +0800
Subject: Re: [PATCH v4 1/5] target/riscv: add vector unit stride load and
 store instructions
To:     Richard Henderson <richard.henderson@linaro.org>,
        alistair23@gmail.com, chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-2-zhiwei_liu@c-sky.com>
 <4cfb56d6-34a5-0e35-87a0-2aefaafa4221@linaro.org>
 <287bde05-421c-f49c-2404-fdee183c9e12@c-sky.com>
 <10e50ea8-7614-f094-a827-38ed09462f29@linaro.org>
From:   LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <30622566-09d2-17b6-edc1-8726dce8cbd8@c-sky.com>
Date:   Fri, 28 Feb 2020 14:16:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <10e50ea8-7614-f094-a827-38ed09462f29@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org



On 2020/2/28 11:33, Richard Henderson wrote:
> On 2/27/20 5:50 PM, LIU Zhiwei wrote:
>>> This is not what I had in mind, and looks wrong as well.
>>>
>>>      int idx = (index * mlen) / 64;
>>>      int pos = (index * mlen) % 64;
>>>      return (((uint64_t *)v0)[idx] >> pos) & 1;
>>>
>>> You also might consider passing log2(mlen), so the multiplication could be
>>> strength-reduced to a shift.
>> I don't think so. For example, when mlen is 8 bits and index is 0, it will
>> reduce to
>>
>> return (((uint64_t *)v0)[0]) & 1
>>
>> And it's not right.
>>
>> The right bit is first bit in vector register 0. And in host big endianess,
>> it will be  the first bit of the seventh byte.
> You've forgotten that we've just done an 8-byte big-endian load, which means
> that we *are* looking at the first bit of the byte at offset 7.
>
> It is right.
Yes, that's it.
>   
>>> You don't need to pass mlen, since it's
>> Yes.
> I finally remembered all of the bits that go into mlen and thought I had
> deleted that sentence -- apparently I only removed half.  ;-)
>
>
> r~

