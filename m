Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 998913C4B0D
	for <lists+linux-csky@lfdr.de>; Mon, 12 Jul 2021 12:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239572AbhGLGz2 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Mon, 12 Jul 2021 02:55:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:53294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240839AbhGLGyD (ORCPT <rfc822;linux-csky@vger.kernel.org>);
        Mon, 12 Jul 2021 02:54:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99B5760FDB;
        Mon, 12 Jul 2021 06:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1626072676;
        bh=0Mhtj2ALqFzzEzlMYegUNK373szXjXHWvZKnVqs60so=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CLKKeQ2yxHty2ldd7ythW0aKH/gTuX1mIbyw1ZFjIXKf4LytwBpdBTRK4lHCGRk3A
         v+uoKT/DRiELwHGXl80jiJB+JpdPuGKiACcjadtMi/NJqtBxbcjWPrk+VHLjE8o3K+
         ALU9brEn45AfhhcKDGIg2oBFD81cd/FART6PR7bo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 578/593] csky: fix syscache.c fallthrough warning
Date:   Mon, 12 Jul 2021 08:12:18 +0200
Message-Id: <20210712060958.712874417@linuxfoundation.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210712060843.180606720@linuxfoundation.org>
References: <20210712060843.180606720@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 0679d29d3e2351a1c3049c26a63ce1959cad5447 ]

This case of the switch statement falls through to the following case.
This appears to be on purpose, so declare it as OK.

../arch/csky/mm/syscache.c: In function '__do_sys_cacheflush':
../arch/csky/mm/syscache.c:17:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
   17 |   flush_icache_mm_range(current->mm,
      |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   18 |     (unsigned long)addr,
      |     ~~~~~~~~~~~~~~~~~~~~
   19 |     (unsigned long)addr + bytes);
      |     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../arch/csky/mm/syscache.c:20:2: note: here
   20 |  case DCACHE:
      |  ^~~~

Fixes: 997153b9a75c ("csky: Add flush_icache_mm to defer flush icache all")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: linux-csky@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/mm/syscache.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/csky/mm/syscache.c b/arch/csky/mm/syscache.c
index ffade2f9a4c8..4e51d63850c4 100644
--- a/arch/csky/mm/syscache.c
+++ b/arch/csky/mm/syscache.c
@@ -17,6 +17,7 @@ SYSCALL_DEFINE3(cacheflush,
 		flush_icache_mm_range(current->mm,
 				(unsigned long)addr,
 				(unsigned long)addr + bytes);
+		fallthrough;
 	case DCACHE:
 		dcache_wb_range((unsigned long)addr,
 				(unsigned long)addr + bytes);
-- 
2.30.2



