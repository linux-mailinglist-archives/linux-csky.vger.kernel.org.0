Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F576D9628
	for <lists+linux-csky@lfdr.de>; Thu,  6 Apr 2023 13:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbjDFLpg (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 6 Apr 2023 07:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbjDFLpG (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 6 Apr 2023 07:45:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887F11114D;
        Thu,  6 Apr 2023 04:41:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13DE164663;
        Thu,  6 Apr 2023 11:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2634C433D2;
        Thu,  6 Apr 2023 11:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680780871;
        bh=V5BQsr3kjpmrNU85YSATEXJCjRsQghWvapoHfDmbADI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CL2DFiJbpiVUHZyaRsFIKr64609SX2qUMaRuLbfgBNegShercRs9iCTf+yaN78Anc
         lXdjRVE1CpRpS3YNsW4ERROQe09TUQOhaeYRsKUJdcfSzwr0cMwzTJHgSvK9Zw8RH3
         2j/Y/C4mCwZTjlq1rPM223zHnR89CcQUDkrZNCXvtzx/HaPVPUEEED0AMp92N5sWss
         siF6c3QojJ6ujju+qR3B6IwkZWSVxS/DwTwFUM0FS6Jdyd4X+eDwOvEetUPVHs9Iom
         WI5z0qLtXQjKQJYmDAOFLAD8Q8sX8xhYy06cTsXK7UVbsNXISNk8Zy6sc1dqX4mvnZ
         f5+Si1Uunj7bA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Functional Testing <lkft@linaro.org>,
        Kees Cook <keescook@chromium.org>,
        Anders Roxell <anders.roxell@linaro.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, shuah@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@kernel.org, nathan@kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH AUTOSEL 4.14 2/7] selftests: sigaltstack: fix -Wuninitialized
Date:   Thu,  6 Apr 2023 07:34:16 -0400
Message-Id: <20230406113421.649149-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230406113421.649149-1-sashal@kernel.org>
References: <20230406113421.649149-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

From: Nick Desaulniers <ndesaulniers@google.com>

[ Upstream commit 05107edc910135d27fe557267dc45be9630bf3dd ]

Building sigaltstack with clang via:
$ ARCH=x86 make LLVM=1 -C tools/testing/selftests/sigaltstack/

produces the following warning:
  warning: variable 'sp' is uninitialized when used here [-Wuninitialized]
  if (sp < (unsigned long)sstack ||
      ^~

Clang expects these to be declared at global scope; we've fixed this in
the kernel proper by using the macro `current_stack_pointer`. This is
defined in different headers for different target architectures, so just
create a new header that defines the arch-specific register names for
the stack pointer register, and define it for more targets (at least the
ones that support current_stack_pointer/ARCH_HAS_CURRENT_STACK_POINTER).

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Link: https://lore.kernel.org/lkml/CA+G9fYsi3OOu7yCsMutpzKDnBMAzJBCPimBp86LhGBa0eCnEpA@mail.gmail.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../sigaltstack/current_stack_pointer.h       | 23 +++++++++++++++++++
 tools/testing/selftests/sigaltstack/sas.c     |  7 +-----
 2 files changed, 24 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/sigaltstack/current_stack_pointer.h

diff --git a/tools/testing/selftests/sigaltstack/current_stack_pointer.h b/tools/testing/selftests/sigaltstack/current_stack_pointer.h
new file mode 100644
index 0000000000000..ea9bdf3a90b16
--- /dev/null
+++ b/tools/testing/selftests/sigaltstack/current_stack_pointer.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#if __alpha__
+register unsigned long sp asm("$30");
+#elif __arm__ || __aarch64__ || __csky__ || __m68k__ || __mips__ || __riscv
+register unsigned long sp asm("sp");
+#elif __i386__
+register unsigned long sp asm("esp");
+#elif __loongarch64
+register unsigned long sp asm("$sp");
+#elif __ppc__
+register unsigned long sp asm("r1");
+#elif __s390x__
+register unsigned long sp asm("%15");
+#elif __sh__
+register unsigned long sp asm("r15");
+#elif __x86_64__
+register unsigned long sp asm("rsp");
+#elif __XTENSA__
+register unsigned long sp asm("a1");
+#else
+#error "implement current_stack_pointer equivalent"
+#endif
diff --git a/tools/testing/selftests/sigaltstack/sas.c b/tools/testing/selftests/sigaltstack/sas.c
index 228c2ae47687d..6069d97bf5063 100644
--- a/tools/testing/selftests/sigaltstack/sas.c
+++ b/tools/testing/selftests/sigaltstack/sas.c
@@ -19,6 +19,7 @@
 #include <errno.h>
 
 #include "../kselftest.h"
+#include "current_stack_pointer.h"
 
 #ifndef SS_AUTODISARM
 #define SS_AUTODISARM  (1U << 31)
@@ -40,12 +41,6 @@ void my_usr1(int sig, siginfo_t *si, void *u)
 	stack_t stk;
 	struct stk_data *p;
 
-#if __s390x__
-	register unsigned long sp asm("%15");
-#else
-	register unsigned long sp asm("sp");
-#endif
-
 	if (sp < (unsigned long)sstack ||
 			sp >= (unsigned long)sstack + SIGSTKSZ) {
 		ksft_exit_fail_msg("SP is not on sigaltstack\n");
-- 
2.39.2

