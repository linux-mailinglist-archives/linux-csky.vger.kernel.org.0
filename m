Return-Path: <linux-csky+bounces-2513-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E998BABB60
	for <lists+linux-csky@lfdr.de>; Tue, 30 Sep 2025 08:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E55E03C3B80
	for <lists+linux-csky@lfdr.de>; Tue, 30 Sep 2025 06:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0941E2BD022;
	Tue, 30 Sep 2025 06:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7IAkQ03"
X-Original-To: linux-csky@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67BD2BD016
	for <linux-csky@vger.kernel.org>; Tue, 30 Sep 2025 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759215437; cv=none; b=W1LtajZGDgz1i8GPXmutPFSOCif8AD+i5HHitr96TfEh0FBL5oKy0mg40rZH7eZRxxO/lHCEq+0F96sqczlXsNVhfuIL/bXzp4cI/y6QjoGjxVsVLhDQEYYtgVt234iRYcNucCamzRyX/et4XP3wSEwhehamS/xCd655i0GmnE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759215437; c=relaxed/simple;
	bh=/bW+na4hs6n6k8gWUXJDCxQ0ct4hChsIfU8rHLRq2Wc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jedLzddWX5fQQmkgFPCt9NQxlqR1GgyeIISO9UvjA5WbB8QuNotPtWs9wFJiYrTxsXQwomj3ZEu91jAVXfRWjE/nNoki2uticvyrKBuc/fydWJPWPeve86iCLXoa7QdXaFmW8MpgsQICo7UT0QwYsYOKUj2Q05ZHzYLn+MmTu8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7IAkQ03; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F89CC4CEF0
	for <linux-csky@vger.kernel.org>; Tue, 30 Sep 2025 06:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759215437;
	bh=/bW+na4hs6n6k8gWUXJDCxQ0ct4hChsIfU8rHLRq2Wc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=B7IAkQ03dgisKlXBlWN7xtgIZ8WMagqaEqaYxYLx0qbW1dYRVSAtCXcMdqzWJutPo
	 jrfVF1oHCdJcOzAStemzmGJSmuBaO6mIjkAuyQIzctbGEvwk0kpYA5CWhOpYkVkTfv
	 m+oXeFbFMZAKUB0PKyOLEp84k5hzh3wXMLszLLtdQrzUz9YrjZiOcqWgJtwpfkL2Sd
	 YcA703tP9sLjWEbprwzs+Atlp4kNZQy4lTRJYz8m6fY7njdvn3JLqV8CDasQWIrZD3
	 1He1dglLgVJnWZFcIx5S/AQzNM3PL+4symmCdGmDCTkyCHHVFsm5axKelZEKZU/KMu
	 LukdQfgSLemSg==
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4060b4b1200so4964003f8f.3
        for <linux-csky@vger.kernel.org>; Mon, 29 Sep 2025 23:57:17 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzvy17MuKBtaFyoR2NilYz9aV2UQ+keE+GU5MseE+ZDHvyx25AR
	70SMyfnjTW7DhEqX+CYk1f3Hy8LbLQJO4YsOXwUbvF8xiz3IDk1FWVsxLgAmysK6P0e4YyuOsPF
	hbAuF6q/MgqFTPxHinMgnMxTUQLMP7os=
X-Google-Smtp-Source: AGHT+IHRcA+37YW/CJ0dKPSjRggjlO1DdFgUDijEaCxriXGfN2VssgLm4goQH+xs4v/04SLFMPZ7wALffHuLneoJ8MM=
X-Received: by 2002:a05:6000:24c6:b0:3ec:1b42:1f8d with SMTP id
 ffacd0b85a97d-40e468e7444mr19076518f8f.10.1759215435834; Mon, 29 Sep 2025
 23:57:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314071013.1575167-1-thuth@redhat.com> <20250314071013.1575167-12-thuth@redhat.com>
 <5e154fcc-6102-414d-a7a6-53cbf366e224@redhat.com> <CAJF2gTRzRycsYeDAs8YZ_h-E2-i0CVLakix6zteuTcZi_6G6_A@mail.gmail.com>
 <6ac94cd5-3617-4f3c-9b12-b97922c0e9c4@redhat.com> <CAJF2gTQsuPtvz3T_TTbrrd=sCn6wGukYTrs5He7dx4XzmMjZiQ@mail.gmail.com>
 <8586069f-d9bd-43b2-bfb3-2b9cd1ccf999@redhat.com>
