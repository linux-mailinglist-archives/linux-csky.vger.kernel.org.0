Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE11774090
	for <lists+linux-csky@lfdr.de>; Tue,  8 Aug 2023 19:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjHHRFI (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 8 Aug 2023 13:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjHHRE3 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 8 Aug 2023 13:04:29 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B5D5C0DA
        for <linux-csky@vger.kernel.org>; Tue,  8 Aug 2023 09:01:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so7035240a12.2
        for <linux-csky@vger.kernel.org>; Tue, 08 Aug 2023 09:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691510449; x=1692115249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bRPNurCVUK+kZN7q7E8TsOpZ2X9nLclQ5Lcqn45M43Y=;
        b=spjbX5NC9TxeuvC4D6vKaWxFqVQkawvnWxQ8i1vNaHYcXOxEfnv7suPbvK2Lva/hVI
         Id5YmU1atZaPQS9kwqHidsTmbMUhzjSS4IUUW5yUksU+yvtWmDIuuyIUALpT4wy4lEo2
         gRe9cDSgYptUD4utB0ay96BA05rPMZGR3xxkEgXMAdEPQxBn/HvjqBqcTAK4jLw1N0zN
         phffx3Gi6KGD0h3dIP4x3klX3a3whUeYD8/COkd4zqng7fLbd/PtnLiiryIumAZxEhuh
         utEGJ9M+P9ZRe6dLWh4KB++ZWBHHTLRjcBaaStmXQlsZbcLUmIpc0VmaBA2sm6g84EnM
         XcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510449; x=1692115249;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bRPNurCVUK+kZN7q7E8TsOpZ2X9nLclQ5Lcqn45M43Y=;
        b=a+E156ApYr7PzTzsMNGTy7FfYpofjCWf6lJeyUTyCcltBd+CzqUazZAV+JMYPyA7Ni
         8tXyPeKB33lky+Es51Jll6azSuJOE7B80GzpRJt5i5eQEtld0XGP+jobej9moWISn9Dx
         E/I+AJbJ84nxWpNAhidCkVyIahF1H+m+cs4hFuqAsGc/Ax4vXSlt3u/CRurtaPTUllEf
         WF7RcLnFNh3IwDqE4DdQ9MQHbNnSczDNm4l26r72cuWEIAYur/V9gmMi0bUUg84gdxqv
         PcpmIBT4mF9kSQkrLz1oyciTfBUGi8NYum/UwWXQv1phX0wS2VTTPbqJsbvGr7K36CT8
         N1qA==
X-Gm-Message-State: AOJu0Yz4F0IN4UC8+JOV+bAU3F+giXU/N2T14I+XQMJrlZEKmM6OiT2p
        GbxHX+pIylmryYaJPgZ9Z/g5Na0lFraWshQKJ8k=
X-Google-Smtp-Source: AGHT+IFcKitgCUMDjTXmYFgGTjati7nhjKf1RmPJEXoKcYA78VEzCeeOhe2OLLR3Pt79LBJFdpGryg==
X-Received: by 2002:a05:6512:358b:b0:4fd:d4b4:faba with SMTP id m11-20020a056512358b00b004fdd4b4fabamr7004297lfr.51.1691483164349;
        Tue, 08 Aug 2023 01:26:04 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id t13-20020a19ad0d000000b004fbae18984dsm1787087lfc.255.2023.08.08.01.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:26:03 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 08 Aug 2023 10:25:56 +0200
Subject: [PATCH 2/2] csky: Make pfn accessors static inlines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230808-csky-virt-to-phys-v1-2-ac727f8def2f@linaro.org>
References: <20230808-csky-virt-to-phys-v1-0-ac727f8def2f@linaro.org>
In-Reply-To: <20230808-csky-virt-to-phys-v1-0-ac727f8def2f@linaro.org>
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

Making virt_to_pfn() a static inline taking a strongly typed
(const void *) makes the contract of a passing a pointer of that
type to the function explicit and exposes any misuse of the
macro virt_to_pfn() acting polymorphic and accepting many types
such as (void *), (unitptr_t) or (unsigned long) as arguments
without warnings.

For symmetry to the same thing with pfn_to_virt().

In order to do this we move the virt_to_phys() and
phys_to_virt() below the definitions of the __pa()
and __va() macros so it compiles. The macro version was also
able to do recursive symbol resolution.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/csky/include/asm/page.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/csky/include/asm/page.h b/arch/csky/include/asm/page.h
index b23e3006a9e0..80da7e96a8fa 100644
--- a/arch/csky/include/asm/page.h
+++ b/arch/csky/include/asm/page.h
@@ -34,9 +34,6 @@
 
 #include <linux/pfn.h>
 
-#define virt_to_pfn(kaddr)      (__pa(kaddr) >> PAGE_SHIFT)
-#define pfn_to_virt(pfn)        __va((pfn) << PAGE_SHIFT)
-
 #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && \
 			(void *)(kaddr) < high_memory)
 
@@ -80,6 +77,16 @@ extern unsigned long va_pa_offset;
 
 #define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
 
+static inline unsigned long virt_to_pfn(const void *kaddr)
+{
+	return __pa(kaddr) >> PAGE_SHIFT;
+}
+
+static inline void * pfn_to_virt(unsigned long pfn)
+{
+	return __va(pfn) << PAGE_SHIFT;
+}
+
 #define MAP_NR(x)	PFN_DOWN((unsigned long)(x) - PAGE_OFFSET - \
 				 PHYS_OFFSET_OFFSET)
 #define virt_to_page(x)	(mem_map + MAP_NR(x))

-- 
2.34.1

