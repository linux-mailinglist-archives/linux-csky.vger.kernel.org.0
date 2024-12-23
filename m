Return-Path: <linux-csky+bounces-1442-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 038129FACCC
	for <lists+linux-csky@lfdr.de>; Mon, 23 Dec 2024 10:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC6711886BE0
	for <lists+linux-csky@lfdr.de>; Mon, 23 Dec 2024 09:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905F31991C1;
	Mon, 23 Dec 2024 09:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="b8fFLJ6/"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CB51A3AB9
	for <linux-csky@vger.kernel.org>; Mon, 23 Dec 2024 09:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947190; cv=none; b=FzITQaBqkCXYWM7jP9RYynYdI95RnD4im4JU/g5QgEZxq0nzprBmFXVbf6uS1ce+ZQY/pHC/AZo7xpa7reAoIsUXs0bfLyOmxf8C85wbS+lLOr/33KIWRpt/VuxNxlq+Fj99wla1UuRmkakd+THxglHo1h7F6jsX0Quobj+cjLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947190; c=relaxed/simple;
	bh=wsOfsxqAjypDbhdyoWQgn2ScMkT8kExqTuyzqqTKK3A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cQO9PvNLCdilcjRndQAppTmq13AItqhLZAbnN10zHjdvaXJ4MaKuJiBUJnWP4LDrLJ4XzqvSqIgRv8Nb2bByQDQ09yWIQtGjrlhT0F5e2Yqm998B3XuUsJSH1PnyMUTxNtEAKrtMr+gCCUUNrGFH/z2u/ayheWxvMMiJ+O6j4q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=b8fFLJ6/; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-728e3826211so3072141b3a.0
        for <linux-csky@vger.kernel.org>; Mon, 23 Dec 2024 01:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947188; x=1735551988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vzAxma0H0oGKVF+0yjfVv8ni44DJQgUTcLWSpNFGuY=;
        b=b8fFLJ6/vWjrbKOwI7uUO7GpigqRpuSTwiQGZX8sQI5yybLCXbhSHDZv+7iwSj7xzq
         h+RH+QICxgGbGu3szgOfmUfCFcXfU2LRJX5WitR+HNKHhzJtXo+5DzhMZn/lZjtGuMe0
         Uxz6JkCGGU0QSqbsv6hoM6LS80gq7RkwbWegpeK041zcvZUiaJdJCuklYve7MuUgAINv
         fXwydI7wMJdUDVf2iz8dF9LnGYI7UtqmaBNkUSR3VYUf7GRQbaa8qwiN7ahvWslIjcku
         UCzlRk9bWJA1jrDhBr1tO4SfCgXHxAU8X7GxLfPlRitP5KCqa8ZNI7a1W3qlQRILXQCS
         EuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947188; x=1735551988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vzAxma0H0oGKVF+0yjfVv8ni44DJQgUTcLWSpNFGuY=;
        b=Q1fr9JtmGBBUqfY71kl55zelzrjknGlBwAyFOEu8I7uOP7qPQbfXfpb7DO47NpkM6Q
         45pXox4cBp2G24TYJUVnsOoNno3i49ceTwAWa6467VK+IyeJTO9zI9mY1TVos718ulga
         bFDhrlMLJ4laXOCY6yl8Ro39ibETFfH399FtojCyAf2EIQrsFwY2+O4YkqVhPN0iaGhR
         BNZhl48A2ZxwLFV4rZjUlTb0Lm69FO5+FqIiI1ENjOioBfD0uFC7wtMaJtQ/eIDjKuyS
         1SD9eLTEF8PjP1arRVeOkctdROjyLlFLIzZuHoodoZAAWLqed3CeWnHNxyUjxbhaBimP
         z5yA==
X-Forwarded-Encrypted: i=1; AJvYcCVdL4E5F3e34+6AyHolS8isEs7oNw7oC6M0+q6aiHrDUqsZ7YvGEwDnBd8qybaf6i44gg/R8AhSdlQ+@vger.kernel.org
X-Gm-Message-State: AOJu0YyjHM5Qo/uL1Dyji9TDncF8rarrFtpLS0rXux4zD5cksbP947oj
	5voqOvrutS/4txqpYT1epf/q4N/8mp7tkD1BoxQrJlDIy6L3/WA5d0hp4gsUeWs=
