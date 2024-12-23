Return-Path: <linux-csky+bounces-1430-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 372959FAC4F
	for <lists+linux-csky@lfdr.de>; Mon, 23 Dec 2024 10:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662F11882C0A
	for <lists+linux-csky@lfdr.de>; Mon, 23 Dec 2024 09:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB510199237;
	Mon, 23 Dec 2024 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="YwCBKelk"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD9194C86
	for <linux-csky@vger.kernel.org>; Mon, 23 Dec 2024 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947036; cv=none; b=mCrzkkD64oLf8UlpQEkIIZynIn3souB41TKQPhiqJX3cxL9Vqwa7o9Y9zelqhZeIlrJH0P8s27NGG5BgtyX+6aTF+Y2yUI2mXPUWail+GMz/COOTmOdlSGmezcVUcJ021ZBPEbMeCKsEUAlcI9vgrzy/A+G9P20nAZFZuXDIjRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947036; c=relaxed/simple;
	bh=iGGseqx9Ut5ViSPAG0PhwW+aGehMNfQFpL91q5ypQVw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I/zZjaApqZZzQ6wGyzwy6Jv1TTob185uUFwq/TGE06pB+90FC0sX5yNf1VvV3eO7g3mTjIe1M/Q73+N7vktKYDXnau70rwk/Pxgo8vebWGNEbice3Qq+UesQEh/PC2qDSAGeTMy3R/Q5TmBK1QWeoPj1/CoNRr+/wYNBdjKcy3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=YwCBKelk; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7265c18d79bso4502350b3a.3
        for <linux-csky@vger.kernel.org>; Mon, 23 Dec 2024 01:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947034; x=1735551834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6vBY23hDAeU19z0pXyQ9vuAeZavJyfGUN8npoqwlxU=;
        b=YwCBKelkhVnAI1YmArkuwZsKg+bbBtWoqB+ScUthCYx9q6p47hH0hsKMEKzrhMV2YP
         tqizLfTBPZRUzZfJaq0LM6WdhXkz3PTS6U00s8HNvZNiWLjp2cuJMt4RaaMGtOiROY6z
         k0NfEb9AUwZFiZGpgrgLi/5/rP2VMIQ57a4B2hJGzmOx6OxHwiCYa5ledkCFLLrOUykO
         17gA31qAMa2PMLVXIhhg7H9eC3wt+XgPEjk6XKbjjAksWCZYm1AjWUFW959qNloZHSzA
         KUReK9etAoforD3CWYNgDGqIR+Q3smDqJ8R2Clw/e50YcV9P9ZV+78KuEvmYj39ncUFr
         SeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947034; x=1735551834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6vBY23hDAeU19z0pXyQ9vuAeZavJyfGUN8npoqwlxU=;
        b=CcaNmLK+jkauX/D7JelwRYobsoJuI+RLXA7ewmPBhKn0YaaNb/4Gn78WAx/gq+96MO
         fAvc7f8KRcc6TlcmAxSX6FgBE/ut4qma35/tTez0SdrFFZlKW8Kc07X46yppu2ZsleXT
         OKcUNbOUsG1XfAG6zfvxBmqIHha6jX3T0Qiu6k0sLMVEZjgA877ROFAux1S9x+JUMT1B
         3XlkGn77D2IWQt9eVYpfIR2+VWuK1W6uuj4FMJhb1WVqcR9yO9wVceALPt06VNlBS2dI
         5qA7CnLflq4QBPcJg6Nofx/qwVC8meTmcVLtfvUy9FQ+filgHpwNXy1YRAHEG2SX4YeQ
         8ZzA==
X-Forwarded-Encrypted: i=1; AJvYcCVzJ7qIUQUDwCDLA8LyDzeb58ylMeAWn9o0AyyrfhZQ28v1TwoaBkTYu0kwLfaDqnpVc5mMo7f2F/TA@vger.kernel.org
X-Gm-Message-State: AOJu0YwXuKJT8l1avbJNFhDxLYNXlpNWdt+RCMP2qwNJoqPuioFpbqZv
	CPXyMeGr7rSPdjmMBZ3V6NqpwUfXh0A+GHZfdpAAqlkcQKIAG7HnvREsHWPiofo=
X-Gm-Gg: ASbGncswQvfkEno6OzcFfS6HqnirrD/TV+ZvOSs1xVlMgF4F6iuTrvXrb32dhYUUa0k
	drfT0ZtGjxChm9E7+Wz6nd+1q09pP/ADYI7aJ0pyOwLo37U7RjcwbVRj/SPgawlsxoEzfzcuYJe
	34aIA8rPlWEdSeZAygnWEpaBZR7ddtdiOmd/r7DTqj1ku8eJHd9DEMK2g8++kHMIxRhuGiLE5JM
	tvt7JD28lN+JT0rQW2+IPpYM40bxBNOzXTrwhF7k4IceyP9WqN615VDv0ue/ddUMa+oouXvl0H+
	EvANHDifnnoAfxN6KIbf5A==
X-Google-Smtp-Source: AGHT+IGO0+mWINscMdGqF/L7XDe6Dv/dfGXrIYILRYMXJn04aY3ZCG1rf5V2YGuLlSic6wG5VWjqsA==
X-Received: by 2002:a05:6a00:4090:b0:72a:a7a4:b4cd with SMTP id d2e1a72fcca58-72abdeb85b1mr18289604b3a.21.1734947034102;
        Mon, 23 Dec 2024 01:43:54 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:43:53 -0800 (PST)
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
Subject: [PATCH v3 04/17] mm: pgtable: add statistics for P4D level page table
Date: Mon, 23 Dec 2024 17:40:50 +0800
Message-Id: <2fa644e37ab917292f5c342e40fa805aa91afbbd.1734945104.git.zhengqi.arch@bytedance.com>
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

Like other levels of page tables, add statistics for P4D level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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


