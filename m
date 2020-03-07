Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5C7F17CF85
	for <lists+linux-csky@lfdr.de>; Sat,  7 Mar 2020 18:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgCGRoQ (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 7 Mar 2020 12:44:16 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43656 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgCGRoQ (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sat, 7 Mar 2020 12:44:16 -0500
Received: by mail-pf1-f194.google.com with SMTP id c144so2739934pfb.10
        for <linux-csky@vger.kernel.org>; Sat, 07 Mar 2020 09:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=95OZDX63l38IDOcVyZsmX82oiPYU78nsEnv9BrPfj+w=;
        b=HTat6H2joNOKsKRXW3If4etMx+SoBwmSpq1YJFq0xo4RcAS8SsllYs9qiR84rWWfjp
         fbMbJ1lntK7CBIR3+v8fp4U81VmC8hTVh+V0g0QSClhAwbXguUthNfxwQFfkp1UUvy8O
         7RBVSfATGau4BCyOdNbOhqufRP47lGc8kpLqjl0lBRVkHpMkFCZm3c1mEMzllVEgGKiQ
         LHhzt2vMqQSfKpKEVY5FZq4DlDU6a2SxMQsgpNRg6Jby27mhyru4+HShaY8xBv7T+jNj
         l3KntayFSIRSCMn8HszTUdkLCC907aCi/mI2rmOWjn2fFyH9JJouctt8H9ICbGR0nR8M
         megQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=95OZDX63l38IDOcVyZsmX82oiPYU78nsEnv9BrPfj+w=;
        b=BaQaA0adRlioH1V2oXvhPqxWUfH9Kbg4kdLgnqKdGPGSC47hguYedEKhZzJ8I202aV
         Yz3BhIfU5DKrqHE4jrSjNXR7EvqrYNz3p4Kzxr2NNcJULPtuHFmuivH3jJKTMTf0zjjD
         rtss/L9rLkSw2Um5iJNQ+Qhvebkb9L35Os5rbtWkdPPxuL/oiynsQxN0mVhl0Pj/asSr
         MfHBcQZGfQBjhB2ZJdsSWEOD+35+AhC1wEz0zXm/OTNWhlQO8Q8eM2Z47XbH0V4vx7/X
         1Hh70PFeDBNCX1jetpTVWnZnaAsI7GuwsV9cbFOg28DSs1yRIoHmnrJ66eEKBFc2vc59
         PlrQ==
X-Gm-Message-State: ANhLgQ0wfkRUqHYShDbu4EZgtmAZfzQnHB+GOvHuMuNafdOvh6eHLs9m
        3M8obwOBZU5Si7N/VOtdoRTtyA==
X-Google-Smtp-Source: ADFU+vsBV9LrfSZQ3f3gwO6m+vqnYHrm/8s4GUrwu9bbzDrxcUJzH4U6cI54goghGGWs732183djbg==
X-Received: by 2002:a63:309:: with SMTP id 9mr8722586pgd.193.1583603054737;
        Sat, 07 Mar 2020 09:44:14 -0800 (PST)
Received: from ?IPv6:2601:1c0:6100:5580:6886:21be:91dd:78be? ([2601:1c0:6100:5580:6886:21be:91dd:78be])
        by smtp.gmail.com with ESMTPSA id u13sm13229747pjn.29.2020.03.07.09.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2020 09:44:14 -0800 (PST)
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
 <a225d9e7-f7ee-71c4-db90-cc27f25470ed@c-sky.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4253d616-3d28-c848-d559-86407e4fc313@linaro.org>
Date:   Sat, 7 Mar 2020 09:44:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <a225d9e7-f7ee-71c4-db90-cc27f25470ed@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 3/6/20 8:36 PM, LIU Zhiwei wrote:
> I define fields shared between vector helpers and decode code.
> FIELD(VDATA, MLEN, 0, 8)
> FIELD(VDATA, VM, 8, 1)
> FIELD(VDATA, LMUL, 9, 2)
> FIELD(VDATA, NF， 11， 4）
> 
> But I can't find a  good place to place the fields. There is not a
> "translate.h" in target/riscv.
>  Is cpu.h OK？

Perhaps "internals.h" would be better.  About 4 of the targets have one of
these.  It keeps things that are not relevant to the actual architecture, only
to the implementation, separate.

r~
