Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E37840ECBF
	for <lists+linux-csky@lfdr.de>; Thu, 16 Sep 2021 23:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235388AbhIPVm1 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 16 Sep 2021 17:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbhIPVm1 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 16 Sep 2021 17:42:27 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CF7C061766
        for <linux-csky@vger.kernel.org>; Thu, 16 Sep 2021 14:41:06 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id n2so2182701plk.12
        for <linux-csky@vger.kernel.org>; Thu, 16 Sep 2021 14:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H6MB2ODxA8ncTb3aji91NU1uUQ9q1AebxOl6ENeKyck=;
        b=MXQC+ZfLxlKAl3MhEJW1BaTu7x3eZBr25vDIOP4P1K/hKKNsBxR9bYAbQrcXeqx0IT
         UwrZDJawrFH60RbkF94BswFhIwo0cou0aN+gLacubbeU6IcTTMJrkdfHEYWn3Q3CVBfY
         FWOlqrCFMP2DA28EATBAk/sg6Cxl8pCwP9qJHgGrwzQTOnAwwW0mxDrD/8RBAtDi8Sen
         7O4AbiMouCC1KnoWzOLrohcS9Vtb2Dd0sBl4eKlMlTi8+NrzRnGujJOfnGMsmwaTYUXB
         tHZDCMU2HvcsbXJF8DOiqaPVnBEOB3kiFk+1tNf5dSr4/Tt9/mMCbKmuD1xBAf0iTv/g
         rERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H6MB2ODxA8ncTb3aji91NU1uUQ9q1AebxOl6ENeKyck=;
        b=v5Ip/A+/fEvqqz14gV7tVvICaGhZEVmA8l34u8m2x6VqIHIWRD3lV4bisR2IGPD1Xa
         7gpH2qiO0Q2+V9BFc/Bs3aKbMly3PTx/fFr+ZK+Y/rZyPukMJIP/OcDQuVhyy/f4KPZX
         tBrhPmVzNOaE1vxq4E+6ZtsQ26RK07RbNmyG1mgZ6VWUdsXRKt0CAGo2h6hiMQdZXzVz
         2DhQaoiqre92O5vyITmzHZ048EDbGl0jGLyd84UzMiLicg8NQSrooXni49SXCCj7nVie
         OBOgDJcuWk/GXDoM4iul7RGChJXN0vxOIU6Bes8DFHqk+AQSDVlOR0jzrRIyMHgoVXYn
         wDyQ==
X-Gm-Message-State: AOAM5315Nvy6wd1HiiDRwaX7b5B9e9vgB2YH/KMc91Cc5V63TkuDfM+S
        pcUKh1X0KNxw4K9l+Y2xlYstNg==
X-Google-Smtp-Source: ABdhPJyEB8CLbdwiUNdfZdvrZtOKbQbkduopskaqSrtZd3BkA7cXNgyeY28844ULJzTSWyVMUXnICw==
X-Received: by 2002:a17:903:244e:b0:13c:802d:92c with SMTP id l14-20020a170903244e00b0013c802d092cmr6486996pls.78.1631828465371;
        Thu, 16 Sep 2021 14:41:05 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id z11sm4163558pff.144.2021.09.16.14.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 14:41:04 -0700 (PDT)
Date:   Thu, 16 Sep 2021 21:41:01 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
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
        Zhu Lingshan <lingshan.zhu@intel.com>
Subject: Re: [PATCH v2 01/13] perf: Ensure perf_guest_cbs aren't reloaded
 between !NULL check and deref
Message-ID: <YUO57TlEGlUk2Q03@google.com>
References: <20210828003558.713983-1-seanjc@google.com>
 <20210828003558.713983-2-seanjc@google.com>
 <20210828194421.GB4353@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828194421.GB4353@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sat, Aug 28, 2021, Peter Zijlstra wrote:
> On Fri, Aug 27, 2021 at 05:35:46PM -0700, Sean Christopherson wrote:
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 464917096e73..2126f6327321 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6491,14 +6491,19 @@ struct perf_guest_info_callbacks *perf_guest_cbs;
> >  
> >  int perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
> >  {
> > -	perf_guest_cbs = cbs;
> > +	if (WARN_ON_ONCE(perf_guest_cbs))
> > +		return -EBUSY;
> > +
> > +	WRITE_ONCE(perf_guest_cbs, cbs);
> > +	synchronize_rcu();
> 
> You're waiting for all NULL users to go away? :-) IOW, we can do without
> this synchronize_rcu() call.

Doh, right.  I was thinking KVM needed to wait for in-progress NMI to exit to
ensure guest PT interrupts are handled correctly, but obviously the NMI handler
needs to exit for that CPU to get into a guest...

> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
> >  
> >  int perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs)
> >  {
> > -	perf_guest_cbs = NULL;
> 
> 	if (WARN_ON_ONCE(perf_guest_cbs != cbs))
> 		return -EBUSY;
> 
> ?

Works for me.  I guess I'm more optimistic about people not being morons :-)
