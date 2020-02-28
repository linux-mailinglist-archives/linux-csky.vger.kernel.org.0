Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76AB2173087
	for <lists+linux-csky@lfdr.de>; Fri, 28 Feb 2020 06:38:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgB1FiO (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 28 Feb 2020 00:38:14 -0500
Received: from mail-pj1-f49.google.com ([209.85.216.49]:36887 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgB1FiO (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 28 Feb 2020 00:38:14 -0500
Received: by mail-pj1-f49.google.com with SMTP id m13so822500pjb.2
        for <linux-csky@vger.kernel.org>; Thu, 27 Feb 2020 21:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nd75UqfiWgYEMzGfi1FcAf9SYOaH39soXyNqY0PuS8c=;
        b=MeGJIgcgcfX4q6yPzBPptEHZ+/Xl2Ibdbs8rd8ycJ0CwwIVdwnKuc8dU9ovvXtxpt5
         BwQGvW0534DpshKk5G5GLh46pkt/R2jWpm30atJmIVSRk4LwjibdinqWsmSJn4lRPuDd
         2SMmFw7hjeTv0OvvUxfSzosP6rFZQ3qjNJhZt+m30XiVoz03CzbiIQWdwe9tBkXmJ90H
         ysBIlPBW2oR+2SPdgTmeVGedHklRW0dNUEmesOh0nXGgfSWpl+M9qYLFQr4Dkvk7Jmhu
         NbGatMFhH+guCFVN4yzYKfEpmIDcymI+WWRGuth5kJ5r6c99hkhnkSpgkge5PRlLvfKb
         AGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nd75UqfiWgYEMzGfi1FcAf9SYOaH39soXyNqY0PuS8c=;
        b=X9/1KWTcbDnvLA4Nm9436UwOHeL8omIn3bhhlm1T+kHxXJW5ty9dQwt67lBrUlvcpB
         CuqbX4zUiSHGIMcNoOg9ef9bdrJfzTG7Yt8OtMY86vJqTWppm0kz8LQW1POycE7zR0i6
         HrXKICD+X9Tm5lRFYIFZAsEMKXPwpXH2yE9PKGUbSwUOgdNfPMhKhMRnfbBjm25az59H
         g2q5Nc6R9bUyuS0EMHTR4WzoZAHy4SFBRx2BkUaLUJqZiAXnFXNdiKDtJ2XendhSM0d+
         15iDcdhMWlhDLOHH4jBnuRxnIYniar8iCCoeHF81ILaYw8B5nLQagLGub2n15FKS4pEN
         TiDw==
X-Gm-Message-State: APjAAAVY4zeVnE60l6BN0P4rhdSh4U7cLBtuAyQMeHrdUJ6lBYX2ti8o
        43YI5UOq3nmV63t6OTSYS9nb818ptls=
X-Google-Smtp-Source: APXvYqxG0Mmy1HhzKK7fwaCD3dN1GvS8ULVdHIrlDg/3eNBjgDgH0Hmllzw2ciXNhbslMhE7ziTZGw==
X-Received: by 2002:a17:902:864c:: with SMTP id y12mr2449074plt.8.1582868292821;
        Thu, 27 Feb 2020 21:38:12 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
        by smtp.gmail.com with ESMTPSA id 144sm9711726pfc.45.2020.02.27.21.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 21:38:12 -0800 (PST)
Subject: Re: [PATCH v4 5/5] target/riscv: add vector amo operations
To:     LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
        chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-6-zhiwei_liu@c-sky.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <03bf483e-d6bb-9de4-9934-12bfa7093ad3@linaro.org>
Date:   Thu, 27 Feb 2020 21:38:10 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225103508.7651-6-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 2/25/20 2:35 AM, LIU Zhiwei wrote:
> +    if (s->sew < 2) {
> +        return false;
> +    }

This could just as easily be in amo_check?

> +
> +    if (tb_cflags(s->base.tb) & CF_PARALLEL) {
> +#ifdef CONFIG_ATOMIC64
> +        fn = fns[0][seq][s->sew - 2];
> +#else
> +        gen_helper_exit_atomic(cpu_env);
> +        s->base.is_jmp = DISAS_NORETURN;
> +        return true;
> +#endif

Why are you raising exit_atomic without first checking that s->sew == 3?  We
can do 32-bit atomic operations always.

> +    } else {
> +        fn = fns[1][seq][s->sew - 2];
> +    }
> +    if (fn == NULL) {
> +        return false;
> +    }
> +
> +    return amo_trans(a->rd, a->rs1, a->rs2, data, fn, s);
> +}
> +
> +static bool amo_check(DisasContext *s, arg_rwdvm* a)
> +{
> +    return (vext_check_isa_ill(s, RVV | RVA) &&
> +            (a->wd ? vext_check_overlap_mask(s, a->rd, a->vm) : 1) &&
> +            vext_check_reg(s, a->rd, false) &&
> +            vext_check_reg(s, a->rs2, false));
> +}

I guess the "If SEW is greater than XLEN, an illegal instruction exception is
raised" requirement is currently in the column of NULLs in the !CONFIG_RISCV64
block.  But it might be better to have it explicit and save the column of NULLs.

It makes sense to me to do both sew checks together, whether in amo_check or in
amo_op.

> +#define GEN_VEXT_AMO_NOATOMIC_OP(NAME, ETYPE, MTYPE, H, DO_OP, SUF)      \
> +static void vext_##NAME##_noatomic_op(void *vs3, target_ulong addr,      \
> +        uint32_t wd, uint32_t idx, CPURISCVState *env, uintptr_t retaddr)\
> +{                                                                        \
> +    ETYPE ret;                                                           \
> +    target_ulong tmp;                                                    \
> +    int mmu_idx = cpu_mmu_index(env, false);                             \
> +    tmp = cpu_ld##SUF##_mmuidx_ra(env, addr, mmu_idx, retaddr);          \
> +    ret = DO_OP((ETYPE)(MTYPE)tmp, *((ETYPE *)vs3 + H(idx)));            \
> +    cpu_st##SUF##_mmuidx_ra(env, addr, ret, mmu_idx, retaddr);           \
> +    if (wd) {                                                            \
> +        *((ETYPE *)vs3 + H(idx)) = (target_long)(MTYPE)tmp;              \

The target_long cast is wrong; should be ETYPE.

You can use cpu_ldX/stX_data (no mmu_idx or retaddr argument).  There should be
no faults, since you've already checked for read+write.

> +/* atomic opreation for vector atomic insructions */
> +#ifndef CONFIG_USER_ONLY
> +#define GEN_VEXT_ATOMIC_OP(NAME, ETYPE, MTYPE, MOFLAG, H, AMO)           \
> +static void vext_##NAME##_atomic_op(void *vs3, target_ulong addr,        \
> +        uint32_t wd, uint32_t idx, CPURISCVState *env)                   \
> +{                                                                        \
> +    target_ulong tmp;                                                    \
> +    int mem_idx = cpu_mmu_index(env, false);                             \
> +    tmp = helper_atomic_##AMO##_le(env, addr, *((ETYPE *)vs3 + H(idx)),  \
> +            make_memop_idx(MO_ALIGN | MOFLAG, mem_idx));                 \
> +    if (wd) {                                                            \
> +        *((ETYPE *)vs3 + H(idx)) = (target_long)(MTYPE)tmp;              \
> +    }                                                                    \
> +}
> +#else
> +#define GEN_VEXT_ATOMIC_OP(NAME, ETYPE, MTYPE, MOFLAG, H, AMO)           \
> +static void vext_##NAME##_atomic_op(void *vs3, target_ulong addr,        \
> +        uint32_t wd, uint32_t idx, CPURISCVState *env)                   \
> +{                                                                        \
> +    target_ulong tmp;                                                    \
> +    tmp = helper_atomic_##AMO##_le(env, addr, *((ETYPE *)vs3 + H(idx))); \
> +    if (wd) {                                                            \
> +        *((ETYPE *)vs3 + H(idx)) = (target_long)(MTYPE)tmp;              \
> +    }                                                                    \
> +}
> +#endif

