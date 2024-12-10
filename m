Return-Path: <linux-csky+bounces-1287-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB569EA575
	for <lists+linux-csky@lfdr.de>; Tue, 10 Dec 2024 03:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F6ED1885B2E
	for <lists+linux-csky@lfdr.de>; Tue, 10 Dec 2024 02:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72511D0F6C;
	Tue, 10 Dec 2024 02:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fDcER2k5"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE89E1BF80C
	for <linux-csky@vger.kernel.org>; Tue, 10 Dec 2024 02:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733798494; cv=none; b=Q0D1oAnfn6+oMm7FhdWUCKxmsokyTLwYCQrjmsP0qAl9QtVwviLD/keZwyI6TQVmIAzVtZhGsKCo1RHfPXq+VZh0siW2ZlYrHWCR8AE7VqllTiGcOND06mn0T/n4ly3IyxnQxR3Ams3YWTijdF9wWtGe1La2GXI1M/iSQ/0TH64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733798494; c=relaxed/simple;
	bh=XV1LugKdz2DpbBeuplWv0YYTqCyV+/pUJf+iX2EDwnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LNUHN8cCxLRfDhdRhKkLQVeizSCxsxeXkSIbhioR/4vtVYb5rJ035EZJ49SkhPfXKjT9QCG5y0An9NRUsngGC6UX/0/X65MKrE7bI+ed1vqLFm1lfwhXAQot7Sp7bs1u/LAdcBEGQaIfgpdI3jwODrqt6d3Gp9hGExIS5SegWXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fDcER2k5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaleshsingh.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-725e3c6ad0dso3061999b3a.0
        for <linux-csky@vger.kernel.org>; Mon, 09 Dec 2024 18:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733798491; x=1734403291; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=68DM57EM10Oy1Phx/X5P68W7yQkXIjbCrTpN7G3wDA4=;
        b=fDcER2k5i55JkEtmoMN7JjD21fhpKrJ/WuN4OLRK7RrQyWUhggG167Da3/G5knqten
         ZNxYsEIHxZPQzJ5cnNEg3An+JYtxenP0d5CoVGAC2ElJlcEwsBqqB+fT7S5aFVj6ONCd
         aERbnDRlphBZYTeH5uXIS6O8cY1fXhrg431RNuFfTsc9vCrjLClTnzA3+xghq9cKHIAI
         95Cmt4gVmGHS/qgBF8FnPUiWC3BVubSS9MyerdKbsQfinUcQY7eziRmzKp3IOJZ7GC3o
         qEMwY8Mf6ATkz6hBuAEE9xeFw4gV2nIrzTItDh9f1yyeFiHFJ5x0bRrOqHdGZc9M/D1I
         tgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733798491; x=1734403291;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68DM57EM10Oy1Phx/X5P68W7yQkXIjbCrTpN7G3wDA4=;
        b=l8oOPVdG7PySfbRiBt1QVx+trSWlSI9ihmQQ5N5id+o42hygYUNdjzg7wg1jCKwxLO
         gmuHi0/MAYeTayU/KZZUAYEQME7oiazdp83L+2sjCD0Wujzn5g2jmCeLBdnLoBJhIMM9
         hh4m5+A//+qcdTe4aHkGFa6GsFGAtBXey9kX2EXG857tjQ7mcG6J0A4XY+qpZvYsaKxJ
         1apadNqTqFkgh0MOdmCfbJ6daHnTEx6xN4UCxoLJCJcpGm5c5D74X6dt7Nj5SaLJFdrv
         UD2KVOFXnGpq0jKWI55v1tFjiQsnjHWIwkmqMOQ17EGF2oVhcsK1hpEiDIBeh39Phsev
         511Q==
X-Forwarded-Encrypted: i=1; AJvYcCVARhk/wLrSwBFUsAXHgJiWSWdfp/GT39QT4sFsgkt59JYBiVK8CqJMabunxZI/zFJOagbodcQrb8UC@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjuje3xaEngUoQfdjOZSTloxFmTRNXzlaQmkBxn0OPw/+Klsym
	scXJCVyHUHEm+tHqCRN0XPazsypKoVTtO2T8Mqf2AfDlFj35dPb0T2rRdIrQjQmraZoBXqKRgfx
	TUP5+XtcQPS+s+oun06NDwg==
