Return-Path: <linux-csky+bounces-720-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3419958F96
	for <lists+linux-csky@lfdr.de>; Tue, 20 Aug 2024 23:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04FB2B210E0
	for <lists+linux-csky@lfdr.de>; Tue, 20 Aug 2024 21:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14161BA87C;
	Tue, 20 Aug 2024 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="w/G3QBvK"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D414C5A3
	for <linux-csky@vger.kernel.org>; Tue, 20 Aug 2024 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724188639; cv=none; b=o0hNPGlku7Edcpcfn468+Q1deTz0XILt+iIMSmkbPuLB01ynGf890HT8uAfL7G13Dx+eWLnsxVGTlGFxrdlVQi1cEem/J0NCxChL0CGMBKemTTlyKvYqnx+pvwJ5k8KZFdufcFUi3HApT8+cz9WQZxTuso5Rw8jIpilKFMtzNE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724188639; c=relaxed/simple;
	bh=mOUCcvaI+h5g3H3w3+SiuGlOuZAvb4zAmyyA5RojPzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KVpwmAX3YDVdYQdo2PiNlezYOHi9quaKhJUQc9EYbd5R9T9bx2KfxPseBx2WuaZlkHI9r50GPn0EWDkrIpQRvLkrO9OQ0VS+DPuViLYh3m0kR2X7ejRFZv7CZzR3h3/fwsz2DSSYrfaXOyckUYEWK68wocFYdOOGOtgJuKb6EyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=none smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b=w/G3QBvK; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-690aabe2600so50082577b3.0
        for <linux-csky@vger.kernel.org>; Tue, 20 Aug 2024 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1724188637; x=1724793437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GOcODjceGC7ZkW4fB/YT/SWFmfr0YR2DkMYRyu0vLoM=;
        b=w/G3QBvKbQBEO/K594bJQEnljtGmmlR8E32evTV/Dk6fweGKTSaUZ9R4C+Y3PQlBr5
         OwZRRiOLZV82Gbw+FOF4hhHn3Y7V/wXXY2X62mnXyCs1TPXksISmUFOPEOv302CBFj1U
         BAE5O9bo7NLYasnrFtOPGvo+dIT6NEodZp0UeXjGDpDK9lW3UNua8h+uOYPs7t8kW3Gd
         2ggkXdgK/XaGlRAE0fOP6Rzl8QJuXJuwg8Brk61y40MqqgNGKOzljB0wl42wmVZ1r0EK
         sPJa2bskzVdtloQJdCS5nlRw3wy20GSRe1GpdqvhozhkPPPKiS8um8c2JSjbNyGwGdtQ
         SrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724188637; x=1724793437;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GOcODjceGC7ZkW4fB/YT/SWFmfr0YR2DkMYRyu0vLoM=;
        b=RIvN5reclpzO/BfyoCSSXWR6gt2ERIGd5pgZ3W8e9HtiGkouPE2r9nROCK7ivTpHVA
         W1j4SFsqsJmE7GH1SE9Upu6p0+wGPGRl08+JhjZk3tFBFy9B8HvJbPDX96+P62OnvN/K
         XZ4KnMqhY4+WQlmiOzwJgQcY6oKvr9sWtW1VXYzW/b6yFCOKHvo6Rm66qFX93ZPlqYzn
         TadgiMEBz+0WldPU2udSHI6Qhft3n765pAso1Li/ER8lh/plO3kVv7Gi5uO2VnluJip9
         7VM3drgSDNSKlKBzeBoDt7LLFIXTJVsSwY4Dhtp6M2smb7BMbUfN36SiMynOWoxXnWbF
         +2Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWC1GanVJ5bK12aTO1CshRDtIvU7NooYpfambrG1b2kE3OuqMqlpZQE1WF3Z42Y7po2+xtUmJbmscM1@vger.kernel.org
X-Gm-Message-State: AOJu0YwDty8EDgkroZSuKcxNJgOInhdIKNCfeSjUhsHxZAj9VVs7n1+f
	/C37/eoRyLwcaIpf3BmFX196pJpI77wkzZYl8DEpAsPXOlRMvozRU3rCMrzd5rU=
X-Google-Smtp-Source: AGHT+IH694ptJUT+W4npveoCOkWoEd/Bd4Fd/tTcyPr4LbEtrypfJeZqkWp1OWOohPWwkgyUxuRYrg==
X-Received: by 2002:a05:690c:6591:b0:6ad:ba92:1731 with SMTP id 00721157ae682-6c0a0ae8507mr6885217b3.41.1724188637088;
        Tue, 20 Aug 2024 14:17:17 -0700 (PDT)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a66f388703sm62392285a.25.2024.08.20.14.17.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:17:16 -0700 (PDT)
Message-ID: <dff57198-7955-ec09-8909-671982834673@landley.net>
Date: Tue, 20 Aug 2024 16:31:13 -0500
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com,
 pedro.falcato@gmail.com, linux-um@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
 <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X>
 <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
 <87y14rso9o.fsf@mail.lhotse>
 <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 10:31, Linus Torvalds wrote:
> On Mon, 19 Aug 2024 at 23:26, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> > +static struct vm_special_mapping vdso_mapping = {
>> > +     .name = "[vdso]",
>> > +     .pages = syscall_pages;
>>                               ^
>>                               should be ,
> 
> Ack. Changed here locally.

Hexagon also has &&vdso_page which I don't understand (but have a toolchain for
somewhere to at least smoketest...)

> But I assume you also don't actually test sh...

But I do.

Aside: arch/sh smoketests easily under qemu, here's a relocatable binary toolchain:

  wget https://landley.net/bin/toolchains/latest/sh4-linux-musl-cross.tar.xz
  tar xvf sh4-linux-musl-cross-tar.xz
  CROSS_COMPILE=$PWD/sh4-linux-musl-cross/bin/sh4-linux-musl-

And https://landley.net/bin/mkroot/latest/sh4.tgz is a tiny qemu-system-sh4
system with kernel + initramfs.cpio.gz + run-qemu.sh with the config used to
build it under docs/ and as the first three lines of docs/linux-miniconfig
record, the kernel is arch/sh/boot/zImage.

You can keep the initramfs.cpio.gz and run-qemu.sh and swap out the kernel for a
quick boot to shell prompt under qemu. Serial console is qemu's stdin/stdout,
"exit" to shut down the emulator.

The build script, if you care, is 400 lines of bash:

  https://github.com/landley/toybox/blob/master/mkroot/mkroot.sh

> It would be good to get acks from the architectures that still used
> the legacy interface.

I'll give arch/sh a whirl. Can somebody answer my above hexagon question?

>               Linus

Rob

