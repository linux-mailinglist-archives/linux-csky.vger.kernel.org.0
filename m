Return-Path: <linux-csky+bounces-1018-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8343B99744A
	for <lists+linux-csky@lfdr.de>; Wed,  9 Oct 2024 20:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6645A1C22146
	for <lists+linux-csky@lfdr.de>; Wed,  9 Oct 2024 18:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274BD1E1C3A;
	Wed,  9 Oct 2024 18:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EtIHaeJw"
X-Original-To: linux-csky@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE1D1E1C11;
	Wed,  9 Oct 2024 18:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728497344; cv=none; b=UZFb0ryr/+IZBi0RCVOdAjkdTF+UDTptb9va+q39OiMC+OqnffGjFpVkXyHYThd3dIvsNBPZHR7JZAJ/xefWRL3uvbrCNWzOZ66TGKgU0K8nHiDJvWR1NjC1clJ/bqdw8WlnkNFcf87AxnItOyyoF3kC6M7bRraiZiInMCAVRT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728497344; c=relaxed/simple;
	bh=YllkjQvsWrr6dQbJlUjRUABqghggyZA8loEEeE76mk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kwm8dcfz9uTqvWoW6vEEo2ruonObkTJGkV8gU0b6/YoDibxM7OaOd4Vcae0HSpxxOfuNpXVU3A5yMUbyeXjoyjDxwXjlfUMs+wYByXQDscDcdmpFipTHBifi7fCQtEGkhIb1k4R+gpwvak1Sbkr3+wsKonxECvxcR8Qc4MAOba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EtIHaeJw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9B2C4CED5;
	Wed,  9 Oct 2024 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728497343;
	bh=YllkjQvsWrr6dQbJlUjRUABqghggyZA8loEEeE76mk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EtIHaeJwWAoCvtdCbCxK9EeVGERQLZ46T6d38Orf178juX3xbiSVV8C3zYclZ4a3D
	 iQGTL7fyxijvASXlADNp0ip35EijAZNvymeSHSlBE7F8/8U3Mq9Tuxp8gd8Z53SVKP
	 jQyccxNQ7+RAC8iWXR6z8qN0YJsNLLOZQt2zaftoVyBlufZugSbmIopLnXL+TWEQ8l
	 N+2zP4nbxkV+aY4tzK+NbxMTpI7TBse9dp+Uk4EIirxkfVkGCCEWl/7ZBwXGJluB38
	 3RWErEhT/fiA5UNNDAn1/JNzpTyjVpUE73YLkc9wCI1OJbQMDeJCSrnnfCiQEcJMPY
	 Zt9wg5wAM+50Q==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v5 1/8] mm: vmalloc: group declarations depending on CONFIG_MMU together
Date: Wed,  9 Oct 2024 21:08:09 +0300
Message-ID: <20241009180816.83591-2-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009180816.83591-1-rppt@kernel.org>
References: <20241009180816.83591-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

There are a couple of declarations that depend on CONFIG_MMU in
include/linux/vmalloc.h spread all over the file.

Group them all together to improve code readability.

No functional changes.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/vmalloc.h | 60 +++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index ad2ce7a6ab7a..9a012cd4fad2 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -134,12 +134,6 @@ extern void vm_unmap_ram(const void *mem, unsigned int count);
 extern void *vm_map_ram(struct page **pages, unsigned int count, int node);
 extern void vm_unmap_aliases(void);
 
-#ifdef CONFIG_MMU
-extern unsigned long vmalloc_nr_pages(void);
-#else
-static inline unsigned long vmalloc_nr_pages(void) { return 0; }
-#endif
-
 extern void *vmalloc_noprof(unsigned long size) __alloc_size(1);
 #define vmalloc(...)		alloc_hooks(vmalloc_noprof(__VA_ARGS__))
 
@@ -266,12 +260,29 @@ static inline bool is_vm_area_hugepages(const void *addr)
 #endif
 }
 
+/* for /proc/kcore */
+extern long vread_iter(struct iov_iter *iter, const char *addr, size_t count);
+
+/*
+ *	Internals.  Don't use..
+ */
+extern __init void vm_area_add_early(struct vm_struct *vm);
+extern __init void vm_area_register_early(struct vm_struct *vm, size_t align);
+
+int register_vmap_purge_notifier(struct notifier_block *nb);
+int unregister_vmap_purge_notifier(struct notifier_block *nb);
+
 #ifdef CONFIG_MMU
+#define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
+
+extern unsigned long vmalloc_nr_pages(void);
+
 int vm_area_map_pages(struct vm_struct *area, unsigned long start,
 		      unsigned long end, struct page **pages);
 void vm_area_unmap_pages(struct vm_struct *area, unsigned long start,
 			 unsigned long end);
 void vunmap_range(unsigned long addr, unsigned long end);
+
 static inline void set_vm_flush_reset_perms(void *addr)
 {
 	struct vm_struct *vm = find_vm_area(addr);
@@ -279,24 +290,14 @@ static inline void set_vm_flush_reset_perms(void *addr)
 	if (vm)
 		vm->flags |= VM_FLUSH_RESET_PERMS;
 }
+#else  /* !CONFIG_MMU */
+#define VMALLOC_TOTAL 0UL
 
-#else
-static inline void set_vm_flush_reset_perms(void *addr)
-{
-}
-#endif
-
-/* for /proc/kcore */
-extern long vread_iter(struct iov_iter *iter, const char *addr, size_t count);
-
-/*
- *	Internals.  Don't use..
- */
-extern __init void vm_area_add_early(struct vm_struct *vm);
-extern __init void vm_area_register_early(struct vm_struct *vm, size_t align);
+static inline unsigned long vmalloc_nr_pages(void) { return 0; }
+static inline void set_vm_flush_reset_perms(void *addr) {}
+#endif /* CONFIG_MMU */
 
-#ifdef CONFIG_SMP
-# ifdef CONFIG_MMU
+#if defined(CONFIG_MMU) && defined(CONFIG_SMP)
 struct vm_struct **pcpu_get_vm_areas(const unsigned long *offsets,
 				     const size_t *sizes, int nr_vms,
 				     size_t align);
@@ -311,22 +312,9 @@ pcpu_get_vm_areas(const unsigned long *offsets,
 	return NULL;
 }
 
-static inline void
-pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
-{
-}
-# endif
-#endif
-
-#ifdef CONFIG_MMU
-#define VMALLOC_TOTAL (VMALLOC_END - VMALLOC_START)
-#else
-#define VMALLOC_TOTAL 0UL
+static inline void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms) {}
 #endif
 
-int register_vmap_purge_notifier(struct notifier_block *nb);
-int unregister_vmap_purge_notifier(struct notifier_block *nb);
-
 #if defined(CONFIG_MMU) && defined(CONFIG_PRINTK)
 bool vmalloc_dump_obj(void *object);
 #else
-- 
2.43.0


