Return-Path: <linux-csky+bounces-1307-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B66D9EB8D2
	for <lists+linux-csky@lfdr.de>; Tue, 10 Dec 2024 18:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B511672BC
	for <lists+linux-csky@lfdr.de>; Tue, 10 Dec 2024 17:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04259204683;
	Tue, 10 Dec 2024 17:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6YvVuuw"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE071B86D5
	for <linux-csky@vger.kernel.org>; Tue, 10 Dec 2024 17:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733853341; cv=none; b=NlkS527pqB2YCqDa98MzWO5PiQl7MdQNT4aICAJtCDoTPJYnrxDfnqUxC7qrfq4x32asUrn03oS0ZqwXnnEfqyNrAhxVju62X/kPd3kVKJJLP9NVVbtnf9/c/7GKBcUjs/yR+JeXcQGKBh8cqf1rLkyyJpIgcWo5FldjnYctj8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733853341; c=relaxed/simple;
	bh=iV6hA0IYWTLQAyvLjwsvTOjyYSVIwGM/w77HmkdSwPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uG2lUD2LbgCCQq2w0nf02QMxbXMRr5+VVcUkJBBZgE65whmA0F1Tx4P0YjtV4JMAZZVEZiMzgLPbHHEfS/O7/o0s4C6aRXIMHLZBgBhQpm4/P6Dvde/uiipkTuurQa6eLkJ/3z7qImfxoKdKHEakHwGeTzS08W/JQshmEVZVlyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o6YvVuuw; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2163affd184so2025ad.1
        for <linux-csky@vger.kernel.org>; Tue, 10 Dec 2024 09:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733853339; x=1734458139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0WaAW3kh+VqyYkynbg5Bnnaq2ujjkmV+I+q8jKp9mU=;
        b=o6YvVuuwTQc3x/NTSjOgUR229ZYckJgkZajd3JUsuBl6J81vq7gv9KkF7ByTLOZgwW
         pYjVtiJLBnEaBHwte3VV6Y2AQmoIxy9IB4Hr4wr+D1IKGhnEJTbYr9sPuusXnW6YVfBw
         pbBXHUWOVGjsDXAHodkfV1+GzyY+IyCdofUWTr5JVfDuds9B5Nt7VW7XZQ/JHOn93Xf/
         CuMbSqYI2a3kY2NFQUrX4Fxc8CxrgAUZPjgTEuMtm7KOoUL5Y2dw7TyRGi1i/2O89NiZ
         rLQva1s7LqyEnvop6mPsI3wTU3OwrLzFcdkAx3CdorpgysFFm15PUFRHFy4wKgnp+us2
         gl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733853339; x=1734458139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0WaAW3kh+VqyYkynbg5Bnnaq2ujjkmV+I+q8jKp9mU=;
        b=RzxGhvSmx9FY6f/Kr1ogZFovOwBLvi9gaYsisn4ab2QwsJe4tgIXIMRRmhNhhHonGI
         o1msQLm+IbS59+SN+SLcS5p4Lxv5GJpNEOW5oVTpV22jk6zfz91Ym7SIkDj6HMYSEx3t
         LDMvFKLulxd/sGn0zxYdmvmISNMeO9IVuMR/axDFr6EQ6z7vH3EvjlUDG28NOKwdSEgM
         lF934gRX0G+5Q1U+/y7qx5I95AAMhutoohEZ6AMVlaI0DCOldcyWw6Qyi2c6+bT1lPjc
         Us1Xcmknl1Hf1ErRRwevtY2eChLERh89l9wCvQC9cJEoz9kJbptN8eNEC8R7OMnxY74j
         wwew==
