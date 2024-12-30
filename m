Return-Path: <linux-csky+bounces-1452-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 311239FE428
	for <lists+linux-csky@lfdr.de>; Mon, 30 Dec 2024 10:09:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBACD188213A
	for <lists+linux-csky@lfdr.de>; Mon, 30 Dec 2024 09:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D05F1A239A;
	Mon, 30 Dec 2024 09:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="UqK3sU+2"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661921A23AF
	for <linux-csky@vger.kernel.org>; Mon, 30 Dec 2024 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549748; cv=none; b=J5oqKThslmzN3VkN+pX1oAtGy+qKfDfREwkZrAGyVIrybCFS3rGUwzge+xoSAxeV3Rd4gakCAWJkDs7D37VfbyXfQO99e22I93pzB7iC+qmXVE8zSAJC3R0CR7ocyJbEa1f9Zb0syRtLNvAunKw/570bHDWfm4u/pn8h0TnmRlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549748; c=relaxed/simple;
	bh=PKxGSwR+56aVOtqiYfVzo+PhXISkTKu7YVtS9mMtvvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fvqMWtf6hUAk7AS5+YbRaG1kAGIvcwekZTW7/w0LjeRDKAj2z9KwG0/YM1wZlFHyeVCO3/wsoB7hg5qYrwa+g176Uw7YeDAvylGAoeb8FI0yBiIQ2fZbgYxMBe2JJS91oVlir3PJrgBPtDxv+uP9tqQqQL+efp9PIAHj1UPmnc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=UqK3sU+2; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21649a7bcdcso113076005ad.1
        for <linux-csky@vger.kernel.org>; Mon, 30 Dec 2024 01:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549745; x=1736154545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mHzGZQny5JmimEm0kycepUlCOKttN6NXbKtm7VNKgbw=;
        b=UqK3sU+2wcAUPiAKKXdtQ0aEJDqkRo6Yya3Wbj9oIqILyZNKbqjce1teTm/9Pe/6TJ
         TT8TcgAmn7YerrmNKsaGqC/WVERQJSYXRT1OqR6pmXQ/mhI169SR8N03MZJaP4hc5/U7
         Y68xqwOFUJu5yye3K1J4GXggf6nRlCdi08h2F1f64ee3FILFskQeGXmz7dX8Kdt6LEXA
         DAFVaNIPS1JpGxoZ5OiMJSwjmI+OFqDDuwo8UB4xy1LXw3q0u1V1kadgXpWOzHB45i65
         ZYWnCzkSVkqGj0YzoFzawN2g9hKsI1PUKJX/uPdhmHDeFZ+JqSgtP3rgsKecpfYbHO3w
         anMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549745; x=1736154545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mHzGZQny5JmimEm0kycepUlCOKttN6NXbKtm7VNKgbw=;
        b=R3Dm+6OOj7UvsfBU72JeTIkdYr0w4xMaRJXgSi+jA0/f8dhCWYPww3GwVywNhy9haz
         kZGumvYYsAvHGQS2WduaZa2Zm3uTEB62XqnCe+J2Gp/tnn44zWz50x3YJU/YtSgPqM6K
         C4zgk7fbY/McDo6qDpsIFXJDY07QNI5OwP9KpH3/KNqlUdY5xpl3+e7SKJtK/bMZuFXM
         +Xa/HQjxcIN1dztDq5YyiCR9JLS/sVptOe0y/OwTsSfidhrNbMOhvNXYBksBLNpK2lL7
         swqOzF651C0F1s1Qlg+sMkEN7ikgbhv0NsyMNftJz5smweYUrCesBMueMcJMQXmUsxOg
         RJug==
X-Forwarded-Encrypted: i=1; AJvYcCXk+T1xFD/dIykVvhcNMpzt9tkuA3bJJuDxOfRLSHS1ubMxWVsan8K5pSPgknqqsPETuzhkkRF1zg6f@vger.kernel.org
X-Gm-Message-State: AOJu0YySnBvfEC2ADdRimQQAep4s/m7HZF/MCpakmH090VgmPWaQoXq2
	PE4K6heD/8oDU9FmGUZiKsqhRh4HmOMglQYwbP6v6G7IofP9pMMEqKOPZZeA8Xw=
