Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A288429F0E1
	for <lists+linux-csky@lfdr.de>; Thu, 29 Oct 2020 17:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbgJ2QNU (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 29 Oct 2020 12:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2QNS (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 29 Oct 2020 12:13:18 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5628BC0613CF
        for <linux-csky@vger.kernel.org>; Thu, 29 Oct 2020 09:13:18 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id x7so3609345ili.5
        for <linux-csky@vger.kernel.org>; Thu, 29 Oct 2020 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CxZxnzINXZRT3YGogUWBhXNUk7pxaKbs9qaXsTqeRDs=;
        b=nCgsOeGWTzSyElFPe6aS772O9zRic7wWosPv+P1ULYSRNF2LtxZOanOsZ+OewCYVrk
         WQObkbAylUNmSlLbtVkaZ/3Iu2NZ8jmi3U60cpnM/dU/XiQ1v36T+OR9jj/tz4NNYOaf
         l/6OnzDo8fWxAPo0SVSlTtMb2W8rFnxqnJwDYtfMUMOy3KgfWynd+2DAU7tyUG2/4SjP
         Z+WonQAuwBxXcJDWK3YN07HKu1Z0Nw8L7mrVsN4auI/6AkQLelA3JZP5dliBbCNOjQhb
         hE6HDmweGOu6y5gA3awnsxMjfH8hCrHYoi9oPQRXCYbrz7mtQ76lKHbESQqZa9Lhp7MR
         JRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CxZxnzINXZRT3YGogUWBhXNUk7pxaKbs9qaXsTqeRDs=;
        b=FTFIf/mu3vUMe3p+6AIik5fIZZCEaMItW4M0QDGKqLXB1o1Dr2Am0AjIJwK3muwTIv
         eZRcOY98RCAahpt4QaEHJ/+oZMVhZzjw8m6gA3foIL8j4yiYMeli/CWGqUzbTefA0ROn
         i4GoqIX5GBP2dAIu6Lk1lAa/iu0QxIMycwAUTeZnanIt7/NS2B7Ly1uBAZSfEBSWjBQ1
         Q8x4NNwykvQOnGS++xAV/Hj16LwCunq8ev/K8jFH6HiPCGUwT72e6dxJuZsl0+J4/u0x
         qkpGzmkYgmKK0OQ7eLy4IxO5wr3Kq7Gk5hKLQDPmK4kEZjbBUCsxU/7E5K9KeWD080NY
         9QzA==
X-Gm-Message-State: AOAM5325jtJ7wFFmaU3YnHBneCqUiOerHcpQ6zPIyRVgmoqpdKDQuXZT
        pZw2T+1n3ruDmf6U0sxNPZtRu8yk/LsT0A==
X-Google-Smtp-Source: ABdhPJxANGpxIEtRO1BXALnM7dUFvh8db5yGpEBLo76xjy7OcxuCw27eX11S2cwuGbZbqzjaaF7Enw==
X-Received: by 2002:a92:5b42:: with SMTP id p63mr4036000ilb.139.1603987997319;
        Thu, 29 Oct 2020 09:13:17 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id i201sm2716191ild.12.2020.10.29.09.13.16
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Oct 2020 09:13:16 -0700 (PDT)
To:     linux-csky@vger.kernel.org
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] csky: add support for TIF_NOTIFY_SIGNAL
Message-ID: <4f498dfd-00eb-3f15-4529-672264fdab0f@kernel.dk>
Date:   Thu, 29 Oct 2020 10:13:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Wire up TIF_NOTIFY_SIGNAL handling for csky.

Cc: linux-csky@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---

5.11 has support queued up for TIF_NOTIFY_SIGNAL, see this posting
for details:

https://lore.kernel.org/io-uring/20201026203230.386348-1-axboe@kernel.dk/

As part of that work, I'm adding TIF_NOTIFY_SIGNAL support to all archs,
as that will enable a set of cleanups once all of them support it. I'm
happy carrying this patch if need be, or it can be funelled through the
arch tree. Let me know.

 arch/csky/include/asm/thread_info.h | 5 ++++-
 arch/csky/kernel/signal.c           | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index 68e7a1227170..21456a3737c2 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -64,6 +64,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_SYSCALL_TRACE	4	/* syscall trace active */
 #define TIF_SYSCALL_TRACEPOINT	5       /* syscall tracepoint instrumentation */
 #define TIF_SYSCALL_AUDIT	6	/* syscall auditing */
+#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
 #define TIF_POLLING_NRFLAG	16	/* poll_idle() is TIF_NEED_RESCHED */
 #define TIF_MEMDIE		18      /* is terminating due to OOM killer */
 #define TIF_RESTORE_SIGMASK	20	/* restore signal mask in do_signal() */
@@ -75,6 +76,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
+#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
@@ -82,7 +84,8 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 
 #define _TIF_WORK_MASK		(_TIF_NEED_RESCHED | _TIF_SIGPENDING | \
-				 _TIF_NOTIFY_RESUME | _TIF_UPROBE)
+				 _TIF_NOTIFY_RESUME | _TIF_UPROBE | \
+				 _TIF_NOTIFY_SIGNAL)
 
 #define _TIF_SYSCALL_WORK	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | \
 				 _TIF_SYSCALL_TRACEPOINT | _TIF_SECCOMP)
diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
index 8b068cf37447..37ea64ed3c12 100644
--- a/arch/csky/kernel/signal.c
+++ b/arch/csky/kernel/signal.c
@@ -257,7 +257,7 @@ asmlinkage void do_notify_resume(struct pt_regs *regs,
 		uprobe_notify_resume(regs);
 
 	/* Handle pending signal delivery */
-	if (thread_info_flags & _TIF_SIGPENDING)
+	if (thread_info_flags & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
 		do_signal(regs);
 
 	if (thread_info_flags & _TIF_NOTIFY_RESUME) {
-- 
2.29.0

-- 
Jens Axboe

