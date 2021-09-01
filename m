Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 776CA3FE415
	for <lists+linux-csky@lfdr.de>; Wed,  1 Sep 2021 22:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242875AbhIAUcA (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 1 Sep 2021 16:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240110AbhIAUby (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 1 Sep 2021 16:31:54 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB52C06129F
        for <linux-csky@vger.kernel.org>; Wed,  1 Sep 2021 13:30:48 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id l3-20020a056214104300b00366988901acso941319qvr.2
        for <linux-csky@vger.kernel.org>; Wed, 01 Sep 2021 13:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=reply-to:date:in-reply-to:message-id:mime-version:references
         :subject:from:to:cc;
        bh=6ZnGJJdv4n8mbt+RRpvBUW8D60FX4+hBHNzvuCZCTkM=;
        b=d1pxFxqJMbf3szpeZg0swAOEez6wH0zflg3vAq4KGbMImJ4S+KcHkhLB2r/3ioVEjj
         ZLhMOpEXMbzCd0IWl9AkSsBlcbzJmd/lYcIK62ZIhRKzL4NvbVpZZVPoNMVqdiHHbt4l
         QbALEWkmHHyf/Sxszih3MXmSDzw28c9uX4Z6jqZP9TuQMex85DDMRFWrKHdddQ1LfBDG
         HR2V+1v5QBtwvPNmJM7wbgXhZ/x0UcPvJa2o/Y/oXzQq4oHwW3F/hSIbY0H235BKyazb
         jt7ElehpbA0TgSdQZQHpNpry8CrPH3K3ffwS8r087C919IqMkZVLjJpdsnXa0ZlxJf0O
         /VMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:date:in-reply-to:message-id
         :mime-version:references:subject:from:to:cc;
        bh=6ZnGJJdv4n8mbt+RRpvBUW8D60FX4+hBHNzvuCZCTkM=;
        b=GuQU91tqMGa8mt9xyIF0O7T0+RBQgPL1/erIHru5GJlJDK2oVmEZ8dP1Y17AV04iNU
         Fg2JROJ+zsaC8p6y6v54qaH+C30cCF/enwttpo3qMfuEUZe3nUGsFonVQGtbo+aELVd5
         M6GQVBa6zSZBRCBp/SjH2Wlz2hjyt41EBQtm3yQRz/11rFVRJvAT14rM9ek43yrESvks
         kIgukm+ka/DldZyNcQ+qMemMtc67xn2mJcbpXWUYZ1L9ZIyLYJY9V7QmPCA1WTFuRTpH
         H25EjdfGEPNzRN7/Ehz4hJUfNXRSROloaXJn4qxLukBUdWTalP+ns7gDw1zjl7ZVE/Sh
         Ogcw==
X-Gm-Message-State: AOAM532HXEvDTq12eflYYIHSJJ2TwHTSMQvUcEHTXnI69umFYVzQm3AJ
        OoZs2C2jJJmOOdvMksAwzLhR/YeaaGE=
X-Google-Smtp-Source: ABdhPJwYmVdzRr+jSYE642JvpN+Oe5nX73xj03Cuo8ty9uFNk/pmfGvXKihV+8dOLi2D30iy1yma/XQrogE=
X-Received: from seanjc798194.pdx.corp.google.com ([2620:15c:90:200:9935:5a5e:c7b6:e649])
 (user=seanjc job=sendgmr) by 2002:a05:6214:104d:: with SMTP id
 l13mr1694132qvr.13.1630528247381; Wed, 01 Sep 2021 13:30:47 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Wed,  1 Sep 2021 13:30:30 -0700
In-Reply-To: <20210901203030.1292304-1-seanjc@google.com>
Message-Id: <20210901203030.1292304-6-seanjc@google.com>
Mime-Version: 1.0
References: <20210901203030.1292304-1-seanjc@google.com>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
Subject: [PATCH v3 5/5] KVM: selftests: Remove __NR_userfaultfd syscall fallback
From:   Sean Christopherson <seanjc@google.com>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-mips@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Peter Foley <pefoley@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Revert the __NR_userfaultfd syscall fallback added for KVM selftests now
that x86's unistd_{32,63}.h overrides are under uapi/ and thus not in
KVM sefltests' search path, i.e. now that KVM gets x86 syscall numbers
from the installed kernel headers.

No functional change intended.

Reviewed-by: Ben Gardon <bgardon@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 tools/arch/x86/include/uapi/asm/unistd_64.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/arch/x86/include/uapi/asm/unistd_64.h b/tools/arch/x86/include/uapi/asm/unistd_64.h
index 4205ed4158bf..cb52a3a8b8fc 100644
--- a/tools/arch/x86/include/uapi/asm/unistd_64.h
+++ b/tools/arch/x86/include/uapi/asm/unistd_64.h
@@ -1,7 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __NR_userfaultfd
-#define __NR_userfaultfd 282
-#endif
 #ifndef __NR_perf_event_open
 # define __NR_perf_event_open 298
 #endif
-- 
2.33.0.153.gba50c8fa24-goog

