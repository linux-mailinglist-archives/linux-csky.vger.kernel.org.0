Return-Path: <linux-csky+bounces-1556-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D372DA0542C
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jan 2025 08:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA6E18819FA
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jan 2025 07:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F651F0E47;
	Wed,  8 Jan 2025 07:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="KtvLg51X"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1811E5739
	for <linux-csky@vger.kernel.org>; Wed,  8 Jan 2025 07:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319822; cv=none; b=PRB/flRP0DGoa0MmkQw1sZ0fxbZG5Hj1Ka/b8ID8FLm2WG2eozcOMRTrrypIfF83hMvIgRjRvfHPEKOiEKQ4gX+5nn4YL07sGWMn7oIoK6wkREqfuam39KqNEvsendX1rDKtTS4uR5gqM2JJs0YmKl442/dRd+XX+sGLq8ixRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319822; c=relaxed/simple;
	bh=6Tm9tzzLwfPI5sWMJ+gGPjjpg7Ij0ovc/RrCPGoP6W0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=szCGDzfmVfMS7VqaCo2DQB5s8UiS10AbxOtzUnuOMecOR2E36zPt7UPkHCgVRAfCLa9xZ2w6+lQQh0DK6YfQ8gbYKGt/AcWrMBoHc21gbwWsPGYAcfrvyKo0EvK4wID0e6SL8ewKwxOnfGZK/5eQlEirVBexteiRWg84hekI5aQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=KtvLg51X; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-216395e151bso7145955ad.0
        for <linux-csky@vger.kernel.org>; Tue, 07 Jan 2025 23:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319820; x=1736924620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmV2C/123ilQKoYc6h41pKDzG2aiaIfZ7nQkaBcWxp0=;
        b=KtvLg51Xue1YBzIOtDDnaKVLDxho5Y6O34b3QLXYGujr9xXAirsHXiFIDJ98IjU9oz
         Z0hAvHLsx9XPp3Agplnwmdgv1qA4pbR9wYkuCUL2dZ92URLD0cl6irNm7klKTt/Is0tm
         4JLj7aE1faDKWpUwyXHPqT4sgeuViPZFzB2ipUzZMoMJ296x2IbGR20ZTsAMf8/Au32o
         CIOBHWY/teEwvunVztgAgLPbdBy3ANmKwDUgjV3S+uTok9chdNvvXzRT2hGQqLXZcP1s
         LvQFH6G/sHCtN/HFAGvMHOg0FcCEXTRuZI0StA33iKs4vlrGO5YuafH2wd1ZbnK0lL1T
         VwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319820; x=1736924620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmV2C/123ilQKoYc6h41pKDzG2aiaIfZ7nQkaBcWxp0=;
        b=qcTfRk0DMpWw4IvX75OjxTHj5wJletClIRL77bkNho6wdGMD7OQcHDDgZKVtGKoYbN
         GDpx4t7bF/oWdhiXQblP5mAE1fdVuA8Z7i8ooAuG9yRLSriQrCz8JWkx3QpeXTcahFt6
         kLky979fqyAv+KJLKLWTSJIprErxnwc+s+PQUpe0bYXbu5aB0ObLsAlDeX+gP8iSArZQ
         PcAM+JOQ2TT+9SRsKgH+4yyIM12BNbcmt77K47qD9SptDo/R8LmIKUvUupJODzNOoheh
         UDgRexy4BEClHg9RbpHoMtZhPBJ/i9Nj6KKaK6ZkSvNgR/888EaQoLrPtvsiZOO1AueW
         ccOA==
X-Forwarded-Encrypted: i=1; AJvYcCXu2geNsX968vHbvizU/SQU07w+7Mv1zOMdqmRorRrOFsAuGnsKfebTJreNG+vUe1d8Ju5FL6l6Z++g@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0M4UQ4ruGyTpXE3BOtrzq5wXGLMdGxcs8YQOsSYIcB7No+b5J
	4LPOz/qoG9kxTRbC+/k9IOLfSDvsyh0uw15i6wjcz3c8dw8vchbslIVYPlr9NDtmu8MXiJq7en8
	1
