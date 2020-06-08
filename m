Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1D61F2C20
	for <lists+linux-csky@lfdr.de>; Tue,  9 Jun 2020 02:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731516AbgFIAVH (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Mon, 8 Jun 2020 20:21:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730544AbgFHXRy (ORCPT <rfc822;linux-csky@vger.kernel.org>);
        Mon, 8 Jun 2020 19:17:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE29D20885;
        Mon,  8 Jun 2020 23:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658274;
        bh=y+OpidB/SxRmVMvmFkNAKPuLpPMPNyxElUHB7xdoPvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mCRo8umAMj+7VdQgyUQgLZNPswDMgiEKceqTbZRT+kau0/1UxAv2rAsLYQkVcxzcs
         7gJ9NWKJPVf9VpZPkGu4azrgh8o29SMnpFOwY7xQ55vSjsi+OkCLlvkPE7y4LYnzVn
         U2NOWyYu+a0SPnIdgAOtlbFIRwl1ommnVIFm6spM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mao Han <han_mao@linux.alibaba.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 280/606] csky: Fixup perf callchain unwind
Date:   Mon,  8 Jun 2020 19:06:45 -0400
Message-Id: <20200608231211.3363633-280-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

From: Mao Han <han_mao@linux.alibaba.com>

[ Upstream commit 229a0ddee1108a3f82a873e6cbbe35c92c540444 ]

 [ 5221.974084] Unable to handle kernel paging request at virtual address 0xfffff000, pc: 0x8002c18e
 [ 5221.985929] Oops: 00000000
 [ 5221.989488]
 [ 5221.989488] CURRENT PROCESS:
 [ 5221.989488]
 [ 5221.992877] COMM=callchain_test PID=11962
 [ 5221.995213] TEXT=00008000-000087e0 DATA=00009f1c-0000a018 BSS=0000a018-0000b000
 [ 5221.999037] USER-STACK=7fc18e20  KERNEL-STACK=be204680
 [ 5221.999037]
 [ 5222.003292] PC: 0x8002c18e (perf_callchain_kernel+0x3e/0xd4)
 [ 5222.007957] LR: 0x8002c198 (perf_callchain_kernel+0x48/0xd4)
 [ 5222.074873] Call Trace:
 [ 5222.074873] [<800a248e>] get_perf_callchain+0x20a/0x29c
 [ 5222.074873] [<8009d964>] perf_callchain+0x64/0x80
 [ 5222.074873] [<8009dc1c>] perf_prepare_sample+0x29c/0x4b8
 [ 5222.074873] [<8009de6e>] perf_event_output_forward+0x36/0x98
 [ 5222.074873] [<800497e0>] search_exception_tables+0x20/0x44
 [ 5222.074873] [<8002cbb6>] do_page_fault+0x92/0x378
 [ 5222.074873] [<80098608>] __perf_event_overflow+0x54/0xdc
 [ 5222.074873] [<80098778>] perf_swevent_hrtimer+0xe8/0x164
 [ 5222.074873] [<8002ddd0>] update_mmu_cache+0x0/0xd8
 [ 5222.074873] [<8002c014>] user_backtrace+0x58/0xc4
 [ 5222.074873] [<8002c0b4>] perf_callchain_user+0x34/0xd0
 [ 5222.074873] [<800a2442>] get_perf_callchain+0x1be/0x29c
 [ 5222.074873] [<8009d964>] perf_callchain+0x64/0x80
 [ 5222.074873] [<8009d834>] perf_output_sample+0x78c/0x858
 [ 5222.074873] [<8009dc1c>] perf_prepare_sample+0x29c/0x4b8
 [ 5222.074873] [<8009de94>] perf_event_output_forward+0x5c/0x98
 [ 5222.097846]
 [ 5222.097846] [<800a0300>] perf_event_exit_task+0x58/0x43c
 [ 5222.097846] [<8006c874>] hrtimer_interrupt+0x104/0x2ec
 [ 5222.097846] [<800a0300>] perf_event_exit_task+0x58/0x43c
 [ 5222.097846] [<80437bb6>] dw_apb_clockevent_irq+0x2a/0x4c
 [ 5222.097846] [<8006c770>] hrtimer_interrupt+0x0/0x2ec
 [ 5222.097846] [<8005f2e4>] __handle_irq_event_percpu+0xac/0x19c
 [ 5222.097846] [<80437bb6>] dw_apb_clockevent_irq+0x2a/0x4c
 [ 5222.097846] [<8005f408>] handle_irq_event_percpu+0x34/0x88
 [ 5222.097846] [<8005f480>] handle_irq_event+0x24/0x64
 [ 5222.097846] [<8006218c>] handle_level_irq+0x68/0xdc
 [ 5222.097846] [<8005ec76>] __handle_domain_irq+0x56/0xa8
 [ 5222.097846] [<80450e90>] ck_irq_handler+0xac/0xe4
 [ 5222.097846] [<80029012>] csky_do_IRQ+0x12/0x24
 [ 5222.097846] [<8002a3a0>] csky_irq+0x70/0x80
 [ 5222.097846] [<800ca612>] alloc_set_pte+0xd2/0x238
 [ 5222.097846] [<8002ddd0>] update_mmu_cache+0x0/0xd8
 [ 5222.097846] [<800a0340>] perf_event_exit_task+0x98/0x43c

The original fp check doesn't base on the real kernal stack region.
Invalid fp address may cause kernel panic.

Signed-off-by: Mao Han <han_mao@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/kernel/perf_callchain.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/csky/kernel/perf_callchain.c b/arch/csky/kernel/perf_callchain.c
index e68ff375c8f8..ab55e98ee8f6 100644
--- a/arch/csky/kernel/perf_callchain.c
+++ b/arch/csky/kernel/perf_callchain.c
@@ -12,12 +12,17 @@ struct stackframe {
 
 static int unwind_frame_kernel(struct stackframe *frame)
 {
-	if (kstack_end((void *)frame->fp))
+	unsigned long low = (unsigned long)task_stack_page(current);
+	unsigned long high = low + THREAD_SIZE;
+
+	if (unlikely(frame->fp < low || frame->fp > high))
 		return -EPERM;
-	if (frame->fp & 0x3 || frame->fp < TASK_SIZE)
+
+	if (kstack_end((void *)frame->fp) || frame->fp & 0x3)
 		return -EPERM;
 
 	*frame = *(struct stackframe *)frame->fp;
+
 	if (__kernel_text_address(frame->lr)) {
 		int graph = 0;
 
-- 
2.25.1

