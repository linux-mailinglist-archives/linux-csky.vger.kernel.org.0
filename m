Return-Path: <linux-csky+bounces-1737-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 797DAA27194
	for <lists+linux-csky@lfdr.de>; Tue,  4 Feb 2025 13:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1140C3A8C41
	for <lists+linux-csky@lfdr.de>; Tue,  4 Feb 2025 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6044D21518B;
	Tue,  4 Feb 2025 12:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j8O5lBTr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ucf0NI2O"
X-Original-To: linux-csky@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD77214A66;
	Tue,  4 Feb 2025 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670780; cv=none; b=FWelfJu7N2KO3K+6MmXzOWhfNgBX+s2h7rGH+B3c0w4s9p8OVy2tZIWjqjeFj0+pyx0MdAd37zeTU5k89aC6Vtkl0Hlr/QvL9KKndy8zbZaLUnqs12mKU5aqnleQxdzOPoPClcqgMm3BYf7gHrJujECQYi5epPso1yS4cUJku+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670780; c=relaxed/simple;
	bh=9mw6+quxmYnXLXlPlZBIMBuVEVcqiJaeRocCVcQo98g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wwin78Qvplt3YRt0UGEbxC0OVfSPx+UJe0UKkoZZTs59zqWDHZplYu0+ptRGc4aMevKyDx+05Kko81eqnvpdaEomImQVileSklnOX5fwPCTm0dpelKMmtrAajTx6fmVTv3xvg6hbaOvkGxvqZyF5fHdRZuY50cUDBcn+KErz0iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j8O5lBTr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ucf0NI2O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738670773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vRuMazrLpos+TaDtFLXd19bBjq9G0tAifyVZPHoRtg=;
	b=j8O5lBTrF8i6zCTWaIDwdV+lT/eN9lrJaYDaehgZ6vWXIc7eAqLr988XEuYFOSyvsYzWT9
	6T8pdCx+/A04HMCm/mk6eKobAlQIewezjiFx3pUacT9/IKUgoi4EnY868Qb7rW9SC3G1zE
	p+nv39YwXM2iMfq7BrB0x6wOMwMiW8UyJF+9SDgbV1Y9F/F/phXq71qT0LVZgSajID+fa+
	VQUulE8aZ/JY/UzKWbuxwxGyQmuTJ2TG8jZnj06Av0WYaXMMQCvbsTwwOwhRzocDdwUpTl
	5mLWIV80gMDrhQsb18rhfrhVV7KhKC8N8LrZriGnIF4eyoDhy6l8RN7k2E7Twg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738670773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5vRuMazrLpos+TaDtFLXd19bBjq9G0tAifyVZPHoRtg=;
	b=ucf0NI2Oniv2a/aV+aWCsg5rDVU19E1gGx0did5kSU3eOaK7BWDF7pRmMxgx9/Il0YgutJ
	4jupsJ0uwnCbvrCQ==
Date: Tue, 04 Feb 2025 13:05:44 +0100
Subject: [PATCH v3 12/18] s390/vdso: Switch to generic storage
 implementation
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250204-vdso-store-rng-v3-12-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de>
In-Reply-To: <20250204-vdso-store-rng-v3-0-13a4669dfc8c@linutronix.de>
To: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 Helge Deller <deller@gmx.de>, Andy Lutomirski <luto@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Theodore Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Russell King <linux@armlinux.org.uk>, Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>, 
 Guo Ren <guoren@kernel.org>
Cc: linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org, 
 loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
 linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-arch@vger.kernel.org, Nam Cao <namcao@linutronix.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 linux-csky@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738670761; l=12301;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=9mw6+quxmYnXLXlPlZBIMBuVEVcqiJaeRocCVcQo98g=;
 b=A7ulOt7+haU45eZJviaqkd+djCKUX+BaKJo7Q8NfUCMk6pN9ZGNQVHHFcI23coAVZxeCXiPhZ
 KM/h5oNuy57ACfaiWwkD1p63n7qtyXFw080+tQQwyXj7RVmI3ZCavBD
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic storage implementation provides the same features as the
custom one. However it can be shared between architectures, making
maintenance easier.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig                         |  1 +
 arch/s390/include/asm/vdso.h              |  4 +-
 arch/s390/include/asm/vdso/getrandom.h    | 12 ----
 arch/s390/include/asm/vdso/gettimeofday.h | 15 +----
 arch/s390/include/asm/vdso/vsyscall.h     | 20 -------
 arch/s390/kernel/time.c                   |  6 +-
 arch/s390/kernel/vdso.c                   | 97 ++-----------------------------
 arch/s390/kernel/vdso32/vdso32.lds.S      |  7 +--
 arch/s390/kernel/vdso64/vdso64.lds.S      |  8 +--
 9 files changed, 17 insertions(+), 153 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9c9ec08d78c71b4d227beeafab1b82d6434cb5c7..7ed6f229250cf6c26efd4ce30e23123cdb030b2c 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -166,6 +166,7 @@ config S390
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GENERIC_IOREMAP if PCI
 	select HAVE_ALIGNED_STRUCT_PAGE
