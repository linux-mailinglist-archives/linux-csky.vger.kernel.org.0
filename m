Return-Path: <linux-csky+bounces-2358-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A3DB564E2
	for <lists+linux-csky@lfdr.de>; Sun, 14 Sep 2025 05:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10ED1420FCC
	for <lists+linux-csky@lfdr.de>; Sun, 14 Sep 2025 03:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2414A26F2BC;
	Sun, 14 Sep 2025 03:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dtj5OhTs"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F380523FC41
	for <linux-csky@vger.kernel.org>; Sun, 14 Sep 2025 03:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757821946; cv=none; b=hLlxqPIV1BcMAKZ1cRBaRcPytmETd8IkRqyd5/u4SpR1SBvkEYXZIGujGU8BfdSOCIxFySiPYNUUURsr9k5C1DOn4tlE6XMhEV1nZ4lPjLOaakSgVjx1DJ6s6wa7n6qzC6l60Tvgyl1UbryL6WGmSuenTCVe6/j4g8QFRkqN0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757821946; c=relaxed/simple;
	bh=UZLn6ULQgc/FnEmwCGdDgCcEQNlktPyYM0GENq2QFck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uyx0z96NvsWSCxMIaSR8mvaFWJHp4B79tesl9e0Zu5PrR2W3D5tlkCGWpxOrLknVH1J6x34+JDp7xJMlUd+R6h/JVLZrtQUt1BEE3AoEHTFBDqI72w2i+UjNlh0rwqQ6anxTY+CATqm+tsWZtIxZ7Kjt4j9MHOJFEgA+kR2nC9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dtj5OhTs; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07e3a77b72so134267766b.0
        for <linux-csky@vger.kernel.org>; Sat, 13 Sep 2025 20:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757821940; x=1758426740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ji/7LeyyXA3A1wf+r0NloCDgCP9kYwAbhvqoNAjAUZw=;
        b=Dtj5OhTsBzQk3sJ5Qvo5Cj1p0EESJX2lCq88wE1ffN4FbLgUYpOsA57Kqcs2YB96oS
         +0LkAdWToxZIBKUlf3ATRppWIqmTVhFIdFdQMHWcwvuD/l7bfRSKLiu7aE6ESdnXEpDW
         HbkaJDABKAPcz+tvW0LuHx5daig5XpPoBA6x6MHtPj9U4ZrB6FN//gU+4xilJjo9FqR4
         /BJB8SSVvIXGPRLOT2TWSOxx1kVgdA4FJFgEFufUhw8YnGWJuW/VYk5uYBOH38KGQWQN
         6QCffW0uulyxZAasYxWkIfBCOgzcm94JIzcKRGRtUH5hfwjUf7vaGWaFXQEi8nx3xZwJ
         v0IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757821940; x=1758426740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ji/7LeyyXA3A1wf+r0NloCDgCP9kYwAbhvqoNAjAUZw=;
        b=ce+iCln9ICA300xrWbUnuWgdhwwwc/Gl9+EtcHelvnnl6ly0FgXxWypC1c7sNfJamz
         HCwXoDvuxpPkpCR3scvPAdS1PkLaGM9G5UukNZqriT2pvzW5/MId4E/CjEVt8USbI6OP
         GFrbWskTeV6Gh+H9WOG/5+8fUWSPRaMjSw7936p84zDCLblUliEd6KSGCKfVwnTHaTzU
         lHu4eU61s+kYaE431D/q4W039zF3DVx/V4kS4fScfmtGJTC0U59JKnhW9sh0hoMfd4b0
         Yue+BdTe11vyP8yGkQ5KIydP5K29jrLOV9kJayjxvyh1M5PaB1//mtKewh1eqs5q4qXf
         O/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCXNWjMZqEO3MIhLLr9LZuetkojbOtfqdroPu0ZkeKWwgmS/6qk9WvENIak40IMirOn54yqO2WbbMIbB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5f+n4g9cvUmic391eziGVy4JhY0cG4KspcSuuFhkWY3OxYa+p
	Xq8p8pHsPInPLIzT70ePxDp21ePwSU4iSnbOJl48RY2BNsi01k22aVPn
