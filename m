Return-Path: <linux-csky+bounces-1544-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7ABA053B1
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jan 2025 08:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27E63188716A
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jan 2025 07:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105CF1A840E;
	Wed,  8 Jan 2025 07:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D36doFD2"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6B911A9B4A
	for <linux-csky@vger.kernel.org>; Wed,  8 Jan 2025 07:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319637; cv=none; b=b8BC2ik7B9fCQfzaCXy30U9u55EZa/wF0D1m3+59EvNCrNEOSqy75j7ntRp/gN9SMOaQ0iGYfl5kD8H74JIR4m8LzNOKgvzm3V544jMZKUowg3EUHiBnqK8/k4/ctH9dfe9pddBbMC+Gp5EwNXhm7IMhzk/0N0FcNEtjKWzKOso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319637; c=relaxed/simple;
	bh=8PYWh2+orWwYf6986S1qPEzSyDMn0jEmjPeP/Gs1msM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f9Z6BZI5FqlbYUN1Hh6PmZA4E5xQO1unyBsRkCPUikEeCMU01sgniitmxpNTO39DKwob0G/xmLNxZR06oHxfWn875NqgLwqim0fFgRUqzGtGvyi2XGriQWtn6o5BOSyAmyl2Y5VoBolOtIcBlZk1YPmCxw+VQ7/RZzIAS63S30g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=D36doFD2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21669fd5c7cso246561015ad.3
        for <linux-csky@vger.kernel.org>; Tue, 07 Jan 2025 23:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319635; x=1736924435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3ajwCEJzuBWHLhfIS3uOIg9mbtSga1CIaOnP3nLDr0=;
        b=D36doFD2eeEmR2bn6CJX8f5wpGnEPnzm3By1w8nWkBeMfXzl3kPPwr4mbqOkXEZhov
         VrwoHhOaSlU+az/WyLPiDSwtFodV/d7k98qHBI47BBbBmYjGz7mLnhwnUKtd9lRrnBFi
         bhczabQP8GmoHfwUxnHtM0Vh0K7nIolVZ4keO6qU+QqCEJjqJ1t+1kgiuPAylWLj3lf7
         OYlKkbHZQNSSaIU8ju8jUadGcCbCbdPcu1WPO2WK/TdX0ptilPW+h759vInIarzE90sV
         78hM/2Eyh7svckrSCheuAzoM3IR2SdV33HEvReFeV1KYoQqUzwFE4/vjdTllVFU7wCtY
         0s4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319635; x=1736924435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3ajwCEJzuBWHLhfIS3uOIg9mbtSga1CIaOnP3nLDr0=;
        b=XwASUvpqfjyg3089nRYOsqLGGAmnxEZz/MmfMdw4bULtBsiXD4u4zE8hl6AYZ3sZcj
         Da4qDP2EdkpdzGYTIpyLPSf+QD1WHyI7tH0338xjZ5u0jtr5Zc6i4tfutws5ZjaKUCOG
         6Ih5C5+MnBo988t5Fi+wKvVNvJ7BxIpmeDBifFEiD4LSYL+xMtwQ+Hgu+P3NRHJWqXbn
         6dxQUSx6NXzuqj1E9y1yofrT4R7m/4rIhsNPsCGxz0nXQcqrYgtCeBe1AGY9swFWZq5z
         v1JjWLGv65stZK8zEN1uGmwN4oIepyS0uLD9JjvDaN3zH380h9wFuVJlDisMi4VSG3i6
         Hyng==
X-Forwarded-Encrypted: i=1; AJvYcCXZHCan8pbMPc/MzdxxGXQaal8ldvAJC09N3YF3iRKIAOT7vYHVbZXaHaxkVaLRAVQUt7rJv2iAhtEG@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm0PqXgVrOlx1PUjt38uoPWzomtScKUH+B5DO89TIk0L/z2fdv
	Up7w6vxckQIbRCgP8A28MGrd3VUBucwbqKsnC6UbLp3AiLXTdGoHU842pbfn7V0=
X-Gm-Gg: ASbGnct7ZwatIBDEfnBnN4iJ56RADqyFPmPJWWPuMaisIhcHu0DgqLnuVFhoj/b5ao0
	+RaK4htcGVNXwkyIYNmSP9FsK38HcZy9wbJQjjKMxKamOfMS9iG8il8O2kvbtzisEcxHzGXmeBu
	Pu3Hjk22qYa8eKeL6abu2cahlYt1pFwZgPYc1OEsskbkFbFZ1sUpa4SOVPEmrNgnPRUZ5RX3FNs
	WG6P6MXsxZ2Y5E3l1vhZ5gpLBgzD1X6dcYE5yYmaZat/yuWeNSk92Xaa57p+oXY93fOKnHCoh8t
	iKThVDBvRnpPPQC0Ahbwpd7UpDY=
X-Google-Smtp-Source: AGHT+IFQatZJEh1vMaYN2M2lTtxd4TB3DgwS5fDlIHVUeP0cQjVCzCSP2sGAFE7qJT7hKS5hKn1bKA==
X-Received: by 2002:a17:902:d4d2:b0:215:9642:4d6d with SMTP id d9443c01a7336-21a83f55157mr23731385ad.17.1736319635015;
        Tue, 07 Jan 2025 23:00:35 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:00:34 -0800 (PST)
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
Subject: [PATCH v5 05/17] arm64: pgtable: use mmu gather to free p4d level page table
Date: Wed,  8 Jan 2025 14:57:21 +0800
Message-Id: <3fd48525397b34a64f7c0eb76746da30814dc941.1736317725.git.zhengqi.arch@bytedance.com>
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

Like other levels of page tables, also use mmu gather mechanism to free
p4d level page table.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/include/asm/pgalloc.h |  1 -
 arch/arm64/include/asm/tlb.h     | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
index 2965f5a7e39e3..1b4509d3382c6 100644
--- a/arch/arm64/include/asm/pgalloc.h
+++ b/arch/arm64/include/asm/pgalloc.h
@@ -85,7 +85,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
 	__pgd_populate(pgdp, __pa(p4dp), pgdval);
 }
 
-#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
 #else
 static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
 {
diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
index a947c6e784ed2..445282cde9afb 100644
--- a/arch/arm64/include/asm/tlb.h
+++ b/arch/arm64/include/asm/tlb.h
@@ -111,4 +111,18 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
 }
 #endif
 
+#if CONFIG_PGTABLE_LEVELS > 4
+static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
+				  unsigned long addr)
+{
+	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
+
+	if (!pgtable_l5_enabled())
+		return;
+
+	pagetable_p4d_dtor(ptdesc);
+	tlb_remove_ptdesc(tlb, ptdesc);
+}
+#endif
+
 #endif
-- 
2.20.1


