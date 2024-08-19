Return-Path: <linux-csky+bounces-714-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAD995757E
	for <lists+linux-csky@lfdr.de>; Mon, 19 Aug 2024 22:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6332B21DF1
	for <lists+linux-csky@lfdr.de>; Mon, 19 Aug 2024 20:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB04E1591E3;
	Mon, 19 Aug 2024 20:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fXaQpyKN"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9881158559
	for <linux-csky@vger.kernel.org>; Mon, 19 Aug 2024 20:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724098570; cv=none; b=SWUqIJ4U3b4mo1DJX+hLEWXU53oFDOEK4k8533G8mVzyX+hiB3HB4KRyBUuzNfB5t1RkkpRw+tS8/nvDOFtnIBDIXRFk6w0ZbPc2b+dvF0pFmbS2PvoPbPZ4KEnVt/TitBgA9POeLaw8ZFpptLgNuLWfzILMzh+83YcIUs2ux6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724098570; c=relaxed/simple;
	bh=MP2kPJdQKYK5hGOu9VTob2QU2S+5BQfmeHYP4bjRtok=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mKnqAqTn+lm37HuDmcrPHUsqAl8oK7dOKCVopqMDBAvHK2OZ6SmmWhOaw6vYY+g7/PnL7svqPGgrJbsvkQHgVwj9jmeRvWPmn14kCmRRz5Hovl/qRfbLE1hOkcXEzUnL+VcUk8+tzxhVoyS5xH2kHz9fbCs9K60n9AnYcE5aVAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fXaQpyKN; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a9e25008aso595814066b.0
        for <linux-csky@vger.kernel.org>; Mon, 19 Aug 2024 13:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724098567; x=1724703367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6kUf3JuaMLYYiOtuZKtyG5uHrd9gw9QQ5nZ3PFBxZMk=;
        b=fXaQpyKNDZSq5jOtaqnZ5iUAWVtAGNjVn7XoRu8ANs2jasJ567WClm/Zq3hcK2TNfq
         PdRe0CFDVo+oScBWiL93ACnUfdd/AeLtsUX8mVVQIxw/uriA9CbUlw3lfdU4X9Carw6O
         P7tRk1qkcPbHuz2c3hhw32ZGcTiAhi5RqdolE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724098567; x=1724703367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6kUf3JuaMLYYiOtuZKtyG5uHrd9gw9QQ5nZ3PFBxZMk=;
        b=cXh1YRfC2g4Bn4PTFVUj50pDQWWhDzfvPMRSV8GtlWsKe9C1fuUR+qnRGMMJyRRXSO
         oqQbhYhsRCWMhLGqMASpUX3UajeWjR6HMCfpINyZU8CL2gBqhSFR3P6PR1AJG8xiDW1m
         EEOeOM5qA2gDahyLryDDbdsVrsK8Wcy7v4IrpGyujtoyP+wCfHd3BDr+AYoJwdtvZpzw
         6JbZKOjnZPFexoWOeZ3XZX6h1MjPhuh/srCXL2cwqK9YfkbF/sjCYPbRFuO2xbIYZs9H
         gYrQruGfM4M+ums5sL/0IEaKZOiNqLkqqwIJeagkDDJST+ie+NRj0TD5JwXHHjUv3FId
         KyzA==
X-Forwarded-Encrypted: i=1; AJvYcCXXGaGW5Xogqe8wPYpWRqwFcBp3LGMh3EGFFohzIl/kZQmmH5bMibHDnkYPRCCm3ZvYwVlIdeCxfSKW@vger.kernel.org
X-Gm-Message-State: AOJu0YwLS0kkzRsGrkX3XUQhTsFfgpOIJRBwkCLMGpvD+3SaMPIy8Zv8
	cEwkOkFuTwh2Ay78mPydRcQSERTIBvsDS7ZV4avKYxWFIv0beiPSbp+UOZj6umpb3gGukv2nARA
	5M632Qw==
X-Google-Smtp-Source: AGHT+IFaloX6NAXUgHl4dsA0vacplrp8iWyic/mNPYGcVCtz47nwH76oyvKEW3Aa9vPY0CbpdjP4IQ==
X-Received: by 2002:a17:906:7951:b0:a72:7fea:5800 with SMTP id a640c23a62f3a-a8392a4b326mr745539366b.63.1724098566970;
        Mon, 19 Aug 2024 13:16:06 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838396d332sm667170766b.224.2024.08.19.13.16.06
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:16:06 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so3478920a12.3
        for <linux-csky@vger.kernel.org>; Mon, 19 Aug 2024 13:16:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUHzSb5V23ggQTozizxV4TN20ppuaDy/r9J6pqumBTo5FqiPo/O7ivSHpe046Lh3Z8v7t/+g3nSwSQG@vger.kernel.org
X-Received: by 2002:a50:c8cb:0:b0:5a3:a9f8:cf20 with SMTP id
 4fb4d7f45d1cf-5beca8c7c0dmr6123102a12.34.1724098565883; Mon, 19 Aug 2024
 13:16:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com> <20240819195120.GA1113263@thelio-3990X>
In-Reply-To: <20240819195120.GA1113263@thelio-3990X>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 19 Aug 2024 13:15:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
Message-ID: <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@quicinc.com>, 
	Dinh Nguyen <dinguyen@kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	akpm@linux-foundation.org, christophe.leroy@csgroup.eu, jeffxu@google.com, 
	Liam.Howlett@oracle.com, linux-kernel@vger.kernel.org, npiggin@gmail.com, 
	oliver.sang@intel.com, pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 19 Aug 2024 at 12:51, Nathan Chancellor <nathan@kernel.org> wrote:
>
> Yes, that appears to fix it for me. I don't have much to say about the
> rest but others might :)

Ok, I did a quick hack-job to remove that disgusting
install_special_mapping() legacy case.

With this, the old "install_special_mapping()" mess no longer exists,
but I haven't even attempted to compile the result, because I don't
have cross-compile environments for any of the affected architectures.

Except UML. I did at least build it there, but it's not like I tested it.

Adding architecture maintainers and more architecture lists to the
participants. It would be good to actually get this patch tested.
Context for newly added people:

   https://lore.kernel.org/all/CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com/

NOTE! This patch is against my current tree, not the linux-next
changes. But it should entirely remove the case that caused problems
in linux-next.

                      Linus

