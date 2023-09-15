Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928BD7A1395
	for <lists+linux-csky@lfdr.de>; Fri, 15 Sep 2023 04:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbjIOCKp (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 14 Sep 2023 22:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjIOCKp (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 14 Sep 2023 22:10:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16371FCE;
        Thu, 14 Sep 2023 19:10:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A0FC433C9;
        Fri, 15 Sep 2023 02:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694743840;
        bh=H4peK7/Mx5CDu/1O9wTXBMeibtsHq958OKN8Kc01/TA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JqWhsvZc7iIoAE7APKfQgH5c3AouN4YAe3iumbXDsC+5qITNTjme4meegPKHtnNcj
         OCfy2N2rw4ikX9QCeX/jxyozhea3hk79gvrSOv9OAvHLpxRzEmh7Lj3QzYgDb3Ciqs
         KGHmAONa2tdSQePEkCpGhwaP9Sc4JltkL2FinrI/GCtofX/1LMB4tU4b0eGTtXNbQA
         /ERh6egjQbpUqhH67BVXJPi6i79Tz2N4ny19v6RhMYSZLymFothQzgdF+VsgGy84Rr
         1uQHuTsYRIVrGS/ZKviT1nWrWYYZaRF7JGUyAAKLR3Pmt3T5RpOaJQNb/5r/ph2l//
         c6IG/xWewNm6w==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-52a4737a08fso1796332a12.3;
        Thu, 14 Sep 2023 19:10:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YxDvR6Qm9mMMQBaV9tsp3EpobIyUDZF5gW3tfXf8fQkwxUcwI0B
        eqbkkycZlGbYoWw1mPKy8gq1eI3il7n21EEdrn0=
X-Google-Smtp-Source: AGHT+IGlBZEBLeOpPiY2OjtH1L7jaQh4g/3yO4ZFve5QQCpfWKQwx78LuRffM/CeRhTTa3fCgbFI5kBSMtxudiIb+D4=
X-Received: by 2002:aa7:cc0a:0:b0:522:3855:7ec5 with SMTP id
 q10-20020aa7cc0a000000b0052238557ec5mr201422edt.10.1694743838675; Thu, 14 Sep
 2023 19:10:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230910082911.3378782-1-guoren@kernel.org> <20230910082911.3378782-6-guoren@kernel.org>
 <ZQIbejhIev5tx6vl@redhat.com> <CAJF2gTSdjgUaUqhkfTPmJg6Mph+8Ej4j8MeDmfBOmFY5gkTpBQ@mail.gmail.com>
 <ZQLVqoCGJ1ExMU3e@redhat.com>
In-Reply-To: <ZQLVqoCGJ1ExMU3e@redhat.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 15 Sep 2023 10:10:25 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQWUCLOpKMQsybMoJdZrso2FEbBRVYV+2U1veFC=7U8_A@mail.gmail.com>
Message-ID: <CAJF2gTQWUCLOpKMQsybMoJdZrso2FEbBRVYV+2U1veFC=7U8_A@mail.gmail.com>
Subject: Re: [PATCH V11 05/17] riscv: qspinlock: Add basic queued_spinlock support
To:     Leonardo Bras <leobras@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Thu, Sep 14, 2023 at 5:43=E2=80=AFPM Leonardo Bras <leobras@redhat.com> =
wrote:
>
> On Thu, Sep 14, 2023 at 12:46:56PM +0800, Guo Ren wrote:
> > On Thu, Sep 14, 2023 at 4:29=E2=80=AFAM Leonardo Bras <leobras@redhat.c=
om> wrote:
> > >
> > > On Sun, Sep 10, 2023 at 04:28:59AM -0400, guoren@kernel.org wrote:
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > The requirements of qspinlock have been documented by commit:
> > > > a8ad07e5240c ("asm-generic: qspinlock: Indicate the use of mixed-si=
ze
> > > > atomics").
> > > >
> > > > Although RISC-V ISA gives out a weaker forward guarantee LR/SC, whi=
ch
> > > > doesn't satisfy the requirements of qspinlock above, it won't preve=
nt
> > > > some riscv vendors from implementing a strong fwd guarantee LR/SC i=
n
> > > > microarchitecture to match xchg_tail requirement. T-HEAD C9xx proce=
ssor
> > > > is the one.
> > > >
> > > > We've tested the patch on SOPHGO sg2042 & th1520 and passed the str=
ess
> > > > test on Fedora & Ubuntu & OpenEuler ... Here is the performance
> > > > comparison between qspinlock and ticket_lock on sg2042 (64 cores):
> > > >
> > > > sysbench test=3Dthreads threads=3D32 yields=3D100 lock=3D8 (+13.8%)=
:
> > > >   queued_spinlock 0.5109/0.00
> > > >   ticket_spinlock 0.5814/0.00
> > > >
> > > > perf futex/hash (+6.7%):
> > > >   queued_spinlock 1444393 operations/sec (+- 0.09%)
> > > >   ticket_spinlock 1353215 operations/sec (+- 0.15%)
> > > >
> > > > perf futex/wake-parallel (+8.6%):
> > > >   queued_spinlock (waking 1/64 threads) in 0.0253 ms (+-2.90%)
> > > >   ticket_spinlock (waking 1/64 threads) in 0.0275 ms (+-3.12%)
> > > >
> > > > perf futex/requeue (+4.2%):
> > > >   queued_spinlock Requeued 64 of 64 threads in 0.0785 ms (+-0.55%)
> > > >   ticket_spinlock Requeued 64 of 64 threads in 0.0818 ms (+-4.12%)
> > > >
> > > > System Benchmarks (+6.4%)
> > > >   queued_spinlock:
> > > >     System Benchmarks Index Values               BASELINE       RES=
ULT    INDEX
> > > >     Dhrystone 2 using register variables         116700.0  62861374=
5.4  53865.8
> > > >     Double-Precision Whetstone                       55.0     18242=
2.8  33167.8
> > > >     Execl Throughput                                 43.0      1311=
6.6   3050.4
> > > >     File Copy 1024 bufsize 2000 maxblocks          3960.0    776230=
6.2  19601.8
> > > >     File Copy 256 bufsize 500 maxblocks            1655.0    341755=
6.8  20649.9
> > > >     File Copy 4096 bufsize 8000 maxblocks          5800.0    742799=
5.7  12806.9
> > > >     Pipe Throughput                               12440.0   2305860=
0.5  18535.9
> > > >     Pipe-based Context Switching                   4000.0    283561=
7.7   7089.0
> > > >     Process Creation                                126.0      1253=
7.3    995.0
> > > >     Shell Scripts (1 concurrent)                     42.4      5705=
7.4  13456.9
> > > >     Shell Scripts (8 concurrent)                      6.0       736=
7.1  12278.5
> > > >     System Call Overhead                          15000.0   3330830=
1.3  22205.5
> > > >                                                                    =
    =3D=3D=3D=3D=3D=3D=3D=3D
> > > >     System Benchmarks Index Score                                  =
     12426.1
> > > >
> > > >   ticket_spinlock:
> > > >     System Benchmarks Index Values               BASELINE       RES=
ULT    INDEX
> > > >     Dhrystone 2 using register variables         116700.0  62654170=
1.9  53688.2
> > > >     Double-Precision Whetstone                       55.0     18192=
1.0  33076.5
> > > >     Execl Throughput                                 43.0      1262=
5.1   2936.1
> > > >     File Copy 1024 bufsize 2000 maxblocks          3960.0    655379=
2.9  16550.0
> > > >     File Copy 256 bufsize 500 maxblocks            1655.0    318923=
1.6  19270.3
> > > >     File Copy 4096 bufsize 8000 maxblocks          5800.0    722127=
7.0  12450.5
> > > >     Pipe Throughput                               12440.0   2059401=
8.7  16554.7
> > > >     Pipe-based Context Switching                   4000.0    257111=
7.7   6427.8
> > > >     Process Creation                                126.0      1079=
8.4    857.0
> > > >     Shell Scripts (1 concurrent)                     42.4      5722=
7.5  13497.1
> > > >     Shell Scripts (8 concurrent)                      6.0       732=
9.2  12215.3
> > > >     System Call Overhead                          15000.0   3076677=
8.4  20511.2
> > > >                                                                    =
    =3D=3D=3D=3D=3D=3D=3D=3D
> > > >     System Benchmarks Index Score                                  =
     11670.7
> > > >
> > > > The qspinlock has a significant improvement on SOPHGO SG2042 64
> > > > cores platform than the ticket_lock.
> > > >
> > > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > ---
> > > >  arch/riscv/Kconfig                | 16 ++++++++++++++++
> > > >  arch/riscv/include/asm/Kbuild     |  3 ++-
> > > >  arch/riscv/include/asm/spinlock.h | 17 +++++++++++++++++
> > > >  3 files changed, 35 insertions(+), 1 deletion(-)
> > > >  create mode 100644 arch/riscv/include/asm/spinlock.h
> > > >
> > > > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> > > > index 2c346fe169c1..7f39bfc75744 100644
> > > > --- a/arch/riscv/Kconfig
> > > > +++ b/arch/riscv/Kconfig
> > > > @@ -471,6 +471,22 @@ config NODES_SHIFT
> > > >         Specify the maximum number of NUMA Nodes available on the t=
arget
> > > >         system.  Increases memory reserved to accommodate various t=
ables.
> > > >
> > > > +choice
> > > > +     prompt "RISC-V spinlock type"
> > > > +     default RISCV_TICKET_SPINLOCKS
> > > > +
> > > > +config RISCV_TICKET_SPINLOCKS
> > > > +     bool "Using ticket spinlock"
> > > > +
> > > > +config RISCV_QUEUED_SPINLOCKS
> > > > +     bool "Using queued spinlock"
> > > > +     depends on SMP && MMU
> > > > +     select ARCH_USE_QUEUED_SPINLOCKS
> > > > +     help
> > > > +       Make sure your micro arch LL/SC has a strong forward progre=
ss guarantee.
> > > > +       Otherwise, stay at ticket-lock.
> > > > +endchoice
> > > > +
> > > >  config RISCV_ALTERNATIVE
> > > >       bool
> > > >       depends on !XIP_KERNEL
> > > > diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm=
/Kbuild
> > > > index 504f8b7e72d4..a0dc85e4a754 100644
> > > > --- a/arch/riscv/include/asm/Kbuild
> > > > +++ b/arch/riscv/include/asm/Kbuild
> > > > @@ -2,10 +2,11 @@
> > > >  generic-y +=3D early_ioremap.h
> > > >  generic-y +=3D flat.h
> > > >  generic-y +=3D kvm_para.h
> > > > +generic-y +=3D mcs_spinlock.h
> > > >  generic-y +=3D parport.h
> > > > -generic-y +=3D spinlock.h
> > >
> > > IIUC here you take the asm-generic/spinlock.h (which defines arch_spi=
n_*())
> > > and include the asm-generic headers of mcs_spinlock and qspinlock.
> > >
> > > In this case, the qspinlock.h will provide the arch_spin_*() interfac=
es,
> > > which seems the oposite of the above description (ticket spinlocks be=
ing
> > > the standard).
> > >
> > > Shouldn't ticket-spinlock.h also get included here?
> > > (Also, I am probably missing something, as I dont' see the use of
> > > mcs_spinlock here.)
> > No, because asm-generic/spinlock.h:
> > ...
> > #include <asm-generic/ticket_spinlock.h>
> > ...
> >
>
> But aren't you removing asm-generic/spinlock.h below ?
> -generic-y +=3D spinlock.h
Yes, current is:

arch/riscv/include/asm/spinlock.h -> include/asm-generic/spinlock.h ->
include/asm-generic/ticket_spinlock.h

+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm/qspinlock.h>
+#include <asm/qrwlock.h>
+#else
+#include <asm-generic/spinlock.h>
+#endif

So, you want me:
+#ifdef CONFIG_QUEUED_SPINLOCKS
+#include <asm/qspinlock.h>
+#else
+#include <asm-generic/ticket_spinlock.h>
+#endif

+#include <asm/qrwlock.h>

Right?

>
> > >
> > > >  generic-y +=3D spinlock_types.h
> > > >  generic-y +=3D qrwlock.h
> > > >  generic-y +=3D qrwlock_types.h
> > > > +generic-y +=3D qspinlock.h
> > > >  generic-y +=3D user.h
> > > >  generic-y +=3D vmlinux.lds.h
> > > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include=
/asm/spinlock.h
> > > > new file mode 100644
> > > > index 000000000000..c644a92d4548
> > > > --- /dev/null
> > > > +++ b/arch/riscv/include/asm/spinlock.h
> > > > @@ -0,0 +1,17 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +
> > > > +#ifndef __ASM_RISCV_SPINLOCK_H
> > > > +#define __ASM_RISCV_SPINLOCK_H
> > > > +
> > > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > > +#define _Q_PENDING_LOOPS     (1 << 9)
> > > > +#endif
> > >
> > > Any reason the above define couldn't be merged on the ifdef below?
> > Easy for the next patch to modify. See Waiman's comment:
> >
> > https://lore.kernel.org/linux-riscv/4cc7113a-0e4e-763a-cba2-7963bcd26c7=
a@redhat.com/
> >
> > > diff --git a/arch/riscv/include/asm/spinlock.h b/arch/riscv/include/a=
sm/spinlock.h
> > > index c644a92d4548..9eb3ad31e564 100644
> > > --- a/arch/riscv/include/asm/spinlock.h
> > > +++ b/arch/riscv/include/asm/spinlock.h
> > > @@ -7,11 +7,94 @@
> > >   #define _Q_PENDING_LOOPS (1 << 9)
> > >   #endif
> > >
> >
> > I see why you separated the _Q_PENDING_LOOPS out.
> >
>
> I see, should be fine then.
>
> Thanks!
> Leo
>
> >
> > >
> > > > +
> > > > +#ifdef CONFIG_QUEUED_SPINLOCKS
> > > > +#include <asm/qspinlock.h>
> > > > +#include <asm/qrwlock.h>
> > > > +#else
> > > > +#include <asm-generic/spinlock.h>
> > > > +#endif
> > > > +
> > > > +#endif /* __ASM_RISCV_SPINLOCK_H */
> > > > --
> > > > 2.36.1
> > > >
> > >
> > > Thanks!
> > > Leo
> > >
> >
> >
> > --
> > Best Regards
> >  Guo Ren
> >
>


--=20
Best Regards
 Guo Ren
