Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D94963FA1C1
	for <lists+linux-csky@lfdr.de>; Sat, 28 Aug 2021 01:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhH0XYZ (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 27 Aug 2021 19:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbhH0XYY (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 27 Aug 2021 19:24:24 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653D6C0613D9
        for <linux-csky@vger.kernel.org>; Fri, 27 Aug 2021 16:23:35 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u11-20020a17090adb4b00b00181668a56d6so5865502pjx.5
        for <linux-csky@vger.kernel.org>; Fri, 27 Aug 2021 16:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TQth0zKaZ1g898XhTaLjgqI+BqtTYpmEnIJq3AsLCJk=;
        b=BAuX2ol8F6dvdcYTLPau4K0GBYzUoQCSuqStZCATywk1xJsRcTN/zbnvR40BRHvYRj
         p2MT9UNw+pSe1w4FqYAzJww2vX26GF4Etd+uOuVWgHJFd4agO5hpaKs4rD3Z8IuIiQ64
         bceibC9z39TyoUF5r/ZBJugD41m33rR/4wmX0JjHH4Ox3VO0sQvCLcKc4rCPjZl3kpp/
         z2ewywcdb4obgJrlPAWwwSgAREPIfSw6ixPLrZU+orCqHvOzAJIbsJDGYnOKI/KJzI5+
         MS27DWV8OUcVAL9tLPc5IpbSctooG5g35qhato+7vW1AY9AOSyjT1rpopwB7U0ojjXOG
         jR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TQth0zKaZ1g898XhTaLjgqI+BqtTYpmEnIJq3AsLCJk=;
        b=lGQp4CTZNs08EywLjW9fEFjZtgDbzPgMyoj5X1csLcPpaEeb1IY6v3jZB4oxpdIryz
         JSX+nrYRLM7Y/2QYbWoaYPxicNNNqdPEiV2wzuXM8jRcDnM7Pu76dHB0aBU5mXeNN6HL
         pX6B17fnDBlBNhZb02nIhQjYg7tsHuNr+O6HVqs8rZesSD/zQGZZR7RQLwLRLDA9V4Jf
         SKCVsvSg1urZ9WRmgtz7hkQUcb+lFIpNpaVJi8pgCMAm3oRBXp8Spbat1cHgCGYPLTW/
         3UI5PlRXwjTemXNP9Tbnn+R3s3bKAMPb85rVJXExp6MykDgepPz3CXg82YKn3qB6F9G9
         a2+A==
X-Gm-Message-State: AOAM533EnBE/mHHrYWehLl04ZfOPIP+B+FrhAxs5z35TSBMwS/0Qf1m+
        05c2Ru4PVuQv8mmqE9pn1ZPUZA==
X-Google-Smtp-Source: ABdhPJwmCb6NSZOc/5AwINtm/0AHRKcukC2PPcNvrpcQ6DjdUz8MDW9KTFWzGmyEhc2uaUezQAIkrA==
X-Received: by 2002:a17:90a:fe8e:: with SMTP id co14mr10854117pjb.200.1630106614660;
        Fri, 27 Aug 2021 16:23:34 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id h13sm7335943pgh.93.2021.08.27.16.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 16:23:33 -0700 (PDT)
Date:   Fri, 27 Aug 2021 23:23:30 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     dvhart <dvhart@infradead.org>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, gor <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>, shuah <shuah@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-csky <linux-csky@vger.kernel.org>,
        linux-mips <linux-mips@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH v2 4/5] KVM: selftests: Add a test for KVM_RUN+rseq to
 detect task migration bugs
Message-ID: <YSlz8h9SWgeuicak@google.com>
References: <20210820225002.310652-1-seanjc@google.com>
 <20210820225002.310652-5-seanjc@google.com>
 <766990430.21713.1629731934069.JavaMail.zimbra@efficios.com>
 <282257549.21721.1629732017655.JavaMail.zimbra@efficios.com>
 <YSblqrrpKcORzilX@google.com>
 <1700758714.29394.1630003332081.JavaMail.zimbra@efficios.com>
 <YSgpy8iXXXUQ+b/k@google.com>
 <339641531.29941.1630091374065.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <339641531.29941.1630091374065.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Fri, Aug 27, 2021, Mathieu Desnoyers wrote:
> > So there are effectively three reasons we want a delay:
> > 
> >  1. To allow sched_setaffinity() to coincide with ioctl(KVM_RUN) before KVM can
> >     enter the guest so that the guest doesn't need an arch-specific VM-Exit source.
> > 
> >  2. To let ioctl(KVM_RUN) make its way back to the test before the next round
> >     of migration.
> > 
> >  3. To ensure the read-side can make forward progress, e.g. if sched_getcpu()
> >     involves a syscall.
> > 
> > 
> > After looking at KVM for arm64 and s390, #1 is a bit tenuous because x86 is the
> > only arch that currently uses xfer_to_guest_mode_work(), i.e. the test could be
> > tweaked to be overtly x86-specific.  But since a delay is needed for #2 and #3,
> > I'd prefer to rely on it for #1 as well in the hopes that this test provides
> > coverage for arm64 and/or s390 if they're ever converted to use the common
> > xfer_to_guest_mode_work().
> 
> Now that we have this understanding of why we need the delay, it would be good to
> write this down in a comment within the test.

Ya, I'll get a new version out next week.

> Does it reproduce if we randomize the delay to have it picked randomly from 0us
> to 100us (with 1us step) ? It would remove a lot of the needs for arch-specific
> magic delay value.

My less-than-scientific testing shows that it can reproduce at delays up to ~500us,
but above ~10us the reproducibility starts to drop.  The bug still reproduces
reliably, it just takes more iterations, and obviously the test runs a bit slower.

Any objection to using a 1-10us delay, e.g. a simple usleep((i % 10) + 1)?
