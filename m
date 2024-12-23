Return-Path: <linux-csky+bounces-1435-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF7B9FAC85
	for <lists+linux-csky@lfdr.de>; Mon, 23 Dec 2024 10:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB25F1882942
	for <lists+linux-csky@lfdr.de>; Mon, 23 Dec 2024 09:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4162D1A8F7A;
	Mon, 23 Dec 2024 09:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="IZ3BPeGq"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7230B194A44
	for <linux-csky@vger.kernel.org>; Mon, 23 Dec 2024 09:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734947100; cv=none; b=B40hOxYWMSunUCk+3rU0leiFyJGk0FF/OGu+zI5YuFret2XoIMwCSFwYF4nV5VhReB87A5NhjzjtSdN8nx26OVjVtGNLny4kbRHf7c5kgXL2K7nwM9jzUrTYQBvtSUNEYJ2Tt1tvVNE+iJ9JuNqbCEBXdyE+FxPQCOdyaphdcgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734947100; c=relaxed/simple;
	bh=w9Tb6kkg2Q49UGEfUZpSUyo28N/wow0+21NvTYUEzY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4n1J2Jg9HPAH7v1thKXXRBuEMKsjfQdpGxgi/azZOjVVX0fbfR2KyMpLf8npA/e9Pg3tiBn7Iv/EKgTAfU2FP9HpdGsAmo9WcJoRNvSTRdKPQU9BubcNJ0ghyRk8W4TM7MpVt3TiaZ8EnbPR7qSoWDhT6zT3bu2blT78AQBKXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=IZ3BPeGq; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-728ea1e0bdbso3575260b3a.0
        for <linux-csky@vger.kernel.org>; Mon, 23 Dec 2024 01:44:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734947098; x=1735551898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=IZ3BPeGqREjYEkMakR8CC2iUnHDDNsFV+SUiQ5Rh+kKC1Voz/zW3kW1AqvJIQr96Pv
         Pn4vAaQAOdSAN2DwUNM621Wc+nd9U2bHTPDBu7o7MWSd8JcT9Ts8XoPEmWGH86KaQoKP
         IDr3ALL5a6oA+2iVxE1gqf+cd3Rv7qurRyGZjqj+tAT8FJlNgdyf3GRRbq665CN4Nnkg
         cdW6OUjO73QBCBhhlKu+9ZAwtkxylw4V8mRXYT53HMP719GfPweSgNPj2yBXG4orTfaS
         Uj+Gn8qfWjOwXlFS+kJjdbs8jY9SOhOWOZD6mcRzI6kZHuLiYpTq4cWbSXeQFCFdB9y9
         zPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734947098; x=1735551898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0nJ0bdEaVLB0+13gaCQHdoBfFkuXXT3Pqta7GOjv8Bo=;
        b=OwzGpbLGWHCUOLFGXjWeuGru07gdNxlmkM9ou1A7iR6MbGJK9q6eEj8SrdwZuZ0awX
         TjZf21axbW/KA8J6krGM0jOwBLFK5H9FpkMP73r8d7oT1ncBOnLhcSj6tM4x/zW/sJwu
         Px26HBoo0DzlNbZ8lBzx4vo0HKXU5Y+OeASHApXkuKxXEK676gGNiwT7ohemIFMTHHFB
         qymZTGgkbGHuU+Zjk/NC0YVI/Zf1WxuTKd4htKYjaZR2jPM1Xfti7wX9C9CgbTQzMqn5
         7UnI5KO8LFVn4GuJy2GklZqlQiHkgTLDhObWJyUK5kpEFkkb4QIBlhqp43jVReRCDMCd
         EI5A==
X-Forwarded-Encrypted: i=1; AJvYcCVuvo22HBdEJIb6XnRz1wNjanTh8CgWL8ly+sx85Grg40CTqJhBwUhtDsz1nH795HQstWX1wOPF0Wr+@vger.kernel.org
X-Gm-Message-State: AOJu0YzzAJZYkOeXK98xFBOKg1jfiVBtC4/0+GiS3ZmSVWKY7t36/V2Q
	dEiiu4DrMsfS+Hp30c99Z5CwDlEtp2mSl65Ezq3TzgFeL9nIAerdH49bClcEEZE=
X-Gm-Gg: ASbGncvrk+cfl014JtKCyWAdcSWi1sil+tyqlVnsxQB/Mul2xESaubhPAZBc5uWGBHn
	DmIADdNsFS6pf6PCacWodpNLaJBbNFLU6SXzkRkwlNpvnQxq+wnEcAOpxb0HBRSYajAHm+Do80y
	fRjOLnvoPRHLFKdW/hbF5SQeL7gEUURjSFksaaEJtnNyB6aJFRo5I3pjUSXEHhzuNHJzyXvjz+D
	FarZMVrX4vH9CbFcLU+1DLpjbiGcDse+VwcVOJZhzuQNTKZI1fkSqaUXlVuFFsjIz/9piV8t9aW
	GK7F5EM3Ho4uhFmYaMqTGw==
X-Google-Smtp-Source: AGHT+IH27a1l8kT42WYYi2KTFhW6smXjjCcrkYYj/EF7HLDGUXcMfllZ3ayHCCSFU+IsHMUxZvkRwQ==
X-Received: by 2002:a05:6a21:6f87:b0:1db:c20f:2c4d with SMTP id adf61e73a8af0-1e5e044b1c1mr19165305637.2.1734947098042;
        Mon, 23 Dec 2024 01:44:58 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8486c6sm7468309b3a.85.2024.12.23.01.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 01:44:57 -0800 (PST)
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
Subject: [PATCH v3 09/17] arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Mon, 23 Dec 2024 17:40:55 +0800
Message-Id: <df71d1bd87ace445383b8ae62087ae14e35eac3b.1734945104.git.zhengqi.arch@bytedance.com>
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


