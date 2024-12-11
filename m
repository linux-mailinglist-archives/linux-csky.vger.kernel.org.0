Return-Path: <linux-csky+bounces-1316-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B4D9EDB3A
	for <lists+linux-csky@lfdr.de>; Thu, 12 Dec 2024 00:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1CC16889A
	for <lists+linux-csky@lfdr.de>; Wed, 11 Dec 2024 23:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CCA1F3D4D;
	Wed, 11 Dec 2024 23:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ejCWzEcS"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CF21F37BD
	for <linux-csky@vger.kernel.org>; Wed, 11 Dec 2024 23:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733959684; cv=none; b=HWwFk4Om4q6lNarGsMNsDUuo2nMUNghHE14MjQMjQkFvLrZIhdqFe1I/eL3HjGJZ2aMmX8aMYhpl1Cch2197/NQ8w0Ss6eglAvBOBYxw2ubPKfVqUisb4TaEzyedSgkfca64JP9hPMhGUAexpQFGx68VKM0m84Mn6LhNneeJ4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733959684; c=relaxed/simple;
	bh=uM+q/yzsIcRuyjHcDmC8155xmbCZFE2hF94cz6in5vY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xyl0G7gV1VtpN8HE09ZqvUUZ7NMavWtyP+rniWz6fcoqGUKcawyUIW7IM+0FCkbZvvxtKYYCFkbZgodqhd1tFEkFMG5Evmpbb2H0xwDOp6abkhiw9k+HlI4X0g4whY9bRaqYvn7CUl9MzjM2gpEWh2BQthLfo46OKCzTMgR6Gb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ejCWzEcS; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-728e3d9706dso17843b3a.3
        for <linux-csky@vger.kernel.org>; Wed, 11 Dec 2024 15:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733959682; x=1734564482; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=C3IQSr9A1qLdVskR9rEe7ppqc2lFkJy3Q6Qw5iPRaPE=;
        b=ejCWzEcSItb/pYmUDQW9i3/51hX9bZULXDyiOV1Trv+DDVZtqg1cf3mx6FtSNPtprl
         m0t54O5ALg6tlV7UPSnDp/7j91VGIuqQ9DwOooKQI/GHWd56Y7RdkujtFXWDalc9Qt2R
         r/Hj4f+yVP8FmXygrjDUkQ9zODK+EgJUz2ZY7/1aevmO2AMDlWTTBn6bGf5969an/94x
         8CrqJo59hGcway3KgEnDifOeCyQ8uACi97gpOYbNI/wwVRDoWCPC5xOuhzJFixS2M3dl
         0RxCiqgeEkHI8VCvW3zefH5PuLHaQOZWHVuYbL1E6uA9IJeNOfAUDL/f5AaHL3NWLWhN
         /pCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733959682; x=1734564482;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C3IQSr9A1qLdVskR9rEe7ppqc2lFkJy3Q6Qw5iPRaPE=;
        b=P/BEP4wmuAZs1duhw8N88YbnRslthLEg2H6i9jZN0XVpS1sl/ygDnumEevvkqRt+/y
         4t+2oLOhDvfAhnR2Ok+8J6LSG6ULfAj1GQZ4Tqe8uQ34wdh+lAoMeeIivNiYKYFWFLHB
         JUYvJEGxTTbh7Xkbq/mYyy3C1tOplXkI/+ex7z+YkWSxToMRUyvXj6fOeNzP8auxI2kE
         oo+sATa+wl6lN5jllpvyWlGxYfVMoFTOJBF9K5MEnN3MWUcmz+Fdum/wVHTdAcVvZIGk
         sIOKmJ2r8AC7sjJok/75Ec3IeGGs8tPibFixgPlq0h2gEDTAg2zb+2bZnRouQBL8/263
         hZGA==
X-Forwarded-Encrypted: i=1; AJvYcCXjEjZPkiIeTreGyWho+AB+qI0V4Y5rfzv7l4Q3sHnGbPNoXv7z/xSHw3udsFhx8+mmjP+4hK1aL68x@vger.kernel.org
X-Gm-Message-State: AOJu0YyVYjTqnm+IP4/hX5459DsNQEbYtUcRsUa+wnx3cd/eELmg3+sy
	w0fuOO28gOdyPZnM+9wSc5upJOVa/fM7vJjBirK8E3H6GsrBmviOfwwXLaQSxrZ9uh33rbArjWb
	312cd5VAknTDLe1C7mpPFzw==
X-Google-Smtp-Source: AGHT+IHwoWCnSZAFhgfRGzh0vJKMetndx4pRL/iGA/i3q5lPp5GtpRRmcU9xCr75DNYXJvBdH8Wl1Hh5YkFK8klCiw==
X-Received: from pge13.prod.google.com ([2002:a05:6a02:2d0d:b0:801:9432:2d6d])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:cf83:b0:1d9:18af:d150 with SMTP id adf61e73a8af0-1e1ceafb16amr1741157637.21.1733959681795;
 Wed, 11 Dec 2024 15:28:01 -0800 (PST)
