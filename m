Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEF98402AE5
	for <lists+linux-csky@lfdr.de>; Tue,  7 Sep 2021 16:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240383AbhIGOjn (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 7 Sep 2021 10:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbhIGOjm (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 7 Sep 2021 10:39:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E60C061575
        for <linux-csky@vger.kernel.org>; Tue,  7 Sep 2021 07:38:36 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id x19so8333989pfu.4
        for <linux-csky@vger.kernel.org>; Tue, 07 Sep 2021 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qhhCof7Bxt7WkPbfZU7ElxFgFbYJKUpmBYIoqT3FQG0=;
        b=dDM249O1jyYEP+sPZcNiaaYYByaEMpzFEK/dirlDIZo1llr4qtiA9AwONG4gfWFxuh
         GI+LHZeQL/xeGEQ7Yfkgt3/vvEePqhDwrmKdVjtWDvjOavLauOARfD2emyCkCFDIZ3e5
         RZJODDFiVIiw9T1gza4f7jn3IWawg1iNUGGJLjWdnuO+yJ9asXLrHQr2+tGWyM13pjym
         1+byStjxJrGiqSwx/wJlrs7mmw75bxC4tAQmD1XUWS2Kmf6OB7eQm5ViyURea6XHmtW+
         mck5xXQNXvsw8NgSA/A4XmTbdZUQ2dwVHhPiE7RfQH0O5+QpGIXptx+UdEU6zgDpgmg+
         vWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qhhCof7Bxt7WkPbfZU7ElxFgFbYJKUpmBYIoqT3FQG0=;
        b=eNhl1Iuepc8WIEqFxj/jP5cNHABlkfPLiIiCRG8Amqs6MadrcWr8cECzPVAKvu7jcu
         2UGI+pT+X2k9Sx/D74mW+edRLTda+/J5KiGtU42PaHl5/sKpd/UpA1DyGCTh99OFaoXF
         eWvn3XdpEKNRSIEcjikGedYrMt2gl82xnMBm2AUvVQ11B3nb0DYsJu5Zc/zwuFM2/0XI
         SJ+C7sm4zbUg2TkB7XHs9XNj6Tpt7r5Eq+FPyjVyJlwatW0WTHt1IcQzt9zVDG2v9UlS
         Y1pkeZWjZTrhfBmT7e5yL31wjf0NktcQyZFU6HW8LhhTVoiMaNu9UvLxqED+3yIa6jA/
         0mbA==
X-Gm-Message-State: AOAM532v8WXpCoZww/p8qLUu8iuKXSwZuchqoXF1ucsUSgo7mPtODoES
        Sb0DjvbCKE3XNBdIKUzjy1sEEQ==
X-Google-Smtp-Source: ABdhPJzl5tT+vIOlvAuqK2CqdOtw1QALWHjYejAcBedH1JDRDyFV2NrE6Q9L+J99MDm/UGDNVHbaHA==
X-Received: by 2002:a63:c10b:: with SMTP id w11mr17484810pgf.228.1631025516087;
        Tue, 07 Sep 2021 07:38:36 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j6sm13428682pgq.0.2021.09.07.07.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 07:38:35 -0700 (PDT)
Date:   Tue, 7 Sep 2021 14:38:31 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Russell King, ARM Linux" <linux@armlinux.org.uk>,
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
        shuah <shuah@kernel.org>,
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
Subject: Re: [PATCH 1/5] KVM: rseq: Update rseq when processing NOTIFY_RESUME
 on xfer to KVM guest
Message-ID: <YTd5Z91j9N2LuuIr@google.com>
References: <20210818001210.4073390-1-seanjc@google.com>
 <20210818001210.4073390-2-seanjc@google.com>
 <1673583543.19718.1629409152244.JavaMail.zimbra@efficios.com>
 <YR7tzZ98XC6OV2vu@google.com>
 <1872633041.20290.1629485463253.JavaMail.zimbra@efficios.com>
 <425456d3-4772-2a1b-9cf3-a5b750b95c2e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425456d3-4772-2a1b-9cf3-a5b750b95c2e@redhat.com>
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Mon, Sep 06, 2021, Paolo Bonzini wrote:
> On 20/08/21 20:51, Mathieu Desnoyers wrote:
> > > Ah, or is it the case that rseq_cs is non-NULL if and only if userspace is in an
> > > rseq critical section, and because syscalls in critical sections are illegal, by
> > > definition clearing rseq_cs is a nop unless userspace is misbehaving.
> > Not quite, as I described above. But we want it to stay set so the CONFIG_DEBUG_RSEQ
> > code executed when returning from ioctl to userspace will be able to validate that
> > it is not nested within a rseq critical section.
> > 
> > > If that's true, what about explicitly checking that at NOTIFY_RESUME?  Or is it
> > > not worth the extra code to detect an error that will likely be caught anyways?
> > The error will indeed already be caught on return from ioctl to userspace, so I
> > don't see any added value in duplicating this check.
> 
> Sean, can you send a v2 (even for this patch only would be okay)?

Made it all the way to v3 while you were out :-)

https://lkml.kernel.org/r/20210901203030.1292304-1-seanjc@google.com
