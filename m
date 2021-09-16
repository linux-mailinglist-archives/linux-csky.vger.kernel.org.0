Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15F240ED59
	for <lists+linux-csky@lfdr.de>; Fri, 17 Sep 2021 00:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241052AbhIPWcL (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 16 Sep 2021 18:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241057AbhIPWcL (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 16 Sep 2021 18:32:11 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2C6C061574
        for <linux-csky@vger.kernel.org>; Thu, 16 Sep 2021 15:30:50 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h3so7627665pgb.7
        for <linux-csky@vger.kernel.org>; Thu, 16 Sep 2021 15:30:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SbpJPJ4GLHhtaxBB1xHIdRhJVAuKGVRHlo9Wp9BtXvg=;
        b=igafNvMA1/3Bo/Hn8R9+USa5il0ulFxjx+nPIh2XyZCbl93vTOyT82CSDzdcKRJJgO
         FkJ5tfOZgSqPwIB2uy13Vsv6TyxDZo5SSSg6NO0tCl0m6iggfHrPIgqTtDvi9KZvPNYG
         8S05G6PCVB/DKu6Qps+LsPTZQ05wevCQFNZ+BICkpGZZdeZrOwvM4eNTBKGGZV/zaEby
         /Uo1noNrpUpRnME+TSkjRKmfn4qrb0maTPZTyYR72JBGteB/DiewqWAa7W2K5Npk1E/o
         h4Ealz2zUj5Dq5lsSJIpFakB2CCLO0hEG1zQ+M9xbiD1cysQ1HBn46apv1+McHJBcrYb
         Amkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SbpJPJ4GLHhtaxBB1xHIdRhJVAuKGVRHlo9Wp9BtXvg=;
        b=xEf2XGCW3dfVwRDoh9m1GilQwOl0QJnbUIYmzYIebsIEnqzzE71Rj2pJZ6MuIPjuyn
         Sb4aWEfWeAs5cjfJpJPTRVebYaUjC+/aVr2KkOxHMHZ2x8qRPXqr8GFphr3MGw31isos
         m9T7odNw/1nr7HFA6IyB/zAImQfdErMzCnB7BY6thlpGlyazm+8zNr1lo78HaZYhJ93t
         ATEjMwnqVbVG+2TV90aVYjZ3zj82tGQbiXjjQEnjUiASxt4LgJoEISh9h5PcbReoVjNI
         +cKFTmDMlgfezcd6LnhBDr9fxkXLKAWaBH7EWtPxOk+K82JOHQBvPKD1AQnjrUbXS6jj
         5zgw==
X-Gm-Message-State: AOAM533DjnJGo6uIoYNRsV+9bMQ7IIJaPV0hfEgTZnV6dxIBOv7xJvNB
        3dIc0DNr/Iss3NqQ5i7DEv9GjA==
X-Google-Smtp-Source: ABdhPJx9Zno3oAszEpQSd/n4PnO2QNAuNkUGb12hjpp8HsLen9cxO4C/uNjsvLGvYRAHddpH9w+INQ==
X-Received: by 2002:a63:6ec9:: with SMTP id j192mr7022031pgc.115.1631831449675;
        Thu, 16 Sep 2021 15:30:49 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id b1sm3951150pjl.4.2021.09.16.15.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 15:30:49 -0700 (PDT)
Date:   Thu, 16 Sep 2021 22:30:45 +0000
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
Subject: Re: [PATCH v2 05/13] perf: Force architectures to opt-in to guest
 callbacks
Message-ID: <YUPFlb6r1udRKcBH@google.com>
References: <20210828003558.713983-1-seanjc@google.com>
 <20210828003558.713983-6-seanjc@google.com>
 <20210828194752.GC4353@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828194752.GC4353@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sat, Aug 28, 2021, Peter Zijlstra wrote:
> On Fri, Aug 27, 2021 at 05:35:50PM -0700, Sean Christopherson wrote:
> > diff --git a/init/Kconfig b/init/Kconfig
> > index 55f9f7738ebb..9ef51ae53977 100644
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1776,6 +1776,9 @@ config HAVE_PERF_EVENTS
> >  	help
> >  	  See tools/perf/design.txt for details.
> >  
> > +config HAVE_GUEST_PERF_EVENTS
> > +	bool
> 	depends on HAVE_KVM
> 
> ?

Ah, nice!  We can go even further to:

	depends on HAVE_PERF_EVENTS && HAVE_KVM

though I'm pretty sure all architectures that select HAVE_KVM also select
HAVE_PERF_EVENTS.

Huh.  arm64 doesn't select HAVE_KVM even though it selects almost literally every
other HAVE_KVM_* config.  arm64 has some other weirdness with CONFIG_KVM, I'll add
a patch or two to fix that stuff and amend this patch as above.

Thanks again!
