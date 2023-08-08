Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73AAC774498
	for <lists+linux-csky@lfdr.de>; Tue,  8 Aug 2023 20:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbjHHSYF (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 8 Aug 2023 14:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235450AbjHHSXl (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 8 Aug 2023 14:23:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7577EFE
        for <linux-csky@vger.kernel.org>; Tue,  8 Aug 2023 10:35:24 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99bcf2de59cso863544966b.0
        for <linux-csky@vger.kernel.org>; Tue, 08 Aug 2023 10:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691516123; x=1692120923;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fKaXpSlwUGOFKYnA0/ujGgP0b2CVx1lfhbc608RRtk4=;
        b=cC/eQAfalXq4FW0hsgHeomL2iWvA/dGSj4o9rnppDl8N398tPTjdPhB56le/gyaudD
         d3RyjEHeWLGTxpXZwjMYZaPb6BIondRXg2BHUD7uC9FbX3UFAuSM9zShxrwtmOFEDJy0
         XNIxSyl2OVVWDkfgC1pM622mT3KfLiMvUDT0mqEen+kdA1C5sE/O5DtAmrmTKvIRuJzD
         tPZzDu11MFEgx1kt5D5dzJqdMIE4KfFcK3otyoLXfPcNTae2iqGNQDUOd/Js4zYwHgR/
         GRJqB96ImsUas48BNaiPcBOen2Sk833YdNnmcF/TvYTSDKJOlRFMTxy+5EeDHBCIx3ii
         oVEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516123; x=1692120923;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKaXpSlwUGOFKYnA0/ujGgP0b2CVx1lfhbc608RRtk4=;
        b=b5QDqa8989DWtKF9ASIvCpe1VICHU/RR+hUYzN7QC17G93BiCt7OAUsHf3v8EIb1dS
         C1vE3zWVaJfMFnqSMlyPCSy1UPvaIfuJqBuaaxGQwwgaOr3SLZsxbvwVyMFjE/8MBV9b
         ECo2JTEz9eQJS244iMDnY2das+XZ4RE9nlhGXGlqljKiT4iuBSrOv2CO14HLrrAOQ8DM
         2G2RNUwKhgYXoUujSlRFcEEMIM7Vp3fBZ4UNL9IPQNr1+/xUKEVSR0bBM2fGrBlWjykm
         yk3e5vAQXPhMpV44hKMb/De6uxKMaFEzksCdqLyFfgcUEPo3E7vakZLLJehGm8NL9CeO
         eEGw==
X-Gm-Message-State: AOJu0YwTyon0xCpecOHteW3a/XofXC1+qsWyGm3rdEoBWKMqtRlO4nYG
        +/lxMhgnHA7FgYZfbrlDwebHVQsV4Y68v89SODU=
X-Google-Smtp-Source: AGHT+IGwuIaXMoIESGfMjXZqvgjAKYGfq+7lPk9/u4u6+4RfcqSnKW8XNmPB5gwM67RaOJssLaTogw==
X-Received: by 2002:ac2:5b89:0:b0:4fb:7888:7e6d with SMTP id o9-20020ac25b89000000b004fb78887e6dmr7043859lfn.46.1691483162463;
        Tue, 08 Aug 2023 01:26:02 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id t13-20020a19ad0d000000b004fbae18984dsm1787087lfc.255.2023.08.08.01.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:26:01 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/2] csky: Convert memory accessors to static inlines
Date:   Tue, 08 Aug 2023 10:25:54 +0200
Message-Id: <20230808-csky-virt-to-phys-v1-0-ac727f8def2f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABL80WQC/x3MPQqAMAxA4atIZgP9GaxeRRykphoElaYUpXh3i
 +M3vFdAKDIJDE2BSJmFz6NCtw34bT5WQl6qwShjlVMOvewPZo4J04nX9gjaxSmvO6N16KF2V6T
 A9/8cp/f9ALLAmCNjAAAA
To:     Vineet Gupta <vgupta@kernel.org>, Guo Ren <guoren@kernel.org>
Cc:     linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

