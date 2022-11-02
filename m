Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79E8616C5D
	for <lists+linux-csky@lfdr.de>; Wed,  2 Nov 2022 19:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKBSgU (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 2 Nov 2022 14:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiKBSgJ (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 2 Nov 2022 14:36:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B3C2F679
        for <linux-csky@vger.kernel.org>; Wed,  2 Nov 2022 11:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667414061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QqLWPThYSO+7/uH6VGCIiG2p0FrpcxY/esl5LuglSyI=;
        b=hcb25Wuv/j1+BPGN+ZztQ1F7j4gESVpLpTCK/P6ePG7RuV+CF6/oA9H25POKTyf+sN9e1R
        goCl5QGl21VQ9GF/Tl7K4PaMNJCUbElb/7tl3BnZIkRwEGGlgt7uHyzny9otm5dQY/3ytj
        IGUhyxSedKXQSZbR8dm5dheJ/Kdr4E8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-302-bujweB_sMFaeJGMefdc-0Q-1; Wed, 02 Nov 2022 14:34:20 -0400
X-MC-Unique: bujweB_sMFaeJGMefdc-0Q-1
Received: by mail-qk1-f197.google.com with SMTP id i11-20020a05620a404b00b006eeb0791c1aso15997604qko.10
        for <linux-csky@vger.kernel.org>; Wed, 02 Nov 2022 11:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QqLWPThYSO+7/uH6VGCIiG2p0FrpcxY/esl5LuglSyI=;
        b=bJ8t54pT/DEabxQSwej9CqKAvT7PlKeNUpPelN/K4RWoO2CKbKceYNak+D3uNSq0P7
         P+oavH1kRWxR2hr7HsJyjb+cNBnTB7XmNTczNiIQa2qjpvoO+2fcziqLfWv8PnVN4R3l
         MSJMT2d/AcN8xt7E/nTZr+1I2VpGYh4yM/lg+vG4p/gHLxSb6YddMBKyS883tXhzolJZ
         UQgU6ImbHOaMz8FS+8vGjVe3IsNPk+pq68NEyeBa+XLnrg7e5CScauZ5UcyiULzFu9Dc
         Tlbgpe8agYRt2XiUBkIcCyE9DvB6hgh3WSyO3rzpf9ewYR99bBr2Poc1rpgZt8CFqGLP
         S3HA==
X-Gm-Message-State: ACrzQf2lmQn+OEcqLfLp8Q3QdDanvfbFexvaj+pDktKwl9WVvOLJfAnW
        F98KzcdLlCyaPLYcV4ddjVTWN/YL+jAEKFmE4MgCA1fXUUXQ/l6X9hNziNL64JGuobK3YZ2/z6p
        nkd2Pk3+n8YW0vZt7aqS+ng==
X-Received: by 2002:a05:620a:2185:b0:6fa:9b5:7bcd with SMTP id g5-20020a05620a218500b006fa09b57bcdmr17834820qka.689.1667414059898;
        Wed, 02 Nov 2022 11:34:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5zQBXSq1wHjxRSmwTcnsY0fuwHzVoafdqUQfLwgY4gLc/C2queTj08Inp5WgKA+UYkDnhs/w==
X-Received: by 2002:a05:620a:2185:b0:6fa:9b5:7bcd with SMTP id g5-20020a05620a218500b006fa09b57bcdmr17834779qka.689.1667414059700;
        Wed, 02 Nov 2022 11:34:19 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id w187-20020a3794c4000000b006eed47a1a1esm8757820qkd.134.2022.11.02.11.34.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:34:18 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        x86@kernel.org
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [RFC PATCH v2 4/8] smp: Trace IPIs sent via arch_send_call_function_ipi_mask()
Date:   Wed,  2 Nov 2022 18:33:32 +0000
Message-Id: <20221102183336.3120536-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221102182949.3119584-1-vschneid@redhat.com>
References: <20221102182949.3119584-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

This simply wraps around the arch function and prepends it with a
tracepoint, similar to send_call_function_single_ipi().

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/smp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index e2ca1e2f31274..c4d561cf50d45 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -160,6 +160,13 @@ void __init call_function_init(void)
 	smpcfd_prepare_cpu(smp_processor_id());
 }
 
+static inline void
+send_call_function_ipi_mask(const struct cpumask *mask)
+{
+	trace_ipi_send_cpumask(mask, _RET_IP_, func);
+	arch_send_call_function_ipi_mask(mask);
+}
+
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
 static DEFINE_STATIC_KEY_FALSE(csdlock_debug_enabled);
@@ -970,7 +977,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		if (nr_cpus == 1)
 			send_call_function_single_ipi(last_cpu);
 		else if (likely(nr_cpus > 1))
-			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
+			send_call_function_ipi_mask(cfd->cpumask_ipi);
 
 		cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->pinged, this_cpu, CFD_SEQ_NOCPU, CFD_SEQ_PINGED);
 	}
-- 
2.31.1

