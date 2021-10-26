Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BB543BE18
	for <lists+linux-csky@lfdr.de>; Wed, 27 Oct 2021 01:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbhJZXug (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 26 Oct 2021 19:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbhJZXuf (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 26 Oct 2021 19:50:35 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955EEC061570
        for <linux-csky@vger.kernel.org>; Tue, 26 Oct 2021 16:48:11 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id v16so680152ple.9
        for <linux-csky@vger.kernel.org>; Tue, 26 Oct 2021 16:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=njkqslFi81CJdgjpKZ7lE+Q4NAM4QezMjn79c9rwW5I=;
        b=yFhDg/St14S+JDyXq1zwYeKBE7rKhdYF5Zw3ZgGu4s1uaqfuZ0/bYQX1NECpjNzGq4
         wAM2ynstuBaRQAZx5AXhAWAKiSpv5XwruTRmn0f6EDokEdhN1eeLaYi7lJs7mDbopAaz
         7sCQUnYsUbUJ5YFDwl1acbZCre3GkfxoIzyZBoJ2YDbnxCbe9j6X+eFDAjWcZI/Po8Do
         EykTs0QggjLE4JX+GkQ6825B038xMW+JIUUeBtpKTyevs0tgoDRRWRi/vHX8g2B34AyJ
         GZTz43gHVYLExc9thO9e6wAs1nLbTFz1Xvs2R6LkqhyTk4Id1tTnoJC5bOz/lNb0aCGu
         KmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=njkqslFi81CJdgjpKZ7lE+Q4NAM4QezMjn79c9rwW5I=;
        b=RIJodDeFwQfxyWVm41cKP6tDL8lQl/GE+HxVmHpKSezE6LGhZz6+Z68MkvGenTgJyB
         YlkSPu75dnsXkWXm9hRQvN9ps/mFR+KI882047b8Ni9i1GfTYnH5p1C/XJ0mlC0mIwpv
         C0N0WfscCnIQazC0XdpNhU7uuPS58QsOt/MwWt/tEBuiSx031msoaPbqL4psXZf6m1HE
         iugqBtBifbx77pZT0JjJbTZ1Dkj53DRxKkR5YDhGWqdL698N3QWH6mRZLqjHxqTO3TXt
         TMJsBW73GWaAcYYuO02F38MzmXHnuBRw1Vr54n/NmdNQ3OPDPcBXoWrOrJZ2RcqmUHU5
         JG8A==
X-Gm-Message-State: AOAM530DoMwghMXP9f2TSbZVfeUG0tiiFCSHHgai2fEyrSQ3SpJV+S30
        qDkDLyB5wEGskViYVoFtIPfBuQ==
X-Google-Smtp-Source: ABdhPJyuv44a0itknKhOqmu4SkSph1yjSLOlDm2TgYU9DxwigHNlYFAslzREtZoefsT/F90ImhvUvQ==
X-Received: by 2002:a17:90a:4b85:: with SMTP id i5mr2110945pjh.25.1635292091032;
        Tue, 26 Oct 2021 16:48:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:5e10:676c:ab93:f48d:23ae])
        by smtp.gmail.com with ESMTPSA id i5sm20437959pgo.36.2021.10.26.16.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Oct 2021 16:48:10 -0700 (PDT)
Date:   Tue, 26 Oct 2021 16:48:10 -0700 (PDT)
X-Google-Original-Date: Tue, 26 Oct 2021 16:24:16 PDT (-0700)
Subject:     Re: [PATCH 0/2] ftrace: make sure preemption disabled on recursion testing
In-Reply-To: <8c7de46d-9869-aa5e-2bb9-5dbc2eda395e@linux.alibaba.com>
CC:     guoren@kernel.org, rostedt@goodmis.org, mingo@redhat.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, tglx@linutronix.de, bp@alien8.de,
        x86@kernel.org, hpa@zytor.com, jpoimboe@redhat.com,
        jikos@kernel.org, mbenes@suse.cz, pmladek@suse.com,
        joe.lawrence@redhat.com, colin.king@canonical.com,
        mhiramat@kernel.org, peterz@infradead.org, npiggin@gmail.com,
        jszhang@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        live-patching@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     yun.wang@linux.alibaba.com
Message-ID: <mhng-95994d12-e1d9-43b3-bef0-c5c844ffcf86@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Mon, 11 Oct 2021 22:39:16 PDT (-0700), yun.wang@linux.alibaba.com wrote:
> The testing show that perf_ftrace_function_call() are using
> smp_processor_id() with preemption enabled, all the checking
> on CPU could be wrong after preemption, PATCH 1/2 will fix
> that.
>
> Besides, as Peter point out, the testing of recursion within
> the section between ftrace_test_recursion_trylock()/_unlock()
> pair also need the preemption disabled as the documentation
> explained, PATCH 2/2 will make sure on that.
>
> Michael Wang (2):
>   ftrace: disable preemption on the testing of recursion
>   ftrace: prevent preemption in perf_ftrace_function_call()
>
>  arch/csky/kernel/probes/ftrace.c     |  2 --
>  arch/parisc/kernel/ftrace.c          |  2 --
>  arch/powerpc/kernel/kprobes-ftrace.c |  2 --
>  arch/riscv/kernel/probes/ftrace.c    |  2 --
>  arch/x86/kernel/kprobes/ftrace.c     |  2 --
>  include/linux/trace_recursion.h      | 10 +++++++++-
>  kernel/livepatch/patch.c             |  6 ------
>  kernel/trace/trace_event_perf.c      | 17 +++++++++++++----
>  kernel/trace/trace_functions.c       |  5 -----
>  9 files changed, 22 insertions(+), 26 deletions(-)

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com> # RISC-V
