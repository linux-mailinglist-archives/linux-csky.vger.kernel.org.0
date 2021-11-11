Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD7B44CFCD
	for <lists+linux-csky@lfdr.de>; Thu, 11 Nov 2021 03:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbhKKCMY (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 10 Nov 2021 21:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234354AbhKKCMD (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 10 Nov 2021 21:12:03 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD34C06121D
        for <linux-csky@vger.kernel.org>; Wed, 10 Nov 2021 18:08:09 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id u5-20020a63d3450000b029023a5f6e6f9bso2453738pgi.21
        for <linux-csky@vger.kernel.org>; Wed, 10 Nov 2021 18:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=OsKSO91+IQOd1IkS1z06+WXQrIrb9btCelj8IT/rfjk=;
        b=UjO1QsSOEJxaGsYGL3Apu9warF+RLCb7N0O8lrT4uA7hcwAOXn0B9aIpQDfjrTQVV9
         GpUiUx0P3EvrUcerrFYJ43Q90SJS/Gs68/jHuhbKg4LsEjNWoUkdOiAjjqiiHSBSgjMG
         R7y7UnI6YE9rNtmXbNbVt3sbKA6jvhnnGELbGyK4SRL2xwd9sX+q3f8jF57/MEhgUPD+
         t/+a9Sg8Ta3/1ptTGbTPekcMLXxNe7dS033Slo6cfYWGcnVi+krIVbSkYZwCP0WX4pZh
         GTnRwbyA69uU8U608boW9DzCYJ+6PE43F4bM/b41jK5pMY5lvLJwB8NslG8L5Jh5BxcV
         /FSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=OsKSO91+IQOd1IkS1z06+WXQrIrb9btCelj8IT/rfjk=;
        b=68bh+1HQSIDZZxA5omIBv6iDly3Sepbb+pKDwPcI48bzjCG9ZqG3iQ2TRes0W67alR
         RoXTRxM457sgS1uX8qOKy85cVcAKriqkjALkT1TQfvkOWmlYeSQekyAYJOximVZcq6O0
         s9UA2XUrc1+atu9wtoiIlZOH3S9sMAl9HiJUtX1qa4xV3gZchzmx3Lcry0u6bp0RJAah
         4BOoFZnk5FNOlrmyrHaI5OGwdiBsoGvFzflEfvxyFJWTmvZIRmyqQz/B13QRe/rgIkPR
         3GHswZ3+vE6cIoiDhXEIJKJho4PADoj0g7pMnQtbh4LMOvbCHCMyV9CeoCOwQrFCsmLY
         PLiA==
X-Gm-Message-State: AOAM533tkszo12yTN8B6Ca0OBpbOl4CHfANmYQ9PugLNeSgNShPnaom2
        cuV5+YXSbJv+1zMoDgD8sIYNDOnoRj4=
X-Google-Smtp-Source: ABdhPJyHlT5oqharcB3QQjRQ4qoO/10ujhci23RJu5uAP9JkYDshL4v2uHHALGrgFqagvzcYI5ZLh/T3x7g=
X-Received: from seanjc.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3e5])
 (user=seanjc job=sendgmr) by 2002:a17:90a:1950:: with SMTP id
 16mr4223713pjh.126.1636596488573; Wed, 10 Nov 2021 18:08:08 -0800 (PST)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Thu, 11 Nov 2021 02:07:38 +0000
In-Reply-To: <20211111020738.2512932-1-seanjc@google.com>
Message-Id: <20211111020738.2512932-18-seanjc@google.com>
Mime-Version: 1.0
References: <20211111020738.2512932-1-seanjc@google.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [PATCH v4 17/17] perf: Drop guest callback (un)register stubs
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

Drop perf's stubs for (un)registering guest callbacks now that KVM
registration of callbacks is hidden behind GUEST_PERF_EVENTS=y.  The only
other user is x86 XEN_PV, and x86 unconditionally selects PERF_EVENTS.

No functional change intended.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 include/linux/perf_event.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0ac7d867ca0c..7b7525e9155f 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1511,11 +1511,6 @@ perf_sw_event(u32 event_id, u64 nr, struct pt_regs *regs, u64 addr)	{ }
 static inline void
 perf_bp_event(struct perf_event *event, void *data)			{ }
 
-static inline void perf_register_guest_info_callbacks
-(struct perf_guest_info_callbacks *cbs)					{ }
-static inline void perf_unregister_guest_info_callbacks
-(struct perf_guest_info_callbacks *cbs)					{ }
-
 static inline void perf_event_mmap(struct vm_area_struct *vma)		{ }
 
 typedef int (perf_ksymbol_get_name_f)(char *name, int name_len, void *data);
-- 
2.34.0.rc0.344.g81b53c2807-goog

