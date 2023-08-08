Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5BD773F9C
	for <lists+linux-csky@lfdr.de>; Tue,  8 Aug 2023 18:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233513AbjHHQuY (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 8 Aug 2023 12:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbjHHQtS (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 8 Aug 2023 12:49:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B3E55BC
        for <linux-csky@vger.kernel.org>; Tue,  8 Aug 2023 08:57:25 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-307d58b3efbso4477326f8f.0
        for <linux-csky@vger.kernel.org>; Tue, 08 Aug 2023 08:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510206; x=1692115006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6m3K/inEtRmdGEBBt/pEMpMfJWtxVrjJEBC47w+pHA=;
        b=ZoG/JsiJUjV6M+X36CcK7jJVuZnbQFIVnCYyWxZKGh/oGZhWzBxJtcZ476B8OJIl0u
         M5JH8mV+D04McgBdqGIS3tSTq4fqL2fave4JsowwN7PKYGeLmpcNTiHZ4ZmFszHfrXFm
         xihZTMmc1L62ODMtWZ47S0NkcKhuadwV3JWtUrf6fFREtvHGgfI52yN1je/szO5LdgOH
         zzAUUC+HXb4UQDAuvXyyXk/3UN/ATtzLVViI9ql2QcpUSWPddWlVjY5Sg73BZlu+HQAA
         8jS7B4Ub2H0XO5ftb3eGEBPVwiE5mw3Dw0aoc6nZX4hbjPhsKxwcLNP6Bd4qskUW9tOw
         PnhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510206; x=1692115006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6m3K/inEtRmdGEBBt/pEMpMfJWtxVrjJEBC47w+pHA=;
        b=cBjDYbUDTYmsF/fXqgihf8EZSfVozQioJIIGfKuZoQ9Xk3OtNcuBUbT4ANYCf/3CAX
         esGIYz+2+a0tTKAcc5brtQeGMH0ca6B6dXlnl0GZBZgsAdwCeMdojbeWwZOLimhdr3RY
         mqFQMt5NZ7iQ9BgVgn5Fuq7fI0wJGR8cFtcfUmu6UpSE6ms13CZNKahXL8Q2r0OjuuuH
         8H0c0yxy5sYsSOiANM+fuGS7PoKQqQ75g5WizjKN5kGfzG4vkG2mo9ec4f49X2sOkfkh
         m/PLIzDtSMxso0y8gatYRnCW8Y/4VvzCr8DPvgsWD+R9ueqEl1ZKyDuJpdq18uOTo2WI
         bD2A==
X-Gm-Message-State: AOJu0YwjIA4DZJdScLBNc3jFQ1ru0ar8BzKAjjnwVV9mP/k/0vSd53jS
        UGK1/5PFsB3LWI9wzvKrS3nlfNwL+jd5bQND51I=
X-Google-Smtp-Source: AGHT+IHxDCh1uiQfUmmrydV7nAhXgfZ1Kwvcz0RMY0OKmPWNtnQhD201bB37ZY0n1WH7gHW98TyYVg==
X-Received: by 2002:a05:6512:ad5:b0:4fb:9050:1d92 with SMTP id n21-20020a0565120ad500b004fb90501d92mr8131994lfu.51.1691483163361;
        Tue, 08 Aug 2023 01:26:03 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id t13-20020a19ad0d000000b004fbae18984dsm1787087lfc.255.2023.08.08.01.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:26:02 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 10:25:55 +0200
Subject: [PATCH 1/2] csky: Cast argument to virt_to_pfn() to (void *)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-csky-virt-to-phys-v1-1-ac727f8def2f@linaro.org>
References: <20230808-csky-virt-to-phys-v1-0-ac727f8def2f@linaro.org>
In-Reply-To: <20230808-csky-virt-to-phys-v1-0-ac727f8def2f@linaro.org>
To:     Vineet Gupta <vgupta@kernel.org>, Guo Ren <guoren@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

The virt_to_pfn() function takes a (void *) as argument, fix
this up to avoid exploiting the unintended polymorphism of
virt_to_pfn.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arc/include/asm/page.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
index e43fe27ec54d..02b53ad811fb 100644
--- a/arch/arc/include/asm/page.h
+++ b/arch/arc/include/asm/page.h
@@ -108,7 +108,7 @@ extern int pfn_valid(unsigned long pfn);
 
 #else /* CONFIG_HIGHMEM */
 
-#define ARCH_PFN_OFFSET		virt_to_pfn(CONFIG_LINUX_RAM_BASE)
+#define ARCH_PFN_OFFSET		virt_to_pfn((void *)CONFIG_LINUX_RAM_BASE)
 
 #endif /* CONFIG_HIGHMEM */
 

-- 
2.34.1