diff --git a/arch/s390/include/asm/vdso.h b/arch/s390/include/asm/vdso.h
index 92c73e4d97a93a90cb640d44fca9856f93e0be14..420a073fdde5db92cfe84bb1f17a549f333f94e0 100644
--- a/arch/s390/include/asm/vdso.h
+++ b/arch/s390/include/asm/vdso.h
@@ -6,13 +6,11 @@
 
 #ifndef __ASSEMBLY__
 
-extern struct vdso_data *vdso_data;
-
 int vdso_getcpu_init(void);
 
 #endif /* __ASSEMBLY__ */
 
-#define __VVAR_PAGES	2
+#define __VDSO_PAGES	4
 
 #define VDSO_VERSION_STRING	LINUX_2.6.29
 
diff --git a/arch/s390/include/asm/vdso/getrandom.h b/arch/s390/include/asm/vdso/getrandom.h
index 36355af7160bee4f04f5177cfa21283699bee006..f8713ce39bb2f2081c3bb5a42eddccc3cddc40c8 100644
--- a/arch/s390/include/asm/vdso/getrandom.h
+++ b/arch/s390/include/asm/vdso/getrandom.h
@@ -23,18 +23,6 @@ static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsig
 	return syscall3(__NR_getrandom, (long)buffer, (long)len, (long)flags);
 }
 
-static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
-{
-	/*
-	 * The RNG data is in the real VVAR data page, but if a task belongs to a time namespace
-	 * then VVAR_DATA_PAGE_OFFSET points to the namespace-specific VVAR page and VVAR_TIMENS_
-	 * PAGE_OFFSET points to the real VVAR page.
-	 */
-	if (IS_ENABLED(CONFIG_TIME_NS) && _vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
-		return (void *)&_vdso_rng_data + VVAR_TIMENS_PAGE_OFFSET * PAGE_SIZE;
-	return &_vdso_rng_data;
-}
-
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/s390/include/asm/vdso/gettimeofday.h b/arch/s390/include/asm/vdso/gettimeofday.h
index 7937765ccfa5b222931591cc5388827e5f75d1b5..fb4564308e9d77a40f8d5059503519e9f5961f14 100644
--- a/arch/s390/include/asm/vdso/gettimeofday.h
+++ b/arch/s390/include/asm/vdso/gettimeofday.h
@@ -14,12 +14,7 @@
 #include <linux/compiler.h>
 
 
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return _vdso_data;
-}
-
-static inline u64 __arch_get_hw_counter(s32 clock_mode, const struct vdso_data *vd)
+static inline u64 __arch_get_hw_counter(s32 clock_mode, const struct vdso_time_data *vd)
 {
 	u64 adj, now;
 
@@ -49,12 +44,4 @@ long clock_getres_fallback(clockid_t clkid, struct __kernel_timespec *ts)
 	return syscall2(__NR_clock_getres, (long)clkid, (long)ts);
 }
 
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *vd)
-{
-	return _timens_data;
-}
-#endif
-
 #endif
diff --git a/arch/s390/include/asm/vdso/vsyscall.h b/arch/s390/include/asm/vdso/vsyscall.h
index 3eb576ecd3bd998daf9372a52befa8b76d52f2bf..d346ebe513015e767405452cd69495ae497c91ee 100644
--- a/arch/s390/include/asm/vdso/vsyscall.h
+++ b/arch/s390/include/asm/vdso/vsyscall.h
@@ -2,32 +2,12 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
 
-#define __VDSO_RND_DATA_OFFSET	768
-
 #ifndef __ASSEMBLY__
 
 #include <linux/hrtimer.h>
 #include <vdso/datapage.h>
 #include <asm/vdso.h>
 
