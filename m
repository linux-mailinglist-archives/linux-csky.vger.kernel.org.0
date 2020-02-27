Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE3D172871
	for <lists+linux-csky@lfdr.de>; Thu, 27 Feb 2020 20:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729545AbgB0TRp (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 27 Feb 2020 14:17:45 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:38883 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729418AbgB0TRp (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 27 Feb 2020 14:17:45 -0500
Received: by mail-pl1-f194.google.com with SMTP id p7so188983pli.5
        for <linux-csky@vger.kernel.org>; Thu, 27 Feb 2020 11:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rkZ3dNlnom8394SX7fXjtihYKPXDxrUBwwgevdf0LLw=;
        b=vu5DrgXjdJxGo1+Q4Lq67uO6mE8thJqVTz9+hxl0L+PTYGwlvOCFGXWcd95UVCw4HB
         CeMfgDAYkwAzDHbmmAPJY8qrNKRemY3oluOnUzS5Xp/0DoSSvWc2b8zhamXyAEoLzqJm
         oaKatgqvySc0Vk2US6jkm8keIg+T/mI5SSKH9tdNAAAO/qY3BKB/twVVJpIltpayh0oi
         a5GpKUQLCB7sApUGgffk75UnIGHSCJTpB4u1b0/Yvv9lyZ1/6WhzIwAdbaFn6ucrpNZx
         USPXF9+gSfE6YO835gya8Gt37M1FdFWMuGMxl1/62BWBjdKIeEGCUvi+S8n/lP8BB1F6
         mkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rkZ3dNlnom8394SX7fXjtihYKPXDxrUBwwgevdf0LLw=;
        b=Z0BGn2rpqOX1b+daMGPetnKQesSKILjQrZZ3beOJO7tbBy7e66Xlcd33jRsD9q98Ns
         2wsYzb2DkpcuRh0vs1ah8az7n3xLop6D1D8ee3kLOObh+63RbMtPQO27atImcwy2aKF7
         15Ur4gmMpePfAGU0M1IXt8j9wDDo4XNrWkhCSZcWEUXgeNgFnU73mz4p8YChBeW4YzaK
         jVPtAuANnCBcXL0YNixtmdg8bLg9axHqQJrgZRzZBDTYf+THpmL2Bpp7n6kPMS7HHcTW
         4h1CiXz4cJThEza+3w9+R2RbOPwseTjgI44PE+wLd10icwMis+b3pibQiIecGz6b/axI
         5UVw==
X-Gm-Message-State: APjAAAVJRXAJN/C6vSL4UnQ+8F7ieZB9GkIv5qVWpE4ti7m9FojL8xHH
        8A4Xkgu5AJFC8ck32ww4MxRvHbkgNGw=
X-Google-Smtp-Source: APXvYqyv6vN8hBGWJ3ssD3m9+mn61b+lNdySW+MEc+9+iXhOL2IrvswEl8N/JbqtGHTz0ueUWXlVVQ==
X-Received: by 2002:a17:90a:8806:: with SMTP id s6mr414229pjn.141.1582831062693;
        Thu, 27 Feb 2020 11:17:42 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
        by smtp.gmail.com with ESMTPSA id k4sm7899602pfg.40.2020.02.27.11.17.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 11:17:41 -0800 (PST)
Subject: Re: [PATCH v4 1/5] target/riscv: add vector unit stride load and
 store instructions
To:     LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
        chihmin.chao@sifive.com, palmer@dabbelt.com
Cc:     wenmeng_zhang@c-sky.com, wxy194768@alibaba-inc.com,
        linux-csky@vger.kernel.org, qemu-devel@nongnu.org,
        qemu-riscv@nongnu.org
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-2-zhiwei_liu@c-sky.com>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4cfb56d6-34a5-0e35-87a0-2aefaafa4221@linaro.org>
Date:   Thu, 27 Feb 2020 11:17:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200225103508.7651-2-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 2/25/20 2:35 AM, LIU Zhiwei wrote:
> +static bool vext_check_reg(DisasContext *s, uint32_t reg, bool widen)
> +{
> +    int legal = widen ? 2 << s->lmul : 1 << s->lmul;
> +
> +    return !((s->lmul == 0x3 && widen) || (reg % legal));
> +}
> +
> +static bool vext_check_overlap_mask(DisasContext *s, uint32_t vd, bool vm)
> +{
> +    return !(s->lmul > 1 && vm == 0 && vd == 0);
> +}
> +
> +static bool vext_check_nf(DisasContext *s, uint32_t nf)
> +{
> +    return s->lmul * (nf + 1) <= 8;
> +}

Some commentary would be good here, quoting the rule being applied.  E.g. "The
destination vector register group for a masked vector instruction can only
overlap the source mask regis-
ter (v0) when LMUL=1. (Section 5.3)"

> +static bool ld_us_op(DisasContext *s, arg_r2nfvm *a, uint8_t seq)
> +{
> +    uint8_t nf = a->nf + 1;

Perhaps NF should have the +1 done during decode, so that it cannot be
forgotten here or elsewhere.  E.g.

%nf      31:3  !function=ex_plus_1
@r2_nfvm ... ... vm:1 ..... ..... ... ..... ....... \
         &r2nfvm %nf %rs1 %rd

Where ex_plus_1 is the obvious modification of ex_shift_1().

> +static inline uint32_t vext_nf(uint32_t desc)
> +{
> +    return (simd_data(desc) >> 11) & 0xf;
> +}
> +
> +static inline uint32_t vext_mlen(uint32_t desc)
> +{
> +    return simd_data(desc) & 0xff;
> +}
> +
> +static inline uint32_t vext_vm(uint32_t desc)
> +{
> +    return (simd_data(desc) >> 8) & 0x1;
> +}
> +
> +static inline uint32_t vext_lmul(uint32_t desc)
> +{
> +    return (simd_data(desc) >> 9) & 0x3;
> +}

You should use FIELD() to define the fields, and then use FIELD_EX32 and
FIELD_DP32 to reference them.

> +/*
> + * This function checks watchpoint before real load operation.
> + *
> + * In softmmu mode, the TLB API probe_access is enough for watchpoint check.
> + * In user mode, there is no watchpoint support now.
> + *
> + * It will triggle an exception if there is no mapping in TLB

trigger.

> + * and page table walk can't fill the TLB entry. Then the guest
> + * software can return here after process the exception or never return.
> + */
> +static void probe_read_access(CPURISCVState *env, target_ulong addr,
> +        target_ulong len, uintptr_t ra)
> +{
> +    while (len) {
> +        const target_ulong pagelen = -(addr | TARGET_PAGE_MASK);
> +        const target_ulong curlen = MIN(pagelen, len);
> +
> +        probe_read(env, addr, curlen, cpu_mmu_index(env, false), ra);
> +        addr += curlen;
> +        len -= curlen;
> +    }
> +}
> +
> +static void probe_write_access(CPURISCVState *env, target_ulong addr,
> +        target_ulong len, uintptr_t ra)
> +{
> +    while (len) {
> +        const target_ulong pagelen = -(addr | TARGET_PAGE_MASK);
> +        const target_ulong curlen = MIN(pagelen, len);
> +
> +        probe_write(env, addr, curlen, cpu_mmu_index(env, false), ra);
> +        addr += curlen;
> +        len -= curlen;
> +    }
> +}

A loop is overkill -- the access cannot span to 3 pages.  These two functions
can be merged using probe_access and MMU_DATA_{LOAD,STORE}.

> +
> +#ifdef HOST_WORDS_BIGENDIAN
> +static void vext_clear(void *tail, uint32_t cnt, uint32_t tot)
> +{
> +    /*
> +     * Split the remaining range to two parts.
> +     * The first part is in the last uint64_t unit.
> +     * The second part start from the next uint64_t unit.
> +     */
> +    int part1 = 0, part2 = tot - cnt;
> +    if (cnt % 64) {
> +        part1 = 64 - (cnt % 64);
> +        part2 = tot - cnt - part1;
> +        memset(tail & ~(63ULL), 0, part1);
> +        memset((tail + 64) & ~(63ULL), 0, part2);

You're confusing bit and byte offsets -- cnt and tot are both byte offsets.

> +static inline int vext_elem_mask(void *v0, int mlen, int index)
> +{
> +
> +    int idx = (index * mlen) / 8;
> +    int pos = (index * mlen) % 8;
> +
> +    switch (mlen) {
> +    case 8:
> +        return *((uint8_t *)v0 + H1(index)) & 0x1;
> +    case 16:
> +        return *((uint16_t *)v0 + H2(index)) & 0x1;
> +    case 32:
> +        return *((uint32_t *)v0 + H4(index)) & 0x1;
> +    case 64:
> +        return *((uint64_t *)v0 + index) & 0x1;
> +    default:
> +        return (*((uint8_t *)v0 + H1(idx)) >> pos) & 0x1;
> +    }

This is not what I had in mind, and looks wrong as well.

    int idx = (index * mlen) / 64;
    int pos = (index * mlen) % 64;
    return (((uint64_t *)v0)[idx] >> pos) & 1;

You also might consider passing log2(mlen), so the multiplication could be
strength-reduced to a shift.

> +#define GEN_VEXT_LD_ELEM(NAME, MTYPE, ETYPE, H, LDSUF)              \
> +static void vext_##NAME##_ld_elem(CPURISCVState *env, abi_ptr addr, \
> +        uint32_t idx, void *vd, uintptr_t retaddr)                  \
> +{                                                                   \
> +    int mmu_idx = cpu_mmu_index(env, false);                        \
> +    MTYPE data;                                                     \
> +    ETYPE *cur = ((ETYPE *)vd + H(idx));                            \
> +    data = cpu_##LDSUF##_mmuidx_ra(env, addr, mmu_idx, retaddr);    \
> +    *cur = data;                                                    \
> +}                                                                   \

If you're going to use cpu_mmu_index, you might as well use cpu_SUFF_data_ra(),
which does not require the mmu_idx parameter.

> +#define GEN_VEXT_ST_ELEM(NAME, ETYPE, H, STSUF)                       \
> +static void vext_##NAME##_st_elem(CPURISCVState *env, abi_ptr addr,   \
> +        uint32_t idx, void *vd, uintptr_t retaddr)                    \
> +{                                                                     \
> +    int mmu_idx = cpu_mmu_index(env, false);                          \
> +    ETYPE data = *((ETYPE *)vd + H(idx));                             \
> +    cpu_##STSUF##_mmuidx_ra(env, addr, data, mmu_idx, retaddr);       \
> +}

Likewise.

> +/*
> + *** unit-stride: load vector element from continuous guest memory
> + */
> +static inline void vext_ld_us_mask(void *vd, void *v0, target_ulong base,
> +        CPURISCVState *env, uint32_t desc,
> +        vext_ld_elem_fn ld_elem,
> +        vext_ld_clear_elem clear_elem,
> +        uint32_t esz, uint32_t msz, uintptr_t ra)
> +{
> +    uint32_t i, k;
> +    uint32_t mlen = vext_mlen(desc);

You don't need to pass mlen, since it's

> +/* unit-stride: store vector element to guest memory */
> +static void vext_st_us_mask(void *vd, void *v0, target_ulong base,
> +        CPURISCVState *env, uint32_t desc,
> +        vext_st_elem_fn st_elem,
> +        uint32_t esz, uint32_t msz, uintptr_t ra)
> +{
> +    uint32_t i, k;
> +    uint32_t nf = vext_nf(desc);
> +    uint32_t mlen = vext_mlen(desc);
> +    uint32_t vlmax = vext_maxsz(desc) / esz;
> +
> +    /* probe every access*/
> +    for (i = 0; i < env->vl; i++) {
> +        if (!vext_elem_mask(v0, mlen, i)) {
> +            continue;
> +        }
> +        probe_write_access(env, base + nf * i * msz, nf * msz, ra);
> +    }
> +    /* store bytes to guest memory */
> +    for (i = 0; i < env->vl; i++) {
> +        k = 0;
> +        if (!vext_elem_mask(v0, mlen, i)) {
> +            continue;
> +        }
> +        while (k < nf) {
> +            target_ulong addr = base + (i * nf + k) * msz;
> +            st_elem(env, addr, i + k * vlmax, vd, ra);
> +            k++;
> +        }
> +    }
> +}

I'll note that vext_ld_us_mask and vext_st_us_mask are identical, except for:

1) probe_read/write_access (which I already suggested merging, using
MMUAccessType),

2) the name of the ld_elem/st_elem variable (the function types are already
identical), and

3) the clear loop at the end of the load (which could be conditional on
clear_elem != NULL; after inlining, this should be optimized away).

> +static void vext_st_us(void *vd, target_ulong base,
> +        CPURISCVState *env, uint32_t desc,
> +        vext_st_elem_fn st_elem,
> +        uint32_t esz, uint32_t msz, uintptr_t ra)

Similarly.


r~
