Return-Path: <linux-csky+bounces-1648-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C94A0B528
	for <lists+linux-csky@lfdr.de>; Mon, 13 Jan 2025 12:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D1E3A2DD7
	for <lists+linux-csky@lfdr.de>; Mon, 13 Jan 2025 11:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2274821ADBA;
	Mon, 13 Jan 2025 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QyUDxo68"
X-Original-To: linux-csky@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F44187554;
	Mon, 13 Jan 2025 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736766683; cv=none; b=Ywv/nPpmIafdiydBuhEHJXT5nk5EGDr80OSeYKwPmlMLDrhDHjWarw0/PgS4PUQGLLVknqS9HBcQZ4Nyl/Ksm8OlE8PETBrzPHWXYF+V/ZqMJ+sUSBFO3giHL/669RpbpGihVezOkVMYcIxiFCGOyW3c1EnoK6v1xMbjR1ZeeNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736766683; c=relaxed/simple;
	bh=ONKN8fq0iP0VC62UEpQtN5Nmm165/LMTCyM9flI8nJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NdSlismQnPk2L1Bcyx47XceufHVyS0FCLCykC+UJS1M8PoUz1jU/hCbFZuWUL0OwMRHht/DIVSnUlnsVR2Frhmv7mcaMaqGt3gk7ROmJg07GcgAj0aWc/yKlIN8DyfJbSWr7nOOk+9MiXdtTjuDT+kPcWRIqPLqfSjALNidS88s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QyUDxo68; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=qj0XqtoExeVFzH/0zurjfq7xU6GfRici48V+bRozJOU=; b=QyUDxo6884XncYuqYHzTOCqFhP
	MJCHu9a4GRwdc2gzh5B2GGjOVCLjQQf/G/U7qmHwI17hAY1iN75xRQXZxeLGWu2r1IqKnZpyhJLDh
	hIuO5PZHdwSPf5wZW6TqT3qcud0nyXMDVNWDhVWthft1Bnu+Kcj3mv+vxETbGCx0QJOf9qMcwsms+
	nqHs/Wgi5QapoBbNUV5Co3c/+0Nu0ObKp+3f0PdvoSv/EyJ2MD7vobCUSztpqsbNNqvMOm1sEmva6
	MTgfeJGjb7Ed6OquAEAdfsZxBI82GyxEwWFFo9IdPl3Yqv95YLHEjIJQwF7fzvfeJC+e9a3V3YyCz
	FdRvrBKQ==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXILk-0000000AHYu-4BnK;
	Mon, 13 Jan 2025 11:11:18 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 27A6730057A; Mon, 13 Jan 2025 12:11:16 +0100 (CET)
Date: Mon, 13 Jan 2025 12:11:16 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Mike Rapoport <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>, Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>, Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org, linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.or
Subject: Re: [REGRESSION] Re: [PATCH v7 8/8] x86/module: enable ROX caches
 for module text on 64 bit
Message-ID: <20250113111116.GF5388@noisy.programming.kicks-ass.net>
References: <20241023162711.2579610-1-rppt@kernel.org>
 <20241023162711.2579610-9-rppt@kernel.org>
 <Z4QM_RFfhNX_li_C@intel.com>
 <20250112190755.GCZ4QTC01KzoZkxel9@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250112190755.GCZ4QTC01KzoZkxel9@fat_crate.local>

On Sun, Jan 12, 2025 at 08:07:55PM +0100, Borislav Petkov wrote:
> On Sun, Jan 12, 2025 at 08:42:05PM +0200, Ville Syrj�l� wrote:
> > On Wed, Oct 23, 2024 at 07:27:11PM +0300, Mike Rapoport wrote:
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > 
> > > Enable execmem's cache of PMD_SIZE'ed pages mapped as ROX for module
> > > text allocations on 64 bit.
> > 
> > Hi,
> > 
> > This breaks resume from hibernation on my Alderlake laptop.
> > 
> > Fortunately this still reverts cleanly.
> 
> Does that hunk in the mail here fix it?
> 
> https://lore.kernel.org/all/Z4DwPkcYyZ-tDKwY@kernel.org/

There's definiltely breakage with that module_writable_address()
nonsense in alternative.c that will not be fixed by that patch.

The very simplest thing at this point is to remove:

     select ARCH_HAS_EXECMEM_ROX             if X86_64

and try again next cycle.

