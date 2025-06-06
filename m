Return-Path: <linux-csky+bounces-2065-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 544B9ACFB3E
	for <lists+linux-csky@lfdr.de>; Fri,  6 Jun 2025 04:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7FED1896ADA
	for <lists+linux-csky@lfdr.de>; Fri,  6 Jun 2025 02:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3351607AC;
	Fri,  6 Jun 2025 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GaKShlix"
X-Original-To: linux-csky@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604C17548
	for <linux-csky@vger.kernel.org>; Fri,  6 Jun 2025 02:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749176628; cv=none; b=sRz4dlxocFK3gLxk5qcXJgESnxknCX1SiDNHlOCwZXrAm4hyWQrrzfmZ0HfNtq8BpPAjvxeepHr9fN5KFUyflqUB8USrTcMFX0FLfJQwpwVqz5tVkJwYmdtY6lsEA1Ye+jhkqCg4/zPrvkcuw8EwyRi+Ifwzrvy7iT/sUN4vh+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749176628; c=relaxed/simple;
	bh=AWs1YydKiebWpvBEPZxTKXVarTcGmuqYZv40X6nQZAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qIODC2GaTciBeCXq0pFvOJTfDYP1ohowV9Ar+7awgT4ugpc2I8/u4hZx3dZnRbBgAPGxdXvikmvNj98BMoR2NIo1E1NjizPVI4JQN7lzC2a1v+o6b8CDoCJzZSAa1GuVkRHqSNk/aMfOl7keiaSXcETIFLASuD29IPkk9HNJtDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GaKShlix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06643C4CEE7
	for <linux-csky@vger.kernel.org>; Fri,  6 Jun 2025 02:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749176628;
	bh=AWs1YydKiebWpvBEPZxTKXVarTcGmuqYZv40X6nQZAA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GaKShlixipI/3e3KpLGrxVf44UXnfR73jy5ZFg08EySTR8Svq7jEssQhzBlrceM/Z
	 GHzXb/vuPyBJ3uXIacJD8WsEDMKW/Gnv6PrqRLHiH+XuIjWJdvUDyMkt26VtHKYxCx
	 upjGWvedsN8JnI+x8AUrUY83mZrq37x1WYm6aLpzUtrcgurpv8rOmxrQoe6BnoC5EX
	 MzcFh4TGZCr91WlM9IEozfUi0FFzhv9RuUuFCbQar3EAAMVrCB9Po2U7xpm5GvMJED
	 4fQ2Y99PpKAE55M+4rXv3if66qu/h9lDjI7OZvekcCKwnUav1cqHOI7YP9usfLD1t8
	 Qmxc1Gb3ypoxQ==
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so13315485e9.1
        for <linux-csky@vger.kernel.org>; Thu, 05 Jun 2025 19:23:47 -0700 (PDT)
X-Gm-Message-State: AOJu0YxEkKv8I1JKAXqLc8AtjDY56p7DgPqpEdJ6hgl9h+jI48xLWvJ8
	3ATa3MCEHb1AlHovspGFszD/Xg+d+7p+87nFeThjD4M+N4KbiKHwRTEKXqnLwCAboQ13WS4IekV
	gKAAHfD1xmg7Ekf052Z4IOGWAo4NMkk8=
X-Google-Smtp-Source: AGHT+IEOSPuoCYjjGKNuSXl5tnmqJ3o6zEFfz8aT2tWuQiZ7fdeu4CAbifxsv3WgdmiQSedbNYqy14T8E8VMK34UrVI=
X-Received: by 2002:a05:600d:16:b0:43d:5264:3cf0 with SMTP id
 5b1f17b1804b1-451f88ad7c9mr43281145e9.11.1749176626429; Thu, 05 Jun 2025
 19:23:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314071013.1575167-1-thuth@redhat.com> <20250314071013.1575167-12-thuth@redhat.com>
 <5e154fcc-6102-414d-a7a6-53cbf366e224@redhat.com>
