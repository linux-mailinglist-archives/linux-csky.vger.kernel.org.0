Return-Path: <linux-csky+bounces-1437-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAF79FAC9C
	for <lists+linux-csky@lfdr.de>; Mon, 23 Dec 2024 10:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDA7816738D
	for <lists+linux-csky@lfdr.de>; Mon, 23 Dec 2024 09:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F90C19342F;
	Mon, 23 Dec 2024 09:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="ILpgUIOu"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793B918F2F8
	for <linux-csky@vger.kernel.org>; Mon, 23 Dec 2024 09:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947126; cv=none; b=mvq5rbEzl0F4ZrU6sJ/2TIl3cd59mc0WYCW4rpm9ExeFsU/9svUZAsQnKhmqsARSgLD3ONNjn/erB8N5CDNwQ7f5rfzFPjSNTf8F4Hj0pnB3R52XZRGwJPukuZGD3kQAHbMbv5alGgz2QsGdrhh1A39+ttLSaasYpphLJjQCjvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947126; c=relaxed/simple;
	bh=0DrkqJj4wQeX5ghzMY0LbiVqPzUVuk7cM17qWFCGuf4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uBoZGA9SIqxzDENKeqi7WVb5tZXzW7XL1PRvhyxBCEz1ZWvA5drh3ufJjDcR6chbi6bysVcMPPxS+1S3dB3WMX0PH7T2fFP/AFwBSr1lm1H2TjehVgQYxlvLAo7O9T5US3IukTZ6SESwPUm9/grwZTkysuOaW82Qbg7k8poIvTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=ILpgUIOu; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728ea1573c0so3238067b3a.0
        for <linux-csky@vger.kernel.org>; Mon, 23 Dec 2024 01:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947124; x=1735551924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rs6Lkouarv58ZoKb+WtHLVo9G63kikGgJGrD7ursbxc=;
        b=ILpgUIOu+Wy8FrgzTSZB2mk8ABhOh3ROj0ny4EM/VImeHeg3lJCoT9MA4LnQ8TJ3Mt
         42CUUskgnSW9ZXJdZiBmDQQ/1vn/TsDhK8v310d6wOmM8IpIJma7j8mffuCd8CpbI4bI
         2XQvgaelaRcDu2W0UKkvlndfnyON7c7liAf1fuotkNGDw5cUce7wAiaufBXLKr3EmzjP
         EW/dFNHQ+2oPSBZVoebTsQRZDtv2wjLyg51eKwCn0HwGehZN8qW4DGv4CPWb1nBECRn+
         Ksl8TDRC0Ypq6jZc3WOJh73FCruKIQ8YN6cU3g4YCKzwSg5fGfTpEbQdfdx1rthDj7dk
         M6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947124; x=1735551924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rs6Lkouarv58ZoKb+WtHLVo9G63kikGgJGrD7ursbxc=;
        b=Smp+LqOjDLTMzx+8GNnMFkipIHL/ACXoF68Sen8J6rpwQ/akdt848f1du+Q05IK+2r
         3PUwaKLqQrcTfNUMNe8GingZoMpIf3ce3s3wCquKqZbhF/398Fw3BhF0hfjuE/HGabe9
         lEw0n0qE/QPlDbpGd2+J0Id2clrEYZM4cm4c86vAYlxaEYHlf76p/O+fTOssjxrbyQVG
         G30a+kUlyRUIuVyiKMYitH4ounpX8kyJqRFf5hyO4ki2W+3PmJzMuvf4KukO97mmqO1E
         zF94voyp5GWX5vHAaMHdrjFePyoaDI32+0qpm82jbhqiIWskpmAiRRTQK7TaLKxMGC9C
         uVXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx9ghQqhYndXAgQie9B+esPhOfG3SXJ9uRrvZv7smLU9nVyRexgWHD7cvGh3EHOi3HLvfM/YiX8neW@vger.kernel.org
X-Gm-Message-State: AOJu0Yybpq8X83lG+cdvcGA/n/G9NR3f+A+U1xHLS4CfKFc+ishwjs+6
	qpRI84GaRtQrvgbqqZiYG0XDaQGc3HccAaiPEzbVnpHkbgyfGp2pBK8zahJu+Tg=
X-Gm-Gg: ASbGncsAK2N3bor3rbR5GAXdQnwyJO9TttL3+6vFM1fmzhlJLEWF//NTW/q1AZI+I7Y
	uAl3R9fQq1uGbqu6bQQdqyxrXT/uqZl3M/Jykeyt2/XIbKGTMDKcQQcrWi5DI7zrpijj+NrV1xI
	7DBBrtqIfU3qd9MMTqdG1Act8O6iwL4yz1z4Xx687CnfM+wtf1GMNS5FPSVcvXYtfetSrOwbfr5
	44Er18EYhVT/GSHEYV2BDuowub6j2LFyWQsgPvrbi67glhOsPm856Ozy8OsWdCMP3LAGAYBfbim
	+GR4PM0KjMJXzrzM4L9vhA==
