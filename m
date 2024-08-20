Return-Path: <linux-csky+bounces-719-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A92958B62
	for <lists+linux-csky@lfdr.de>; Tue, 20 Aug 2024 17:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D5C6284043
	for <lists+linux-csky@lfdr.de>; Tue, 20 Aug 2024 15:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D837194138;
	Tue, 20 Aug 2024 15:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cHWThSYR"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3602118E370
	for <linux-csky@vger.kernel.org>; Tue, 20 Aug 2024 15:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167937; cv=none; b=AbVqJMJICvMhxMI3cXAPNwAQ+rI8oU3KIoZ9/U3+dCPWxz1notfeJ615j+WsTiQz+QqH6pJNjSSmv/CB5b5m9OeUFqxCqNo1YmtsOYdT/tT1oWFgopN6ho/RcDJmeoH5bAGBHly/+3fhCQPc5KYWwXM4d4Jl0nYUeWFY0sML9qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167937; c=relaxed/simple;
	bh=MiDlbS6ff17tWH6m3MZ6F9tz3FBlacdmGvTetKNSYdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AO1X5KITgdJs110TxxWWovcdGJPrXBonlbhd/egWlQR8y8xDSTO+re578YP0XzxfNbIB9eu6N+3qXfrUvs3zAoGBvfxa1gVkjZQwJsArEwzoPHAWTq/ebxFbqEhHtN67gmAOfxBQnbqTUZDKBD25dL6ONCOBlAK8t7IzCsMJzWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cHWThSYR; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52efd530a4eso8774092e87.0
        for <linux-csky@vger.kernel.org>; Tue, 20 Aug 2024 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724167934; x=1724772734; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=reG4/g7c03D2ee4fl6pmLF83MA+CK6ivPFyQdUf/2ns=;
        b=cHWThSYRh6G18xVUEMXyUQZb/YOyhOgR5JRzFBqCNO8BcT9uBkQhK552mhhRVRSpWB
         SF2tWsZbih9YM85nl0JoT6AlOr4pKAec/bAjICFXGMqdUzZVjMBxxm5XL7s9cWXwuHSN
         gKgBPzHnfArPxFiCX/sv5Y5GzUvnRZEpq4Xa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724167934; x=1724772734;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=reG4/g7c03D2ee4fl6pmLF83MA+CK6ivPFyQdUf/2ns=;
        b=l4vW2Cz39jpMCAYx3o2IMF8/U+AgMh3dB0X7JhEwCveJ3ClRi7cZ+DMz4TUqR5VTbn
         TlOyjh0rTq+bXnUwtOQmnby2zWJWTLqewyuQdFvoxQxgYUsC6CEERhLPdMzGIwKF5XeO
         E2viXp58Kdsq4ynkTRWAx0M3vWOxnXF0aYTFkPJFoX85qmr+XKydGi8TrlbGBVxWp0kq
         uoVRyi4NuTigOohT13pd8p+s534NfjSfUazxITguv62Aril63i0RpdhHewWbAEVOBxxe
         l5LiK4w/skM4/xPUh2JgaCA3zSDs5tO7TTqtB2G2D+jKal+8sitnGQ5mlPwZOoimGvUt
         ZTcw==
X-Forwarded-Encrypted: i=1; AJvYcCWhdsaNPRa1pYjPWy+5h+MZp8wk2ND816NVGfKjfJ4JLVGOGmHqfVXTFhuLhlVGYF23T/WxhSm1CuQjjxDIDvmwGAkTmpABSYlKdQ==
X-Gm-Message-State: AOJu0YwMrgWnrvQbp+hVODL77/zeo3N4s4s6/qDJlqk5YgxQ7WeuRtlX
	bqWGNzL4zMG5O5uNhB8LQLOaAPru7J4iMQnR61hFStoIp78EL4TumjDisqN2cfFJ7dt+6VKyrIP
	mcjhspQ==
X-Google-Smtp-Source: AGHT+IHI63ur2VubtN885P1cB9iigtpu91Z/8ZlwsPrJIaFsXtXTJOLqg2V1C3K0/0437fl2IZuo0A==
X-Received: by 2002:a05:6512:1111:b0:533:77d:116f with SMTP id 2adb3069b0e04-5331c695a2bmr8608880e87.9.1724167933760;
        Tue, 20 Aug 2024 08:32:13 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838c6ad0sm772994166b.24.2024.08.20.08.32.11
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 08:32:11 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bed72ff2f2so4749699a12.2
        for <linux-csky@vger.kernel.org>; Tue, 20 Aug 2024 08:32:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVFIZg8I1R6i7cu8IW5VO0H12l5Ds4H/VAMA1WPTeFM6UEQnrTSRoU66Wz+rFcDb4sL1jXmf1fxwucpOmEzX40FwnkoIJp1nwSQ5A==
X-Received: by 2002:a05:6402:2710:b0:57c:c166:ba6 with SMTP id
 4fb4d7f45d1cf-5beca5c5750mr8152922a12.19.1724167931490; Tue, 20 Aug 2024
 08:32:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com> <87y14rso9o.fsf@mail.lhotse>
In-Reply-To: <87y14rso9o.fsf@mail.lhotse>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 08:31:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
Message-ID: <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 23:26, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> > +static struct vm_special_mapping vdso_mapping = {
> > +     .name = "[vdso]",
> > +     .pages = syscall_pages;
>                               ^
>                               should be ,

Ack. Changed here locally. But I assume you also don't actually test sh...

It would be good to get acks from the architectures that still used
the legacy interface.

              Linus