This is not right.  It is not legal to call these helpers from another helper
-- they will use the wrong GETPC() and will not unwind properly.

> +static inline void vext_amo_atomic(void *vs3, void *v0, target_ulong base,
> +        void *vs2, CPURISCVState *env, uint32_t desc,
> +        vext_get_index_addr get_index_addr,
> +        vext_amo_atomic_fn atomic_op,
> +        vext_ld_clear_elem clear_elem,
> +        uint32_t esz, uint32_t msz, uintptr_t ra)
> +{
> +    uint32_t i;
> +    target_long addr;
> +    uint32_t wd = vext_wd(desc);
> +    uint32_t vm = vext_vm(desc);
> +    uint32_t mlen = vext_mlen(desc);
> +    uint32_t vlmax = vext_maxsz(desc) / esz;
> +
> +    for (i = 0; i < env->vl; i++) {
> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {
> +            continue;
> +        }
> +        probe_read_access(env, get_index_addr(base, i, vs2), msz, ra);
> +        probe_write_access(env, get_index_addr(base, i, vs2), msz, ra);
> +    }

You probably need to check for aligned address here too, probably first so an
unaligned fault has priority over an invalid page fault.

The missing aligned address check is the only remaining exception that the
helper_atomic_* functions would raise, since you have properly checked for
read+write.  So it might be possible to get away with using the helpers, but I
don't like it.

But I do think it would be better to write your own helpers for the atomic
paths.  They need not check quite so much, since we have already done the
validation above.  You pretty much only need to use tlb_vaddr_to_host.

If that gets too ugly, we can talk about rearranging
accel/tcg/atomic_template.h so that it could be reused.

Alternately, we could simply *always* use the non-atomic helpers, and raise
exit_atomic if PARALLEL.

> +static inline void vext_amo_noatomic(void *vs3, void *v0, target_ulong base,
> +        void *vs2, CPURISCVState *env, uint32_t desc,
> +        vext_get_index_addr get_index_addr,
> +        vext_amo_noatomic_fn noatomic_op,
> +        vext_ld_clear_elem clear_elem,
> +        uint32_t esz, uint32_t msz, uintptr_t ra)

Without the retaddr argument to the noatomic_fn, as described above,
vext_amo_noatomic and vext_amo_atomic are identical.


r~
