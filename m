Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7C87A5937
	for <lists+linux-csky@lfdr.de>; Tue, 19 Sep 2023 07:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231182AbjISFOq (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 19 Sep 2023 01:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjISFOp (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 19 Sep 2023 01:14:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196A5100
        for <linux-csky@vger.kernel.org>; Mon, 18 Sep 2023 22:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695100432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4GZT13TAwSFlgcmBEe3p4sewwUQikjB5LnKu1cjTHTo=;
        b=AZF+JRkJjFCB5cOGUJo/PPeEUmhPHts9xdaNmTQECk7l3eR6nBU1IGL1We6ksShpdMEpfg
        1LIz8UMdyNdMLIptPCL+ZPY3M52cz/rYyInKmkXuvwQ2cpN1T2ByftNuaQn1SiSmorFsiu
        6iSLbtgAbTQmKbJgNGbRxQukYtNizbs=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-qE1d9-hVOieFkE7JL_2PzQ-1; Tue, 19 Sep 2023 01:13:50 -0400
X-MC-Unique: qE1d9-hVOieFkE7JL_2PzQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6c0f174540cso7797758a34.2
        for <linux-csky@vger.kernel.org>; Mon, 18 Sep 2023 22:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695100430; x=1695705230;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4GZT13TAwSFlgcmBEe3p4sewwUQikjB5LnKu1cjTHTo=;
        b=IQ9iBbJkZGj5Rtrav4SZlsZoM+bViEd18kp+F6hEpL2aZZEfeUChvLWnx7qYweJ7aU
         I8XANJrIPFcIN66p/zeNsBtfEXYvOkLU6iv7YjT9bT0+4ljdAIRTULobxxv50zpCFJ2I
         Y/PRMVpgOaRb5I2/i+aKOwgYNZ3+z1tOklpObjlnghyqNIWm//WD0LP+HES0xAqYoFf3
         uS30Zx12/LuIeChaGn8alEW8SQYj8j9ZC3Bsz2EeIeUMwDuW4ygffd9nOx9ryi0G/dbV
         MDPH/GX2xR0wFZOJip4B4lghSbNsABBipWV8MTcI3dgc+2srzH7Sqfjs8vwA3WKDoYN+
         wKDw==
X-Gm-Message-State: AOJu0YwAPumkq5Dd6r+wa9HOyA0/EP2rGj3pBHYnNIQlMKmmmWDf/lth
        TCM5WWBRpRZBcSK374Zlr6KwQXOI7Z8YKHqloYCsgywdJjFTi70rZ8zVJ1ch7Fpk9y7IAd5Jxv9
        31ZXA+MKh1iQCxmMhMB/8hw==
X-Received: by 2002:a9d:4d85:0:b0:6bd:78a:460 with SMTP id u5-20020a9d4d85000000b006bd078a0460mr12957265otk.32.1695100429985;
        Mon, 18 Sep 2023 22:13:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5ILH35twxznQW0Ej6u7DI9g60WcJhE2TstDk41zWTR2DprqxjK01MIBFqaLSsyUqs0vRlGg==
X-Received: by 2002:a9d:4d85:0:b0:6bd:78a:460 with SMTP id u5-20020a9d4d85000000b006bd078a0460mr12957247otk.32.1695100429689;
        Mon, 18 Sep 2023 22:13:49 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:677d:42e9:f426:9422:f020])
        by smtp.gmail.com with ESMTPSA id q4-20020a9d7c84000000b006b45be2fdc2sm4759631otn.65.2023.09.18.22.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 22:13:49 -0700 (PDT)
Date:   Tue, 19 Sep 2023 02:13:39 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     Guo Ren <guoren@kernel.org>
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
Subject: Re: [PATCH V11 03/17] riscv: Use Zicbop in arch_xchg when available
Message-ID: <ZQkuA7WloWIIteVR@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-4-guoren@kernel.org>
 <ZQF3qS1KRYAt3coC@redhat.com>
 <CAJF2gTT5s2-vhgrxnkE1EGqJMvXn8ftYrrwRMdJH1tjEqAv5kQ@mail.gmail.com>
 <ZQUEEckIEbtxwLEG@redhat.com>
 <CAJF2gTQLBNy9uS4AF+UgD+ew3BN1dLs0f0+z0jzpieR75kv_Dw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTQLBNy9uS4AF+UgD+ew3BN1dLs0f0+z0jzpieR75kv_Dw@mail.gmail.com>
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

