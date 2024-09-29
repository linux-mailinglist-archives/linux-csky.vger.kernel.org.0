Return-Path: <linux-csky+bounces-904-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2629893EC
	for <lists+linux-csky@lfdr.de>; Sun, 29 Sep 2024 11:07:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69FD628568E
	for <lists+linux-csky@lfdr.de>; Sun, 29 Sep 2024 09:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E0E1311B6;
	Sun, 29 Sep 2024 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmitqqRB"
X-Original-To: linux-csky@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B44BE4E
	for <linux-csky@vger.kernel.org>; Sun, 29 Sep 2024 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727600843; cv=none; b=L90cCYixwPjunIxedQo4Ak92zds6swTg7gvLCVF89J0A5ntWfNnYV7VxRYI/7Cf25mztmMBK7dPy9FCukkUVLcKhb6u67sZXEhjQbBKhqnEThSzM0K3rYOMqBkUX0n4V3h/YlDk0m2RzNsD/iXVUjyHKASO7Vx/aaFQV0/HsXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727600843; c=relaxed/simple;
	bh=t9CZZjF6vCoqoLElfF3NcT4MuYAcsVhnZXWUfBKrGxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLBdV7lK6ENgT09icGFdqV/7RHGXbTjl/WARzTLx6G0tEzWjcjY89S0WFDp28oPKUKzTOx8Z8JocmypSX1UssLkysxHxNmTCBV/PSQtfPDoAmrSBygG6koQMxnTdb0xMOfVhyzDL1Y5Rp46a4NdpvcIhRgrbUHF8pA77jQON7j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmitqqRB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9FB5C4CEC5
	for <linux-csky@vger.kernel.org>; Sun, 29 Sep 2024 09:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727600842;
	bh=t9CZZjF6vCoqoLElfF3NcT4MuYAcsVhnZXWUfBKrGxo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KmitqqRBD8n8DUxVG53R8tgNMPL7M6YnRxUPJk/+lKh+vDxC3bZOBaUN0bd1ElNME
	 XsDrrcuaGXahvRwWUQfJMPAyrDdrkIU66n8pI3xfqmiW9KYQE4zXSlTiqypztKqw5M
	 3PLWE5agpR+rkwfA6UlAO3Pi3T/2dqy3Lqa1mzrNtqhW5yfK6/SUXxuFc75Y8WyjoA
	 fslN7hNB65hfS+aKBGnI42oUWiT+hXN7yXBXO1KHXLfUa61Ezi49JYixqWSVSx188L
	 CQM8U19Rvt3LsJ9YYTQ9EjODX7WJyAF/mBjFRdA7quxsh/5ymig31cSQLRaibYZ6v3
	 HfCdapPeTek9A==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c88e45f467so936232a12.1
        for <linux-csky@vger.kernel.org>; Sun, 29 Sep 2024 02:07:22 -0700 (PDT)
X-Gm-Message-State: AOJu0YxBHRCdU7IkSwYhnK8n692Zflv9aJ2P3A7vSxQx+04Y0ylPsn1f
	BagOE+Yon5bsS7jVHeL9qJDt8SSscd4aI8n9g9XzteBlGXCxld7/lAksGt28EFHhK2Y0Y5muEW6
	QfbGyddfrOtXqPuX6Ny2qOhAD4ns=
X-Google-Smtp-Source: AGHT+IENE6ItzWMNVzMZizLlU/u4rS5KV4dUTgDnBZAAydNCEYFbwO3GGVbvEy3UPv89V7SXfLl3j+xV2CYBVsUgDnI=
X-Received: by 2002:a05:6402:1d56:b0:5c5:c444:4e3a with SMTP id
 4fb4d7f45d1cf-5c8823f905bmr10506979a12.0.1727600841453; Sun, 29 Sep 2024
 02:07:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2fa3151f-5aab-406c-95d9-add398ae58b3@t-8ch.de>
In-Reply-To: <2fa3151f-5aab-406c-95d9-add398ae58b3@t-8ch.de>
From: Guo Ren <guoren@kernel.org>
Date: Sun, 29 Sep 2024 17:07:09 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQerCZdTPyUObeWQR89UirG-Xw7cnwZBTKtNpftn0H2aA@mail.gmail.com>
Message-ID: <CAJF2gTQerCZdTPyUObeWQR89UirG-Xw7cnwZBTKtNpftn0H2aA@mail.gmail.com>
Subject: Re: [BUG?] csky: qemu-user: swapped syscall numbers for getppid and rt_sigreturn
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Cc: linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 4:17=E2=80=AFPM Thomas Wei=C3=9Fschuh <thomas@t-8ch=
.de> wrote:
>
> Hi Guo Ren,
>
> it seems the values of __NR_rt_sigreturn and __NR_getppid are swapped
> between csky qemu-user and the kernel.
>
> In qemu-user [0, 1]:
> (With context to show the disconuity)
>
> #define TARGET_NR_rt_sigqueueinfo 138
> --> #define TARGET_NR_rt_sigreturn 173
> #define TARGET_NR_setpriority 140
>
> #define TARGET_NR_getpid 172
> --> #define TARGET_NR_getppid 139
> #define TARGET_NR_getuid 174
>
> The mainline kernel however uses the generic syscall numbers:
>
> #define __NR_rt_sigreturn 139
> #define __NR_getppid 173
>
> Is this intentional? If so, what am I supposed to do about it?
Yes, Linux csky has followed the mainline kernel and abandoned csky's
custom definition of unistd.h. So I think qemu-user should follow
that, too.

>
>
> While we are here:
>
> Is there a known bug about upstream gcc 14.2.0 (and earlier) loosing
> track of registers, especially r4, during optimizations?
> It seems to me that this register gets overwritten sometimes before it
> is meant to be used.
>
>
> Thanks,
> Thomas
>
>
> [0] https://raw.githubusercontent.com/XUANTIE-RV/qemu/refs/heads/xuantie-=
qemu-6.1.0/linux-user/csky/syscall_nr.h
> [1] https://raw.githubusercontent.com/XUANTIE-RV/qemu/refs/heads/xuantie-=
qemu-8.0/linux-user/csky/syscall_nr.h



--=20
Best Regards
 Guo Ren

