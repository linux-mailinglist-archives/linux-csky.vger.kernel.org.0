Return-Path: <linux-csky+bounces-2439-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB10B59EEA
	for <lists+linux-csky@lfdr.de>; Tue, 16 Sep 2025 19:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6D33AFD63
	for <lists+linux-csky@lfdr.de>; Tue, 16 Sep 2025 17:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6817F2C11F0;
	Tue, 16 Sep 2025 17:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="D5eLwBoj"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A202B2FFFB2
	for <linux-csky@vger.kernel.org>; Tue, 16 Sep 2025 17:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758042517; cv=none; b=fqh4S7XSvXNFNpyN8k/H31vaEJtRBySvyz1exlJWbK3n+KbkuccQHkSbvIk8NZdQQ5O2Pz+jlNwsdtY2tvMe/Ev986N+qF0gKA4DtPbVYQ6gGKZB9iWcIVNZSiItWoCcqUtUKgjMwnCtx01PSUHG279pHkxoO/evzF4mdOhYH2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758042517; c=relaxed/simple;
	bh=PgWcajlgRtwCN1aidp/F0FGsvN0V9p5zYN3VYaOBF0E=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=m0lC1negfjyA49j6X5cWNuerjQ0TU9Viquh3+NXwxb/xnCLUxqK+904qvjIpIbZn89kJS8B79uIyppkza6pzrxmEl5jYTcrMxpITLkw7KTrcQgWV4F4aGzW4MEkEz5kqawiRD+fN0fRh05HFgzz884sRzFnEte6q1YgDGv+Enww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com; spf=pass smtp.mailfrom=jrtc27.com; dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b=D5eLwBoj; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrtc27.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jrtc27.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3eb0a50a4c3so1644922f8f.1
        for <linux-csky@vger.kernel.org>; Tue, 16 Sep 2025 10:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user; t=1758042511; x=1758647311; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIXyc3Fa0oN4a5i/p3ClDZo8xo9GAZJtSKI5SCU0zd8=;
        b=D5eLwBojfdlh7Q0cfd/t8ODFkczYAE4ccdja3rz4S2mZAneyp4d5nkKj2+q5ACqPOi
         /yjKRgjGDtlthxxMjKg+S4dh4NoTe7TQtaOGt7C2xJuzHcDvWXbiFQeZFEXRTYRGEndM
         SX9Sw6J/VXNagS+CitUGczdEzmFWRDpey8ygRCmBQMHIQu7GPnjJmsiuzxJ439/U8JmR
         298j/N4p67b/yaMJKJJ+VWXOpv1hUZ105IAdTcUXwsdDkApa+SUIZ/41vDVTSl2x9Wl3
         IQdtpGO7ZGksW/E0kcCSXvs8GiZJOFfXHXP3NBDLRPnYeH08tG9upiLt0dMHZhfnli7C
         h58Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758042511; x=1758647311;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIXyc3Fa0oN4a5i/p3ClDZo8xo9GAZJtSKI5SCU0zd8=;
        b=MIyfuCcn22vEFiNsKaRsztKUNo7x8n4ywE9Dalc4jO4Njdv57F+lxXskZafkuv8TVk
         ZNVqcO+9Wx+55+IaFhyCSoegkA1D+/ll+Of4ZAvyUY1+cC80kmpXdEth1l86w9dtfXUy
         n4aW455qRtCDbLUP0QlPmSitWYCG4pIC7rf4Ia8byfitRKl33igjhfZy/wqIXsH5mhvA
         9FCy89WdvZOK03RRAxYrg2JG5GUxQdUv9V9GbKUzaN1JW2jT0+9uzwRn24qFg0pS6tid
         1wIGBOVEc9QhzhvfzyUUWOCBo85QnR3e1FmwQ/3jNPlFss7ZwUYWtpnEkd59Cj9hvxlu
         dcWw==
X-Forwarded-Encrypted: i=1; AJvYcCWFv8MxqBJFS8t7xHy12cEyxNxrKHy4tj+pvRKgQommUi6bK1albgklFoHZEy/pWMHBZ23fvE0lV6qq@vger.kernel.org
X-Gm-Message-State: AOJu0YyOR6sbZpkh0mB7altTJ6TYZemrKz0OBm9T6svl4mMMgsdCSOjx
	cMcpO3uS2uDYof0PEt9a9L/rZ/6I5TEO7L19De4p3mbCd3Z3dxQ69pmvHsvFBfrRAwU=
X-Gm-Gg: ASbGncudjgFig7H26v1eur+kAn4af+aOFh32QBX1fq+0MEO7aciuJt8YvimEZmHHWfw
	/PAf8dUosaYnA3ZnLk0eGYSptZIcvmNQp7x1Z6uUamDTyaUuVqGD18vZa+H4g/FF6zJ1p7n+0NQ
	hlFjTWul6uE964x8NXcavKko9gigF14rab7nxpIcO2fJPJ9hQmQsc6NYJPWjYGgBOBNC0zXzLdd
	TZkt9EaBPAOvBKl6wz62IyiQ57u3/d0GYzRCoq+muIeLgmhl55R2mp9bgthPb2bXow+i8FHZLRW
	pR2GVv4Ye/O+gEOIW0f0EYyoJqkigAlXih0wBN4Pmm1dh7k3GAuFqzTtZ75P5GYNX55PAjY4iZw
	1d691eltvQMbeId6qJiDGBishvMK7IbwwnhaJNs5zaGzI9mBXNcNSiFkR1g==
X-Google-Smtp-Source: AGHT+IGdFovreVsG0VTuKKVTgWJJEqEKFnO21Mo+tI9uoQq7jJrFi/9vVCfXuUmfB6QhCbWUaAaAkg==
X-Received: by 2002:a05:6000:2dca:b0:3eb:2437:97c5 with SMTP id ffacd0b85a97d-3eb24379a13mr7083124f8f.22.1758042510664;
        Tue, 16 Sep 2025 10:08:30 -0700 (PDT)
Received: from smtpclient.apple (nat-184-7.net.cam.ac.uk. [131.111.184.7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd0a7sm22520843f8f.39.2025.09.16.10.08.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Sep 2025 10:08:30 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
Date: Tue, 16 Sep 2025 18:08:18 +0100
Cc: linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Brauner <brauner@kernel.org>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Aleksa Sarai <cyphar@cyphar.com>,
 =?utf-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
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
Content-Transfer-Encoding: 7bit
Message-Id: <A08066E1-A57E-4980-B15A-8FB00AC747CC@jrtc27.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
To: Askar Safin <safinaskar@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)

On 13 Sep 2025, at 01:37, Askar Safin <safinaskar@gmail.com> wrote:
> [...]
> For example, I renamed the following global variables:
> 
> __initramfs_start
> __initramfs_size
> [...]
> 
> to:
> 
> __builtin_initramfs_start
> __builtin_initramfs_size

I strongly suggest picking different names given __builtin_foo is the
naming scheme used for GNU C builtins/intrinsics. I leave you and
others to bikeshed that one.

Jessica


