Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C09BF4141D4
	for <lists+linux-csky@lfdr.de>; Wed, 22 Sep 2021 08:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbhIVGaa (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 22 Sep 2021 02:30:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232685AbhIVGaa (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Wed, 22 Sep 2021 02:30:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632292140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pJ7mY3KGJnt0GGObf9665ZCn7DQvGIxKlz9Hgzfe7VE=;
        b=Ah6F7aW5/exccYXC1OVMx5XAUJSgBfMU9UjQW3vy82NGWuB7IHHWUbst15q9aKgbi61m1R
        6xtU221qIfogFbksD81bH4UyMgm0TgzITsoPmxn35yTy+dSFgwUZI+QluwQbcauAFBXG8n
        5gL0qX9f/vf+qoNQX5SPW2JkhnRz5lI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-kNRCCmxBNeWzKYzhCkOkcg-1; Wed, 22 Sep 2021 02:28:59 -0400
X-MC-Unique: kNRCCmxBNeWzKYzhCkOkcg-1
Received: by mail-wr1-f72.google.com with SMTP id c2-20020adfa302000000b0015e4260febdso1103993wrb.20
        for <linux-csky@vger.kernel.org>; Tue, 21 Sep 2021 23:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pJ7mY3KGJnt0GGObf9665ZCn7DQvGIxKlz9Hgzfe7VE=;
        b=7u3N52gZOmpxdMcfwMbyLYhv7VPyZGXv4I97i1hu2vQ+Qty2mJohjhW14tkquRpi6S
         KrIlJwHteD/5CWTglI3MeVad80IS++yG3FyiVdt9r9Epb0oTGwVha/5dOXZfCNMvlR2j
         r5OqN5VnAJG57kE7jXVkrWMql1OaS4Loj6NamwcDfvxFJg3WZjkH3e4sUwGTGSUujnjr
         VATjZUpI5VgEWt3W/Q4fUI8VXlz/t3scbfbuGYs88B8LktHFd3jyH5xbKlJ8tX8Mv1t1
         nKdeFtUjNI++LeP9GAMv6Fpl7MNvlzuKTayVDp7byIpEXK7blpiXv/FM8wzZLzS/rUWA
         N07g==
X-Gm-Message-State: AOAM533VjaZSu3xlygla7kw2CDRehhDtY3eF9xouWORFeHKLrjQeIBo8
        2uBnfcjX57CteALO3/UXENPVbeyipDQzkkEciEm72PvQ6nXUXEoQIHqwYP8LtT+yeyqpGnwVIkI
        6rCiNEu6CtkKS+EBBuTAHIA==
X-Received: by 2002:a05:600c:3ba4:: with SMTP id n36mr8722412wms.35.1632292137440;
        Tue, 21 Sep 2021 23:28:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGUh0clwu4unN1cIXXPNEQKf8qlYc4JIONnRibnq73sMmW8cPrqysrS+MXk+0qjWI0DZnAvw==
X-Received: by 2002:a05:600c:3ba4:: with SMTP id n36mr8722395wms.35.1632292137204;
        Tue, 21 Sep 2021 23:28:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i18sm1136021wrn.64.2021.09.21.23.28.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 23:28:56 -0700 (PDT)
Subject: Re: [PATCH v3 06/16] perf/core: Rework guest callbacks to prepare for
 static_call support
To:     Sean Christopherson <seanjc@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>, Guo Ren <guoren@kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
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
        Like Xu <like.xu.linux@gmail.com>,
        Zhu Lingshan <lingshan.zhu@intel.com>
References: <20210922000533.713300-1-seanjc@google.com>
 <20210922000533.713300-7-seanjc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6636ab49-e21c-601f-9d2c-34e681c14faa@redhat.com>
Date:   Wed, 22 Sep 2021 08:28:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210922000533.713300-7-seanjc@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 22/09/21 02:05, Sean Christopherson wrote:
> To prepare for using static_calls to optimize perf's guest callbacks,
> replace ->is_in_guest and ->is_user_mode with a new multiplexed hook
> ->state, tweak ->handle_intel_pt_intr to play nice with being called when
> there is no active guest, and drop "guest" from ->is_in_guest.

... from ->get_guest_ip.  Code-wise,

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

