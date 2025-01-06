Return-Path: <linux-csky+bounces-1502-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC49A026A8
	for <lists+linux-csky@lfdr.de>; Mon,  6 Jan 2025 14:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43F7E163DA0
	for <lists+linux-csky@lfdr.de>; Mon,  6 Jan 2025 13:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7D91DDC22;
	Mon,  6 Jan 2025 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="F8yWxxpn"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623511DD0DC
	for <linux-csky@vger.kernel.org>; Mon,  6 Jan 2025 13:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736170511; cv=none; b=XdpTNnhGXI27TkXB6dJ4QAQULrwATzzRgwoKrbVNnH8ePbs/VrkOQNNXjkP6bWFGXdWqFkunPis+u9DUivd8Dnmgiza/vYtWoYSRSu5SM6qd5EQV03bzLfZvffhjZdxyvIg6OjwdHusBRZX5C9q71pNTU9yq6x7nFMd15xkUyhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736170511; c=relaxed/simple;
	bh=rzubnT0gas16PzeOBWAv24OQZ7te5xw5qxzCAysoAMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D5RLhwXLQhrZ/fM/EpZpZU8D4zBC5pAxh+CLwmiZ+7wGFZ51fsXseJHCx3pUvsblHEO7neFge3KtQIzxvscZtVia/eNlOruz6nPS8WoLubXZTJ3QwIWdZm2T5bu+Kdi4G867o0QNKBRl5/VTq3QqcLQLkgc/kC76fu7qj9oVKOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=F8yWxxpn; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2163bd70069so17232695ad.0
        for <linux-csky@vger.kernel.org>; Mon, 06 Jan 2025 05:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736170508; x=1736775308; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSl9CiTNSQwE0RKlCdBtogvBaV/TE9/iFGVUzDM7I3Y=;
        b=F8yWxxpn99xl6RSYcERdON6gNNnB5asuoZxu9+IiKhnbHtzVBKmaMwFOzzQbvYhySj
         nh6VUUrLeDq6AAXMXq/jAJ2VQolB9McY5VZE0rbL5jcDDdnEFC46jw/4AhXX7aen6Ty0
         UNa2mEJlz1X9sq5S+X9LBViB3JGYE2nlUvFICMDM6UWb6v2sF4soUCtUVwnWBF5Z/TWe
         Cd1G0zka+EO70usIOt9JQR75ipBZxl2Uz8loGmmPvNgXkiKeYK4/PpzvaxxzLEOLJcUj
         Z41cGVJP9D2tjsC373FIWLE0htTiClZQVQ6GqdjjSBFlJ3uLdhUpZgLJYNc+e0KD9w7m
         97mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736170508; x=1736775308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSl9CiTNSQwE0RKlCdBtogvBaV/TE9/iFGVUzDM7I3Y=;
        b=Yn6DljZ83nJwh3JXv6ShbjGXg96V75bV473BZV2eLW43UyBqYkHK3caCO2ycXg+E2W
         IEp64Br8xkWqznmA9ZsymxOlbcbFf3KLC2U5wohXMXDgGGDvPK/0lM9jFRUsPLbTd9Xu
         PQAL57+MA5+p+HRLys3/6PTOKsrJ16PCnNZu+Z+DFwQY7zUSJEnqOgCEHisVhMt/fST/
         XgXUBS0mH8LTMsbvTqVPJWN6ShGiV3eYq7sUI6cbUZjPpOg20EnvXROwQQx/EAkVWXYJ
         db/1sqtCRlUpPllIrb2CniOR9ZoBXTcFDfZMf/NpBXZOVbBb8/eLO+QRlCgynDqFAFWj
         ZnlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPOYsWNZ+pVEtNcl+RV88FPo79re6dk4NR6rgyOXPEfrIdLroynA7f2rIWGn8xQQrHOZ3LhVKcxT+R@vger.kernel.org
