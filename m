Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CA81B460C
	for <lists+linux-csky@lfdr.de>; Wed, 22 Apr 2020 15:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbgDVNPO (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 22 Apr 2020 09:15:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:53572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgDVNPO (ORCPT <rfc822;linux-csky@vger.kernel.org>);
        Wed, 22 Apr 2020 09:15:14 -0400
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3978B2077D
        for <linux-csky@vger.kernel.org>; Wed, 22 Apr 2020 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587561313;
        bh=vblH/yZ/u73C+LzZ3aNjUcEQQynkpX3Rm9l2qj6xW5E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eQb6RbKD2meFb+lh6M/nQDH5GlXcx3U9vE22B8Lyri+UzValA6AicSpH3FH5UUh8g
         dOaZYcEWNP71rPQSVmTTvwrbEFTSyPmWMzBtfmBwv0GcKmYoMXRWNlTZVP3R2kHn9J
         jt5yCczn+PTbNpBZzeeUJRjle4VAYJGBWMmpDsb4=
Received: by mail-lj1-f175.google.com with SMTP id f18so2181980lja.13
        for <linux-csky@vger.kernel.org>; Wed, 22 Apr 2020 06:15:13 -0700 (PDT)
X-Gm-Message-State: AGi0PuZSU28qEW4I8/+gWkHbnA3yborrX72l8uNNDSwmtkn3GFjwiHW7
        c9NuB+PvmeMl9oF3qO8sm9Rx6ov7JAJZvwCCPD8=
X-Google-Smtp-Source: APiQypIE/I42H8zLFht4Z5cBFmKd+zUn7Og+wtUXWKY+HsGmopmtmjmh7mgXEUf8EhSEwmRnTnE8UOxc35QncXXkves=
X-Received: by 2002:a05:651c:119a:: with SMTP id w26mr5697284ljo.53.1587561311339;
 Wed, 22 Apr 2020 06:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <1587455788-9450-1-git-send-email-yibin_liu@c-sky.com>
In-Reply-To: <1587455788-9450-1-git-send-email-yibin_liu@c-sky.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 22 Apr 2020 21:15:00 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQPOuLK5n8F7zsNgsd7fcTPOTNHFn_b4hB5dUMBQhqeJA@mail.gmail.com>
Message-ID: <CAJF2gTQPOuLK5n8F7zsNgsd7fcTPOTNHFn_b4hB5dUMBQhqeJA@mail.gmail.com>
Subject: Re: [PATCH] Fix MSA register operation error
To:     Liu Yibin <yibin_liu@c-sky.com>
Cc:     linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Thx for the patch.

On Tue, Apr 21, 2020 at 3:56 PM Liu Yibin <yibin_liu@c-sky.com> wrote:
>
> MSA register should shift to the right 29 for bits,
> rather than 28 bits.
>
> Signed-off-by: Liu Yibin <yibin_liu@c-sky.com>
> ---
>  arch/csky/abiv1/inc/abi/entry.h | 6 ++++--
>  arch/csky/abiv2/inc/abi/entry.h | 6 ++++--
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/arch/csky/abiv1/inc/abi/entry.h b/arch/csky/abiv1/inc/abi/entry.h
> index 5056ebb..1dc5ed8 100644
> --- a/arch/csky/abiv1/inc/abi/entry.h
> +++ b/arch/csky/abiv1/inc/abi/entry.h
> @@ -16,6 +16,8 @@
>  #define LSAVE_A4       40
>  #define LSAVE_A5       44
>
> +#define MSA_SHIFT              29
> +
>  #define usp ss1
>
>  .macro USPTOKSP
> @@ -167,8 +169,8 @@
>          *   BA     Reserved  C   D   V
>          */
>         cprcr   r6, cpcr30
> -       lsri    r6, 28
> -       lsli    r6, 28
> +       lsri    r6, MSA_SHIFT
> +       lsli    r6, MSA_SHIFT
>         addi    r6, 0xe
>         cpwcr   r6, cpcr30
>
> diff --git a/arch/csky/abiv2/inc/abi/entry.h b/arch/csky/abiv2/inc/abi/entry.h
> index a99aff5..2507cbf 100644
> --- a/arch/csky/abiv2/inc/abi/entry.h
> +++ b/arch/csky/abiv2/inc/abi/entry.h
> @@ -14,6 +14,8 @@
>  #define LSAVE_A2       32
>  #define LSAVE_A3       36
>
> +#define MSA_SHIFT              29
> +
>  #define KSPTOUSP
>  #define USPTOKSP
>
> @@ -285,8 +287,8 @@
>          */
>         mfcr    r6, cr<30, 15> /* Get MSA0 */
>  2:
> -       lsri    r6, 28
> -       lsli    r6, 28
> +       lsri    r6, MSA_SHIFT
> +       lsli    r6, MSA_SHIFT
Yes, it's 512MB align and we should only reserve highest 3 bits.

But I'll change it to with keeping the primary author:
-       lsri    r6, 28
-       lsli    r6, 28
+       lsri    r6, 29
+       lsli    r6, 29

>         addi    r6, 0x1ce
>         mtcr    r6, cr<30, 15> /* Set MSA0 */
>
> --
> 2.7.4
>


-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