In-Reply-To: <8586069f-d9bd-43b2-bfb3-2b9cd1ccf999@redhat.com>
From: Guo Ren <guoren@kernel.org>
Date: Tue, 30 Sep 2025 14:57:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRH_Jqd8CDsqo=_SU_CtUJ-XLRRBFHLX3+UbsPZf4P83w@mail.gmail.com>
X-Gm-Features: AS18NWAEGHb-yvgWu9jYuZJtBffSuH0rmxMkNyiADFdvDn9GjFuv6Xamvz9af0k
Message-ID: <CAJF2gTRH_Jqd8CDsqo=_SU_CtUJ-XLRRBFHLX3+UbsPZf4P83w@mail.gmail.com>
Subject: Re: [PATCH 11/41] csky: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 non-uapi headers
To: Thomas Huth <thuth@redhat.com>
Cc: linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 12:27=E2=80=AFPM Thomas Huth <thuth@redhat.com> wro=
te:
>
> On 06/06/2025 09.20, Guo Ren wrote:
> > On Fri, Jun 6, 2025 at 1:31=E2=80=AFPM Thomas Huth <thuth@redhat.com> w=
rote:
> >>
> >> On 06/06/2025 04.23, Guo Ren wrote:
> >>> On Fri, Jun 6, 2025 at 2:28=E2=80=AFAM Thomas Huth <thuth@redhat.com>=
 wrote:
