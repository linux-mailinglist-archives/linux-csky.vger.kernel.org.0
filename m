Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216097754DA
	for <lists+linux-csky@lfdr.de>; Wed,  9 Aug 2023 10:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbjHIIOG (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 9 Aug 2023 04:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjHIIOG (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 9 Aug 2023 04:14:06 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D720310F6
        for <linux-csky@vger.kernel.org>; Wed,  9 Aug 2023 01:14:04 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe3678010eso10753483e87.3
        for <linux-csky@vger.kernel.org>; Wed, 09 Aug 2023 01:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691568843; x=1692173643;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/POtGoXxFGh/QREkHtBMWRDqd8iLqkrUnCKRL9clRsw=;
        b=fdKionpMUm0u6uiYhFl9Oc3nrINpFaoTuD+h0OSD2iXv1RbP3YpyCgehFgaLu4IcA4
         JDdhdgU2NLXuazckybostbzHkabIgdce5zuAWvu32iZpC0Hn3Zgd2VKG7Ew9ls/nus6d
         MFfPT1Qg48u6jK1AQAavOa3739LDp2lCBXRbVunA5ZQIDL9N7hkUAlHq1+W5I5hxbXQQ
         23re7bob1P6YXH/HuLbTU87z58ohetX6FJp1LPl3KZuk6fGpB5ksa1CeqiVaNvAw2qED
         RuXLuZ7zsS8cr3ZhJfXxhZcHIgM1eTC0/JVYfxezEVvkPIt6HDNdpwky6H8Iz5HCovW9
         KyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691568843; x=1692173643;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/POtGoXxFGh/QREkHtBMWRDqd8iLqkrUnCKRL9clRsw=;
        b=cEDHtqPo/6qMcoxM/j2gDh43OS9hNrjDT1/vm8xGaloSgK1EGPRHJkRJ4XLJPq51LG
         eOY1xscmf+T6HHk8/ooWFn6L08RzUAu7CJBsNNaQF5dHZRrV2X7TDbu61HVt/X7RZ35y
         MkPqa5b4RcfUlNQGPsOsibo8lwNgUpDJawVAL84vu8u/KKWjYWLpQoMb5TK17NcY8saQ
         BevOFEM0Y4883dbxAXvwJTcdwQ6RtFHKCteVC1S7o4b0NshfcuH19ndmtA6m4hX8+qVQ
         CK4OtTKHkYfK2ZEBAfnyfZPqS9vBDGil1kTItfiG7a/HEgr9vAV5hXoGy+msLJI62GkZ
         STiw==
X-Gm-Message-State: AOJu0Yy4UROz6cX1CG9pn4zEat1/SnML36kPEPYU9kWdZPnwkPJjuqNm
        hYHy0hGxLNjaeNzeohTQMBEXYpsjMCCOmjS8+6Q=
X-Google-Smtp-Source: AGHT+IGZecM6CbCsqF2dOwZiTNvsFmMX7R5/gF1JznmKyf1zitouJ85JqS7YhVKBTHEbwh8NPeTlDQ==
X-Received: by 2002:a19:6457:0:b0:4fb:81f2:422b with SMTP id b23-20020a196457000000b004fb81f2422bmr1300289lfj.54.1691568843022;
        Wed, 09 Aug 2023 01:14:03 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id w12-20020ac25d4c000000b004f84a92ba75sm2196916lfd.65.2023.08.09.01.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 01:14:02 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH v2 0/2] csky: Convert memory accessors to static inlines
Date:   Wed, 09 Aug 2023 10:14:00 +0200
Message-Id: <20230809-csky-virt-to-phys-v2-0-2697c93f60cf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMhK02QC/32NTQrDIBBGrxJm3SlqFtqueo+SRfAnDi0xjCINw
 bvX5gBdvgff+w7InslnuA8HsK+UKa0d1GUAG+d18UiuMyihRmGEQZtfO1bigiXhFveMozPCSq2
 kDDfou419oM/ZfE6dI+WSeD8vqvzZf7UqUeBstdLBOB9UeLxpnTldEy8wtda+K4neDrMAAAA=
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

This converts the virt_to_pfn and pfn_to_virt macros
into static inlines so we get proper type checking on
the pointers passed in.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Changes in v2:
- Fix compilation error on pfn_to_virt() by more casting.
- Return const void * rather than just void * from pfn_to_virt()
- Link to v1: https://lore.kernel.org/r/20230808-csky-virt-to-phys-v1-0-ac727f8def2f@linaro.org

---
Linus Walleij (2):
      csky: Cast argument to virt_to_pfn() to (void *)
      csky: Make pfn accessors static inlines

 arch/arc/include/asm/page.h  |  2 +-
 arch/csky/include/asm/page.h | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)
---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230808-csky-virt-to-phys-3d80c17211f9

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

