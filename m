Return-Path: <linux-csky+bounces-1823-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9002A433D9
	for <lists+linux-csky@lfdr.de>; Tue, 25 Feb 2025 04:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95DD9189DB48
	for <lists+linux-csky@lfdr.de>; Tue, 25 Feb 2025 03:47:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8A274D5AB;
	Tue, 25 Feb 2025 03:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XxJVPKXQ"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAAF1925B8
	for <linux-csky@vger.kernel.org>; Tue, 25 Feb 2025 03:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455211; cv=none; b=g2vZC/+sLMYjEjAZZ7S1YTMbtUCwNXaPHHEYsm+NFyZZ1Ny1L6D0O60Ip9H060S14WhXy/188s4HkviAfTzbwVPctM0AorApjypVEa6h5HcPdrinhAWNXihujsZHolyNj6m36ieoazzaIYC1IT1XOKcZWEwO/2/JBW0cAtsn+8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455211; c=relaxed/simple;
	bh=qOYOmYv6AcpiD6NAdQLP8Px3mufRdB0wo+qS2NmvqWQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cMLTVatJKdup4e+Ai/wuzpZJ1udU4xTktlRwfH9eC/fxbKoiszd4z/aZm3vqq0Oaz4mn/tMAU8gMoaBD6qK4FsL41sT448Bp655MO3P4n5s4H4KjBoERJZjG9+/rqL4Uwpv2c1SdOty/hJ4pHEYxhN4MYjXlO7ChE7qdMJh1kKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XxJVPKXQ; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2fc6272259cso8298681a91.0
        for <linux-csky@vger.kernel.org>; Mon, 24 Feb 2025 19:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455209; x=1741060009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WhvhnqTOqnsJRoRSYGkE7Nvf8aJcMBRIuvNZLKTVVg=;
        b=XxJVPKXQRhHu8vXHjLSJytIsBI9a9NMtzbR17v5ArbR6O9v4DosIc11N0Kzk+h4gVu
         KApjkrXOXpEWnMqunL3baMwyfjt6dZ4+odxhwoCdEejYmT2in6L4bHY70qe66MsLWBHw
         d5pAzp0FhB4gIZUs+yvBPJxNqiNM8fBseaWklJrBvV8uQmK5zyzdhEXKEYD1wAVtTco4
         ZdDE1gWA96Tq6D2d7OnUa1JgQZk1GOlhCVMEFBN6m5XlMLJFsYZw67Wh/A8z5uqhGy6f
         wJIqN6lsGUkzQeqlsv5j6GFAhIXsH14WYDzE+F3ypEqJLFTAvBRLHBOIJrksx7fSRs0W
         VVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455209; x=1741060009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WhvhnqTOqnsJRoRSYGkE7Nvf8aJcMBRIuvNZLKTVVg=;
        b=w/F26V5VT56k6AI+qLkhNaxv0GDelZSu52IH2KdVxlR7eqVsikFaVN5L9lQ7IYAXLO
         kFKx1aRGBItwKCKjnATr9zFJ24diLPdsJZ5R7IhZ8vGIzPc8hUnz5IZowBWaYUM6Rdje
         2kvqK5vlfpkn6R6VxyPaL0Pxyvga5ZAJg5rcCPjMfuasnJNtGF/XLH6nk/RStBrx+V6V
         wFk2BcYH4wzk50AZP+hKDC5cO5gemEWpCjLPPmAyXgOYtHcnVXKtQiu9J9BlamHt+Pxn
         0GeMwqj84V+/e4R+5929RQ4KXaEpsnA6b0sorSS7xSjTIyClNxFUsoAGl9P1FRottHgU
         MR6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVy17fTrc8FwDyRAqs7jFGJuIp6GdSl8Az7Rx/peabuXWvrglRcypnuZH72hggow9X2X9y5vbVil5Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzW6Qw3zoV2Lni9JVpRpqcHugIB0CEbuetksQB7eaIbvy+LJD/K
	gMIl5JpeAkrIWtD2EJ+uKkkQLOKgbKFNsCZcXDt66Fr9Q9RONEpS8JC3Qy4Y+eM=
