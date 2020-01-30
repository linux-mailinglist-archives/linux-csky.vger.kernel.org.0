Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970C914E018
	for <lists+linux-csky@lfdr.de>; Thu, 30 Jan 2020 18:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbgA3Rky (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 30 Jan 2020 12:40:54 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33086 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727376AbgA3Rky (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 30 Jan 2020 12:40:54 -0500
Received: by mail-wr1-f67.google.com with SMTP id b6so5225707wrq.0
        for <linux-csky@vger.kernel.org>; Thu, 30 Jan 2020 09:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:subject:cc:to:in-reply-to:references:message-id
         :mime-version:content-transfer-encoding;
        bh=sjSjgSgyTuvEGGpGcPzOuN43I5rGzkVNCSsBJ7pjoBk=;
        b=aFEgL1GeQFgxI2GOdOIYGasbJZ+aAJDZeFJF8GdYgdQlJra16qDC0lbJ5XngfCwcby
         yyGFa5z+2fWNz7oebHjghlXQc7HBnBh/XSobupARvdfuzntNc3QtYg/Efx13CGP4YN9A
         +YKjfVlAho6jZM81z9BptEs1U8iz7NccZvejXU1JQyo1ebqc4A1xbz+yMsBiDRZJSHif
         vkVclm1Hvq1kwX5LLcVJ2nI5HW+mCYtjmboWQNBnvnBGP5sGGhv1nNX58jBGEHhQoihv
         VxuiERz6Etf4cCO8bSJGmdAo+lcT6BoNlSU5u+Y00DBA+zZ8Gqzttj7gpPgenv9unfRN
         Ihlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
         :message-id:mime-version:content-transfer-encoding;
        bh=sjSjgSgyTuvEGGpGcPzOuN43I5rGzkVNCSsBJ7pjoBk=;
        b=XxHxntSvDkkD/yt7QL6MK5Yk2GPc2dZfnqg8vs8n6f+NQFAu+gRknD7DriUs50IwNW
         QDBy/abtNZUExVLwwsiAnwy5btbIadgE8KFf4PHurhYeHBE9Nj7qfaEHqCX7uyf0wZiy
         7LC7N+XhaF32lYUCaU3arsywels1MJ9fASaysuLdoCLJsP2wg8XzsMxdI3AYHdwApiPl
         r6tRctf0BJu9/oUoZmLviThBlah5p+hIijjM+UrFT6rzOmCEMs6/Ql1T8u63EfoFTGCd
         DK4jccy5IL/RQR0ef7DDkDux+Ml0lnCZV5sXZZcQuY68tLjBJVHVYqrhVDG9xxTCwBP1
         n/Jw==
X-Gm-Message-State: APjAAAX5t+7DLTEC4VJ/hUE5XR9F7x5DXkhM8525RzqVCsULhlsZUVDs
        6RxehfJVgO/ccffNC/iYpPQoUQ==
X-Google-Smtp-Source: APXvYqwcuu7W4dXgdugwyB3ewpuGVbCs/ylVmGHTA820ZR8jxpC05U2oaVk2DPBJt+IWjaMyIUgdfA==
X-Received: by 2002:a5d:620b:: with SMTP id y11mr6709330wru.230.1580406052028;
        Thu, 30 Jan 2020 09:40:52 -0800 (PST)
Received: from localhost ([2a00:79e0:d:11:1da2:3fd4:a302:4fff])
        by smtp.gmail.com with ESMTPSA id a1sm8143501wrr.80.2020.01.30.09.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 09:40:51 -0800 (PST)
Date:   Thu, 30 Jan 2020 09:40:51 -0800 (PST)
X-Google-Original-Date: Thu, 30 Jan 2020 17:40:46 GMT (+0000)
From:   Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject:     Re: [PATCH] riscv: Use flush_icache_mm for flush_icache_user_range
CC:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        guoren@linux.alibaba.com, Andrew Waterman <andrew@sifive.com>,
        palmer@sifive.com
To:     guoren@linux.alibaba.com
In-Reply-To: <20200124161810.24322-1-guoren@linux.alibaba.com>
References: <20200124161810.24322-1-guoren@linux.alibaba.com>
Message-ID: <mhng-19381e7d-faca-4e0d-87e6-29d43d7796e0@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Fri, 24 Jan 2020 16:18:10 GMT (+0000), guoren@linux.alibaba.com wrote:
> The only call path is:
>
> __access_remote_vm -> copy_to_user_page -> flush_icache_user_range
>
> Seems it's ok to use flush_icache_mm instead of flush_icache_all and
> it could reduce flush_icache_all called on other harts.
>
> I think the patch is the fixup for the commit 08f051eda33b.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Cc: Andrew Waterman <andrew@sifive.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> ---
>  arch/riscv/include/asm/cacheflush.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/include/asm/cacheflush.h b/arch/riscv/include/asm/cacheflush.h
> index b69aecbb36d3..26589623fd57 100644
> --- a/arch/riscv/include/asm/cacheflush.h
> +++ b/arch/riscv/include/asm/cacheflush.h
> @@ -85,7 +85,7 @@ static inline void flush_dcache_page(struct page *page)
>   * so instead we just flush the whole thing.
>   */
>  #define flush_icache_range(start, end) flush_icache_all()
> -#define flush_icache_user_range(vma, pg, addr, len) flush_icache_all()
> +#define flush_icache_user_range(vma, pg, addr, len) flush_icache_mm(vma->vm_mm, 0)
>
>  void dma_wbinv_range(unsigned long start, unsigned long end);
>  void dma_wb_range(unsigned long start, unsigned long end);

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

I've added this to for-next with some minor modifications as
4d99abce8ce80e866020ffa5b2bd790269235f37.  It missed the PR I'm sending
now-ish, but I'll include it as part of the next one even if it's during an
early RC.

Thanks!
