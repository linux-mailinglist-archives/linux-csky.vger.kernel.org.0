Return-Path: <linux-csky+bounces-903-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDC69893BF
	for <lists+linux-csky@lfdr.de>; Sun, 29 Sep 2024 10:26:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3480C1C21338
	for <lists+linux-csky@lfdr.de>; Sun, 29 Sep 2024 08:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08DC13B29B;
	Sun, 29 Sep 2024 08:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="EXIVItjx"
X-Original-To: linux-csky@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0581E4B0
	for <linux-csky@vger.kernel.org>; Sun, 29 Sep 2024 08:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727598371; cv=none; b=UXYJ2GXoz4+hiyXV99jOQ7MAmoOMrx6bFktxsW6w/HKSJjZFdnAkqJewDoTMczObH6dAcnNYdZqQWRTSIUxqFTHtMh/Ghkit0tlSkRv9Czhrr2ll8Xocn83L24ITLdArZjLPLdY4RElPmpdMNfOkOAWVUUnJqE8ZLcjWWWTzdm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727598371; c=relaxed/simple;
	bh=uKkmgsVXzVAyPJSJMRLAmmBWnVUdzjLfm4uBg816XnE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Vu16h9naNkmSbGns7GYhffKLMwg6tJF/L90D17/HJ5XMFw10nnrVh0dQnyOL3zZg/0kyvmsBGPsL8iQ+JpFpaIqN5+VM77cZTSLE39PafuQKwJ6HBmT9e37KSNOK/yvk98W2nNZsW9LmDqUhe8TQ0BdvfEIRQ9GWMZlu3U0u8VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=EXIVItjx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1727597846; bh=uKkmgsVXzVAyPJSJMRLAmmBWnVUdzjLfm4uBg816XnE=;
	h=Date:From:To:Cc:Subject:From;
	b=EXIVItjxP/30JiULOavGnIqoKJVgMZ0Nc9LKXt7w4OTq52UA+UPHuXl2JGCT3XxQV
	 578RVao2doJ9xqgKamnUIGDkNo3IrFfYKpiQdOWCkmzKdC6eB9wZjrxxYSpIwWv9nS
	 15thnhkHQbm4OyiRyWz9jtvBJjf82UNUIKmAceUA=
Date: Sun, 29 Sep 2024 10:17:26 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Subject: [BUG?] csky: qemu-user: swapped syscall numbers for getppid and
 rt_sigreturn
Message-ID: <2fa3151f-5aab-406c-95d9-add398ae58b3@t-8ch.de>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Guo Ren,

it seems the values of __NR_rt_sigreturn and __NR_getppid are swapped
between csky qemu-user and the kernel.

In qemu-user [0, 1]:
(With context to show the disconuity)

#define TARGET_NR_rt_sigqueueinfo 138
--> #define TARGET_NR_rt_sigreturn 173
#define TARGET_NR_setpriority 140

#define TARGET_NR_getpid 172
--> #define TARGET_NR_getppid 139
#define TARGET_NR_getuid 174

The mainline kernel however uses the generic syscall numbers:

#define __NR_rt_sigreturn 139
#define __NR_getppid 173

Is this intentional? If so, what am I supposed to do about it?


While we are here:

Is there a known bug about upstream gcc 14.2.0 (and earlier) loosing
track of registers, especially r4, during optimizations?
It seems to me that this register gets overwritten sometimes before it
is meant to be used.


Thanks,
Thomas


[0] https://raw.githubusercontent.com/XUANTIE-RV/qemu/refs/heads/xuantie-qemu-6.1.0/linux-user/csky/syscall_nr.h
[1] https://raw.githubusercontent.com/XUANTIE-RV/qemu/refs/heads/xuantie-qemu-8.0/linux-user/csky/syscall_nr.h