In-Reply-To: <5e154fcc-6102-414d-a7a6-53cbf366e224@redhat.com>
From: Guo Ren <guoren@kernel.org>
Date: Fri, 6 Jun 2025 10:23:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRzRycsYeDAs8YZ_h-E2-i0CVLakix6zteuTcZi_6G6_A@mail.gmail.com>
X-Gm-Features: AX0GCFvAPLonICdDBIeynUbJ-mnuXYkQY2AbiAy4igvcTmljZwznQgPHRnNWOBs
Message-ID: <CAJF2gTRzRycsYeDAs8YZ_h-E2-i0CVLakix6zteuTcZi_6G6_A@mail.gmail.com>
Subject: Re: [PATCH 11/41] csky: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 non-uapi headers
To: Thomas Huth <thuth@redhat.com>
Cc: linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 6, 2025 at 2:28=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrote=
:
>
> On 14/03/2025 08.09, Thomas Huth wrote:
> > While the GCC and Clang compilers already define __ASSEMBLER__
> > automatically when compiling assembly code, __ASSEMBLY__ is a
> > macro that only gets defined by the Makefiles in the kernel.
> > This can be very confusing when switching between userspace
> > and kernelspace coding, or when dealing with uapi headers that
> > rather should use __ASSEMBLER__ instead. So let's standardize on
> > the __ASSEMBLER__ macro that is provided by the compilers now.
> >
> > This is a completely mechanical patch (done with a simple "sed -i"
> > statement).
> >
> > Cc: Guo Ren <guoren@kernel.org>
> > Cc: linux-csky@vger.kernel.org
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >   arch/csky/abiv1/inc/abi/regdef.h    | 2 +-
> >   arch/csky/abiv2/inc/abi/regdef.h    | 2 +-
> >   arch/csky/include/asm/barrier.h     | 4 ++--
> >   arch/csky/include/asm/cache.h       | 2 +-
> >   arch/csky/include/asm/ftrace.h      | 4 ++--
> >   arch/csky/include/asm/jump_label.h  | 4 ++--
> >   arch/csky/include/asm/page.h        | 4 ++--
> >   arch/csky/include/asm/ptrace.h      | 4 ++--
> >   arch/csky/include/asm/string.h      | 2 +-
> >   arch/csky/include/asm/thread_info.h | 4 ++--
> >   10 files changed, 16 insertions(+), 16 deletions(-)
> >
> > diff --git a/arch/csky/abiv1/inc/abi/regdef.h b/arch/csky/abiv1/inc/abi=
/regdef.h
> > index 7b386fd670702..c75ecf2cafd7c 100644
> > --- a/arch/csky/abiv1/inc/abi/regdef.h
> > +++ b/arch/csky/abiv1/inc/abi/regdef.h
> > @@ -3,7 +3,7 @@
> >   #ifndef __ASM_CSKY_REGDEF_H
> >   #define __ASM_CSKY_REGDEF_H
> >
> > -#ifdef __ASSEMBLY__
> > +#ifdef __ASSEMBLER__
> >   #define syscallid   r1
> >   #else
> >   #define syscallid   "r1"
> > diff --git a/arch/csky/abiv2/inc/abi/regdef.h b/arch/csky/abiv2/inc/abi=
/regdef.h
> > index 0933addbc27b7..fc08d56ccdbe1 100644
> > --- a/arch/csky/abiv2/inc/abi/regdef.h
> > +++ b/arch/csky/abiv2/inc/abi/regdef.h
> > @@ -3,7 +3,7 @@
> >   #ifndef __ASM_CSKY_REGDEF_H
> >   #define __ASM_CSKY_REGDEF_H
> >
> > -#ifdef __ASSEMBLY__
> > +#ifdef __ASSEMBLER__
> >   #define syscallid   r7
> >   #else
> >   #define syscallid   "r7"
> > diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/asm/ba=
rrier.h
> > index 15de58b10aece..c33fdcfe3770c 100644
> > --- a/arch/csky/include/asm/barrier.h
> > +++ b/arch/csky/include/asm/barrier.h
> > @@ -3,7 +3,7 @@
> >   #ifndef __ASM_CSKY_BARRIER_H
> >   #define __ASM_CSKY_BARRIER_H
> >
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >
> >   #define nop()       asm volatile ("nop\n":::"memory")
> >
> > @@ -84,5 +84,5 @@
> >
> >   #include <asm-generic/barrier.h>
> >
> > -#endif /* __ASSEMBLY__ */
> > +#endif /* __ASSEMBLER__ */
> >   #endif /* __ASM_CSKY_BARRIER_H */
> > diff --git a/arch/csky/include/asm/cache.h b/arch/csky/include/asm/cach=
e.h
> > index 4b5c09bf1d25e..d575482e0fcec 100644
> > --- a/arch/csky/include/asm/cache.h
> > +++ b/arch/csky/include/asm/cache.h
> > @@ -10,7 +10,7 @@
> >
> >   #define ARCH_DMA_MINALIGN   L1_CACHE_BYTES
> >
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >
> >   void dcache_wb_line(unsigned long start);
> >
> > diff --git a/arch/csky/include/asm/ftrace.h b/arch/csky/include/asm/ftr=
ace.h
> > index 00f9f7647e3f3..21532f2180587 100644
> > --- a/arch/csky/include/asm/ftrace.h
> > +++ b/arch/csky/include/asm/ftrace.h
> > @@ -11,7 +11,7 @@
> >
> >   #define MCOUNT_ADDR ((unsigned long)_mcount)
> >
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >
> >   extern void _mcount(unsigned long);
> >
> > @@ -28,5 +28,5 @@ struct dyn_arch_ftrace {
> >   void prepare_ftrace_return(unsigned long *parent, unsigned long self_=
addr,
> >                          unsigned long frame_pointer);
> >
> > -#endif /* !__ASSEMBLY__ */
> > +#endif /* !__ASSEMBLER__ */
> >   #endif /* __ASM_CSKY_FTRACE_H */
> > diff --git a/arch/csky/include/asm/jump_label.h b/arch/csky/include/asm=
/jump_label.h
> > index ef2e37a10a0fe..603b0caa80249 100644
> > --- a/arch/csky/include/asm/jump_label.h
> > +++ b/arch/csky/include/asm/jump_label.h
> > @@ -3,7 +3,7 @@
> >   #ifndef __ASM_CSKY_JUMP_LABEL_H
> >   #define __ASM_CSKY_JUMP_LABEL_H
> >
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >
> >   #include <linux/types.h>
> >
> > @@ -48,5 +48,5 @@ void arch_jump_label_transform_static(struct jump_ent=
ry *entry,
> >                                     enum jump_label_type type);
> >   #define arch_jump_label_transform_static arch_jump_label_transform_st=
atic
> >
> > -#endif  /* __ASSEMBLY__ */
> > +#endif  /* __ASSEMBLER__ */
> >   #endif      /* __ASM_CSKY_JUMP_LABEL_H */
> > diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.=
h
> > index 4911d0892b71d..76774dbce8697 100644
> > --- a/arch/csky/include/asm/page.h
> > +++ b/arch/csky/include/asm/page.h
> > @@ -26,7 +26,7 @@
> >
> >   #define PHYS_OFFSET_OFFSET (CONFIG_DRAM_BASE & (SSEG_SIZE - 1))
> >
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >
> >   #include <linux/pfn.h>
> >
> > @@ -84,5 +84,5 @@ static inline unsigned long virt_to_pfn(const void *k=
addr)
> >   #include <asm-generic/memory_model.h>
> >   #include <asm-generic/getorder.h>
> >
> > -#endif /* !__ASSEMBLY__ */
> > +#endif /* !__ASSEMBLER__ */
> >   #endif /* __ASM_CSKY_PAGE_H */
> > diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm/ptr=
ace.h
> > index 0634b7895d81d..5f01839e11843 100644
> > --- a/arch/csky/include/asm/ptrace.h
> > +++ b/arch/csky/include/asm/ptrace.h
> > @@ -8,7 +8,7 @@
> >   #include <linux/types.h>
> >   #include <linux/compiler.h>
> >
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >
> >   #define PS_S        0x80000000 /* Supervisor Mode */
> >
> > @@ -98,5 +98,5 @@ static inline unsigned long regs_get_register(struct =
pt_regs *regs,
> >
> >   asmlinkage int syscall_trace_enter(struct pt_regs *regs);
> >   asmlinkage void syscall_trace_exit(struct pt_regs *regs);
> > -#endif /* __ASSEMBLY__ */
> > +#endif /* __ASSEMBLER__ */
> >   #endif /* __ASM_CSKY_PTRACE_H */
> > diff --git a/arch/csky/include/asm/string.h b/arch/csky/include/asm/str=
ing.h
> > index a0d81e9d6b8f6..82e99f52b547c 100644
> > --- a/arch/csky/include/asm/string.h
> > +++ b/arch/csky/include/asm/string.h
> > @@ -3,7 +3,7 @@
> >   #ifndef _CSKY_STRING_MM_H_
> >   #define _CSKY_STRING_MM_H_
> >
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >   #include <linux/types.h>
> >   #include <linux/compiler.h>
> >   #include <abi/string.h>
> > diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/as=
m/thread_info.h
> > index b5ed788f0c681..fdd4f8ad45acf 100644
> > --- a/arch/csky/include/asm/thread_info.h
> > +++ b/arch/csky/include/asm/thread_info.h
> > @@ -3,7 +3,7 @@
> >   #ifndef _ASM_CSKY_THREAD_INFO_H
> >   #define _ASM_CSKY_THREAD_INFO_H
> >
> > -#ifndef __ASSEMBLY__
> > +#ifndef __ASSEMBLER__
> >
> >   #include <asm/types.h>
> >   #include <asm/page.h>
> > @@ -51,7 +51,7 @@ static inline struct thread_info *current_thread_info=
(void)
> >       return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
> >   }
> >
> > -#endif /* !__ASSEMBLY__ */
> > +#endif /* !__ASSEMBLER__ */
> >
> >   #define TIF_SIGPENDING              0       /* signal pending */
> >   #define TIF_NOTIFY_RESUME   1       /* callback before returning to u=
ser */
>
> Friendly ping!
>
> Guo Ren, could you maybe pick this (and the previous patch) up via your c=
sky
> tree? (x86 and parisc already got merge via their respective architecture
> trees, so I guess the same should happen for this patch here, too).
>
>   Thanks,
>    Thomas
>
How about riscv?

--=20
Best Regards
 Guo Ren

