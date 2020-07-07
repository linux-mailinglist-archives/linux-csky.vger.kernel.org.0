Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642C2217B63
	for <lists+linux-csky@lfdr.de>; Wed,  8 Jul 2020 00:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbgGGWv6 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 7 Jul 2020 18:51:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47956 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728742AbgGGWui (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 7 Jul 2020 18:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594162236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jxvjf7Q+v/mOPCYZqZl27IogKSwgytmGoijHqe+1Kyo=;
        b=P1GHIVX5tnRGecOQlWrsq9Q3ScUaoZXQIfYEkK/B9GeC04SIQNGi02tJwD6QJTLKywG9ge
        8MkehkXJxlixptsJSWpDDQXApEtw4AJbgP5KLWsq7cgF1NyCxPwZc/2BdrJYfIShaNcV+G
        EbmYHFWmNmpXFdV0wM9fmJvm6jkWt7U=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-96-U0zE8oDtNgaOo1gpjSFbrg-1; Tue, 07 Jul 2020 18:50:35 -0400
X-MC-Unique: U0zE8oDtNgaOo1gpjSFbrg-1
Received: by mail-qv1-f70.google.com with SMTP id g17so26320750qvw.0
        for <linux-csky@vger.kernel.org>; Tue, 07 Jul 2020 15:50:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jxvjf7Q+v/mOPCYZqZl27IogKSwgytmGoijHqe+1Kyo=;
        b=ZhG0L8i2xbMi6JEjvL7ohPTiKLtz2TscSn7oZ2cGz9pGIDdsCxVedJqGUZcBuQhbNJ
         2IXygoR6EQpL9hg1svGmNQJOFQh2eH5OORPoVvvy4MEuXE3Pf8W9/KM9zPQ39LFAyNbf
         wTIkEzgtn37/VM/pzr4fQPaU4Hvym+pYeljKpeRBHxBvKPicHYaa+6CFFi3LKtxeHtHk
         Uz4pDjdnZFqPBrq5Upp+xotakDBHU+BZfLUpDtBJeav/lH8lyFD9To71FvkxlbT/zP56
         64eqf2KPdt2eaSBD1Hp7UTxVwBGLHKBvVlvEdMk16pTzoAgLdie4hrCrz9NJktXnop5M
         Y1Iw==
X-Gm-Message-State: AOAM533W9P2nkN/Q2+E756zDAWCAJdtcN3Vh3MM6G4uuz4+GExYnCWHf
        /HbT5er1z7fspBaw6JEXuk+JxqlqIXcT1aOJRAUPuQyVXkQlSt0QqkQqHjM2Z/X6tA9r1aXvGMG
        cyr1Nf7/FD6UQRIv4jqhHsg==
X-Received: by 2002:ac8:16b2:: with SMTP id r47mr57607225qtj.273.1594162234497;
        Tue, 07 Jul 2020 15:50:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEUX4FOONaw2ZO8mmmd3zmBYLqC03cLLhe3ytu7deLkE6Bv0g/Xef2K2OGzTk+bX724w5ibw==
X-Received: by 2002:ac8:16b2:: with SMTP id r47mr57607196qtj.273.1594162234214;
        Tue, 07 Jul 2020 15:50:34 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j16sm26267642qtp.92.2020.07.07.15.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 15:50:33 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH v5 06/25] mm/csky: Use general page fault accounting
Date:   Tue,  7 Jul 2020 18:50:02 -0400
Message-Id: <20200707225021.200906-7-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200707225021.200906-1-peterx@redhat.com>
References: <20200707225021.200906-1-peterx@redhat.com>
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
Acked-by: Guo Ren <guoren@kernel.org>
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

