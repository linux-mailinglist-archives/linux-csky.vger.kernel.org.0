Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23B1309A15
	for <lists+linux-csky@lfdr.de>; Sun, 31 Jan 2021 04:31:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbhAaDbf (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 30 Jan 2021 22:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbhAaDbd (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sat, 30 Jan 2021 22:31:33 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5734CC061573;
        Sat, 30 Jan 2021 19:30:53 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o16so9624805pgg.5;
        Sat, 30 Jan 2021 19:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=WWtdonkpI96IFBE23zlui93VOmpriWeRuclQpLHiSrQ=;
        b=eSCoksJ1Yzv/0BafKpHiRRXPKnSIvcmu5C8r/mihPZT7sg4H85PPlglIDJW80h3clD
         fd4ivdugrzla49hkbsIq0/rdtSO+B6t0nc6sqXNZECMM4P/dcjvdqKwnLKxwRwZoisSe
         g4gxwXfE3hl2hwxq7/RE3gBz8t2xrU2wWagJLphFtVXBZZPYK5pLYj74Mw9vS8oM4pKU
         6QYwv7XtIFq+X7sjnwKdzr75ZO1pp1ztyUUWwfOF5YJ7ZyntGlW+ujiU9AEN8+j3Zrdg
         j/nxnuRNVYt9tavAg8CtBw8/cQ3AL1zngp18EmiNiGAzmmpMHsfadM9qZ4NZVXJD4hTe
         mAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=WWtdonkpI96IFBE23zlui93VOmpriWeRuclQpLHiSrQ=;
        b=B1sKy4yNzjTk4z6m2XP1sFBRGxMm7AIzJE2nwslTQ+/POqtsoxbrEbx3l4FRaEPbhA
         UegUQ/Co2Ap2PvU3qGirtIo8pL9l8CSWeP1+HiheUJzexo2lq2J1XNLgxKrSmQqn1TIh
         nZ1H48uVWdLiYCLpzs3BDYEu72b7f5hJHz3/o2R1GLY+mR920ti1fR9dRLh0v5imfugv
         V9Eck/fcu5W6KEODe+UA3v9TM3ohuIuAeIyU7yJBaB/P4qbZcQBlbtkgypXOZpuyojT4
         KDHBpKQie19FrsG1Csw9V8FmqL2h40vcDC3zLNqusrWRT0cmYQ5XYNHq1YkKV20tlj2F
         woSQ==
X-Gm-Message-State: AOAM530CmCUWumN9e7c2aKpNMxFWCr3baESRnSgGznvIV+9MLxVF4cdR
        jJNyZhRqUccJauRnkAdGtVxlafKIuuw=
X-Google-Smtp-Source: ABdhPJwg/CC1nlE2QXUEo6aPv7AuExcknG2RvU7iKigAxQiaO+plz8rwLHQC/gO7heys0NGdqRr/GA==
X-Received: by 2002:a63:5309:: with SMTP id h9mr11066861pgb.19.1612063852569;
        Sat, 30 Jan 2021 19:30:52 -0800 (PST)
Received: from localhost (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id d14sm12961544pfo.156.2021.01.30.19.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Jan 2021 19:30:52 -0800 (PST)
Date:   Sun, 31 Jan 2021 13:30:45 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [RFC 00/20] TLB batching consolidation and enhancements
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Nadav Amit <nadav.amit@gmail.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-csky@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Nadav Amit <namit@vmware.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Yu Zhao <yuzhao@google.com>
References: <20210131001132.3368247-1-namit@vmware.com>
In-Reply-To: <20210131001132.3368247-1-namit@vmware.com>
MIME-Version: 1.0
Message-Id: <1612063149.2awdsvvmhj.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Excerpts from Nadav Amit's message of January 31, 2021 10:11 am:
> From: Nadav Amit <namit@vmware.com>
>=20
> There are currently (at least?) 5 different TLB batching schemes in the
> kernel:
>=20
> 1. Using mmu_gather (e.g., zap_page_range()).
>=20
> 2. Using {inc|dec}_tlb_flush_pending() to inform other threads on the
>    ongoing deferred TLB flush and flushing the entire range eventually
>    (e.g., change_protection_range()).
>=20
> 3. arch_{enter|leave}_lazy_mmu_mode() for sparc and powerpc (and Xen?).
>=20
> 4. Batching per-table flushes (move_ptes()).
>=20
> 5. By setting a flag on that a deferred TLB flush operation takes place,
>    flushing when (try_to_unmap_one() on x86).
>=20
> It seems that (1)-(4) can be consolidated. In addition, it seems that
> (5) is racy. It also seems there can be many redundant TLB flushes, and
> potentially TLB-shootdown storms, for instance during batched
> reclamation (using try_to_unmap_one()) if at the same time mmu_gather
> defers TLB flushes.
>=20
> More aggressive TLB batching may be possible, but this patch-set does
> not add such batching. The proposed changes would enable such batching
> in a later time.
>=20
> Admittedly, I do not understand how things are not broken today, which
> frightens me to make further batching before getting things in order.
> For instance, why is ok for zap_pte_range() to batch dirty-PTE flushes
> for each page-table (but not in greater granularity). Can't
> ClearPageDirty() be called before the flush, causing writes after
> ClearPageDirty() and before the flush to be lost?

Because it's holding the page table lock which stops page_mkclean from=20
cleaning the page. Or am I misunderstanding the question?

I'll go through the patches a bit more closely when they all come=20
through. Sparc and powerpc of course need the arch lazy mode to get=20
per-page/pte information for operations that are not freeing pages,=20
which is what mmu gather is designed for.

I wouldn't mind using a similar API so it's less of a black box when=20
reading generic code, but it might not quite fit the mmu gather API
exactly (most of these paths don't want a full mmu_gather on stack).

>=20
> This patch-set therefore performs the following changes:
>=20
> 1. Change mprotect, task_mmu and mapping_dirty_helpers to use mmu_gather
>    instead of {inc|dec}_tlb_flush_pending().
>=20
> 2. Avoid TLB flushes if PTE permission is not demoted.
>=20
> 3. Cleans up mmu_gather to be less arch-dependant.
>=20
> 4. Uses mm's generations to track in finer granularity, either per-VMA
>    or per page-table, whether a pending mmu_gather operation is
>    outstanding. This should allow to avoid some TLB flushes when KSM or
>    memory reclamation takes place while another operation such as
>    munmap() or mprotect() is running.
>=20
> 5. Changes try_to_unmap_one() flushing scheme, as the current seems
>    broken to track in a bitmap which CPUs have outstanding TLB flushes
>    instead of having a flag.

Putting fixes first, and cleanups and independent patches (like #2) next
would help with getting stuff merged and backported.

Thanks,
Nick
