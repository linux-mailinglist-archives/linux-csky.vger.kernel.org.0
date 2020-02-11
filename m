Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7B0158B57
	for <lists+linux-csky@lfdr.de>; Tue, 11 Feb 2020 09:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgBKIhF (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 11 Feb 2020 03:37:05 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:58528 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBKIhF (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 11 Feb 2020 03:37:05 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id ED77F72CCEA;
        Tue, 11 Feb 2020 11:37:02 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id D294A7CC68F; Tue, 11 Feb 2020 11:37:02 +0300 (MSK)
Date:   Tue, 11 Feb 2020 11:37:02 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Ma Jun <majun258@linux.alibaba.com>
Cc:     ren_guo@c-sky.com, linux-csky@vger.kernel.org,
        strace-devel@lists.strace.io
Subject: Re: [RESEND PATCH] arch/csky: Fix the compile error when use abiv1
Message-ID: <20200211083702.GA4026@altlinux.org>
References: <1581317988-3826-1-git-send-email-majun258@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1581317988-3826-1-git-send-email-majun258@linux.alibaba.com>
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Mon, Feb 10, 2020 at 02:59:48PM +0800, Ma Jun wrote:
> From: MaJun <majun258@linux.alibaba.com>
> 
> Fix the bug caused by csky_regs. Because this struct
> has no member r1, only a1.
> 
> Signed-off-by: Ma Jun <majun258@linux.alibaba.com>
> ---
>  linux/csky/get_scno.c | 2 +-
>  linux/csky/set_scno.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/linux/csky/get_scno.c b/linux/csky/get_scno.c
> index 9efb202..9d4397a 100644
> --- a/linux/csky/get_scno.c
> +++ b/linux/csky/get_scno.c
> @@ -12,7 +12,7 @@ arch_get_scno(struct tcb *tcp)
>  #if defined(__CSKYABIV2__)
>  	tcp->scno = csky_regs.regs[3];
>  #else
> -	tcp->scno = csky_regs.r1;
> +	tcp->scno = csky_regs.a1;
>  #endif
>  	return 1;
>  }
> diff --git a/linux/csky/set_scno.c b/linux/csky/set_scno.c
> index 655d108..c1e1c18 100644
> --- a/linux/csky/set_scno.c
> +++ b/linux/csky/set_scno.c
> @@ -13,7 +13,7 @@ arch_set_scno(struct tcb *tcp, kernel_ulong_t scno)
>  #if defined(__CSKYABIV2__)
>  	csky_regs.regs[3] = scno;
>  #else
> -	csky_regs.r1 = scno;
> +	csky_regs.a1 = scno;
>  #endif
>  	return set_regs(tcp->pid);
>  }

Applied, thanks.


-- 
ldv
