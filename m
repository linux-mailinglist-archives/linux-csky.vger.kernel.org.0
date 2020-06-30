Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF7F20FE10
	for <lists+linux-csky@lfdr.de>; Tue, 30 Jun 2020 22:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbgF3Uqw (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 30 Jun 2020 16:46:52 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45357 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730076AbgF3UpZ (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Tue, 30 Jun 2020 16:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593549923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7ODhBJEySE25lLdIL36bUDM3v/f2DyEns/dEg5PpJb4=;
        b=X9i97eOSaM7f8AHEbT2WJuVItaQLrRsPSCpMXptIhKOZeZGy8QJ0CshukCUPOTD1Uif66r
        kdhIDPVbxBN0dsxZxufgcwq4Buety130gEHTdEcn2h6E3XZWEGRFmdbq12x0AapI90LUd7
        2nfhiT5xORDnXKFtjk3kLn/9Cukpk1o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-cxc5n9wkOpCx2jc61pJWGQ-1; Tue, 30 Jun 2020 16:45:21 -0400
X-MC-Unique: cxc5n9wkOpCx2jc61pJWGQ-1
Received: by mail-qt1-f199.google.com with SMTP id c5so15275561qtv.20
        for <linux-csky@vger.kernel.org>; Tue, 30 Jun 2020 13:45:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7ODhBJEySE25lLdIL36bUDM3v/f2DyEns/dEg5PpJb4=;
        b=crgaaYT4cU6iWDY4o4hmUwswqlltHuJ/zFNTtGWDKaU6QhHs6Y4ieQrTLwrKo5lkXB
         AAiPXoGCUmAKfKax1+V9rv7D0WUzDmrU2/WWTxwyHVnXNKapoWg9KNyyzVulU9d4NgZp
         liO9A6ewoXnIzScJ6Zv2MrpZoH8uqP2hhrnsMH30QoVpQgbc2Qpo4Dsm+yKSfo8sdL8V
         Ut2z1DvW/VN5xDYbfLg8YSSIT54prgB7ggRvTR+xAuHnSfbeqpQS8RQ5ki1T/Vy+C2F/
         G+ZFWCovpj2EQChVIJ2fYhThSyuXVTPe/xhJDORspB9C5rgIcwlLPvU742LA1Zj7kpGv
         t2gQ==
X-Gm-Message-State: AOAM530yNcXSVexN74JgWKToM98QbHRnBLrvKRcRgBz5KbteIhjjWF9g
        DUEaxrs9iKnTDYGPaTb0QE/+Kr9hq9ansIFI2bpDbafCzSyAe/yQ+yp6coZi6sddnmrzXu3uVSJ
        oECRbFPdWyvyO5yImqvwnAg==
X-Received: by 2002:a0c:a306:: with SMTP id u6mr8860912qvu.88.1593549920888;
        Tue, 30 Jun 2020 13:45:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4ZC/3hV5sZ3jrFOaj/HrUvlBV2LSVm33S24f5OpZpmLOt/vUUR0YiRw9Ypkc2T/z0QGSYbg==
X-Received: by 2002:a0c:a306:: with SMTP id u6mr8860803qvu.88.1593549919465;
        Tue, 30 Jun 2020 13:45:19 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id y16sm4443907qty.1.2020.06.30.13.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:45:18 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org
Subject: [PATCH v4 06/26] mm/csky: Use general page fault accounting
Date:   Tue, 30 Jun 2020 16:45:17 -0400
Message-Id: <20200630204517.38760-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Use the general page fault accounting by passing regs into handle_mm_fault().
It naturally solve the issue of multiple page fault accounting when page fault
retry happened.

CC: Guo Ren <guoren@kernel.org>
CC: linux-csky@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/csky/mm/fault.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 7137e2e8dc57..c3f580714ee4 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -151,7 +151,7 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 	 * the fault.
 	 */
 	fault = handle_mm_fault(vma, address, write ? FAULT_FLAG_WRITE : 0,
-				NULL);
+				regs);
 	if (unlikely(fault & VM_FAULT_ERROR)) {
 		if (fault & VM_FAULT_OOM)
 			goto out_of_memory;
@@ -161,16 +161,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 			goto bad_area;
 		BUG();
 	}
-	if (fault & VM_FAULT_MAJOR) {
-		tsk->maj_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs,
-			      address);
-	} else {
-		tsk->min_flt++;
-		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs,
-			      address);
-	}
-
 	mmap_read_unlock(mm);
 	return;
 
-- 
2.26.2

