Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC61E3D1BD2
	for <lists+linux-csky@lfdr.de>; Thu, 22 Jul 2021 04:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhGVB5g (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 21 Jul 2021 21:57:36 -0400
Received: from mga03.intel.com ([134.134.136.65]:49574 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230367AbhGVB5e (ORCPT <rfc822;linux-csky@vger.kernel.org>);
        Wed, 21 Jul 2021 21:57:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10052"; a="211612850"
X-IronPort-AV: E=Sophos;i="5.84,259,1620716400"; 
   d="scan'208";a="211612850"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 19:38:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,259,1620716400"; 
   d="scan'208";a="512014134"
Received: from lingshan-mobl5.ccr.corp.intel.com (HELO [10.255.29.38]) ([10.255.29.38])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2021 19:38:02 -0700
Subject: Re: [PATCH V8 01/18] perf/core: Use static_call to optimize
 perf_guest_info_callbacks
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     bp@alien8.de, seanjc@google.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        kan.liang@linux.intel.com, ak@linux.intel.com,
        wei.w.wang@intel.com, eranian@google.com, liuxiangdong5@huawei.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
        boris.ostrvsky@oracle.com, Like Xu <like.xu@linux.intel.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Guo Ren <guoren@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        xen-devel@lists.xenproject.org,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>
References: <20210716085325.10300-1-lingshan.zhu@intel.com>
 <20210716085325.10300-2-lingshan.zhu@intel.com>
 <fd117e37-8063-63a4-43cd-7cb555e5bab5@gmail.com>
From:   "Zhu, Lingshan" <lingshan.zhu@intel.com>
Message-ID: <c5fad2b5-2c2f-9b06-6f45-629776a690fa@intel.com>
Date:   Thu, 22 Jul 2021 10:38:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <fd117e37-8063-63a4-43cd-7cb555e5bab5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org



On 7/21/2021 7:57 PM, Like Xu wrote:
> On 16/7/2021 4:53 pm, Zhu Lingshan wrote:
>> +    } else if (xenpmu_data->pmu.r.regs.cpl & 3)
oh, my typo, will fix in V9

Thanks
>
> Lingshan, serious for this version ?
>
> arch/x86/xen/pmu.c:438:9: error: expected identifier or ‘(’ before 
> ‘return’
>   438 |         return state;
>       |         ^~~~~~
> arch/x86/xen/pmu.c:439:1: error: expected identifier or ‘(’ before ‘}’ 
> token
>   439 | }
>       | ^
> arch/x86/xen/pmu.c: In function ‘xen_guest_state’:
> arch/x86/xen/pmu.c:436:9: error: control reaches end of non-void 
> function [-Werror=return-type]
>   436 |         }
>       |         ^
> cc1: some warnings being treated as errors
>
>> +            state |= PERF_GUEST_USER;
>>       }

