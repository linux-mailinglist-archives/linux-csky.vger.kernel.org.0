Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9215320BC86
	for <lists+linux-csky@lfdr.de>; Sat, 27 Jun 2020 00:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgFZWbr (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 26 Jun 2020 18:31:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47575 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726079AbgFZWbq (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Fri, 26 Jun 2020 18:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593210704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYKuiXa6JqSlFakb02F9N/z/khfKW7nv0ZKU3o10xCg=;
        b=DGRwBAFMqF1mh4XxnaJxgSdEs59EzNZwXLGDCK7lTocadtKFahvOt5yGSQOvuvRsEgS9NU
        VOcmrBeG7bi5Vm7U7EbyyAHnaWJZbj5yP2OwyUN6rlDkYZiJlaVXXcPa1PSgjexdeBqLs7
        R0nObCU0frbH22xcdKaA1aQku9+sfvE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-W7mn9QtgPCq66l941G0r5A-1; Fri, 26 Jun 2020 18:31:42 -0400
X-MC-Unique: W7mn9QtgPCq66l941G0r5A-1
Received: by mail-qv1-f72.google.com with SMTP id g13so7385905qvp.5
        for <linux-csky@vger.kernel.org>; Fri, 26 Jun 2020 15:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYKuiXa6JqSlFakb02F9N/z/khfKW7nv0ZKU3o10xCg=;
        b=sw6JajNCudec+UHs4FZSEc2enrOzPJ9IsMe9ZhTigH/wDvzzMVdYfnpV39cV0HS34q
         nxn1EJBglb9ssF+8zzO5O7MQ9Bb+3QtNrynSqdQAwn9CvijUVi3ARBSV3404qGHYviOw
         JhIekHE5vCfe8iq46egiJn9cG+jPkfCp3JM4rDMtLVx4JchR2yvhwbYN2Phv5BZBWchj
         OmAAOaav/Tll1iDxa8wBjTLfRQ2C7oYedH4F3NP06nA6NV6tipDKcsjbXvlv+nI8IYvd
         QBxe/oCa0/LnkZoccrJG4FinqAJ8Wp9W0Au8mOnMVXhSTkuzm7Du0BRVBCvNxnRE9RLj
         9Jbw==
X-Gm-Message-State: AOAM532t3kpuqaT9iNllcxAuqoJPbTeiNpzRbI7FgFieX79F003h8cmf
        cIshzBwrf0g/LWze+9U06mWVyeIMZTKEgidI0hGvpx11pQQaGCKi8SKZPJAEu/2E8CjgSgjJdem
        0Liyu4orESW3jV5VI3JB73w==
X-Received: by 2002:ac8:27bd:: with SMTP id w58mr5311364qtw.348.1593210701799;
        Fri, 26 Jun 2020 15:31:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxSMdcnN8S0Vm53+A1zYZUxGb86xhlZEgD0Ug2gSVVAidxyTpcuF0guaWkh6epy+fd5/SNVlw==
X-Received: by 2002:ac8:27bd:: with SMTP id w58mr5311342qtw.348.1593210701587;
        Fri, 26 Jun 2020 15:31:41 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f203sm9903311qke.135.2020.06.26.15.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 15:31:40 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>, peterx@redhat.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH 06/26] mm/csky: Use general page fault accounting
Date:   Fri, 26 Jun 2020 18:31:10 -0400
Message-Id: <20200626223130.199227-7-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626223130.199227-1-peterx@redhat.com>
References: <20200626223130.199227-1-peterx@redhat.com>
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
index b14f97d3cb15..a3e0aa3ebb79 100644
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
 	up_read(&mm->mmap_sem);
 	return;
 
-- 
2.26.2

