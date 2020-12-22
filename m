Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61A42E0FE8
	for <lists+linux-csky@lfdr.de>; Tue, 22 Dec 2020 22:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbgLVVoI (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 22 Dec 2020 16:44:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgLVVoI (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 22 Dec 2020 16:44:08 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4081C0613D6
        for <linux-csky@vger.kernel.org>; Tue, 22 Dec 2020 13:43:27 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id x12so8076993plr.10
        for <linux-csky@vger.kernel.org>; Tue, 22 Dec 2020 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V18RJFVoSD2HfPTrMybJhWRx+16Y//JP10XUyAiF9C0=;
        b=MoFoz97ipfgL0tskYxv3eUZrXs1Gtf4S6AIT48y4RoUx4gTy/pyHeDU0ASRe4+CTGV
         6EQPpsfEG8ojet/F+BqJP7osfq2axER1b9OdQ5I7dbdF8eIZ5zNdTK9moJab2eBpN90w
         Vqz2Kherc3CmoKwR9ICk4/+1KBetvtuXSFh+kNpzebgvZW1e10DodKAND41hjcHoL7O1
         aPBdL2Cp6KXghjcUF5GrxhFp4g+00u7vCveST0JC+7XDzWJjhpp47uHFhFbzr8/ZqfKw
         O4BIlbC80rAzXV+Cw98wRd4KHOlJJ73+yFwfcfXmpcLWmwDJ8GtjtZWcE5k59g3GypE5
         qpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V18RJFVoSD2HfPTrMybJhWRx+16Y//JP10XUyAiF9C0=;
        b=k4DhoN3xqGd8kWtQ5osvMgXZZXTjIzwdIpZcVaYtki+EifgXH5rRtMSW9kvHRY9O4q
         nR1q3pha23uVyEpggbq1f1EFYI04qfL7gDOhIeZOxl0pIR9K7UXHxNQ4vG1pyiu66xnS
         ApU66Py1j6xjw2wS8Q/T7OTkZCcCeHa/UZ/zsx616bNrjRJkfifcKHlk9Nk6o6CXGU3O
         T3ykIGbckeJwiDwRmd4sBehBlk3IaDGc7HbVkTMIOuKsNPhIoX92GAEKteYCsvJg5CCU
         SuyeDQc7CTWEcZd2FdbkWomqUfElBF1gD5XZmqu1d2E85COi8Lu852uLhj+OlHo4a79n
         Qoxg==
X-Gm-Message-State: AOAM530YfZNFbonYd9azLMX46sj88TlOueFYOnhuovHD0+V9pfA0rLOC
        ebsvUIMV3kF60Xb+cESFY9Mm6PI4rb0yfg==
X-Google-Smtp-Source: ABdhPJynPZBPU88MgcEl5WcwU0cdYjZC20/3FRJRStClymFa4iKtg9+XkPvnpAcMdwtKD+bNajR6Jw==
X-Received: by 2002:a17:90a:fc83:: with SMTP id ci3mr24052182pjb.145.1608673407151;
        Tue, 22 Dec 2020 13:43:27 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:a6ae:11ff:fe11:4abb])
        by smtp.gmail.com with ESMTPSA id s29sm22665086pgn.65.2020.12.22.13.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 13:43:26 -0800 (PST)
Date:   Tue, 22 Dec 2020 13:43:23 -0800
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: building csky with CC=clang
Message-ID: <20201222214323.655tjdqdvxhw3722@google.com>
References: <CAKwvOdmnhsPU0UA9uEd1HTQ_yoBO8h741+sKrtebcPsXpXn8_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAKwvOdmnhsPU0UA9uEd1HTQ_yoBO8h741+sKrtebcPsXpXn8_g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 2020-12-22, 'Nick Desaulniers' via Clang Built Linux wrote:
>Hello!
>I was playing with some of LLVM's experimental backends (m68k) and saw
>there was a CSKY backend. I rebuilt LLVM to support CSKY, but I ran
>into trouble building the kernel before even getting to the compiler
>invocation:
>
>$ ARCH=csky CROSS_COMPILE=csky-linux-gnu- make CC=clang -j71 defconfig
>...
>scripts/Kconfig.include:40: linker 'csky-linux-gnu-ld' not found
>
>My distro doesn't package binutils-csky-linux-gnu, is there
>documentation on how to build the kernel targeting CSKY, starting with
>building GNU binutils configured with CSKY emulation?

Note also that the llvm/lib/Target/CSKY has not been fully upstreamed
yet. It is a WIP https://lists.llvm.org/pipermail/llvm-dev/2020-August/144481.html
I will not expect clang csky to work currently.
(The latest committed LLVM patch is https://reviews.llvm.org/D93372
Normally committing an important piece of a large patch series like this should take
a bit longer time longer after someone in the community accepted it
https://llvm.org/docs/CodeReview.html#can-code-be-reviewed-after-it-is-committed )

I do want to raise the recent LLVM M68k target. Its patches ([M67k] (Patch */8))
are very organized and the main proposer shares updates to llvm-dev regularly.
There is a lot from the process where the C-SKY target can learn from.
