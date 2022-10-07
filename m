Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DFC5F7ADE
	for <lists+linux-csky@lfdr.de>; Fri,  7 Oct 2022 17:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbiJGPqZ (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 7 Oct 2022 11:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJGPqJ (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 7 Oct 2022 11:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB14A1217ED
        for <linux-csky@vger.kernel.org>; Fri,  7 Oct 2022 08:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665157565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4Pqcbma7I8CmezCzayfM2Dc1cTkJUS9uBKY5V7UMK0=;
        b=R6ivKPGV1WTUPftIQ6GlVAUdzCKgQYR9SPf9kGVdAxCGR3xkl5KbAOX2ggSG0qiYX4Vgel
        aZb8X8lgZltAT1DLITy3H+GBWxuuhkA/2iPZQBQRrfU2pv3FW+GcgSe+VYm3oQBBSa9DAc
        2Sos5slU8mT7LTPJ6D29W6Zmqc8IjcI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-608-FH3vkmRLPvuh2jG5Pr6oig-1; Fri, 07 Oct 2022 11:46:04 -0400
X-MC-Unique: FH3vkmRLPvuh2jG5Pr6oig-1
Received: by mail-wm1-f72.google.com with SMTP id h129-20020a1c2187000000b003c3eb8683acso340139wmh.3
        for <linux-csky@vger.kernel.org>; Fri, 07 Oct 2022 08:46:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O4Pqcbma7I8CmezCzayfM2Dc1cTkJUS9uBKY5V7UMK0=;
        b=0H+8JtKLbJVWJiS/wSbL6+K8wY6zGuEWyZCLE2uh756o8SQc35vARurSVYgHdL8085
         CQi6MNCQE1mHRUaUA7ewRLZFDHapWPlpD8Ws1ikB02D8GT7y7W5sLf8XivFM2tbzjm5C
         OEDCOoDRafAvYDYYXQlKMjhZwr7OS934YyoYHS9GqlJbUVoL973/cNbUzVxLiwcMN2ln
         szktY3+vvUqiCsLWBozVvUvfJk7e3lfjYB7VKI4KozaWe/nTl/4C8XMyxPWxRY4LNNhY
         njYO/8bRPyFWabF+7iOUC+xCIMGUJRJFgmQjDR2gKrMS3o7wamQMLRA6/gH3QGYSd271
         TZPw==
X-Gm-Message-State: ACrzQf1wrpMQlWsxkL51SQxoiRvy2plx3nDoq6gyzXddU0weHkFSJCOq
        uBGRDVQFeP5vuta4sn6OKWfuWmopv1p3MXMMaDuqM+uvVyiLuCExeZ6XayadiWR/1oUecfhwt64
        tLcfJzSrpufRJRQtA4d5sKw==
X-Received: by 2002:a05:600c:474c:b0:3b4:cbca:5677 with SMTP id w12-20020a05600c474c00b003b4cbca5677mr3615508wmo.76.1665157563640;
        Fri, 07 Oct 2022 08:46:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5BU2FP8ts0HH9McA8hGqt4EcEkhUio8tUw5hjcE8rRRaWGVB+HCzlKu55T50nu8VVd2MVS1w==
X-Received: by 2002:a05:600c:474c:b0:3b4:cbca:5677 with SMTP id w12-20020a05600c474c00b003b4cbca5677mr3615475wmo.76.1665157563388;
        Fri, 07 Oct 2022 08:46:03 -0700 (PDT)
Received: from vschneid.remote.csb ([149.71.65.94])
        by smtp.gmail.com with ESMTPSA id i18-20020adfb652000000b0022e38c93195sm2339428wre.34.2022.10.07.08.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 08:46:01 -0700 (PDT)
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
Subject: [RFC PATCH 3/5] smp: Add a multi-CPU variant to send_call_function_single_ipi()
Date:   Fri,  7 Oct 2022 16:45:31 +0100
Message-Id: <20221007154533.1878285-3-vschneid@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221007154145.1877054-1-vschneid@redhat.com>
References: <20221007154145.1877054-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

This simply wraps around the arch function and prepends it with a
tracepoint, bringing parity with send_call_function_single_ipi().

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 kernel/smp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 7a7a22d69972..387735180aed 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -160,6 +160,12 @@ void __init call_function_init(void)
 	smpcfd_prepare_cpu(smp_processor_id());
 }
 
+static inline void send_call_function_ipi_mask(const struct cpumask *mask)
+{
+	trace_ipi_send_cpumask(_RET_IP_, mask);
+	arch_send_call_function_ipi_mask(mask);
+}
+
 #ifdef CONFIG_CSD_LOCK_WAIT_DEBUG
 
 static DEFINE_STATIC_KEY_FALSE(csdlock_debug_enabled);
@@ -970,7 +976,7 @@ static void smp_call_function_many_cond(const struct cpumask *mask,
 		if (nr_cpus == 1)
 			send_call_function_single_ipi(last_cpu);
 		else if (likely(nr_cpus > 1))
-			arch_send_call_function_ipi_mask(cfd->cpumask_ipi);
+			send_call_function_ipi_mask(cfd->cpumask_ipi);
 
 		cfd_seq_store(this_cpu_ptr(&cfd_seq_local)->pinged, this_cpu, CFD_SEQ_NOCPU, CFD_SEQ_PINGED);
 	}
-- 
2.31.1

