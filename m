Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D3E6E7C63
	for <lists+linux-csky@lfdr.de>; Wed, 19 Apr 2023 16:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjDSOXR (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 19 Apr 2023 10:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjDSOXG (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 19 Apr 2023 10:23:06 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C955B445
        for <linux-csky@vger.kernel.org>; Wed, 19 Apr 2023 07:22:52 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63d2ba63dddso1793926b3a.2
        for <linux-csky@vger.kernel.org>; Wed, 19 Apr 2023 07:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1681914172; x=1684506172;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IvT99d3vu2s9u2HdXHuOsCskK0/5VChFq+aBcaoQwKM=;
        b=eJ51Lyhme8n3XB+0k6fcBFov9PY8/EUmTR8+nuSaGr7xBsijqIoLjwhsLzVxYH/nx0
         wauVowtfzqnaLMg0Md06tjLXI3lWkSGzsXedNOsMpQwkDCNvEtBTyQ19M/Yyo6D06BSV
         XNjXn0CGdLZl3nFWqDjNax+yB6CXLq01SwKNwyDS36uGnLYxQFXzNQuK/+7hScqPlZwX
         z+agJw/VCIGMUixwVDzm2XMnLSn8GR3DsnMXY+jrQCfbr9O1Le1uXDKTi2rYkt7oJ2Ce
         tyNNGrxSj0L54sdbIeiSTDtndMc3YiWnjyxMJLeRw/TsNRHsyFeDM9KNzzDNKUVPs4Et
         pKOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681914172; x=1684506172;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvT99d3vu2s9u2HdXHuOsCskK0/5VChFq+aBcaoQwKM=;
        b=jkZwdPStXNvRNmtE/6cS51Z9pWDY+gZOGeGxIMkliPxACPY0JM0wAvYgyxahHUR7tc
         HlDXWAJGjFR/NgdODjrGvsOUoZ0rfldOixKh/Vl5jaJi9gf08n9l3V6AQw08OkPeDdUr
         +eNtcyQ8d1hTr3Iodd1syb/ZMkX/nwdDN2TUbFflb0IBU5lw7+K866ua2rnlSsMxb6tQ
         OP6fI0S70hsL72013aG64T4DJar9MgANbXbwjFV6w7I/Ve4r5h0kxf/zYV1sfp2cCO02
         KGsTObeEeoZkZByyZXKWewK5t7zvpEfoST4MWqzZt6HcAcKUzsjBqyUPRVPYKuRyMtLc
         l8rA==
X-Gm-Message-State: AAQBX9fcwS2qhXJqW3NON7VQPf5T9tmi1NzGiow4Ihxirib2dx5xQunR
        mxpyB2rv2uVYczbLkR5t8s169w==
X-Google-Smtp-Source: AKy350YgrN7zbaEKFT5DU1qrct74Wsi9a0WokbCy4dVCW0VXg9H7v3lPwT87yJxbljWHRWpRpF5B0Q==
X-Received: by 2002:a05:6a00:130a:b0:63b:859f:f094 with SMTP id j10-20020a056a00130a00b0063b859ff094mr4002975pfu.20.1681914171995;
        Wed, 19 Apr 2023 07:22:51 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id d2-20020a63d642000000b005140ce70582sm10431557pgj.44.2023.04.19.07.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 07:22:51 -0700 (PDT)
Date:   Wed, 19 Apr 2023 07:22:51 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Apr 2023 07:22:44 PDT (-0700)
Subject:     Re: [PATCH 09/21] riscv: dma-mapping: skip invalidation before bidirectional DMA
In-Reply-To: <20230327121317.4081816-10-arnd@kernel.org>
CC:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        vgupta@kernel.org, linux@armlinux.org.uk,
        neil.armstrong@linaro.org, linus.walleij@linaro.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, guoren@kernel.org,
        bcain@quicinc.com, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, dinguyen@kernel.org, shorne@gmail.com,
        deller@gmx.de, mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        Paul Walmsley <paul.walmsley@sifive.com>, dalias@libc.org,
        glaubitz@physik.fu-berlin.de, davem@davemloft.net,
        jcmvbkbc@gmail.com, Christoph Hellwig <hch@lst.de>,
        robin.murphy@arm.com, prabhakar.mahadev-lad.rj@bp.renesas.com,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     arnd@kernel.org
Message-ID: <mhng-7529cf5a-4397-456f-b610-faa619d4faca@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Mon, 27 Mar 2023 05:13:05 PDT (-0700), arnd@kernel.org wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>
> For a DMA_BIDIRECTIONAL transfer, the caches have to be cleaned
> first to let the device see data written by the CPU, and invalidated
> after the transfer to let the CPU see data written by the device.
>
> riscv also invalidates the caches before the transfer, which does
> not appear to serve any purpose.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/riscv/mm/dma-noncoherent.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/dma-noncoherent.c b/arch/riscv/mm/dma-noncoherent.c
> index 640f4c496d26..69c80b2155a1 100644
> --- a/arch/riscv/mm/dma-noncoherent.c
> +++ b/arch/riscv/mm/dma-noncoherent.c
> @@ -25,7 +25,7 @@ void arch_sync_dma_for_device(phys_addr_t paddr, size_t size,
>  		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>  		break;
>  	case DMA_BIDIRECTIONAL:
> -		ALT_CMO_OP(flush, vaddr, size, riscv_cbom_block_size);
> +		ALT_CMO_OP(clean, vaddr, size, riscv_cbom_block_size);
>  		break;
>  	default:
>  		break;

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
