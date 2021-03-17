Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EC633E7CA
	for <lists+linux-csky@lfdr.de>; Wed, 17 Mar 2021 04:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhCQDlI (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 16 Mar 2021 23:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhCQDkk (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 16 Mar 2021 23:40:40 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04DAC061760
        for <linux-csky@vger.kernel.org>; Tue, 16 Mar 2021 20:40:39 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bt4so339266pjb.5
        for <linux-csky@vger.kernel.org>; Tue, 16 Mar 2021 20:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=t280vDZQWk0iZZ+xQFR7BI6xACbsATSb7UzAA7K2/a0=;
        b=Humdt9srb74JTFtTLWQFozZx4MkuAbxcuC0K/hAZ5mVCgDHroQ+B5lp/tFiHSs+1fB
         38gITDQeMM6jaALv1oRJIz5cyKYq/Klf5POvfPvYtHVUeU3zrlO27iPji+39hoa5tAfi
         PWVpnulycTQuCx4y5nsc0oV4FK4GErfmmnFNxAl1GKnhOfAr223cbIpIXY0qcBi/h/q6
         VgrM8+ttoNi4HncnjFBaJKF04RnkD2OL7B2k/kMDKinkug3q9vebo84Bq4mJ0LaTv/bU
         7npOzBfb0uicwUxurpmoO4aR08rauCjmBjyyBiS46a7dVMNmHkq3ANaOSjgqKGnRbTFe
         2ZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=t280vDZQWk0iZZ+xQFR7BI6xACbsATSb7UzAA7K2/a0=;
        b=ONRDJGXSxVKRvJUkdV37WQm+3v2ffBQw7m92Vrk2oDlAdAluVqzOSgc1Vw84VJehnk
         0TSz1WYLcrlS3QRg5AI6MQL/R7BD92digFvLvtaAMvEDdsQyq1VRZ6O1H2FP7lBYUUsp
         PC7q0SvJHHF3vdwjkMAT4rAsEruY+Ec2AicWDoc9+tRBp+dFGbPy1ZiQUttaLaQuAWcE
         L4hRUqcFQc0/+CPHdSechuaL2ArD59zoIO4Zp0fjz+qTR5K11Up40IjBHDlAEnrbX5Db
         d8FpPQR/MZO9e6cznS41yuTu2U7KXkTTCarRCKZC9vxT3SlH8TB+fId7S/h1CMMK3Sro
         GN6w==
X-Gm-Message-State: AOAM531IvfDcj45z778xnElKyQmESMIy0KH0N+kOOEhXaNj9GUZvWXgl
        b2eH2UFfmMgc5TQOU0M+7bIhUw==
X-Google-Smtp-Source: ABdhPJw+fTIoWjUDX5CUuSKCp+cvthbxVN3kxlUImWClYDjMZlRLuSxvAy55TEc3ABlo9funImT0rQ==
X-Received: by 2002:a17:902:ed41:b029:e5:c92d:ec24 with SMTP id y1-20020a170902ed41b02900e5c92dec24mr2356365plb.57.1615952439246;
        Tue, 16 Mar 2021 20:40:39 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s200sm17957184pfs.53.2021.03.16.20.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 20:40:38 -0700 (PDT)
Date:   Tue, 16 Mar 2021 20:40:38 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Mar 2021 20:40:31 PDT (-0700)
Subject:     Re: [PATCH 2/2] riscv: Enable generic clockevent broadcast
In-Reply-To: <20210307022446.63732-2-guoren@kernel.org>
CC:     Arnd Bergmann <arnd@arndb.de>, guoren@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        guoren@linux.alibaba.com, tglx@linutronix.de,
        daniel.lezcano@linaro.org, Anup Patel <Anup.Patel@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>, greentime.hu@sifive.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-25b45eaf-1d0b-4292-9228-1ac3ac68832b@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sat, 06 Mar 2021 18:24:46 PST (-0800), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> When percpu-timers are stopped by deep power saving mode, we
> need system timer help to broadcast IPI_TIMER.
>
> This is first introduced by broken x86 hardware, where the local apic
> timer stops in C3 state. But many other architectures(powerpc, mips,
> arm, hexagon, openrisc, sh) have supported the infrastructure to
> deal with Power Management issues.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Anup Patel <anup.patel@wdc.com>
> Cc: Atish Patra <atish.patra@wdc.com>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> Cc: Greentime Hu <greentime.hu@sifive.com>
> ---
>  arch/riscv/Kconfig      |  2 ++
>  arch/riscv/kernel/smp.c | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 85d626b8ce5e..8637e7344abe 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -28,6 +28,7 @@ config RISCV
>  	select ARCH_HAS_SET_DIRECT_MAP
>  	select ARCH_HAS_SET_MEMORY
>  	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
> +	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
>  	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> @@ -39,6 +40,7 @@ config RISCV
>  	select EDAC_SUPPORT
>  	select GENERIC_ARCH_TOPOLOGY if SMP
>  	select GENERIC_ATOMIC64 if !64BIT
> +	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
>  	select GENERIC_EARLY_IOREMAP
>  	select GENERIC_GETTIMEOFDAY if HAVE_GENERIC_VDSO
>  	select GENERIC_IOREMAP
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index ea028d9e0d24..8325d33411d8 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -9,6 +9,7 @@
>   */
>
>  #include <linux/cpu.h>
> +#include <linux/clockchips.h>
>  #include <linux/interrupt.h>
>  #include <linux/module.h>
>  #include <linux/profile.h>
> @@ -27,6 +28,7 @@ enum ipi_message_type {
>  	IPI_CALL_FUNC,
>  	IPI_CPU_STOP,
>  	IPI_IRQ_WORK,
> +	IPI_TIMER,
>  	IPI_MAX
>  };
>
> @@ -176,6 +178,12 @@ void handle_IPI(struct pt_regs *regs)
>  			irq_work_run();
>  		}
>
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> +		if (ops & (1 << IPI_TIMER)) {
> +			stats[IPI_TIMER]++;
> +			tick_receive_broadcast();
> +		}
> +#endif
>  		BUG_ON((ops >> IPI_MAX) != 0);
>
>  		/* Order data access and bit testing. */
> @@ -192,6 +200,7 @@ static const char * const ipi_names[] = {
>  	[IPI_CALL_FUNC]		= "Function call interrupts",
>  	[IPI_CPU_STOP]		= "CPU stop interrupts",
>  	[IPI_IRQ_WORK]		= "IRQ work interrupts",
> +	[IPI_TIMER]		= "Timer broadcast interrupts",
>  };
>
>  void show_ipi_stats(struct seq_file *p, int prec)
> @@ -217,6 +226,13 @@ void arch_send_call_function_single_ipi(int cpu)
>  	send_ipi_single(cpu, IPI_CALL_FUNC);
>  }
>
> +#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
> +void tick_broadcast(const struct cpumask *mask)
> +{
> +	send_ipi_mask(mask, IPI_TIMER);
> +}
> +#endif
> +
>  void smp_send_stop(void)
>  {
>  	unsigned long timeout;

Thanks, this is on for-next.