X-Gm-Gg: ASbGncvmkEcKXTC3MZavCDYASXXp7d4K6xkDNHzxPKSZv4eu/9EmppDMxCIi2MF3NPg
	5AYdB6SP/OQJFCmwzF+OuovkULKC7XUAKLQLpeEayb7yr/nC4rBMcD+SmM1e48Gt7i/btWJ8u91
	s7S1ijUp5yxQxBsSYjqHDe66YDeIJqfHbv2vp/uGrlRBbhgG1LwxzhiBvp8LlKzNZat7fYGyIOb
	DIYHadvM9y4YHrMO8UO8wgr/CKF0JR3Rtt9KUR5ymtPJzXe/fNjdJLPEE79eXim3dde2ByT7Ox8
	Rtc2JK+TY4b8xP6I0fiJZi0tZbGlYy0DLuCG42cZhFPj79OLa+lmsAeIpKiN2SUclQ1q0KJYVzR
	k5S7H6X1Pv3UhXsGnQXg=
X-Google-Smtp-Source: AGHT+IFrowlqfzYJmQGTHyfqsFCL1BbKqEywr8+/6hRK49j3T1AOHulukHNAqoGa7PMdZRPYrPs7MA==
X-Received: by 2002:a17:907:3da2:b0:b04:6157:43b with SMTP id a640c23a62f3a-b07c2544bb9mr854247466b.25.1757821940418;
        Sat, 13 Sep 2025 20:52:20 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd88fsm669745266b.51.2025.09.13.20.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:52:20 -0700 (PDT)
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
Subject: [PATCH RESEND 41/62] init: rename reserve_initrd_mem to reserve_initramfs_mem
Date: Sun, 14 Sep 2025 06:52:15 +0300
Message-ID: <20250914035215.3641628-1-safinaskar@gmail.com>
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

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/arm/mm/init.c            | 2 +-
 arch/loongarch/kernel/setup.c | 2 +-
 arch/riscv/mm/init.c          | 2 +-
 include/linux/initrd.h        | 4 ++--
 init/initramfs.c              | 2 +-
 5 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 290e9f9874c9..a564cbc36d18 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -186,7 +186,7 @@ void __init arm_memblock_init(const struct machine_desc *mdesc)
 	/* Register the kernel text, kernel data and initrd with memblock. */
 	memblock_reserve(__pa(KERNEL_START), KERNEL_END - KERNEL_START);
 
-	reserve_initrd_mem();
+	reserve_initramfs_mem();
 
 	arm_mm_memblock_reserve();
 
diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.c
index 075b79b2c1d3..226262f35dc1 100644
--- a/arch/loongarch/kernel/setup.c
+++ b/arch/loongarch/kernel/setup.c
@@ -602,7 +602,7 @@ void __init setup_arch(char **cmdline_p)
 	pagetable_init();
 	bootcmdline_init(cmdline_p);
 	parse_early_param();
-	reserve_initrd_mem();
+	reserve_initramfs_mem();
 
 	platform_init();
 	arch_mem_init(cmdline_p);
diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 15683ae13fa5..b1c4876dadae 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -295,7 +295,7 @@ static void __init setup_bootmem(void)
 
 	dma32_phys_limit = min(4UL * SZ_1G, (unsigned long)PFN_PHYS(max_low_pfn));
 
-	reserve_initrd_mem();
+	reserve_initramfs_mem();
 
 	/*
 	 * No allocation should be done before reserving the memory as defined
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index b2a0128c3438..51c473b6a973 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -10,10 +10,10 @@ extern unsigned long virt_external_initramfs_start, virt_external_initramfs_end;
 extern void free_initramfs_mem(unsigned long, unsigned long);
 
 #ifdef CONFIG_BLK_DEV_INITRD
-extern void __init reserve_initrd_mem(void);
+extern void __init reserve_initramfs_mem(void);
 extern void wait_for_initramfs(void);
 #else
-static inline void __init reserve_initrd_mem(void) {}
+static inline void __init reserve_initramfs_mem(void) {}
 static inline void wait_for_initramfs(void) {}
 #endif
 
diff --git a/init/initramfs.c b/init/initramfs.c
index 7a050e54ff1a..a6c11260e62b 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -631,7 +631,7 @@ early_param("initrd", early_initrd);
 
 static BIN_ATTR(initrd, 0440, sysfs_bin_attr_simple_read, NULL, 0);
 
-void __init reserve_initrd_mem(void)
+void __init reserve_initramfs_mem(void)
 {
 	phys_addr_t start;
 	unsigned long size;
-- 
2.47.2


