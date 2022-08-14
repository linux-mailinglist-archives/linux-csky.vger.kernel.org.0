Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262A15922A1
	for <lists+linux-csky@lfdr.de>; Sun, 14 Aug 2022 17:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241759AbiHNPtP (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sun, 14 Aug 2022 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240192AbiHNPrB (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sun, 14 Aug 2022 11:47:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D6765B7;
        Sun, 14 Aug 2022 08:35:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70DBE60DB7;
        Sun, 14 Aug 2022 15:35:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC998C433D7;
        Sun, 14 Aug 2022 15:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660491316;
        bh=5dBZbZXQNfVHSjI8nHnSrIYAGDA/pPykGZHL7T7DMKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sxq49YOeqTajbLf+Mblij09hPyNukxIsPq42dywFW9Ir5fbmJY5D2c6hj7edlJAk2
         ALywa+UdEYEQvUiskRq1AbabrolZih2GIGcRuHqgYqbahCh9NRto0zPqLmQZivhQAl
         C9k3hdj9H4YCPyzI5ieZ/6XagWUo2grQMzPVXWU/iuVJOuSVPxvNXHbaTgPz6XtBng
         yIdKmzczM4gCN2VFS+uJbKS3Q8Lm6UP1rGXxeZo+rCi9Px5AB8zCnaKAJJjivpLb7F
         +SRUlWadgLl1peIzWY9rLqpB3fFcxHV8N3V+dL0hk8m3RFWWa37ARAP6EYOql1jZIw
         1t2l4S7hrj99w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liao Chang <liaochang1@huawei.com>,
        Chen Guokai <chenguokai17@mails.ucas.ac.cn>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Guo Ren <guoren@kernel.org>, Sasha Levin <sashal@kernel.org>,
        rostedt@goodmis.org, julia.lawall@inria.fr,
        akpm@linux-foundation.org, lkp@intel.com,
        linux-csky@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 23/31] csky/kprobe: reclaim insn_slot on kprobe unregistration
Date:   Sun, 14 Aug 2022 11:34:23 -0400
Message-Id: <20220814153431.2379231-23-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814153431.2379231-1-sashal@kernel.org>
References: <20220814153431.2379231-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

From: Liao Chang <liaochang1@huawei.com>

[ Upstream commit a2310c74d418deca0f1d749c45f1f43162510f51 ]

On kprobe registration kernel allocate one insn_slot for new kprobe,
but it forget to reclaim the insn_slot on unregistration, leading to a
potential leakage.

Reported-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Liao Chang <liaochang1@huawei.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/kernel/probes/kprobes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
index 556b9ba61ec0..79272dde72db 100644
--- a/arch/csky/kernel/probes/kprobes.c
+++ b/arch/csky/kernel/probes/kprobes.c
@@ -124,6 +124,10 @@ void __kprobes arch_disarm_kprobe(struct kprobe *p)
 
 void __kprobes arch_remove_kprobe(struct kprobe *p)
 {
+	if (p->ainsn.api.insn) {
+		free_insn_slot(p->ainsn.api.insn, 0);
+		p->ainsn.api.insn = NULL;
+	}
 }
 
 static void __kprobes save_previous_kprobe(struct kprobe_ctlblk *kcb)
-- 
2.35.1

