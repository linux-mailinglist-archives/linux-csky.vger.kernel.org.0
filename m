Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 749A724D5B9
	for <lists+linux-csky@lfdr.de>; Fri, 21 Aug 2020 15:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgHUNEV (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 21 Aug 2020 09:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgHUNEF (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 21 Aug 2020 09:04:05 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E19C06138B
        for <linux-csky@vger.kernel.org>; Fri, 21 Aug 2020 06:04:04 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id s81so393329vkb.3
        for <linux-csky@vger.kernel.org>; Fri, 21 Aug 2020 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Of8B1JdNddjVmiolpjV5fIdtTFXK4mNZ1WJPME585rI=;
        b=MsAQRhu3Yz/2CxCDMuK8lKA+6IRovanKanJ+xkv2q+6NkbAawmZpclkCicAmFD/GCn
         LptyFlY1QNEZQQsXN+H9dDLRT4LBFDnWDJrOnwxLywkRMDS+y19GE8mt8p6MDEyHomi3
         PFnKlUCyzg0eXSq7GzvqfoZXMFdHwEaMcn6/BoqVc/tZEQWIZMIrQZYAZpNpAoNWL5aY
         uEMNLITtGGWZqH/4462D4EtFgtvMyRCanOIp3j+6P1azskPtkwwEgAeEiYnQyRUjuOro
         zJOhRTVrnIiLVm7oWrK0GeYEDIzSDLV5oSxTEb1GfnRw/o4yqzjwpZJ2MntLh2eC175o
         4rTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Of8B1JdNddjVmiolpjV5fIdtTFXK4mNZ1WJPME585rI=;
        b=HbeHy3cYerpXrc0xBykowTitOefniqNrHdQlpnIUplTzX94pAiBhco7f6WrovevIy3
         aoo7Da5I3QwvdNI/MJc27cBRTV58qGhSKlwUeJXFJ76YDhJTGEsZdgUT0ejc/xUp4lle
         FHiL9M3qAkenu7f2gyWhiQ58CMaU7/v3FnAgpr1zJnJugsig3WT19VBm6muxkOsWiPbQ
         4Z6xlnvVXYuSXxj1M6aQ/AcT3GYK6JvcRTby747SfdAjhYd2rdeEbiUn3JpKqt4tWw8U
         hqTU55t8Lg/ZBtDLGkO4110ZzEOGk2nCpLxVWVSIUSMSspg9TOu8pbyReDYDnizd9s+8
         MCXA==
X-Gm-Message-State: AOAM530RIuhFNvo7rOwk5XZmla3FKZiBAmp1Jg8SfLQpqB1H0xlfumql
        3AHLxrK3vDOT1CQrlmdnEjY+RoL6/QDPrAnsF3WBhw==
X-Google-Smtp-Source: ABdhPJxexRNpnHIAvgnOO637NaC3Fo+35Ifzsik1b/A6iDZxGrmVTZ55K47fA64XUTB0JSJ5J9MQb/JS1o/wJWEBAJI=
X-Received: by 2002:ac5:ccdb:: with SMTP id j27mr1509317vkn.43.1598015043981;
 Fri, 21 Aug 2020 06:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <1596887102-9743-1-git-send-email-guoren@kernel.org>
In-Reply-To: <1596887102-9743-1-git-send-email-guoren@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 21 Aug 2020 15:03:27 +0200
Message-ID: <CAPDyKFoAonef5daQy0rZFdQeUhKwryYDM0k-aiWXKZG8XBxQxw@mail.gmail.com>
Subject: Re: [PATCH] mmc: Kconfig: Add RISCV and CSKY for MMC_DW
To:     guoren@kernel.org
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sat, 8 Aug 2020 at 13:45, <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Synopsys DesignWare MMC controller could be used in RISC-V and
> C-SKY architectures.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index 3b706af..119adab 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -777,7 +777,7 @@ config MMC_CAVIUM_THUNDERX
>
>  config MMC_DW
>         tristate "Synopsys DesignWare Memory Card Interface"
> -       depends on ARC || ARM || ARM64 || MIPS || COMPILE_TEST
> +       depends on ARC || ARM || ARM64 || MIPS || RISCV || CSKY || COMPILE_TEST
>         help
>           This selects support for the Synopsys DesignWare Mobile Storage IP
>           block, this provides host support for SD and MMC interfaces, in both
> --
> 2.7.4
>
