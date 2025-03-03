Return-Path: <linux-csky+bounces-1849-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E85AAA4B833
	for <lists+linux-csky@lfdr.de>; Mon,  3 Mar 2025 08:15:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1899B1688CF
	for <lists+linux-csky@lfdr.de>; Mon,  3 Mar 2025 07:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C621E51F3;
	Mon,  3 Mar 2025 07:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="f4A84WM5"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E08061E5B76
	for <linux-csky@vger.kernel.org>; Mon,  3 Mar 2025 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740986139; cv=none; b=I25JSj7j5yTV9yJ4qIYjivKLt6HWZeV/SNWfiUHZiN04R2FKAOrDrSFQpYCZ8l/2hjGH4v4jDvbhv2gvzBrUj7JO9NhJCbDezZKTFntk/GGgAeMR/lc5CtkW/011GuXZA2qUif9MdSe8xzSX70Zdg6INX+uy2tUf3NUuGpQRxok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740986139; c=relaxed/simple;
	bh=cyZ+Grt5WsWeJ35wJ4Miw4zucqCOoTXmPw42CecotaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fRI+LlJTO6kIbDT1PUQwbsywBql1LWaL/Z+KrCN1Z0Ehn6efPtpmulyxFbUZGzWodXNJ6TT2LD7hXjy5lV12eb7W5tSwMbAjY5ozAeA124ZlsGO4U2tbDSwsWtZkezdmv/CkzH0cWOPBasiOFW03bPuwFgJGyKUTNTPQiznN5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=f4A84WM5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2238e884f72so19108645ad.3
        for <linux-csky@vger.kernel.org>; Sun, 02 Mar 2025 23:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1740986137; x=1741590937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3xf7HJyOLISUqnBF4lpknQTsncyxq6apcdgU1Q2bwI=;
        b=f4A84WM5UBmOEItKzAifDxDy7QSqQog+5OdOY7cDip+Ifi/SFUtojaXd3nv9N46OkR
         obbn8XiDHfPwzOhP+v9F4yJio5kY6Fy6S6Dij4j9DhRO+gigEV2oQ1XDcdtvMOTvOPmE
         WpuxN3y1/iFpfhe6FIe7LgfmoW5WjaSdqf2obCSIVsNV4KU9GPJlIYbIQ+dtrHsEz8Qj
         obAsvIJ84Xaa/DfhJQP52pW8eNlzAzvKCu3ybiqdRykVPzSYIGvK4+hUWmRrrn+BPGQx
         E1zuno2Ug6TvBtzOsf/XTEeGekcF2JdKNte3lMVXw8TZSOU37BEEcnrYWZ+wVCIGz6FH
         p2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740986137; x=1741590937;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z3xf7HJyOLISUqnBF4lpknQTsncyxq6apcdgU1Q2bwI=;
        b=PRviwi0O8rURRM+2RfROuOZ7UPM6XpDKkPAghwDHwIi9FyJEPPWjSjO3pXCrt/oXJV
         ZFZ9upeBcUjNHroRtW+QTkH3ccZYJEdQCIL6ui/C2Xiifsusff1cdRU151TY9R1b/LZH
         1pum+8tKlEKZJkTAARo7rooN5yf6r/Ubt1ce+KpCvxD/f0wceQNs8XwRiyTnIodJaqoY
         MrN8ju2Ql4KuJuHcBzVdVJJlsv80Oc9fiXAYWtMAtkql1mwWzgGqKehmYMDzhC8D7m48
         gzb5sMWzvg9FRLaCeCAn8otqrMcWYRJvMye2Fqnx3QMTxfyL+eaBCm56NKUkru/nULM+
         as4g==
X-Forwarded-Encrypted: i=1; AJvYcCXIeQNgc8jvvjOu1q69v15UqaEC1+HgFW6Q3DslTuWWyTwsQ/DemTwruAJyBn8mW9vJlvzjJGcXUeJx@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt4lRFMHu4e/LtXj1R2tcePF0ZR2CyCbMGX5qTouNUclnz0q7X
	J+gP8UX7DlF4oasTt7Buo224tWyioi7SLa9DoQwHkeMWnrISkhtdbHtGL3zCOt8=
