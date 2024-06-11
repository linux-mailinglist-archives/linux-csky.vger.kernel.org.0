Return-Path: <linux-csky+bounces-514-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A21890386C
	for <lists+linux-csky@lfdr.de>; Tue, 11 Jun 2024 12:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F98FB21E59
	for <lists+linux-csky@lfdr.de>; Tue, 11 Jun 2024 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9429179957;
	Tue, 11 Jun 2024 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IFr9cFaz"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A8617966E;
	Tue, 11 Jun 2024 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718100549; cv=none; b=dhXsjVI1cEOiUD4jE0auoRPDV950oJO02MYKJxJZ+s+AapCFdYqN979qS07IEAEyKu1hQjlJrIB49hiHqFVQw4qw3w4/TgDizox0wVaUsEugWumlGf8Fk14uFR5a1SmLDRK+zOyOUxllgGOUXuPa80dV7I0hEpIAQ+zwjLm7jXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718100549; c=relaxed/simple;
	bh=3WmpZua6PWQXO1deurxbC150Z6/pP6qkObBX3JdgDcs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eWkzS+e+JM1qPFQomjdHEK2oXCPiL0fbBNJdNgJkcz7wopcLXiq83vzPqSY8eJ1NBNOZiG8GCOGegiN13fuU0u3T/I+7DFNajmOUA69KQ0eFXfjzXNUjv6BHuyRBbJLYPd4ugmjFGsr7/S6wvdjUurcl8V0bPxDLRnoxPzs+IqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IFr9cFaz; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2eabd22d441so86297831fa.2;
        Tue, 11 Jun 2024 03:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718100546; x=1718705346; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SAheL3Pbpy7JA5UqcNyCOEP7IV/L7OYe1Dlbh7jegN0=;
        b=IFr9cFazcunObWQQ5MsQtM+qQSGXs7lI0Og+DgoYajh2PRCB2/XW6th/+qrhUsKnOL
         gqaFqiyGyZ7Pwkm5AW3fqxpa82e7qB1aqkuMUJ8aN5FWd1NyAjzhKTr4Ti1kJRf9zmp1
         vuQ/IYfvPxcbFvelwpVKuFy6SUEDJqveE9Q3DVSNYRL9kKUeRVaROWcqd/eXUp5yXu+H
         PpQjcsMyUJEdm/PngMqw3w6iB5TAz5ieGev3WrUsNxSFSg4kGepK3hMvWzVaZqzjAK9o
         4AsrHNzwSinxHnMxMu6+F1wcaE5hP1ogiMXuSBfU84VQzORJxycFLeIDBnCoXyaTYsR5
         4eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718100546; x=1718705346;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAheL3Pbpy7JA5UqcNyCOEP7IV/L7OYe1Dlbh7jegN0=;
        b=jyGf0OKYJhzKQVBqADg0vf1C08psqEc35z+DoKs/CKA6VsUmbL4hN/qaQixUi0ctLH
         D4iRDahFKe8DIuU7eRDo2gojqwa6EqoBeamZPvpc0v2ZqVjA0qzNlOOOYaQyIYn36EEw
         sU3tWmTvnRGGyU8OTTWJ6HhE1+5bAj74pURApIMb8GqZI+o8vbaAvDzpVoJfA5H47tam
         edH4f2Z+VBGZv2hobDzjAYPQczSmOpSHYfvHjr0ZU+pMZUS1MH/WDzU0JmThRhLx7z3X
         bRNvUyV10AIAOX6FV13JlcZHNz+CyccTTMggckdNsqagW3u7sq7edBWO23q1+fHFg8tl
         Rqkg==
X-Forwarded-Encrypted: i=1; AJvYcCWdDzY442Y2BVZf1v1zgebFcex5USy17GYiNBsZUQB9f5xdwM9Zm+cM31TQXaDw2zPIoZTwiIw0HldMOXvWemLmX1mcVnVCyZwQ3Hgxq7pUj1P1kyU6j4oAwcU5n+7e6E6jdVxF/w==
X-Gm-Message-State: AOJu0YwRIOaSKEOMfYLMeV2UXFPU4Ca1pf+p4FzxiO1OuxPlo3TTlcHy
	hsWfJPrMdSZIKFxKBIhdqUq1gfYlhIqUqFCE8cl7t5HFucaPwDUu
X-Google-Smtp-Source: AGHT+IH0PjLhxIMcOmVEi1E/G0UDxaUaRfwrRjmV1duTjWtdEeQo18W5dDAK7YmkOyj35USGDzY0NA==
X-Received: by 2002:a2e:9b57:0:b0:2eb:d963:d8cc with SMTP id 38308e7fff4ca-2ebd963dbffmr57469111fa.49.1718100545408;
        Tue, 11 Jun 2024 03:09:05 -0700 (PDT)
