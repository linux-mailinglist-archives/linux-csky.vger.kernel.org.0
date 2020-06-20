Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F2C202509
	for <lists+linux-csky@lfdr.de>; Sat, 20 Jun 2020 18:08:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgFTQId (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 20 Jun 2020 12:08:33 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32394 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725880AbgFTQIc (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Sat, 20 Jun 2020 12:08:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592669311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uAGWGHZX+NRKxPhaQCrHlyIVKqgbsc6xDoomuBD05Hw=;
        b=HRVCcChduwqCMPn//fe8n8VzggZ0W8IgYjdkVScXl3X1/W5nqiDc2IYGPRsJzUt0dN0GAw
        mE/AGExA5yWkg2xaJ/YH/1ghph1VlWZ8c5qLrUaj9rDAtugTa4BCyaeURbKFpjLnxuE4bj
        x0HgIQiNrfcA7KYozxCtUwkHWpBNK9A=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-PwGPBsQtNbW2pmtZXjN8yQ-1; Sat, 20 Jun 2020 12:08:29 -0400
X-MC-Unique: PwGPBsQtNbW2pmtZXjN8yQ-1
Received: by mail-qt1-f199.google.com with SMTP id u26so9527262qtj.21
        for <linux-csky@vger.kernel.org>; Sat, 20 Jun 2020 09:08:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uAGWGHZX+NRKxPhaQCrHlyIVKqgbsc6xDoomuBD05Hw=;
        b=Yr/QVIDEN+mJ7sJ4bAcBYjUVOt5TY9Vb3cz0A7fMv/YTNBG3Ek/GV/BOo78s1arSgY
         5ir8zwyonwRRTiuZdTco8L7fc2KHBRCF9VyVuMFThDhrknm7B8ISM427+sqtolLXx/5e
         Mu6dBtHTZmdelkrIz0e9Ykb8/0M6n834+sk6DpDph9OgGWvPyMc6cKHmnl0A9ANULo+s
         7JdEEWDFnXP8cjDXo+pCXZrXH5KJD9pOd1ccSMWzreNcEORbOAR6IsTrTM96Kbzya/Ln
         A3MC8PCDHSLLjSCDC0jKHmF1BBycrMEAyvSSSURzS2fk0Wp+KRflF9nVgMinJLTClacs
         Dqvw==
X-Gm-Message-State: AOAM533JAnSakMxS+ind1Ofn0YHCj74xNERT/bwRqGJM+2jLORkRmagp
        KNusmm45ASWspFPIpFTp1QRVtx1srupAFRpWSzg5vp5jGohH68MZ/GDsq6oUeojFgAVL6AA3K2Y
        HOYH6i/ajlas7AAi5W0MQIA==
X-Received: by 2002:ac8:2af4:: with SMTP id c49mr7855098qta.42.1592669308735;
        Sat, 20 Jun 2020 09:08:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhW6m+v5NAydxoWwY4YCydn/fcpsNSqMLAgkBrIBmXw9vSkjNqmzWLGoF9/VukK2HQYENUBg==
X-Received: by 2002:ac8:2af4:: with SMTP id c49mr7855067qta.42.1592669308443;
        Sat, 20 Jun 2020 09:08:28 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 195sm9432761qkg.74.2020.06.20.09.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 09:08:27 -0700 (PDT)
Date:   Sat, 20 Jun 2020 12:08:25 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH 06/26] mm/csky: Use general page fault accounting
Message-ID: <20200620160825.GC6414@xz-x1>
References: <20200619160538.8641-1-peterx@redhat.com>
 <20200619160538.8641-7-peterx@redhat.com>
 <CAJF2gTS+6UwSAbHk9236g2FOhyYniKZ-W3DcKJuSYMF13qHZxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTS+6UwSAbHk9236g2FOhyYniKZ-W3DcKJuSYMF13qHZxQ@mail.gmail.com>
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sat, Jun 20, 2020 at 09:44:31AM +0800, Guo Ren wrote:
> On Sat, Jun 20, 2020 at 12:05 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Use the general page fault accounting by passing regs into handle_mm_fault().
> > It naturally solve the issue of multiple page fault accounting when page fault
> > retry happened.
> >
> > CC: Guo Ren <guoren@kernel.org>
> > CC: linux-csky@vger.kernel.org
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  arch/csky/mm/fault.c | 12 +-----------
> >  1 file changed, 1 insertion(+), 11 deletions(-)
> >
> > diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
> > index b14f97d3cb15..a3e0aa3ebb79 100644
> > --- a/arch/csky/mm/fault.c
> > +++ b/arch/csky/mm/fault.c
> > @@ -151,7 +151,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
> >          * the fault.
> >          */
> >         fault = handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : 0,
> > -                               NULL);
> > +                               regs);
> what's your kernel version ? （4th arg exsist ?）
>         /*
>          * If for any reason at all we couldn't handle the fault,
>          * make sure we exit gracefully rather than endlessly redo
>          * the fault.
>          */
>         fault = handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : 0);
>         if (unlikely(fault & VM_FAULT_ERROR)) {

Hi, Guo,

Sorry to be unclear.  This patch is based on patch 1 in the same series:

https://lore.kernel.org/lkml/20200619160538.8641-2-peterx@redhat.com/

Thanks,

-- 
Peter Xu

