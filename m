Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A8744CFC6
	for <lists+linux-csky@lfdr.de>; Thu, 11 Nov 2021 03:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233813AbhKKCMK (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 10 Nov 2021 21:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbhKKCLy (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 10 Nov 2021 21:11:54 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473BFC0432C0
        for <linux-csky@vger.kernel.org>; Wed, 10 Nov 2021 18:08:04 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id jx2-20020a17090b46c200b001a62e9db321so2072586pjb.7
        for <linux-csky@vger.kernel.org>; Wed, 10 Nov 2021 18:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=mw+8kRBMaigpdPoQg441qk6T9IEU8krLENLSjCCr4zw=;
        b=SrMofVJY/GjIpbuhbq5Q0NchE90Iee1Zg/DXzrBAL+84O+9mkb6Cvy4kbuTgC9NQoK
         tBqW8VuJ90++OLutVCiS1ya3l32W+JKb2BOUzxT4CfsJTbL/puTXQsav1euvT3+gukG2
         yS7t4ZuH8QzI7fhcSd7lINxxYvVsKg3i3FXbG+Q8gteNmUbpj11OvRbe8kbh++awXIwA
         lQ4l1HocfEVizMh2041kgc72dvgbUqXNAgsThfb0ZWYRAHAJLmF2dzBFcQYmNC3B4SgG
         os87bSDOwQmR/d7G3NMYHAuPjpmsSI+LJUHPF3mp7ZDo3cMuuRvUGMBLZ8TO5A0n/acG
         yo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=mw+8kRBMaigpdPoQg441qk6T9IEU8krLENLSjCCr4zw=;
        b=hpnM4amEiOqWFMBfRa7OkehXUsryuKzQ2iaw1YigfvnuYSwmHpGGPkCpEzdjH7zeLg
         ap+YDETAai5FVJRQDb1u4cF2zo0u+kGtgbNGWzLLbBukzsxWvfBFdhBUtRVaIHngOv1I
         aGeS7/dgSGWg7YcZzDoG6rAY0746RHe22Ou5ibGOox/TSRppAxuDx2qHT/VMtNrbySqp
         YvkrPlL19U7klSAATcK2qvjv0UruneMbat6GtYZhVI8xma+ikwTaW4HNmLg8OUUQ688X
         Y/8T/bEBDAOP7L032lAAagqQLTET4Iy7JOJzIix8tVSrtsoKF5vMZFuERTyHLbyF6396
         5yGA==
X-Gm-Message-State: AOAM531oBxORnHWyd73tnGHPGAFdllHtcE1DwF1wlqdzmGrzy1fzbzl6
        1Tors0VfKQk6pFzr6a2TzEOMzTNANYk=
X-Google-Smtp-Source: ABdhPJz67wmixiDyySBDTYDOJ0Ka4b7LxO+H1fUSrGnT0BW1K6fuhepd8JhPlaHMI6pEBAJMacMWw56NTRg=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:902:e789:b0:140:801:1262 with SMTP id
 cp9-20020a170902e78900b0014008011262mr4254554plb.42.1636596483663; Wed, 10
 Nov 2021 18:08:03 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 Nov 2021 02:07:35 +0000
In-Reply-To: <20211111020738.2512932-1-seanjc@google.com>
Message-Id: <20211111020738.2512932-15-seanjc@google.com>
Mime-Version: 1.0
References: <20211111020738.2512932-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v4 14/17] KVM: arm64: Convert to the generic perf callbacks
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guo Ren <guoren@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
        Artem Kashkanov <artem.kashkanov@intel.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Like Xu <like.xu@linux.intel.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Drop arm64's version of the callbacks in favor of the callbacks provided
by generic KVM, which are semantically identical.

Reviewed-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/arm64/kvm/perf.c | 34 ++--------------------------------
 1 file changed, 2 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/kvm/perf.c b/arch/arm64/kvm/perf.c
index dfa9bce8559e..374c496a3f1d 100644
--- a/arch/arm64/kvm/perf.c
+++ b/arch/arm64/kvm/perf.c
@@ -13,42 +13,12 @@
 
 DEFINE_STATIC_KEY_FALSE(kvm_arm_pmu_available);
 
-static unsigned int kvm_guest_state(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-	unsigned int state;
-
-	if (!vcpu)
-		return 0;
-
-	state = PERF_GUEST_ACTIVE;
-	if (!vcpu_mode_priv(vcpu))
-		state |= PERF_GUEST_USER;
-
-	return state;
-}
-
-static unsigned long kvm_get_guest_ip(void)
-{
-	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
-
-	if (WARN_ON_ONCE(!vcpu))
-		return 0;
-
-	return *vcpu_pc(vcpu);
-}
-
-static struct perf_guest_info_callbacks kvm_guest_cbs = {
-	.state		= kvm_guest_state,
-	.get_ip		= kvm_get_guest_ip,
-};
-
 void kvm_perf_init(void)
 {
-	perf_register_guest_info_callbacks(&kvm_guest_cbs);
+	kvm_register_perf_callbacks(NULL);
 }
 
 void kvm_perf_teardown(void)
 {
-	perf_unregister_guest_info_callbacks(&kvm_guest_cbs);
+	kvm_unregister_perf_callbacks();
 }
-- 
2.34.0.rc0.344.g81b53c2807-goog

