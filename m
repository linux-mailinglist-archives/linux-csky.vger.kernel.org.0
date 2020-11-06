Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391FE2A8C4C
	for <lists+linux-csky@lfdr.de>; Fri,  6 Nov 2020 02:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgKFBug (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 5 Nov 2020 20:50:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732772AbgKFBug (ORCPT <rfc822;linux-csky@vger.kernel.org>);
        Thu, 5 Nov 2020 20:50:36 -0500
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CBCE1206DC
        for <linux-csky@vger.kernel.org>; Fri,  6 Nov 2020 01:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604627435;
        bh=helXX3bor4utgRiggbzalAYGqagKwX2OyHQxG7F0D74=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pyhnLhiXghkUeShLMnHXj9MhLqbtTjVOJT5Mqu4e7J+4p4O6xn/d/Jc67EcrU8Q7F
         UIqmhLWhkyxLcqmD3DxwkA7n3TBmOTv9QQRzPc4yvducORcbQVnrxE24o9S2beSl9I
         bTfhkZOt7dy+tastteS93yKYLrJ1eF6/h+HuqT/8=
Received: by mail-lj1-f178.google.com with SMTP id y16so3670043ljk.1
        for <linux-csky@vger.kernel.org>; Thu, 05 Nov 2020 17:50:34 -0800 (PST)
X-Gm-Message-State: AOAM531gnwFeaV01LeW9sFHIY5mmcXLnH5pSmdKDDaxQOgagMygWUg/Y
        4W5GGbVZucdESBwgOYuvSbDV9ugFMT0RBIjD3PY=
X-Google-Smtp-Source: ABdhPJyMzPcY3OBSGrJo9P1nTaJ16HOt5KfbI6gIRAnS133o54GjGiIjPpY2P20UcYgg/YO0IzVfyokaoORKG+1BXwY=
X-Received: by 2002:a2e:921a:: with SMTP id k26mr1732307ljg.79.1604627433022;
 Thu, 05 Nov 2020 17:50:33 -0800 (PST)
MIME-Version: 1.0
References: <4f498dfd-00eb-3f15-4529-672264fdab0f@kernel.dk> <19e5bad9-2421-0f40-446f-23479b365477@kernel.dk>
In-Reply-To: <19e5bad9-2421-0f40-446f-23479b365477@kernel.dk>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 6 Nov 2020 09:50:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT=xm7vrEdw_je8vfHgkHk5t07htNJX+59tGKbb-co2vg@mail.gmail.com>
Message-ID: <CAJF2gTT=xm7vrEdw_je8vfHgkHk5t07htNJX+59tGKbb-co2vg@mail.gmail.com>
Subject: Re: [PATCH] csky: add support for TIF_NOTIFY_SIGNAL
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

I haven't tested the whole patchset of notify_signal, but the wire-up
code is ok for me.

Acked-by: Guo Ren <guoren@kernel.org>


On Fri, Nov 6, 2020 at 12:19 AM Jens Axboe <axboe@kernel.dk> wrote:
>
> Gentle nudge on this one.
>
> On 10/29/20 10:13 AM, Jens Axboe wrote:
> > Wire up TIF_NOTIFY_SIGNAL handling for csky.
> >
> > Cc: linux-csky@vger.kernel.org
> > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > ---
> >
> > 5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
> > for details:
> >
> > https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/
> >
> > As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
> > as that will enable a set of cleanups once all of them support it. I'm
> > happy carrying this patch if need be, or it can be funelled through the
> > arch tree. Let me know.
> >
> >  arch/csky/include/asm/thread_info.h | 5 ++++-
> >  arch/csky/kernel/signal.c           | 2 +-
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
> > index 68e7a1227170..21456a3737c2 100644
> > --- a/arch/csky/include/asm/thread_info.h
> > +++ b/arch/csky/include/asm/thread_info.h
> > @@ -64,6 +64,7 @@ static inline struct thread_info *current_thread_info(void)
> >  #define TIF_SYSCALL_TRACE    4       /* syscall trace active */
> >  #define TIF_SYSCALL_TRACEPOINT       5       /* syscall tracepoint instrumentation */
> >  #define TIF_SYSCALL_AUDIT    6       /* syscall auditing */
> > +#define TIF_NOTIFY_SIGNAL    7       /* signal notifications exist */
> >  #define TIF_POLLING_NRFLAG   16      /* poll_idle() is TIF_NEED_RESCHED */
> >  #define TIF_MEMDIE           18      /* is terminating due to OOM killer */
> >  #define TIF_RESTORE_SIGMASK  20      /* restore signal mask in do_signal() */
> > @@ -75,6 +76,7 @@ static inline struct thread_info *current_thread_info(void)
> >  #define _TIF_SYSCALL_TRACE   (1 << TIF_SYSCALL_TRACE)
> >  #define _TIF_SYSCALL_TRACEPOINT      (1 << TIF_SYSCALL_TRACEPOINT)
> >  #define _TIF_SYSCALL_AUDIT   (1 << TIF_SYSCALL_AUDIT)
> > +#define _TIF_NOTIFY_SIGNAL   (1 << TIF_NOTIFY_SIGNAL)
> >  #define _TIF_UPROBE          (1 << TIF_UPROBE)
> >  #define _TIF_POLLING_NRFLAG  (1 << TIF_POLLING_NRFLAG)
> >  #define _TIF_MEMDIE          (1 << TIF_MEMDIE)
> > @@ -82,7 +84,8 @@ static inline struct thread_info *current_thread_info(void)
> >  #define _TIF_SECCOMP         (1 << TIF_SECCOMP)
> >
> >  #define _TIF_WORK_MASK               (_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
> > -                              _TIF_NOTIFY_RESUME | _TIF_UPROBE)
> > +                              _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
> > +                              _TIF_NOTIFY_SIGNAL)
> >
> >  #define _TIF_SYSCALL_WORK    (_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
> >                                _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP)
> > diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
> > index 8b068cf37447..37ea64ed3c12 100644
> > --- a/arch/csky/kernel/signal.c
> > +++ b/arch/csky/kernel/signal.c
> > @@ -257,7 +257,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
> >               uprobe_notify_resume(regs);
> >
> >       /* Handle pending signal delivery */
> > -     if (thread_info_flags & _TIF_SIGPENDING)
> > +     if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
> >               do_signal(regs);
> >
> >       if (thread_info_flags & _TIF_NOTIFY_RESUME) {
> >
>
>
> --
> Jens Axboe
>


--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
