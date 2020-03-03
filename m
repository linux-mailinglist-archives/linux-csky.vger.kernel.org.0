Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89437176B35
	for <lists+linux-csky@lfdr.de>; Tue,  3 Mar 2020 03:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728561AbgCCCss (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Mon, 2 Mar 2020 21:48:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:44680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbgCCCss (ORCPT <rfc822;linux-csky@vger.kernel.org>);
        Mon, 2 Mar 2020 21:48:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEB80246DF;
        Tue,  3 Mar 2020 02:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583203727;
        bh=1Y8fBheo+gb39pMv7lTELFyrrzvQXoZGwB0CRyzuFc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJTu2RwWs+QwZznBJmgF/SvyGgADGfhI/i7/au/1L7rg1sZzNTPeoPZefRP4XXpb/
         0rENvb9IyQgIA7d9kndLVgHZ9qrEUw1sZLKffnptVRQ4UMW9OYsMMn90YpUpVBUtet
         s6+FyXhTovAupGatHkcBf1v1qV3jwRHZ3uz8aqo4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Sasha Levin <sashal@kernel.org>, linux-csky@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 56/58] csky: Fixup compile warning for three unimplemented syscalls
Date:   Mon,  2 Mar 2020 21:47:38 -0500
Message-Id: <20200303024740.9511-56-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200303024740.9511-1-sashal@kernel.org>
References: <20200303024740.9511-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

[ Upstream commit 2305f60b76110cb3e8658a4ae85d1f7eb0c66a5b ]

Implement fstat64, fstatat64, clone3 syscalls to fixup
checksyscalls.sh compile warnings.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/include/uapi/asm/unistd.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/csky/include/uapi/asm/unistd.h b/arch/csky/include/uapi/asm/unistd.h
index 211c983c7282d..ba40189297338 100644
--- a/arch/csky/include/uapi/asm/unistd.h
+++ b/arch/csky/include/uapi/asm/unistd.h
@@ -1,7 +1,10 @@
 /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
+#define __ARCH_WANT_STAT64
+#define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_SYS_CLONE
+#define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_SET_GET_RLIMIT
 #define __ARCH_WANT_TIME32_SYSCALLS
 #include <asm-generic/unistd.h>
-- 
2.20.1

