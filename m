Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16BF72E76FD
	for <lists+linux-csky@lfdr.de>; Wed, 30 Dec 2020 09:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgL3IVE (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 30 Dec 2020 03:21:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10098 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgL3IVE (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 30 Dec 2020 03:21:04 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4D5PMW0hM4zM9P9;
        Wed, 30 Dec 2020 16:19:19 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Wed, 30 Dec 2020 16:20:20 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <guoren@kernel.org>, <keescook@chromium.org>,
        <luto@amacapital.net>, <wad@chromium.org>
CC:     <linux-csky@vger.kernel.org>
Subject: [PATCH] csky: remove unused including <linux/version.h>
Date:   Wed, 30 Dec 2020 16:20:20 +0800
Message-ID: <1609316420-9020-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 arch/csky/include/asm/thread_info.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/csky/include/asm/thread_info.h b/arch/csky/include/asm/thread_info.h
index 21456a3..f704e27 100644
--- a/arch/csky/include/asm/thread_info.h
+++ b/arch/csky/include/asm/thread_info.h
@@ -6,7 +6,6 @@
 
 #ifndef __ASSEMBLY__
 
-#include <linux/version.h>
 #include <asm/types.h>
 #include <asm/page.h>
 #include <asm/processor.h>
-- 
2.7.4

