Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E1B4E1D4E
	for <lists+linux-csky@lfdr.de>; Sun, 20 Mar 2022 19:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbiCTSGm (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sun, 20 Mar 2022 14:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbiCTSGm (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sun, 20 Mar 2022 14:06:42 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6703CA46
        for <linux-csky@vger.kernel.org>; Sun, 20 Mar 2022 11:05:18 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d18so10942548plr.6
        for <linux-csky@vger.kernel.org>; Sun, 20 Mar 2022 11:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=W8wVV9vzvtZCSSPiAIhvOJYVojouvBvjOyuSiPQ7Orc=;
        b=BuisuQ8zdGEGElEJtLnEk71SamOFCHUHk+7Ws5ru+OHTRth66xjBGh0enkv7Of5kLu
         L6rKry91Ihzlj0uxyXjxLXb++DDhR1O8oNaCoVhMnO+Dvupl7sEy40n0EGOFWHdmhpd+
         8PqykppNi4Z6/mCgFVoUWj2oRG0ob7S1r4pNaL5OuEvmcoKWJtanxtJGkMC2ybIjybAf
         33UNziLBePEX6dwCBcBAhtjGYSPdBQFv+C0si9BVAMbxVlHZrXhP5L5pFaq8F+l/NwVx
         HZTmffxPCek82nQ94DyPjoysNPkmeYvmMTyS/A7HAeBdBojvWy3rEjD2CQOZhfR53D2y
         sgaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=W8wVV9vzvtZCSSPiAIhvOJYVojouvBvjOyuSiPQ7Orc=;
        b=q5AOMB8mCBC+PZJOfot11fQy4QPRrC7fZaneNHCIpfViJJ3MFWL2xKRYUiIaFwlkaT
         o8OUL3UP3PZ4ycZH4G857uCXRIcS+Ti/xazCoBhy9jijvRE42NMiIp6HU28CQLJzWRYl
         VWCL1u0USIEQmyk29ZMgn/98wX46SaRNMcXGiRjQdx7u0VahBVKOwVI26BKS3T6H1dR7
         +Tzz+f1pp6TTzdN7ZYAkjasl1hnkjdQQ7Dlwj8DlEZtZrTdSXe2zK6quLjbUpf+hSOB4
         BFhMDXLBgbw1IGmXhGB3AHEnARRece1JQpBWnqpoMQ2vpeC9Npg/jUYZOl926n5P1KLJ
         TDPw==
X-Gm-Message-State: AOAM532v25ZNLRY3NfU4aNvrmQZyX11k+NllqOEahTWTXncavLOV09Zx
        6flBGTuXlL8vq2awzvo4SWDZRw==
X-Google-Smtp-Source: ABdhPJyIXO8JsaI8FTrIRSaST77QU9EDA/NG1bQPqJX2QUGXuKXs3BzVWFYzx9mKyEttwTJPa1HxLQ==
X-Received: by 2002:a17:902:d48d:b0:153:a517:6ff2 with SMTP id c13-20020a170902d48d00b00153a5176ff2mr9360763plg.141.1647799517730;
        Sun, 20 Mar 2022 11:05:17 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s25-20020a056a00179900b004f737ce5c1asm16245907pfg.73.2022.03.20.11.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 11:05:17 -0700 (PDT)
Date:   Sun, 20 Mar 2022 11:05:17 -0700 (PDT)
X-Google-Original-Date: Sun, 20 Mar 2022 11:05:07 PDT (-0700)
Subject:     Re: [PATCH V2] arch: patch_text: Fixup last cpu should be master
In-Reply-To: <20220313012221.1755483-1-guoren@kernel.org>
CC:     guoren@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        guoren@linux.alibaba.com, jcmvbkbc@gmail.com,
        Will Deacon <will@kernel.org>, catalin.marinas@arm.com,
        mhiramat@kernel.org, chris@zankel.net,
        Arnd Bergmann <arnd@arndb.de>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     guoren@kernel.org
Message-ID: <mhng-b034f45a-521b-4c80-a314-4ddf1a1dc534@palmer-mbp2014>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sat, 12 Mar 2022 17:22:21 PST (-0800), guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>
> These patch_text implementations are using stop_machine_cpuslocked
> infrastructure with atomic cpu_count. The original idea: When the
> master CPU patch_text, the others should wait for it. But current
> implementation is using the first CPU as master, which couldn't
> guarantee the remaining CPUs are waiting. This patch changes the
> last CPU as the master to solve the potential risk.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Peter Zijlstra <peterz@infradead.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Arnd Bergmann <arnd@arndb.de>
>
> ---
> Changes in V2:
>  - Fixup last cpu should be num_online_cpus() by Max Filippov
>  - Fixup typos found by Max Filippov
> ---
>  arch/arm64/kernel/patching.c      | 4 ++--
>  arch/csky/kernel/probes/kprobes.c | 2 +-
>  arch/riscv/kernel/patch.c         | 2 +-
>  arch/xtensa/kernel/jump_label.c   | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patching.c
> index 771f543464e0..33e0fabc0b79 100644
> --- a/arch/arm64/kernel/patching.c
> +++ b/arch/arm64/kernel/patching.c
> @@ -117,8 +117,8 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
>  	int i, ret = 0;
>  	struct aarch64_insn_patch *pp = arg;
>
> -	/* The first CPU becomes master */
> -	if (atomic_inc_return(&pp->cpu_count) == 1) {
> +	/* The last CPU becomes master */
> +	if (atomic_inc_return(&pp->cpu_count) == num_online_cpus()) {
>  		for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
>  			ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
>  							     pp->new_insns[i]);
> diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
> index 42920f25e73c..34ba684d5962 100644
> --- a/arch/csky/kernel/probes/kprobes.c
> +++ b/arch/csky/kernel/probes/kprobes.c
> @@ -30,7 +30,7 @@ static int __kprobes patch_text_cb(void *priv)
>  	struct csky_insn_patch *param = priv;
>  	unsigned int addr = (unsigned int)param->addr;
>
> -	if (atomic_inc_return(&param->cpu_count) == 1) {
> +	if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
>  		*(u16 *) addr = cpu_to_le16(param->opcode);
>  		dcache_wb_range(addr, addr + 2);
>  		atomic_inc(&param->cpu_count);
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 0b552873a577..765004b60513 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -104,7 +104,7 @@ static int patch_text_cb(void *data)
>  	struct patch_insn *patch = data;
>  	int ret = 0;
>
> -	if (atomic_inc_return(&patch->cpu_count) == 1) {
> +	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
>  		ret =
>  		    patch_text_nosync(patch->addr, &patch->insn,
>  					    GET_INSN_LENGTH(patch->insn));

Acked-by: Palmer Dabbelt <palmer@rivosinc.com> # RISC-V

It's better if these sorts of things get split up: there's really no 
dependency between these diffs and having them together just makes for a 
merge/test headache for everyone.

I'm OK taking this through the RISC-V tree if other folks ack it, but 
for now I'm going to assume it's going to go in via somewhere else.

> diff --git a/arch/xtensa/kernel/jump_label.c b/arch/xtensa/kernel/jump_label.c
> index 61cf6497a646..b67efcd7e32c 100644
> --- a/arch/xtensa/kernel/jump_label.c
> +++ b/arch/xtensa/kernel/jump_label.c
> @@ -40,7 +40,7 @@ static int patch_text_stop_machine(void *data)
>  {
>  	struct patch *patch = data;
>
> -	if (atomic_inc_return(&patch->cpu_count) == 1) {
> +	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
>  		local_patch_text(patch->addr, patch->data, patch->sz);
>  		atomic_inc(&patch->cpu_count);
>  	} else {
