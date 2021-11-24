Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDE245B4B1
	for <lists+linux-csky@lfdr.de>; Wed, 24 Nov 2021 07:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbhKXG6i (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 24 Nov 2021 01:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhKXG6h (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 24 Nov 2021 01:58:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB587C061574
        for <linux-csky@vger.kernel.org>; Tue, 23 Nov 2021 22:55:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso4396772wmr.4
        for <linux-csky@vger.kernel.org>; Tue, 23 Nov 2021 22:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMC8pp4mVpNvhRL3jm1hX0mNoR6GBx6c8qg48EuKy2w=;
        b=nI0EaHE/M+xl/HsklYIGJKHl+ovr78hwBFi5nMaij8dYWmuAsns2/PROeqWJ3FJ8qf
         aD7wNLNDhLoxy6UsbYz2FAusX29C2JrTgc0ewkjPLAdLQ6bTCpUuN9yvU1QVCLoEx/vE
         x9h8cFPjnvKJkmrzTDrilrNUzVgzqQlULh7tlyEnHMRrHzKilpBfuytFei4rRxOcBGmc
         a3NSzzaOe647/6qkGS6f6wFVijbAqrKDxt8SmICwNCsLp3bujQFccjS2D8UiaQM8Ooxt
         u4DOTXYziau7u0+e5tFDL+Z82QjeKNbIhzuelK61J7ehqeV5g64GB85hzqrgxuYvm2N7
         rDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tMC8pp4mVpNvhRL3jm1hX0mNoR6GBx6c8qg48EuKy2w=;
        b=ACZqHnpbYf34BoRNf8SUZeS3Z8ZPhdXORCspE4y8qpWtNdqB11HqtdU7H53iEYVARi
         5QSCJZdhhVt2bytY1DUtBZgniBAAIC5tsip7OTSUX3tLg1z8rcjdGjL2p65B42Q5ILSR
         hu6aJ/L5LeoJ9wdaD3oYkBrwxLcLP8l/7PbxMf6Lj0JU8wXts5ddRu6kzWJRSDuiJ71s
         /lg4xsqNonc1LqDbIHLdXXbwwA+VgM9vGiXNCjenvWquk+F28GMg0SvUJQ+e/415+v5m
         z84PHPVvCQiUw20ZmaMeaSAtah1AESzfT0Jvcxa9ZpEdhFTBInWJYhCS5QoNOIqmI/JP
         lKKw==
X-Gm-Message-State: AOAM531a6z5DbSBpTheHAhg3l2XrcI9gAMSA2+aEPXjxerWErdSVS1Xh
        9S1rTAc/vOQLhKAvHBgGtjYkKbT0+iZh942vOp48yFDxmFtZIav2
X-Google-Smtp-Source: ABdhPJyzY2RHxrAEL5Q8QxrTjXOPnheMWIXDQcEdBHU0XPG5cgjRLiKr064wWKsNaG5Rf+AS4V+fxKmWCH54gG5PTmo=
X-Received: by 2002:a05:600c:2149:: with SMTP id v9mr12303753wml.59.1637736926050;
 Tue, 23 Nov 2021 22:55:26 -0800 (PST)
MIME-Version: 1.0
References: <20211124060521.614015-1-guoren@kernel.org>
In-Reply-To: <20211124060521.614015-1-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 24 Nov 2021 12:25:14 +0530
Message-ID: <CAAhSdy1CZbdAPEYxFOhrn=wUcmc9Yea0ziMUmHjaudKdH2Yw1w@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fixup one-page wasting
To:     Guo Ren <guoren@kernel.org>
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Atish Patra <Atish.Patra@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Wed, Nov 24, 2021 at 11:35 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> For small memory systems(Allwinner D1s/F133), one page size memory
> cannot be ignored.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Alexandre Ghiti <alex@ghiti.fr>
> Cc: Anup Patel <anup@brainfault.org>
> Cc: Atish Patra <Atish.Patra@wdc.com>

This PATCH breaks the CPU hotplug functionality.

When a CPU/HART is turned off and turned on at runtime, the
low-level relocate() will be called to enable MMU on the CPU
being brought-up which in-turn uses trampoline_pg_dir.

Regards,
Anup

> ---
>  arch/riscv/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 24b2b8044602..097bb3bc4020 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -241,9 +241,9 @@ unsigned long riscv_pfn_base __ro_after_init;
>  EXPORT_SYMBOL(riscv_pfn_base);
>
>  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> -pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
>  static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
>
> +pgd_t trampoline_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>  pgd_t early_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>  static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
>
> --
> 2.25.1
>
