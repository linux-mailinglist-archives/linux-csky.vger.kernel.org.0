Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DD6228DBA
	for <lists+linux-csky@lfdr.de>; Wed, 22 Jul 2020 03:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731594AbgGVBov (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 21 Jul 2020 21:44:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbgGVBov (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 21 Jul 2020 21:44:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2057BC0619DB
        for <linux-csky@vger.kernel.org>; Tue, 21 Jul 2020 18:44:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id f16so342431pjt.0
        for <linux-csky@vger.kernel.org>; Tue, 21 Jul 2020 18:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=yRf1KkzEQtnGqiMsmmJMd1M1Ly6X4XyFRu3fx8vPXY0=;
        b=XQHFTK8TLwZMhMuzQyIKFEykOxgVlgNBf9kaI3gUbbLyJWGbwT3FRt8tHlFdtILJ4c
         162oajiVIQqH8z1mqFu5PRaz343GNQwde5dW8LT3G148vliNleRUs5HvY7OBsX/0nzdO
         qbhS0vkY3rnvqHNeTlOB854yvG8n6FdfxEyDRdnQFrtELcOJgj8NCiPdmISu8WcAqbdO
         AoShQJKs6FsZDnsSYHlYzxKbnJKmrMQBX9SwdOH5Ew0MP8n1r5T9Je3XFJt6wqvJUUmR
         yvTngVKx+sAR2oB9r5jHVsZ4bpXAi6kMAHBA61m52VwIXLg+hopolQSiecm6SQUxU24l
         L7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=yRf1KkzEQtnGqiMsmmJMd1M1Ly6X4XyFRu3fx8vPXY0=;
        b=ZIwwtHh+xaWSX3hgtzcHQC2UUF7cxW41ozOi2wIAPjyyyNYob9rBRzNeF53oBgMMLl
         uvhsW0GZF72tX6ZCaE8M5w4Uy+L3XCgpgZmtKlHFlmu1wLCl1Zwo3+/Yf9Qjp/a46vyL
         B43wkvAa82RRWKTpEkc0UOWVNMH4B5lS26qZ9d6sSvLdPNNoctzEIIDhgHKWwo5pLheS
         SPolg+VbP5oGrQWl8OmEs+MXvPHYtFXhQMR5OqgJR3sYvUIjZTjV56tGtM6JcWeZ03DY
         cxVSS8PSRadhzFnF40JBbTc66WzQyEmAaF0DW0WmEve96NBCsHSsyZvulaUYZ2VUWHpy
         erdA==
X-Gm-Message-State: AOAM532cGvmh+I7FeVQ1du0FsTbC8AdtYkkDFCoPOMT3HT9qB0NFYb3K
        KkOGdHaTGGITAdPKK0TxpAOH3w==
X-Google-Smtp-Source: ABdhPJwywb/lnJmZV4jLcblWIs0VYXUeViGyBDggD6qYivCicW5bfW11E23m5aEUiqrPdmqQ4G5gHA==
X-Received: by 2002:a17:90a:4fa2:: with SMTP id q31mr8100898pjh.178.1595382290361;
        Tue, 21 Jul 2020 18:44:50 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 4sm18359304pgk.68.2020.07.21.18.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 18:44:49 -0700 (PDT)
Date:   Tue, 21 Jul 2020 18:44:49 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Jul 2020 18:44:46 PDT (-0700)
Subject:     Re: [PATCH] riscv: Cleanup unnecessary define in asm-offset.c
In-Reply-To: <1594561309-65026-1-git-send-email-guoren@kernel.org>
CC:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@kernel.org,
        guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-6e379a55-7e6a-46aa-8faa-011756333d92@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sun, 12 Jul 2020 06:41:49 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
>  - TASK_THREAD_SP is duplicated define
>  - TASK_STACK is no use at all
>  - Don't worry about thread_info's offset in task_struct, have
>    a look on comment in include/linux/sched.h:
>
> struct task_struct {
> 	/*
> 	 * For reasons of header soup (see current_thread_info()), this
> 	 * must be the first element of task_struct.
> 	 */
> 	struct thread_info		thread_info;
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> ---
>  arch/riscv/kernel/asm-offsets.c | 3 ---
>  arch/riscv/kernel/entry.S       | 5 -----
>  2 files changed, 8 deletions(-)
>
> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
> index 07cb9c1..db20344 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -27,9 +27,6 @@ void asm_offsets(void)
>  	OFFSET(TASK_THREAD_S9, task_struct, thread.s[9]);
>  	OFFSET(TASK_THREAD_S10, task_struct, thread.s[10]);
>  	OFFSET(TASK_THREAD_S11, task_struct, thread.s[11]);
> -	OFFSET(TASK_THREAD_SP, task_struct, thread.sp);
> -	OFFSET(TASK_STACK, task_struct, stack);
> -	OFFSET(TASK_TI, task_struct, thread_info);
>  	OFFSET(TASK_TI_FLAGS, task_struct, thread_info.flags);
>  	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
>  	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index cae7e6d..3e8707e 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -389,12 +389,7 @@ ENTRY(__switch_to)
>  	lw a4, TASK_TI_CPU(a1)
>  	sw a3, TASK_TI_CPU(a1)
>  	sw a4, TASK_TI_CPU(a0)
> -#if TASK_TI != 0
> -#error "TASK_TI != 0: tp will contain a 'struct thread_info', not a 'struct task_struct' so get_current() won't work."
> -	addi tp, a1, TASK_TI
> -#else
>  	move tp, a1
> -#endif

Seems reasonable.  That was really there to save anyone who got bit by the
conversion to to THREAD_INFO_IN_TASK.

I've added a comment and put this on for-next.

Thanks!

>  	ret
>  ENDPROC(__switch_to)

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
