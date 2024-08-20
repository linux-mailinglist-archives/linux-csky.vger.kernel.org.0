Return-Path: <linux-csky+bounces-721-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E6F958FB3
	for <lists+linux-csky@lfdr.de>; Tue, 20 Aug 2024 23:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC471C208A1
	for <lists+linux-csky@lfdr.de>; Tue, 20 Aug 2024 21:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58D214F109;
	Tue, 20 Aug 2024 21:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TUvHgwEK"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797BBE541
	for <linux-csky@vger.kernel.org>; Tue, 20 Aug 2024 21:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724189488; cv=none; b=M23nhaiZKV8uVDCJvYQk8qT4VYSikyTee9IZDb1i9G4E2yEZK1c/4ZotUaNqfm1Wa66eAjgxDrWkaSTv8KuybCkjlc8NNVU3T+BsiZZgrI5atM35M5OxG2uuE7PQpz2qZGzgH9CXWKNP0NqMeXtv195kt2cq8hmZyGU5wW40YYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724189488; c=relaxed/simple;
	bh=zPen0ZDsMIGVeT7oJMVDG1CPWwqKsFrBf0fJYTWFLXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DqHgwQjnRyQIO1Od2zIxqQ9ba27Jrh+TM2RzlGraNOPTPm4ZJsLlB8XTUWLtGsSIjs0nUE0jwyx8mjTAKBCrXdh5QdUOTWsFEEl4UD4rcI8R05qcJbblMAXtfByk0U49k0Q8d9aaxPp5viJzhiz++QCv5pVc/+ombKuIxboI4Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TUvHgwEK; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so4549404a12.3
        for <linux-csky@vger.kernel.org>; Tue, 20 Aug 2024 14:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1724189485; x=1724794285; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B/qBbIdE12tBC8jy3M3AIScxm0SURUOtfr0PSYL5bF8=;
        b=TUvHgwEK6QWIv8b/UE6+7QvVdlLb2YDQsd71uqzaEQ+BrCDQmPMhad/tEVmFVaTN/s
         ZrCuE1pXX6EHJsaKK0e7tg+TjRqs6oX1fJg0YpA+xZ/PBw5/d3EVeBPWdb56fmz1rPTy
         JLGKXD3Bv2Xopjk06cF8wNx7tD4lXEhdqKxB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724189485; x=1724794285;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B/qBbIdE12tBC8jy3M3AIScxm0SURUOtfr0PSYL5bF8=;
        b=YL/JZRsQDjbV19bWr5WHQG5Z+6DZp/jhf1tKvKkXhKTMEi++ZC0IYSt3iZQFg5BPqU
         8IScGGqy28lqas4dvckqhSstKKmYp/+fHScIj+kxGOiS/dcFjWUa6JOVZtej5geG5Ph5
         wXnkL4X89U4vGYiOW4IPEBNWX89zVcbCzZAiCbqaOfiVJ2JhRUKsuyycAteO5B5DX0NQ
         jUPAWpcEhoMquMt5k5Vc4CP+/5xPQ6bRe5F6dQrna5eeVeiM6mwOcw5j0wT5JH5TxUc5
         8yoAftd98aA48910jSupeYUUwX4u5ka6JCR6dmfLdkp4Gac/TomYkYj1y+ZeeEIT7eKJ
         legw==
X-Forwarded-Encrypted: i=1; AJvYcCVxoAfnP6R9W+C7j6zafhla2WrpQnAfAd8fnCrNukQUQ6OR8m+/oR3lAYmMVNUMKwTjsvykZ/ht44+A@vger.kernel.org
X-Gm-Message-State: AOJu0YzDsY2uctD5SSh44KjqHz6cXHDrr1rPFBNdSKlSjmZCOsABGYcW
	JDHK5SaxSDkM+GQBvuEeUOBhfjbrSrttSygAdRtgmmqtmZXgowchOOb9Eb5nL5hwt4B1eu0ZkDU
	+AC0VAg==
X-Google-Smtp-Source: AGHT+IHIBWlF6sXPCxlXKUuw1dYWhCZ08yg0ZJWju6RYWrtxxEX5i1zv9XaLrGB2blGa+/BkAk4biw==
X-Received: by 2002:a05:6402:358b:b0:5be:eeb3:b9d with SMTP id 4fb4d7f45d1cf-5bf1f0d89c4mr76791a12.9.1724189484389;
        Tue, 20 Aug 2024 14:31:24 -0700 (PDT)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbdfa4f1sm7188815a12.43.2024.08.20.14.31.23
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:31:24 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bb85e90ad5so4549369a12.3
        for <linux-csky@vger.kernel.org>; Tue, 20 Aug 2024 14:31:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNdyws95XLB7Sa/S9qZ4b7lfOMecB76uCXzi5LUheRD7K7A2hUfM8pRFqCczsJ10qA0aobR/lHFCk7@vger.kernel.org
X-Received: by 2002:a05:6402:354d:b0:5bf:b29:6eb4 with SMTP id
 4fb4d7f45d1cf-5bf1f164130mr60685a12.21.1724189483542; Tue, 20 Aug 2024
 14:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812082605.743814-1-mpe@ellerman.id.au> <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X> <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
 <87y14rso9o.fsf@mail.lhotse> <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
 <dff57198-7955-ec09-8909-671982834673@landley.net>
In-Reply-To: <dff57198-7955-ec09-8909-671982834673@landley.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 20 Aug 2024 14:31:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
Message-ID: <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct vm_special_mapping
To: Rob Landley <rob@landley.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, 
	christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com, 
	linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com, 
	pedro.falcato@gmail.com, linux-um@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>, 
	Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Aug 2024 at 14:17, Rob Landley <rob@landley.net> wrote:
>
> Hexagon also has &&vdso_page which I don't understand (but have a toolchain for
> somewhere to at least smoketest...)

The '&&' is just a typo. It should obviously be just a single '&'. As
mentioned, the only testing that patch got was a x86-64 UML build
test.

Fixed locally.

               Linus

