Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4887754DB
	for <lists+linux-csky@lfdr.de>; Wed,  9 Aug 2023 10:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjHIIOH (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 9 Aug 2023 04:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjHIIOG (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 9 Aug 2023 04:14:06 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C099610FF
        for <linux-csky@vger.kernel.org>; Wed,  9 Aug 2023 01:14:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe1489ced6so10821162e87.0
        for <linux-csky@vger.kernel.org>; Wed, 09 Aug 2023 01:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691568844; x=1692173644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WPNuwr8BV2crYdR1HSxa9CVFwtJ2x4ORzKRyFk7VJAs=;
        b=S3NUfjB4bsVe9j6vOvkgbzCiTwC+/LUZKHOJA+DVd1hF79XKEdcJLk5HeANwSJMNbE
         wFpiDbSv79eoDUKbFvABoRC4bzoj14hmJCAJZ+IEaSBva/ry7TZMziatdW3YEqIdCjgB
         YulVLM079c0A02u23M9dDfoB9cMLWz0IkCBNCjYoMH6qyb1qOSwKadguXMuWw3CgQUVQ
         0+9kRZjClq3de5Y0DtfavbxvkIy/dspo/iG+vratIzTwZtvaM+YMiU76D9uExhAgJoxH
         7UE9kG79yVX/aXKS7E+0xBKcFA0aQMmaJjFSi5930Xbdy/54AMjv26QFYnm5g9zPIY59
         7OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568844; x=1692173644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WPNuwr8BV2crYdR1HSxa9CVFwtJ2x4ORzKRyFk7VJAs=;
        b=j7wS8OB5orFdHZtNKyvlujlR+sorVFhmPIOmcTHY3WtaaCLJKtd0r1T5+b+2eztCV2
         2HVPzkPoo+2+Tdjf5oN9lSWRui3IrOjR+gyiI/9LheqxbFX6ikf2wxLkg+7GbhMSonvj
         TqxUDA9UV7H6Uf/sNpsC2JM1gof/ATexfTdBu64/14fhThoHMVz7PP+67fLtFwv2dcmc
         jK1EDvRIr63bURbSrex6F25aMJ+gLBUpFnWKRuy9zIXg/nZ5aX8S353DbAmxq96zpwT5
         JNjEMOvBIOtupD84/rTzPd/git4fi1BfWP+sVRiJeDpLFw7X77oQWbnrUpsHmOOUVO8N
         qsdA==
X-Gm-Message-State: AOJu0YxVhDIbnTnJNknJrtKcfsSrNMaBtoQJOg5TmUqC5PpDspFAKa4W
        017Sc4PmWvzsN4Er+xkJaEbldA==
X-Google-Smtp-Source: AGHT+IGFV6oMEHkHKUKwQzLqMtPfeM/T6iurCa7KQ+Aco/96KR8LzXnX/g855E8IYulDBfcHTtWs6Q==
X-Received: by 2002:a05:6512:3d24:b0:4f9:571d:c50e with SMTP id d36-20020a0565123d2400b004f9571dc50emr1501208lfv.36.1691568843947;
        Wed, 09 Aug 2023 01:14:03 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w12-20020ac25d4c000000b004f84a92ba75sm2196916lfd.65.2023.08.09.01.14.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 01:14:03 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 09 Aug 2023 10:14:01 +0200
Subject: [PATCH v2 1/2] csky: Cast argument to virt_to_pfn() to (void *)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230809-csky-virt-to-phys-v2-1-2697c93f60cf@linaro.org>
References: <20230809-csky-virt-to-phys-v2-0-2697c93f60cf@linaro.org>
In-Reply-To: <20230809-csky-virt-to-phys-v2-0-2697c93f60cf@linaro.org>
To:     Vineet Gupta <vgupta@kernel.org>, Guo Ren <guoren@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

The virt_to_pfn() function takes a (void *) as argument, fix
this up to avoid exploiting the unintended polymorphism of
virt_to_pfn.

Acked-by: Guo Ren <guoren@kernel.org>
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

