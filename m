Return-Path: <linux-csky+bounces-1290-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 427749EA58D
	for <lists+linux-csky@lfdr.de>; Tue, 10 Dec 2024 03:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB1E1287CF0
	for <lists+linux-csky@lfdr.de>; Tue, 10 Dec 2024 02:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F321D7E54;
	Tue, 10 Dec 2024 02:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVINSByV"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3D51A7271
	for <linux-csky@vger.kernel.org>; Tue, 10 Dec 2024 02:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798499; cv=none; b=BmIvkWKnPgayUp4VQoP2Fqb5yl69kNok3n1KVJeafVELVnGaNsC3L//ncbNzo6MIO2f8EHUuARl/7GZQ6YLqjARrAmH7MouHNLTG4/qIJPvq118CI6xtJ9Ixhf9aEDMPa0/JrbvS1qo/JSN3CLnh3AuQ9w/EJKo6vt/E5iU4xRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798499; c=relaxed/simple;
	bh=xcbH9OWeM8vfFx05iH7xS2xrxxFnY7fI4TROJ6H3v1U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PEDHapUY91+qkle2MnzKnb/wY2ljeaGrRLiZcYDxtwvMe9A+f3EpYKS+RHwT1WXYepTHDa3EFbCHoE/i2ClC6wLQl56H/xFzDVYB7ArtuBZWfbULlTfjlLBu1s+u9K1T0YbVWDef/j/kceVHwbxROjoMySd1ruvKXQ7dMLVSZek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVINSByV; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ef728e36d5so3395142a91.3
        for <linux-csky@vger.kernel.org>; Mon, 09 Dec 2024 18:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733798496; x=1734403296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S88A34UwW99gwo3FHZNSbMidEba+jodHLuTGE22Alms=;
        b=BVINSByVYwBv5lgEkvx+76L0RqMhL+deprR/gTHChS3s+LAeQnWL8l2OWllCOCFVV0
         cBWkBGv/vENbNrTZtObdhv4jDb0tNZceZ79+DC+47nU7Iz7Oma4pG7I4g0O5dTvf3ERE
         GbQsRpxHOUGJhBYs/vTH7MKKXv1N5w2o7jW0xtNCuK9mkPVeXWY8Aak6NjhYVxS4YvQl
         vAVCKelGD2m6jTy52h73IY2hPMDJ1HoIMOkslszd7T6nHcHecWwk5ek8tLPgM8kp4JC1
         qDOAAtlJbioUAx1DYlR3BApBi2xBeurg47wXJOiMVjp6Ag9HlAErM07aq9hHNiNQgByG
         y3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798496; x=1734403296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S88A34UwW99gwo3FHZNSbMidEba+jodHLuTGE22Alms=;
        b=N94mK/y5JLwjdda3U35fHvPdWGww/nxzmY0tBZaj/jr+34yYygDRJy2S8STHWhIPMY
         CkVqz4DDCfMrV8Xng3ZYKfvH0/JhwSxIXgXTroGYp+qtCsA965GZbwjMBcbBK82oaeJD
         au+ZQnrw03q2OMreeXPnoEjMNZJ6Y99xyE2sY2V0O8/9X6c5b0uTbwpNLrkcg1SRUCCO
         N3XmIM/d71RpkkJ5C1b4EkTahzVtJTAflAQkTXu4yuUW9fEoPTd0n2oblsr7ImuZhuQ2
         xCr7Dw924N2A+3SS73GpkPnS25oseRhuciTBse0ydzQ6dT90JfXELonBQDfskHxJhkZz
         I1Rw==
X-Forwarded-Encrypted: i=1; AJvYcCW0a+VhQOELxbmPziAbyxXv87XN7VNjGVniNgM+e8TfFA1edqX5BUOb76jqXdRgwd7X3LKUbQ1a7USD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw12vEGkZ5GvznHukYnHM68z6Xuwu/pM1fTNAq66qG+lwOHXy/Z
	1I3hgyh/9Yes9QKX/n6Fj6v6yPV75zVTnhSm1jQ9CNqndaPyF8/6e+nWhhd8I20ftzEhOnbKPeH
	6SqmCVv2ejIMUcA4Tkxzi3g==
