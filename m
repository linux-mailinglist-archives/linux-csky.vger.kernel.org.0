Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E21E11461A3
	for <lists+linux-csky@lfdr.de>; Thu, 23 Jan 2020 06:44:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgAWFof (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 23 Jan 2020 00:44:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33846 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgAWFoe (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 23 Jan 2020 00:44:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so1708876wrr.1
        for <linux-csky@vger.kernel.org>; Wed, 22 Jan 2020 21:44:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UD2g3R6EAWCmOv3T2af3YKBLNY0Xvn+xHCncHmLKPFw=;
        b=JCtjWNLjaIdA+tOfF5e30N6xC2R7EKBvmaDa2DeLl22ER2d0IuuWLEKyqXmriPYSJE
         u47z7moP4wmVG7uBkdVZheNXzoLQgOfF5vnl6Dad9pS/SUcffBKjsbgts5aTPxM87qWw
         nrH0jvVnL9LRDw/x9wuzLUlsp7y1lkYnqRf61oNVz2sVxuqxYoDgbSb3ap5rqN2dg3tI
         aydMjz7P8ZvJ4EsjW6EsmLSKHW9G1EssOHnior+6cBteMWG6w/IjiMkFD/tT3AnJDEbm
         a/UkkcZpfE5m6P4Jd20fsiCNz3IIhoCAF1ctZIMcgGMRn3blJFZhx73DWnthZyxwI2Mz
         hwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UD2g3R6EAWCmOv3T2af3YKBLNY0Xvn+xHCncHmLKPFw=;
        b=a1XgWYOKd6BNJdIMhLLTrKN86kWqmtFYJ38IeLgioZDm3ub3T0T0qKzV/h+3ZpECFr
         PDyYFPDeWPtV4t5TqTFN52vjX77MKovVt4eOWqwosdJj1oeZ9y2tczHujo746ZyMy6uO
         h14AcGQbpqPoBLcZRX7lyk0dYNH0e4yHVEpdMp0ZO7HZ5dU+tjFYcYDP8VNwnJZFYz9z
         3urG7nIeJi8Au7HxVCH/7L1FISTgxkXR+kmMAdnhkBm2nyH8cClfge5yv0Kbt5pm2YHY
         WmXQTdTJ+CuKtuYYitvTqwTlKXGL5kEW1mXzBKnOddUc56G9w3l3xyNsWOUtAIbT0Jmw
         DNnA==
X-Gm-Message-State: APjAAAVJ2nIcq1nQyzaVi2Na1UMWyKwZsX30pBRzc3cotm+ZlyJiJvO5
        668Svm6MWrhKGKAhDUao8UvfOMB61fGkJLGh/FargA==
X-Google-Smtp-Source: APXvYqyv+KlVKgjZla10G9aq/wBRqNXRZlBj1SqOqrDQKX4hSnOy90LI2wYMDDJ2iA9J2tC+0TnvKzxIf8yQ4C+omcI=
X-Received: by 2002:a5d:5345:: with SMTP id t5mr16455678wrv.0.1579758272249;
 Wed, 22 Jan 2020 21:44:32 -0800 (PST)
MIME-Version: 1.0
References: <20200116143029.31441-1-guoren@kernel.org>
In-Reply-To: <20200116143029.31441-1-guoren@kernel.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 23 Jan 2020 11:14:20 +0530
Message-ID: <CAAhSdy0k2gb1+k214dW1Zk-YwvujNdui5GJE3zPb_NhDS9b_Rw@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] riscv: Separate patch for cflags and aflags
To:     Guo Ren <guoren@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <Anup.Patel@wdc.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Bin Meng <bmeng.cn@gmail.com>,
        Atish Patra <atish.patra@wdc.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Thu, Jan 16, 2020 at 8:01 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <ren_guo@c-sky.com>
>
> Use "subst fd" in Makefile is a hack way and it's not convenient
> to add new ISA feature. Just separate them into riscv-march-cflags
> and riscv-march-aflags.
>
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>
> Cc: Anup Patel <Anup.Patel@wdc.com>
> ---
>  arch/riscv/Makefile | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index b9009a2fbaf5..6d09b53cf106 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -35,12 +35,18 @@ else
>  endif
>
>  # ISA string setting
> -riscv-march-$(CONFIG_ARCH_RV32I)       := rv32ima
> -riscv-march-$(CONFIG_ARCH_RV64I)       := rv64ima
> -riscv-march-$(CONFIG_FPU)              := $(riscv-march-y)fd
> -riscv-march-$(CONFIG_RISCV_ISA_C)      := $(riscv-march-y)c
> -KBUILD_CFLAGS += -march=$(subst fd,,$(riscv-march-y))
> -KBUILD_AFLAGS += -march=$(riscv-march-y)
> +riscv-march-cflags-$(CONFIG_ARCH_RV32I)                := rv32ima
> +riscv-march-cflags-$(CONFIG_ARCH_RV64I)                := rv64ima
> +riscv-march-$(CONFIG_FPU)                      := $(riscv-march-y)fd
> +riscv-march-cflags-$(CONFIG_RISCV_ISA_C)       := $(riscv-march-cflags-y)c
> +
> +riscv-march-aflags-$(CONFIG_ARCH_RV32I)                := rv32ima
> +riscv-march-aflags-$(CONFIG_ARCH_RV64I)                := rv64ima
> +riscv-march-aflags-$(CONFIG_FPU)               := $(riscv-march-aflags-y)fd
> +riscv-march-aflags-$(CONFIG_RISCV_ISA_C)       := $(riscv-march-aflags-y)c
> +
> +KBUILD_CFLAGS += -march=$(riscv-march-cflags-y)
> +KBUILD_AFLAGS += -march=$(riscv-march-aflags-y)
>
>  KBUILD_CFLAGS += -mno-save-restore
>  KBUILD_CFLAGS += -DCONFIG_PAGE_OFFSET=$(CONFIG_PAGE_OFFSET)
> --
> 2.17.0
>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
