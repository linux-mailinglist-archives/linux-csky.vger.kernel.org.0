Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F564289C8
	for <lists+linux-csky@lfdr.de>; Mon, 11 Oct 2021 11:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235561AbhJKJkw (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Mon, 11 Oct 2021 05:40:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:40158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235500AbhJKJkv (ORCPT <rfc822;linux-csky@vger.kernel.org>);
        Mon, 11 Oct 2021 05:40:51 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29D5660231;
        Mon, 11 Oct 2021 09:38:52 +0000 (UTC)
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mZrli-00FySl-62; Mon, 11 Oct 2021 10:38:50 +0100
Date:   Mon, 11 Oct 2021 10:38:49 +0100
Message-ID: <87v923q4t2.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Guo Ren <guoren@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
Subject: Re: [PATCH v3 14/16] KVM: arm64: Convert to the generic perf callbacks
In-Reply-To: <20210922000533.713300-15-seanjc@google.com>
References: <20210922000533.713300-1-seanjc@google.com>
        <20210922000533.713300-15-seanjc@google.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: seanjc@google.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, will@kernel.org, mark.rutland@arm.com, guoren@kernel.org, nickhu@andestech.com, green.hu@gmail.com, deanbo422@gmail.com, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, pbonzini@redhat.com, boris.ostrovsky@oracle.com, jgross@suse.com, alexander.shishkin@linux.intel.com, jolsa@redhat.com, namhyung@kernel.org, james.morse@arm.com, alexandru.elisei@arm.com, suzuki.poulose@arm.com, vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org, sstabellini@kernel.org, linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org, artem.kashkanov@intel.com, like.xu.linux@gmail.com, lingshan.zhu@intel.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Wed, 22 Sep 2021 01:05:31 +0100,
Sean Christopherson <seanjc@google.com> wrote:
> 
> Drop arm64's version of the callbacks in favor of the callbacks provided
> by generic KVM, which are semantically identical.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/arm64/kvm/perf.c | 34 ++--------------------------------
>  1 file changed, 2 insertions(+), 32 deletions(-)
> 
> diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
> index 3e99ac4ab2d6..0b902e0d5b5d 100644
> --- a/arch/arm64/kvm/perf.c
> +++ b/arch/arm64/kvm/perf.c
> @@ -13,45 +13,15 @@
>  
>  DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
>  
> -static unsigned int kvm_guest_state(void)
> -{
> -	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
> -	unsigned int state;
> -
> -	if (!vcpu)
> -		return 0;
> -
> -	state = PERF_GUEST_ACTIVE;
> -	if (!vcpu_mode_priv(vcpu))
> -		state |= PERF_GUEST_USER;
> -
> -	return state;
> -}
> -
> -static unsigned long kvm_get_guest_ip(void)
> -{
> -	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
> -
> -	if (WARN_ON_ONCE(!vcpu))
> -		return 0;
> -
> -	return *vcpu_pc(vcpu);
> -}
> -
> -static struct perf_guest_info_callbacks kvm_guest_cbs = {
> -	.state		= kvm_guest_state,
> -	.get_ip		= kvm_get_guest_ip,
> -};
> -
>  void kvm_perf_init(void)
>  {
>  	if (kvm_pmu_probe_pmuver() != 0xf && !is_protected_kvm_enabled())
>  		static_branch_enable(&kvm_arm_pmu_available);
>  
> -	perf_register_guest_info_callbacks(&kvm_guest_cbs);
> +	kvm_register_perf_callbacks(NULL);
>  }
>  
>  void kvm_perf_teardown(void)
>  {
> -	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
> +	kvm_unregister_perf_callbacks();
>  }

Reviewed-by: Marc Zyngier <maz@kernel.org>

	M.

-- 
Without deviation from the norm, progress is not possible.
