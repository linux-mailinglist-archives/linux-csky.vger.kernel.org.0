Return-Path: <linux-csky+bounces-675-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E93FD9335EF
	for <lists+linux-csky@lfdr.de>; Wed, 17 Jul 2024 06:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD62D2842E9
	for <lists+linux-csky@lfdr.de>; Wed, 17 Jul 2024 04:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123C86FB6;
	Wed, 17 Jul 2024 04:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EkyTkP8x"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DBB748A
	for <linux-csky@vger.kernel.org>; Wed, 17 Jul 2024 04:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721188951; cv=none; b=orVrcW/MWNF+MMaWumRLlb/pOipPqyYNSRtVoInufsK3pLteAEKaWAkW1MQHW41iMuxyzCRnszEaiwIZr1IIsvbkkpmrAkxNUO/rbW2xpLGbaoJq7vLPcrFUQFYK5KH/BwSZ2R4CdWE9Vozo/Oa/3AIgXQQISbtEV4DNitWenEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721188951; c=relaxed/simple;
	bh=+PBwcB9983LmNCN43zPYuSin1XxQnwumx190TVwsnxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iObQDhPbj/cZhbujFhuKwGAMdLS4Fa4y/YfhcZBlGtCUlP2CBX5OqYpA+Da2lA4UO6cXKPEkLLohcYxDO64tcy53iE+2WRPC+cMsjQMVyh5lnctnqdAYaQGx6rl7fFMGC460PxqoC7F9LlaTc0skyS71ZfT/60LsLZgDrI1Iybs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EkyTkP8x; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a77bf336171so69943066b.1
        for <linux-csky@vger.kernel.org>; Tue, 16 Jul 2024 21:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721188947; x=1721793747; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uFdo7pC51nfSgG7miXqI4efeygQzIA690nn8x/a17Zw=;
        b=EkyTkP8xYeF/gAKH90P71Wb22dtCODRICCIhiC1usITZEh88IXpF8i/XMtQxsEA4SX
         be0poQcJfiz0R4dif9eiP42pj3SEu7JZB3t22yRKPgtZjHC758g4eMu486QTKEkEYsYW
         Aq4WaHNkMqSyFYVQRcnZveCB0fdI+/OM6M0Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721188947; x=1721793747;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uFdo7pC51nfSgG7miXqI4efeygQzIA690nn8x/a17Zw=;
        b=ESDUTyswjqPkBGwKsQMPe8s3NZTAhT6BGe8CNV3mJ94UpQLVCjITC0k8C61TFtzYDc
         UEK8lVrUPYSl13flBqgsnurco6mHi+cazP1ZQDXtyao2KzjxgQZ9QIuwqDnksE1COa5L
         Jn2BYseUYJ2EfTzvifnx0/LQSkSVryIG0XveQyvpCTJWYrDC51gzFySDEZ+yMagQ9oRB
         gOO2BZgp3CqVFdPfN8jXbjq8kJqhubAR+qJ4z8WZuUVsBJZYvfqINilogXc2rNNFIZmC
         tC/LARI8z0QQsyehSr4E90nVYdN3uicOYzHv+LUOilikL71tPL5SvrMt4eHMcDQ0BOpY
         Aw6g==
X-Forwarded-Encrypted: i=1; AJvYcCWFDrDAfxmXIi/IMqN5R8ssdzSp5Y1T1qFf/HnCWni2cERrISGNCB/eiBGa63LQ6RGQOP8f/2nrt/kp7u0ZI0OVYh/QIFmFhlLX2w==
X-Gm-Message-State: AOJu0YyvlkClO0Tb3nPVQyBCDKCdnH8DlfSo+ivbxE1/apN82NqvFFux
	TNQvyIMK+Vd9sJEQYjckOQoUddc2ah53f5t9IG/rKa+vRIHvtyA70rVnXn4h9DsrINLAPsxvW8k
	OOJyEhw==
