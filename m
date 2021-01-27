Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14003051AC
	for <lists+linux-csky@lfdr.de>; Wed, 27 Jan 2021 06:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhA0FFK (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 27 Jan 2021 00:05:10 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:43968 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232788AbhA0DFU (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Tue, 26 Jan 2021 22:05:20 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=guoren@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UN09ODa_1611716255;
Received: from IT-C02Z45M7LVCF.local(mailfrom:guoren@linux.alibaba.com fp:SMTPD_---0UN09ODa_1611716255)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 27 Jan 2021 10:57:36 +0800
Subject: Re: csky + clangbuiltlinux
To:     Nick Desaulniers <ndesaulniers@google.com>,
        zixuan.wu@linux.alibaba.com, ren_guo@c-sky.com,
        linux-csky@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <CAKwvOdnQjm2yMfKLcT-9=iQg68=EskMh3Evrx=3rTAJo3UAnZw@mail.gmail.com>
From:   Guo Ren <guoren@linux.alibaba.com>
Message-ID: <d8f70be3-178f-7485-4a28-05108e21ef20@linux.alibaba.com>
Date:   Wed, 27 Jan 2021 10:57:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdnQjm2yMfKLcT-9=iQg68=EskMh3Evrx=3rTAJo3UAnZw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Hi Nick,

On 2021/1/27 上午5:51, Nick Desaulniers wrote:

> Hello,
> I was wondering if there's any interest in getting LLVM's csky backend
> to compile the Linux kernel?  We maintain LLVM support in the kernel,
> and CI in various places.  It would be neat to see these working well
> together and actively supported.

I'll try to compile kernel with llvm after upstreamed.

https://reviews.llvm.org/D86505 
<https://reviews.llvm.org/D86505?spm=a2o8d.corp_prod_task_list.0.0.63a76b88jKU2Wg> 
[finished] https://reviews.llvm.org/D86610 
<https://reviews.llvm.org/D86610> [finished]

https://reviews.llvm.org/D89180 <https://reviews.llvm.org/D89180> 
[finished]

https://reviews.llvm.org/D93372 <https://reviews.llvm.org/D93372> 
[finished]

https://reviews.llvm.org/D88466 <https://reviews.llvm.org/D88466> [finished]

https://reviews.llvm.org/D94007 <https://reviews.llvm.org/D94007> 
[reviewing] https://reviews.llvm.org/D93798 
<https://reviews.llvm.org/D93798> [reviewing] 
https://reviews.llvm.org/D95029 <https://reviews.llvm.org/D95029> 
[reviewing] https://reviews.llvm.org/D95030 
<https://reviews.llvm.org/D95030> [reviewing] Best Regards

Guo Ren