X-Gm-Gg: ASbGncts56vUhUIr2VZO17I3mAFxpDhRbr78w10Cc/qudVPFrHc8qKBZRdpjXjZpLMu
	nC1noA1GtDBZTvtTfZIxDL+8R/0BLwTJDKMxR1z8cJA2Gmwhd+zKmFlbg06NehKfPtJc0HFt8ea
	aDuNR6lWtgCLICMMvppOlWjCjJoKrvkscyrFRodtPWEWduvs9pmQdUNwv1K+PmUnmfTt4wg9QvY
	Q3SPFg2qtErU1tX46Xsd217D7GV6czsu303G1YNCeUi+0nYKDyqbdicYpinv3VPrtGdHDcFk9++
	o0KwJ8a6IaigwCvjOt/xFw==
X-Google-Smtp-Source: AGHT+IGqxRLXXsgzbTBUt4P8wMbb/CAKHFN0NH0iCzAzNT/ELUdunTp3cz3Ieuj7L8l/gUjxiL3RMw==
X-Received: by 2002:aa7:888c:0:b0:72a:a9b5:ed91 with SMTP id d2e1a72fcca58-72abde0e6b7mr17804649b3a.13.1734947187839;
        Mon, 23 Dec 2024 01:46:27 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:46:27 -0800 (PST)
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
Subject: [PATCH v3 16/17] mm: pgtable: remove tlb_remove_ptdesc()
Date: Mon, 23 Dec 2024 17:41:02 +0800
Message-Id: <93cce93bf8be04f3a5cd828cc0a48750fb90af44.1734945104.git.zhengqi.arch@bytedance.com>
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

Just like removing tlb_remove_page_ptdesc(), remove tlb_remove_ptdesc() as
well, and make callers call tlb_remove_table() directly.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/include/asm/tlb.h       |  8 ++------
 arch/arm64/include/asm/tlb.h     | 16 ++++------------
 arch/riscv/include/asm/pgalloc.h | 14 +++++++-------
 arch/s390/include/asm/tlb.h      |  8 ++++----
 include/asm-generic/tlb.h        |  7 +------
 mm/mmu_gather.c                  | 11 +++++------
 6 files changed, 23 insertions(+), 41 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index ea4fbe7b17f6f..ac3881ec342f1 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -32,8 +32,6 @@
 static inline void
 __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
-	struct ptdesc *ptdesc = page_ptdesc(pte);
-
 #ifndef CONFIG_ARM_LPAE
 	/*
 	 * With the classic ARM MMU, a pte page has two corresponding pmd
@@ -43,16 +41,14 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 	__tlb_adjust_range(tlb, addr - PAGE_SIZE, 2 * PAGE_SIZE);
 #endif
 
-	tlb_remove_ptdesc(tlb, ptdesc);
+	tlb_remove_table(tlb, pte);
 }
 
 static inline void
 __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
 {
 #ifdef CONFIG_ARM_LPAE
-	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
-
-	tlb_remove_ptdesc(tlb, ptdesc);
+	tlb_remove_table(tlb, virt_to_page(pmdp));
 #endif
 }
 
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 8d762607285cc..4a60569fed696 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -75,18 +75,14 @@ static inline void tlb_flush(struct mmu_gather *tlb)
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 				  unsigned long addr)
 {
-	struct ptdesc *ptdesc = page_ptdesc(pte);
-
-	tlb_remove_ptdesc(tlb, ptdesc);
+	tlb_remove_table(tlb, pte);
 }
 
 #if CONFIG_PGTABLE_LEVELS > 2
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 				  unsigned long addr)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
-
-	tlb_remove_ptdesc(tlb, ptdesc);
+	tlb_remove_table(tlb, virt_to_page(pmdp));
 }
 #endif
 
@@ -94,12 +90,10 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 				  unsigned long addr)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(pudp);
-
 	if (!pgtable_l4_enabled())
 		return;
 
-	tlb_remove_ptdesc(tlb, ptdesc);
+	tlb_remove_table(tlb, virt_to_page(pudp));
 }
 #endif
 
@@ -107,12 +101,10 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
 				  unsigned long addr)
 {
-	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
-
 	if (!pgtable_l5_enabled())
 		return;
 
-	tlb_remove_ptdesc(tlb, ptdesc);
+	tlb_remove_table(tlb, virt_to_page(p4dp));
 }
 #endif
 
diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index ab4f9b2cf9e11..25c2e2f262810 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -26,10 +26,10 @@
 static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
 {
 	if (riscv_use_sbi_for_rfence()) {
-		tlb_remove_ptdesc(tlb, pt);
+		tlb_remove_table(tlb, pt);
 	} else {
-		pagetable_dtor(pt);
-		tlb_remove_page(tlb, ptdesc_page((struct ptdesc *)pt));
+		pagetable_dtor(page_ptdesc((struct page *)pt));
+		tlb_remove_page(tlb, pt);
 	}
 }
 
@@ -108,14 +108,14 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 				  unsigned long addr)
 {
 	if (pgtable_l4_enabled)
-		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
+		riscv_tlb_remove_ptdesc(tlb, virt_to_page(pud));
 }
 
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long addr)
 {
 	if (pgtable_l5_enabled)
-		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
+		riscv_tlb_remove_ptdesc(tlb, virt_to_page(p4d));
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
@@ -144,7 +144,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 				  unsigned long addr)
 {
-	riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
+	riscv_tlb_remove_ptdesc(tlb, virt_to_page(pmd));
 }
 
 #endif /* __PAGETABLE_PMD_FOLDED */
