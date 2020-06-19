Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE5D2013FA
	for <lists+linux-csky@lfdr.de>; Fri, 19 Jun 2020 18:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392523AbgFSQHA (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 19 Jun 2020 12:07:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54118 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403765AbgFSQFz (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Fri, 19 Jun 2020 12:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592582754;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nYKuiXa6JqSlFakb02F9N/z/khfKW7nv0ZKU3o10xCg=;
        b=f3TUGnTHs04S0Bqzp3mJaVZP51wuRQlvjT61aeqP5ac5T1cIr8sAWVhoR36CCgd8w8bG6e
        F1iD5gNtq8O9IXSnGI+457bTG9Rg24oVSXcFJ1+VDP/68Fupy0lNRj9iz1xj4NN1EC/yLW
        gBDJdr9N0ZuQdMsLr1nS5FB4YCevYGA=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-xV-DU0BsNPqDp-zC8UxYjA-1; Fri, 19 Jun 2020 12:05:52 -0400
X-MC-Unique: xV-DU0BsNPqDp-zC8UxYjA-1
Received: by mail-qk1-f199.google.com with SMTP id u186so976426qka.4
        for <linux-csky@vger.kernel.org>; Fri, 19 Jun 2020 09:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nYKuiXa6JqSlFakb02F9N/z/khfKW7nv0ZKU3o10xCg=;
        b=nUgKexxIpaFe1GNhO45rRIXMRbl2lXnlnkTAx7A4fPKQbJEBzWrrkZQKvqHfAxI7cD
         KFqCMtyZQKcNQd5wlKWUrVwRKYUUv0NJm8ORsVAmwVTveypsQyT1C52WvOzsto3vg8b1
         p/UXor9pEpnSSLQZPhhTXE57+YOb8eBGNlAt6W+tFkbirX499cfyCTc0nF+Roe7O5CrB
         nbAWS+jBlFgi7rS735CoJHchepK72+KUOUYSmR8/cjJFI/nyRgMlmtl+gR9ouJR8LTwn
         7kCtIhG5nGNbfY90CqOSA8nQjuaTciivyHXkiHvZN4Hm/iO51AkrYOqTQGSKfNpEz2AJ
         8kZA==
X-Gm-Message-State: AOAM533IJXAby1gz01Xn7leZzKaPEHB/heBONoIh4IBFXZFiqCec08Yh
        VOWtn17yqpDcOag4FNVSpavnX8XJIjXqaamdNF2ImR3PezoTTRPdRQZukLIMePI5L0TGZOY637Q
        1KO1SIYbj5mh/FPcytE/B1g==
X-Received: by 2002:a05:620a:3cc:: with SMTP id r12mr4302299qkm.44.1592582751653;
        Fri, 19 Jun 2020 09:05:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySAqeFc3bvWBPkc6npddWja9I+KCezM5DnLrSAgO76qm+hQxaisHscRU59a9ognA5IwopVqQ==
X-Received: by 2002:a05:620a:3cc:: with SMTP id r12mr4302251qkm.44.1592582751313;
        Fri, 19 Jun 2020 09:05:51 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id g11sm6412604qkk.123.2020.06.19.09.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 09:05:50 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH 06/26] mm/csky: Use general page fault accounting
Date:   Fri, 19 Jun 2020 12:05:18 -0400
Message-Id: <20200619160538.8641-7-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200619160538.8641-1-peterx@redhat.com>
References: <20200619160538.8641-1-peterx@redhat.com>
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

