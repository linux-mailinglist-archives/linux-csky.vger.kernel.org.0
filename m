Return-Path: <linux-csky+bounces-470-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB7988B739
	for <lists+linux-csky@lfdr.de>; Tue, 26 Mar 2024 03:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 288F51C2F4B5
	for <lists+linux-csky@lfdr.de>; Tue, 26 Mar 2024 02:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655D71272DE;
	Tue, 26 Mar 2024 02:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mI1YHUW9"
X-Original-To: linux-csky@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD18526B;
	Tue, 26 Mar 2024 02:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711419442; cv=none; b=hry8/MFVTts/urGtPg0wE4+baOw3OsKb/3Q/ubYDOTBZWemJG+EptCQczLv+2kAcJConcNZd/R0VaRFPfWy+5LnhRNKZnF2/qPylcmfPCTkjJpOeB+vsBXZpRjFEflyOyeFEShbI1f7ZzzsqZAne5tTEw6Cad+xRnsSDlpi8J7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711419442; c=relaxed/simple;
	bh=whLNPBFJ+q2+vc2R8+bRAmAZKOkjtqN6kDoBWWZgKCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bZ6GsP1l8JkYSQbOXJZhO0AXaUHO5+rTxzyYhABTj7PGZGZi+c/6IuCN6PH4QByyKsC6t+htnXoDJCyux7GjJg/HTbqxKfue0U5csp6BiuzZLk4ad2X8woQYOCo8uDnbm3aFuRaakQmOwpGs27ng6FJ9IbbpxW9psX6B8BcgfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mI1YHUW9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711419440; x=1742955440;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=whLNPBFJ+q2+vc2R8+bRAmAZKOkjtqN6kDoBWWZgKCE=;
  b=mI1YHUW9dZ1FKkX9i2CnJ8jbOOW0d8SI8FCjwEW1FycXl4/kQxqPiHQ+
   C6eLYDBVVaqSfpH3E2mWtvi031zt18yserZfj4SlxqNs8I2p6OgR7cCdq
   9u6DiHYT7g2/TVFthgLioP4BdhVrW4SFWRC4RZLgx/87SpWJi1l7AmXsa
   Pr++gJW9+H0DgidWyJwsKcoZKG7XAyrX2Y35KnzYZhkD7QAlpRjgRiSFW
   B1hVjb2pGS23QyHOvHl8CblzfrwSh72O4B5dYFIHT9HdKtYBB7X2ZS+TX
   DTFWEznjswhIfltL5KSZDuZagYBlZ6Vbmq+i5N73w/SKki7QtNTJndEg5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6564286"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6564286"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20489892"
Received: from rpwilson-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.11.187])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:17:16 -0700
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	broonie@kernel.org,
	christophe.leroy@csgroup.eu,
	dave.hansen@linux.intel.com,
	debug@rivosinc.com,
	hpa@zytor.com,
	keescook@chromium.org,
	kirill.shutemov@linux.intel.com,
	luto@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	x86@kernel.org
Cc: rick.p.edgecombe@intel.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org
Subject: [PATCH v4 07/14] csky: Use initializer for struct vm_unmapped_area_info
Date: Mon, 25 Mar 2024 19:16:49 -0700
Message-Id: <20240326021656.202649-8-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
References: <20240326021656.202649-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Future changes will need to add a new member to struct
vm_unmapped_area_info. This would cause trouble for any call site that
doesn't initialize the struct. Currently every caller sets each member
manually, so if new members are added they will be uninitialized and the
core code parsing the struct will see garbage in the new member.

It could be possible to initialize the new member manually to 0 at each
call site. This and a couple other options were discussed, and a working
consensus (see links) was that in general the best way to accomplish this
would be via static initialization with designated member initiators.
Having some struct vm_unmapped_area_info instances not zero initialized
will put those sites at risk of feeding garbage into vm_unmapped_area() if
the convention is to zero initialize the struct and any new member addition
misses a call site that initializes each member manually.

It could be possible to leave the code mostly untouched, and just change
the line:
struct vm_unmapped_area_info info
to:
struct vm_unmapped_area_info info = {};

However, that would leave cleanup for the members that are manually set
to zero, as it would no longer be required.

So to be reduce the chance of bugs via uninitialized members, instead
simply continue the process to initialize the struct this way tree wide.
This will zero any unspecified members. Move the member initializers to the
struct declaration when they are known at that time. Leave the members out
that were manually initialized to zero, as this would be redundant for
designated initializers.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Link: https://lore.kernel.org/lkml/202402280912.33AEE7A9CF@keescook/#t
Link: https://lore.kernel.org/lkml/j7bfvig3gew3qruouxrh7z7ehjjafrgkbcmg6tcghhfh3rhmzi@wzlcoecgy5rs/
---
v3:
 - Fixed spelling errors in log
 - Be consistent about field vs member in log

Hi,

This patch was split and refactored out of a tree-wide change [0] to just
zero-init each struct vm_unmapped_area_info. The overall goal of the
series is to help shadow stack guard gaps. Currently, there is only one
arch with shadow stacks, but two more are in progress. It is compile tested
only.

There was further discussion that this method of initializing the structs
while nice in some ways has a greater risk of introducing bugs in some of
the more complicated callers. Since this version was reviewed my arch
maintainers already, leave it as was already acknowledged.

Thanks,

Rick

[0] https://lore.kernel.org/lkml/20240226190951.3240433-6-rick.p.edgecombe@intel.com/
---
 arch/csky/abiv1/mmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/csky/abiv1/mmap.c b/arch/csky/abiv1/mmap.c
index 6792aca49999..7f826331d409 100644
--- a/arch/csky/abiv1/mmap.c
+++ b/arch/csky/abiv1/mmap.c
@@ -28,7 +28,12 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	int do_align = 0;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {
+		.length = len,
+		.low_limit = mm->mmap_base,
+		.high_limit = TASK_SIZE,
+		.align_offset = pgoff << PAGE_SHIFT
+	};
 
 	/*
 	 * We only need to do colour alignment if either the I or D
@@ -61,11 +66,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 			return addr;
 	}
 
-	info.flags = 0;
-	info.length = len;
-	info.low_limit = mm->mmap_base;
-	info.high_limit = TASK_SIZE;
 	info.align_mask = do_align ? (PAGE_MASK & (SHMLBA - 1)) : 0;
-	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
 }
-- 
2.34.1


