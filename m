Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6C2A7A160C
	for <lists+linux-csky@lfdr.de>; Fri, 15 Sep 2023 08:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjIOG0d (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 15 Sep 2023 02:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjIOG0d (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 15 Sep 2023 02:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7DC11FE0
        for <linux-csky@vger.kernel.org>; Thu, 14 Sep 2023 23:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694759142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9+jnNNi5vRzRYE59Q36xUOPPsHIe6r3BvoxI49Al2Kk=;
        b=ex9P29ftQON9ujoep4VfLpQZ+ZuXB/JteIYz/wbuhk4yHJQjjA+Oxg41pYIzuAnl0Ir+gf
        c1StUgdoM65K0HCcIz5kMC4PP8gpxFT2cJuhL4IHouyBvKLVQC4EKQfmENNGPr44FKyeXK
        Oobx4sjKlQ6e2LRRK3XKf6iusAE2qhY=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-s1C-19XkPJmEmeauphttDQ-1; Fri, 15 Sep 2023 02:25:40 -0400
X-MC-Unique: s1C-19XkPJmEmeauphttDQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3aa0fabef2cso2306102b6e.1
        for <linux-csky@vger.kernel.org>; Thu, 14 Sep 2023 23:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694759139; x=1695363939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+jnNNi5vRzRYE59Q36xUOPPsHIe6r3BvoxI49Al2Kk=;
        b=CbeqwmmduAJwgznfBETQChvzJ6qLZY7aWr0QsHuLSJVWHYZsk2kuYLJiAaU5qk5FSx
         Pw0QMjkUtffShOUXpkWCx3yKol3oqMQniF9DT1Gv/wBYMQGAykr1dUzYrkol9AFtLSqu
         rcnIe7jKmWtelpFiR9rQL05abjY287ItyQQ+n+cMSluOIPKVoddThicoTfhxokk98F/Y
         NGyfr22mPbeQnxNU3up8zPJMojkChln/LzBU1VcKeTH4UH57tF2FJJYJ6VKgS9IRQ22R
         ZF763V8nm0GGD8H3hUglfFlYKWjp98nUuUIGCzc2fzAq4sdAC6X3ir8Av868GSxXMeaQ
         0UTw==
X-Gm-Message-State: AOJu0YxDVkLZ2D3W5rF97luqgcTGdu2Xx1cBUUI16qZli9U5oKnMXdf5
        s6q6E6A8K+2s9BpKeBVyZCj531vh+wel1/34P86g3V/lQrBpOS6K4jLaKaRrVnPfoySZ5wuwz42
        U25/m9bY6/p2JtcU2pLInvA==
X-Received: by 2002:a05:6808:b34:b0:3ac:ab36:2741 with SMTP id t20-20020a0568080b3400b003acab362741mr797317oij.53.1694759139624;
        Thu, 14 Sep 2023 23:25:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMHaFc+UC1EHaQRMbCwUpAmphXEf20cxE2AiOsjMs+KiUT0/fC2jPyxpfPcipU6ikyGrIg1Q==
X-Received: by 2002:a05:6808:b34:b0:3ac:ab36:2741 with SMTP id t20-20020a0568080b3400b003acab362741mr797288oij.53.1694759139377;
        Thu, 14 Sep 2023 23:25:39 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id e27-20020a05680809bb00b003a37372e6b2sm1294124oig.21.2023.09.14.23.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 23:25:38 -0700 (PDT)
Date:   Fri, 15 Sep 2023 03:25:29 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     guoren@kernel.org
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 14/17] RISC-V: paravirt: pvqspinlock: Add kconfig
 entry
Message-ID: <ZQP42f5SC2ecaAKE@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-15-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910082911.3378782-15-guoren@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sun, Sep 10, 2023 at 04:29:08AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Add kconfig entry for paravirt_spinlock, an unfair qspinlock
> virtualization-friendly backend, by halting the virtual CPU rather
> than spinning.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig         | 12 ++++++++++++
>  arch/riscv/kernel/Makefile |  1 +
>  2 files changed, 13 insertions(+)
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4bcff2860f48..ec0da24ed6fb 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -813,6 +813,18 @@ config RELOCATABLE
>  
>            If unsure, say N.
>  
> +config PARAVIRT_SPINLOCKS
> +	bool "Paravirtualization layer for spinlocks"
> +	depends on QUEUED_SPINLOCKS
> +	default y
> +	help
> +	  Paravirtualized spinlocks allow a unfair qspinlock to replace the
> +	  test-set kvm-guest virt spinlock implementation with something
> +	  virtualization-friendly, for example, halt the virtual CPU rather
> +	  than spinning.
> +
> +	  If you are unsure how to answer this question, answer Y.
> +
>  endmenu # "Kernel features"
>  
>  menu "Boot options"
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 671ad85f28f2..114b29234c46 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -103,3 +103,4 @@ obj-$(CONFIG_ARCH_RV64ILP32)	+= compat_signal.o
>  
>  obj-$(CONFIG_64BIT)		+= pi/
>  obj-$(CONFIG_ACPI)		+= acpi.o
> +obj-$(CONFIG_PARAVIRT_SPINLOCKS) += qspinlock_paravirt.o
> -- 
> 2.36.1
> 

LGTM:
Reviewed-by: Leonardo Bras <leobras@redhat.com>

Thanks!
Leo