X-Forwarded-Encrypted: i=1; AJvYcCV3cbfL1VPM8pUSGQ8qVJmARTOgw5EF6Vm8/QDp2rK6OaghqAUEd02fggLVKCVaO3agB00i6YuMnmvl@vger.kernel.org
X-Gm-Message-State: AOJu0YyJaWkmq1bwPhwtaD8iAJdKcuvDXaAOALAwd8TsH8zEsU9UbthS
	wFm/ukjLrknr/jeQM123mggV1zESlhiSu5xxuX+K72DtSytX0rBPO6LE1J6QchwiasCklRdfs95
	TG+Xm3vy10Q4j0AJACwTQqu030vNNcngJ3k51
X-Gm-Gg: ASbGncu8dWreYRQfxx4FlzMV59LJVDWFplQ29Xx425rmPJ0AdVRwFtNVRtT1P5kD3XX
	qX2KZdncThpBc5yL83R8Uw2F+KDzjeReSFUvV8C71XU9bEKe7DWcUYYqkvoIJdmlZ
X-Google-Smtp-Source: AGHT+IGLvX826EUtDFzCMbe4Z82/rCvZNBH+2oBWnGrvdZr1UuD+ncWShG6UN2y8G42XtPREcypqHTRZ438FncSXyng=
X-Received: by 2002:a17:903:144b:b0:215:79b5:aa7e with SMTP id
 d9443c01a7336-21674d58706mr2897555ad.13.1733853339077; Tue, 10 Dec 2024
 09:55:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210024119.2488608-1-kaleshsingh@google.com>
 <20241210024119.2488608-2-kaleshsingh@google.com> <CAHbLzkpCRGF+-WXkHVEutkEGHSWydmpb1CwkvHZRTH-f773J-w@mail.gmail.com>
