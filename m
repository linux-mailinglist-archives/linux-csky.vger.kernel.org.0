Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF63C4137BD
	for <lists+linux-csky@lfdr.de>; Tue, 21 Sep 2021 18:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbhIUQqI (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 21 Sep 2021 12:46:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229499AbhIUQqH (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Tue, 21 Sep 2021 12:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632242678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MOh25Z0CXinUksqYDluCoredOuFNiGvVHCwdZh/BTA=;
        b=fMQBRvFbKUREv2fA+AGvkCsmlbU6zexpDH0XZ7f9S+6tOtWrksGDgEYq1tJD5g/1pJpAQq
        NHx71FG/3pPj+hPpQHV/wluvJjANYWDxvg7ZaRm3yIhXhA62L9X0LzWiTFHHhN7KL3a8tk
        6O8nSkJsGIEhmzcttRNJ67nAEZ8utTA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-VfpabcVXMtaHl3d7SJA-Aw-1; Tue, 21 Sep 2021 12:44:37 -0400
X-MC-Unique: VfpabcVXMtaHl3d7SJA-Aw-1
Received: by mail-wr1-f72.google.com with SMTP id m18-20020adfe952000000b0015b0aa32fd6so9332320wrn.12
        for <linux-csky@vger.kernel.org>; Tue, 21 Sep 2021 09:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2MOh25Z0CXinUksqYDluCoredOuFNiGvVHCwdZh/BTA=;
        b=posyiQ78tHUALPMGnRnSZbTWlmiQZ6+95VRcM4sDY0mg0r54NVjkoVipeeAG/3mUCU
         WwMEzk82LUen4Xi8zWwK+POHcsldRm6JD0GPl2zv9amGC5wnbAiCu9fV01LWG1LiBtqN
         1iXHyUpqwKuKwPKIH8lqyb5Bjrcm92vIS4Kgk0M6TxXyP98dj9TB2Qv5gqW652nafZUy
         Gbam3bHq0i6WtAs6qRzm7S3UsiRiFpsnfbrkT4yolmoQsfwZKaxY6l60DDs3zhVks5vu
         OE8+8fUDPQfvAqe7h85AKCSMPPsBXWOj0wzOiNulosrcEuo+rgGd06xNsFJ34jge+rdq
         CXHA==
X-Gm-Message-State: AOAM531Lh2E+ucFzHw8CQZMZwBXMDmKXTmrfhyhSOMX1hHJAD4uWg7S6
        uLb2Puz1w0leSqnUNcj1Tl544MmrvwGQg1F8BYbBDezsgs1JDbPcHyvo1ELncT6xnzBJRFevCbY
        riw4r60uO2jtNlBQzvEKGRg==
X-Received: by 2002:adf:ef02:: with SMTP id e2mr35671889wro.401.1632242676303;
        Tue, 21 Sep 2021 09:44:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsCp5ZrdIqXk735XH8pFAzorkNCbfLAUPGTe1MtIGjUyvp4uSPpnZgIUWeU9z8tn602zxqYg==
X-Received: by 2002:adf:ef02:: with SMTP id e2mr35671861wro.401.1632242676096;
        Tue, 21 Sep 2021 09:44:36 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id k1sm20272243wrz.61.2021.09.21.09.44.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 09:44:35 -0700 (PDT)
Subject: Re: [PATCH v2 05/13] perf: Force architectures to opt-in to guest
 callbacks
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
 <20210828003558.713983-6-seanjc@google.com>
 <20210828194752.GC4353@worktop.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8ee13a69-f2c4-2413-2d6c-b6c0a559286e@redhat.com>
Date:   Tue, 21 Sep 2021 18:44:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210828194752.GC4353@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 28/08/21 21:47, Peter Zijlstra wrote:
>> +config HAVE_GUEST_PERF_EVENTS
>> +	bool
> 	depends on HAVE_KVM

It won't really do anything, since Kconfig does not detects conflicts 
between select' and 'depends on' clauses.

Rather, should the symbol be selected by KVM, instead of ARM64 and X86?

Paolo