X-Gm-Gg: ASbGncszaZYZL34kfWueSKXZGvm0YqQ3BHthcR1NtikAnDRy5oI9mCmoVByWg7mTbOa
	RV6n5hrL7lI7pXSE5IcyWxO2izK7oT1mSUTY/INLwj8NSBLvgtWKBXGWxCj64Dii9Nwxz2Fc/56
	JGFRJ0LJsnYFeVlQuOII1VUgNvp1I+tOSgb2lqT9X7aQRBmTWi9EuPV4IVOM+IOmFzoc3HI2W9k
	SPvfUn6D+/hJ76rdzWm1KO733WQw3f59nfBcafflyt5QcZvi9QTucR7sFrFTFKs9IfP7FRcbIOg
	SDwfjFC81+XWVV9n3cEKYw==
X-Google-Smtp-Source: AGHT+IEdmvGR6U/qwRYH5ruA02a+sFRctKWchidIfEBAoumo12DzBepIE5K3QuQVJJ60xG/AvigJ4Q==
X-Received: by 2002:a05:6a20:a127:b0:1db:ddba:8795 with SMTP id adf61e73a8af0-1e5e08028cfmr53967973637.36.1735549745320;
        Mon, 30 Dec 2024 01:09:05 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:09:04 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	agordeev@linux.ibm.com,
	kevin.brodsky@arm.com,
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
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH v4 02/15] riscv: mm: Skip pgtable level check in {pud,p4d}_alloc_one
Date: Mon, 30 Dec 2024 17:07:37 +0800
Message-Id: <84ddf857508b98a195a790bc6ff6ab8849b44633.1735549103.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1735549103.git.zhengqi.arch@bytedance.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kevin Brodsky <kevin.brodsky@arm.com>

{pmd,pud,p4d}_alloc_one() is never called if the corresponding page
table level is folded, as {pmd,pud,p4d}_alloc() already does the
required check. We can therefore remove the runtime page table level
checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
the generic version, so we remove it altogether.

This is consistent with the way arm64 and x86 handle this situation
(runtime check in p4d_free() only).

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/include/asm/pgalloc.h | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
index f52264304f772..8ad0bbe838a24 100644
--- a/arch/riscv/include/asm/pgalloc.h
+++ b/arch/riscv/include/asm/pgalloc.h
@@ -12,7 +12,6 @@
 #include <asm/tlb.h>
 
 #ifdef CONFIG_MMU
-#define __HAVE_ARCH_PUD_ALLOC_ONE
 #define __HAVE_ARCH_PUD_FREE
 #include <asm-generic/pgalloc.h>
 
@@ -88,15 +87,6 @@ static inline void pgd_populate_safe(struct mm_struct *mm, pgd_t *pgd,
 	}
 }
 
-#define pud_alloc_one pud_alloc_one
-static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
-{
-	if (pgtable_l4_enabled)
-		return __pud_alloc_one(mm, addr);
-
-	return NULL;
-}
-
 #define pud_free pud_free
 static inline void pud_free(struct mm_struct *mm, pud_t *pud)
 {
@@ -118,15 +108,11 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
 #define p4d_alloc_one p4d_alloc_one
 static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long addr)
 {
-	if (pgtable_l5_enabled) {
-		gfp_t gfp = GFP_PGTABLE_USER;
-
-		if (mm == &init_mm)
-			gfp = GFP_PGTABLE_KERNEL;
-		return (p4d_t *)get_zeroed_page(gfp);
-	}
+	gfp_t gfp = GFP_PGTABLE_USER;
 
-	return NULL;
+	if (mm == &init_mm)
+		gfp = GFP_PGTABLE_KERNEL;
+	return (p4d_t *)get_zeroed_page(gfp);
 }
 
 static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
-- 
2.20.1


