Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363792A835B
	for <lists+linux-csky@lfdr.de>; Thu,  5 Nov 2020 17:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbgKEQTV (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 5 Nov 2020 11:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgKEQTU (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 5 Nov 2020 11:19:20 -0500
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9824C0613CF
        for <linux-csky@vger.kernel.org>; Thu,  5 Nov 2020 08:19:20 -0800 (PST)
Received: by mail-il1-x141.google.com with SMTP id z2so1859014ilh.11
        for <linux-csky@vger.kernel.org>; Thu, 05 Nov 2020 08:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=NvlqX9EmzuvbQD0EDo3s7wdTkQzV0W8IHIgjH29O6kU=;
        b=K9baUop1I9NbilEWNi+1Y4G07G+VWNtOLjPeMBTn3gKy/xOE/TJTnRmip4uMz5rFOt
         OFJivFGy4O+u+vNppKLaE5SzapRwqFSTzuZT+aJnzLPRpa1qpjv+Q2dae6nz3lV1PfUL
         aISwP5tsuC0cKo0HQkDCLTbZ31mvWSzHeeFOuydUtf/VBqmq6IXk2HcZJl1OfDBWn2on
         Khq0Zw1PcjfUnF4eIfZEB1h/SGSWiiNRcMWtZDxmUVOdkF7UYfncfBHytkYGph5vMC3i
         zt6pvAi3lvorgZHLyPSmInfsBReMiQcZQXjSTw/jgNnlevPlxLT2o0UuTTqqr9eJS3su
         vAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NvlqX9EmzuvbQD0EDo3s7wdTkQzV0W8IHIgjH29O6kU=;
        b=Tyhsog+ox4tKr5Kh7NyonGqBrefdIu3ZbQjaIjpg0wOehFvZUgn0fnwtqYw3rdoDUm
         YnYnlYabOZAm9wUjJiTm8QoF0CWp3bgKm+cGG3/9pyDYWrxp3+MY4dZOchxeE8E6QfuW
         CCFyoxpMZk/BDKVs2CTLFQkxTJgg12tbtsTs19QsZjv0HzpcW089CG4/mWLYt8YTSeBA
         u6uxnucHqf3RNcd7oNlDOl0Al5XifmuR/kcfnqDmMLJmLzgAKNqdv6g5fJ+jq4AXFgAY
         b9NDE4qz3Q3lvd6Ck5hrsalF4SgxkO7D1SSB+mJUf9o1ZW21NDHY7AdHiigrRc6P5dT0
         IuqA==
X-Gm-Message-State: AOAM533vYDZ5GL2UH4cIurQdccxOFous/m9nk3nBVb94UXBvlAOtbVXz
        P6/DHSKxzik/x4tYpw2kvQ34owO4FHqNGQ==
X-Google-Smtp-Source: ABdhPJxALQLrXfXlns/PZynaEgnAJVODNZJ1SO6BniFSu7p9nbe9qiVsvji3NHxoT53M8eTPo7quaA==
X-Received: by 2002:a92:5b02:: with SMTP id p2mr2374584ilb.283.1604593159823;
        Thu, 05 Nov 2020 08:19:19 -0800 (PST)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id m9sm1315112ioj.54.2020.11.05.08.19.18
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 08:19:19 -0800 (PST)
Subject: Re: [PATCH] csky: add support for TIF_NOTIFY_SIGNAL
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-csky@vger.kernel.org
References: <4f498dfd-00eb-3f15-4529-672264fdab0f@kernel.dk>
Message-ID: <19e5bad9-2421-0f40-446f-23479b365477@kernel.dk>
Date:   Thu, 5 Nov 2020 09:19:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4f498dfd-00eb-3f15-4529-672264fdab0f@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Gentle nudge on this one.

On 10/29/20 10:13 AM, Jens Axboe wrote:
> Wire up TIF_NOTIFY_SIGNAL handling for csky.
> 
> Cc: linux-csky@vger.kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
> 
> 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
> for details:
> 
> https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/
> 
> As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
> as that will enable a set of cleanups once all of them support it. I'm
> happy carrying this patch if need be, or it can be funelled through the
> arch tree. Let me know.
> 
>  arch/csky/include/asm/thread_info.h | 5 ++++-
>  arch/csky/kernel/signal.c           | 2 +-
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
> index 68e7a1227170..21456a3737c2 100644
> --- a/arch/csky/include/asm/thread_info.h
> +++ b/arch/csky/include/asm/thread_info.h
> @@ -64,6 +64,7 @@ static inline struct thread_info *current_thread_info(void)
>  #define TIF_SYSCALL_TRACE	4	/* syscall trace active */
>  #define TIF_SYSCALL_TRACEPOINT	5       /* syscall tracepoint instrumentation */
>  #define TIF_SYSCALL_AUDIT	6	/* syscall auditing */
> +#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
>  #define TIF_POLLING_NRFLAG	16	/* poll_idle() is TIF_NEED_RESCHED */
>  #define TIF_MEMDIE		18      /* is terminating due to OOM killer */
>  #define TIF_RESTORE_SIGMASK	20	/* restore signal mask in do_signal() */
> @@ -75,6 +76,7 @@ static inline struct thread_info *current_thread_info(void)
>  #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
>  #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
>  #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
> +#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
>  #define _TIF_UPROBE		(1 << TIF_UPROBE)
>  #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
>  #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
> @@ -82,7 +84,8 @@ static inline struct thread_info *current_thread_info(void)
>  #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
>  
>  #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
> -				 _TIF_NOTIFY_RESUME | _TIF_UPROBE)
> +				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
> +				 _TIF_NOTIFY_SIGNAL)
>  
>  #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
>  				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP)
> diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
> index 8b068cf37447..37ea64ed3c12 100644
> --- a/arch/csky/kernel/signal.c
> +++ b/arch/csky/kernel/signal.c
> @@ -257,7 +257,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
>  		uprobe_notify_resume(regs);
>  
>  	/* Handle pending signal delivery */
> -	if (thread_info_flags & _TIF_SIGPENDING)
> +	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
>  		do_signal(regs);
>  
>  	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
> 


-- 
Jens Axboe

