Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C82BA94DE
	for <lists+linux-csky@lfdr.de>; Wed,  4 Sep 2019 23:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbfIDVWU (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 4 Sep 2019 17:22:20 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45581 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728717AbfIDVWU (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 4 Sep 2019 17:22:20 -0400
Received: by mail-io1-f65.google.com with SMTP id f12so30189460iog.12
        for <linux-csky@vger.kernel.org>; Wed, 04 Sep 2019 14:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Nm692qk4LNmOHZMyj1jVHOcSSuFyCUnTdIF+X/Nubik=;
        b=C2B2dNYdSzXJxH9VlS6QeY936qliwaicI+yJm/i6LNpGDvf1jocEMbplE0QRaj8Gds
         Se1YBeenhuMe0CwSs5mRe41ywWpNYB/rAsRcPFh8q3C1YzKTOqqHk5+CLSG0De9gxYCd
         +IPILNkX8Tvli3QVTjOmjP87J1mQHRgWavjMSOn1Yu370HPoPgbWAG3qYd0+dk46TKDU
         +gtWzTEs3wLDGQloXGmVWAIj/TIA5MZXjpSVUY28J/OnDCBlWE8k5w0u+zktLkMZu+qS
         VomIe0Nsy5aT+79e9B1fx4NtX4bopyBv/MGZ+p7ZVZMdPieM7rwOUW1vVHPhP5aluLZ7
         74dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Nm692qk4LNmOHZMyj1jVHOcSSuFyCUnTdIF+X/Nubik=;
        b=dq9rty15b5YVtTMcSWC+SatNOnwCBuhruPJ2Ob+wv3OpTqSqMrKtXEn+epmpO7rvVK
         GTMQepA54gauxFxPQCrZGC5dKiYmLEYSSRnxWzuSqPScWXzbnnIiUh3wfMqI6ntAyPrF
         PzHwhcZ4xlvQ4b9KbH14PUvpor84+AgU1LWRvk9570TKrLPGKGJ+5eZHw219+fuUN1Zd
         ia0DXB3f2A+VP0EgEKKHF9kTZtK3h2eyUOFxN0ufHJVhOCWB9U2FivFPqJSv6nRKqPx7
         eQ5kSzQIGDziUENxsHrxM30Yc9hO4Yjgrc9KPxE9U9lGX1L7jScPfgDSgNCyyveDz3yi
         G6UA==
X-Gm-Message-State: APjAAAXwu2zWEdro/uYEdUF5o9LE47p8o6Xaz8f68B3uj+B8vL+2iEl4
        zgKRLwsnS4YJLpIlNR3lxrv0Zg==
X-Google-Smtp-Source: APXvYqx3kV34KAQ1WdbjpS3AwyBLMr0HwcwCXpIRa03VFOZwIm8yjheyzlOGwLq5YOPzaFPXtHoFRQ==
X-Received: by 2002:a6b:bc47:: with SMTP id m68mr102783iof.70.1567632139657;
        Wed, 04 Sep 2019 14:22:19 -0700 (PDT)
Received: from localhost (75-161-11-128.albq.qwest.net. [75.161.11.128])
        by smtp.gmail.com with ESMTPSA id m25sm109477iol.12.2019.09.04.14.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 14:22:19 -0700 (PDT)
Date:   Wed, 4 Sep 2019 14:22:18 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Mao Han <han_mao@c-sky.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Greentime Hu <green.hu@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH V6 2/3] riscv: Add support for perf registers sampling
In-Reply-To: <0179424c5edc166273d5fe261f70b1a4c13a90f8.1567060834.git.han_mao@c-sky.com>
Message-ID: <alpine.DEB.2.21.9999.1909041420270.13502@viisi.sifive.com>
References: <cover.1567060834.git.han_mao@c-sky.com> <0179424c5edc166273d5fe261f70b1a4c13a90f8.1567060834.git.han_mao@c-sky.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Hello Mao Han,

On Thu, 29 Aug 2019, Mao Han wrote:

> This patch implements the perf registers sampling and validation API
> for riscv arch. The valid registers and their register ID are defined in
> perf_regs.h. Perf tool can backtrace in userspace with unwind library
> and the registers/user stack dump support.

[ ... ]

> diff --git a/arch/riscv/include/uapi/asm/perf_regs.h b/arch/riscv/include/uapi/asm/perf_regs.h
> new file mode 100644
> index 0000000..df1a581
> --- /dev/null
> +++ b/arch/riscv/include/uapi/asm/perf_regs.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

All of the other Linux architectures use "GPL-2.0 WITH Linux-syscall-note" 
for their license for the perf uapi files.  Could you please change this 
license string to match the standard Linux practice?  Then I think it 
should be good to merge.


- Paul
