Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B8EC244FE1
	for <lists+linux-csky@lfdr.de>; Sat, 15 Aug 2020 00:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHNWgN (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 14 Aug 2020 18:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727908AbgHNWgJ (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 14 Aug 2020 18:36:09 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF039C061385
        for <linux-csky@vger.kernel.org>; Fri, 14 Aug 2020 15:36:08 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o13so5213224pgf.0
        for <linux-csky@vger.kernel.org>; Fri, 14 Aug 2020 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=1Gm4DBq2aKiHPSTyt1FIj1F/+D7DhQ4fc8VI2sz0rsI=;
        b=lJ/o+2Nt05U5e0lpQPxqMtSE2E7+/KYFBl+vbHoFZ2b2zxLWZnJaieenezGM3PFgTq
         WS2o0XYtew02RQO3Fd3ntzN3idtpMBg32SI8dHA0ztqWw69TIOjST2gfSC8jAUJorrTJ
         Yv9s0ID87nAT1oQeJlbkb94alXD2B7X3/r31NItPQ6CRyvJo3ldLKYRYnLfgcF4j8O1f
         dDNlzXtKLL+W5OA2dV8LS14ife/GCS6TNLWHktTsZnc7Qust4yLgCt2iMZUHD8FTMNMi
         9arAaxIiI44nVNEMtTQexxiWc4GxwcBIonig4orLKuXGeyBIHvx2FvE8ilEYTpWG8I5e
         a3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=1Gm4DBq2aKiHPSTyt1FIj1F/+D7DhQ4fc8VI2sz0rsI=;
        b=eqeOVuRXViKRdkJxCYmCaWkleUTIJYRajdRo5g0YXZ7CjZs+IXvtbKBlqKHWxzE1bO
         m6b3Q4YqxJJ1TyoZ/g+SHBUbZ0Pf2CXQopcX/XAjijqZ8nXccjS8JBUKX3Q7n/CCQYvD
         zvLY1tME9ZxIWAnEC7ywOj8qjsBMBAQN/9fnA/UhpHvZDOmyTvdF8AQyXysxph1PC/m/
         IYF3BkmfwV7Fy1YSI5SDo/wI1D4uhyUJ0zDW8z2BAN3yaQdTgAYDDjvaEmueGwJRweiH
         tIHoAX/2gfZpUqGKaSZmElwEmk3BLz1Vwnn71oBb7W0Ff+vn6sppn60ZqhK1BkxRt1yR
         gTPA==
X-Gm-Message-State: AOAM532HgCzucsw2eXz9hLQvPeORw1ipknC2d58igoaFA1NBw+BpJXl6
        9MmXnCgvjjMjwH70B3mpmLJW+g==
X-Google-Smtp-Source: ABdhPJxSggPlmWg3KIB8rUnjcpOCqr5iuQ37qtyRCNb+C/Wl89zCMHW8/n9UhEL046/uVKT0MxbZQQ==
X-Received: by 2002:a63:1e65:: with SMTP id p37mr3058000pgm.58.1597444567189;
        Fri, 14 Aug 2020 15:36:07 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w6sm8540368pgr.82.2020.08.14.15.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 15:36:06 -0700 (PDT)
Date:   Fri, 14 Aug 2020 15:36:06 -0700 (PDT)
X-Google-Original-Date: Fri, 14 Aug 2020 15:34:49 PDT (-0700)
Subject:     Re: [PATCH v3 3/7] riscv: Fixup kprobes handler couldn't change pc
In-Reply-To: <1594683562-68149-4-git-send-email-guoren@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, mhiramat@kernel.org,
        oleg@redhat.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, anup@brainfault.org,
        linux-csky@vger.kernel.org, greentime.hu@sifive.com,
        zong.li@sifive.com, guoren@kernel.org, me@packi.ch,
        Bjorn Topel <bjorn.topel@gmail.com>, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-296dd63e-71de-4d30-acfb-df374d12388d@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Mon, 13 Jul 2020 16:39:18 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The "Changing Execution Path" section in the Documentation/kprobes.txt
> said:
>
> Since kprobes can probe into a running kernel code, it can change the
> register set, including instruction pointer.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/kernel/mcount-dyn.S | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> index 35a6ed7..4b58b54 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -123,6 +123,7 @@ ENDPROC(ftrace_caller)
>  	sd	ra, (PT_SIZE_ON_STACK+8)(sp)
>  	addi	s0, sp, (PT_SIZE_ON_STACK+16)
>
> +	sd ra,  PT_EPC(sp)
>  	sd x1,  PT_RA(sp)
>  	sd x2,  PT_SP(sp)
>  	sd x3,  PT_GP(sp)

So that's definately not going to be EPC any more.  I'm not sure that field is
sanely named, though, as it's really just the PC when it comes to other ptrace
stuff.

> @@ -157,6 +158,7 @@ ENDPROC(ftrace_caller)
>  	.endm
>
>  	.macro RESTORE_ALL
> +	ld ra,  PT_EPC(sp)
>  	ld x1,  PT_RA(sp)

x1 is ra, so loading it twice doesn't seem reasonable.

>  	ld x2,  PT_SP(sp)
>  	ld x3,  PT_GP(sp)
> @@ -190,7 +192,6 @@ ENDPROC(ftrace_caller)
>  	ld x31, PT_T6(sp)
>
>  	ld	s0, (PT_SIZE_ON_STACK)(sp)
> -	ld	ra, (PT_SIZE_ON_STACK+8)(sp)
>  	addi	sp, sp, (PT_SIZE_ON_STACK+16)
>  	.endm

If you're dropping the load you should drop the store above as well.  In
general this seems kind of mixed up, both before and after this patch.
