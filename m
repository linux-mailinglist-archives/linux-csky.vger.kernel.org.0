Return-Path: <linux-csky+bounces-2508-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDD3B9AD8E
	for <lists+linux-csky@lfdr.de>; Wed, 24 Sep 2025 18:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BDFE19C3A0D
	for <lists+linux-csky@lfdr.de>; Wed, 24 Sep 2025 16:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD89313E30;
	Wed, 24 Sep 2025 16:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJ9fR/G/"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC91F31353A
	for <linux-csky@vger.kernel.org>; Wed, 24 Sep 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730690; cv=none; b=a8ze6onqPgA+RbBeiKOTn0RvxYt0nKK0P9cMSe9PEyJDYU8CQQ+75mlgL2m8BiwNjBzIg+9rhmDbwEXByt52ZUQJKwukq7o5jsrEyZg2SDocRQIXWSQTUxwQvnNSOKxoVbqiMxOx5vrqz1fomvtPpFWbUqxKifllY6jtL9Gj3Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730690; c=relaxed/simple;
	bh=+elp/mgEwQHUPO2/veHl6cFeD7QMzkxV3mT27B/vMe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VYpCZTZfLbD8sLOXzm8Uo1iJVWNSMKWqvXEk/VXJCCPDOLJsbizriBZ+36FJJM9EVZYLz9h0DET3B2nm4s49z+V48o3toYI09efpDYFvkwGFo/tqWGuUBbHWe6/veUMkTqyFJyomoRJ6yq9l+tcnkFcoaraPUnt86ID9CnvXyy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJ9fR/G/; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4ce9b5de951so70861cf.2
        for <linux-csky@vger.kernel.org>; Wed, 24 Sep 2025 09:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758730685; x=1759335485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+elp/mgEwQHUPO2/veHl6cFeD7QMzkxV3mT27B/vMe0=;
        b=jJ9fR/G/uQOoGU1zjzeq+kEGJH0FGPF6hyv+BRd11txZaP6jykJx7KYV+Fy89/hm3r
         Fj1jHTTr1k3gSZ9YbnsYf7t/+Y1cgcUQRaozim9bYqDxSSoV25zr5djoCo2k+XVY+9XH
         hZwrqWm/lkHBVgotX1/VMNfSLp5gX19VCA2QcSKMUDXlmxsoFrDA/aUnalMiOUk6S4Dm
         ApxpBGputpqRfa7MY3pOnEuQUef0R7OKBgerb0vkMv3dzWiW0+dXhhizmvnjoU/shLfI
         pMehbr68Tb60E0EQMTVNp25KF0WY4uOSvx5h0SUZ0kqikDM0hjKYe9piKoNpkOCmD6s4
         fVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758730685; x=1759335485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+elp/mgEwQHUPO2/veHl6cFeD7QMzkxV3mT27B/vMe0=;
        b=WE2gG9uirVM5ctEmPGoSswmfj+79DsNW1UUlbIYd49mZHrdaBOgXAG5Rt2TyyA7rCi
         DF00Hc0dYu+tDi6BPjoxC0vkx+UIMjwpd5+IKZ6nM10lBYgdjTG1AVT3G/Ws7kvW+cE2
         Cpn6Dpkp2OtVZdcYdBnpM+hgNIQBWix8znTJKuJufRN2Bw4nd4fxhOIOxbC/rR2vHKkm
         MRQFXy09668sfOFddyEvJyK8eS+XEjQcPJVKTlWmIan5xQV28SepuTn0BMxjzm9lBR/B
         MvYHbUQjDtdRO/d9G3xtcOhUDN+YxFod9ZIW0AZj+j0dDVIo+NOvsqa1EI/GEsjzBwwQ
         hQ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXs9YUhOpLwoLJm+yrW0LL8hXKsb7VDkspKpsqXvRAdGeKGi8JwUA6D1meY1XTDFTfdmKmddu6/pDga@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu3PZnj+hACaVS8lBn9h0MVO1QgtJClXW6tivBJd+a+z1kCPFJ
	tSzanPwKX13c6KQJMeY05TdtunRlmoHB52aysJ35q8rCvq2FL2VWqidyVAmjkxYAa/hNCu7f0bv
	wW8ZlFgf6Th2BxZZlKCvKyXZ2/UFe5as=
