Return-Path: <linux-csky+bounces-1955-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A383A62E81
	for <lists+linux-csky@lfdr.de>; Sat, 15 Mar 2025 15:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF55A16B3FF
	for <lists+linux-csky@lfdr.de>; Sat, 15 Mar 2025 14:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD69202F92;
	Sat, 15 Mar 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmSjBQ9i"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA82D1FC7CF
	for <linux-csky@vger.kernel.org>; Sat, 15 Mar 2025 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742050545; cv=none; b=AKXrsX7+xifd5rpqPgQCmlIn3SvLAYy7dM2qldNCdde+IV0pju6MObvblNaOGs4Wf2XGQ02yuwgd3GcssFZfdKcWMWY369to2vy9bUG2AvkShxSFSwdmiwKsK5T4ZwR41O0s7hGTaM9gAf+26HwSrQvKNIBpT//kHIKmmKDxoPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742050545; c=relaxed/simple;
	bh=XA99tfLBp8bXT73QYWUaMhUBMUYYGtyNQMBwQmFvmFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=aK6J8SL0vjQXG2E/2aLL0s6rWlMOxXFj5IeOu8aVYjYCUvqsFZyDOIqDGbAZpPXRkh6qvZFktxp5rih3fBGZgdJp8F6qejdu34XMI2eFAzzbUa/f2ZoSVohZotc2iiYTCept0Nfozuu1Q/ZV9oQmFSMLODX0KdR4e30VvK1cWNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PmSjBQ9i; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225b5448519so55307545ad.0
        for <linux-csky@vger.kernel.org>; Sat, 15 Mar 2025 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742050543; x=1742655343; darn=vger.kernel.org;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XA99tfLBp8bXT73QYWUaMhUBMUYYGtyNQMBwQmFvmFg=;
        b=PmSjBQ9iXnLJUW2idUj4k2rryQQVbg/u4JfQq9Z7sOLQAWkwBeOXLDdObkRKX/YwA5
         VZKXGNshnwN3FzHVih5sE5LsjfahwEYo8mTxY+LFfphTknebNzB/lfuO8AgeHLHwztzw
         hsQclR4CmM2Swg9TQqh+7yBxVTAaMFPsWwwstd/omtTWD9gRwkFkiw3zLoYoHumY5V1+
         OGK3MYKiA74blXWHYoH8LmYf767Z13BBpm0aBv2/F0xio5h/xsfr2n+3+iVpbq4gm1iX
         bEVfjWwVFbRAM9csDsJGmDcIdCcvalQvxWekpf6eq4XRcvLFvrtmew58O7LnVVFdwxXC
         yFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742050543; x=1742655343;
        h=cc:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XA99tfLBp8bXT73QYWUaMhUBMUYYGtyNQMBwQmFvmFg=;
        b=dc4P9TUOHUlcRllEIUfQe5enTFG/RwrnvKvhQVor0xLL5DO1KoSGHIFI5QiFsRQYB+
         nbspQRsuHw1IPz3x6ufGh89JovNEV60LL9Daie85GTFWUFtCn8utBs9srwQMW11evtrL
         3lBigjWBKaVoTmL28VVAl3igLsqXAJB9wXfgDsRFN4SlOteyLNQ7/l7Zi3TO9DlTBEFL
         5QfAri/DlTyVyVWJq/5itsD7+zhTJpyBW2TjSqRBXe0kxbKRutBxd9Dm7rOewDzjtVjm
         +/WH/jAWczCz4iwKDJkKRFEO+Mix04C7ELEOlrbh+HUcXlTHKHdlvQTAQJPy1snc8JAK
         kYiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdQUKECrCADAqlCjHdLNY0X3tsY5xJWCDwCV7V3xzV6vFBzavsOZG/FBVPbu2swuj+Cmp8KL1b62cm@vger.kernel.org
X-Gm-Message-State: AOJu0YzMDSWe7cQjSDsxEDkhqZxLaoZvKffH3sBKX8ZipL2zvxnGTp/p
	23Sv3JKvvOUXM3xeWc6+qBPFDeD8idXOBezWB6R5avTh4i/7Kvnt6MdlRIOlgpa72WpifwPVjJc
	4P2rEkwTTk/KHthA3afJaG0qI2K0=
X-Gm-Gg: ASbGnctT4q3KL4o3uug2uriXf9JjZUlwIAHx7vGCn8buB9LfzXX+Yyb3lFdBf2UYfVw
	BITcwYJRSP91SWQA8H7tDHPS8YuhPNkzi9eoWjnIzYbwPJouXP9aGgdGopeWDZnYsjvtE5Gp8Jy
	AankXScIi5ELiRahoTv+Iyo5A=
X-Received: by 2002:a17:90b:2e44:b0:2f9:d9fe:e72e with SMTP id
 98e67ed59e1d1-30151cc2490mt7920209a91.16.1742050543260; Sat, 15 Mar 2025
 07:55:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306185124.3147510-1-rppt@kernel.org> <20250306185124.3147510-11-rppt@kernel.org>
 <cee346ec-5fa5-4d0b-987b-413ee585dbaa@sirena.org.uk> <Z9CyRHewqfZlmgIo@shell.armlinux.org.uk>
 <Z9ErEBuMMvd6i2n9@kernel.org>
In-Reply-To: <Z9ErEBuMMvd6i2n9@kernel.org>
From: DiTBho Down in The Bunny hole <downinthebunnyhole@gmail.com>
Date: Sat, 15 Mar 2025 15:55:33 +0100
X-Gm-Features: AQ5f1Jrmv7KQRCuWBIo_vXTI9aIDRsZr_EQ5uQHAURWeudjXpiSlHPWiANvw4jg
Message-ID: <CAAZ8i80e6CsD1Y36-sVrVs4QPB-82J1gPOeDvHa_+sQtfUpMtQ@mail.gmail.com>
Subject: Soekris crypto 1411, where to find ?
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc <linux-parisc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

hi
this is probably not the right place to ask, but I've been searching
eBay and similar places for 2 years and haven't found one yet.
I support older MIPS hardware and need to find a Soekris crypto 1411
miniPCI module or two, to add VPN acceleration.

Anyone have an idea where to buy it?

Soekris company went out of business years ago.

Let me know.
D.

