Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECB6E79E1C6
	for <lists+linux-csky@lfdr.de>; Wed, 13 Sep 2023 10:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238834AbjIMIQ4 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 13 Sep 2023 04:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbjIMIQw (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 13 Sep 2023 04:16:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA9C2199A
        for <linux-csky@vger.kernel.org>; Wed, 13 Sep 2023 01:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694592962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jC7cBaRtwiLtOqIw5mLAFy7L+zLW4t61GX8cvLgSZ6Q=;
        b=YHfG4FnNQo8zV27yca7XWFH6SPkd97VKHap7P4koFKINiAHwfbOTY2gqKhomYxehOGm2Rn
        gMGpMhRTI5ypZn7msTuuNUFbZmhaMXIwu/wGf3wL8DBov8uQND47atHfvX26kwN2ubqzfV
        8yScGrz5OwejSplGcy+BIb4XqPoS6TA=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-d3Ryc6k0P6uyjE6PMPpFTw-1; Wed, 13 Sep 2023 04:16:01 -0400
X-MC-Unique: d3Ryc6k0P6uyjE6PMPpFTw-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-1cc7407e507so8264991fac.3
        for <linux-csky@vger.kernel.org>; Wed, 13 Sep 2023 01:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694592961; x=1695197761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jC7cBaRtwiLtOqIw5mLAFy7L+zLW4t61GX8cvLgSZ6Q=;
        b=mO4YFwv9OSbbWdGp/aU73te6sNxzYER/XYEV2gSDfpda4dumtp/0TmyK956j9Y4N6w
         fdY3upW5v1LfFvvX1WK5gG3YV1Ir96PunaZpxtO4pPY5TQ0moP6RFzJMbAEE2fBeYjPl
         +f6XOmjH2/XZ3b6hVc1abuKNx8bTiOWN+wBJSLxcRPvQIQQZSWNftA4h/ixZwJqoUkWB
         9TuvZppKgSux9/utnmoM/9Q+FXB7UYBi/FLMv7Z1DAPq9fV9+5WWWVyQUwFaQr7VDLt8
         miewgDVT1PR7nrM1AxQATRKQbu2g37j0wlWCW4RCohb7BMUvXwKFSbIs+xbufKQwXTwE
         rTNg==
X-Gm-Message-State: AOJu0YxBhzmcENNJELigONFtxotzfvN2Fn4+LnuB1nDDTknP9eqx0sdf
        X1BnOUFVo2HHjB9Bmz6vAidZPPWCplhEgBBuwxDBJt2/U6oi+crfKJ5e/GKsKWi67IxNR4/eBHx
        3bD6+Ft2h2YgRevc6sQiPlQ==
X-Received: by 2002:a05:6870:8a29:b0:1bb:ac7:2e34 with SMTP id p41-20020a0568708a2900b001bb0ac72e34mr2086715oaq.40.1694592960763;
        Wed, 13 Sep 2023 01:16:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOZaoTn/FO9XWZIjXe4DzC8fn4zXFZUBlh/tx8ipyh0Rk/Pu3d+gYYuWAYZlcTSDNBgzo2Hg==
X-Received: by 2002:a05:6870:8a29:b0:1bb:ac7:2e34 with SMTP id p41-20020a0568708a2900b001bb0ac72e34mr2086683oaq.40.1694592960455;
        Wed, 13 Sep 2023 01:16:00 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:4ff9:7c29:fe41:6aa7:43df])
        by smtp.gmail.com with ESMTPSA id e2-20020a056870944200b001d533004669sm6032266oal.32.2023.09.13.01.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 01:16:00 -0700 (PDT)
Date:   Wed, 13 Sep 2023 05:15:51 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     guoren@kernel.org
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 02/17] asm-generic: ticket-lock: Move into
 ticket_spinlock.h
