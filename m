Return-Path: <linux-csky+bounces-518-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67771904566
	for <lists+linux-csky@lfdr.de>; Tue, 11 Jun 2024 21:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC5F1F2133D
	for <lists+linux-csky@lfdr.de>; Tue, 11 Jun 2024 19:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049131514D8;
	Tue, 11 Jun 2024 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JXP0r93T"
X-Original-To: linux-csky@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456F150993;
	Tue, 11 Jun 2024 19:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718135834; cv=none; b=WUPf57mHh2Q+H6dRysE7/hSLjhcuFu8EqOvKLgbBT5mia/fXE+3cG0jllag8/nYR9XH35ukAsi1cQD5IahJsZwVAvyJYNdr5qERR/SgFRfe4U2C3qAquPcJvuuNMcCmnGl0+irGK9iJGeoGG9cE5euYoFA2j1DmlQh9w1tz9cRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718135834; c=relaxed/simple;
	bh=6M1ebK5ksd8fFr0463WqM9S7WBIPDoIGj+N3XpTNpPc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KtdoH1PxXcV4KuJbZM+qDMNRUxeHPp51ICWdSdE1JYBUz3NhmQOqD0UQPbEZLG5lYNZeJXYf/QnxHhqMwTrRQA4gx2tMdPdCvln0t5JfeJv/eHkvlRz2tMW9F1Hcbdp/5ANdQnv2Ngkds6WrAlFMNIMmI4ONUD5LlAHbO0CIvmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JXP0r93T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A94FFC2BD10;
	Tue, 11 Jun 2024 19:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718135834;
	bh=6M1ebK5ksd8fFr0463WqM9S7WBIPDoIGj+N3XpTNpPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JXP0r93TC6EddhtLwiYV0ZjXHBBlEdNNIljuy8rPFZz9i8xvRmt12ONtRAzQCSzwt
	 3QZdLA4TSq94RabfXvxKod5pcgr5XD4hgZFDGIRsEWmQbkgIJuYCOyP44PqHjE/an0
	 pAiTbYjRMIfWLZcfyz6UK4G/Z28FKjxWfKWHmoCU=
Date: Tue, 11 Jun 2024 12:57:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>
Cc: "ampere-linux-kernel@lists.amperecomputing.com"
 <ampere-linux-kernel@lists.amperecomputing.com>, Uladzislau Rezki
 <urezki@gmail.com>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "cl@linux.com" <cl@linux.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "linux-mm@kvack.org"
 <linux-mm@kvack.org>, "guoren@kernel.org" <guoren@kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "xiongwei.song@windriver.com" <xiongwei.song@windriver.com>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Matthew Wilcox
 <willy@infradead.org>
Subject: Re: [PATCH v5] vmalloc: Modify the alloc_vmap_area() error message
 for better diagnostics
Message-Id: <20240611125713.eeef88483f5a782e3df71b21@linux-foundation.org>
In-Reply-To: <CH2PR01MB5894B0182EA0B28DF2EFB916F5C72@CH2PR01MB5894.prod.exchangelabs.com>
References: <CH2PR01MB5894B0182EA0B28DF2EFB916F5C72@CH2PR01MB5894.prod.exchangelabs.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 19:38:44 +0000 Shubhang Kaushik OS <Shubhang@os.amperecomputing.com> wrote:

> 'vmap allocation for size %lu failed: use vmalloc=<size> to increase size'
> The above warning is seen in the kernel functionality for allocation of the restricted virtual memory range till exhaustion.
> 
> This message is misleading because 'vmalloc=' is supported on arm32, x86 platforms and is not a valid kernel parameter on a number of other platforms (in particular its not supported on arm64, alpha, loongarch, arc, csky, hexagon, microblaze, mips, nios2, openrisc, parisc, m64k, powerpc, riscv, sh, um, xtensa, s390, sparc). With the update, the output gets modified to include the function parameters along with the start and end of the virtual memory range allowed.
> 
> The warning message after fix on kernel version 6.10.0-rc1+:
> 
> vmalloc_node_range for size 33619968 failed: Address range restricted between 0xffff800082640000 - 0xffff800084650000
> 
> Backtrace with the misleading error message:
> 
> 	vmap allocation for size 33619968 failed: use vmalloc=<size> to increase size
> 	insmod: vmalloc error: size 33554432, vm_struct allocation failed, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> 	CPU: 46 PID: 1977 Comm: insmod Tainted: G            E      6.10.0-rc1+ #79
> 	Hardware name: INGRASYS Yushan Server iSystem TEMP-S000141176+10/Yushan Motherboard, BIOS 2.10.20230517 (SCP: xxx) yyyy/mm/dd
> 	Call trace:
> 		dump_backtrace+0xa0/0x128
> 		show_stack+0x20/0x38
> 		dump_stack_lvl+0x78/0x90
> 		dump_stack+0x18/0x28
> 		warn_alloc+0x12c/0x1b8
> 		__vmalloc_node_range_noprof+0x28c/0x7e0
> 		custom_init+0xb4/0xfff8 [test_driver]
> 		do_one_initcall+0x60/0x290
> 		do_init_module+0x68/0x250
> 		load_module+0x236c/0x2428
> 		init_module_from_file+0x8c/0xd8
> 		__arm64_sys_finit_module+0x1b4/0x388
> 		invoke_syscall+0x78/0x108
> 		el0_svc_common.constprop.0+0x48/0xf0
> 		do_el0_svc+0x24/0x38
> 		el0_svc+0x3c/0x130
> 		el0t_64_sync_handler+0x100/0x130
> 		el0t_64_sync+0x190/0x198

When sending an updated version, please describe what was changed since
the previous version.  After the changelog's ^---$ separator is the
usual place.

I'm seeing this:

--- a/mm/vmalloc.c~vmalloc-modify-the-alloc_vmap_area-error-message-for-better-diagnostics-v5
+++ a/mm/vmalloc.c
@@ -2057,7 +2057,7 @@ overflow:
 
 	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
 		pr_warn("vmalloc_node_range for size %lu failed: Address range restricted to %#lx - %#lx\n",
-				size, addr, addr+size);
+				size, vstart, vend);
 
 	kmem_cache_free(vmap_area_cachep, va);
 	return ERR_PTR(-EBUSY);
_

which I assume has no effect?