> >>>>
> >>>> On 14/03/2025 08.09, Thomas Huth wrote:
> >>>>> While the GCC and Clang compilers already define __ASSEMBLER__
> >>>>> automatically when compiling assembly code, __ASSEMBLY__ is a
> >>>>> macro that only gets defined by the Makefiles in the kernel.
> >>>>> This can be very confusing when switching between userspace
> >>>>> and kernelspace coding, or when dealing with uapi headers that
> >>>>> rather should use __ASSEMBLER__ instead. So let's standardize on
> >>>>> the __ASSEMBLER__ macro that is provided by the compilers now.
> >>>>>
> >>>>> This is a completely mechanical patch (done with a simple "sed -i"
> >>>>> statement).
> >>>>>
> >>>>> Cc: Guo Ren <guoren@kernel.org>
> >>>>> Cc: linux-csky@vger.kernel.org
> >>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>>>> ---
> >>>>>     arch/csky/abiv1/inc/abi/regdef.h    | 2 +-
> >>>>>     arch/csky/abiv2/inc/abi/regdef.h    | 2 +-
> >>>>>     arch/csky/include/asm/barrier.h     | 4 ++--
> >>>>>     arch/csky/include/asm/cache.h       | 2 +-
> >>>>>     arch/csky/include/asm/ftrace.h      | 4 ++--
> >>>>>     arch/csky/include/asm/jump_label.h  | 4 ++--
> >>>>>     arch/csky/include/asm/page.h        | 4 ++--
> >>>>>     arch/csky/include/asm/ptrace.h      | 4 ++--
> >>>>>     arch/csky/include/asm/string.h      | 2 +-
> >>>>>     arch/csky/include/asm/thread_info.h | 4 ++--
> >>>>>     10 files changed, 16 insertions(+), 16 deletions(-)
> >>>>>
> >>>>> diff --git a/arch/csky/abiv1/inc/abi/regdef.h b/arch/csky/abiv1/inc=
/abi/regdef.h
> >>>>> index 7b386fd670702..c75ecf2cafd7c 100644
> >>>>> --- a/arch/csky/abiv1/inc/abi/regdef.h
> >>>>> +++ b/arch/csky/abiv1/inc/abi/regdef.h
> >>>>> @@ -3,7 +3,7 @@
> >>>>>     #ifndef __ASM_CSKY_REGDEF_H
> >>>>>     #define __ASM_CSKY_REGDEF_H
> >>>>>
> >>>>> -#ifdef __ASSEMBLY__
> >>>>> +#ifdef __ASSEMBLER__
> >>>>>     #define syscallid   r1
> >>>>>     #else
> >>>>>     #define syscallid   "r1"
> >>>>> diff --git a/arch/csky/abiv2/inc/abi/regdef.h b/arch/csky/abiv2/inc=
/abi/regdef.h
> >>>>> index 0933addbc27b7..fc08d56ccdbe1 100644
> >>>>> --- a/arch/csky/abiv2/inc/abi/regdef.h
> >>>>> +++ b/arch/csky/abiv2/inc/abi/regdef.h
> >>>>> @@ -3,7 +3,7 @@
> >>>>>     #ifndef __ASM_CSKY_REGDEF_H
> >>>>>     #define __ASM_CSKY_REGDEF_H
> >>>>>
> >>>>> -#ifdef __ASSEMBLY__
> >>>>> +#ifdef __ASSEMBLER__
> >>>>>     #define syscallid   r7
> >>>>>     #else
> >>>>>     #define syscallid   "r7"
> >>>>> diff --git a/arch/csky/include/asm/barrier.h b/arch/csky/include/as=
m/barrier.h
> >>>>> index 15de58b10aece..c33fdcfe3770c 100644
> >>>>> --- a/arch/csky/include/asm/barrier.h
> >>>>> +++ b/arch/csky/include/asm/barrier.h
> >>>>> @@ -3,7 +3,7 @@
> >>>>>     #ifndef __ASM_CSKY_BARRIER_H
> >>>>>     #define __ASM_CSKY_BARRIER_H
> >>>>>
> >>>>> -#ifndef __ASSEMBLY__
> >>>>> +#ifndef __ASSEMBLER__
> >>>>>
> >>>>>     #define nop()       asm volatile ("nop\n":::"memory")
> >>>>>
> >>>>> @@ -84,5 +84,5 @@
> >>>>>
> >>>>>     #include <asm-generic/barrier.h>
> >>>>>
> >>>>> -#endif /* __ASSEMBLY__ */
> >>>>> +#endif /* __ASSEMBLER__ */
> >>>>>     #endif /* __ASM_CSKY_BARRIER_H */
> >>>>> diff --git a/arch/csky/include/asm/cache.h b/arch/csky/include/asm/=
cache.h
> >>>>> index 4b5c09bf1d25e..d575482e0fcec 100644
> >>>>> --- a/arch/csky/include/asm/cache.h
> >>>>> +++ b/arch/csky/include/asm/cache.h
> >>>>> @@ -10,7 +10,7 @@
> >>>>>
> >>>>>     #define ARCH_DMA_MINALIGN   L1_CACHE_BYTES
> >>>>>
> >>>>> -#ifndef __ASSEMBLY__
> >>>>> +#ifndef __ASSEMBLER__
> >>>>>
> >>>>>     void dcache_wb_line(unsigned long start);
> >>>>>
> >>>>> diff --git a/arch/csky/include/asm/ftrace.h b/arch/csky/include/asm=
/ftrace.h
> >>>>> index 00f9f7647e3f3..21532f2180587 100644
> >>>>> --- a/arch/csky/include/asm/ftrace.h
> >>>>> +++ b/arch/csky/include/asm/ftrace.h
> >>>>> @@ -11,7 +11,7 @@
> >>>>>
> >>>>>     #define MCOUNT_ADDR ((unsigned long)_mcount)
> >>>>>
> >>>>> -#ifndef __ASSEMBLY__
> >>>>> +#ifndef __ASSEMBLER__
> >>>>>
> >>>>>     extern void _mcount(unsigned long);
> >>>>>
> >>>>> @@ -28,5 +28,5 @@ struct dyn_arch_ftrace {
> >>>>>     void prepare_ftrace_return(unsigned long *parent, unsigned long=
 self_addr,
> >>>>>                            unsigned long frame_pointer);
> >>>>>
> >>>>> -#endif /* !__ASSEMBLY__ */
> >>>>> +#endif /* !__ASSEMBLER__ */
> >>>>>     #endif /* __ASM_CSKY_FTRACE_H */
> >>>>> diff --git a/arch/csky/include/asm/jump_label.h b/arch/csky/include=
/asm/jump_label.h
> >>>>> index ef2e37a10a0fe..603b0caa80249 100644
> >>>>> --- a/arch/csky/include/asm/jump_label.h
> >>>>> +++ b/arch/csky/include/asm/jump_label.h
> >>>>> @@ -3,7 +3,7 @@
> >>>>>     #ifndef __ASM_CSKY_JUMP_LABEL_H
> >>>>>     #define __ASM_CSKY_JUMP_LABEL_H
> >>>>>
> >>>>> -#ifndef __ASSEMBLY__
> >>>>> +#ifndef __ASSEMBLER__
> >>>>>
> >>>>>     #include <linux/types.h>
> >>>>>
> >>>>> @@ -48,5 +48,5 @@ void arch_jump_label_transform_static(struct jump=
_entry *entry,
> >>>>>                                       enum jump_label_type type);
> >>>>>     #define arch_jump_label_transform_static arch_jump_label_transf=
orm_static
> >>>>>
> >>>>> -#endif  /* __ASSEMBLY__ */
> >>>>> +#endif  /* __ASSEMBLER__ */
> >>>>>     #endif      /* __ASM_CSKY_JUMP_LABEL_H */
> >>>>> diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/p=
age.h
> >>>>> index 4911d0892b71d..76774dbce8697 100644
> >>>>> --- a/arch/csky/include/asm/page.h
> >>>>> +++ b/arch/csky/include/asm/page.h
> >>>>> @@ -26,7 +26,7 @@
> >>>>>
> >>>>>     #define PHYS_OFFSET_OFFSET (CONFIG_DRAM_BASE & (SSEG_SIZE - 1))
> >>>>>
> >>>>> -#ifndef __ASSEMBLY__
> >>>>> +#ifndef __ASSEMBLER__
> >>>>>
> >>>>>     #include <linux/pfn.h>
> >>>>>
> >>>>> @@ -84,5 +84,5 @@ static inline unsigned long virt_to_pfn(const voi=
d *kaddr)
> >>>>>     #include <asm-generic/memory_model.h>
> >>>>>     #include <asm-generic/getorder.h>
> >>>>>
> >>>>> -#endif /* !__ASSEMBLY__ */
> >>>>> +#endif /* !__ASSEMBLER__ */
> >>>>>     #endif /* __ASM_CSKY_PAGE_H */
> >>>>> diff --git a/arch/csky/include/asm/ptrace.h b/arch/csky/include/asm=
/ptrace.h
> >>>>> index 0634b7895d81d..5f01839e11843 100644
> >>>>> --- a/arch/csky/include/asm/ptrace.h
> >>>>> +++ b/arch/csky/include/asm/ptrace.h
> >>>>> @@ -8,7 +8,7 @@
> >>>>>     #include <linux/types.h>
> >>>>>     #include <linux/compiler.h>
> >>>>>
> >>>>> -#ifndef __ASSEMBLY__
> >>>>> +#ifndef __ASSEMBLER__
> >>>>>
> >>>>>     #define PS_S        0x80000000 /* Supervisor Mode */
> >>>>>
> >>>>> @@ -98,5 +98,5 @@ static inline unsigned long regs_get_register(str=
uct pt_regs *regs,
> >>>>>
> >>>>>     asmlinkage int syscall_trace_enter(struct pt_regs *regs);
> >>>>>     asmlinkage void syscall_trace_exit(struct pt_regs *regs);
> >>>>> -#endif /* __ASSEMBLY__ */
> >>>>> +#endif /* __ASSEMBLER__ */
> >>>>>     #endif /* __ASM_CSKY_PTRACE_H */
> >>>>> diff --git a/arch/csky/include/asm/string.h b/arch/csky/include/asm=
/string.h
> >>>>> index a0d81e9d6b8f6..82e99f52b547c 100644
> >>>>> --- a/arch/csky/include/asm/string.h
> >>>>> +++ b/arch/csky/include/asm/string.h
> >>>>> @@ -3,7 +3,7 @@
> >>>>>     #ifndef _CSKY_STRING_MM_H_
> >>>>>     #define _CSKY_STRING_MM_H_
> >>>>>
> >>>>> -#ifndef __ASSEMBLY__
> >>>>> +#ifndef __ASSEMBLER__
> >>>>>     #include <linux/types.h>
> >>>>>     #include <linux/compiler.h>
> >>>>>     #include <abi/string.h>
> >>>>> diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/includ=
e/asm/thread_info.h
> >>>>> index b5ed788f0c681..fdd4f8ad45acf 100644
> >>>>> --- a/arch/csky/include/asm/thread_info.h
> >>>>> +++ b/arch/csky/include/asm/thread_info.h
> >>>>> @@ -3,7 +3,7 @@
> >>>>>     #ifndef _ASM_CSKY_THREAD_INFO_H
> >>>>>     #define _ASM_CSKY_THREAD_INFO_H
> >>>>>
> >>>>> -#ifndef __ASSEMBLY__
> >>>>> +#ifndef __ASSEMBLER__
> >>>>>
> >>>>>     #include <asm/types.h>
> >>>>>     #include <asm/page.h>
> >>>>> @@ -51,7 +51,7 @@ static inline struct thread_info *current_thread_=
info(void)
> >>>>>         return (struct thread_info *)(sp & ~(THREAD_SIZE - 1));
> >>>>>     }
> >>>>>
> >>>>> -#endif /* !__ASSEMBLY__ */
> >>>>> +#endif /* !__ASSEMBLER__ */
> >>>>>
> >>>>>     #define TIF_SIGPENDING              0       /* signal pending *=
/
> >>>>>     #define TIF_NOTIFY_RESUME   1       /* callback before returnin=
g to user */
> >>>>
> >>>> Friendly ping!
> >>>>
> >>>> Guo Ren, could you maybe pick this (and the previous patch) up via y=
our csky
> >>>> tree? (x86 and parisc already got merge via their respective archite=
cture
> >>>> trees, so I guess the same should happen for this patch here, too).
> >>>>
> >>>>     Thanks,
> >>>>      Thomas
> >>>>
> >>> How about riscv?
> >>
> >> The riscv patch
> >> (https://lore.kernel.org/all/20250314071013.1575167-30-thuth@redhat.co=
m/)
> >> needs a rebase since it does not apply cleanly anymore. I'll try to do=
 that
> >> in the next couple of days.
> > Thanks for the info, I would take the patch after the other
> > architecture is approved. It's not a rush job.
>
> The riscv patch has now been merged. Could you please pick up the csky pa=
tch
> now?

Yes, I'll review and pick it up.

--=20
Best Regards
 Guo Ren

