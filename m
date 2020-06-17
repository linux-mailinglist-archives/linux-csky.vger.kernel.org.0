Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D05D91FD139
	for <lists+linux-csky@lfdr.de>; Wed, 17 Jun 2020 17:49:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgFQPtd (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 17 Jun 2020 11:49:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33726 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726494AbgFQPtc (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Wed, 17 Jun 2020 11:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592408970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tDWhLTLZ7olw8GAAlUQ4uQj+TXV9++NuoVK0ARUFcIQ=;
        b=CIaAUySoh1hFw+V1Uer7NWbm7bGUtDIlqS0Vk9SwKEGRuUlmItUZGRj2KS1GpozQu7TrNW
        i4JSTFyj6pdgjIX+qnfyAWj4MyOEfU5eYixYSGv5rdpITnbp51B+omMNnYBjZ5Z5gtZF6n
        /Ic8kg+cKEkWl85dBfYSkquAPQJY4Vg=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-342-3j80C1O8NSKHGtr3nM8VYQ-1; Wed, 17 Jun 2020 11:49:28 -0400
X-MC-Unique: 3j80C1O8NSKHGtr3nM8VYQ-1
Received: by mail-qt1-f197.google.com with SMTP id l26so2031800qtr.14
        for <linux-csky@vger.kernel.org>; Wed, 17 Jun 2020 08:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tDWhLTLZ7olw8GAAlUQ4uQj+TXV9++NuoVK0ARUFcIQ=;
        b=QH4XmQPrv4oiK1nGn42r9eNiEoC9mAmXGsxr4BOcc6o6rQ2C31s22mn/Xogkf/7AdM
         H+JZH0P2EI2KAUyEVb2dKRUoz1Rm6DaBXmEZDwpCzKTKzgUc5yRNY6swDA3OiRXwr++m
         C1eYj1A0O0HkaQXjW+L8ZYcwaehCrXLIV4DoqpD8j4fPI2nAPGnHl5LMp8Moez4HzahN
         8D/WiVONv6NXbddqzJBrVqIuIs5v7by8n6LAf5S2IB5oQNcpKcy2+ncA4BjqGvBHLBB1
         Ia74/5vrZxXZzaWbSRWhnhBmRfWQcb9xWO2OdrXBsVbm8Pq+XZDpRM1JdR8Sk5VRXX7K
         pYnQ==
X-Gm-Message-State: AOAM5331BLD01zFlw8honK6UYV3zVwaYYlQsiJ44FXCYcszS0+dSJROD
        e/VIvh8V537faTFEvb7469IkuknE58fU8UkWQMm/86npDXozeDoH7VOEA3qqcx1rhA2yyBxie4z
        pa3/fgqTQFb4Se45hjMGGbA==
X-Received: by 2002:aed:2803:: with SMTP id r3mr25137316qtd.212.1592408968134;
        Wed, 17 Jun 2020 08:49:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJJovWTmPSQ+HOXo0IAdIlJ+CjdneGFj8wAR4MxASHoGf+c0X4S+fKYy93Bmy5LEQzmh9cyw==
X-Received: by 2002:aed:2803:: with SMTP id r3mr25137294qtd.212.1592408967833;
        Wed, 17 Jun 2020 08:49:27 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id t13sm238106qtc.77.2020.06.17.08.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 08:49:26 -0700 (PDT)
Date:   Wed, 17 Jun 2020 11:49:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH 07/25] mm/csky: Use mm_fault_accounting()
Message-ID: <20200617154925.GC76766@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615221607.7764-8-peterx@redhat.com>
 <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Wed, Jun 17, 2020 at 03:04:49PM +0800, Guo Ren wrote:
> Hi Peter,

Hi, Guo,

> 
> On Tue, Jun 16, 2020 at 6:16 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Use the new mm_fault_accounting() helper for page fault accounting.
> > Also, move the accounting to be after release of mmap_sem.
> >
> > CC: Guo Ren <guoren@kernel.org>
> > CC: linux-csky@vger.kernel.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/csky/mm/fault.c | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> >
> > diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> > index 4e6dc68f3258..8f8d34d27eca 100644
> > --- a/arch/csky/mm/fault.c
> > +++ b/arch/csky/mm/fault.c
> > @@ -111,8 +111,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
> >                 return;
> >         }
> >  #endif
> > -
> > -       perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
> >         /*
> >          * If we're in an interrupt or have no user
> >          * context, we must not take the fault..
> > @@ -160,17 +158,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
> >                         goto bad_area;
> >                 BUG();
> >         }
> > -       if (fault & VM_FAULT_MAJOR) {
> > -               tsk->maj_flt++;
> > -               perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
> > -                             address);
> > -       } else {
> > -               tsk->min_flt++;
> > -               perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
> > -                             address);
> > -       }
> > -
> >         up_read(&mm->mmap_sem);
> > +       mm_fault_accounting(tsk, regs, address, fault & VM_FAULT_MAJOR);
> >         return;
> >
> >         /*
> > --
> > 2.26.2
> >
> I notice that you move it out of mm->mmap_sem's area, all archs should
> follow the rule ? Can you give me a clarification and put it into de
> commit log ?

I don't think it's a must, but mmap_sem should not be required at least by
observing current code.  E.g., do_user_addr_fault() of x86 does the accounting
without mmap_sem even before this series.

The perf events should be thread safe on its own.  Frankly speaking I'm not
very certain about my understanding on the per task counters, because iiuc we
can also try to get user pages remotely of a thread in parallel with the page
fault happening on the same thread, then it seems to me that the per task pf
counters can be accessed on different cores simultaneously.  However otoh that
seems to be very rare, and it's still acceptable to me as a trade off to avoid
overhead of locks or atomic ops on the counters.  I'd be glad to be corrected
if I missed anything important here...

Thanks,

-- 
Peter Xu