X-Google-Smtp-Source: AGHT+IEtrC2iviCeXWAtkatWkkbrcoIFQnKfltvUj9wZA43T/YasMAjSbDISIyM+Y3e/Wy24hv9IDhoi1rtLFpgStA==
X-Received: from pfbcn3.prod.google.com ([2002:a05:6a00:3403:b0:725:db2d:370e])
 (user=kaleshsingh job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:12c5:b0:1e0:d867:c875 with SMTP id adf61e73a8af0-1e1b1b5c646mr3881670637.36.1733798490862;
 Mon, 09 Dec 2024 18:41:30 -0800 (PST)
Date: Mon,  9 Dec 2024 18:41:06 -0800
In-Reply-To: <20241210024119.2488608-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241210024119.2488608-1-kaleshsingh@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241210024119.2488608-5-kaleshsingh@google.com>
Subject: [PATCH mm-unstable 04/17] mm: alpha: Introduce arch_mmap_hint()
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

Introduce alpha arch_mmap_hint() and define HAVE_ARCH_MMAP_HINT.
This is a preparatory patch, no functional change is introduced.

Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
---
 arch/alpha/include/asm/pgtable.h |  1 +
 arch/alpha/kernel/osf_sys.c      | 29 ++++++++++++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/include/asm/pgtable.h b/arch/alpha/include/asm/pgtable.h
index 635f0a5f5bbd..372885a01abd 100644
--- a/arch/alpha/include/asm/pgtable.h
+++ b/arch/alpha/include/asm/pgtable.h
@@ -362,5 +362,6 @@ extern void paging_init(void);
 
 /* We have our own get_unmapped_area to cope with ADDR_LIMIT_32BIT.  */
 #define HAVE_ARCH_UNMAPPED_AREA
+#define HAVE_ARCH_MMAP_HINT
 
 #endif /* _ALPHA_PGTABLE_H */
diff --git a/arch/alpha/kernel/osf_sys.c b/arch/alpha/kernel/osf_sys.c
index 86185021f75a..68e61dece537 100644
--- a/arch/alpha/kernel/osf_sys.c
+++ b/arch/alpha/kernel/osf_sys.c
@@ -1225,6 +1225,27 @@ arch_get_unmapped_area_1(unsigned long addr, unsigned long len,
 	return vm_unmapped_area(&info);
 }
 
+unsigned long arch_mmap_hint(struct file *filp, unsigned long addr,
+			     unsigned long len, unsigned long pgoff,
+			     unsigned long flags)
+{
+	unsigned long limit;
+
+	if (!addr)
+		return 0;
+
+	/* "32 bit" actually means 31 bit, since pointers sign extend.  */
+	if (current->personality & ADDR_LIMIT_32BIT)
+		limit = 0x80000000;
+	else
+		limit = TASK_SIZE;
+
+	if (limit - len < addr)
+		return 0;
+
+	return generic_mmap_hint(filp, addr, len, pgoff, flags);
+}
+
 unsigned long
 arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		       unsigned long len, unsigned long pgoff,
@@ -1254,11 +1275,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	   merely specific addresses, but regions of memory -- perhaps
 	   this feature should be incorporated into all ports?  */
 
-	if (addr) {
-		addr = arch_get_unmapped_area_1 (PAGE_ALIGN(addr), len, limit);
-		if (addr != (unsigned long) -ENOMEM)
-			return addr;
-	}
+	addr = arch_mmap_hint(filp, addr, len, pgoff, flags);
+	if (addr)
+		return hint;
 
 	/* Next, try allocating at TASK_UNMAPPED_BASE.  */
 	addr = arch_get_unmapped_area_1 (PAGE_ALIGN(TASK_UNMAPPED_BASE),
-- 
2.47.0.338.g60cca15819-goog


