Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7BF172F5A
	for <lists+linux-csky@lfdr.de>; Fri, 28 Feb 2020 04:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730638AbgB1Ddp (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 27 Feb 2020 22:33:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46319 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730630AbgB1Ddp (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 27 Feb 2020 22:33:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so655990pll.13
        for <linux-csky@vger.kernel.org>; Thu, 27 Feb 2020 19:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f1HUTfjWI/l8GIJRRF8yHhG7QeUn+lrCOnpteX95pLM=;
        b=RBSq1GfRIRYFjHSaxXmwbNoRSaYnW936lY57A8kboKcwYNRtNQmQlh878l2gxT/GGp
         LCXxZ4VlY8yWyyVyqq564hAs2b3pHd133KjJ7rNAskFe3W3d+O7f5RbbHCHf55pSJRP8
         AGAQ/2ZWoISimiQ3KN9WIutydHQSEaJTyjq4ZUzD+f+GRtIGY7RH5re0RGbFWwvxgXbb
         27g4S845JR5Wo0rJUZ+CClDNrkc/+bSW+uTv0SIzb4QLzHmNh1Nv13O0FeHSRnjm5tzW
         TZpEWn1gxGLxlPwUwieRxF7m/Xlq3W72oGMmQ6VcvTp0/RdbEyL10gWDQXSReUwlOgDD
         r/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f1HUTfjWI/l8GIJRRF8yHhG7QeUn+lrCOnpteX95pLM=;
        b=nYbrWMjDvnnUp3ItaDwt7jFVvFEoQHEcnV6xux4zP9Uix+FFTifzr6ZFHzPcCF1c4Y
         U6OT76lSMYIYfW1Cb1AjQFIjbkxML0uV7s4qMKhUCN6KFJVx1vfvWkBrV8DlqcmH9zOz
         xdVBIr1ccKSwdG+r/AKE4zHWZTfcDf9XdVeaDcFla2olAEasAaW22bERKKz2MriQhxs1
         irb0jj7S43r7//lf0rmjxk/623Zi1YmP9JpK56OjHP+iV5Y8X17qMM1SC62v04Ljj6gX
         i61EOAgXNLOB7Uwcy71V3RbPXj+sa2X2Z7H6vO6KqcZXZxxmyvpQJOAExSeB9mJ/2nyI
         CREA==
X-Gm-Message-State: APjAAAUIot2rlOk1tS2aKchjvoVUrSmcTjWla2WmKfEUjGmXCIioYS3m
        Yy5Jhh/YuWmIkgg7vZkzuCXVlw==
X-Google-Smtp-Source: APXvYqyNg8c+b1nge2zl3AKwa/fmuWS0TQBCd9OHpVeiNDE2hCZTjRsXzNRQJTYSiQSeQrCufG7O6Q==
X-Received: by 2002:a17:90a:2107:: with SMTP id a7mr944778pje.37.1582860824073;
        Thu, 27 Feb 2020 19:33:44 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
        by smtp.gmail.com with ESMTPSA id c68sm9188740pfc.156.2020.02.27.19.33.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 19:33:43 -0800 (PST)
Subject: Re: [PATCH v4 1/5] target/riscv: add vector unit stride load and
 store instructions
To:     LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
        chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-2-zhiwei_liu@c-sky.com>
 <4cfb56d6-34a5-0e35-87a0-2aefaafa4221@linaro.org>
 <287bde05-421c-f49c-2404-fdee183c9e12@c-sky.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <10e50ea8-7614-f094-a827-38ed09462f29@linaro.org>
Date:   Thu, 27 Feb 2020 19:33:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <287bde05-421c-f49c-2404-fdee183c9e12@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 2/27/20 5:50 PM, LIU Zhiwei wrote:
>> This is not what I had in mind, and looks wrong as well.
>>
>>     int idx = (index * mlen) / 64;
>>     int pos = (index * mlen) % 64;
>>     return (((uint64_t *)v0)[idx] >> pos) & 1;
>>
>> You also might consider passing log2(mlen), so the multiplication could be
>> strength-reduced to a shift.
> I don't think so. For example, when mlen is 8 bits and index is 0, it will
> reduce to
> 
> return (((uint64_t *)v0)[0]) & 1
> 
> And it's not right.
> 
> The right bit is first bit in vector register 0. And in host big endianess,
> it will be  the first bit of the seventh byte.

You've forgotten that we've just done an 8-byte big-endian load, which means
that we *are* looking at the first bit of the byte at offset 7.

It is right.

>> You don't need to pass mlen, since it's
> Yes.

I finally remembered all of the bits that go into mlen and thought I had
deleted that sentence -- apparently I only removed half.  ;-)


r~