On Sun, Sep 17, 2023 at 10:34:36PM +0800, Guo Ren wrote:
> On Sat, Sep 16, 2023 at 9:25 AM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > On Fri, Sep 15, 2023 at 08:36:31PM +0800, Guo Ren wrote:
> > > On Wed, Sep 13, 2023 at 4:50 PM Leonardo Bras <leobras@redhat.com> wrote:
> > > >
> > > > On Sun, Sep 10, 2023 at 04:28:57AM -0400, guoren@kernel.org wrote:
> > > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > > >
> > > > > Cache-block prefetch instructions are HINTs to the hardware to
> > > > > indicate that software intends to perform a particular type of
> > > > > memory access in the near future. Enable ARCH_HAS_PREFETCHW and
> > > > > improve the arch_xchg for qspinlock xchg_tail.
> > > > >
> > > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > > ---
> > > > >  arch/riscv/Kconfig                 | 15 +++++++++++++++
> > > > >  arch/riscv/include/asm/cmpxchg.h   |  4 +++-
> > > > >  arch/riscv/include/asm/hwcap.h     |  1 +
> > > > >  arch/riscv/include/asm/insn-def.h  |  5 +++++
> > > > >  arch/riscv/include/asm/processor.h | 13 +++++++++++++
> > > > >  arch/riscv/kernel/cpufeature.c     |  1 +
> > > > >  6 files changed, 38 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > > index e9ae6fa232c3..2c346fe169c1 100644
> > > > > --- a/arch/riscv/Kconfig
> > > > > +++ b/arch/riscv/Kconfig
> > > > > @@ -617,6 +617,21 @@ config RISCV_ISA_ZICBOZ
> > > > >
> > > > >          If you don't know what to do here, say Y.
> > > > >
> > > > > +config RISCV_ISA_ZICBOP
> > > > > +     bool "Zicbop extension support for cache block prefetch"
> > > > > +     depends on MMU
> > > > > +     depends on RISCV_ALTERNATIVE
> > > > > +     default y
> > > > > +     help
> > > > > +        Adds support to dynamically detect the presence of the ZICBOP
> > > > > +        extension (Cache Block Prefetch Operations) and enable its
> > > > > +        usage.
> > > > > +
> > > > > +        The Zicbop extension can be used to prefetch cache block for
> > > > > +        read/write/instruction fetch.
> > > > > +
> > > > > +        If you don't know what to do here, say Y.
> > > > > +
> > > > >  config TOOLCHAIN_HAS_ZIHINTPAUSE
> > > > >       bool
> > > > >       default y
> > > > > diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
> > > > > index 702725727671..56eff7a9d2d2 100644
> > > > > --- a/arch/riscv/include/asm/cmpxchg.h
> > > > > +++ b/arch/riscv/include/asm/cmpxchg.h
> > > > > @@ -11,6 +11,7 @@
> > > > >
> > > > >  #include <asm/barrier.h>
> > > > >  #include <asm/fence.h>
> > > > > +#include <asm/processor.h>
> > > > >
> > > > >  #define __arch_xchg_masked(prepend, append, r, p, n)                 \
> > > > >  ({                                                                   \
> > > > > @@ -25,6 +26,7 @@
> > > > >                                                                       \
> > > > >       __asm__ __volatile__ (                                          \
> > > > >              prepend                                                  \
> > > > > +            PREFETCHW_ASM(%5)                                        \
> > > > >              "0:      lr.w %0, %2\n"                                  \
> > > > >              "        and  %1, %0, %z4\n"                             \
> > > > >              "        or   %1, %1, %z3\n"                             \
> > > > > @@ -32,7 +34,7 @@
> > > > >              "        bnez %1, 0b\n"                                  \
> > > > >              append                                                   \
> > > > >              : "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))       \
> > > > > -            : "rJ" (__newx), "rJ" (~__mask)                          \
> > > > > +            : "rJ" (__newx), "rJ" (~__mask), "rJ" (__ptr32b)         \
> > > > >              : "memory");                                             \
> > > > >                                                                       \
> > > > >       r = (__typeof__(*(p)))((__retx & __mask) >> __s);               \
> > > > > diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> > > > > index b7b58258f6c7..78b7b8b53778 100644
> > > > > --- a/arch/riscv/include/asm/hwcap.h
> > > > > +++ b/arch/riscv/include/asm/hwcap.h
> > > > > @@ -58,6 +58,7 @@
> > > > >  #define RISCV_ISA_EXT_ZICSR          40
> > > > >  #define RISCV_ISA_EXT_ZIFENCEI               41
> > > > >  #define RISCV_ISA_EXT_ZIHPM          42
> > > > > +#define RISCV_ISA_EXT_ZICBOP         43
> > > > >
> > > > >  #define RISCV_ISA_EXT_MAX            64
> > > > >
> > > > > diff --git a/arch/riscv/include/asm/insn-def.h b/arch/riscv/include/asm/insn-def.h
> > > > > index 6960beb75f32..dc590d331894 100644
> > > > > --- a/arch/riscv/include/asm/insn-def.h
> > > > > +++ b/arch/riscv/include/asm/insn-def.h
> > > > > @@ -134,6 +134,7 @@
> > > > >
> > > > >  #define RV_OPCODE_MISC_MEM   RV_OPCODE(15)
> > > > >  #define RV_OPCODE_SYSTEM     RV_OPCODE(115)
> > > > > +#define RV_OPCODE_PREFETCH   RV_OPCODE(19)
> > > > >
> > > > >  #define HFENCE_VVMA(vaddr, asid)                             \
> > > > >       INSN_R(OPCODE_SYSTEM, FUNC3(0), FUNC7(17),              \
> > > > > @@ -196,4 +197,8 @@
> > > > >       INSN_I(OPCODE_MISC_MEM, FUNC3(2), __RD(0),              \
> > > > >              RS1(base), SIMM12(4))
> > > > >
> > > > > +#define CBO_prefetchw(base)                                  \
> > > > > +     INSN_R(OPCODE_PREFETCH, FUNC3(6), FUNC7(0),             \
> > > > > +            RD(x0), RS1(base), RS2(x0))
> > > > > +
> > > >
> > > > I understand that here you create the instruction via bitfield, following
> > > > the ISA, and this enables using instructions not available on the
> > > > toolchain.
> > > >
> > > > It took me some time to find the document with this instruction, so please
> > > > add this to the commit msg:
> > > >
> > > > https://github.com/riscv/riscv-CMOs/blob/master/specifications/cmobase-v1.0.pdf
> > > > Page 23.
> > > >
> > > > IIUC, the instruction is "prefetch.w".
> > > >
> > > > Maybe I am missing something, but in the document the rs2 field
> > > > (PREFETCH.W) contains a 0x3, while the above looks to have a 0 instead.
> > > >
> > > > rs2 field = 0x0 would be a prefetch.i (instruction prefetch) instead.
> > > >
> > > > Is the above correct, or am I missing something?
> > > Oh, you are right. My fault, thx for pointing out. It should be:
> > > +       INSN_R(OPCODE_PREFETCH, FUNC3(6), FUNC7(0),             \
> > > +              RD(x0), RS1(base), RS2(x3))
> >
> > Now I am curious to check if / how will this impact performance. :)
> > (Please let me know)
> Ref:
> commit 0ea366f5e1b6 ("arm64: atomics: prefetch the destination word
> for write prior to stxr")
> commit 86d231459d6d ("bpf: cpumap memory prefetchw optimizations for
> struct page")

Oh, I understand that prefetch.w is very useful for performance :)

What I meant is that previously this patch was issuing a prefetch.i,
and now it's issuing a prefetch.w (as intended). 

What got me curious is how much would it impact the performance to change 
the prefetch.i to prefetch.w. :)

Thanks!
Leo


> 
> >
> >
> > >
> > > >
> > > >
> > > > Thanks!
> > > > Leo
> > > >
> > > > >  #endif /* __ASM_INSN_DEF_H */
> > > > > diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
> > > > > index de9da852f78d..7ad3a24212e8 100644
> > > > > --- a/arch/riscv/include/asm/processor.h
> > > > > +++ b/arch/riscv/include/asm/processor.h
> > > > > @@ -12,6 +12,8 @@
> > > > >  #include <vdso/processor.h>
> > > > >
> > > > >  #include <asm/ptrace.h>
> > > > > +#include <asm/insn-def.h>
> > > > > +#include <asm/hwcap.h>
> > > > >
> > > > >  #ifdef CONFIG_64BIT
> > > > >  #define DEFAULT_MAP_WINDOW   (UL(1) << (MMAP_VA_BITS - 1))
> > > > > @@ -103,6 +105,17 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
> > > > >  #define KSTK_EIP(tsk)                (ulong)(task_pt_regs(tsk)->epc)
> > > > >  #define KSTK_ESP(tsk)                (ulong)(task_pt_regs(tsk)->sp)
> > > > >
> > > > > +#define ARCH_HAS_PREFETCHW
> > > > > +#define PREFETCHW_ASM(base)  ALTERNATIVE(__nops(1), \
> > > > > +                                         CBO_prefetchw(base), \
> > > > > +                                         0, \
> > > > > +                                         RISCV_ISA_EXT_ZICBOP, \
> > > > > +                                         CONFIG_RISCV_ISA_ZICBOP)
> > > > > +static inline void prefetchw(const void *ptr)
> > > > > +{
> > > > > +     asm volatile(PREFETCHW_ASM(%0)
> > > > > +             : : "r" (ptr) : "memory");
> > > > > +}
> > > > >
> > > > >  /* Do necessary setup to start up a newly executed thread. */
> > > > >  extern void start_thread(struct pt_regs *regs,
> > > > > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > > > > index ef7b4fd9e876..e0b897db0b97 100644
> > > > > --- a/arch/riscv/kernel/cpufeature.c
> > > > > +++ b/arch/riscv/kernel/cpufeature.c
> > > > > @@ -159,6 +159,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
> > > > >       __RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
> > > > >       __RISCV_ISA_EXT_DATA(zicbom, RISCV_ISA_EXT_ZICBOM),
> > > > >       __RISCV_ISA_EXT_DATA(zicboz, RISCV_ISA_EXT_ZICBOZ),
> > > > > +     __RISCV_ISA_EXT_DATA(zicbop, RISCV_ISA_EXT_ZICBOP),
> > > > >       __RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
> > > > >       __RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
> > > > >       __RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
> > > > > --
> > > > > 2.36.1
> > > > >
> > > >
> > >
> > >
> > > --
> > > Best Regards
> > >  Guo Ren
> > >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 

