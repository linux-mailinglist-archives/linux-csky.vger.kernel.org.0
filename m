Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C9762DDF9
	for <lists+linux-csky@lfdr.de>; Thu, 17 Nov 2022 15:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbiKQOZe (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 17 Nov 2022 09:25:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240388AbiKQOZN (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 17 Nov 2022 09:25:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC877231
        for <linux-csky@vger.kernel.org>; Thu, 17 Nov 2022 06:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668695055;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nZPY6OJIRrwMZkBLytVOAK+0kIpEYMOqoTEpl19M6ws=;
        b=Jim0yvnQUkfXa64i8eZLemC9LJf1QHjxQQV0Q70jQsvjkgaHl2AN9g66wz2Hu/U+Y/Emqo
        u0kCZ8AH/Rzo0Vpkr6qIg3T29efgnSzuE5EgSqUEXSQ79Nf4MoiKgfIkuVOXe2pxojUFVH
        Fg9w20Aj1hhWTn39TXsYQ5VqoAOLzaY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-6-YshAfM-bOCKCp7VTXex8AA-1; Thu, 17 Nov 2022 09:24:11 -0500
X-MC-Unique: YshAfM-bOCKCp7VTXex8AA-1
Received: by mail-wr1-f69.google.com with SMTP id q2-20020adfab02000000b00241b8f7efc5so603039wrc.19
        for <linux-csky@vger.kernel.org>; Thu, 17 Nov 2022 06:24:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZPY6OJIRrwMZkBLytVOAK+0kIpEYMOqoTEpl19M6ws=;
        b=f6ZFwuXeruj+b6tn3icxvN6k3SrBrvmblxmXpwOcofa7pyeO6G9hEh0CmM/0grIF3K
         9avURnJ+EoI07JGBxBTMU/mV//U+D1byEaOncfncoxhlag2m6HRQO8poR0nptjfVDOhy
         pyffn3LePnmxDzQSleaPnVtDe8AhxkaLO535Zj2amP7LyyBhjMEYPn3e2lDNWroG8vOl
         yf/PoBlX+y5ywJ+vJosZZwJ1n1+BgUQrC3PwdB4L5U1lX8+xlK8sMLwivrztJjvnXKRm
         Hayr0NpbBfe8hG6UxqjxYsOoysDiJMYcZqCxwJtCuyjM0NdqoONq6bzw/e/vemFfpmIJ
         3QtQ==
X-Gm-Message-State: ANoB5pnAcsDsXPRXrnIzUBBqOWI6lAVZN+yrLiO3SlK2bD+KowEV1/Li
        k+IEaFVX+Vy9KJFPevOXC6bVzCLwGY3Xljv4MuPhNIKS50fOAFyAPsBmKQFlGhGhc8WCBF7ZndG
        NRNICqxa3v30KoRm0JzBTkA==
X-Received: by 2002:a05:600c:24e:b0:3c5:f9f1:f956 with SMTP id 14-20020a05600c024e00b003c5f9f1f956mr5602428wmj.50.1668695049914;
        Thu, 17 Nov 2022 06:24:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf660kXw1O9nDmBZzBp9eoh92b2B6Bcx05wnz8U6SS8Dy3l/finKWGNWkc/ihpfy4N9vMJHAMQ==
X-Received: by 2002:a05:600c:24e:b0:3c5:f9f1:f956 with SMTP id 14-20020a05600c024e00b003c5f9f1f956mr5602401wmj.50.1668695049758;
        Thu, 17 Nov 2022 06:24:09 -0800 (PST)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id v18-20020a5d6112000000b00236e834f050sm1095385wrt.35.2022.11.17.06.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 06:24:09 -0800 (PST)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org, Guo Ren <guoren@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [RFC PATCH v2 6/8] treewide: Trace IPIs sent via
 smp_send_reschedule()
In-Reply-To: <Y3X7CijMXpqQIHhk@hirez.programming.kicks-ass.net>
References: <20221102182949.3119584-1-vschneid@redhat.com>
 <20221102183336.3120536-5-vschneid@redhat.com>
 <Y3X7CijMXpqQIHhk@hirez.programming.kicks-ass.net>
Date:   Thu, 17 Nov 2022 14:24:04 +0000
Message-ID: <xhsmhiljdy7zv.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 17/11/22 10:12, Peter Zijlstra wrote:
> On Wed, Nov 02, 2022 at 06:33:34PM +0000, Valentin Schneider wrote:
>
>> diff --git a/kernel/smp.c b/kernel/smp.c
>> index c4d561cf50d45..44fa4b9b1f46b 100644
>> --- a/kernel/smp.c
>> +++ b/kernel/smp.c
>> @@ -167,6 +167,14 @@ send_call_function_ipi_mask(const struct cpumask *mask)
>>      arch_send_call_function_ipi_mask(mask);
>>  }
>>
>> +void smp_send_reschedule(int cpu)
>> +{
>> +	/* XXX scheduler_ipi is inline :/ */
>> +	trace_ipi_send_cpumask(cpumask_of(cpu), _RET_IP_, NULL);
>> +	arch_smp_send_reschedule(cpu);
>> +}
>> +EXPORT_SYMBOL_GPL(smp_send_reschedule);
>
> Yeah, no.. I see some crazy archs do this, but no we're not exporting
> this in generic.

So the list is: ia64, powerpc, riscv
and they all seem to do it because of KVM:
  c4cb768f0277 ("[IA64] export smp_send_reschedule")
  de56a948b918 ("KVM: PPC: Add support for Book3S processors in hypervisor mode")
  d3d7a0ce020e ("RISC-V: Export kernel symbols for kvm")

Other archs get out of it either because their smp_send_reschedule() is
inline (e.g. x86), or because they don't allow building KVM as a module
(e.g. arm64).

If I can cobble the tracepoint+reschedule in an inline helper, then that
wouldn't require any new exports - I'm fighting a bit with the header maze
ATM, but hopefully I can get somewhere with this.

