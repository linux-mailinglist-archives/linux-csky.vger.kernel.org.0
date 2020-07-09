Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 412F321AA42
	for <lists+linux-csky@lfdr.de>; Fri, 10 Jul 2020 00:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgGIWGo (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 9 Jul 2020 18:06:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgGIWGo (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 9 Jul 2020 18:06:44 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9F1C08C5CE
        for <linux-csky@vger.kernel.org>; Thu,  9 Jul 2020 15:06:44 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t15so1695836pjq.5
        for <linux-csky@vger.kernel.org>; Thu, 09 Jul 2020 15:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8CK0I8zJbGlH0rJDFXmQvv5rpjqRFDp888sWR1bVovw=;
        b=s0JZ5pO/GZ7fXyqQDzDmx8kuDguwspLqorvrH+OdYjBFl/uCF0Be7BpE7WGfgBRcen
         4Htj9cQoZMRn4Z3ToPS9QIEmkfghneRkevOktoFcG7CLk7KCwN8ZyJsceZArCZZB7TBu
         IGhyyBu38L+7+mARgarW6v6rqsVnMQKlVY45ClkQpAPr/4D5jgxo9kTmKcVSn9RTkkYL
         eMsOxA2kaMLQ5LTNrvMTzqstPrtXoLW2AAoozhtuV31v0esflicl6y61CUlNWmJc1oxj
         Zt/saYZAe1nU4NqGrqLWw5l2dmiBQix+rIP2lxS/8JIODBlTgY7VEUtpa0VT92815QnE
         1+jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8CK0I8zJbGlH0rJDFXmQvv5rpjqRFDp888sWR1bVovw=;
        b=Aw+C6o1FgzOymqKG3TRNt1X2Nte+O6663BAYi2jDRTWP7CmA17lgK/HH3jF3ge6f/I
         WNbaJ8nqPEJYdc6e8S3Z1Wqq7N4b4dMG/MCLXwYOVejLVBbTRX8RbfJfoLO5Ejwa7N4h
         6LdZVD6h/vBkyx8HVe6E7J/+j7tAQqFNWKXL+qfVSJcn+F8swOjWNpaymPTvpaOFM2Wg
         AkUv//DoKKSAUBNsQErrpAXCXv0YBIbGGUstHLgH7QL22nkzEXuXF0owAdXQMgNHTWkd
         mqvO2nhV0idYLQog4A7QJu1olXxKB35KZjzYhbuJ+K1B0+VcxkYKQn4zPeMiK7WDBAQO
         iAdQ==
X-Gm-Message-State: AOAM530E9xsWwPZAMmezjGnpdAPceGAHXVtX8I3dd7QwI+sITxqoLdoD
        aHgkyMAUGT/zaO20QuAbD+pbSA==
X-Google-Smtp-Source: ABdhPJyR7Siu7Y/A4iQg3bBo7ftXxCV5V8bWZODguKGhUXjoYZ4xnZ1Kn21deuob8QYmEuB9LYfIOw==
X-Received: by 2002:a17:90a:2367:: with SMTP id f94mr2400859pje.20.1594332403444;
        Thu, 09 Jul 2020 15:06:43 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q20sm3875614pfn.111.2020.07.09.15.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 15:06:42 -0700 (PDT)
Date:   Thu, 09 Jul 2020 15:06:42 -0700 (PDT)
X-Google-Original-Date: Thu, 09 Jul 2020 14:48:00 PDT (-0700)
Subject:     Re: [PATCH V2 0/3] riscv: Enable LOCKDEP
In-Reply-To: <1593266228-61125-1-git-send-email-guoren@kernel.org>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, anup@brainfault.org,
        greentime.hu@sifive.com, zong.li@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, tycho@tycho.ws, nickhu@andestech.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, guoren@linux.alibaba.com
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     guoren@kernel.org
Message-ID: <mhng-af022fcc-7dce-4d1b-9204-d31241538412@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sat, 27 Jun 2020 06:57:05 PDT (-0700), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Lockdep is needed by proving the spinlocks and rwlocks. To support it,
> we need to add TRACE_IRQFLAGS codes in kernel/entry.S. These patches
> follow Documentation/irqflags-tracing.txt.
>
> Fixup 2 bugs that block the lockdep implementation.
>
> ---
> Changes in v2
>  - Remove sX regs recovery codes which are unnecessary, because
>    callee will handle them. Thx Greentime :)
>
>  - Move "restore a0 - a7" to handle_syscall, but if _TIF_SYSCALL_WORK
>    is set, "restore a1 - a7" is still duplicated. I prefer a C wrapper
>    for syscall.
>
> Guo Ren (2):
>   riscv: Fixup static_obj() fail
>   riscv: Enable LOCKDEP_SUPPORT & fixup TRACE_IRQFLAGS_SUPPORT
>
> Zong Li (1):
>   riscv: Fixup lockdep_assert_held with wrong param cpu_running
>
>  arch/riscv/Kconfig              |  3 +++
>  arch/riscv/kernel/entry.S       | 33 ++++++++++++++++++++++++++++++++-
>  arch/riscv/kernel/smpboot.c     |  1 -
>  arch/riscv/kernel/vmlinux.lds.S |  2 +-
>  4 files changed, 36 insertions(+), 3 deletions(-)

These are on for-next.  As far as I can tell lockdep is working, but I'm just
doing some simple boot tests.

Thanks!
