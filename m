Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4133E7B2
	for <lists+linux-csky@lfdr.de>; Wed, 17 Mar 2021 04:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbhCQDgQ (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 16 Mar 2021 23:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbhCQDgJ (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 16 Mar 2021 23:36:09 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAC8C06175F
        for <linux-csky@vger.kernel.org>; Tue, 16 Mar 2021 20:36:09 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so2483846pjb.0
        for <linux-csky@vger.kernel.org>; Tue, 16 Mar 2021 20:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=vgC4Hi1wlvfUamR+lmJh7JgDIUhelSU6Ukx+EhusVr8=;
        b=Gnx8QJNkZubSSIyu4WGdQec8Ajw0vvWuYdvfhDVqP7/7F/Z57lmQ5MThtB12qZYecE
         4ERfVxOn9an7bDs4FarZsNvAl1HKlaJ6ZwlO6KQTd0o1thIC2T191NBL/f+ZSg5AX8kn
         QLCAn7bmHEql+ZdPe4za5vCUVQacHBJRX4DuA7ybt9GHapatznswao4DWqwjEoE1+Ei3
         r3cayDqbinfJCWfQFAXEYCBsQ6i4i4FfLF77IPJLbsSkSTX4mS9LenT+OwfBn/cqKMoN
         1UuanW+nOKrqWL8LyoFcXPDO64EhOXQ90gf2lzYZ9bMO5w8zTPVCioRp3wdrhxMUXyJx
         /YIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=vgC4Hi1wlvfUamR+lmJh7JgDIUhelSU6Ukx+EhusVr8=;
        b=pVi+JeCPIY08GJM4QfuzZmM1p/gLjLeWRty9AQ4Fpgeh5fM5w4ALBlOYwLOTjn03qP
         T6jrUvuDSHRoOzuTfN05KfKmobigoqC2KqyGZc73VOeZZPxjLsMETfVncqILX0TP0wfy
         Tg5/1luyIvD5SSvbUZM/nBCTI8uil2bJfP3Kvr1vuao5qtqPFQvnVZid2kj93uk5ZY9E
         hp+uNu9kB0kuds4OJ+Jo4MHzmGNWuqPGO6ZIOlgerup0mZ3HbY4Fj0vPaMsJDrTZ+J5b
         6xh97X70ZLWEnFvi6Ufg7uDGTP252ceiDXzNTa4g/uCJlj7Rw434JBF7jGPtkzVO2xDM
         DIvQ==
X-Gm-Message-State: AOAM533HMW4y55RNIn2xxudu6KMGVpXrXu3eU35tE47iVWOSMw8VZhrz
        gSrXyTu7Ad4D0uvnY7ZGEJSAQw==
X-Google-Smtp-Source: ABdhPJw4lISaavZJujC21CQLMCa8XgLKbdbcKmBpGRJonPttIAH9wkgW/3AMFz4qmzc6iC1nUozPtQ==
X-Received: by 2002:a17:90b:1082:: with SMTP id gj2mr2223421pjb.155.1615952168886;
        Tue, 16 Mar 2021 20:36:08 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id bj15sm730816pjb.9.2021.03.16.20.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 20:36:08 -0700 (PDT)
Date:   Tue, 16 Mar 2021 20:36:08 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Mar 2021 20:33:59 PDT (-0700)
Subject:     Re: [PATCH 2/4] clocksource: riscv: Using CPUHP_AP_ONLINE_DYN
In-Reply-To: <1614608902-85038-2-git-send-email-guoren@kernel.org>
CC:     guoren@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-arch@vger.kernel.org, guoren@linux.alibaba.com,
        peterz@infradead.org, tglx@linutronix.de,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Anup Patel <Anup.Patel@wdc.com>, Christoph Hellwig <hch@lst.de>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-2d96ba73-2578-4f60-b81b-75da618ff41e@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Mon, 01 Mar 2021 06:28:20 PST (-0800), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Remove RISC-V clocksource custom definitions in hotplug.h:
>  - CPUHP_AP_RISCV_TIMER_STARTING
>
> For coding convention.
>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Tested-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Link: https://lore.kernel.org/lkml/CAHk-=wjM+kCsKqNdb=c0hKsv=J7-3Q1zmM15vp6_=8S5XfGMtA@mail.gmail.com/
> ---
>  drivers/clocksource/timer-riscv.c | 4 ++--
>  include/linux/cpuhotplug.h        | 1 -
>  2 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
> index c51c5ed..43aee27 100644
> --- a/drivers/clocksource/timer-riscv.c
> +++ b/drivers/clocksource/timer-riscv.c
> @@ -150,10 +150,10 @@ static int __init riscv_timer_init_dt(struct device_node *n)
>  		return error;
>  	}
>
> -	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
> +	error = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
>  			 "clockevents/riscv/timer:starting",
>  			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
> -	if (error)
> +	if (error < 0)
>  		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
>  		       error);
>  	return error;
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 14f49fd..f60538b 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -130,7 +130,6 @@ enum cpuhp_state {
>  	CPUHP_AP_MARCO_TIMER_STARTING,
>  	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
>  	CPUHP_AP_ARC_TIMER_STARTING,
> -	CPUHP_AP_RISCV_TIMER_STARTING,
>  	CPUHP_AP_CLINT_TIMER_STARTING,
>  	CPUHP_AP_CSKY_TIMER_STARTING,
>  	CPUHP_AP_HYPERV_TIMER_STARTING,

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Just like the previous one.  Presumably CLINT is ours as well?

Thanks!
