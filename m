Return-Path: <linux-csky+bounces-1050-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37364997E73
	for <lists+linux-csky@lfdr.de>; Thu, 10 Oct 2024 09:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80EF1F21668
	for <lists+linux-csky@lfdr.de>; Thu, 10 Oct 2024 07:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E391C3315;
	Thu, 10 Oct 2024 07:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oR2MBOmC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OLc0/Izc"
X-Original-To: linux-csky@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54BD01BFE0B;
	Thu, 10 Oct 2024 07:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728543734; cv=none; b=TjYwVOX/gL/KqJLHRjVk9gJUak6kKqdm+9XVEG8qxgDPPkWAorJJPic09OkwwCpSfn/7fk4pj39FL8tKTJpXxrhF4PxyH0qiQ3H6zFOn4mS/XFg+uzHMUttV2ZUrM5yOKNAKS1CV8Pq5TUI0zyJYOxMUmZC8mXf2lyMmYBJE/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728543734; c=relaxed/simple;
	bh=5q/oYmCSAPWM0DZS09Zn4vubsvf/hAs/b2wMHxglk/E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oo6e2aypyaNuYaifPmGYg27JUyShFBxgv5/gXPu4Z4+kI2b0eW3N7XuTZbSzez0F/kCg474F26tvyPvHdgo3jTjEOAwUUvRjvBMQvx0uy+JEYV+3dE9czfZyK/5UcM3Uq3msHNQkUe5DCibF28GyKmevwJzr6Il8QQq6/UAcpyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oR2MBOmC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OLc0/Izc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728543729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o80BJ2ePq/KTeWTph/dk3r0TbxIJWIzYIWjc4f8IPAY=;
	b=oR2MBOmC8kYuKrHMx461FC2+cUPMhFJ6D1VRIgry34xBIrBo+VzVzj6Q1kbJMDxDxrpM5w
	BibcvUOsfhxeZFqpFe7Dz3h4X9VmsWB+vh6eXtf185bxeWUSTPYSPnpDOtrmjGGOB1FDvs
	80mXlYYzDOGq/4GWwybYZvhu3a/zol6Hvqcy+5MBkQyVqNu1DBjnxzOXgUCaq8o8B/78/V
	H7bArnDGZnvw8As8rr6shQ5aoLBScYPP5T7h7+yRqkBGpCGZCOy6eSgicp2xIEJpc5BP88
	ku3YK6VW/Ygn+VBqB6hc3nhQ87EUtji+qTi8KCJp0BaEUuuX+AG1zT0Wpqpi0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728543729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o80BJ2ePq/KTeWTph/dk3r0TbxIJWIzYIWjc4f8IPAY=;
	b=OLc0/IzcI1/Q0xfn6++5SSfFHZnsZswl+T5N39o23MMYsZ/2b515TSBPnlXG7UYDBAK8nH
	0W/YxVH5uAC0RrCA==
Date: Thu, 10 Oct 2024 09:01:17 +0200
Subject: [PATCH 15/28] x86: vdso: Access timens vdso data without vvar.h
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-vdso-generic-base-v1-15-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-0-b64f0842d512@linutronix.de>
In-Reply-To: <20241010-vdso-generic-base-v1-0-b64f0842d512@linutronix.de>
To: Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Russell King <linux@armlinux.org.uk>, Huacai Chen <chenhuacai@kernel.org>, 
 WANG Xuerui <kernel@xen0n.name>, Theodore Ts'o <tytso@mit.edu>, 
 "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>, 
 linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-riscv@lists.infradead.org, loongarch@lists.linux.dev, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728543717; l=2753;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=5q/oYmCSAPWM0DZS09Zn4vubsvf/hAs/b2wMHxglk/E=;
 b=kReKc4w+yDADDmj9s544US9VPVSloE8UMIfnmrPa7aAdPH4ejj+L3bd9L+1xbmEfjoHrX8qSs
 maEyo7KotmKA6M0V/aylVq3f/Ugs1ZBlarmgyjV66OmOTx3DXEQv6Uj
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The vdso_data is at the start of the timens page.
Make use of this invariant to remove the usage of vvar.h.
This also matches the logic for the pvclock and hvclock pages.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/x86/entry/vdso/vdso-layout.lds.S    | 6 ------
 arch/x86/include/asm/vdso/getrandom.h    | 2 +-
 arch/x86/include/asm/vdso/gettimeofday.h | 6 ++++--
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso-layout.lds.S
index bafa73f09e9285fbf29cf3f73e13b6d92df2f376..51c0cc0119748dda0f29d577197c520f272fd02f 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -28,12 +28,6 @@ SECTIONS
 	hvclock_page = vvar_start + 2 * PAGE_SIZE;
 	timens_page  = vvar_start + 3 * PAGE_SIZE;
 
-#undef _ASM_X86_VVAR_H
-	/* Place all vvars in timens too at the offsets in asm/vvar.h. */
-#define EMIT_VVAR(name, offset) timens_ ## name = timens_page + offset;
-#include <asm/vvar.h>
-#undef EMIT_VVAR
-
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vdso/getrandom.h
index ecdcdbcd3392533e5619d7f09403d60a9810ceab..d0713c829254cc8172c5903a1fdba168b52ff1ea 100644
--- a/arch/x86/include/asm/vdso/getrandom.h
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -33,7 +33,7 @@ static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsig
 static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
 {
 	if (IS_ENABLED(CONFIG_TIME_NS) && __arch_get_vdso_data()->clock_mode == VDSO_CLOCKMODE_TIMENS)
-		return (void *)&__vdso_rng_data + ((void *)&__timens_vdso_data - (void *)__arch_get_vdso_data());
+		return (void *)&__vdso_rng_data + ((void *)&timens_page - (void *)__arch_get_vdso_data());
 	return &__vdso_rng_data;
 }
 
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index b2d2df026f6e707b8164d8842c33edea9a658466..1e6116172a65cd07ef29092dba6241d719f07448 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -21,7 +21,9 @@
 #include <clocksource/hyperv_timer.h>
 
 #define __vdso_data (VVAR(_vdso_data))
-#define __timens_vdso_data (TIMENS(_vdso_data))
+
+extern struct vdso_data timens_page
+	__attribute__((visibility("hidden")));
 
 #define VDSO_HAS_TIME 1
 
@@ -61,7 +63,7 @@ extern struct ms_hyperv_tsc_page hvclock_page
 static __always_inline
 const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
 {
-	return __timens_vdso_data;
+	return &timens_page;
 }
 #endif
 

-- 
2.47.0


