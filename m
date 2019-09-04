Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60EF6A9518
	for <lists+linux-csky@lfdr.de>; Wed,  4 Sep 2019 23:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbfIDVZA (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 4 Sep 2019 17:25:00 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43101 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729594AbfIDVY7 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 4 Sep 2019 17:24:59 -0400
Received: by mail-io1-f68.google.com with SMTP id u185so43860719iod.10
        for <linux-csky@vger.kernel.org>; Wed, 04 Sep 2019 14:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gpnxUOC87Hy/bQFTjChPoPUmVY9m9l5TllB0pP0NeVk=;
        b=fTLS4AC5Y3ATB96yfTaa7NNHIOTrZhvDflTG9Orv7lWVtnUCwEpcmP20IMPHHfbAo4
         8IZUu4m/TmyBzD4IkRERocaj62+YgKlCnp0UnS9rfQgWahlhEFwbtw+h7L7OoNv6+ap+
         RJudWwoFvJWcbxdoKoVd/Td0s4qFhYYQFo5RvC7qc4TKPMc3MftX/S71qdKw2PGFipAO
         nIux+yq5b0aZNpSAGSZID8kbRRvqRopQ2NLanjEh0XZx17D9feHuYXCD+G3JbySlMwSq
         wlTIM/KfezSMBzPmjTFMtfGCmlA465gjVqqLLGaudRkH6Z3C1ADjcKPc1Em1eTAFMHrl
         oBYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gpnxUOC87Hy/bQFTjChPoPUmVY9m9l5TllB0pP0NeVk=;
        b=BFoJgU8M1FL7CwFeuOooBS8+IB8+V+7XOjfh+y89PXnbXshUZaOiZW/eAt5dh9le3a
         1WWabLsoVLyfhXUgbvsB/GVf5I5FxuaLijBy22BVJSZn4/S2d80+vZcxQZbBEB+fNA3b
         MPR/lkFPmsArbK5FU+jLdx6M8PSVZsrm7/EGpLdVFU8lStk4qQWpL/t1lkgG0buDf//A
         0Et09FYH8IPyj2OoR9if8MW1Qlkmuf4bV2wSovVwGQKjRUG/Yzq9BIibJMLvDNkwfN3f
         8k9ghQoDz9pNT7j9yC0gQpDWrkJiuYVfoBtFZDF/DG/zmqVR2nVgof+VIZerZEMRTzYd
         /Esg==
X-Gm-Message-State: APjAAAU9KoTppXpQfz0jzJ8d+fFNMJcmE/g4AHBYdGOHz0Ovlqdr81UR
        wKHo55fmt7G/WGHokG+LXB7NXw==
X-Google-Smtp-Source: APXvYqxjjM03c8YncfiKMgSDvfLe10vnXrh6O5z7tHl/a/2REfqzPMyznieZD1T0RCpHILA7wU/D0g==
X-Received: by 2002:a02:cad1:: with SMTP id f17mr333310jap.18.1567632299044;
        Wed, 04 Sep 2019 14:24:59 -0700 (PDT)
Received: from localhost (75-161-11-128.albq.qwest.net. [75.161.11.128])
        by smtp.gmail.com with ESMTPSA id r2sm66211ioh.61.2019.09.04.14.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:24:58 -0700 (PDT)
Date:   Wed, 4 Sep 2019 14:24:57 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Mao Han <han_mao@c-sky.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Greentime Hu <green.hu@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH V6 3/3] riscv: Add support for libdw
In-Reply-To: <4cba2dfb6b1ef0df01185c6bce78a0a2867d0a7d.1567060834.git.han_mao@c-sky.com>
Message-ID: <alpine.DEB.2.21.9999.1909041422220.13502@viisi.sifive.com>
References: <cover.1567060834.git.han_mao@c-sky.com> <4cba2dfb6b1ef0df01185c6bce78a0a2867d0a7d.1567060834.git.han_mao@c-sky.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Hello Mao Han,

On Thu, 29 Aug 2019, Mao Han wrote:

> This patch add support for DWARF register mappings and libdw registers
> initialization, which is used by perf callchain analyzing when
> --call-graph=dwarf is given.

> diff --git a/tools/arch/riscv/include/uapi/asm/perf_regs.h b/tools/arch/riscv/include/uapi/asm/perf_regs.h
> new file mode 100644
> index 0000000..df1a581
> --- /dev/null
> +++ b/tools/arch/riscv/include/uapi/asm/perf_regs.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

As with 

https://lore.kernel.org/linux-riscv/CAJF2gTRXH_bx0rwsTZMTnX+umZfVTL_iVnewPtVM50sLaqJPTg@mail.gmail.com/T/#t

is it possible to change this license string to "GPL-2.0 WITH 
Linux-syscall-note" to match the other Linux architectures? 


- Paul
