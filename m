Return-Path: <linux-csky+bounces-678-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F45C933644
	for <lists+linux-csky@lfdr.de>; Wed, 17 Jul 2024 07:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1933B20C2C
	for <lists+linux-csky@lfdr.de>; Wed, 17 Jul 2024 05:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F1DD304;
	Wed, 17 Jul 2024 05:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KwGAkvSz"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408BBA45
	for <linux-csky@vger.kernel.org>; Wed, 17 Jul 2024 05:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721192918; cv=none; b=Hp1LhO1Cq3Dt9fGNLZuovx2729wcAcacp0vR2QaHripJrkddFuODIeaqAi3l3duCdis684G715H+uWtF09VQdeq/v+sx0WPm7WF4tNyO3MjI93v0Ij0WsBbB2XAvQiLF1j5/yJ7tBY4LZhwyq3rhpbPSA0FU4lFBIacbcImsPrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721192918; c=relaxed/simple;
	bh=456vFjdQgX8t+DKO4cXNe0nbngfpEhmfIZpf1Fy7zRU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tu1TS4MVtK5h541+OV0BaPrCKbifk9ALUnC6Mp7oxpC/c7q2w7PBm2aFX1z6jgTnruAENA4gZB1RW4jNL68NLiFqC54h24L1vTjvid54DyV5CmALTeVvxel9N0KqUMG9KDzv+CJ+EoI+a7Ja27Y4LhfcqtM4UTcM5fZoNedPqjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KwGAkvSz; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-52eafa1717bso6430607e87.2
        for <linux-csky@vger.kernel.org>; Tue, 16 Jul 2024 22:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721192914; x=1721797714; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ylupikJo36krvlGvfFYUWfmmy7QZTRdDT6qxa+A7N0M=;
        b=KwGAkvSzI3nMfUR/yLeMrhnZU0Q+8oDnMp3St5LbPJgvi8QQWsYjxFMVcgiCKm8xxu
         dpwpOd+Ij5sw7XnA/KsGjM1NWOWK8SBe6bvcEJbPq2P7sXVRKg5HsY0mXcZVvmDbL7M7
         XcJLb0bj7NZTio7h26FJ0JFqqs+qlIH0ZVG0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721192914; x=1721797714;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ylupikJo36krvlGvfFYUWfmmy7QZTRdDT6qxa+A7N0M=;
        b=C4AZA+9vGkxZ7lf8HQPHBCreEBMN8IQXPhLANwHHksC/pV3e0Ajh1TpG7piLhBYIL2
         fKFOenh2o1Po0HRygyBjDMlC+O3XcANAPUDWquNSA2xX48+LTPHMzOl2DuFbFcZ95XDT
         JRhLZe90y4zYd/wtx3/oR3fLznAfSaQclZ0jBp8hs77v6QMQ2HYjBbfbCC04X5EyXrzm
         GF1FeOzbziGuRDoJ+vmjG26pg6OWUhXwH+BAZCT4B1JHjwyOJbpH4Io3sVyxVrsP8PtG
         nPpUxsyROlj7z7Hka3zLMH/RFXv7NLIxEME5zmZchzE7TSmc61Vz49YXTF7E/g11sUkq
         p1QQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmXTCPW16CrVpj1phWAgzSUSEUKFhAYZLBZ1LOAO4efnQ/opNe2e7Bwa7KIRGF4SUBJ5kyeNkvmwiQwQQ0Ej5RBxwQGDAhEFxAfg==
X-Gm-Message-State: AOJu0YwcJU4hjO6J6vuxmo9Z2FJvOC9e+dUIokVXTcDf7Yg3g0Ua473T
	rD2FVx7QTD7p4ZnyVFeS41uGwwyyjh7LqshvqXDny/iVb83uT53WhX+fcQldfmbeooOzAA7KfKt
	PeuQXfg==
X-Google-Smtp-Source: AGHT+IFM4ZdJWcYNQg2ZPcLuY4vZE8ox/16mM1yKMN9X+iJyOWJOZNhtKYaDdZyhZuMsP9QAceShEg==
X-Received: by 2002:a05:6512:281d:b0:52e:987f:cfe4 with SMTP id 2adb3069b0e04-52ee53d6898mr324900e87.30.1721192914496;
        Tue, 16 Jul 2024 22:08:34 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ed24f3c5dsm1327726e87.106.2024.07.16.22.08.33
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 22:08:33 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2eeb1051360so58579091fa.0
        for <linux-csky@vger.kernel.org>; Tue, 16 Jul 2024 22:08:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfi0VSU4UcrL/NSpwLC3EDqRHpCzM0pHpEI/SJJSR+XJ73TxFrlRoYuFdO2QDQlXkqVw6zAsxL5uk4IlIl03pJVS+waOnU+QbOxg==
X-Received: by 2002:a2e:3a1a:0:b0:2ec:5f6e:65ea with SMTP id
 38308e7fff4ca-2eefd1bf195mr3375661fa.38.1721192913022; Tue, 16 Jul 2024
 22:08:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com>
 <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com> <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
In-Reply-To: <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 22:08:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
Message-ID: <CAHk-=wjqr_ahprUjddSBdQfSXUtg3Y2dCxHre=-Wa4VGdi7wuw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.11
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:57, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Note, it really might be just 'allmodconfig'. We've had things that
> depend on config entries in the past, eg the whole
> CONFIG_HEADERS_INSTALL etc could affect things.

Oh, and my "find" line was bogus, because it turns out ".config"
itself is only updated if it changed, which explains my confusion
about some of the other header files.

So it turns out that to get the real list of rewritten headers, you
need to do something like

    make allmodconfig
    touch .config
    make

and then to make it faster, you just  ^C after five seconds, and do that

    find . -newer .config -name '*.h'

and _now_ it's meaningful, and on arm64 I see

  ./arch/arm64/include/generated/uapi/asm/unistd_64.h
  ./arch/arm64/include/generated/asm/syscall_table_32.h
  ./arch/arm64/include/generated/asm/syscall_table_64.h
  ./arch/arm64/include/generated/asm/unistd_32.h
  ./arch/arm64/include/generated/asm/unistd_compat_32.h
  ./include/generated/autoconf.h
  ./usr/include/asm/unistd_64.h

while on x86, the only header that changes as part of the build is

    ./include/generated/autoconf.h

and all the other files I listed were just because I hadn't noticed
that "make allmodconfig" itself avoids the write of ".config".

So that "touch .config" is needed.

Or just use another file entirely to flag the "this is the state
before I actually started the build". Which I probably should have
done instead of thinking that "hey, I have this .config file that I
can just use as a marker".

            Linus

