Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF9A44CE6A
	for <lists+linux-csky@lfdr.de>; Thu, 11 Nov 2021 01:39:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbhKKAmq (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 10 Nov 2021 19:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhKKAmp (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 10 Nov 2021 19:42:45 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0AB2C061767
        for <linux-csky@vger.kernel.org>; Wed, 10 Nov 2021 16:39:57 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id m26so4113639pff.3
        for <linux-csky@vger.kernel.org>; Wed, 10 Nov 2021 16:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GCvgNnriUarmCbicpFHHYqZw6hipmqUHqLUNYcuQ5mQ=;
        b=C/MSXc16d+vnyvPXnpHvWobOFVkGiZtvk8Fqn9KlAR5wdGaXHNSYYEqouCychGdG8p
         5qAR+o3QR3qaB0TDQ3yAC+dSCwOdKvfiEZ3Kln4q4atLvJqPKPRHW1o5zq6Ns5xwkOtC
         ik1lkhQwf39tyN70E9VZseTQvLWw0Txmbjd6Pu8ATSLAClCUTw6YIKKav5QdSu46fQ/5
         +e5c/wEbKgc1jOnG5VvHUJ9ey6iGYkWAk7F4ceZqKKEK8rilWv0ZFkZJXl5cjnWfQIx8
         55tsEZ8ESYtzoMLt6c2A3hOaXpTct4C6eIipQoqRcDMTUY4c5FxHvAnMIbgpRMgbfXry
         LjOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GCvgNnriUarmCbicpFHHYqZw6hipmqUHqLUNYcuQ5mQ=;
        b=3RNedufUJs/pDgQPcPvjrhbqXvlUciXmpeX7A/vblGdZGED1wJhxOQQUApev+3RyIX
         RMEz8iTYQyPU6x2VcnqHTJj1CXlQQQXkZmJyNwRz4VadwYKrXfjw6BvOqZOkNWNNloW6
         1rSM4he60OOZuF/a+vFAlZdJC9Z9zzh6swPG49N9e7vBHB6GtKqYBGSUz1Kv40QL3hMK
         YYmQX8XL/CKdOwixGCFHI8WMsfeauK1As8YzlTcTnjxWJD0VnXsgkE9wbdTpY/luKCsu
         FyzJZi3xDITOOGz7JDMlVlVVnV3KrK3GmgIwBraNA3xalnYBtHprh5wK6+eZiH7Z2v9c
         tXfQ==
X-Gm-Message-State: AOAM530RViX1Q/HQuFFeHsbQ0sfAPRm6vz85MoYfusebTckkciyL59e6
        nm+w+Ih55JteMEz/bRvMaIodAw==
X-Google-Smtp-Source: ABdhPJyzWkgci9VXixrCRz+lgwFJsP+1qd2jH9xIE5pUKSl6Qej6NdegD7xki773sUR8p4Puao3+lQ==
X-Received: by 2002:a63:6302:: with SMTP id x2mr1983608pgb.5.1636591196936;
        Wed, 10 Nov 2021 16:39:56 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h194sm750078pfe.156.2021.11.10.16.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 16:39:56 -0800 (PST)
Date:   Thu, 11 Nov 2021 00:39:52 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Like Xu <like.xu.linux@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
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
        Zhu Lingshan <lingshan.zhu@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@redhat.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <green.hu@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Marc Zyngier <maz@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Guo Ren <guoren@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 01/16] perf: Ensure perf_guest_cbs aren't reloaded
 between !NULL check and deref
Message-ID: <YYxmWGB6IUwEu4VZ@google.com>
References: <20210922000533.713300-1-seanjc@google.com>
 <20210922000533.713300-2-seanjc@google.com>
 <77e3a76a-016b-8945-a1d5-aae4075e2147@gmail.com>
 <YYPrst2CUBXLYc9h@google.com>
 <f86fe9cb-bf4b-1c10-e0da-276fbb3f62ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f86fe9cb-bf4b-1c10-e0da-276fbb3f62ee@redhat.com>
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Wed, Nov 10, 2021, Paolo Bonzini wrote:
> On 11/4/21 15:18, Sean Christopherson wrote:
> > If I'm interpeting Paolo's suggestion
> > correctly, he's pointing out that oustanding stores to the function pointers in
> > @cbs need to complete before assigning a non-NULL pointer to perf_guest_cbs,
> > otherwise a perf event handler may see a valid pointer with half-baked callbacks.
> > 
> > I think smp_store_release() with a comment would be appropriate, assuming my
> > above interpretation is correct.
> > 
> 
> Yes, exactly.  It should even be rcu_assign_pointer(), matching the
> synchronize_rcu()

And perf_guest_cbs should be tagged __rcu and accessed accordingly.  Which is
effectively what this version (poorly) implemented with a homebrewed mix of
{READ,WRITE}_ONCE, lockdep(), and synchronize_rcu().

> in patch 1 (and the change can be done in patch 1, too).

Ya, the change needs to go into patch 1.