Date: Wed, 11 Dec 2024 15:27:40 -0800
In-Reply-To: <20241211232754.1583023-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241211232754.1583023-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241211232754.1583023-3-kaleshsingh@google.com>
Subject: [PATCH mm-unstable v2 02/16] mm: x86: Introduce arch_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com, minchan@kernel.org, jyescas@google.com
Cc: linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	James.Bottomley@HansenPartnership.com, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net, 
	andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce x86 arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Fallback to generic_mmap_hint() if an architecture doesn't
provide HAVE_ARCH_MMAP_HINT.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---

Changes in v2:
  - MAP_FIXED case is also handled in arch_mmap_hint() since this is just a
    special case of the hint addr being "enforced", per Yang Shi.
  - Consolidate most of the error handling in arch_mmap_hint().
  - Fallback to generic_mmap_hint() if arch_mmap_hint() is not provided.

 arch/x86/include/asm/pgtable_64.h |  1 +
 arch/x86/kernel/sys_x86_64.c      | 64 +++++++++++++++----------------
 include/linux/sched/mm.h          |  5 +++
 mm/mmap.c                         |  9 +++++
 4 files changed, 45 insertions(+), 34 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index d1426b64c1b9..4472fd0040c3 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -245,6 +245,7 @@ extern void cleanup_highmap(void);
 
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define HAVE_ARCH_MMAP_HINT
 
 #define PAGE_AGP    PAGE_KERNEL_NOCACHE
 #define HAVE_PAGE_AGP 1
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 776ae6fa7f2d..008c6d19bd02 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -123,31 +123,44 @@ static inline unsigned long stack_guard_placement(vm_flags_t vm_flags)
 	return 0;
 }
 
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	unsigned long begin, end;
+
+	find_start_end(addr, flags, &begin, &end);
+
+	/* requested length too big for entire address space */
+	if (len > end || len > TASK_SIZE)
+		return -ENOMEM;
+
+	/* No address checking. See comment at mmap_address_hint_valid() */
+	if (flags & MAP_FIXED)
+		return addr;
+
+	addr = PAGE_ALIGN(addr);
+
+	/* Fallback to VA space search? */
+	if (!mmap_address_hint_valid(addr, len))
+		return 0;
+
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+
 unsigned long
 arch_get_unmapped_area(struct file *filp, unsigned long addr, unsigned long len,
 		       unsigned long pgoff, unsigned long flags, vm_flags_t vm_flags)
 {
-	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
 	struct vm_unmapped_area_info info = {};
 	unsigned long begin, end;
 
-	if (flags & MAP_FIXED)
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
 		return addr;
 
 	find_start_end(addr, flags, &begin, &end);
 
-	if (len > end)
-		return -ENOMEM;
-
-	if (addr) {
-		addr = PAGE_ALIGN(addr);
-		vma = find_vma(mm, addr);
-		if (end - len >= addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
-
 	info.length = len;
 	info.low_limit = begin;
 	info.high_limit = end;
@@ -168,34 +181,17 @@ arch_get_unmapped_area_topdown(struct file *filp, unsigned long addr0,
 			  unsigned long len, unsigned long pgoff,
 			  unsigned long flags, vm_flags_t vm_flags)
 {
-	struct vm_area_struct *vma;
-	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
 	struct vm_unmapped_area_info info = {};
 
-	/* requested length too big for entire address space */
-	if (len > TASK_SIZE)
-		return -ENOMEM;
-
-	/* No address checking. See comment at mmap_address_hint_valid() */
-	if (flags & MAP_FIXED)
-		return addr;
-
 	/* for MAP_32BIT mappings we force the legacy mmap base */
 	if (!in_32bit_syscall() && (flags & MAP_32BIT))
 		goto bottomup;
 
 	/* requesting a specific address */
-	if (addr) {
-		addr &= PAGE_MASK;
-		if (!mmap_address_hint_valid(addr, len))
-			goto get_unmapped_area;
-
-		vma = find_vma(mm, addr);
-		if (!vma || addr + len <= vm_start_gap(vma))
-			return addr;
-	}
-get_unmapped_area:
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return addr;
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index edeec19d1708..f4143703f234 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -205,6 +205,11 @@ unsigned long generic_mmap_hint(struct file *filp, unsigned long addr,
 				unsigned long len, unsigned long pgoff,
 				unsigned long flags);
 
+/* See generic_mmap_hint() */
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags);
+
 unsigned long
 generic_get_unmapped_area(struct file *filp, unsigned long addr,
 			  unsigned long len, unsigned long pgoff,
diff --git a/mm/mmap.c b/mm/mmap.c
index 382b4eac5406..76dd6acdf051 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -705,6 +705,15 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 }
 #endif
 
+#ifndef HAVE_ARCH_MMAP_HINT
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+				      unsigned long len, unsigned long pgoff,
+				      unsigned long flags)
+{
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+#endif
+
 /*
  * This mmap-allocator allocates new areas top-down from below the
  * stack's low limit (the base):
-- 
2.47.0.338.g60cca15819-goog