Received: from pc636 (host-90-233-193-23.mobileonline.telia.com. [90.233.193.23])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ead4131387sm21465021fa.51.2024.06.11.03.09.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 03:09:05 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Tue, 11 Jun 2024 12:09:01 +0200
To: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>
Cc: "ampere-linux-kernel@lists.amperecomputing.com" <ampere-linux-kernel@lists.amperecomputing.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"cl@linux.com" <cl@linux.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"urezki@gmail.com" <urezki@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"guoren@kernel.org" <guoren@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"xiongwei.song@windriver.com" <xiongwei.song@windriver.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	"willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v4] vmalloc: Modify the alloc_vmap_area() error message
 for better diagnostics
Message-ID: <ZmgiPTHGy-kHNe5x@pc636>
References: <MN2PR01MB59025CC02D1D29516527A693F5C62@MN2PR01MB5902.prod.exchangelabs.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR01MB59025CC02D1D29516527A693F5C62@MN2PR01MB5902.prod.exchangelabs.com>

On Mon, Jun 10, 2024 at 05:22:58PM +0000, Shubhang Kaushik OS wrote:
> 'vmap allocation for size %lu failed: use vmalloc=<size> to increase size'
> The above warning is seen in the kernel functionality for allocation of the restricted virtual memory range till exhaustion.
> 
> This message is misleading because 'vmalloc=' is supported on arm32, x86 platforms and is not a valid kernel parameter on a number of other platforms (in particular its not supported on arm64, alpha, loongarch, arc, csky, hexagon, microblaze, mips, nios2, openrisc, parisc, m64k, powerpc, riscv, sh, um, xtensa, s390, sparc). With the update, the output gets modified to include the function parameters along with the start and end of the virtual memory range allowed.
> 
> The warning message after fix on kernel version 6.10.0-rc1+:
> 
> vmalloc_node_range for size 33619968 failed: Address range restricted between 0xffff800082640000 - 0xffff800084650000
> 
> Backtrace with the misleading error message:
> 
> 	vmap allocation for size 33619968 failed: use vmalloc=<size> to increase size
> 	insmod: vmalloc error: size 33554432, vm_struct allocation failed, mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
> 	CPU: 46 PID: 1977 Comm: insmod Tainted: G            E      6.10.0-rc1+ #79
> 	Hardware name: INGRASYS Yushan Server iSystem TEMP-S000141176+10/Yushan Motherboard, BIOS 2.10.20230517 (SCP: xxx) yyyy/mm/dd
> 	Call trace:
> 		dump_backtrace+0xa0/0x128
> 		show_stack+0x20/0x38
> 		dump_stack_lvl+0x78/0x90
> 		dump_stack+0x18/0x28
> 		warn_alloc+0x12c/0x1b8
> 		__vmalloc_node_range_noprof+0x28c/0x7e0
> 		custom_init+0xb4/0xfff8 [test_driver]
> 		do_one_initcall+0x60/0x290
> 		do_init_module+0x68/0x250
> 		load_module+0x236c/0x2428
> 		init_module_from_file+0x8c/0xd8
> 		__arm64_sys_finit_module+0x1b4/0x388
> 		invoke_syscall+0x78/0x108
> 		el0_svc_common.constprop.0+0x48/0xf0
> 		do_el0_svc+0x24/0x38
> 		el0_svc+0x3c/0x130
> 		el0t_64_sync_handler+0x100/0x130
> 		el0t_64_sync+0x190/0x198
> 
> Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
> Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 ++++++---
>  mm/vmalloc.c                                    | 4 ++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index b600df82669d..9b8f8ab90284 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7245,9 +7245,12 @@
>  
>  	vmalloc=nn[KMG]	[KNL,BOOT,EARLY] Forces the vmalloc area to have an
>  			exact size of <nn>. This can be used to increase
> -			the minimum size (128MB on x86). It can also be
> -			used to decrease the size and leave more room
> -			for directly mapped kernel RAM.
> +			the minimum size (128MB on x86, arm32 platforms).
> +			It can also be used to decrease the size and leave more room
> +			for directly mapped kernel RAM. Note that this parameter does
> +			not exist on many other platforms (including arm64, alpha,
> +			loongarch, arc, csky, hexagon, microblaze, mips, nios2, openrisc,
> +			parisc, m64k, powerpc, riscv, sh, um, xtensa, s390, sparc).
>  
>  	vmcp_cma=nn[MG]	[KNL,S390,EARLY]
>  			Sets the memory size reserved for contiguous memory
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5d3aa2dc88a8..75ad551e90ba 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2055,8 +2055,8 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
>  	}
>  
>  	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
> -		pr_warn("vmap allocation for size %lu failed: use vmalloc=<size> to increase size\n",
> -			size);
> +		pr_warn("vmalloc_node_range for size %lu failed: Address range restricted to %#lx - %#lx\n",
> +				size, addr, addr+size);
>
One question. I see that you would like to see the range, i.e. its "start"
and "end" addresses for failure case. For such purpose, why do not you use
"vstart" and "vend" variables which specify a range?

An "addr" points here on "vend". Or is this intentional?

Sorry for late looking at this. I was on a vacation last week.

--
Uladzislau Rezki