-enum vvar_pages {
-	VVAR_DATA_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_NR_PAGES
-};
-
-static __always_inline struct vdso_data *__s390_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __s390_get_k_vdso_data
-
-static __always_inline struct vdso_rng_data *__s390_get_k_vdso_rnd_data(void)
-{
-	return (void *)vdso_data + __VDSO_RND_DATA_OFFSET;
-}
-#define __arch_get_k_vdso_rng_data __s390_get_k_vdso_rnd_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
 
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index e9f47c3a61978a45c72aee23bc44dcb128113c8c..41ca3586b19f6cac3753b52f0b99be62a33e1cb1 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -84,7 +84,7 @@ void __init time_early_init(void)
 	/* Initialize TOD steering parameters */
 	tod_steering_end = tod_clock_base.tod;
 	for (cs = 0; cs < CS_BASES; cs++)
-		vdso_data[cs].arch_data.tod_steering_end = tod_steering_end;
+		vdso_k_time_data[cs].arch_data.tod_steering_end = tod_steering_end;
 
 	if (!test_facility(28))
 		return;
@@ -390,8 +390,8 @@ static void clock_sync_global(long delta)
 		      tod_steering_delta);
 	tod_steering_end = now + (abs(tod_steering_delta) << 15);
 	for (cs = 0; cs < CS_BASES; cs++) {
-		vdso_data[cs].arch_data.tod_steering_end = tod_steering_end;
-		vdso_data[cs].arch_data.tod_steering_delta = tod_steering_delta;
+		vdso_k_time_data[cs].arch_data.tod_steering_end = tod_steering_end;
+		vdso_k_time_data[cs].arch_data.tod_steering_delta = tod_steering_delta;
 	}
 
 	/* Update LPAR offset. */
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 598b512cde012b1857c748042ceeea65b54cb92f..70c8f9ad13cde96f0f307213bacb671b818f628b 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -16,8 +16,8 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
-#include <linux/time_namespace.h>
 #include <linux/random.h>
+#include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
 #include <asm/vdso/vsyscall.h>
 #include <asm/alternative.h>
@@ -26,85 +26,6 @@
 extern char vdso64_start[], vdso64_end[];
 extern char vdso32_start[], vdso32_end[];
 