@@ -152,7 +152,7 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 				  unsigned long addr)
 {
-	riscv_tlb_remove_ptdesc(tlb, page_ptdesc(pte));
+	riscv_tlb_remove_ptdesc(tlb, pte);
 }
 #endif /* CONFIG_MMU */
 
diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
index da4a7d175f69c..5eed6300f3d72 100644
--- a/arch/s390/include/asm/tlb.h
+++ b/arch/s390/include/asm/tlb.h
@@ -86,7 +86,7 @@ static inline void pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 	tlb->cleared_pmds = 1;
 	if (mm_alloc_pgste(tlb->mm))
 		gmap_unlink(tlb->mm, (unsigned long *)pte, address);
-	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pte));
+	tlb_remove_table(tlb, virt_to_page(pte));
 }
 
 /*
@@ -105,7 +105,7 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_puds = 1;
-	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pmd));
+	tlb_remove_table(tlb, virt_to_page(pmd));
 }
 
 /*
@@ -123,7 +123,7 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
 	tlb->cleared_p4ds = 1;
-	tlb_remove_ptdesc(tlb, virt_to_ptdesc(pud));
+	tlb_remove_table(tlb, virt_to_page(pud));
 }
 
 /*
@@ -141,7 +141,7 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 	__tlb_adjust_range(tlb, address, PAGE_SIZE);
 	tlb->mm->context.flush_mm = 1;
 	tlb->freed_tables = 1;
-	tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
+	tlb_remove_table(tlb, virt_to_page(p4d));
 }
 
 #endif /* _S390_TLB_H */
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 8d6cfe5058543..583e95568f52b 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -211,7 +211,7 @@ struct mmu_table_batch {
 #ifndef __HAVE_ARCH_TLB_REMOVE_TABLE
 static inline void __tlb_remove_table(void *table)
 {
-	struct ptdesc *ptdesc = (struct ptdesc *)table;
+	struct ptdesc *ptdesc = page_ptdesc((struct page *)table);
 
 	pagetable_dtor(ptdesc);
 	pagetable_free(ptdesc);
@@ -499,11 +499,6 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
 }
 
-static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
-{
-	tlb_remove_table(tlb, pt);
-}
-
 static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
index 7aa6f18c500b2..c58ce4539c56f 100644
--- a/mm/mmu_gather.c
+++ b/mm/mmu_gather.c
@@ -314,18 +314,17 @@ static inline void tlb_table_invalidate(struct mmu_gather *tlb)
 #ifdef CONFIG_PT_RECLAIM
 static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
 {
-	struct ptdesc *ptdesc;
+	struct page *page;
 
-	ptdesc = container_of(head, struct ptdesc, pt_rcu_head);
-	__tlb_remove_table(ptdesc);
+	page = container_of(head, struct page, rcu_head);
+	__tlb_remove_table(page);
 }
 
 static inline void __tlb_remove_table_one(void *table)
 {
-	struct ptdesc *ptdesc;
+	struct page *page = (struct page *)table;
 
-	ptdesc = table;
-	call_rcu(&ptdesc->pt_rcu_head, __tlb_remove_table_one_rcu);
+	call_rcu(&page->rcu_head, __tlb_remove_table_one_rcu);
 }
 #else
 static inline void __tlb_remove_table_one(void *table)
-- 
2.20.1


