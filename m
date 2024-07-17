Return-Path: <linux-csky+bounces-677-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D382933621
	for <lists+linux-csky@lfdr.de>; Wed, 17 Jul 2024 06:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC10B22BBE
	for <lists+linux-csky@lfdr.de>; Wed, 17 Jul 2024 04:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B5E7494;
	Wed, 17 Jul 2024 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B/GANxE8"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71ED3AD31
	for <linux-csky@vger.kernel.org>; Wed, 17 Jul 2024 04:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721192297; cv=none; b=bZZZUUL0Xonwxl2ZyS4euHmsNW41M7mw2/TVyZPauwwVgk2aLcbX6I2wx5mhLO0ObJCZWoPSG1pqTIlmYR29N8ACon6o4i+Z8Z5SAAsyxRPx2iTFdbOc2JbhojIDz/M+qM0KhFGn1q5dh5hllm0lKwF2IQI6PmZpDOT8Y7Sf0Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721192297; c=relaxed/simple;
	bh=vABRMnRmbUscNHZGwHRUTWrzrPZYmjEVucxlkyKGsgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Azbf0rdu5DEOAZpUSnhsdb4skk806a8G1eTnoVERPXBU5KJGaj7z3Uz7vqP4xB5o41LdXdq6Scl9rNRSh8cqteHpVHazTzVEV84kIfyrRcPBwyOZOzT9BH8QYbUYjBAIKUaBKP2yytT04Uf/Pp3Fvc6wIyzWfKORzgW+9YqClJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B/GANxE8; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-595712c49ebso7492941a12.0
        for <linux-csky@vger.kernel.org>; Tue, 16 Jul 2024 21:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721192294; x=1721797094; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EAXDs4QhymT5qdSIqwghPBIT7eGCMQME0KsEWD+9hyo=;
        b=B/GANxE87DkLINfPSCNJjOwvUUQWqQzeT7l/vnsPtYjYEbBXHFE7X3kF05uFryl7Ol
         /HyHKqxhWbeZA3tqoyi5P1K0YAMIjb5WmaJVe1Kv+R2YU1QnWKnUIbNSSB9CZ1/QoWGu
         Tm2DohU4ACVb+8SOUvHCHO7/heWiuJuJPlwj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721192294; x=1721797094;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAXDs4QhymT5qdSIqwghPBIT7eGCMQME0KsEWD+9hyo=;
        b=Kh5Y0j/bx8qsgQOQLAg2EuNVzY2jWbbdsb+medt4BV4j2Yj3ziaIXvR/BLk3itNyKB
         +n+B4ZXA4c5HalttcFGc0gDVrCoxCyDwasQImBpDESv0p+en/HbYFr5LFzARrer/UjpH
         +Xi7A6fLKuQXi7Vne5Fnf4lQKnkoxQ12+4SbuQY2GmOuqf251ZItt7yzlF1VVj9rqkv3
         rlLS5Eua9Hn54iNsGFXMEL/dq0XLrLA4ZmCn6HDThDi6EorP+NskxrqqmJX14Atgp4OP
         2KZ+BxL0w1mHFR9x28oBapeViSIbfICUegYVLsoxE8b1XjJfT8h6DNpvDWNp16ON7YrP
         YkEw==
X-Forwarded-Encrypted: i=1; AJvYcCWUwqAxqd+WJtWfHEygTp+qrM/QSZJEMOWxcGDwBW9w1gR3COML94GwvModoUpaQauk9zc27UL15aTsewymjkFPrkDJ6W4zp/5UbA==
X-Gm-Message-State: AOJu0YxpsvI5nbIpVxoNceY/SreQM8Lo8quXh7JLviJJv8F9FEOx7AqM
	Z7wMlp3Qgk7No4znt1gye2wYtddSK8yTvFtdnMeK/XUqwpH4MpVKLi/CoWWcziWRKkRO8qurWQq
	5v1tuIw==
X-Google-Smtp-Source: AGHT+IHQG9dJ+lDJr6fJZ6k98V7VkV1bFadUq1V09AFRp4oEonyHx/TDEzFIYROBEf1kCLdbQaW64g==
X-Received: by 2002:a05:6402:34cd:b0:58e:e2a:1b58 with SMTP id 4fb4d7f45d1cf-5a05b22b9b0mr463029a12.2.1721192293706;
        Tue, 16 Jul 2024 21:58:13 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b25528dc1sm6177651a12.52.2024.07.16.21.58.12
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jul 2024 21:58:12 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5854ac817afso7715984a12.2
        for <linux-csky@vger.kernel.org>; Tue, 16 Jul 2024 21:58:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUphtTyhvqe9OZV7FxAj5GzJAb64+foWcZrBO2CsbabpLntMYte5Rb0gxbeK8VENgqo5iB4twAx7B3Cp1a8t5d8rGQPxAk8OwNMLw==
X-Received: by 2002:a05:6402:5244:b0:57d:4d7:4c06 with SMTP id
 4fb4d7f45d1cf-5a05b7ee599mr504374a12.13.1721192292251; Tue, 16 Jul 2024
 21:58:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a662962e-e650-4d99-bed2-aa45f0b2cf19@app.fastmail.com>
 <CAHk-=wibB7SvXnUftBgAt+4-3vEKRpvEgBeDEH=i=j2GvDitoA@mail.gmail.com> <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
In-Reply-To: <d7d6854b-e10d-473f-90c8-5e67cc5d540a@app.fastmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 16 Jul 2024 21:57:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
Message-ID: <CAHk-=wir5og_Pd6MBSDFS+dL-bxoBix03QyGheySeeWPX82SDw@mail.gmail.com>
Subject: Re: [GIT PULL] asm-generic updates for 6.11
To: Arnd Bergmann <arnd@arndb.de>
Cc: Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, 
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>, linux-snps-arc@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jul 2024 at 21:44, Arnd Bergmann <arnd@arndb.de> wrote:
>
> I don't see those either (this is an x86 defconfig example):

Note, it really might be just 'allmodconfig'. We've had things that
depend on config entries in the past, eg the whole
CONFIG_HEADERS_INSTALL etc could affect things.

And yes, I build everything in the source tree, so $(obj) is $(src). I
find the whole "separate object tree" model incomprehensible, and
think it's a result of people using CVS or something like that where
having multiple source trees is hard.

              Linus

