Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21403F23B2
	for <lists+linux-csky@lfdr.de>; Fri, 20 Aug 2021 01:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236572AbhHSXef (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 19 Aug 2021 19:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbhHSXee (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 19 Aug 2021 19:34:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9428C06175F
        for <linux-csky@vger.kernel.org>; Thu, 19 Aug 2021 16:33:57 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id c4so4882979plh.7
        for <linux-csky@vger.kernel.org>; Thu, 19 Aug 2021 16:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FSqOrapu64fBYafjbU5tjcyWOc2DrNI0dbheqGMVOMc=;
        b=qPf6yOnP+Rcz9FT3tKuWykTPcKe82BX3Np45gaPnFPSg6PdUJnLygVgfX+kzI3cJ9H
         jtESUvUqN1Ez+DTuoTUzsGouHIoQxocdabjlXnhhXdwEIL3SL3EPMESdP1tUYWRrWW5X
         56WH9AV8Z8I1+Dv+ob4dltRCZxxppIzcXuZZbDajZOYY+UHcUj8zqAQ2N2zC8ir+rqzQ
         7xRIzOV9hhvssqy3laN9jfhD8920m0bpiZR1ld4i0qnlmpXy3nqZRp+SXiFRJw3tk0Cb
         jAkYC7GX39D/8+SHQHrfwZ3zlTN2RbLaSSUFeut9erJLOEf2TnrtjesxTQV5Xd8hTAQL
         GItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FSqOrapu64fBYafjbU5tjcyWOc2DrNI0dbheqGMVOMc=;
        b=DUWWeoyX9ardRTcRrFL3yYuIsqazRmkiAOretudYLdTl5Sz8DLk/8AY+Fu7XOg8OJH
         32zrATrqvhBdCaGgN+6mTKzreD0Dy0bWvBypkZbRxG3G9zadTrbV4FZWiv/KRVwd/HS1
         u6TjA2QXqAtpAbUrEABPnqHp6RDlQr0n5SNhumggRp56dgpWSYDqr6e8sY4NkZhczZKV
         Sf5kHynfuqX+pQq1bFj7RboJXJQhoXN4/cvhldbuBdyNCHC+Do1xoIOARtUMzdy7/fWv
         28doOH8naXF5IIwcMUAYPNxZWHqnP49vzZgd2UCCimdkDSpuL7Ifwn2qw5ZBW4cx6J8T
         bLzw==
X-Gm-Message-State: AOAM530EmqmU27HE3SAxjO4CSHlqPabe5/AjLQ6B893kfBctjylspqey
        0Z/ChRH0RURvi/qoPJ7LJmepOw==
X-Google-Smtp-Source: ABdhPJyN4VYmA4QdN+DQJ6bFcB8JQlcPHEw8dvqiqzL/oaDUmvZhZqDC612NpYT8Mg6IsLybHUWCkQ==
X-Received: by 2002:a17:90a:d686:: with SMTP id x6mr1336693pju.227.1629416036922;
        Thu, 19 Aug 2021 16:33:56 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j185sm4649122pfb.86.2021.08.19.16.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 16:33:56 -0700 (PDT)
Date:   Thu, 19 Aug 2021 23:33:50 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     "Russell King, ARM Linux" <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>, gor <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>, rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
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
        linux-mips@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390@vger.kernel.org, KVM list <kvm@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH 4/5] KVM: selftests: Add a test for KVM_RUN+rseq to
 detect task migration bugs
Message-ID: <YR7qXvnI/AQM10gU@google.com>
References: <20210818001210.4073390-1-seanjc@google.com>
 <20210818001210.4073390-5-seanjc@google.com>
 <1540548616.19739.1629409956315.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540548616.19739.1629409956315.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Thu, Aug 19, 2021, Mathieu Desnoyers wrote:
> ----- On Aug 17, 2021, at 8:12 PM, Sean Christopherson seanjc@google.com wrote:
> 
> > Add a test to verify an rseq's CPU ID is updated correctly if the task is
> > migrated while the kernel is handling KVM_RUN.  This is a regression test
> > for a bug introduced by commit 72c3c0fe54a3 ("x86/kvm: Use generic xfer
> > to guest work function"), where TIF_NOTIFY_RESUME would be cleared by KVM
> > without updating rseq, leading to a stale CPU ID and other badness.
> > 
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> 
> [...]
> 
> > +	while (!done) {
> > +		vcpu_run(vm, VCPU_ID);
> > +		TEST_ASSERT(get_ucall(vm, VCPU_ID, NULL) == UCALL_SYNC,
> > +			    "Guest failed?");
> > +
> > +		cpu = sched_getcpu();
> > +		rseq_cpu = READ_ONCE(__rseq.cpu_id);
> > +
> > +		/*
> > +		 * Verify rseq's CPU matches sched's CPU, and that sched's CPU
> > +		 * is stable.  This doesn't handle the case where the task is
> > +		 * migrated between sched_getcpu() and reading rseq, and again
> > +		 * between reading rseq and sched_getcpu(), but in practice no
> > +		 * false positives have been observed, while on the other hand
> > +		 * blocking migration while this thread reads CPUs messes with
> > +		 * the timing and prevents hitting failures on a buggy kernel.
> > +		 */
> 
> I think you could get a stable cpu id between sched_getcpu and __rseq_abi.cpu_id
> if you add a pthread mutex to protect:
> 
> sched_getcpu and __rseq_abi.cpu_id  reads
> 
> vs
> 
> sched_setaffinity calls within the migration thread.
> 
> Thoughts ?

I tried that and couldn't reproduce the bug.  That's what I attempted to call out
in the blurb "blocking migration while this thread reads CPUs ... prevents hitting
failures on a buggy kernel".

I considered adding arbitrary delays around the mutex to try and hit the bug, but
I was worried that even if I got it "working" for this bug, the test would be too
tailored to this bug and potentially miss future regression.  Letting the two
threads run wild seemed like it would provide the best coverage, at the cost of
potentially causing to false failures.