X-Google-Smtp-Source: AGHT+IGKFXSWCJqlNS2qFXMxzoG4Xb3NRDnkhhqp5lhhsQRnzkIpBXQqaaHYQ40OzOD6Dmlpa/x+DpWxNJUXLfVq7w==
X-Received: from pjvb11.prod.google.com ([2002:a17:90a:d88b:b0:2ea:7d73:294e])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1d0c:b0:2ee:ed07:d6d2 with SMTP id 98e67ed59e1d1-2ef6ab2888cmr21797074a91.37.1733798496370;
 Mon, 09 Dec 2024 18:41:36 -0800 (PST)
Date: Mon,  9 Dec 2024 18:41:09 -0800
In-Reply-To: <20241210024119.2488608-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210024119.2488608-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210024119.2488608-8-kaleshsingh@google.com>
Subject: [PATCH mm-unstable 07/17] mm: loongarch: Introduce arch_mmap_hint()
From: Kalesh Singh <kaleshsingh@google.com>
To: akpm@linux-foundation.org, vbabka@suse.cz, yang@os.amperecomputing.com, 
	riel@surriel.com, david@redhat.com
Cc: linux@armlinux.org.uk, tsbogend@alpha.franken.de, 
	James.Bottomley@HansenPartnership.com, ysato@users.sourceforge.jp, 
	dalias@libc.org, glaubitz@physik.fu-berlin.de, davem@davemloft.net, 
	andreas@gaisler.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, chris@zankel.net, 
	jcmvbkbc@gmail.com, bhelgaas@google.com, jason.andryuk@amd.com, 
	leitao@debian.org, linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, 
	kernel-team@android.com, android-mm@google.com, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"

Introduce loongarch arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/loongarch/include/asm/pgtable.h |  1 +
 arch/loongarch/mm/mmap.c             | 40 ++++++++++++++++++----------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
index da346733a1da..326a6c4b7488 100644
--- a/arch/loongarch/include/asm/pgtable.h
+++ b/arch/loongarch/include/asm/pgtable.h
@@ -624,6 +624,7 @@ static inline long pmd_protnone(pmd_t pmd)
  */
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#define HAVE_ARCH_MMAP_HINT
 
 #endif /* !__ASSEMBLY__ */
 
diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
index 914e82ff3f65..b7db43fabca1 100644
--- a/arch/loongarch/mm/mmap.c
+++ b/arch/loongarch/mm/mmap.c
@@ -17,12 +17,32 @@
 
 enum mmap_allocation_direction {UP, DOWN};
 
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	int do_color_align = 0;
+
+	if (!addr)
+		return 0;
+
+	if (filp || (flags & MAP_SHARED))
+		do_color_align = 1;
+
+	if (do_color_align)
+		addr = COLOUR_ALIGN(addr, pgoff);
+	else
+		addr = PAGE_ALIGN(addr);
+
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+
+
 static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	unsigned long addr0, unsigned long len, unsigned long pgoff,
 	unsigned long flags, enum mmap_allocation_direction dir)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
 	unsigned long addr = addr0;
 	int do_color_align;
 	struct vm_unmapped_area_info info = {};
@@ -45,23 +65,15 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 		return addr;
 	}
 
+	/* requesting a specific address */
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return addr;
+
 	do_color_align = 0;
 	if (filp || (flags & MAP_SHARED))
 		do_color_align = 1;
 
-	/* requesting a specific address */
-	if (addr) {
-		if (do_color_align)
-			addr = COLOUR_ALIGN(addr, pgoff);
-		else
-			addr = PAGE_ALIGN(addr);
-
-		vma = find_vma(mm, addr);
-		if (TASK_SIZE - len >= addr &&
-		    (!vma || addr + len <= vm_start_gap(vma)))
-			return addr;
-	}
-
 	info.length = len;
 	info.align_mask = do_color_align ? (PAGE_MASK & SHM_ALIGN_MASK) : 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
-- 
2.47.0.338.g60cca15819-goog


