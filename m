Return-Path: <linux-csky+bounces-1547-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A78BDA053D8
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jan 2025 08:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C671887555
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jan 2025 07:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17301E47AD;
	Wed,  8 Jan 2025 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="jzhuXRQy"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6F1E22E6
	for <linux-csky@vger.kernel.org>; Wed,  8 Jan 2025 07:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736319683; cv=none; b=MMhDMkrg4jHpJeL/iSTJUQ9ZQf8hE+TAw4MW55uUGmSYGorrxt6Npvhjbu008SL3F21zPx7pK1c0Y8t9GDhZGZPBMthY/Ry98C41u34xq2nQe+dWXNgam4W469eDBXMeAq4AsdTlBOCCfhV5ivFCNGr1XHTY7bcfhNAQRyyu0rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736319683; c=relaxed/simple;
	bh=wfTgGSVhXTkiP60cV7XgYAcbBAoscYS/kqOY2RPeVxA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PBPHP/BzfYOum2mVefTIaXt26Iay8oFzgkxltPFlHlIucAIiu5GZdOEx1UtSq3IFgne9fxFxdKj8qBbcRJxvdEluhCgq9XMhrZfpDINrkAm2EkrPV76qgjW74GAMOft5tXjFrBzYtNQp/2k3t0e6SpuxC6dISzlnjshykB6W6+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=jzhuXRQy; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2163dc5155fso239942845ad.0
        for <linux-csky@vger.kernel.org>; Tue, 07 Jan 2025 23:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736319680; x=1736924480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRYydr57EpvJJkVepk/VS3bq1fMuYMijkZdKL5zejaA=;
        b=jzhuXRQygiP56bBOGwYPpbPtA5GEJz1GaN11tiBhJYnUV114ySJcMCAR4Vl+T6q7iB
         iO9qveGtmAH/WLYpOnkh6/dQ4fWRdvMBfQkgqPlto4qRGfb24KnxiIpSTcAjkUG5xJsW
         6vcIMFe9+GK1j0KNvpwYHFkFKfOIdYXc7cJOcNkjfpRMruUxLep7SGgaYlmoaWVVHOLz
         pL7s9qE7xJ9WxO4pGKdd71605tq/4DHIUMhLXggZULfR7eGOU/yxQ09VIcxeQyYh3b10
         KrZxsMr40DPAULhPtjk37jYc3p6WqftsSh5wCMycWAPG2NO7InOzihDWbXycUDdm0j4K
         TlCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736319680; x=1736924480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRYydr57EpvJJkVepk/VS3bq1fMuYMijkZdKL5zejaA=;
        b=tusaRX1kr30pMM4AjWEg3C496idUMDB3Hm/zOO0fU8uuNXQMArXlUsenKcBH1Ne6pa
         eVhVbpbLRZ2eESUz5k6wWUct8tSR0tkkr39pr6icOXfCe9AD8VswA9gWHQ7GG4ddoy4D
         eWYnN8Wd/hRCEmqpW6BeDe1Z5n6nZYql58mSGM2x6WPutNdT1Psu21DELoxnBUOI7I7K
         Czwtm6eZOj0zO/Hmz84TdM9UE/Fyipm07klUXOEtuSQDNMnc1vcZ7OUf6Sv7aV6tFJeP
         CuW2OaewuRcut96VUfO2B6kpvfkrypR6DDZ/ukrjIjPVqXQo1jQfOOOmLoKkPD7QBZEB
         ok7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9JvXusz3iqx9fUe2Kc6/mV4ad1KfzLPQQoA3wyqKmO1nJtOKWStSI3x3FI4xYBqi1sVVOt/Xq98ZV@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Bmk71Eu+HCXPKVCpp6Wovvvi9EZFobnPnCHWcjv78Ctug9PU
	gyYMmMKPONfVOBIuEYIkt9JNC5a6IHdY3zi6rbQ6wKyyLhh16coemCUXtTIGyRk=
X-Gm-Gg: ASbGncvVSs1dwrM0YH5yzKESBkKiKJYOp6JEHifY4HSh3d1zh5/Ob3OdS316KUIEWem
	fkBS/BMnYXGPNtnmyEB17K4Om3dJnPnOO0hcNVxQFfgadmkKAMUOUgchGT3k4X7ADTfkAGwoczL
	cgvkM2y+gfC6FGupbJJ0Fuvo6dKGHg2pzVlCtqPCM1nrjVvep4O30FTNXNunxpaX56LXSYNUAaT
	QktKSBuDH5xCdGsISDmIBEecpdQMNcD9WS9q6lO8hdJCB9YQrMe9BSOJ4VCBnJw5s9guSBPWWEx
	fycgNqwiMtEOc4YLqTTtPk2XdFw=
X-Google-Smtp-Source: AGHT+IGA+MEO+KKVHOehVcxKdAaP4kVFc+4x/MGW5FidU7ZYZhG+ejtfRbHdQiRj7WdzfqmV0LUjgQ==
X-Received: by 2002:a17:902:d352:b0:215:8847:435c with SMTP id d9443c01a7336-21a83f4b133mr25527805ad.12.1736319679689;
        Tue, 07 Jan 2025 23:01:19 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca023a3sm320067275ad.250.2025.01.07.23.01.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 23:01:19 -0800 (PST)
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
Subject: [PATCH v5 08/17] arm: pgtable: move pagetable_dtor() to __tlb_remove_table()
Date: Wed,  8 Jan 2025 14:57:24 +0800
Message-Id: <327b4b8990729edd4ce97d9d5acbdaff2d9fa1d1.1736317725.git.zhengqi.arch@bytedance.com>
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

Move pagetable_dtor() to __tlb_remove_table(), so that ptlock and page
table pages can be freed together (regardless of whether RCU is used).
This prevents the use-after-free problem where the ptlock is freed
immediately but the page table pages is freed later via RCU.

Page tables shouldn't have swap cache, so use pagetable_free() instead of
free_page_and_swap_cache() to free page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/include/asm/tlb.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index ef79bf1e8563f..59854c6b97bc5 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -26,12 +26,14 @@
 
 #else /* !CONFIG_MMU */
 
-#include <linux/swap.h>
 #include <asm/tlbflush.h>
 
 static inline void __tlb_remove_table(void *_table)
 {
-	free_page_and_swap_cache((struct page *)_table);
+	struct ptdesc *ptdesc = (struct ptdesc *)_table;
+
+	pagetable_dtor(ptdesc);
+	pagetable_free(ptdesc);
 }
 
 #include <asm-generic/tlb.h>
@@ -41,7 +43,9 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, unsigned long addr)
 {
 	struct ptdesc *ptdesc = page_ptdesc(pte);
 
+#ifndef CONFIG_MMU_GATHER_TABLE_FREE
 	pagetable_dtor(ptdesc);
+#endif
 
 #ifndef CONFIG_ARM_LPAE
 	/*
@@ -61,7 +65,6 @@ __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp, unsigned long addr)
 #ifdef CONFIG_ARM_LPAE
 	struct ptdesc *ptdesc = virt_to_ptdesc(pmdp);
 
-	pagetable_dtor(ptdesc);
 	tlb_remove_ptdesc(tlb, ptdesc);
 #endif
 }
-- 
2.20.1


