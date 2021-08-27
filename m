Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDD13F9DFF
	for <lists+linux-csky@lfdr.de>; Fri, 27 Aug 2021 19:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbhH0RYd (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 27 Aug 2021 13:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343493AbhH0RYW (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 27 Aug 2021 13:24:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A02C0612A4
        for <linux-csky@vger.kernel.org>; Fri, 27 Aug 2021 10:23:10 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id m26so6272149pff.3
        for <linux-csky@vger.kernel.org>; Fri, 27 Aug 2021 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pW2KRXINIECq2UqrMAjVuApe68m2StZHA9v7va6qTiU=;
        b=rYBmoVs975N+yu2934Kl7Ag8dNi2tkW5MPQBPsQWMJceqaAUViMJX5p8VTsmrLat2L
         1kJT1N4rNPJvHYN4v8xV4LZQQiN0gVYVxxZoK0AWZMQtgbtlsholocVLBSLsdQUjTc7K
         EO/n6pcBnNhyHknntLRnjl3c7dPZnYup1ZY4k8dYXcB6+XwMELnSDRN8GScTXVD9wLYw
         72HE/X1LKTlO7T9MyRzf3/jBybVrYz/zMXfVi26QTtQIvfOSsE3Kyet1JW3IoRhxG7Z4
         s9RsOEhsC/QREunQ94/foNgn4vxgTRk3Re13QZxXDPqu5Xx6dQ43rKJdU90h8PsbIabZ
         TDVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pW2KRXINIECq2UqrMAjVuApe68m2StZHA9v7va6qTiU=;
        b=Gsa2qvQYkGx2769FBORCA4oRPOZEp0NIDfNEme7xWIrerisFcDptZ5FnuyRliGUxbK
         rzBe3rRWaY2UqtVQ5nDKqLhDKN3nYp9FG9ZIGQ9AyOO+1PteKuxJWrsW/U5HynIfOM/G
         mK0YsDUsmfFNkVpER7A2A1VLNoD6Okf23tHjqZSYNbQMwcF6yVgSET5APQ2c5kvDekt4
         8Jh00ehbmEpBOt26Pyak64brhVwbhyYPTD2xUmjHhJOhrjaLe8gMUqyQKYrUdNGj3YHS
         SIBtQbVBNCJKo0/NV8ykFEEhU0AUOYNnz4OKHfN08BlPLA1MbRAEP53Qk9iw7Gt0hklc
         JsaA==
X-Gm-Message-State: AOAM530EDGoWBdgW1MPYirBnSpZcGJk/JUn+B/cdHSwvmXrAS1h9bM/j
        MjDVEenLKH+4QE6M5ltRFyZGcQ==
X-Google-Smtp-Source: ABdhPJz+T5dgH3sIVem/Dht2xu+EGET8qPyEg43yvrgPII1mSQTEgb7AA1JRyZkdBQMuVGObTA+XjQ==
X-Received: by 2002:a63:ef14:: with SMTP id u20mr8773852pgh.13.1630084990019;
        Fri, 27 Aug 2021 10:23:10 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id n24sm7386923pgv.60.2021.08.27.10.23.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 10:23:09 -0700 (PDT)
Date:   Fri, 27 Aug 2021 17:23:05 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Zhu Lingshan <lingshan.zhu@intel.com>
Cc:     peterz@infradead.org, pbonzini@redhat.com, bp@alien8.de,
        vkuznets@redhat.com, wanpengli@tencent.com, jmattson@google.com,
        joro@8bytes.org, kan.liang@linux.intel.com, ak@linux.intel.com,
        wei.w.wang@intel.com, eranian@google.com, liuxiangdong5@huawei.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, kvm@vger.kernel.org,
        like.xu.linux@gmail.com, boris.ostrvsky@oracle.com,
        Like Xu <like.xu@linux.intel.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Guo Ren <guoren@kernel.org>, Nick Hu <nickhu@andestech.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH V10 01/18] perf/core: Use static_call to optimize
 perf_guest_info_callbacks
Message-ID: <YSkfeXcd6nUT3AOJ@google.com>
References: <20210806133802.3528-1-lingshan.zhu@intel.com>
 <20210806133802.3528-2-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806133802.3528-2-lingshan.zhu@intel.com>
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Fri, Aug 06, 2021, Zhu Lingshan wrote:
> @@ -2944,18 +2966,21 @@ static unsigned long code_segment_base(struct pt_regs *regs)
>  
>  unsigned long perf_instruction_pointer(struct pt_regs *regs)
>  {
> -	if (perf_guest_cbs && perf_guest_cbs->is_in_guest())
> -		return perf_guest_cbs->get_guest_ip();
> +	unsigned long ip = static_call(x86_guest_get_ip)();
> +
> +	if (likely(!ip))

Pivoting on ip==0 isn't correct, it's perfectly legal for a guest to execute
from %rip=0.  Unless there's some static_call() magic that supports this with a
default function:
	
	if (unlikely(!static_call(x86_guest_get_ip)(&ip)))
		regs->ip + code_segment_base(regs)

	return ip;

The easiest thing is keep the existing:

	if (unlikely(static_call(x86_guest_state)()))
		return static_call(x86_guest_get_ip)();

	return regs->ip + code_segment_base(regs);

It's an extra call for PMIs in guest, but I don't think any of the KVM folks care
_that_ much about the performance in this case.

> +		ip = regs->ip + code_segment_base(regs);
>  
> -	return regs->ip + code_segment_base(regs);
> +	return ip;
>  }
