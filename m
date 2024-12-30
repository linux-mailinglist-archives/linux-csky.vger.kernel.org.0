Return-Path: <linux-csky+bounces-1459-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E9569FE478
	for <lists+linux-csky@lfdr.de>; Mon, 30 Dec 2024 10:11:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D617E3A228C
	for <lists+linux-csky@lfdr.de>; Mon, 30 Dec 2024 09:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008FE1A725A;
	Mon, 30 Dec 2024 09:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SMYXNOOE"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227431A239E
	for <linux-csky@vger.kernel.org>; Mon, 30 Dec 2024 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735549834; cv=none; b=SOtpzaGi+bwPAlVAKkmc5OgIwaGLttMfT3qgmmw8FhE0SJmeLsERDqASk/076nG2dncZm+nq0lerDi20ksz/n8CDQJ77LIkT67wNc6sieoLOP3RGHjk50uknTsfkF7MgIwHlOqxYBQE1SnDcK7DRlnx00El+rkbwnbN9JBglMnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735549834; c=relaxed/simple;
	bh=w9Tb6kkg2Q49UGEfUZpSUyo28N/wow0+21NvTYUEzY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a0zkjgkci2zIHSWXtfhy9Vr3T8nK1CvPLZS+zyONZTtmLoduJVcsOVSaEBBMdw3QRb41XiOfDt+8BzX3tzn3t/RmS9V4ZPb/ujPvVvTnAXQxlJM/5HSNH18bI8ZB5NPmQ3bWV0aUs3JQyCyMVRwXtuyv7dOOycInH3Lenfyn3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SMYXNOOE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2165cb60719so116242025ad.0
        for <linux-csky@vger.kernel.org>; Mon, 30 Dec 2024 01:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735549832; x=1736154632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=SMYXNOOERJ1ARyKG8MiDTgatbG+eULYxRlgQScb+bpKUq3Zq2boEUN08L5OOeHUkaY
         XEEVRHousYEFM98XYCW7AIpbW3FQjJ6fD5YBJBBBmw+oa+jjQGlMz9L4pxpTjhtDHOc+
         mzKJziqgTQCMgBTHzj2YA8F1aWpYo9nvXIarhYF86JwCQeoxb+lUkw+oa2X6RSW4W/Ky
         6WVpzuT/Z/O5vWT2bjKx46iOw4QX9zLIN7W2nm16mDkfWzkeDn+RflIkDsdGtntb1nSB
         sRfvEio/iYoSPfgmK0uOUW6TRrFBXYwATq/kmJaAjmKmADifjbYyxMmfkSU2CA+OWdvc
         +c9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735549832; x=1736154632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=Td+xlNLkvt22Fc7VQJZMxLaZ/etw6jaSo19lsKVkoZ8HqslZ7kdXXDmstblIuZcas/
         T1IQAOXh/0GN7d0i+vO7OSctlEXNNI/lxJlSS45L6zv/v1QLEzyQhzzfgxGN1LQv3VLH
         Tvk6zM3lh/kcYpgofsRzjagmRsVw5OGRtEKGC52+OqvZ/wD/OIQ/hmB8b9FRxlf1BQar
         HLBqlp3RAoGKStg3N4CHMSY5soNe90LegchQ6CKeokcwtOUUKXucmRKxCqw9R5cMT4qF
         yh35ma180m5t3fMS7JJvpxRUsomvPk52Ucx8b65IyDOctO5TH1dyN3xgmKbPNudn/414
         JVww==
X-Forwarded-Encrypted: i=1; AJvYcCW8fR9L5yNIqctQSnDK/cHHyHaf4VmqCg5LJ8Xd9m/peC1Xy2HSRV0awIOIH3Q6ASelqH/FMtpf5TUf@vger.kernel.org
X-Gm-Message-State: AOJu0YwBG5rV8cxgxgzLCbiNbSGR1ctmgiz6fzV54SQgpNUNPMipBix8
	H7q2zc+pCWNshwWCPwasR7KBJW/8hfkTxFdWKVE4wGAUbgJjRl2LesN7fcme48M=
X-Gm-Gg: ASbGncswG11mS5/uwIlyA2wbno1gHwS1/VUj5Y31NtfwYad5efVmVD3+gQpoECLJRiF
	B0mNeM6zCUrgcup0a6SwNbn1+GSpDfmcEteCFau8eEH18o6uYg62w7K+96afKBs3vp2LDjB5Bql
	9l8cBAJC+OAuyrI5jsruFP2cgCPIXGuxBLVmO9xemg+r0JJsPpsx5z66n9YKhW+60umbai0X7x0
	VhCLSbjqh3KRYghNVu51yK0Qqyj70fJwkcWWvh+QTi0OUsefN/wf8C7Exuc8Qwlgls56ilVo29n
	HkI75hoP8HLPlN6EfM1Hqg==
X-Google-Smtp-Source: AGHT+IGwnjGmNRtsc6wvIZAIM8FV7PRxiURIME1KaVRQ0EplG8wu3sXxm46oGULh37KJjV0x+YOVDQ==
X-Received: by 2002:a05:6a00:2181:b0:725:8c0f:6fa3 with SMTP id d2e1a72fcca58-72abdebb85dmr42631070b3a.22.1735549832564;
        Mon, 30 Dec 2024 01:10:32 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-842aba72f7csm17057841a12.4.2024.12.30.01.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 01:10:32 -0800 (PST)
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
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH v4 09/15] arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 30 Dec 2024 17:07:44 +0800
Message-Id: <df71d1bd87ace445383b8ae62087ae14e35eac3b.1735549103.git.zhengqi.arch@bytedance.com>
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

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/tlb.h | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index 408d0f36a8a8f..93591a80b5bfb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -9,11 +9,13 @@
 #define __ASM_TLB_H
 
 #include <linux/pagemap.h>
-#include <linux/swap.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #define tlb_flush tlb_flush
@@ -82,7 +84,6 @@ static inline void __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte,
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 
@@ -92,7 +93,6 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
 {
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -106,7 +106,6 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 	if (!pgtable_l4_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
@@ -120,7 +119,6 @@ static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
 	if (!pgtable_l5_enabled())
 		return;
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 }
 #endif
-- 
2.20.1