X-Google-Smtp-Source: AGHT+IFbf941JJcCwl/eBnqmsOjmcSzlqfW2urKtjwVbZSnGg/+XW783zn4XPHE1bjB3jexYMizYBQ==
X-Received: by 2002:a17:906:be9:b0:a77:e152:a8e with SMTP id a640c23a62f3a-a79edcf5211mr362632266b.26.1721188946676;
        Tue, 16 Jul 2024 21:02:26 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1cfbsm394000666b.107.2024.07.16.21.02.22
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 21:02:22 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-58d24201934so698500a12.0
        for <linux-csky@vger.kernel.org>; Tue, 16 Jul 2024 21:02:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUaVWKhXcuUO3xAbWOD8NJCYnfXh0nKJ0vUIiPMK+Ao/ee09ZNVYPJv5duoQcEq1sfvBRc69S5TutjGCL127SEWFDFVhNx5A/ZXTw==
X-Received: by 2002:a50:8ad2:0:b0:57d:4409:4f48 with SMTP id
 4fb4d7f45d1cf-59f0c41dfa9mr3193440a12.15.1721188942100; Tue, 16 Jul 2024
 21:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
In-Reply-To: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 21:02:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
Message-ID: <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.11
To: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, 
	linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Jul 2024 at 14:07, Arnd Bergmann <arnd@arndb.de> wrote:
>
> Most of this is part of my ongoing work to clean up the system call
> tables. In this bit, all of the newer architectures are converted to
> use the machine readable syscall.tbl format instead in place of complex
> macros in include/uapi/asm-generic/unistd.h.

I haven't bisected things, but I think this code is seriously and
utterly broken.

When I do a

    make allmodconfig
    make -j199 > ../makes

on my arm64 machine, it keeps rebuilding pretty much the whole thing
every time - whether I have made any changes or not.

The second time it should be basically a no-op. Sure, a fairly slow
no-op, because 'make' will go through the motions and check all the
dependencies etc, but it shouldn't *build* anything.

But that's not at all what I see. It rebuilds pretty much the whole
tree (not quite everything, but at an estimate it rebuilds the
majority of files).

And the first things I see in the build log is

  SYSHDR  arch/arm64/include/generated/uapi/asm/unistd_64.h
  SYSTBL  arch/arm64/include/generated/asm/syscall_table_32.h
  SYSTBL  arch/arm64/include/generated/asm/syscall_table_64.h
  SYSHDR  arch/arm64/include/generated/asm/unistd_32.h
  SYSHDR  arch/arm64/include/generated/asm/unistd_compat_32.h
  HDRINST usr/include/asm/unistd_64.h
  CC      arch/arm64/kernel/asm-offsets.s
  CALL    scripts/checksyscalls.sh
  ...

which is why I'm suspecting your changes without having actually
bisected the build time regression at all.

And yes, I checked - it does update the timestamps of those four
generated files: unistd_compat_32.h, unistd_32.h, syscall_table_64.h,
and syscall_table_32.h

Every time.

So I'm pretty sure it's on you, even if I didn't do the bisection.

This needs fixing, urgently. Because it turns a "small pull" into
always taking 5+ minutes for me. I didn't notice immediately, because
many of my core pulls I _expect_ to rebuild everything, but...

Btw, I don't see the same effect on x86-64, so this is purely an arm64
issue (well, and presumably any other architecture that uses
'syscall-y').

You might want to do a build like this:

    make allmodconfig
    make

twice, and then do

    find . -newer .config -name '*.h'

to find things where the build has generated header files with new
timestamps despite no changes.

There are other bad cases, but the syscall ones seem to be the ones
that cause problems.

I'm adding Masahiro to the participants, because of some of the other
files that *do* show up for me when I do the above thing:

On x86:
  arch/x86/boot/voffset.h
  arch/x86/boot/zoffset.h
  security/apparmor/net_names.h

On arm64 (ignoring the above and the syscall ones):
  include/generated/vdso-offsets.h

That 'find' also shows that the install headers thing does the same to
the ./usr/include/ directories, but the kernel build doesn't care
about those.

             Linus

