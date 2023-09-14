Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA157A07AB
	for <lists+linux-csky@lfdr.de>; Thu, 14 Sep 2023 16:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240319AbjINOr1 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 14 Sep 2023 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240293AbjINOr0 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 14 Sep 2023 10:47:26 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306AE1FC8
        for <linux-csky@vger.kernel.org>; Thu, 14 Sep 2023 07:47:22 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4018af103bcso7418515e9.1
        for <linux-csky@vger.kernel.org>; Thu, 14 Sep 2023 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1694702840; x=1695307640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHpWmHejf9EicOnbuTpXQSbFe9gmT4JUPIXQ/pQhLLs=;
        b=OICqe2J+pAU/Tw1th392fVmAUa+8T60710r04130hvuY9Irz3uPklqPCNYiKH4N5tp
         xaJWWXHhj5/wE040hJ9kSMtiEtj3yLpwmlXy4G9+5zTfiBd10Qt5CSsICqywQijxFcRW
         je8Xf8KvgNIImwjEAQuKAwCKVvicotgOFQeKFpUVHsE58ly20i+nAxdQOyxX1bckKLXK
         U0mVstkxeoV8WKZulfztUojq62+BLhyKlN2vYfkEjX2I+ieKe6sjku4C6BOEivTOZvc4
         YWItytRxlm2VXgACWpOT9Y1q0CcvybbeOAxnvdP4ERRnggf+1Efu6xg17KaLkV8nSEM8
         Kp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694702840; x=1695307640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHpWmHejf9EicOnbuTpXQSbFe9gmT4JUPIXQ/pQhLLs=;
        b=tw65IqCbcgpc3xRLnzw+vTQfMzgmf09ww/NHEDm22e33MHI8GcJ+BftszYaO8mAbeg
         MrqH/2RCQObARkoPwU3cfEG7SzdaBPS4mvRzBZL7xPLXG7BIZfVm4/mWbIrpyhFCRe4r
         VXhrvFofEcn9gKWrbmZYMfc0Y3zkA3R3zowIQsnLWv7PgsxJ5AEsF9VkZAhZ+xOWjAaq
         r1+TGZPDpI5bmx6II6h/e9tuu4H4cYaHI3vTY5D2lvH90e/n6OeBqBNazS2XUFy8q2Bl
         4UcnI4UW2WSMi+XQpNpl/gJG32pXPG63Iet8vk77PWD7h+KrLE8+nAs8i/aleftcmZxu
         ewbQ==
X-Gm-Message-State: AOJu0YwbpzBTw9jQ9iilLNU4c1DBShMytAaAEgRjusRcezV7qxLRgFDe
        0DuGLPYxjJb2S2u907I0wyJFjQ==
X-Google-Smtp-Source: AGHT+IE4vnDXBqfwShidPjq/u140Nh9Lf+YfW3WjJy+bEdPvCUxsYsEPIWnZNVPkTVSDMOA9EX84Jw==
X-Received: by 2002:a05:600c:895:b0:401:b393:da18 with SMTP id l21-20020a05600c089500b00401b393da18mr1795468wmp.6.1694702840548;
        Thu, 14 Sep 2023 07:47:20 -0700 (PDT)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id n7-20020a7bcbc7000000b003fef3180e7asm4996897wmi.44.2023.09.14.07.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 07:47:19 -0700 (PDT)
Date:   Thu, 14 Sep 2023 16:47:18 +0200
From:   Andrew Jones <ajones@ventanamicro.com>
To:     guoren@kernel.org
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, jszhang@kernel.org, wefu@redhat.com,
        wuwei2016@iscas.ac.cn, leobras@redhat.com,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 03/17] riscv: Use Zicbop in arch_xchg when available
Message-ID: <20230914-74d0cf00633c199758ee3450@orel>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-4-guoren@kernel.org>
 <20230914-892327a75b4b86badac5de02@orel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914-892327a75b4b86badac5de02@orel>
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Thu, Sep 14, 2023 at 04:25:53PM +0200, Andrew Jones wrote:
> On Sun, Sep 10, 2023 at 04:28:57AM -0400, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> > 
> > Cache-block prefetch instructions are HINTs to the hardware to
> > indicate that software intends to perform a particular type of
> > memory access in the near future. Enable ARCH_HAS_PREFETCHW and
> > improve the arch_xchg for qspinlock xchg_tail.
> > 
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> >  arch/riscv/Kconfig                 | 15 +++++++++++++++
> >  arch/riscv/include/asm/cmpxchg.h   |  4 +++-
> >  arch/riscv/include/asm/hwcap.h     |  1 +
> >  arch/riscv/include/asm/insn-def.h  |  5 +++++
> >  arch/riscv/include/asm/processor.h | 13 +++++++++++++
> >  arch/riscv/kernel/cpufeature.c     |  1 +
> >  6 files changed, 38 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > index e9ae6fa232c3..2c346fe169c1 100644
> > --- a/arch/riscv/Kconfig
> > +++ b/arch/riscv/Kconfig
> > @@ -617,6 +617,21 @@ config RISCV_ISA_ZICBOZ
> >  
> >  	   If you don't know what to do here, say Y.
> >  
> > +config RISCV_ISA_ZICBOP
> 
> Even if we're not concerned with looping over blocks yet, I think we
> should introduce zicbop block size DT parsing at the same time we bring
> zicbop support to the kernel (it's just more copy+paste from zicbom and
> zicboz). It's a bit annoying that the CMO spec doesn't state that block
> sizes should be the same for m/z/p. And, the fact that m/z/p are all
> separate extensions leads us to needing to parse block sizes for all
> three, despite the fact that in practice they'll probably be the same.

Although, I saw on a different mailing list that Andrei Warkentin
interpreted section 2.7 "Software Discovery" of the spec, which states

"""
The initial set of CMO extensions requires the following information to be
discovered by software:

* The size of the cache block for management and prefetch instructions
* The size of the cache block for zero instructions
* CBIE support at each privilege level

Other general cache characteristics may also be specified in the discovery
mechanism.
"""

as management and prefetch having the same block size and only zero
potentially having a different size. That looks like a reasonable
interpretation to me, too. So, we could maybe proceed with assuming we
can use zicbom_block_size for prefetch, for now. If a platform comes along
that interpreted the spec differently, requiring prefetch block size to
be specified separately, then we'll cross that bridge when we get there.

Thanks,
drew