In-Reply-To: <CAHbLzkpCRGF+-WXkHVEutkEGHSWydmpb1CwkvHZRTH-f773J-w@mail.gmail.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 10 Dec 2024 09:55:27 -0800
Message-ID: <CAC_TJvc5SU_khaBf7NS1VvD+d5PJ4X1DwKWbO92j-dZ+rEuc9A@mail.gmail.com>
Subject: Re: [PATCH mm-unstable 01/17] mm: Introduce generic_mmap_hint()
To: Yang Shi <shy828301@gmail.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com, linux@armlinux.org.uk, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 7:27=E2=80=AFPM Yang Shi <shy828301@gmail.com> wrote=
:
>
> On Mon, Dec 9, 2024 at 6:41=E2=80=AFPM Kalesh Singh <kaleshsingh@google.c=
om> wrote:
> >
> > Consolidate the hint searches from both direcitons (topdown and
> > bottomup) into generic_mmap_hint().
> >
> > No functional change is introduced.
> >
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >  include/linux/sched/mm.h |  4 ++++
> >  mm/mmap.c                | 45 ++++++++++++++++++++++++----------------
> >  2 files changed, 31 insertions(+), 18 deletions(-)
> >
> > diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> > index 928a626725e6..edeec19d1708 100644
> > --- a/include/linux/sched/mm.h
> > +++ b/include/linux/sched/mm.h
> > @@ -201,6 +201,10 @@ unsigned long mm_get_unmapped_area_vmflags(struct =
mm_struct *mm,
> >                                            unsigned long flags,
> >                                            vm_flags_t vm_flags);
> >
> > +unsigned long generic_mmap_hint(struct file *filp, unsigned long addr,
> > +                               unsigned long len, unsigned long pgoff,
> > +                               unsigned long flags);
> > +
> >  unsigned long
> >  generic_get_unmapped_area(struct file *filp, unsigned long addr,
> >                           unsigned long len, unsigned long pgoff,
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index df9154b15ef9..e97eb8bf4889 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -620,6 +620,27 @@ unsigned long vm_unmapped_area(struct vm_unmapped_=
area_info *info)
> >         return addr;
> >  }
> >
> > +unsigned long generic_mmap_hint(struct file *filp, unsigned long addr,
> > +                               unsigned long len, unsigned long pgoff,
> > +                               unsigned long flags)
> > +{
> > +       struct mm_struct *mm =3D current->mm;
> > +       struct vm_area_struct *vma, *prev;
> > +       const unsigned long mmap_end =3D arch_get_mmap_end(addr, len, f=
lags);
> > +
> > +       if (!addr)
> > +               return 0;
> > +
> > +       addr =3D PAGE_ALIGN(addr);
> > +       vma =3D find_vma_prev(mm, addr, &prev);
> > +       if (mmap_end - len >=3D addr && addr >=3D mmap_min_addr &&
> > +           (!vma || addr + len <=3D vm_start_gap(vma)) &&
> > +           (!prev || addr >=3D vm_end_gap(prev)))
> > +               return addr;
> > +
> > +       return 0;
> > +}
> > +
> >  /* Get an address range which is currently unmapped.
> >   * For shmat() with addr=3D0.
> >   *
> > @@ -637,7 +658,6 @@ generic_get_unmapped_area(struct file *filp, unsign=
ed long addr,
> >                           unsigned long flags, vm_flags_t vm_flags)
> >  {
> >         struct mm_struct *mm =3D current->mm;
> > -       struct vm_area_struct *vma, *prev;
> >         struct vm_unmapped_area_info info =3D {};
> >         const unsigned long mmap_end =3D arch_get_mmap_end(addr, len, f=
lags);
> >
> > @@ -647,14 +667,9 @@ generic_get_unmapped_area(struct file *filp, unsig=
ned long addr,
> >         if (flags & MAP_FIXED)
> >                 return addr;
>
> It seems you also can move the MAP_FIXED case into generic_mmap_hint(), r=
ight?

I think that could be done too. we'll need a new name :) Let me take a
look at it ...

-- Kalesh

>
> >
> > -       if (addr) {
> > -               addr =3D PAGE_ALIGN(addr);
> > -               vma =3D find_vma_prev(mm, addr, &prev);
> > -               if (mmap_end - len >=3D addr && addr >=3D mmap_min_addr=
 &&
> > -                   (!vma || addr + len <=3D vm_start_gap(vma)) &&
> > -                   (!prev || addr >=3D vm_end_gap(prev)))
> > -                       return addr;
> > -       }
> > +       addr =3D generic_mmap_hint(filp, addr, len, pgoff, flags);
> > +       if (addr)
> > +               return addr;
> >
> >         info.length =3D len;
> >         info.low_limit =3D mm->mmap_base;
> > @@ -685,7 +700,6 @@ generic_get_unmapped_area_topdown(struct file *filp=
, unsigned long addr,
> >                                   unsigned long len, unsigned long pgof=
f,
> >                                   unsigned long flags, vm_flags_t vm_fl=
ags)
> >  {
> > -       struct vm_area_struct *vma, *prev;
> >         struct mm_struct *mm =3D current->mm;
> >         struct vm_unmapped_area_info info =3D {};
> >         const unsigned long mmap_end =3D arch_get_mmap_end(addr, len, f=
lags);
> > @@ -698,14 +712,9 @@ generic_get_unmapped_area_topdown(struct file *fil=
p, unsigned long addr,
> >                 return addr;
> >
> >         /* requesting a specific address */
> > -       if (addr) {
> > -               addr =3D PAGE_ALIGN(addr);
> > -               vma =3D find_vma_prev(mm, addr, &prev);
> > -               if (mmap_end - len >=3D addr && addr >=3D mmap_min_addr=
 &&
> > -                               (!vma || addr + len <=3D vm_start_gap(v=
ma)) &&
> > -                               (!prev || addr >=3D vm_end_gap(prev)))
> > -                       return addr;
> > -       }
> > +       addr =3D generic_mmap_hint(filp, addr, len, pgoff, flags);
> > +       if (addr)
> > +               return addr;
> >
> >         info.flags =3D VM_UNMAPPED_AREA_TOPDOWN;
> >         info.length =3D len;
> > --
> > 2.47.0.338.g60cca15819-goog
> >
> >

