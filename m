Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A516B4113F5
	for <lists+linux-csky@lfdr.de>; Mon, 20 Sep 2021 14:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhITMHI (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Mon, 20 Sep 2021 08:07:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52655 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231474AbhITMHI (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Mon, 20 Sep 2021 08:07:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632139541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q8wAH/IsmVnI2ydhQ1BFoaOBGT1C6T31sGkkhWrMszg=;
        b=E5O5IYb3E/Ra/xlxED0QOc8QrPeCDxCsIi9ztHhZjYBOh6ejFUGPudbBXxiS/wHIdenNep
        qIFlUvG5zJwA+fqK3RXonYrssqDunAdP9q4HaYuW0GkV6Qxp86eISEvTcccX4DFIPFEpFG
        Kuo6tHq2RiDnvU1gHyMflYXobeoveWY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-9enR0z7cNbWU9nRa7CZ4PQ-1; Mon, 20 Sep 2021 08:05:40 -0400
X-MC-Unique: 9enR0z7cNbWU9nRa7CZ4PQ-1
Received: by mail-wr1-f70.google.com with SMTP id l9-20020adfc789000000b00160111fd4e8so636216wrg.17
        for <linux-csky@vger.kernel.org>; Mon, 20 Sep 2021 05:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q8wAH/IsmVnI2ydhQ1BFoaOBGT1C6T31sGkkhWrMszg=;
        b=fIUK5xMQ15bNbqwW6CTC+EIqQbsTygMqzuict1N+uoQ9wguo41ovaI9yCIcBBIypEf
         3+8criWmrsJ25wdKQ5rHd+Q1PciBYZufqzKHNb92+umxSkD6CXKSlmRF9Dke7Pd6qdHg
         rGLm0JUDkI0GJRdpAdgnbNdHafbbjqowG2xxUAwPWM/sCrQof6HbxNi9UijmpjndaRX7
         HQBrd7+iHA1WqAeG9gouf1VwPC0GKpFq8SCrtvmLJryXPpBYf6zhrQW9uUqw5830Yz3d
         IylvBhN2YsPNrqxz1MQKb2laAocF2leN9qWfRllS02EqeKzoT6fGFugN2yiLBom6IgR2
         PpGw==
X-Gm-Message-State: AOAM5315rSOV/bIgKFdhs/muFVAS2uwe3S4UwvhtoUQde2hBnFKi/80f
        6G3qdUVI9ZGn23t8ptj7YDiBhia3k9ce5n1E9BYtZy862QpmLc14CZ8QK3VJB7ce7KZGzHyF1DN
        vFc80TODloboESITFQKwXng==
X-Received: by 2002:a5d:4608:: with SMTP id t8mr28038937wrq.136.1632139538949;
        Mon, 20 Sep 2021 05:05:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz64XIPtY2fM12srCDcTMCwDqENNrjhBUdJzYmop3FKDPBAPZx+uh9ah7Isb2beeBqNbwRMJw==
X-Received: by 2002:a5d:4608:: with SMTP id t8mr28038880wrq.136.1632139538580;
        Mon, 20 Sep 2021 05:05:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id l15sm19128605wme.42.2021.09.20.05.05.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 05:05:37 -0700 (PDT)
To:     Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <seanjc@google.com>
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
References: <20210828003558.713983-1-seanjc@google.com>
 <20210828201336.GD4353@worktop.programming.kicks-ass.net>
 <YUO5J/jTMa2KGbsq@google.com>
 <YURDqVZ1UXKCiKPV@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 00/13] perf: KVM: Fix, optimize, and clean up callbacks
Message-ID: <662e93f9-e858-689d-d203-742731ecad2c@redhat.com>
Date:   Mon, 20 Sep 2021 14:05:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YURDqVZ1UXKCiKPV@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 17/09/21 09:28, Peter Zijlstra wrote:
>> In theory, I like the idea of burying intel_pt inside x86 (and even in
>> Intel+VMX code for the most part), but the actual implementation is a
>> bit gross.  Because of the whole "KVM can be a module" thing,
> 
> ARGH!! we should really fix that. I've heard other archs have made much
> better choices here.

I think that's only ARM, and even then it is only because of limitations 
of the hardware which mostly apply only if VHE is not in use.

If anything, it's ARM that should support module build in VHE mode 
(Linux would still need to know whether it will be running at EL1 or 
EL2, but KVM's functionality is as self-contained as on x86 in the VHE 
case).

Paolo

