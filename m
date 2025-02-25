Return-Path: <linux-csky+bounces-1822-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD5DA433D3
	for <lists+linux-csky@lfdr.de>; Tue, 25 Feb 2025 04:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8569317B0DC
	for <lists+linux-csky@lfdr.de>; Tue, 25 Feb 2025 03:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B08156F39;
	Tue, 25 Feb 2025 03:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bWOqBTe0"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D3B7DA7F
	for <linux-csky@vger.kernel.org>; Tue, 25 Feb 2025 03:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740455202; cv=none; b=jLgca14gMwMzSzOwBHXanHSebm4YPYhuZSjrYVeTHDJ0A6z7CackNp4XqRe0Z0E1WicJkbviHxOfkMaSEseL5VP3LiL304gu7YHzYPR75vgGgo6Bc815QEqAQLGLWQ+r0HGdGNIc1AZWQTWrljFq0lozS2L6Bk383AS7WrREdmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740455202; c=relaxed/simple;
	bh=oBmV5ytFANypY5PKhoeTOhUVK0FgP+zeeiYW6bw8jKk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ozkTva+lMAMYBJlfpQdbGoxzlbDzb8Je3w+HQfb37H2eDn297z9tXtT7t0bbJ+p6cM/GXtGITRt/E3fNjDxR9MDe/LSC1BE2kGfdHvTGuADzB/0pxEyY5yKA9ElX5gioJpLX7Ld/4rWAw8RNLJdkrz1VL3JPPdt97Oys6ZDP0+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bWOqBTe0; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-221050f3f00so115931535ad.2
        for <linux-csky@vger.kernel.org>; Mon, 24 Feb 2025 19:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740455199; x=1741059999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8OP1Tf7pAaJ4pNIvAgoQe1yrsY5TH0xWN2DlWHIb0tQ=;
        b=bWOqBTe0FNo2JdVQczJkB9CnLCjn2VsxTrBCMVEO2bTkBwn+9fWyHYUfMDgYlHDlO9
         TDmuZaxsUyySuy8UYSL6LHNPDqNr06zGC4mt7x9TGkuiwf9KeXk58HpCAKCaDHltt07U
         YoEE47cleCA2dOCEBABOZdBBc30QtUTENUi3AKhSwSeiyrIeTHWQ72YZw8/nRNL0Eqao
         MVHiYjurnYfe/P3inyxsjUHjzMLsK9zuTlHqXbnKYH31nouu2ZGM8X3B1qLuKsy5v0OJ
         fwMwi6YsDiBPkPC9QwuTZlX4L5QbZHPCnOVXqf+5suieKikkI6Jm1O5rCiHa81+a6o9S
         x9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740455199; x=1741059999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8OP1Tf7pAaJ4pNIvAgoQe1yrsY5TH0xWN2DlWHIb0tQ=;
        b=UujrsVc84cl9f3B7rNNwP3YTvlLvaVCbj7DFUYbizR76N2v/bVN8g074kdEBo40Fvh
         iIB/vu5pqyWhU5gOdS6XiUzN8b0ZQePevchnqKphDNr9eLnVc8vvkSWfWWxrXEGjpaFL
         dHqVTZFsg7/yt8TjZYMhgFnupJx2LhVZxAgyWQNoo/VSEp+2RmSaXh7YYqd4ETFtVPVE
         mRLb4qnpYArn1eSmKBYfVdN9LY3KjrvjGNoUOdXBVPkk4kXbsvCSSUjj7mmpGuACHzYQ
         H2CMmv0vgnPH4DEJMsIRvzzEIH3QWj5zz2z/5aWMj2xZO+VeCGKVk6vGDv1lcGRNym/0
         mcWg==
X-Forwarded-Encrypted: i=1; AJvYcCU5wP/ydrS1sNNxQBdEJw8HMtbzW7gWvyIhDX7/Fi6ghXLo+5J56+OXUSBxCnDJvCvRKqPql0PUzoSE@vger.kernel.org
X-Gm-Message-State: AOJu0YxJBKu3S5yaRHbiI2qrfXJFksscvwtimaB57P8YMsnRtfFRiPuZ
	PyQcbeY79GOfYFbXdybRz8FTlbuOG7BkujJd06vT7WgADBUMazZSmeTVtAWlicA=
X-Gm-Gg: ASbGncvXkETHQu4l1voKONcXwTgk8n4EY9iESAdgTwXT6oNmYuyQEf3AVy0Dl3KdCBQ
	aj0Dk+bclFhpdMK287Y/8M+CJ7cUvz9OnK5/lPBpXQ/t7yui3S9XFRpl/dZPxyr8FVwVl318c1s
	D25xnibkuSscra+A52tc30N96n7g5fmihU2+OQySKZYHdEiYQoVw++ptT9ue4ZE/FZQ5E4oYfdW
	vEl6+avKHB7aCqiOPCeAjc0hi7yXcM5Fe4h3SdM0i6/iy+c1uexCn+FHN2sc1fBMWAVGTHeqplu
	8703AyaEsDenYBHWUpeqBURnhQCcw9VJrKPp6X7UZ4KDO3TpKxabXm87TYn0usDcjA==
X-Google-Smtp-Source: AGHT+IFHXm4yz9k/q53vQDLsSd2kyUiUDLPeAK4sNAWc/t1WzpyNSO/kW4XJ16gHc0dMjVe/gJ+ItQ==
X-Received: by 2002:a05:6a00:230b:b0:734:9cc:a6e4 with SMTP id d2e1a72fcca58-734791ab6bfmr3168643b3a.21.1740455198810;
        Mon, 24 Feb 2025 19:46:38 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.179])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a81f014sm409429b3a.156.2025.02.24.19.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:46:38 -0800 (PST)
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
Subject: [PATCH v2 2/6] mm: pgtable: change pt parameter of tlb_remove_ptdesc() to struct ptdesc *
Date: Tue, 25 Feb 2025 11:45:52 +0800
Message-Id: <60bb44299cf2d731df6592e446e7f694054d0dbe.1740454179.git.zhengqi.arch@bytedance.com>
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

All callers of tlb_remove_ptdesc() pass it a pointer of struct ptdesc, so
let's change the pt parameter from void * to struct ptdesc * to perform
a type safety check.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 54f579750c8e5..18bf499ef8801 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -506,7 +506,7 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
 	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
 }
 
-static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
+static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
 {
 	tlb_remove_table(tlb, pt);
 }
-- 
2.20.1