Message-ID: <ZQFvt2nW4IwpdDo3@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-3-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910082911.3378782-3-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sun, Sep 10, 2023 at 04:28:56AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Move ticket-lock definition into an independent file. This is the
> preparation for the next combo spinlock of riscv.
> 
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  include/asm-generic/spinlock.h        |  87 +---------------------
>  include/asm-generic/ticket_spinlock.h | 103 ++++++++++++++++++++++++++
>  2 files changed, 104 insertions(+), 86 deletions(-)
>  create mode 100644 include/asm-generic/ticket_spinlock.h
> 
> diff --git a/include/asm-generic/spinlock.h b/include/asm-generic/spinlock.h
> index 4773334ee638..970590baf61b 100644
> --- a/include/asm-generic/spinlock.h
> +++ b/include/asm-generic/spinlock.h
> @@ -1,94 +1,9 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  
> -/*
> - * 'Generic' ticket-lock implementation.
> - *
> - * It relies on atomic_fetch_add() having well defined forward progress
> - * guarantees under contention. If your architecture cannot provide this, stick
> - * to a test-and-set lock.
> - *
> - * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
> - * sub-word of the value. This is generally true for anything LL/SC although
> - * you'd be hard pressed to find anything useful in architecture specifications
> - * about this. If your architecture cannot do this you might be better off with
> - * a test-and-set.
> - *
> - * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
> - * uses atomic_fetch_add() which is RCsc to create an RCsc hot path, along with
> - * a full fence after the spin to upgrade the otherwise-RCpc
> - * atomic_cond_read_acquire().
> - *
> - * The implementation uses smp_cond_load_acquire() to spin, so if the
> - * architecture has WFE like instructions to sleep instead of poll for word
> - * modifications be sure to implement that (see ARM64 for example).
> - *
> - */
> -
>  #ifndef __ASM_GENERIC_SPINLOCK_H
>  #define __ASM_GENERIC_SPINLOCK_H
>  
> -#include <linux/atomic.h>
> -#include <asm-generic/spinlock_types.h>
> -
> -static __always_inline void arch_spin_lock(arch_spinlock_t *lock)
> -{
> -	u32 val = atomic_fetch_add(1<<16, &lock->val);
> -	u16 ticket = val >> 16;
> -
> -	if (ticket == (u16)val)
> -		return;
> -
> -	/*
> -	 * atomic_cond_read_acquire() is RCpc, but rather than defining a
> -	 * custom cond_read_rcsc() here we just emit a full fence.  We only
> -	 * need the prior reads before subsequent writes ordering from
> -	 * smb_mb(), but as atomic_cond_read_acquire() just emits reads and we
> -	 * have no outstanding writes due to the atomic_fetch_add() the extra
> -	 * orderings are free.
> -	 */
> -	atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);
> -	smp_mb();
> -}
> -
> -static __always_inline bool arch_spin_trylock(arch_spinlock_t *lock)
> -{
> -	u32 old = atomic_read(&lock->val);
> -
> -	if ((old >> 16) != (old & 0xffff))
> -		return false;
> -
> -	return atomic_try_cmpxchg(&lock->val, &old, old + (1<<16)); /* SC, for RCsc */
> -}
> -
> -static __always_inline void arch_spin_unlock(arch_spinlock_t *lock)
> -{
> -	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
> -	u32 val = atomic_read(&lock->val);
> -
> -	smp_store_release(ptr, (u16)val + 1);
> -}
> -
> -static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
> -{
> -	u32 val = lock.val.counter;
> -
> -	return ((val >> 16) == (val & 0xffff));
> -}
> -
> -static __always_inline int arch_spin_is_locked(arch_spinlock_t *lock)
> -{
> -	arch_spinlock_t val = READ_ONCE(*lock);
> -
> -	return !arch_spin_value_unlocked(val);
> -}
> -
> -static __always_inline int arch_spin_is_contended(arch_spinlock_t *lock)
> -{
> -	u32 val = atomic_read(&lock->val);
> -
> -	return (s16)((val >> 16) - (val & 0xffff)) > 1;
> -}
> -
> +#include <asm-generic/ticket_spinlock.h>
>  #include <asm/qrwlock.h>
>  
>  #endif /* __ASM_GENERIC_SPINLOCK_H */
> diff --git a/include/asm-generic/ticket_spinlock.h b/include/asm-generic/ticket_spinlock.h
> new file mode 100644
> index 000000000000..cfcff22b37b3
> --- /dev/null
> +++ b/include/asm-generic/ticket_spinlock.h
> @@ -0,0 +1,103 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * 'Generic' ticket-lock implementation.
> + *
> + * It relies on atomic_fetch_add() having well defined forward progress
> + * guarantees under contention. If your architecture cannot provide this, stick
> + * to a test-and-set lock.
> + *
> + * It also relies on atomic_fetch_add() being safe vs smp_store_release() on a
> + * sub-word of the value. This is generally true for anything LL/SC although
> + * you'd be hard pressed to find anything useful in architecture specifications
> + * about this. If your architecture cannot do this you might be better off with
> + * a test-and-set.
> + *
> + * It further assumes atomic_*_release() + atomic_*_acquire() is RCpc and hence
> + * uses atomic_fetch_add() which is RCsc to create an RCsc hot path, along with
> + * a full fence after the spin to upgrade the otherwise-RCpc
> + * atomic_cond_read_acquire().
> + *
> + * The implementation uses smp_cond_load_acquire() to spin, so if the
> + * architecture has WFE like instructions to sleep instead of poll for word
> + * modifications be sure to implement that (see ARM64 for example).
> + *
> + */
> +
> +#ifndef __ASM_GENERIC_TICKET_SPINLOCK_H
> +#define __ASM_GENERIC_TICKET_SPINLOCK_H
> +
> +#include <linux/atomic.h>
> +#include <asm-generic/spinlock_types.h>
> +
> +static __always_inline void ticket_spin_lock(arch_spinlock_t *lock)
> +{
> +	u32 val = atomic_fetch_add(1<<16, &lock->val);
> +	u16 ticket = val >> 16;
> +
> +	if (ticket == (u16)val)
> +		return;
> +
> +	/*
> +	 * atomic_cond_read_acquire() is RCpc, but rather than defining a
> +	 * custom cond_read_rcsc() here we just emit a full fence.  We only
> +	 * need the prior reads before subsequent writes ordering from
> +	 * smb_mb(), but as atomic_cond_read_acquire() just emits reads and we
> +	 * have no outstanding writes due to the atomic_fetch_add() the extra
> +	 * orderings are free.
> +	 */
> +	atomic_cond_read_acquire(&lock->val, ticket == (u16)VAL);
> +	smp_mb();
> +}
> +
> +static __always_inline bool ticket_spin_trylock(arch_spinlock_t *lock)
> +{
> +	u32 old = atomic_read(&lock->val);
> +
> +	if ((old >> 16) != (old & 0xffff))
> +		return false;
> +
> +	return atomic_try_cmpxchg(&lock->val, &old, old + (1<<16)); /* SC, for RCsc */
> +}
> +
> +static __always_inline void ticket_spin_unlock(arch_spinlock_t *lock)
> +{
> +	u16 *ptr = (u16 *)lock + IS_ENABLED(CONFIG_CPU_BIG_ENDIAN);
> +	u32 val = atomic_read(&lock->val);
> +
> +	smp_store_release(ptr, (u16)val + 1);
> +}
> +
> +static __always_inline int ticket_spin_value_unlocked(arch_spinlock_t lock)
> +{
> +	u32 val = lock.val.counter;
> +
> +	return ((val >> 16) == (val & 0xffff));
> +}
> +
> +static __always_inline int ticket_spin_is_locked(arch_spinlock_t *lock)
> +{
> +	arch_spinlock_t val = READ_ONCE(*lock);
> +
> +	return !ticket_spin_value_unlocked(val);
> +}
> +
> +static __always_inline int ticket_spin_is_contended(arch_spinlock_t *lock)
> +{
> +	u32 val = atomic_read(&lock->val);
> +
> +	return (s16)((val >> 16) - (val & 0xffff)) > 1;
> +}
> +
> +/*
> + * Remapping spinlock architecture specific functions to the corresponding
> + * ticket spinlock functions.
> + */
> +#define arch_spin_is_locked(l)		ticket_spin_is_locked(l)
> +#define arch_spin_is_contended(l)	ticket_spin_is_contended(l)
> +#define arch_spin_value_unlocked(l)	ticket_spin_value_unlocked(l)
> +#define arch_spin_lock(l)		ticket_spin_lock(l)
> +#define arch_spin_trylock(l)		ticket_spin_trylock(l)
> +#define arch_spin_unlock(l)		ticket_spin_unlock(l)
> +
> +#endif /* __ASM_GENERIC_TICKET_SPINLOCK_H */

IIUC here most of the file was moved, and the above defines are introduced.

I understand this pattern of creating the defines at the end of the file is 
the same used in "asm-generic/qspinlock.h" but I don't actually think this
is a good way of doing this.

Instead of having those defines here (and similarly on 
"asm-generic/qspinlock.h", I think it would be better to have those defines 
in the arch-specific header including them, which would allow the arch to 
include multiple spinlock versions and decide (compile-time, even run-time)
which version to use. It gives decision power to the arch code.

(And it would remove the need of undefining them on a later patch)

There are only 3 archs which use this arch-generic qspinlock, so should 
not be a huge deal to have the defines copied there:

# git grep asm-generic/qspinlock.h
arch/loongarch/include/asm/qspinlock.h:16:#include <asm-generic/qspinlock.h>
arch/sparc/include/asm/qspinlock.h:6:#include <asm-generic/qspinlock.h>
arch/x86/include/asm/qspinlock.h:107:#include <asm-generic/qspinlock.h>

Other than that:
Reviewed-by: Leonardo Bras <leobras@redhat.com>

