Return-Path: <linux-csky+bounces-2321-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ECBB55B70
	for <lists+linux-csky@lfdr.de>; Sat, 13 Sep 2025 02:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53DAC1D6307D
	for <lists+linux-csky@lfdr.de>; Sat, 13 Sep 2025 00:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B85DE136672;
	Sat, 13 Sep 2025 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXC5LHaV"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5562E126C05
	for <linux-csky@vger.kernel.org>; Sat, 13 Sep 2025 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757724531; cv=none; b=Ewg8owZ+R6Z683sNu3EKhXsXFO+x3dBy6OvpaERTzXq0qxOs0BS39+uGj2chnA1Hgxze3qQfVsgS1qAuP+SBnXGDfeCz1FPiVz08ZfWoUEJzuWWFgYyZ5lqVEvKlfRxEqWLQdXSgic3PXDBejDCY0bwIbaVIeBzBjryQ6i/70fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757724531; c=relaxed/simple;
	bh=xKqULWXz/2FiENcJWmfzamYmMIE4imk3W/BtNdWBiQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YGlugMvamI3Jv/uyBmL9HGBvddcQWPjdnBzkJ5Ojer+SIRyYEscQKUYbiHqiCBVU6rGEJ7yYYeuhSxIFHH+t7ESNCtUwTTJbuhr+1+8txsgMIwFIhoSFiOauGgJUFZqoSDX55/Ua6wlobakYWhGWDV0HKmouQJvfr/kkVpxzi7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXC5LHaV; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6188b6f7f15so3005912a12.2
        for <linux-csky@vger.kernel.org>; Fri, 12 Sep 2025 17:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757724526; x=1758329326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AaXPZ8GS+1OiGE0ZCje70+VbQ3y123W+k6t1ILETLlQ=;
        b=LXC5LHaVko3hLgitulh2D+X+9QzDfKDNhew7kFXwh3JBpMXe8S8TiFwp92HLY5PnX/
         nE0PBrgrSYYmvUr7nB60XBcUGWbD3ENdwZDdGEZEpmftZ+HtA+EeeF7PR1uT2dDM52dc
         ZMVq+Hm8pSzt/CvRPR7Me2trqTMPiaCvHkP6+b+IEQvD5eF5k0u5n4FsZ31R41RDQcDQ
         BrBCpUlXV52huKpy2TgomHW9QVs9Ykrr2tU/v4K4dgAQoo0ONvDQb+XsjiZSFbJ2IgvS
         xrCTwIgGWYosdnf/NGyWsk7DdhjDkNLnA/ofhmUV8ldCxH2yGyu11Sj/DxoAM0vBqfC8
         jM3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757724526; x=1758329326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AaXPZ8GS+1OiGE0ZCje70+VbQ3y123W+k6t1ILETLlQ=;
        b=PrRgFTkafemCTL/r0FPWLOZbJuy4xKAMUi2pkLUIj77by6uclScwqey9i8E2zZvmYn
         rRxc//8U9H+subkmx3Ez8Tueim8CUrAF4GNt0JdMa3M0ducFgtU/wrq28AR6vbCUppG7
         xGH/R/pqL0nGfuS/5y/ZQZb6iFf3+LSg77ReopRMWT+DSMpWNYtAj+uVALFEeRYBeRMI
         OCYSiYuLHcfEdDj2VTxh/gFtsz39Qw3DC2Chf6LYIX+A/5lKMiWuZdHito8gt3YXrH8r
         s/IPRs7YK7PHjl2x1dGQDl++WsWiZPV/Qrx231hAsKvRZ83kbdR6YPg+GXTKb0ifNNxK
         iiWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZYsLAzL2EN0uOp8O284ny5OJQ+q+zzuyfkeuAkC+c+RHGM8MsGfiVZXguBRG5Pwy0gL74yXUQ+V1+@vger.kernel.org
X-Gm-Message-State: AOJu0YxL8dcLwcRSO2FoYOtVaJNlr5TeeqFujsLbsQfpTea7hhSO/HZE
	ThRxoFPiK6BaTwHPlqIegss7+LsrqaahyegG7l0Iicx7FI1aBTH7+caj
X-Gm-Gg: ASbGnctZnFqagPhoPEeipOTzGBF+OngGfNNXu/cElwIdbEirO+1wziGHWJUiY74j9RX
	mTpcq5VOMnwZUhd9H+4K25SJXaeMpLlD6skvp2qZbeRIar33UoThUype7sCRQC1Uj1b4WwJJaxP
	VhZzpRCRRtw5kdmTSk4gH6gLv4vk+BX3SN/TRU9BEBR4yt+E/OIYCOcP5qZM8IAqB9yEp1pmtiO
	7lqxCPJY6Prh8yY+JvZIwWbvSRhokiEDBuYLFq+SK/yOKqb26tomIb2xCFjYzj+vfC3FCF/qv9o
	ZqUFcsXXYbuhyOq7iMB1H6HOyKZ3BHD2s1aHpjQM3qgP7cy4XFBWPktv8PQI/aJpPbr8lm5N1Po
	B8ocwe0w+o7pTYpj0+NU=
X-Google-Smtp-Source: AGHT+IG9OWg6vz1Y30fO80tUWulNMPWiUpAt7xVByuYcp52he6rblxs++6dTXTQkGfdvR2czpiOABA==
X-Received: by 2002:a17:907:d88:b0:af9:add3:6bbb with SMTP id a640c23a62f3a-b07c35fb469mr433586666b.29.1757724525627;
        Fri, 12 Sep 2025 17:48:45 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd5bfsm461777466b.63.2025.09.12.17.48.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:48:45 -0700 (PDT)
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
Subject: [PATCH RESEND 08/62] arm: init: remove FLAG_RDLOAD and FLAG_RDPROMPT
Date: Sat, 13 Sep 2025 00:37:47 +0000
Message-ID: <20250913003842.41944-9-safinaskar@gmail.com>
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

They are unused since previous commit

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 Documentation/arch/arm/setup.rst | 4 ++--
 arch/arm/kernel/atags_compat.c   | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/Documentation/arch/arm/setup.rst b/Documentation/arch/arm/setup.rst
index 8e12ef3fb9a7..be77d4b2aac1 100644
--- a/Documentation/arch/arm/setup.rst
+++ b/Documentation/arch/arm/setup.rst
@@ -35,8 +35,8 @@ below:
     =====   ========================
     bit 0   1 = mount root read only
     bit 1   unused
-    bit 2   0 = load ramdisk
-    bit 3   0 = prompt for ramdisk
+    bit 2   unused
+    bit 3   unused
     =====   ========================
 
  rootdev
diff --git a/arch/arm/kernel/atags_compat.c b/arch/arm/kernel/atags_compat.c
index b9747061fa97..8d04edee3066 100644
--- a/arch/arm/kernel/atags_compat.c
+++ b/arch/arm/kernel/atags_compat.c
@@ -44,8 +44,6 @@ struct param_struct {
 	    unsigned long ramdisk_size;		/*  8 */
 	    unsigned long flags;		/* 12 */
 #define FLAG_READONLY	1
-#define FLAG_RDLOAD	4
-#define FLAG_RDPROMPT	8
 	    unsigned long rootdev;		/* 16 */
 	    unsigned long video_num_cols;	/* 20 */
 	    unsigned long video_num_rows;	/* 24 */
-- 
2.47.2


