Return-Path: <linux-csky+bounces-516-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 454C7904320
	for <lists+linux-csky@lfdr.de>; Tue, 11 Jun 2024 20:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0303B23705
	for <lists+linux-csky@lfdr.de>; Tue, 11 Jun 2024 18:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E25E38FA1;
	Tue, 11 Jun 2024 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HPLZ/6hz"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAF852F70;
	Tue, 11 Jun 2024 18:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718129143; cv=none; b=sYhFqYRc6r0574DmSOlIpHFNdA+i8WqGzBnV1yA850/VdN82Qq+13YjQTOKYCX0K3yBX0UTkoBiQxtvCaPESC/HiKUVGqW2PdTLG4FTwIH3uKblGE7CLwMkHc+t9EeEvz+Zfe5iWuXSBps4XsmofXg1XXnyC2ESunj2+fkIVyPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718129143; c=relaxed/simple;
	bh=v4260zIOGMiHtURiK7ky76hfMdWXplRiNTWm7coxRYY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amk5zHKLKSVALIQvCwGrPsbCsCNatOwI3MIoeVE6DNEDkOdS58SU/cJ9/57CGEp5C2Y+HTmB26zKaE0tDkc8zBsD8qigRMlbB6yN4VMXz8S9tLtYSS17kC8pYi0Vm7cGCeoDgzi7EP8NZhLBi/CqfU+Hv5OTmDQX6dHQOLwFRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HPLZ/6hz; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52c84a21c62so3123583e87.1;
        Tue, 11 Jun 2024 11:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718129140; x=1718733940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RUohe5I/U8iYfjovsxU/qvXwQ8UTe5baG/sBR7a+0qU=;
        b=HPLZ/6hzuJ5u06VvQKwRd+kjwk9SYaWMxPiXspf8gDWnvZDXefovErJuW3w7z0ezhg
         TxbHeX9udq16OeLS8PCCEsncQdb3/jsT4l1EvihfY3lN+XfOBCPCUHdEiMyoA4lsdFSR
         JTTwYi0WvfVcj7BqRfTDeNU8FU7fYfIHrR7f4YDdWSCY9WIn8Dbaq9oIGeLAO6374WTS
         u0B12mMH698yxiy5Mu8E2iAoGOIrd4+zHjzhPXqYcOMdSXdYUwbxDMoj224GTCER6wEV
         zTqiDayNuDhZbclZxhXw+Ks5UbyLf1Eui/cUdNFl+fCy+LFEt5UOypeZBZTWqWif+AGy
         kcbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718129140; x=1718733940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUohe5I/U8iYfjovsxU/qvXwQ8UTe5baG/sBR7a+0qU=;
        b=Zc5m+uDVG1obqBK8cy0+tRiKgxdfRkIEy0l7Ki6xHRphrgV8xJ4Bf0f+XfORC/Zvw0
         YTL7q5JwZrFHIPqkgOM4DXAKp0VQJ1b8mSUYGHXD48ce1zodOH6L/eGn5PM8JU7e9GZr
         9JywiUz8G0ek6b3R7SOSdMHP8VRWWm2pCGNdQWjNh56v5RzzskkZW0l696lKG2t2L9jo
         26FedT5pCfma5dlVB9rrgzxi2Nave/d9Jhr288WGTxZWHRRaVuAzKVC2WOlr/WHL5732
         qF2pGAd90eC+qp0izBYm289ZJkKXRzYOJjDDWL/7ffjn71WcDM0UnhFlNVHcoDiCPkvL
         3vkg==
X-Forwarded-Encrypted: i=1; AJvYcCVMjgcN26Qo9UTRn4fTg/7LQpe2OMdhkfZJoBAkcoYIClWOtzKbyabuykg0A/tnBI5Rlj1W+sl8L7hAFPyjZVo8bsTmfCTUw+ea8VWfaSlDi95gMS8v1N/GqBWPsqF3t0NG/r/x8A==
X-Gm-Message-State: AOJu0YyoEg3r4vgcjm9Z892n0LyjU9HtGY27l/FsyhXN3LaE361qwudq
	56kh/quuv0mOzEgDzx4ce8mv0Z56ey14SHbOFmHPY0TJVKrG9XcG
X-Google-Smtp-Source: AGHT+IE2qPhlRsFkwXDOcSqAcYHE6TUAlN0piNN/sxB8v9XWqfk1bNSlBYNdXHQRf5+2ZR64HQJHIA==
X-Received: by 2002:a05:6512:70c:b0:52c:8a4b:f972 with SMTP id 2adb3069b0e04-52c8a4bfb11mr3484974e87.34.1718129140051;
        Tue, 11 Jun 2024 11:05:40 -0700 (PDT)
Received: from pc636 (host-90-233-193-23.mobileonline.telia.com. [90.233.193.23])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52bb433e22bsm2217192e87.287.2024.06.11.11.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 11:05:39 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 11 Jun 2024 20:05:37 +0200
To: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"ampere-linux-kernel@lists.amperecomputing.com" <ampere-linux-kernel@lists.amperecomputing.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"cl@linux.com" <cl@linux.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"guoren@kernel.org" <guoren@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"xiongwei.song@windriver.com" <xiongwei.song@windriver.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	"willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v4] vmalloc: Modify the alloc_vmap_area() error message
 for better diagnostics
Message-ID: <ZmiR8STlyXEahzqy@pc636>
References: <MN2PR01MB59025CC02D1D29516527A693F5C62@MN2PR01MB5902.prod.exchangelabs.com>
 <ZmgiPTHGy-kHNe5x@pc636>
 <CH2PR01MB58942C3696E4FD0181782F4DF5C72@CH2PR01MB5894.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CH2PR01MB58942C3696E4FD0181782F4DF5C72@CH2PR01MB5894.prod.exchangelabs.com>

>
> This is intentional.  When 'addr' equals 'vend' the overflow path is triggered, but then the 'vstart' and 'vend'
> values are not carried in the overflow path - making them point to no address. That is the reason 'addr' is used
> in the warning message to specify the restrictive range - that gets assigned to 'va_start' and 'va_end' in the ideal case.
> 
What do you mean when you say:
"but then the 'vstart' and 'vend' values are not carried in the overflow path - making them point to no address."

From your commit message: "With the update, the output gets modified to
include the function parameters along with the start and end of the virtual
memory range allowed."

i see that you would like to print an allowed range. Thus an allowed
range is specified by "vstart" and "vend", i.e.:


      vstart  vend
<-------|------|------> vmap spase

an allocation must be served between "vstart" and "vend". So, according to
your commit message that range should be printed in case of error.

Now you print, "vend" address and "vend + size" one. I do not follow why
you need it. Could you please explain?

--
Uladzislau Rezki