X-Gm-Gg: ASbGncuE9v72zlysuHzWafzPW0YKeaqgfG0npf3UeeigvARWR3XGMWOr2YShn2MAXb6
	fwH/vxdUg8PHdb/c23E/9QoUBt0KjbILSi4c++LLvuwS/uvdMOVupKGXU8Mn/+M+nQ+yFq9xC4j
	+Dt+cR8l34G8TXzgMwQ6SKTgdeRbArs3ylRgBQp8itSvDfFXx6nc8LH9tyVLMrEgQ4hA64S3CcR
	ClmTzkcGHG+LejaTfb26tISJmwmnNotD05EQv5waaXEWbXn3HCdl+WmOLEyraj9nFmbWAzPVU2Q
	OGHg7AAjpBPrMtf4h1KBFe5wsak=
X-Google-Smtp-Source: AGHT+IFPhscn4ro6sBJsBOR2a8pRlJGCRsiSDouRo+43OGNlwIzbjZLHQRkjQ8iB7a2FmZbbQjyk4w==
X-Received: by 2002:a17:902:fc46:b0:216:4fad:35d0 with SMTP id d9443c01a7336-21a7a1d4731mr100818035ad.9.1736319820276;
        Tue, 07 Jan 2025 23:03:40 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:03:39 -0800 (PST)
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
Subject: [PATCH v5 17/17] mm: pgtable: introduce generic pagetable_dtor_free()
Date: Wed,  8 Jan 2025 14:57:33 +0800
Message-Id: <1663a0565aca881d1338ceb7d1db4aa9c333abd6.1736317725.git.zhengqi.arch@bytedance.com>
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

The pte_free(), pmd_free(), __pud_free() and __p4d_free() in
asm-generic/pgalloc.h and the generic __tlb_remove_table() are basically
the same, so let's introduce pagetable_dtor_free() to deduplicate them.

In addition, the pagetable_dtor_free() in s390 does the same thing, so
let's s390 also calls generic pagetable_dtor_free().

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com> # s390
---
 arch/s390/mm/pgalloc.c        |  6 ------
 include/asm-generic/pgalloc.h | 12 ++++--------
 include/asm-generic/tlb.h     |  3 +--
 include/linux/mm.h            |  6 ++++++
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 3e002dea6278f..a4e7619020931 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -180,12 +180,6 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
 	return table;
 }
 
-static void pagetable_dtor_free(struct ptdesc *ptdesc)
-{
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
-}
-
 void page_table_free(struct mm_struct *mm, unsigned long *table)
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(table);
diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 4afb346eae255..e3977ddca15e4 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -109,8 +109,7 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte_page);
 
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 
@@ -153,8 +152,7 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
 
 	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 #endif
 
@@ -202,8 +200,7 @@ static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
 	struct ptdesc *ptdesc = virt_to_ptdesc(pud);
 
 	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_PUD_FREE
@@ -248,8 +245,7 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
 	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
 
 	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 
 #ifndef __HAVE_ARCH_P4D_FREE
diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 53ae7748f555b..e402aef79c93e 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -213,8 +213,7 @@ static inline void __tlb_remove_table(void *table)
 {
 	struct ptdesc *ptdesc = (struct ptdesc *)table;
 
-	pagetable_dtor(ptdesc);
-	pagetable_free(ptdesc);
+	pagetable_dtor_free(ptdesc);
 }
 #endif
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index cad11fa10c192..94078c488e904 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3001,6 +3001,12 @@ static inline void pagetable_dtor(struct ptdesc *ptdesc)
 	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
 }
 
+static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
+{
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
+}
+
 static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
 {
 	struct folio *folio = ptdesc_folio(ptdesc);
-- 
2.20.1


