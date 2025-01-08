Return-Path: <linux-csky+bounces-1543-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C047FA053A7
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jan 2025 08:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147CE3A59D0
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jan 2025 07:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3A1AA786;
	Wed,  8 Jan 2025 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O5XRCKWq"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9F1AA794
	for <linux-csky@vger.kernel.org>; Wed,  8 Jan 2025 07:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319623; cv=none; b=MCJRg/dWKEiEVHwFXHu04WQYQcxUh5Lc8SsrIEOVqzB8GOM1U5HG9dKuA7EcorwnWvHtRAMcrThIKiIUbiS4TjOht3plvIRmE0VSwV312L1fg2LmQxpzzr9U5AnaD/OfJS0CvFDN21iExJVzaY8EfAy1NgFM5ubRBFM1UM9WsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319623; c=relaxed/simple;
	bh=e3kN1Di5Fcouv11d71USulaPcPOxTFiQrC41b2k4smg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GcHogE97zX1YXLFqj6e2t+ib32cqpOM6+JDlw2MO6fxdj1+xhi/cgDic8lBNBaVMMYsI4n8jZpAWBYg04dg51klEtx4ESXAmtyUJx5xKvUkieuMPxBPjht9H5Arg1QiAF4aWWHu+bHyC0XW92nITeKOvQRGV6oJIC4W3ja77YrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O5XRCKWq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21a7ed0155cso22821115ad.3
        for <linux-csky@vger.kernel.org>; Tue, 07 Jan 2025 23:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319620; x=1736924420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/cYfjcYM2i48jLO7NuvQJ4j04U6+7fBnrQjgIuvbLyg=;
        b=O5XRCKWq8txl5jdu+/W1m3atTtJsBrDNFn0550BG/WccWESMhlAacBuoMat6JixgPQ
         h2u+KmhFWSwrbfJa0K6FVo9dHO5n7gUtjw6uMJ9u5W4xIQL7hH+sussflQ74wCFitdAH
         Q0jF+5XJqv7Lec/ahR9b6RK50PxEE/1sDiPk2jI6ROpYGeoHeRIXhffmo1pR6OOivosQ
         aL2nyeu7ZDtaK5clMw+6gA2R6+xqDw73i7MTBxWP46ERYw/ixy+6c27qYRUaWgOOYkZH
         sRdTxZ//MMNjR4uxVMZuJ86vlE1So9w4HHzsHvOGaCYs3PvdWQ9DQ0+l0izkUNPe3oKt
         7+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319620; x=1736924420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/cYfjcYM2i48jLO7NuvQJ4j04U6+7fBnrQjgIuvbLyg=;
        b=PMRcmabK2GH7pEUfxBKZ9XHbdzXm7VEb9VvfLEFLbN6i+CaMEz6tktRcmL0fYaQ7Fy
         OaZPdiC5ZfXLXr66JNCKAU8JEj7RK33Q819k9NxF5zmDnQfrx99n2NhD+POa2KiH1FjI
         mQOTMV1Xeh4YlKbHK/sHT45+joK1od4mQFEgRQwnFKnEl7beKN7fORcWdxDx55vPOFv7
         wELTtOOYIY6CFxgKscHizoMocfuPko+zjeBVzTPRAUAHO1RZEPVjKJCsMl1SvZBP9Xsr
         0CZd/YVNbpYUOV3EAfr/lOzq+jwrgibOucQ1XJRtZ+X08ytQDzrgx+CbL6gr5fz/F+0s
         LZHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH+aEm7nK1+8yStJBwFZJ/77k2BmjiAw1qmoN6rKdBCR0wzF8dJdVMeyRI+Ov8oecLH9/iPu0LcqZ1@vger.kernel.org
X-Gm-Message-State: AOJu0YyHzxXjhzje4MS306JDFy3hxrroEwAokyELmLnQe7VgNzeHYQ4e
	Fb4CBx2ZSpKTATW2yCCTMsf7Qie+gXexTHxLBPOY7q0F2fKIAZF0fUGT1hcxcY8=
