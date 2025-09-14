Return-Path: <linux-csky+bounces-2354-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A52B5649C
	for <lists+linux-csky@lfdr.de>; Sun, 14 Sep 2025 05:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3628420876
	for <lists+linux-csky@lfdr.de>; Sun, 14 Sep 2025 03:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9A8264628;
	Sun, 14 Sep 2025 03:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Meuoho8s"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4197267F59
	for <linux-csky@vger.kernel.org>; Sun, 14 Sep 2025 03:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757821428; cv=none; b=acpsc/7tMks68iSJ2noqCC5WWuY9h6PxsvKdSIQhPKsmEjry+91FdQTXpGTDGdIN5ssqw+ChSZQ3MLvNEuWYbwLt5Jaw2Gho+YlE4gTi/nmlxg1LHTiYYwYO2LfWqeunbb9I63Tx9eTOSO/2y6jLZdtTjXpDf6D786Ix33h8XVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757821428; c=relaxed/simple;
	bh=Rey/ebl7WFu2BHJpZO0tlGb9Yvux/yHNtNSpgXJUf3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u9NlT3nfzS8xos9pVSpa01UWcJzcwiP4M7U2DTu8sP1I3CDN01lsUoZGThWEpQU+Sw9k/bDb1mZj3XHVG2RPkr1BmaVnBpmW6zPmRh2C5qEP9Ll9hz8GJDdeoblgXX0xb74FK1iR0x4pjG5XXtzAMOkkkTppvDl1Ti+w1YcTe7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Meuoho8s; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b07c38680b3so313489466b.1
        for <linux-csky@vger.kernel.org>; Sat, 13 Sep 2025 20:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757821422; x=1758426222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Edp+OfqM1e00xcpSWGvAGWC/LGQGu+BMiq7TC0KqX/w=;
        b=Meuoho8stdCgQ03Hoq6UgAr03TaN96IypV+PgLqP/nGA44yo2zt6U929mjRx+HCq13
         FPWIoc3jiMY7qBRlszyNQbvaQVxYynf3mcVS4ZUqM9DXZXSglG7vOuDf+9BPpKpwhOE5
         esyrIr1LmwK1sh8FW8bsMCVhqfrrjJWn3/4I8UakoSU28KzFPHuQL9W0/2J7g0A8nZ1O
         T5RsV+SSGzPKnwo1gUBPlfDSkMXh66xIdqSXJL7EHd2oWfyzikGuiq7xGrG+i6kSggsO
         7dLhiHDpmeMEhTiC4sxGkbT4o1wUK7rDi6kWKBKQROziCBkBfVzJywQs93poRxb5DR22
         ZxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757821422; x=1758426222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Edp+OfqM1e00xcpSWGvAGWC/LGQGu+BMiq7TC0KqX/w=;
        b=Or5nBfsN9pgKpO0YlgPyh/EOAYp0wEd/NbJMCz96M9K9xPaBMxLTXrT8GrWlm9MF0n
         l/sobcvfLY2+lZ8Wd8WQ/QEmNKCUq6dkXjlbYIwqh+gf9hgrLuAJzmlQt2P5ygLEpTgf
         sONFqEmuJH8g8nAueYF63mdvbiQ/7gaDij7pX42xfGH1aW0Icuze3Gl1WPAAkcxS7cNb
         Oy+9wyHLGeyCzhbogXdXhQnakvptb1LpESqnxcEBNtyCoCJBZXycfYeqgM3Dl1U7Z5I3
         A2xpjzX0CImbvo3cW/cHdjy2sd+7YS76AsqKxNJu5UgIoO+H3OhDl78KfaAfXm2opHdA
         riUA==
X-Forwarded-Encrypted: i=1; AJvYcCWpqPl5MZwoaPE4gyLIoadGZE7D3uGxc+GynWPcjIwtOVtsPtqhWzf4uD+oH+NmBBSlSOCvyWzYWKvB@vger.kernel.org
X-Gm-Message-State: AOJu0YwxNwzrEfw1vBd1DokkbupRZRg+JUHggC94n1hDyBzGOGP/NFfq
	4g2M4DqnB7CXO9TCmNMUWg0XxBrGml8IAdQpwBp/pDKktmkP+uXAVfk5
X-Gm-Gg: ASbGncuZ0qUOjPazOdPCH5bg8z/tywAdO+M/mtZoNO4f52hk/bQO+xI5XwoJZoP22ZO
	FvPF3TazDxGZlM58bRgfIk8iCSf/SpXY9gJiSI79y2lkx2GVcbLOvOVo68IasYvLBCaed5POhHD
	11l+NLfQdZgI3QmwGbwNZNeSVUsKYyez7KKv4bDCHfdDRMTa5xiv1J9pjHXT1BHlhJvCkItVPMG
	Us0CqTJzu16gz3Pvs7rmnBHK6Gu+F2TI2LXe4tnH3zSPrNc4cynNZVZUbcmwqwkq4OUTDr2OtZe
	LzwhCT0T+FHvkkBv998ZP5xUjkCbZ+YJbpu4HPiT1M5pTfku96w3M0uJ9+FCiUVKtp/8AVhHQnu
	duy6pIB1lsWFAEPzvA14=
X-Google-Smtp-Source: AGHT+IET6lw3qY9XyvNvb3pybcnRN4nnQ2bci5TeiF0EBvfDGIL/USbY9x3ZkIUotRlW6z+hFZZ7Dw==
X-Received: by 2002:a17:907:72c9:b0:af9:6bfb:58b7 with SMTP id a640c23a62f3a-b07c354e9b4mr721980466b.5.1757821422077;
        Sat, 13 Sep 2025 20:43:42 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07d2870da1sm345137366b.13.2025.09.13.20.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:43:40 -0700 (PDT)
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
Subject: [PATCH RESEND 37/62] init: remove root_mountflags from init/do_mounts.h
Date: Sun, 14 Sep 2025 06:43:35 +0300
Message-ID: <20250914034335.3506706-1-safinaskar@gmail.com>
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

It is already declared in include/linux/kernel.h

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/init/do_mounts.h b/init/do_mounts.h
index 90422fb07c02..e225d594dd06 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -12,8 +12,6 @@
 #include <linux/task_work.h>
 #include <linux/file.h>
 
-extern int root_mountflags;
-
 /* Ensure that async file closing finished to prevent spurious errors. */
 static inline void init_flush_fput(void)
 {
-- 
2.47.2


