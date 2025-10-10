Return-Path: <linux-csky+bounces-2525-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 48500BCB9DD
	for <lists+linux-csky@lfdr.de>; Fri, 10 Oct 2025 06:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 62DA24E3EB9
	for <lists+linux-csky@lfdr.de>; Fri, 10 Oct 2025 04:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FD91DF26E;
	Fri, 10 Oct 2025 04:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDuL5tqL"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8641E0DE8
	for <linux-csky@vger.kernel.org>; Fri, 10 Oct 2025 04:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760069383; cv=none; b=KIoFWFFm68XeaZ2SHw4UgCTeC0bYlymB9D3Dp5dvv8KNiCqEBsrnIKb8Pt+g7wOQNQoa3gAXNbchTt1Ux/roDYc9P0PdhUfjcMUfxH6pn9RY2frAT5j+nz5BmcEZFBOts0QwsRufZ+R5aULhiWdBUKlz6WSAnVVez9jO6uCBZ3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760069383; c=relaxed/simple;
	bh=QekwWSNZM13jRboBgI+VcoYsXugGuoxwasNpiteDkcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CAzb1aUX5x1pklch6k0egCX9K+higcPLyBu9M3v6ERGUAfM6ui/NBLi1o034Yxu8OMDTyyeKUG4tk5J0nYavs+rM0v2lXxbAIKByWAUcugqJ/sL1EyAuW9qSMNG8zWLa2bEkN4k8Jc/6hAMlUuq1Sl2boRnHTlotbmXyEPtMH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nDuL5tqL; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6352c8b683eso1907574d50.2
        for <linux-csky@vger.kernel.org>; Thu, 09 Oct 2025 21:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760069379; x=1760674179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QekwWSNZM13jRboBgI+VcoYsXugGuoxwasNpiteDkcg=;
        b=nDuL5tqLs6F/bqWcdATCSw3q6sR4xH9PojO9qOD+5CVFhCKnIdXYLqb6N9qP3a90AK
         XcWKwh2rGBNpBKIw4DXxov8U2qs0Dzy6gXk8vFfvDusYiZmPGdnri/OyTQj/4/Q9hjBA
         AP9cRpfxElOVTqf47iRfDxq23HPr72skNOU/r2V/uYwO0u5rdlLaDJlfE0FHTHhwxXRY
         CxV+l2MjGbd2BdsN32iKqGDmRkhB4tNQBtMagkevAiwpNidXH4OagDZ/3oHz+Ju9tDVq
         V/7yZAk0s3YGeHhlLGi653f8C0CT7tXpjc3Ab8zbhGaCEogKGwXedDHs/+NW7Be9ThrK
         SjAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760069379; x=1760674179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QekwWSNZM13jRboBgI+VcoYsXugGuoxwasNpiteDkcg=;
        b=O1Pp6dpXzp+bXkfpvHiJM9MSAykeYHGpwMQFjlaS1xnIDz3802x+K/uvvrLcFCw8N2
         WqyW2jACSXd2eT3jC56eNGG7JmQ1DvugRM3UVHrz4O7cJCZ4iD90DiFkwrWGPqY0mZPk
         BmrSSlCQ62jNUqmj3EjZFVnupyKF+o7K1y3IPfPdObSwzobVJJ9UvsB1A/nNk6yMwHAY
         YJ1V5wR0E6K5TzFK1HUWY60Bhe+aQiM7T8LjrkSUklwQM13D/Kv6pOCuZEgFlvY7KR0t
         IzyYclloAC7ogd+qPxmf3KvhopBP8blbiFn0Mi3Rn1DIc4H5CKhSTshYqyCt1740Ljdw
         aNEw==
X-Forwarded-Encrypted: i=1; AJvYcCUibqRjPTK/dc4o5Y9q5Pqw7w+Aq7TXQ19IkFNUx6xmdnMZZ7BeN/v/V1JEQLqLvWEy7CsXCOqMojMu@vger.kernel.org
X-Gm-Message-State: AOJu0YwzGJe4RXR5c0N6lr05/pF+Y2VllDlxN+Y1fSGlMj29WjRPjbnP
	GLQubPbB2sgPf5650A/l42R2VmILTuJO0ju2o9TYMspmUsDfX6tAYjcSN8ZM3JzuMqtnr7+lV8W
	NnKXl9gqdmtw4t0/S++08lVjlsARexbc=
X-Gm-Gg: ASbGncsHK6pZQIILWOnFofyaDikD+SDRTz5Ob1qlZOh53zNrmVXLgvD2Anmjoqb+99u
	BHrEf0njAPb17+QldKW73qA2VnBT57F7IZ/DZHubfy5qcgj30UthMugoI+OojuuDyzFaG2Hwt70
	Fh0h3uczXuKbJnj863LnhO+rHq9u0EVro7vwBR25a37Hb5tnRKXDbeq8Y6JeRkk+92GDlRT4u/a
	UfFdVh+qItbughstv8zw7pr41y9EsYsUJLm
X-Google-Smtp-Source: AGHT+IEKzDZJ3mg1FFWOqowFJqWLj/+dmJPdM199pmmtVcavFH/YLuoH0hEdsvn7dHSOiTNw/3Aomiv0DcOjJivXzrY=
X-Received: by 2002:a53:e946:0:b0:636:17d6:a30 with SMTP id
 956f58d0204a3-63ccb82410bmr7618496d50.15.1760069378763; Thu, 09 Oct 2025
 21:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <A08066E1-A57E-4980-B15A-8FB00AC747CC@jrtc27.com>
In-Reply-To: <A08066E1-A57E-4980-B15A-8FB00AC747CC@jrtc27.com>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 07:09:02 +0300
X-Gm-Features: AS18NWDxe32nrD4BfQQFhIe3tEEfxrwgJsYQo_BWhSUPsy5CceSv7QOcZ20roI0
Message-ID: <CAPnZJGAKmgySY_RK0kmGTgwUh9hw4FSrVR+LoJCbD_RmJZe6RA@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 8:08=E2=80=AFPM Jessica Clarke <jrtc27@jrtc27.com> =
wrote:
> I strongly suggest picking different names given __builtin_foo is the
> naming scheme used for GNU C builtins/intrinsics. I leave you and
> others to bikeshed that one.

Thank you! I will fix this.

--=20
Askar Safin

