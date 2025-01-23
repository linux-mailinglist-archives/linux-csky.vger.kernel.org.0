Return-Path: <linux-csky+bounces-1687-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 474A3A1A4FC
	for <lists+linux-csky@lfdr.de>; Thu, 23 Jan 2025 14:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126003AB453
	for <lists+linux-csky@lfdr.de>; Thu, 23 Jan 2025 13:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD5021128D;
	Thu, 23 Jan 2025 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="M/dznGMi"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B24E20FA8E
	for <linux-csky@vger.kernel.org>; Thu, 23 Jan 2025 13:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737638950; cv=none; b=hbn53BmsUeFMFAi9QkNHWUDFKIIMONpNl9K5l6/9w5MbDSy8a9uLuCKbFMDD+ZVKrXl9ZG1GXU46P/fW/v87ga49mGf27CnA3KHXxQI1b/mOJgLTR6pJuq1K+YBUmmO1VJPxWJz6o154WjXg291EOz5AdtnMDzp2OG876NjdssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737638950; c=relaxed/simple;
	bh=xyoxab241Xbf++2pkWevGXAMdg+Lltm4zD7nrlxitWM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KEXZVi4nMXXb2O4J2T1zUWzezF1yD4ItrRzDyVSqR1WKgN5yAYj0WzRiVE3tE/uNraohprJUDFOk7W8LNkuGhjN75O9jpM0DaRECuOflMDx5Z0CmK51nhg9F1SzdIr9Mw7yVTkxJcS46FKtkQNXiAOmBkdDxbweu155+d7TGv7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=M/dznGMi; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216728b1836so13931595ad.0
        for <linux-csky@vger.kernel.org>; Thu, 23 Jan 2025 05:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737638948; x=1738243748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8C94XB4BAC98f0nzKDfhip6ZZIJjZtAIgTVlkxB/zEY=;
        b=M/dznGMiy55gDN4Bz8oivIoQTni4ET1ZdrZPukL3yR3sGAC7Cvy+xQhynQvdI9/yh/
         ZQhlAxWVub1c7f2ZbaFFGvnfuvRkZb9H503JbCXZ9Vwkj9KLUpJs858s5RNnYjaiIaUw
         lI+tSM14c88PHsh54pfbFBxD5Suu8dOiyPSrV0KN+iVRZYm9Cm7ppVSRLoIHQSBzDtdz
         Jsh/HsULJhEJkCcTSeINtQcE8kD55A6TDD3zUx8V22bZSdALpxtluCsNKwjK4/IFZG5q
         ocjAsy04352y4mPBGnCbJBzRQ0CcXjQltc3ceT0KbJtw9ZluGYhD3Nex0Q5FhRZl2RLm
         rHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737638948; x=1738243748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8C94XB4BAC98f0nzKDfhip6ZZIJjZtAIgTVlkxB/zEY=;
        b=ShlRF90HiytKa8KZEDO9nRH4t1U4tIvpqQBo1waOOM72E7JwyDUipKCrKGbgYJbWre
         UKhPNaFs7dcpIHcf1zVobOy9ejNilBYzdIr8H3lOiCXjL7vPmjxRSlj9bUm0tJ0cjx4i
         VL7BJuC5xxERigmsVpJZVnjZLIgSc3NR8flllz9XzSA8YDEf258ScLXI7hPN+EQs4sVY
         SN89mRTXjmnISl8VoKGkHccuOoY2ACjHOAisc40JMItPwPlZvDos/bTci83B4TcljcUr
         F1OIQiDgUrdJXtLnkgtLAgy5eTQsO2saw0JEpijwS3paON7EreHvYlOZTTQPC+9FUUfv
         8jXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcepsFV/I9ZOJlVMF4QP1dcDWJ3jcbr3GdWz63MWw3OC7arQJlDqeL+9KTe2MRuYPf8RpIyrw9pO5S@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh8kndK3su3WEB3ywdzsC+/wmd8NyZ7Us8udEdJSZ0QzncbDWs
	gXzBkS/FeX5o/b9wAcMOBEGNNxWF08ZB1xzzJrsjIOY7MPTD+PwVL7E23GAQ9dI=
X-Gm-Gg: ASbGnctLCoG8NdtMiG3Dg+Hde+A+5y/ioqgrZw34vd9ujmyKa01okw0vYmHzvwO+Yf8
	OD8cbxhGdEbHlbo0q8MgFJ1C1ZnSvmnuur2ViwFGasRky0UXPsAvKcqRvITwGzTUGa5q5Uhz1qi
	cbZdbINvtI+X3VWTy0oAtVcULcvO4XADPlmqS5CyzH5cStEMeSy2IzkpMESTE3fig6kw1gGlmkR
	IZzHJNxBnytYYQOhFodDmaHHGShZHsXP0ayw7yYKQKjvY60SogK9ODxCahl0yPG9Gy4iUeEMn5V
	4jvp+9zEvkN15yB9U0BzybEsV67HptbcKAjI3pEVesp8
X-Google-Smtp-Source: AGHT+IFkSdO3UtmG5jKkAJtanqQZSHufZoNoVtMFPHl42HZUz79kP6iB5Pw4LWGczfrtYHtt4kZUXA==
X-Received: by 2002:a17:902:f54f:b0:215:b468:1a33 with SMTP id d9443c01a7336-21c351c67acmr376126085ad.4.1737638948337;
        Thu, 23 Jan 2025 05:29:08 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d3ac3e2sm111583655ad.139.2025.01.23.05.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 05:29:07 -0800 (PST)
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
Subject: [PATCH 5/5] mm: pgtable: remove tlb_remove_page_ptdesc()
Date: Thu, 23 Jan 2025 21:26:18 +0800
Message-Id: <62d6a04c3a0e70efd435cc2c8a4d9d07d94e7ece.1737637631.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1737637631.git.zhengqi.arch@bytedance.com>
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tlb_remove_ptdesc()/tlb_remove_table() is specially designed for page
table pages, and now all architectures have been converted to use it to
remove page table pages. So let's remove tlb_remove_page_ptdesc(), it
currently has no users and should not be used for page table pages.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/asm-generic/tlb.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index 10cdbe0e7adfe..dec030cb12108 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -509,12 +509,6 @@ static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
 	tlb_remove_table(tlb, pt);
 }
 
-/* Like tlb_remove_ptdesc, but for page-like page directories. */
-static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
-{
-	tlb_remove_page(tlb, ptdesc_page(pt));
-}
-
 static inline void tlb_change_page_size(struct mmu_gather *tlb,
 						     unsigned int page_size)
 {
-- 
2.20.1


