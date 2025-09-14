Return-Path: <linux-csky+bounces-2364-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EFAB5654E
	for <lists+linux-csky@lfdr.de>; Sun, 14 Sep 2025 05:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1AEA7AC918
	for <lists+linux-csky@lfdr.de>; Sun, 14 Sep 2025 03:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8C826E6E8;
	Sun, 14 Sep 2025 03:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vnx7+S6v"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9A723D7FF
	for <linux-csky@vger.kernel.org>; Sun, 14 Sep 2025 03:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822160; cv=none; b=GRkrEC96AO7IcX5JyDxaR9JPz50RXFQd2WYzcwvPpYxgse9w5O6XW7avyO2prVf84qRf3q0WRCkAP6wHFuN8ICEm1KNMojQaOdq2L95jQgz/EeOiPFycGWuocvhPwLzTJa2t1+pEEq3quCXW9OqXRSTBzZb9NinpxTwNn9Ig4/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822160; c=relaxed/simple;
	bh=n+mmy3PjKTU6Jj1te3ZtONq7xS36QH+38sfXYxmW5ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0UTw86HBXBuTNJXXJ9f3Zz8V8qVcODCoNU/H2lk0c62fCauHAzgWdfMviY1pWGHKPSj/ApCVGkZYdmW/5LSkEQQkzDivUwvrtaKBdXcabk07XA5XkCiaIJE9kWC4EbqQL2FUHmy83mZF6UYa8YEdChpRlhxFSvzgUY4CoWr1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vnx7+S6v; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-62f330eeb86so55273a12.2
        for <linux-csky@vger.kernel.org>; Sat, 13 Sep 2025 20:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822157; x=1758426957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IZ7mWaMdZxGJK1wTX4F7lWg1sPAH5qiKx6l6RS6EW/U=;
        b=Vnx7+S6vR5uXvbxbQI6Y2nSi9+hEKUhrI+HwiAIdN707y/+/0p2YE+/GeqFmuX1GRJ
         UmfbavpAMsUNv/JYJb/rHEKQIImz68EFaYQS6v90t97us53l6aJTcciPwYDeAptqB5uE
         KIVroc2zNs2ycQRgXSexOBVTJGNWyP0I7PBdHbRfFW+/H6OrVTg6b6+9tLmEf7kiELSY
         Wh0ffdJCq58eBl69bD7bPJX2rKH96f8FrWO8iO46le5j7Do/KceVIc7/U+x0Jpi9Um1d
         9aLhofIKfXtovdWaTt6eDwUVr+rWqj0/U7p18dRBUBcBFfwoO+WWnrDPTNnaIkPi+hV9
         p0aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822157; x=1758426957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZ7mWaMdZxGJK1wTX4F7lWg1sPAH5qiKx6l6RS6EW/U=;
        b=fRsMRvllCBhPIE3KneyTUqx8F0/jMnu3jHL779bX4cQ2ku96t9lRd2hHG/+rQma21t
         z3J/e1gWE/HVYi31qCD7ihSGB07ZrqCjukPEkMBpiRveenWwJkbD6m3Noxc4eUKjDxu2
         4G/iA3N6zK6UtUCfyh8nNuUaNrsXkmyWuvXyFIAFFQ3WOSXfscmWEXqpCMU/HSo3I/yl
         D++lzoTGyLTX6sBV6EOrRghfi17eH+w0VfAtzWGD+0ATJCptTkpzavWdTn+4/EzO60xU
         VWQj/CexOwQtpkJK3nRw5zUoiNru6r+BkP74gtDUMUXgiL/riwPx8ISD/VLBBqKJeSva
         /PAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQvfSo63rQSduIYkrNYnVyzgyBbox9LvBw8971ngugctu7X+dPo5SehT0WJ4UX8kPoC6eQ9Bq7th96@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0vD6f4DLy5mBkWBpdI2WDMJDOtwgdiJPNCVtvbQCGgIMTecUQ
	exE+qoyTXEKXZauLXUPhYsk8GDEDFLMAqhVbOAYGU93l2MjFMHOVAUka
X-Gm-Gg: ASbGncuIEwFJPzbUFKRhQgLwBm76qDCX3Z8bMQ5hE162EIznFWKkERWqs2PISxWpFG4
	WPM9tZYPC3ZZ3hAEOjT8x+r2menPtxjr2zPZU7VGkiGh+0a9XZoQvXWPYsix28eq+q24vOfKaYu
	xlRSgo+g/XvmS9+kMarXXwvKryNBXsgIDqNTRc4dfPtHMecRlxeP3lD5QYeVK9qa6V+gckiLPDJ
	9OWmqwbTUOzbe6r5TuawMgNBHQHOd259C8Mmj5Qg+lBl1A1xr3PsT/U81/QISTt8h+wHqGBxCov
	ukAfyBGZDDPo7cn+9ZZ5kpv4ZerBXuPJt0X7oDCG1R6ZTSCZj48pUTMU00XGqRkx9JY6vIbc108
	oidyjhlpnKD88ijIXzpiAojxdr9YfIg==
X-Google-Smtp-Source: AGHT+IHVlqrM3WGO2PMhAdJqFymXZDFmcHUFnmRqsIL52zZcyiB7/sntw8UcjJnO5qIuj3xo01B0kw==
X-Received: by 2002:a05:6402:278f:b0:62f:26f8:fea0 with SMTP id 4fb4d7f45d1cf-62f26f91103mr1500285a12.33.1757822156480;
        Sat, 13 Sep 2025 20:55:56 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62f2b2a8c38sm677327a12.31.2025.09.13.20.55.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:55:55 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 47/62] init: fix typo: virtul => virtual
Date: Sun, 14 Sep 2025 06:55:50 +0300
Message-ID: <20250914035550.3706342-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typo

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/initramfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/initramfs.c b/init/initramfs.c
index 8b648b09247a..cf19b7c0c358 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -636,7 +636,7 @@ void __init reserve_initramfs_mem(void)
 	phys_addr_t start;
 	unsigned long size;
 
-	/* Ignore the virtul address computed during device tree parsing */
+	/* Ignore the virtual address computed during device tree parsing */
 	virt_external_initramfs_start = virt_external_initramfs_end = 0;
 
 	if (!phys_external_initramfs_size)
-- 
2.47.2


