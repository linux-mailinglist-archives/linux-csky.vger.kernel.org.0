Return-Path: <linux-csky+bounces-688-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0447593FB6F
	for <lists+linux-csky@lfdr.de>; Mon, 29 Jul 2024 18:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE09C1F21D9B
	for <lists+linux-csky@lfdr.de>; Mon, 29 Jul 2024 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1BE15B11D;
	Mon, 29 Jul 2024 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFoaUtwf"
X-Original-To: linux-csky@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B2A158A1F;
	Mon, 29 Jul 2024 16:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722271180; cv=none; b=CIzOMneTb4J5vhTfMd9mu0rXjIeE0rv97pKhR+XVT+ZdXSlrtse3Gik99kJ+7KEAZbQyInoJdisQWGOkYJcH9z/5IVJevaN84Zm+tlKzPSRLJj3hqqEYdnmhpChMv6B9Nyar32nbAcB7w27fSet6e7z56f6gMRcM4cRZoKXRXPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722271180; c=relaxed/simple;
	bh=mNvXML5Nk4yWB83caFXu2jPWm4A4dReK0f5e32AqTwU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rRxgABLYNofrCek3SbnSEJG7w0kMzhj6M4XUUHkO2pzBEaEr50YXSVNa94tSTFF0GdaqMMp0kQ7rX83MKgVGc06H7w28WWYvQCDTQheIT0ZzBVQZFfteGZnZ41015kzZvXtwiOhcx1LAlM28QstE/uylBG2hjlNDOFw6OxoCn6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFoaUtwf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EAE1BC4AF0E;
	Mon, 29 Jul 2024 16:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722271180;
	bh=mNvXML5Nk4yWB83caFXu2jPWm4A4dReK0f5e32AqTwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YFoaUtwfPkoJfSSKHESCAmhmix7yJANDH3e6NCD2V1gwyJj+Lmj4VEPTAQvcG1wwa
	 1IR//NNVLaDgA4+bKqtuaon4VjXb3Pi8NIgBRWCdy+x0skAlMRiztQFYk+xP6Rv7KS
	 TphF5dMxBvS+A/yFC8il4awQtrLV3CcpYcwimga/rokLykHh3F38ffFGPwfaLgSzWF
	 s+irSv5UYKf06ktOA8g34jq33VkVLAeDgMs6cJVK2jB1tYyOvxIoakTdIvth10WEN6
	 b9Tju6W4OPwJdsBLWT9Z+3u8e9hmBsxZmBvPtrtGePw4P5+o7tKGPdA3YAHXPY3QEF
	 8R57Th8w623jg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D69CEC43638;
	Mon, 29 Jul 2024 16:39:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] vmalloc: Modify the alloc_vmap_area() error message for
  better diagnostics
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <172227117987.3603.11842142446691677565.git-patchwork-notify@kernel.org>
Date: Mon, 29 Jul 2024 16:39:39 +0000
References: <CH2PR01MB5894B0182EA0B28DF2EFB916F5C72@CH2PR01MB5894.prod.exchangelabs.com>
In-Reply-To: <CH2PR01MB5894B0182EA0B28DF2EFB916F5C72@CH2PR01MB5894.prod.exchangelabs.com>
To: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>
Cc: linux-riscv@lists.infradead.org,
 ampere-linux-kernel@lists.amperecomputing.com, urezki@gmail.com,
 linux-arm-kernel@lists.infradead.org, cl@linux.com, corbet@lwn.net,
 akpm@linux-foundation.org, linux-mm@kvack.org, guoren@kernel.org,
 linux-doc@vger.kernel.org, xiongwei.song@windriver.com,
 linux-csky@vger.kernel.org, willy@infradead.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Tue, 11 Jun 2024 19:38:44 +0000 you wrote:
> 'vmap allocation for size %lu failed: use vmalloc=<size> to increase size'
> The above warning is seen in the kernel functionality for allocation of the restricted virtual memory range till exhaustion.
> 
> This message is misleading because 'vmalloc=' is supported on arm32, x86 platforms and is not a valid kernel parameter on a number of other platforms (in particular its not supported on arm64, alpha, loongarch, arc, csky, hexagon, microblaze, mips, nios2, openrisc, parisc, m64k, powerpc, riscv, sh, um, xtensa, s390, sparc). With the update, the output gets modified to include the function parameters along with the start and end of the virtual memory range allowed.
> 
> The warning message after fix on kernel version 6.10.0-rc1+:
> 
> [...]

Here is the summary with links:
  - [v5] vmalloc: Modify the alloc_vmap_area() error message for better diagnostics
    https://git.kernel.org/riscv/c/55ccad6fc1a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