X-Gm-Gg: ASbGncusNxF1e2+pXL6tGuH0wsdNsFgnpjZ4LzYTfzSMg46z9C5dutCKD60XkZRuIAX
	0pwjAXu0uqVB7rq+eFo2iWQtQkx7lDRbkuNd5RgdaMsliKyn6LuvrS+dBZ0YJIvu1bVpBUxhZ9X
	bE3i8J4HsnrxYAlH6bsZ1r2K/Zp07qxOpL7AAqbIU2SBMB6WkL5Is2cJ/lGkk4AsoXMu8lcK73z
	qWxw/wd5DFnVK4ky0zbDPmTsS4mfs9KOrZ0qdl19sfHcjxNVcq+LiFTIK2ZH9SBa4Gh+ZQ6fKW+
	JYQ3SjLwxzcHCqL2AjpCZn0IhsLybUYdcFQwXH/OgOSOFYCEHfVGXKO+vXolGBXaEw==
X-Google-Smtp-Source: AGHT+IFoZm5A7KJfLiXXGkFybdFv8MW6FGVkhPNKsRMzkFsrmZE9FMc5jXLgIOhcL2vDMu87N5uJKQ==
X-Received: by 2002:a05:6a20:7347:b0:1ee:e16a:cfa4 with SMTP id adf61e73a8af0-1f0fc78fb8fmr2712731637.33.1740455208891;
        Mon, 24 Feb 2025 19:46:48 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:46:48 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: peterz@infradead.org,
	kevin.brodsky@arm.com,
	riel@surriel.com,
	vishal.moola@gmail.com,
	david@redhat.com,
	jannh@google.com,
	hughd@google.com,
	willy@infradead.org,
	yuzhao@google.com,
	muchun.song@linux.dev,
	akpm@linux-foundation.org,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	arnd@arndb.de,
	dave.hansen@linux.intel.com,
	rppt@kernel.org,
	alexghiti@rivosinc.com
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	linux-riscv@lists.infradead.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v2 3/6] mm: pgtable: convert some architectures to use tlb_remove_ptdesc()
Date: Tue, 25 Feb 2025 11:45:53 +0800
Message-Id: <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1740454179.git.zhengqi.arch@bytedance.com>
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
tlb_remove_page()). This is the same as the implementation of
tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
convert these architectures to use tlb_remove_ptdesc().

The ultimate goal is to make the architecture only use tlb_remove_ptdesc()
or tlb_remove_table() for page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/csky/include/asm/pgalloc.h      | 3 +--
 arch/hexagon/include/asm/pgalloc.h   | 3 +--
 arch/loongarch/include/asm/pgalloc.h | 3 +--
 arch/m68k/include/asm/sun3_pgalloc.h | 3 +--
 arch/mips/include/asm/pgalloc.h      | 3 +--
 arch/nios2/include/asm/pgalloc.h     | 9 ++++-----
 arch/openrisc/include/asm/pgalloc.h  | 3 +--
 arch/sh/include/asm/pgalloc.h        | 3 +--
 arch/um/include/asm/pgalloc.h        | 9 +++------
 9 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
index bf8400c28b5a3..9d2b50265a8d8 100644
--- a/arch/csky/include/asm/pgalloc.h
+++ b/arch/csky/include/asm/pgalloc.h
@@ -63,8 +63,7 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
 
 #define __pte_free_tlb(tlb, pte, address)		\
 do {							\
-	pagetable_dtor(page_ptdesc(pte));		\
-	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte));	\
 } while (0)
 
 extern void pagetable_init(void);
diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
index 1ee5f5f157ca7..3d35d2bc42534 100644
--- a/arch/hexagon/include/asm/pgalloc.h
+++ b/arch/hexagon/include/asm/pgalloc.h
@@ -89,8 +89,7 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
 
 #define __pte_free_tlb(tlb, pte, addr)				\
 do {								\
-	pagetable_dtor((page_ptdesc(pte)));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte));		\
 } while (0)
 
 #endif
diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
index 7211dff8c969e..ac026146e7e95 100644
--- a/arch/loongarch/include/asm/pgalloc.h
+++ b/arch/loongarch/include/asm/pgalloc.h
@@ -57,8 +57,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
 
 #define __pte_free_tlb(tlb, pte, address)			\
 do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte));		\
 } while (0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
index 80afc3a187249..ddc24812f1832 100644
--- a/arch/m68k/include/asm/sun3_pgalloc.h
+++ b/arch/m68k/include/asm/sun3_pgalloc.h
@@ -19,8 +19,7 @@ extern const char bad_pmd_string[];
 
 #define __pte_free_tlb(tlb, pte, addr)				\
 do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte));		\
 } while (0)
 
 static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd, pte_t *pte)
diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
index 26c7a6ede983c..7e73d2f913dd4 100644
--- a/arch/mips/include/asm/pgalloc.h
+++ b/arch/mips/include/asm/pgalloc.h
@@ -50,8 +50,7 @@ extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
 #define __pte_free_tlb(tlb, pte, address)			\
 do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte));		\
 } while (0)
 
 #ifndef __PAGETABLE_PMD_FOLDED
diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
index 12a536b7bfbd4..4b4a1766e2cc7 100644
--- a/arch/nios2/include/asm/pgalloc.h
+++ b/arch/nios2/include/asm/pgalloc.h
@@ -28,10 +28,9 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 extern pgd_t *pgd_alloc(struct mm_struct *mm);
 
-#define __pte_free_tlb(tlb, pte, addr)					\
-	do {								\
-		pagetable_dtor(page_ptdesc(pte));			\
-		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
-	} while (0)
+#define __pte_free_tlb(tlb, pte, addr)				\
+do {								\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte));		\
+} while (0)
 
 #endif /* _ASM_NIOS2_PGALLOC_H */
diff --git a/arch/openrisc/include/asm/pgalloc.h b/arch/openrisc/include/asm/pgalloc.h
index 3372f4e6ab4b5..2964e26980a18 100644
--- a/arch/openrisc/include/asm/pgalloc.h
+++ b/arch/openrisc/include/asm/pgalloc.h
@@ -66,8 +66,7 @@ extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm);
 
 #define __pte_free_tlb(tlb, pte, addr)				\
 do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte));		\
 } while (0)
 
 #endif
diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
index 96d938fdf2244..c376d4b708fda 100644
--- a/arch/sh/include/asm/pgalloc.h
+++ b/arch/sh/include/asm/pgalloc.h
@@ -34,8 +34,7 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
 
 #define __pte_free_tlb(tlb, pte, addr)				\
 do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte));		\
 } while (0)
 
 #endif /* __ASM_SH_PGALLOC_H */
diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
index f0af23c3aeb2b..a70151cfd11c9 100644
--- a/arch/um/include/asm/pgalloc.h
+++ b/arch/um/include/asm/pgalloc.h
@@ -27,24 +27,21 @@ extern pgd_t *pgd_alloc(struct mm_struct *);
 
 #define __pte_free_tlb(tlb, pte, address)			\
 do {								\
-	pagetable_dtor(page_ptdesc(pte));			\
-	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
+	tlb_remove_ptdesc((tlb), page_ptdesc(pte));		\
 } while (0)
 
 #if CONFIG_PGTABLE_LEVELS > 2
 
 #define __pmd_free_tlb(tlb, pmd, address)			\
 do {								\
-	pagetable_dtor(virt_to_ptdesc(pmd));			\
-	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
+	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pmd));		\
 } while (0)
 
 #if CONFIG_PGTABLE_LEVELS > 3
 
 #define __pud_free_tlb(tlb, pud, address)			\
 do {								\
-	pagetable_dtor(virt_to_ptdesc(pud));		\
-	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pud));	\
+	tlb_remove_ptdesc((tlb), virt_to_ptdesc(pud));		\
 } while (0)
 
 #endif
-- 
2.20.1