X-Gm-Gg: ASbGncvzmHm68L2pVROEwK24SbVJ44DKhSI8Arkz8AXpPoSDLH9touJuPwCqV3OLAyp
	T4XMzzovalFuoTFwLedM+Ne90RJYGql160UamAFbuKrmG0CjGwvxBLVS4YE6raouG1sjf0VXSuP
	6x/fs0aVCzfFvPbcQZR9qI9QwKQU2fgDmAroaezkDg9Ir5FC4PS7i1LAgOEmO36YS7t+KUBsNxg
	prw6C8PphPj47OTHBXFQ9IrngScTVF16Ths/hzhT61457mgU5RPxmpViw2podRYbf/a1Ry56jx0
	uZHqaat5M+ZYui7nNgJsYc5FPChksGIwqxgvmas9IG9mdYrZg+xuOUXp5eHYUHix91Woaw==
X-Google-Smtp-Source: AGHT+IFFzAQLESy+9XTrR371K4l9s8+Ug8zXVzf/oXiEIXCRNjxwSBTp4Oh3Iq6eaMxuwqzsZm0CFA==
X-Received: by 2002:a17:902:f64a:b0:223:5645:8e1a with SMTP id d9443c01a7336-2236926727dmr181629675ad.51.1740986137075;
        Sun, 02 Mar 2025 23:15:37 -0800 (PST)
Received: from [10.68.122.90] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235050ce10sm71093955ad.200.2025.03.02.23.15.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Mar 2025 23:15:36 -0800 (PST)
Message-ID: <4eb93ca8-7526-4709-b43e-2ed9e5583e3b@bytedance.com>
Date: Mon, 3 Mar 2025 15:15:22 +0800
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] riscv: pgtable: unconditionally use
 tlb_remove_ptdesc()
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com,
 vishal.moola@gmail.com, david@redhat.com, jannh@google.com,
 hughd@google.com, willy@infradead.org, yuzhao@google.com,
 muchun.song@linux.dev, akpm@linux-foundation.org, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, arnd@arndb.de,
 dave.hansen@linux.intel.com, rppt@kernel.org, alexghiti@rivosinc.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 linux-riscv@lists.infradead.org
References: <cover.1740454179.git.zhengqi.arch@bytedance.com>
 <9025595e895515515c95e48db54b29afa489c41d.1740454179.git.zhengqi.arch@bytedance.com>
 <CAEEQ3wnvgX=Bq=oAQV6wfg5a7H2jiG7f8P6trbC9agJ8D6t4pA@mail.gmail.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <CAEEQ3wnvgX=Bq=oAQV6wfg5a7H2jiG7f8P6trbC9agJ8D6t4pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/3/25 9:45 AM, yunhui cui wrote:
> Hi Qi,
> 

[...]

>>
>>
> 
> This set of patches mainly refactors the remove page table function
> interfaces. The comment "riscv_ipi_for_rfence" has been removed, as it
> was no longer needed, and this patch handles that.
> 
> Additionally, whether riscv_use_sbi_for_rfence is true or false, page
> tables can now be released using RCU. This patch changes the previous
> synchronous release logic (for !riscv_use_sbi_for_rfence) to an
> RCU-based release.
> 
> So, Reviewed-by: Yunhui Cui <cuiyunhui@bytedance.com>
> 
> Based on qemu-system-riscv64, I tested this patch. The log is as follows:
> ./gup_test
> TAP version 13
> 1..1
> # GUP_FAST_BENCHMARK: Time: get:663365 put:117 us
> # ok 1 ioctl status 0
> # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Nice.

> 
> So, Tested-by: Yunhui Cui <cuiyunhui@bytedance.com>

Thank you very much for your review and testing!

> 
> Thanks,
> Yunhui


