Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3E2414B7E
	for <lists+linux-csky@lfdr.de>; Wed, 22 Sep 2021 16:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhIVOOV (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 22 Sep 2021 10:14:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236027AbhIVOOP (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Wed, 22 Sep 2021 10:14:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632319964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZMdBUFCcEro44m/VYQjrdo8tgcAaj3vpqrRJk30Xe4=;
        b=AfPwWbF8yLhbvlx4DgIh/0v6SBEVJG8wr1TRBpKZz9hAUT7+td02E7C1DbrWdaQwPNMfLq
        YkYJORZmIpKPKtsTaskMCRnc2MC9vhPV3HIa79JkkQtPf5vgmxfDI2ZlD/1+Q6X+N1Andl
        7cCs11/Uek2WDmmT8VDNq2zCYNr75Mo=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-204-xhyFs2HGOKWwgp1oH4uprg-1; Wed, 22 Sep 2021 10:12:43 -0400
X-MC-Unique: xhyFs2HGOKWwgp1oH4uprg-1
Received: by mail-ed1-f72.google.com with SMTP id o18-20020a056402439200b003d2b11eb0a9so3154746edc.23
        for <linux-csky@vger.kernel.org>; Wed, 22 Sep 2021 07:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rZMdBUFCcEro44m/VYQjrdo8tgcAaj3vpqrRJk30Xe4=;
        b=21I/1VtKaJlD0Ik40TgaZP31BnnD6Z/n8tcUxe/pciUsG3ndbdNOPF433LXNcyXAK7
         ZVQskAN1d9cb/0xuzCCi04/TmacEL+1Cl8l1iNI+s0a0DMK3YaiDqlc6kM4oJpO2jEgH
         WKxwcK1ALGRn8UNIL3i3v+9pc/jX8oNwdeW7lzyajsmg+u5g+u8gDv8NjRASVRKCli6t
         9h5oejf8sfBn4x8dc/fr72+KD0tbylq3F0lDurieoUcI+jhKIIpTODOevO3fCH3m6MZq
         BaqaZx/41epnvzyBzvGXFFf+t424M1rHxlrOsIS6HUC66jYIw+G5Jo0PZ6Cmd+Dsarji
         Q1/g==
X-Gm-Message-State: AOAM532YrOhsuaF2cs5hu+U6n2PNCBL2dH1Ua1iCuc6vs835VT0ackLO
        JIWvIzj5eGcIM1rQacPPTjpPb+bXdMSEufBmokF9Ko4NX1JfqD/GfWYzP4VGyF6kojT3sk1JS62
        vAqkBwOFryVc29gjVMV5GsA==
X-Received: by 2002:a17:906:b183:: with SMTP id w3mr41217079ejy.394.1632319961900;
        Wed, 22 Sep 2021 07:12:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDM/LAO92AMI8uC+ZsdL5tg3HWsAwfnbY471GXtr9Lv9ROvDMZHXi9azcQssuJ/zXZcmQ7Nw==
X-Received: by 2002:a17:906:b183:: with SMTP id w3mr41217031ejy.394.1632319961680;
        Wed, 22 Sep 2021 07:12:41 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id n23sm393858edw.75.2021.09.22.07.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Sep 2021 07:12:41 -0700 (PDT)
Subject: Re: [PATCH 0/5] KVM: rseq: Fix and a test for a KVM+rseq bug
To:     Sean Christopherson <seanjc@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Ben Gardon <bgardon@google.com>
References: <20210818001210.4073390-1-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <430684f9-1b35-b6f1-f243-6298e892bc7a@redhat.com>
Date:   Wed, 22 Sep 2021 16:12:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210818001210.4073390-1-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 18/08/21 02:12, Sean Christopherson wrote:
> Patch 1 fixes a KVM+rseq bug where KVM's handling of TIF_NOTIFY_RESUME,
> e.g. for task migration, clears the flag without informing rseq and leads
> to stale data in userspace's rseq struct.
> 
> Patch 2 is a cleanup to try and make future bugs less likely.  It's also
> a baby step towards moving and renaming tracehook_notify_resume() since
> it has nothing to do with tracing.  It kills me to not do the move/rename
> as part of this series, but having a dedicated series/discussion seems
> more appropriate given the sheer number of architectures that call
> tracehook_notify_resume() and the lack of an obvious home for the code.
> 
> Patch 3 is a fix/cleanup to stop overriding x86's unistd_{32,64}.h when
> the include path (intentionally) omits tools' uapi headers.  KVM's
> selftests do exactly that so that they can pick up the uapi headers from
> the installed kernel headers, and still use various tools/ headers that
> mirror kernel code, e.g. linux/types.h.  This allows the new test in
> patch 4 to reference __NR_rseq without having to manually define it.
> 
> Patch 4 is a regression test for the KVM+rseq bug.
> 
> Patch 5 is a cleanup made possible by patch 3.
> 
> 
> Sean Christopherson (5):
>    KVM: rseq: Update rseq when processing NOTIFY_RESUME on xfer to KVM
>      guest
>    entry: rseq: Call rseq_handle_notify_resume() in
>      tracehook_notify_resume()
>    tools: Move x86 syscall number fallbacks to .../uapi/
>    KVM: selftests: Add a test for KVM_RUN+rseq to detect task migration
>      bugs
>    KVM: selftests: Remove __NR_userfaultfd syscall fallback
> 
>   arch/arm/kernel/signal.c                      |   1 -
>   arch/arm64/kernel/signal.c                    |   1 -
>   arch/csky/kernel/signal.c                     |   4 +-
>   arch/mips/kernel/signal.c                     |   4 +-
>   arch/powerpc/kernel/signal.c                  |   4 +-
>   arch/s390/kernel/signal.c                     |   1 -
>   include/linux/tracehook.h                     |   2 +
>   kernel/entry/common.c                         |   4 +-
>   kernel/rseq.c                                 |   4 +-
>   .../x86/include/{ => uapi}/asm/unistd_32.h    |   0
>   .../x86/include/{ => uapi}/asm/unistd_64.h    |   3 -
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   3 +
>   tools/testing/selftests/kvm/rseq_test.c       | 131 ++++++++++++++++++
>   14 files changed, 143 insertions(+), 20 deletions(-)
>   rename tools/arch/x86/include/{ => uapi}/asm/unistd_32.h (100%)
>   rename tools/arch/x86/include/{ => uapi}/asm/unistd_64.h (83%)
>   create mode 100644 tools/testing/selftests/kvm/rseq_test.c
> 

Queued v3, thanks.  I'll send it in a separate pull request to Linus 
since it touches stuff outside my usual turf.

Thanks,

Paolo