X-Gm-Gg: ASbGncu+zjibAatyv4CiPqyusecrIryBY4/Q5iBaXyix6r3lbXIURKbPENm0BsE02+F
	ybFygXkg8A6EglYKzUxn1d9muuvvRvhIiBP/2Y0cGBUlnVJ+ILyp5u2P15ONoZOvkT+YPJ3lvNe
	fvxYkDNzX21WIkyDPDYdJBGvikNlz6gGTpEt1zG0p/o3W3eg2WSRm7KCutkbe7jjn8PPLga7Iqu
	wiu22NemQss/KGajmTjQUlHjxkfWs49IymB2ipz
X-Google-Smtp-Source: AGHT+IHrjx0XfB3NQHdqBt66Ox1dwY4oj3I0wMxztSwqqFAAkQnhEkK0QBLdnresO+RuCvDJitimjmBRn2YZHsgZxpk=
X-Received: by 2002:a05:622a:3d2:b0:4d9:ea03:74f8 with SMTP id
 d75a77b69052e-4da473535b8mr6186491cf.16.1758730685377; Wed, 24 Sep 2025
 09:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <ffbf1a04-047d-4787-ac1e-f5362e1ca600@csgroup.eu>
In-Reply-To: <ffbf1a04-047d-4787-ac1e-f5362e1ca600@csgroup.eu>
From: Alexander Patrakov <patrakov@gmail.com>
Date: Thu, 25 Sep 2025 00:17:39 +0800
X-Gm-Features: AS18NWB-xeGoRDKYPj3kUYXUnKXLhFMFvvc0QyoLpOeKcP1DsD-enKeBhlulfsI
Message-ID: <CAN_LGv3Opj9RW0atfXODy-Epn++5mt_DLEi-ewxR9Me5x46Bkg@mail.gmail.com>
Subject: Re: [PATCH RESEND 00/62] initrd: remove classic initrd support
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Askar Safin <safinaskar@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, 
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

On Tue, Sep 23, 2025 at 8:22=E2=80=AFPM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
>
>
> Le 13/09/2025 =C3=A0 02:37, Askar Safin a =C3=A9crit :
> > [Vous ne recevez pas souvent de courriers de safinaskar@gmail.com. D=C3=
=A9couvrez pourquoi ceci est important =C3=A0 https://aka.ms/LearnAboutSend=
erIdentification ]
> >
> > Intro
> > =3D=3D=3D=3D
> > This patchset removes classic initrd (initial RAM disk) support,
> > which was deprecated in 2020.
> > Initramfs still stays, and RAM disk itself (brd) still stays, too.
> > init/do_mounts* and init/*initramfs* are listed in VFS entry in
> > MAINTAINERS, so I think this patchset should go through VFS tree.
> > This patchset touchs every subdirectory in arch/, so I tested it
> > on 8 (!!!) archs in Qemu (see details below).
> > Warning: this patchset renames CONFIG_BLK_DEV_INITRD (!!!) to CONFIG_IN=
ITRAMFS
> > and CONFIG_RD_* to CONFIG_INITRAMFS_DECOMPRESS_* (for example,
> > CONFIG_RD_GZIP to CONFIG_INITRAMFS_DECOMPRESS_GZIP).
> > If you still use initrd, see below for workaround.
>
> Apologise if my question looks stupid, but I'm using QEMU for various
> tests, and the way QEMU is started is something like:
>
> qemu-system-ppc -kernel ./vmlinux -cpu g4 -M mac99 -initrd
> ./qemu/rootfs.cpio.gz
>
> I was therefore expecting (and fearing) it to fail with your series
> applied, but surprisingly it still works.
>
> Therefore is it really initrd you are removing or just some corner case
> ? If it is really initrd, then how does QEMU still work with that
> -initrd parameter ?

The QEMU -initrd parameter is a misnomer. It can be used to pass an
initrd or an initramfs, and the kernel automatically figures out what
it is. What you are passing is an initramfs (a gzipped cpio archive
with all the files), which is a modern and supported use case.

--=20
Alexander Patrakov