X-Gm-Message-State: AOJu0YydUKLq0ZpAkhBRLn9/cB2HJUwjBx8cSylRKC4607fR/1hoMRQX
	1k88myU6tnZsy2RDoQg0oSoxfv1dOcVwoomalg+3riRyeBN0Vojf39khiuSox3I=
X-Gm-Gg: ASbGncv+ez2YIi2G+TvDJNVOQjIu86Zo+P6/xTdlSLRl8Km5ZSOBChAoQymYUC4H5UT
	R4HpI6tbBqY2fgZrEqJEGucad5xQTLma+gR3knnsKdcN7IWD1YqeMIc1gZ7WSHofs8CYCuc3MNo
	UWlfRUZLQSRdF1+JiisrROqz9bPhv2sf8DpOkgy/rE8S3F/Dk8uByocB18lec0zm8bSUZfVx6fu
	oErLqWviP92naJLfgej16zAqPgTMi00UoFBfPIPAPL7SMD25/Ve6GA0+vn5Am8hSrSyPKOkl4Ob
	dmdSiNbOm9s4T+xm70Fh5hLX5mDMGEwibeU5dzgk2Dl8bM8PV7Lw
X-Google-Smtp-Source: AGHT+IFuxfmftFbdw6fO4bIMnZYJ/q+si7Sq93AxF4PGQarIeYtLJTB7gRBGy3tWc8bUzZwj1LueBQ==
X-Received: by 2002:a17:902:e844:b0:216:3083:d03d with SMTP id d9443c01a7336-219e6f13c50mr852868805ad.44.1736170508636;
        Mon, 06 Jan 2025 05:35:08 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:d64:296c:a8f3:f81e:f88b? ([2409:8a28:f44:d64:296c:a8f3:f81e:f88b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdf02sm292469725ad.151.2025.01.06.05.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 05:35:08 -0800 (PST)
Message-ID: <57ea8193-2fd9-41a9-85b4-7af924f900f4@bytedance.com>
Date: Mon, 6 Jan 2025 21:34:55 +0800
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] s390: pgtable: also move pagetable_dtor() of PxD
 to __tlb_remove_table()
Content-Language: en-US
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <ad21b9392096336cf15aee46f68f9989a9cf877e.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uyJ2BjslzsjkZI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <2d16f0fe-9c7f-4229-b7b5-ffa3ab1b1143@bytedance.com>
 <Z3vQHplZqtHf6Td8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3vQHplZqtHf6Td8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/1/6 20:44, Alexander Gordeev wrote:
> On Mon, Jan 06, 2025 at 07:02:17PM +0800, Qi Zheng wrote:
>>> On Mon, Dec 30, 2024 at 05:07:47PM +0800, Qi Zheng wrote:
>>>> To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
>>>> PMD|PUD|P4D to __tlb_remove_table().
>>>
>>> The above and Subject are still incorrect: pagetable_dtor() is
>>> called from pagetable_dtor_free(), not from __tlb_remove_table().
>>
>> Hmm, __tlb_remove_table() calls pagetable_dtor_free(), so moving to
>> pagetable_dtor_free() means moving to __tlb_remove_table(). Right?
> 
> Right. But you Subject and description claim "... also move the
> pagetable_dtor()" not to pagetable_dtor_free() - which is another
> function.

OK, will change the subject and description to:

s390: pgtable: also move pagetable_dtor() of PxD to pagetable_dtor_free()

To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
PMD|PUD|P4D to pagetable_dtor_free().

But pagetable_dtor_free() is newly introduced in this patch, should it
be changed to 'move ... to pagetable_pte_dtor_free()'? But this seems
strange. :(

> 
>> And the main purpose of this patch is also to move pagetable_dtor()
>> to __tlb_remove_table(). So I think this description makes sense?
> 
> The patch makes sense, but the description it is incorrect ;)
> 
> Thanks!

Thanks!

