Return-Path: <linux-csky+bounces-1868-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC51A4D389
	for <lists+linux-csky@lfdr.de>; Tue,  4 Mar 2025 07:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5978D1892891
	for <lists+linux-csky@lfdr.de>; Tue,  4 Mar 2025 06:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B32E1F4E38;
	Tue,  4 Mar 2025 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="AUPfMz6H"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F511F4CA7
	for <linux-csky@vger.kernel.org>; Tue,  4 Mar 2025 06:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741068698; cv=none; b=M1h3OD/qZ2k9+RFlaurUynRy0GKWUHZ4vWd9xjQ6PV995F4aVq6Tsx27yh3T3sK53UDlArw7tav+gfz8G3ImObGk9qj2EnTk7+bY1+fifaQ9InrnQGOpAYNYagVHUb/o0AsCp4dU9i7OY4jj9vNUaiyy/OtLBoIzrA2w6hcgN5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741068698; c=relaxed/simple;
	bh=xVZb2uxImUx0ECcSqYKHOxrGyYGp1I4gtxr8DYt1oOg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEeKuCPrpUvu+n7YIhiYfHRuL0ioNLKR7dM4ZPIb4lZmbox/MfNFAVs9T5f/9STJCkCSQVsKxZoRarBvAmALZI6fLt9N9d7nMDh8kh5IHSXNBo/hRcEGBEDYPWn8mWzPIP/q6eeXapNMoXSdk4GQfRe9lV1BszVGOn/YIsE+SWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=AUPfMz6H; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2feb9078888so8399676a91.3
        for <linux-csky@vger.kernel.org>; Mon, 03 Mar 2025 22:11:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1741068696; x=1741673496; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FvNFViwfp2APOt2jux8SKthZ9o17Z2NZrToAsK4eao=;
        b=AUPfMz6HBETFK4R0Mgs28jh2E0iSLs4SSEp7XTmoiALoDkS//Uy7h4hJbFXzCH3UcR
         lGIj13pM/OuDs+VBhkjVDmvJpWnMaiqk3LM4WUKgsyzn/uq3QVeTneYl9F5gefREB3Es
         UYCXiAMwlluep6lkTCQAPfgOCzsmZm86Hl+GwRNInToF+9pD95vYLhQ4ute8JQsrKTXi
         yBQXB2yWVOzjPbFf2j5JZnM+ScKcqEVfgVBLLa+05TxvwRCNF3TBP2jVaSOiI4nBuv33
         t27pXqg5Pf3y1O8teLeBXMcQc8bZr2I5Rv3DKEAWMgJUq9Uek4VgjicA9lYrdV/B9XMI
         3PCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741068696; x=1741673496;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4FvNFViwfp2APOt2jux8SKthZ9o17Z2NZrToAsK4eao=;
        b=RTKLjTLpJN/6Y5CiBxZRwM7JdufF0MezkGhagleQtXbRJRIkdpQ4og5REdt9CmlaY8
         vcqzlSGFDgopZhc+FkwN+ehx6BaDsT0mF2iwupjYaHITYfZyRzcZnycmKHcvP98BEX18
         mWxP1jA9p1/nCLV9qzntGLZZv/5OfxChPgzOAovQSuEwTSKZgNHXVw3zuWGBgf9jbl4s
         mV5f1Le6RfVx6w0kRHeOY7SIlPEJhGLXcLZfFiUt2EiBdC3hWLONUXG2d+15cHd/WITg
         JxOp6PDWgnSqycaaimkbWsID7g1+L95FgTe9GAGnnjW6aX94nRcYd2mz/ury04zwxFdA
         FkPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDPBn2pzMvYaC45HAxLAX9g+T3cnLSh9Wf7PwPsphYIPPTffOqOcCbmHGpEyQnpSispuhkD4kaguIe@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj3Zy9JQS37aFyggJn43tt8/cVubZu3l/Bib8wN79VUlGrfm+W
	a+7m/+Qk/TD78RfLirQlgWpEl0C+G6ns7afybcZNzrGx7oaLStTTbzlmdK6cd+o=