X-Google-Smtp-Source: AGHT+IEsUkA9RBo0Vmvp6m94/gMVFQ4PHl6SoN42Z+rLx+q01B5oEKa1sTTPOWHs1mFCNObFPbuRxA==
X-Received: by 2002:a05:6a20:6a25:b0:1d9:18af:d150 with SMTP id adf61e73a8af0-1e5e05a9e39mr19676430637.21.1734947123919;
        Mon, 23 Dec 2024 01:45:23 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:45:23 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	tglx@linutronix.de,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	yuzhao@google.com,
	willy@infradead.org,
	muchun.song@linux.dev,
	vbabka@kernel.org,
	lorenzo.stoakes@oracle.com,
	akpm@linux-foundation.org,
	rientjes@google.com,
	vishal.moola@gmail.com,
	arnd@arndb.de,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	ryan.roberts@arm.com
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v3 11/17] x86: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 23 Dec 2024 17:40:57 +0800
Message-Id: <0dc5a3bf5a692e24379c1d3b879a6d4396f0dbbd.1734945104.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1734945104.git.zhengqi.arch@bytedance.com>
References: <cover.1734945104.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: x86@kernel.org
---
 arch/x86/include/asm/tlb.h | 17 ++++++++++-------
 arch/x86/kernel/paravirt.c |  1 +
 arch/x86/mm/pgtable.c      | 12 ++----------
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/tlb.h b/arch/x86/include/asm/tlb.h
index 73f0786181cc9..f64730be5ad67 100644
--- a/arch/x86/include/asm/tlb.h
+++ b/arch/x86/include/asm/tlb.h
@@ -31,24 +31,27 @@ static inline void tlb_flush(struct mmu_gather *tlb)
  */
 static inline void __tlb_remove_table(void *table)
 {
-	free_page_and_swap_cache(table);
+	struct ptdesc *ptdesc = (struct ptdesc *)table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #ifdef CONFIG_PT_RECLAIM
 static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 
-	page = container_of(head, struct page, rcu_head);
-	put_page(page);
+	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
+	__tlb_remove_table(ptdesc);
 }
 
 static inline void __tlb_remove_table_one(void *table)
 {
-	struct page *page;
+	struct ptdesc *ptdesc;
 
-	page = table;
-	call_rcu(&page->rcu_head, __tlb_remove_table_one_rcu);
+	ptdesc = table;
+	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
 }
 #define __tlb_remove_table_one __tlb_remove_table_one
 #endif /* CONFIG_PT_RECLAIM */
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 7bdcf152778c0..46d5d325483b0 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -62,6 +62,7 @@ void __init native_pv_lock_init(void)
 #ifndef CONFIG_PT_RECLAIM
 static void native_tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
+	pagetable_dtor(table);
 	tlb_remove_page(tlb, table);
 }
 #else
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index a6cd9660e29ec..a0b0e501ba663 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -23,6 +23,7 @@ EXPORT_SYMBOL(physical_mask);
 static inline
 void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
+	pagetable_dtor(table);
 	tlb_remove_page(tlb, table);
 }
 #else
@@ -60,7 +61,6 @@ early_param("userpte", setup_userpte);
 
 void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 {
-	pagetable_dtor(page_ptdesc(pte));
 	paravirt_release_pte(page_to_pfn(pte));
 	paravirt_tlb_remove_table(tlb, pte);
 }
@@ -68,7 +68,6 @@ void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
 #if CONFIG_PGTABLE_LEVELS > 2
 void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 	paravirt_release_pmd(__pa(pmd) >> PAGE_SHIFT);
 	/*
 	 * NOTE! For PAE, any changes to the top page-directory-pointer-table
@@ -77,16 +76,12 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
 #ifdef CONFIG_X86_PAE
 	tlb->need_flush_all = 1;
 #endif
-	pagetable_dtor(ptdesc);
-	paravirt_tlb_remove_table(tlb, ptdesc_page(ptdesc));
+	paravirt_tlb_remove_table(tlb, virt_to_page(pmd));
 }
 
 #if CONFIG_PGTABLE_LEVELS > 3
 void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pud);
-
-	pagetable_dtor(ptdesc);
 	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(pud));
 }
@@ -94,9 +89,6 @@ void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
-
-	pagetable_dtor(ptdesc);
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
 }
-- 
2.20.1