-static struct vm_special_mapping vvar_mapping;
-
-static union vdso_data_store vdso_data_store __page_aligned_data;
-
-struct vdso_data *vdso_data = vdso_data_store.data;
-
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)(vvar_page);
-}
-
-/*
- * The VVAR page layout depends on whether a task belongs to the root or
- * non-root time namespace. Whenever a task changes its namespace, the VVAR
- * page tables are cleared and then they will be re-faulted with a
- * corresponding layout.
- * See also the comment near timens_setup_vdso_data() for details.
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm = task->mm;
-	VMA_ITERATOR(vmi, mm, 0);
-	struct vm_area_struct *vma;
-
-	mmap_read_lock(mm);
-	for_each_vma(vmi, vma) {
-		if (!vma_is_special_mapping(vma, &vvar_mapping))
-			continue;
-		zap_vma_pages(vma);
-		break;
-	}
-	mmap_read_unlock(mm);
-	return 0;
-}
-#endif
-
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-			     struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	struct page *timens_page = find_timens_vvar_page(vma);
-	unsigned long addr, pfn;
-	vm_fault_t err;
-
-	switch (vmf->pgoff) {
-	case VVAR_DATA_PAGE_OFFSET:
-		pfn = virt_to_pfn(vdso_data);
-		if (timens_page) {
-			/*
-			 * Fault in VVAR page too, since it will be accessed
-			 * to get clock data anyway.
-			 */
-			addr = vmf->address + VVAR_TIMENS_PAGE_OFFSET * PAGE_SIZE;
-			err = vmf_insert_pfn(vma, addr, pfn);
-			if (unlikely(err & VM_FAULT_ERROR))
-				return err;
-			pfn = page_to_pfn(timens_page);
-		}
-		break;
-#ifdef CONFIG_TIME_NS
-	case VVAR_TIMENS_PAGE_OFFSET:
-		/*
-		 * If a task belongs to a time namespace then a namespace
-		 * specific VVAR is mapped with the VVAR_DATA_PAGE_OFFSET and
-		 * the real VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET
-		 * offset.
-		 * See also the comment near timens_setup_vdso_data().
-		 */
-		if (!timens_page)
-			return VM_FAULT_SIGBUS;
-		pfn = virt_to_pfn(vdso_data);
-		break;
-#endif /* CONFIG_TIME_NS */
-	default:
-		return VM_FAULT_SIGBUS;
-	}
-	return vmf_insert_pfn(vma, vmf->address, pfn);
-}
-
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		       struct vm_area_struct *vma)
 {
@@ -112,11 +33,6 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
 
-static struct vm_special_mapping vvar_mapping = {
-	.name = "[vvar]",
-	.fault = vvar_fault,
-};
-
 static struct vm_special_mapping vdso64_mapping = {
 	.name = "[vdso]",
 	.mremap = vdso_mremap,
@@ -142,7 +58,7 @@ static int map_vdso(unsigned long addr, unsigned long vdso_mapping_len)
 	struct vm_area_struct *vma;
 	int rc;
 
-	BUILD_BUG_ON(VVAR_NR_PAGES != __VVAR_PAGES);
+	BUILD_BUG_ON(VDSO_NR_PAGES != __VDSO_PAGES);
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
@@ -157,14 +73,11 @@ static int map_vdso(unsigned long addr, unsigned long vdso_mapping_len)
 	rc = vvar_start;
 	if (IS_ERR_VALUE(vvar_start))
 		goto out;
-	vma = _install_special_mapping(mm, vvar_start, VVAR_NR_PAGES*PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
-				       &vvar_mapping);
+	vma = vdso_install_vvar_mapping(mm, vvar_start);
 	rc = PTR_ERR(vma);
 	if (IS_ERR(vma))
 		goto out;
-	vdso_text_start = vvar_start + VVAR_NR_PAGES * PAGE_SIZE;
+	vdso_text_start = vvar_start + VDSO_NR_PAGES * PAGE_SIZE;
 	/* VM_MAYWRITE for COW so gdb can set breakpoints */
 	vma = _install_special_mapping(mm, vdso_text_start, vdso_text_len,
 				       VM_READ|VM_EXEC|
@@ -220,7 +133,7 @@ unsigned long vdso_text_size(void)
 
 unsigned long vdso_size(void)
 {
-	return vdso_text_size() + VVAR_NR_PAGES * PAGE_SIZE;
+	return vdso_text_size() + VDSO_NR_PAGES * PAGE_SIZE;
 }
 
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
diff --git a/arch/s390/kernel/vdso32/vdso32.lds.S b/arch/s390/kernel/vdso32/vdso32.lds.S
index c916c4f73f766ebcc9328b189e46015e67393b0d..9630d58c20806b51f3a2f3b59a53409ad6d3508f 100644
--- a/arch/s390/kernel/vdso32/vdso32.lds.S
+++ b/arch/s390/kernel/vdso32/vdso32.lds.S
@@ -6,16 +6,15 @@
 
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
 
 OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
 OUTPUT_ARCH(s390:31-bit)
 
 SECTIONS
 {
-	PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
-#ifdef CONFIG_TIME_NS
-	PROVIDE(_timens_data = _vdso_data + PAGE_SIZE);
-#endif
+	VDSO_VVAR_SYMS
+
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
diff --git a/arch/s390/kernel/vdso64/vdso64.lds.S b/arch/s390/kernel/vdso64/vdso64.lds.S
index ec42b7d9cb53094b783c6b0492962af7e5027831..e4f6551ae898881baff6d37701a9d8d9188a52cc 100644
--- a/arch/s390/kernel/vdso64/vdso64.lds.S
+++ b/arch/s390/kernel/vdso64/vdso64.lds.S
@@ -7,17 +7,15 @@
 #include <asm/vdso/vsyscall.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
 
 OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
 OUTPUT_ARCH(s390:64-bit)
 
 SECTIONS
 {
-	PROVIDE(_vdso_data = . - __VVAR_PAGES * PAGE_SIZE);
-	PROVIDE(_vdso_rng_data = _vdso_data + __VDSO_RND_DATA_OFFSET);
-#ifdef CONFIG_TIME_NS
-	PROVIDE(_timens_data = _vdso_data + PAGE_SIZE);
-#endif
+	VDSO_VVAR_SYMS
+
 	. = SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text

-- 
2.48.1


