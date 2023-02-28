Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25C06A6155
	for <lists+linux-csky@lfdr.de>; Tue, 28 Feb 2023 22:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjB1Vhq (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 28 Feb 2023 16:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjB1Vhq (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 28 Feb 2023 16:37:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054BD3430F;
        Tue, 28 Feb 2023 13:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=B5j2SOFWmtz+byodXTEtLGjajHY9V7moC1330qT7ZY8=; b=hTwQ3kkAP6iIZQTqLZVTocWHRU
        Ij3tn6LImZ/3nzMEl0hGpChAT3eXCsnlnPct5tN2GBKBcYJJxGmusv0GWljHEUfTTdiLmKHl5/r/A
        e1YPRGY8lpZlVpJynqExNBNvobacTeIKUky/55E9Nu4xkWqD2oK4Xop0YMzVOQkfM0MT3m83D4raZ
        CDbD2yw0ifcg4sTX9tBxeMl+2SPPPSpHQGW4VCQOOGfbCjgvwVahkjYzQyw9sMF0z5xp+5oOV95vo
        fgf/Yv+a30t9tD4bft/P+9AsaFx/62mVSHWM8mzEHdXQ3lZYd0+qgXY50cjIO3qJS6iVvinCLisyw
        Y0jkOjMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pX7fI-0018ot-92; Tue, 28 Feb 2023 21:37:40 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, linux-arch@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
Subject: [PATCH v3 09/34] csky: Implement the new page table range API
Date:   Tue, 28 Feb 2023 21:37:12 +0000
Message-Id: <20230228213738.272178-10-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230228213738.272178-1-willy@infradead.org>
References: <20230228213738.272178-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Add set_ptes(), update_mmu_cache_range() and flush_dcache_folio().
Change the PG_dcache_clean flag from being per-page to per-folio.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
---
 arch/csky/abiv1/cacheflush.c         | 32 +++++++++++++++++-----------
 arch/csky/abiv1/inc/abi/cacheflush.h |  2 ++
 arch/csky/abiv2/cacheflush.c         | 30 +++++++++++++-------------
 arch/csky/abiv2/inc/abi/cacheflush.h | 10 +++++++--
 arch/csky/include/asm/pgtable.h      | 21 +++++++++++++++---
 5 files changed, 62 insertions(+), 33 deletions(-)

diff --git a/arch/csky/abiv1/cacheflush.c b/arch/csky/abiv1/cacheflush.c
index fb91b069dc69..ba43f6c26b4f 100644
--- a/arch/csky/abiv1/cacheflush.c
+++ b/arch/csky/abiv1/cacheflush.c
@@ -14,43 +14,49 @@
 
 #define PG_dcache_clean		PG_arch_1
 
-void flush_dcache_page(struct page *page)
+void flush_dcache_folio(struct folio *folio)
 {
 	struct address_space *mapping;
 
-	if (page == ZERO_PAGE(0))
+	if (is_zero_pfn(folio_pfn(folio)))
 		return;
 
-	mapping = page_mapping_file(page);
+	mapping = folio_flush_mapping(folio);
 
-	if (mapping && !page_mapcount(page))
-		clear_bit(PG_dcache_clean, &page->flags);
+	if (mapping && !folio_mapped(folio))
+		clear_bit(PG_dcache_clean, &folio->flags);
 	else {
 		dcache_wbinv_all();
 		if (mapping)
 			icache_inv_all();
-		set_bit(PG_dcache_clean, &page->flags);
+		set_bit(PG_dcache_clean, &folio->flags);
 	}
 }
+EXPORT_SYMBOL(flush_dcache_folio);
+
+void flush_dcache_page(struct page *page)
+{
+	flush_dcache_folio(page_folio(page));
+}
 EXPORT_SYMBOL(flush_dcache_page);
 
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long addr,
-	pte_t *ptep)
+void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long addr,
+		pte_t *ptep, unsigned int nr)
 {
 	unsigned long pfn = pte_pfn(*ptep);
-	struct page *page;
+	struct folio *folio;
 
 	if (!pfn_valid(pfn))
 		return;
 
-	page = pfn_to_page(pfn);
-	if (page == ZERO_PAGE(0))
+	if (is_zero_pfn(pfn))
 		return;
 
-	if (!test_and_set_bit(PG_dcache_clean, &page->flags))
+	folio = page_folio(pfn_to_page(pfn));
+	if (!test_and_set_bit(PG_dcache_clean, &folio->flags))
 		dcache_wbinv_all();
 
-	if (page_mapping_file(page)) {
+	if (folio_flush_mapping(folio)) {
 		if (vma->vm_flags & VM_EXEC)
 			icache_inv_all();
 	}
diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
index ed62e2066ba7..0d6cb65624c4 100644
--- a/arch/csky/abiv1/inc/abi/cacheflush.h
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -9,6 +9,8 @@
 
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 extern void flush_dcache_page(struct page *);
+void flush_dcache_folio(struct folio *);
+#define flush_dcache_folio flush_dcache_folio
 
 #define flush_cache_mm(mm)			dcache_wbinv_all()
 #define flush_cache_page(vma, page, pfn)	cache_wbinv_all()
diff --git a/arch/csky/abiv2/cacheflush.c b/arch/csky/abiv2/cacheflush.c
index 39c51399dd81..c1cf0d55a2a1 100644
--- a/arch/csky/abiv2/cacheflush.c
+++ b/arch/csky/abiv2/cacheflush.c
@@ -6,30 +6,30 @@
 #include <linux/mm.h>
 #include <asm/cache.h>
 
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
-		      pte_t *pte)
+void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long address,
+		pte_t *pte, unsigned int nr)
 {
-	unsigned long addr;
+	unsigned long pfn = pte_pfn(*pte);
 	struct page *page;
+	unsigned int i;
 
-	if (!pfn_valid(pte_pfn(*pte)))
+	if (!pfn_valid(pfn) || is_zero_pfn(pfn))
 		return;
 
-	page = pfn_to_page(pte_pfn(*pte));
-	if (page == ZERO_PAGE(0))
-		return;
+	folio = page_folio(pfn_to_page(pfn));
 
-	if (test_and_set_bit(PG_dcache_clean, &page->flags))
+	if (test_and_set_bit(PG_dcache_clean, &folio->flags))
 		return;
 
-	addr = (unsigned long) kmap_atomic(page);
-
-	dcache_wb_range(addr, addr + PAGE_SIZE);
+	for (i = 0; i < folio_nr_pages(folio); i++) {
+		unsigned long addr = (unsigned long) kmap_local_folio(folio,
+								i * PAGE_SIZE);
 
-	if (vma->vm_flags & VM_EXEC)
-		icache_inv_range(addr, addr + PAGE_SIZE);
-
-	kunmap_atomic((void *) addr);
+		dcache_wb_range(addr, addr + PAGE_SIZE);
+		if (vma->vm_flags & VM_EXEC)
+			icache_inv_range(addr, addr + PAGE_SIZE);
+		kunmap_local((void *) addr);
+	}
 }
 
 void flush_icache_deferred(struct mm_struct *mm)
