Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A614141A1
	for <lists+linux-csky@lfdr.de>; Wed, 22 Sep 2021 08:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbhIVGZH (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 22 Sep 2021 02:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53171 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232630AbhIVGZH (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Wed, 22 Sep 2021 02:25:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632291817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zooka9gAajsg8DCKduDSvz7LupNnOu3u1TFHi7y68Yc=;
        b=TxIE912/sclScoAzCqcd+GJT9rXC021QMVlM4pFrNJfStcaI3ENrIqV38xS2zgkQR2CEP/
        n7aZ6qmr9HATYOqc6h2B71+cYyYtEaYAvPs0Ga2L8hOcZnQlbnScm3KlotWOcG/HSc2pqm
        CbW/ZT1dZfz8WI9yv0jFBvFatv1lPOA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-daHPuxUlNvKaOX_01yCwiw-1; Wed, 22 Sep 2021 02:23:36 -0400
X-MC-Unique: daHPuxUlNvKaOX_01yCwiw-1
Received: by mail-wr1-f69.google.com with SMTP id h5-20020a5d6885000000b0015e21e37523so1129919wru.10
        for <linux-csky@vger.kernel.org>; Tue, 21 Sep 2021 23:23:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zooka9gAajsg8DCKduDSvz7LupNnOu3u1TFHi7y68Yc=;
        b=SmIJCQzxQxOsGpQ89BJu7R7fccduY3CSxjYUZUx+EP2OC3fw/bx0cieHp3noh55cYU
         jz3sMdYSIvuz9oS9yuTMiScs53w/qEaRIYkdzgIIsmXuahr0qnoGfC/mGD5dLI6ijISO
         ep614Un9va1NQIZ/gvQBEqK2ynnBdfK9YBltdoc4BQjUmSPPT/PsXXTp96C4PougPWu/
         gu8A7vRa+wTRG4gBHD7lGboTBDfmgDIKQpVn4Pvr6HPc5iQYE50YvHkBKU1V5OQYSMO7
         8EzBVhU4kQ/I7XO5I/iqmlwY8ThLqp0a0kz8lIBp5m6rzhz245zt7DVzK+s3X4QftWBI
         uTCg==
X-Gm-Message-State: AOAM530ITW/2nAwJnaF3VY8a1uQ0HlRgbLikKwe24mBH/vKTYZ2F3/Bl
        xiQg8pIk62BQ66NhneWkcbf4E4GBR/zeNdpUlux9GISfP6/vrE60aBLBYSgK1V3Rb+VjYh2wKoY
        fAMMbiNBn2MjZYkiSrvbF7w==
X-Received: by 2002:a7b:c3cc:: with SMTP id t12mr8423412wmj.68.1632291814961;
        Tue, 21 Sep 2021 23:23:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4Cxl6B3FvPynsb4jNEGdd2w6uOOFopYtreXbLymB/TUbaoz5flccfGAb2LTh0HveeWZIomg==
X-Received: by 2002:a7b:c3cc:: with SMTP id t12mr8423394wmj.68.1632291814600;
        Tue, 21 Sep 2021 23:23:34 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id o1sm1112414wru.91.2021.09.21.23.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 23:23:34 -0700 (PDT)
Subject: Re: [PATCH v3 02/16] KVM: x86: Register perf callbacks after calling
 vendor's hardware_setup()
To:     Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
References: <20210922000533.713300-1-seanjc@google.com>
 <20210922000533.713300-3-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6e31f767-ae3d-ec87-9880-5a8ebc381192@redhat.com>
Date:   Wed, 22 Sep 2021 08:23:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922000533.713300-3-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 22/09/21 02:05, Sean Christopherson wrote:
> Wait to register perf callbacks until after doing vendor hardaware setup.
> VMX's hardware_setup() configures Intel Processor Trace (PT) mode, and a
> future fix to register the Intel PT guest interrupt hook if and only if
> Intel PT is exposed to the guest will consume the configured PT mode.
> 
> Delaying registration to hardware setup is effectively a nop as KVM's perf
> hooks all pivot on the per-CPU current_vcpu, which is non-NULL only when
> KVM is handling an IRQ/NMI in a VM-Exit path.  I.e. current_vcpu will be
> NULL throughout both kvm_arch_init() and kvm_arch_hardware_setup().
> 
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Artem Kashkanov <artem.kashkanov@intel.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/x86.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 86539c1686fa..fb6015f97f9e 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8426,8 +8426,6 @@ int kvm_arch_init(void *opaque)
>   
>   	kvm_timer_init();
>   
> -	perf_register_guest_info_callbacks(&kvm_guest_cbs);
> -
>   	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
>   		host_xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
>   		supported_xcr0 = host_xcr0 & KVM_SUPPORTED_XCR0;
> @@ -8461,7 +8459,6 @@ void kvm_arch_exit(void)
>   		clear_hv_tscchange_cb();
>   #endif
>   	kvm_lapic_exit();
> -	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
>   
>   	if (!boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
>   		cpufreq_unregister_notifier(&kvmclock_cpufreq_notifier_block,
> @@ -11064,6 +11061,8 @@ int kvm_arch_hardware_setup(void *opaque)
>   	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
>   	kvm_ops_static_call_update();
>   
> +	perf_register_guest_info_callbacks(&kvm_guest_cbs);
> +
>   	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
>   		supported_xss = 0;
>   
> @@ -11091,6 +11090,8 @@ int kvm_arch_hardware_setup(void *opaque)
>   
>   void kvm_arch_hardware_unsetup(void)
>   {
> +	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
> +
>   	static_call(kvm_x86_hardware_unsetup)();
>   }
>   
> 

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

