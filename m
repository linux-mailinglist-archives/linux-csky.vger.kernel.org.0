Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56F11FA359
	for <lists+linux-csky@lfdr.de>; Tue, 16 Jun 2020 00:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgFOWQc (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Mon, 15 Jun 2020 18:16:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44087 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726536AbgFOWQ0 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>);
        Mon, 15 Jun 2020 18:16:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592259385;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KFBAGoH4m4vLgkLo1O4lKDrZPfxmEHOi/brzsSjZMGQ=;
        b=hU4i1nePOwFBStQUl8UPBSFYz244BjLzX1JV390hJ/h9pz0DpN+iYQxkwWH8B96U82wjXc
        0yf/nfd3m0MlBvb5VyIP8WNv9M7mKADblcaRS5OUDXqJ5bQgq364lN93dT2awcYU2oz3yw
        1cYnZOeFN0mSDtHaGUj0IOHwwC7YNUY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-tWK9OQ39M6CiN7I7GQ9Xqw-1; Mon, 15 Jun 2020 18:16:22 -0400
X-MC-Unique: tWK9OQ39M6CiN7I7GQ9Xqw-1
Received: by mail-qv1-f71.google.com with SMTP id s15so14098148qvo.6
        for <linux-csky@vger.kernel.org>; Mon, 15 Jun 2020 15:16:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KFBAGoH4m4vLgkLo1O4lKDrZPfxmEHOi/brzsSjZMGQ=;
        b=XyZhyURv+sgbi7QZPC3D0BgjtnO+AjpK0fWea5U1bVxBs3eicE/WvwD4fKWF0EgZkR
         8254JbR9N0JXGSR6Ky9MxuJO2tJy+uru2Bni00qmIibnq+yV79PlyCTXZXbjdnBwm8fa
         2tPWt9iqRtJeFhyYMX8vbHFBAsFq4CbqT8jp7bw2jDlVu6MzCiZFk29YMcRsoUrafpg6
         p9R29yfD/wShsuROuq0HGYcpyDrOWUamuzs9QWQ5qh9hOjfmHlbH5qieGcaQWbwBtCaa
         VfwMndrOFlUMiISNtnLaWENpEllQ4EPeCqWF6ZTG/oaJW/EJo2UGwOaxfzB9RDFB1hsV
         5mtw==
X-Gm-Message-State: AOAM531AJrvR2yPhg5A3S0t8DFo1/f4iZ+G2ZnzEl+p5TBGzr0GuBlrN
        /jldv2ExlQwHIScJ9j5ermu3Agkyqlo/3cbXvYsTAVrk6NnmdrY73bTjzTXAfkVpGTlTas0TH/0
        Ls5O/Rez0Q9JP0zaOksDJQw==
X-Received: by 2002:ac8:768b:: with SMTP id g11mr18907573qtr.249.1592259381884;
        Mon, 15 Jun 2020 15:16:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyj2u8zUEq1AVaqIVlLmmoPxXksMKXvCW3j5Sj2WjcowIx7CNdGCFxksv3E2wEYY6My624aug==
X-Received: by 2002:ac8:768b:: with SMTP id g11mr18907553qtr.249.1592259381676;
        Mon, 15 Jun 2020 15:16:21 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id w13sm12351509qkb.91.2020.06.15.15.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 15:16:21 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, peterx@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH 07/25] mm/csky: Use mm_fault_accounting()
Date:   Mon, 15 Jun 2020 18:15:49 -0400
Message-Id: <20200615221607.7764-8-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615221607.7764-1-peterx@redhat.com>
References: <20200615221607.7764-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Use the new mm_fault_accounting() helper for page fault accounting.
Also, move the accounting to be after release of mmap_sem.

CC: Guo Ren <guoren@kernel.org>
CC: linux-csky@vger.kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/csky/mm/fault.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/arch/csky/mm/fault.c b/arch/csky/mm/fault.c
index 4e6dc68f3258..8f8d34d27eca 100644
--- a/arch/csky/mm/fault.c
+++ b/arch/csky/mm/fault.c
@@ -111,8 +111,6 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
 		return;
 	}
 #endif
-
-	perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS, 1, regs, address);
 	/*
 	 * If we're in an interrupt or have no user
 	 * context, we must not take the fault..
@@ -160,17 +158,8 @@ asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long write,
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
+	mm_fault_accounting(tsk, regs, address, fault & VM_FAULT_MAJOR);
 	return;
 
 	/*
-- 
2.26.2