X-Gm-Gg: ASbGncuSyaN2bpuFjuMWA23/9DCsrwA3GlJdNIqWL18itgrRE2aHqaMZcDpNJjw1dR9
	wMHk8m5GE/D1I6Hc/Q8frosIxvvPyXlbQJj6tlPcz1VnrOx40mgJaGjL60LtK69T0g6b5+/8Inr
	24kTLufno7iJ4gyQXlbjjy+7yxIVz7hYbxOnFiT+EBB4VCZZ8NpaC9Tw6HavZRkCkJeSYz07cW/
	hKzj0s7+pmmAV7aSCRQ0k5aDxkPYHdTSGxCoEg8Reik7gQ1K3HgNXxXkCm7x3WGgWk/B8dBsGs1
	q61A0+BAxCryvEaRtmcUtvpFkGA=
X-Google-Smtp-Source: AGHT+IExFPt1bVFS1B+HfK/rni8xCakw0mpYmNpiHCGWtvviMVtfvk5MaDovSIdy5xSOdSeWSopXEQ==
X-Received: by 2002:a17:903:2311:b0:210:fce4:11ec with SMTP id d9443c01a7336-21a83f42687mr30246255ad.1.1736319619595;
        Tue, 07 Jan 2025 23:00:19 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:00:19 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
	alex@ghiti.fr,
	andreas@gaisler.com,
	palmer@dabbelt.com,
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
Subject: [PATCH v5 04/17] mm: pgtable: add statistics for P4D level page table
Date: Wed,  8 Jan 2025 14:57:20 +0800
Message-Id: <d55fe3c286305aae84457da9e1066df99b3de125.1736317725.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1736317725.git.zhengqi.arch@bytedance.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like other levels of page tables, add statistics for P4D level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
---
 arch/riscv/include/asm/pgalloc.h |  6 +++++-
 arch/x86/mm/pgtable.c            |  3 +++
 include/asm-generic/pgalloc.h    |  2 ++
 include/linux/mm.h               | 16 ++++++++++++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index 551d614d3369c..3466fbe2e508d 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -108,8 +108,12 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
 				  unsigned long addr)
 {
-	if (pgtable_l5_enabled)
+	if (pgtable_l5_enabled) {
+		struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+		pagetable_p4d_dtor(ptdesc);
 		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
+	}
 }
 #endif /* __PAGETABLE_PMD_FOLDED */
 
diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 69a357b15974a..3d6e84da45b24 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -94,6 +94,9 @@ void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
 #if CONFIG_PGTABLE_LEVELS > 4
 void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
 {
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
+
+	pagetable_p4d_dtor(ptdesc);
 	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
 	paravirt_tlb_remove_table(tlb, virt_to_page(p4d));
 }
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 59131629ac9cc..bb482eeca0c3e 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -230,6 +230,7 @@ static inline p4d_t *__p4d_alloc_one_noprof(struct mm_struct *mm, unsigned long
 	if (!ptdesc)
 		return NULL;
 
+	pagetable_p4d_ctor(ptdesc);
 	return ptdesc_address(ptdesc);
 }
 #define __p4d_alloc_one(...)	alloc_hooks(__p4d_alloc_one_noprof(__VA_ARGS__))
@@ -247,6 +248,7 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
 
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
+	pagetable_p4d_dtor(ptdesc);
 	pagetable_free(ptdesc);
 }
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index c49bc7b764535..5d82f42ddd5cc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3175,6 +3175,22 @@ static inline void pagetable_pud_dtor(struct ptdesc *ptdesc)
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+static inline void pagetable_p4d_ctor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_set_pgtable(folio);
+	lruvec_stat_add_folio(folio, NR_PAGETABLE);
+}
+
+static inline void pagetable_p4d_dtor(struct ptdesc *ptdesc)
+{
+	struct folio *folio = ptdesc_folio(ptdesc);
+
+	__folio_clear_pgtable(folio);
+	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
+}
+
 extern void __init pagecache_init(void);
 extern void free_initmem(void);
 
-- 
2.20.1