X-Gm-Gg: ASbGncsdJmdRqbeTBzFfIcS0L7+yU2slOt5L6gu1WGDxiAexPW1Onm0C7CGpBs9wOKg
	t3yOBdCsnmRIyNsnd91vUs34N6/1t0IEFHhUFCji2GdIneSEq6f1qAiBsEfTWE4hOWWKKXKEP4c
	byHPVlasZOLVHodHEqPIuoz/x8wiMDnBm3MD3tMH1B8FZNMTpaP6J/Z6TYnkRGMfi56kL0EE3Ab
	oDWNl3agXoHlMjxioIs4OeElb59VTD8N28ebnRGY19TyFdOFZFm5SrQOlUv589n/qK2qrAAlV1w
	REJW/+4zHejQJ5fuN/XGc1ZM3St5c1VJpGoy2VAXr8TkwkWu+T6kpCrrWEMEPe9ntn0u
X-Google-Smtp-Source: AGHT+IEXDQyCMQ8sBrL+0HeKoJpZdetEfwPwd6LYj+c4cbVY5/CTPcBDN/0v1nn1xNdV90cajxorag==
X-Received: by 2002:a05:6a20:db0a:b0:1f3:40d3:67d4 with SMTP id adf61e73a8af0-1f340d369d8mr504424637.30.1741068695820;
        Mon, 03 Mar 2025 22:11:35 -0800 (PST)
Received: from [10.68.122.90] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aee7ddf23b6sm9305805a12.15.2025.03.03.22.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 22:11:35 -0800 (PST)
Message-ID: <7d1c834d-bc65-4979-9b72-0d1d91019501@bytedance.com>
Date: Tue, 4 Mar 2025 14:11:24 +0800
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6 update] mm: pgtable: convert some architectures to
 use tlb_remove_ptdesc()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, riel@surriel.com,
 vishal.moola@gmail.com, david@redhat.com, jannh@google.com,
 hughd@google.com, willy@infradead.org, yuzhao@google.com,
 muchun.song@linux.dev, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, arnd@arndb.de, dave.hansen@linux.intel.com,
 rppt@kernel.org, alexghiti@rivosinc.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org, Geert Uytterhoeven <geert@linux-m68k.org>
References: <19db3e8673b67bad2f1df1ab37f1c89d99eacfea.1740454179.git.zhengqi.arch@bytedance.com>
 <20250303072603.45423-1-zhengqi.arch@bytedance.com>
 <20250303155331.de9b2fff9b04984a255a7bc2@linux-foundation.org>
 <c48715aa-8c1f-41bf-92a0-bacf401c2f7c@bytedance.com>
 <20250303200815.53007fb79e5049a99f24c999@linux-foundation.org>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250303200815.53007fb79e5049a99f24c999@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/4/25 12:08 PM, Andrew Morton wrote:
> On Tue, 4 Mar 2025 10:31:07 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> 
>>
>>
>> On 3/4/25 7:53 AM, Andrew Morton wrote:
>>> On Mon,  3 Mar 2025 15:26:03 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
>>>
>>>> Now, the nine architectures of csky, hexagon, loongarch, m68k, mips,
>>>> nios2, openrisc, sh and um do not select CONFIG_MMU_GATHER_RCU_TABLE_FREE,
>>>> and just call pagetable_dtor() + tlb_remove_page_ptdesc() (the wrapper of
>>>> tlb_remove_page()). This is the same as the implementation of
>>>> tlb_remove_{ptdesc|table}() under !CONFIG_MMU_GATHER_TABLE_FREE, so
>>>> convert these architectures to use tlb_remove_ptdesc().
>>>>
>>>
>>> checkpatch warns.
>>>
>>> Do these things have to be macros?  Switching to static inline fixes
>>> the unused-arg warning in a nice fashion.
>>
>> This can be switched to static inline. In addition, I found that alpha,
>> arc, microblaze, parisc, sparc32 and xtensa also have the unused-arg
>> issue. Do I need to add a new patch to fix all of them, or just fix the
>> newly added 11 warnings?
> 
> I guess leave things as they are now.  Switching all these to C
> functions can be addressed at a later time?

Okay, let's leave it for later.




