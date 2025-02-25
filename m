Return-Path: <linux-csky+bounces-1821-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05567A433CA
	for <lists+linux-csky@lfdr.de>; Tue, 25 Feb 2025 04:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45DBC189D286
	for <lists+linux-csky@lfdr.de>; Tue, 25 Feb 2025 03:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47884156F39;
	Tue, 25 Feb 2025 03:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XqQAFeu9"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CC87FD
	for <linux-csky@vger.kernel.org>; Tue, 25 Feb 2025 03:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455191; cv=none; b=j6gxTcK3/Id5uLMmTx4uk1QJCEfS55eopYpoRM6KB+JJL7HT0nrw67hNwghDjO06IcO1Ozc2BrvtKyVbQfNlrhqU7uT0gdL32Tz9kjhrGLwxE/Cwwv0d9c8pO2AdpwrPAjVm3AdKUvRB09Bx5szrtJTbx8eHNcSuFHjZY691lco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455191; c=relaxed/simple;
	bh=+Ao5l71m8R2KBR4pKhSeuqtrK/FFUTZNCirhHcI/U+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QdVmgwMxw47F0LU0UZLjWllPCsi+X2s3Bf0REKL/x2pMC4W3fzR0B3ZSX4syV5G5atEuJPBduK9zXkIThSUmcaxvM4apYaGKMpcaUmzCb1xFHL3UX9NoAw7Cli93mTb4jwh5MKYPjZXcIPkoLQJ0SpBVbdxIFd2jnuIwAfg19dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XqQAFeu9; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-220bff984a0so108511995ad.3
        for <linux-csky@vger.kernel.org>; Mon, 24 Feb 2025 19:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455189; x=1741059989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0Ocxe5/W3x8AaSNUp1nmQA6Ns9xuyK5JD/uD9z0OJg=;
        b=XqQAFeu9+jAY7gKK2np4vO4g91b9uWMd/6TX7uoukDIaD/obEG/vESFDxfKesdbDoM
         DUhZSnz6YFmvEDmpJ/nWXcwRcGca7LDIIKRDNxDtW2hjagjoenxWRFn4/kcvQXf3ACwl
         zJDVmBz48yBwHLGQMaHqSbxVJmbCZbQdfveZIEfNlYxG/y799JFM4vRo7yeCq+nhdKP1
         Q+5kr2LA3g3RrNO2bmwI2bN4c50lMhba78Jbd+BDEVb4CwQBNN9S1j46EM/7O6ZtGOUC
         k7tXgspl9UxEDV8bfxvY+EQ3QwjNTMjGgtNLzJafFP4GWzb1jmwV2nUqgBedoxCyHI37
         fAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455189; x=1741059989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g0Ocxe5/W3x8AaSNUp1nmQA6Ns9xuyK5JD/uD9z0OJg=;
        b=CG2WQPLG8H8Dg3Lmb+sgcwXYIQvzUuEFqKPcwFfBIxE8Uip/S79/ifuHI4Kzk86GzO
         OPOA+QRPXz48/R2whcLXxfIAAtwBOX/5bs/Y2WSKlVT5clM+ooW9x+KI0EnQZSlWAbAB
         p+deLD8iPafPBB9oni6GuF6ogds+7O5rxMsdrHDKGo4Vkr6Vi3mvRlMGSdzTrQf2L34L
         cb44WVaccAMxPqV7abIIkSAhY0AnjrvIjKaaBIvtv84Dh4I01Aea3NGt658JPO62Fa1r
         +m8OMGIP3l0KH0duH7/1FM62FCcH9sKrD7qxpamTY2S5yyHP8sZNx6pk4+9bUcn4QNZS
         NAZg==
X-Forwarded-Encrypted: i=1; AJvYcCX7zqQtY036lISbn49m6/Vv54AWOe7jNHDKrk7M2AMx25+Gz46ZD7Uq2ZkZzNoMRGn3jMcRwR+gd6Fb@vger.kernel.org
X-Gm-Message-State: AOJu0YwyrZMhIeU69+c4+IBLX3yVG8FmM6YQGNGx8ZlnYaZXCGbI9wFk
	z6c9pbtpKq1JAJ7uCa6re51gG5X73NqeocfGwI0vDPHKfgZ0nCqSEv4zOsSgxfA=
X-Gm-Gg: ASbGncvYI+8DeGtAQ6j+duuE6/Wu6TOb3HDa64EsPD1G2+WLM+oYNaskrODXNDLCnxp
	tPKZAQfySBh14LZg+trEN1CIHyvQ487RHhiqa0kyghcTKKfRUJKcE3ecG2+rClX7fQNbJt+is2r
	+V0/1k6BdijQprnMyVMK4+SNG7VDbOlZiZNXlulxaWpBVkxgPoGq0I28/b9EzeNiiMH3PArw4dA
	2uZqqEkO34K8ATdM7Ub52kfoRutBuv9ISu3g6lBKBT5bA4jKEZmrz0uHLEo03T5DJGKvDb9WSF7
	vvfw467t5kLBZiLgEB1eZqUfMkB3HrJVk6Y96FsNCiT8cov/XtbbjuKGzdD4atJh5Q==
X-Google-Smtp-Source: AGHT+IGBfXw23ytiI6FvQDqnu6HA+6X81xKlY5Cdi/AJkyrR2YGvsG8wye6vZ+K3tNu1qHLJYKOiEg==
X-Received: by 2002:a05:6a00:22c9:b0:731:771:38f2 with SMTP id d2e1a72fcca58-734790de607mr3427312b3a.8.1740455188892;
        Mon, 24 Feb 2025 19:46:28 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:46:28 -0800 (PST)
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
Subject: [PATCH v2 1/6] mm: pgtable: make generic tlb_remove_table() use struct ptdesc
Date: Tue, 25 Feb 2025 11:45:51 +0800
Message-Id: <5be8c3ab7bd68510bf0db4cf84010f4dfe372917.1740454179.git.zhengqi.arch@bytedance.com>
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

Now only arm will call tlb_remove_ptdesc()/tlb_remove_table() when
CONFIG_MMU_GATHER_TABLE_FREE is disabled. In this case, the type of the
table parameter is actually struct ptdesc * instead of struct page *.

Since struct ptdesc still overlaps with struct page and has not been
separated from it, forcing the table parameter to struct page * will not
cause any problems at this time. But this is definitely incorrect and
needs to be fixed. So just like the generic __tlb_remove_table(), let
generic tlb_remove_table() use struct ptdesc by default when
CONFIG_MMU_GATHER_TABLE_FREE is disabled.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/asm-generic/tlb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index b35b36fa7aabf..54f579750c8e5 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -232,10 +232,10 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page);
  */
 static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
 {
-	struct page *page = (struct page *)table;
+	struct ptdesc *ptdesc = (struct ptdesc *)table;
 
-	pagetable_dtor(page_ptdesc(page));
-	tlb_remove_page(tlb, page);
+	pagetable_dtor(ptdesc);
+	tlb_remove_page(tlb, ptdesc_page(ptdesc));
 }
 #endif /* CONFIG_MMU_GATHER_TABLE_FREE */
 
-- 
2.20.1


