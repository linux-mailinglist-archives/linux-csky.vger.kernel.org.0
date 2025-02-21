Return-Path: <linux-csky+bounces-1809-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0533BA3FA6A
	for <lists+linux-csky@lfdr.de>; Fri, 21 Feb 2025 17:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1AA019E3BC6
	for <lists+linux-csky@lfdr.de>; Fri, 21 Feb 2025 16:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C7F3215F77;
	Fri, 21 Feb 2025 16:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Wd3VgrGl"
X-Original-To: linux-csky@vger.kernel.org
Received: from smtp-8fab.mail.infomaniak.ch (smtp-8fab.mail.infomaniak.ch [83.166.143.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06871F1312
	for <linux-csky@vger.kernel.org>; Fri, 21 Feb 2025 16:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740153647; cv=none; b=CdFZDu87iQ2+WdmS02lAnWc93u5oEp6oxifdQYKX6Yj05NtpBFPPVLeSYx01iu7/sDEIjgLEhSmCZo91cq8szguEmoAR+1PTq/FQSqahp51n/dHbInBTOUlOVJcYk2fklXkpydFsk9uJptDqKnLX7CYZHAsp9KodcxHchhKUZMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740153647; c=relaxed/simple;
	bh=8JwxSrAkb49WD2mDErfKLvyH0/6S3kZaUGqW2G14m5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QsQNct8VwqZuCtqugIrRadCsckCoGFxrw1zA7c6bqTyxRLt/GMGwMtGvWB1IC5UEsxBQbrsSESmu3M50ae1dCrMo2h8lRbcRgJ9mHFTQrlJMUS5By6vHhTn9Q8HIFrtGiAXEe3HffH2AbzsBplDe/u6mf2+kSz8IP0q52NK/t/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Wd3VgrGl; arc=none smtp.client-ip=83.166.143.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Yzvx01MRfzhfX;
	Fri, 21 Feb 2025 17:00:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1740153636;
	bh=bzQREuWWWsR2CIYsAKZ/AYGR6t2UePv92kGxLbABb24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Wd3VgrGl6XF5Mb3O9V4H28Jc/XuZkOXkVlwUk6gWUIiGjwc5DMUVu/Viwn21aOl6p
	 7YGIL6b7a8D84nOQO/r2Rh0K6IoQ0TY+kB3OskTqKEVoyANhXyDRf82jrZKfoh25Q+
	 lAgYf5VQLnbtELW6PXW2op7t6A4vdKp1L2QVYRl8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Yzvwz4GQHzgjK;
	Fri, 21 Feb 2025 17:00:35 +0100 (CET)
Date: Fri, 21 Feb 2025 17:00:34 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Kees Cook <kees@kernel.org>, Guo Ren <guoren@kernel.org>
Cc: linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>, 
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org, 
	James Morris <jamorris@linux.microsoft.com>, Jann Horn <jannh@google.com>, linux-csky@vger.kernel.org, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
Subject: Re: security/landlock/ruleset.c:96:9: warning: 'memcpy' accessing
 4294967295 bytes at offsets 20 and 0 overlaps 6442450943 bytes at offset
 -2147483648
Message-ID: <20250221.ga2OSh6ieZei@digikod.net>
References: <202501040747.S3LYfvYq-lkp@intel.com>
 <20250106.uu8as0Ha6pof@digikod.net>
 <202501061623.7A617B09@keescook>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202501061623.7A617B09@keescook>
X-Infomaniak-Routing: alpha

Cc csky developers.

See https://lore.kernel.org/r/202501040747.S3LYfvYq-lkp@intel.com

On Mon, Jan 06, 2025 at 04:27:26PM -0800, Kees Cook wrote:
> On Mon, Jan 06, 2025 at 06:04:56PM +0100, Mickaël Salaün wrote:
> > On Sat, Jan 04, 2025 at 07:26:27AM +0800, kernel test robot wrote:
> > >    security/landlock/ruleset.c: In function 'create_rule':
> > > >> security/landlock/ruleset.c:96:9: warning: 'memcpy' accessing 4294967295 bytes at offsets 20 and 0 overlaps 6442450943 bytes at offset -2147483648 [-Wrestrict]
> > >       96 |         memcpy(new_rule->layers, layers,
> > >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >       97 |                         flex_array_size(new_rule, layers, num_layers));
> > >          |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

This warning seems to only show with the csky architecture.

> >
> > I guess the GCC warning is a false positive?
> > See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=116494
> 
> Does the warning go away if flex_array_size() is open-coded or if the
> create_rule prototype uses "*" instead of "[]" syntax for the "layers"
> argument?

But that would not be correct right?

> 
> The warning is about the "read" part ("accessing"). Using tip-of-tree
> gcc with -fdiagnostics-details might show more details on the calling
> path.
> 
> -Kees
> 
> -- 
> Kees Cook
> 