diff --git a/arch/csky/abiv2/inc/abi/cacheflush.h b/arch/csky/abiv2/inc/abi/cacheflush.h
index a565e00c3f70..9c728933a776 100644
--- a/arch/csky/abiv2/inc/abi/cacheflush.h
+++ b/arch/csky/abiv2/inc/abi/cacheflush.h
@@ -18,11 +18,17 @@
 
 #define PG_dcache_clean		PG_arch_1
 
+static inline void flush_dcache_folio(struct folio *folio)
+{
+	if (test_bit(PG_dcache_clean, &folio->flags))
+		clear_bit(PG_dcache_clean, &folio->flags);
+}
+#define flush_dcache_folio flush_dcache_folio
+
 #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
 static inline void flush_dcache_page(struct page *page)
 {
-	if (test_bit(PG_dcache_clean, &page->flags))
-		clear_bit(PG_dcache_clean, &page->flags);
+	flush_dcache_folio(page_folio(page));
 }
 
 #define flush_dcache_mmap_lock(mapping)		do { } while (0)
diff --git a/arch/csky/include/asm/pgtable.h b/arch/csky/include/asm/pgtable.h
index d4042495febc..a30ae048233e 100644
--- a/arch/csky/include/asm/pgtable.h
+++ b/arch/csky/include/asm/pgtable.h
@@ -90,7 +90,20 @@ static inline void set_pte(pte_t *p, pte_t pte)
 	/* prevent out of order excution */
 	smp_mb();
 }
-#define set_pte_at(mm, addr, ptep, pteval) set_pte(ptep, pteval)
+
+static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
+		pte_t *ptep, pte_t pte, unsigned int nr)
+{
+	for (;;) {
+		set_pte(ptep, pte);
+		if (--nr == 0)
+			break;
+		ptep++;
+		pte_val(pte) += PAGE_SIZE;
+	}
+}
+
+#define set_pte_at(mm, addr, ptep, pte) set_ptes(mm, addr, ptep, pte, 1)
 
 static inline pte_t *pmd_page_vaddr(pmd_t pmd)
 {
@@ -263,8 +276,10 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
 extern void paging_init(void);
 
-void update_mmu_cache(struct vm_area_struct *vma, unsigned long address,
-		      pte_t *pte);
+void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long address,
+		pte_t *pte, unsigned int nr);
+#define update_mmu_cache(vma, addr, ptep) \
+	update_mmu_cache_range(vma, addr, ptep, 1)
 
 #define io_remap_pfn_range(vma, vaddr, pfn, size, prot) \
 	remap_pfn_range(vma, vaddr, pfn, size, prot)
-- 
2.39.1

