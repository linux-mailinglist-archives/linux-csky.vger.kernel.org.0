Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81DAD413E3C
	for <lists+linux-csky@lfdr.de>; Wed, 22 Sep 2021 02:05:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhIVAHT (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 21 Sep 2021 20:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhIVAHS (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 21 Sep 2021 20:07:18 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1520C061757
        for <linux-csky@vger.kernel.org>; Tue, 21 Sep 2021 17:05:48 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id m6-20020a05620a24c600b004338e8a5a3cso5727252qkn.10
        for <linux-csky@vger.kernel.org>; Tue, 21 Sep 2021 17:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=/Rel7IDBHL/DlNbV9YDximOR/ceEVZKr5BpHO0J3wYE=;
        b=k3BkoiZwNDQSgL3tEWZpjE6EfQkaXg/m6u3CKlmQTge7gDNDRP920npuJicDQOLGIW
         yoGIN4Z0aY9QErf1e66xqyhlAmsb29Adxkyap6pNmw+FigDAF/HwZpyD4SwfyDNjxEBI
         L3Hj7QeZ2mK2YQzpAxgJzXhidgJBh66gysCSfbdAzAVCNl0/PpYOOwZCkG0XgqdYqcPi
         DepD/Zz5nhXyEE26CXt5pzDL9NIQrBteg/3FetFaX3qIqSta7kwW9lSwibR7Yi7ZIN64
         bGtcOit8MazFfctrkSYZbjCCAGX937gmiMhEPPsCUfa343jN+qkq71vPPMrbXWva4s8x
         1MRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=/Rel7IDBHL/DlNbV9YDximOR/ceEVZKr5BpHO0J3wYE=;
        b=tOIew8XfGX7clg3zW7oFRdKnOqLz8bjdPrpkaRF7M+Y832qd6/8tqwTw/XwqzYEiSo
         dIvNJsW60HtgDuiwxAsAp3X/RyAGCZoqw9mgrD7x6rSWJZQJI4e8PESLhRuslFHfrJDw
         40CnGTSFPqkTKM3KL5fI+YMG6VHxl0WJ+SNwBt1v+Je2fIg0CefyhHgmaYmtJBXpeswd
         DWBFtZdvcvzOWyINMY3ZXDsmGOcyi5dCYKi9ayOhjd7sb6pj/ymyOseIJpSNJK1o8bG1
         wTKyyUYrSXUCm/zfiQtGrx1kLtZurGqj176A64kvJrdL7U31fp+xWiZSXwDihW0/a063
         I4wQ==
X-Gm-Message-State: AOAM532YX7GegrgX4qZFnr2lSF1isw0fyimU0wUpNBVDa5rAfCfSiM9W
        i3dkKihQ+ULHQTQMVvyCC4mur3LkmA8=
X-Google-Smtp-Source: ABdhPJxOQ2RWktf9fE+8nT6XGH9bJ2bTXzkYzGz9TY7O9+ijr2BzXnZvbY3O/xwZK7tibJDN6XsSYEuLjw4=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:b022:92d6:d37b:686c])
 (user=seanjc job=sendgmr) by 2002:a05:6214:12af:: with SMTP id
 w15mr24363579qvu.66.1632269147772; Tue, 21 Sep 2021 17:05:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 21 Sep 2021 17:05:19 -0700
In-Reply-To: <20210922000533.713300-1-seanjc@google.com>
Message-Id: <20210922000533.713300-3-seanjc@google.com>
Mime-Version: 1.0
References: <20210922000533.713300-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3 02/16] KVM: x86: Register perf callbacks after calling
 vendor's hardware_setup()
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
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
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sean Christopherson <seanjc@google.com>,
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Wait to register perf callbacks until after doing vendor hardaware setup.
VMX's hardware_setup() configures Intel Processor Trace (PT) mode, and a
future fix to register the Intel PT guest interrupt hook if and only if
Intel PT is exposed to the guest will consume the configured PT mode.

Delaying registration to hardware setup is effectively a nop as KVM's perf
hooks all pivot on the per-CPU current_vcpu, which is non-NULL only when
KVM is handling an IRQ/NMI in a VM-Exit path.  I.e. current_vcpu will be
NULL throughout both kvm_arch_init() and kvm_arch_hardware_setup().

Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Artem Kashkanov <artem.kashkanov@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kvm/x86.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 86539c1686fa..fb6015f97f9e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8426,8 +8426,6 @@ int kvm_arch_init(void *opaque)
 
 	kvm_timer_init();
 
-	perf_register_guest_info_callbacks(&kvm_guest_cbs);
-
 	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
 		host_xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 		supported_xcr0 = host_xcr0 & KVM_SUPPORTED_XCR0;
@@ -8461,7 +8459,6 @@ void kvm_arch_exit(void)
 		clear_hv_tscchange_cb();
 #endif
 	kvm_lapic_exit();
-	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
 
 	if (!boot_cpu_has(X86_FEATURE_CONSTANT_TSC))
 		cpufreq_unregister_notifier(&kvmclock_cpufreq_notifier_block,
@@ -11064,6 +11061,8 @@ int kvm_arch_hardware_setup(void *opaque)
 	memcpy(&kvm_x86_ops, ops->runtime_ops, sizeof(kvm_x86_ops));
 	kvm_ops_static_call_update();
 
+	perf_register_guest_info_callbacks(&kvm_guest_cbs);
+
 	if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
 		supported_xss = 0;
 
@@ -11091,6 +11090,8 @@ int kvm_arch_hardware_setup(void *opaque)
 
 void kvm_arch_hardware_unsetup(void)
 {
+	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
+
 	static_call(kvm_x86_hardware_unsetup)();
 }
 
-- 
2.33.0.464.g1972c5931b-goog

