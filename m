Return-Path: <linux-csky+bounces-2307-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 579F2B555B6
	for <lists+linux-csky@lfdr.de>; Fri, 12 Sep 2025 19:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABE27C31DB
	for <lists+linux-csky@lfdr.de>; Fri, 12 Sep 2025 17:57:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F338732BF44;
	Fri, 12 Sep 2025 17:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QnyHMy0i"
X-Original-To: linux-csky@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B7432A3D1
	for <linux-csky@vger.kernel.org>; Fri, 12 Sep 2025 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757699816; cv=none; b=PibfsCoXnfVI6WpDygoroOM+JN7+RljWKitLXzpNmi4ApK5pGKlh2EhDG4+1XILco3SC8ylLpYfTp+vXJH5GwSX3EUBRamdlDIW4mQst0jdo3neC8O9auc1rbjEQC3kI3cYYfS51M8O6PlT0YBTxKvQWhVMSbLEyVBbjmEghrgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757699816; c=relaxed/simple;
	bh=t6JYHFn6xtQi0eO3tcMpphFu+Moxe/d2WklRNG+P690=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fe+pD9gLrureX0nWjO3ZnGNDXM/fEpD1JfUsk9waF0xU4kMff8Qm7DRYuWxAL1MbOcNAZBA2eTQ5Bs0ufN4zJLzfW0hyqglpeeLOEarb23qwPqPQ4etIL2Tv+jzuT7tlG6jCKHgGrOrAXJ7trBsYj8h34NG3ca74tADL5DJpon0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QnyHMy0i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757699814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=1WFUlnErlcGz3KGoSgWtaZOcBftKtTBkFfUxb/98m8k=;
	b=QnyHMy0i6ibXo+lAHQQ5TKq/gfsgGMLhKFQb2+F4ybcfbMu4jcbsQBLqXAjbIcctgFmkvT
	f6/kxDupHAFiQRsWJ160N4swt4T3cBTCNmn6Sp82tUOwK66xn9f7pAOvXCdZOEjkbNlgcu
	dP0P41sFDRd+mrdcj13UAlreSz5I07k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-5ouxpUFSNNShd4jvXCtiJg-1; Fri, 12 Sep 2025 13:56:52 -0400
X-MC-Unique: 5ouxpUFSNNShd4jvXCtiJg-1
X-Mimecast-MFC-AGG-ID: 5ouxpUFSNNShd4jvXCtiJg_1757699811
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e751508f3aso1546730f8f.0
        for <linux-csky@vger.kernel.org>; Fri, 12 Sep 2025 10:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757699811; x=1758304611;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WFUlnErlcGz3KGoSgWtaZOcBftKtTBkFfUxb/98m8k=;
        b=ULnLApOAIGHYdNJEfLNpb/cMSbqmG054iqMzN5ZHx7lkqWtwPLyeKjFdYtCrIVDdyA
         1WCKwl1DsjUuvZ7UCNuRCzrf85ZRFFKNUlvg7pQu2xT1j6Ue5h9gpmYQAjmwynGb3i+p
         /50FXyYkifxu0YEO42i+/bhSeDJdusLRgiD2+mvw6LGosAuuQE5u/PxfsHRn5mC5K67M
         M1KKb6yTKq/HzyY68/bDcRhbDf9pI/Ql3XcDtsPIsgXDKZsPiBJ9qcG42Abf7aDWyzHk
         Gxr/wBl/y2+/3W6nS2F818zgforRqBondqyH1nEGKXuwlyRtpCfpIxdInaFSsqM6ejh0
         O4tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCBz/a7K9wrRb6A9jyI8twQFUSmXX4Ywm6fxFApWxWHH6cIH73/N6WJYUuwMrBB7+oSSxjwHYjIwVz@vger.kernel.org
X-Gm-Message-State: AOJu0Yy87xJeUOUkWlO/PQKlWuaQuNWJ/GTkHZtw79tOKQkD/6NvTcqv
	ijhnUHhNumI8SriPojJ8KjUcb9uF11n1uo1dTJyG6NANCP+1eUgrcTf/LApbqTrlj5QPMqF1OPD
	PUbloZHFQ3UiMVyha1J8VznbQvszzWUYLswywi7cT6oXjxYxYYTM04a62nO2PuW0=
X-Gm-Gg: ASbGncutmItqwav2LMJ8bySP0f6RawKCDFDBwO4rb5jShuDpTCBpcNQrqShtmGL9VyL
	FXT0n6ARz+y5v+WbgziTLOuUygIJ0h84AgsWwNFWChL3O3zop+OGsRLtCddLReiGC+YOiRlbfIz
	QBpmxJ04dGCe5ldR5KYblAXqUw3bwhJH9f8vMbLvCJWVx5b2xSS7TH0dl8YDK3kIS8M/lQhLdhS
	6fIe46VMj0VD3I+SxkE6DUw0d8LqY5Pl4F0sR3Bk8ARbsr85afg+lzen69eK92s1NjoDmsg7rae
	LmJlPRTSSvikH7oYC1NSSNcvMnQt1RCg/ClUHHXclZGj0WuY1U0wt0sN6YiKb5Di3XdUs61CYdj
	4eeqjBJILwFmr9bjjJhlfMlDLNI7c2bUAQthkwGnef8Gj/IUnO2fQteoyXM3VTzxauAw=
X-Received: by 2002:a5d:64e6:0:b0:3cd:6cd:8c2 with SMTP id ffacd0b85a97d-3e765a22c28mr4163066f8f.60.1757699811031;
        Fri, 12 Sep 2025 10:56:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbQWWosXseBmiCDWHjZ+i8QCGCkijiPXS7J5DPAO7lPWNkZhPahOhzNwRV6nh+EFTyxM8bbQ==
X-Received: by 2002:a5d:64e6:0:b0:3cd:6cd:8c2 with SMTP id ffacd0b85a97d-3e765a22c28mr4163028f8f.60.1757699810512;
        Fri, 12 Sep 2025 10:56:50 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7c778f764sm1719041f8f.57.2025.09.12.10.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 10:56:49 -0700 (PDT)
Message-ID: <3f11cb3a-7f48-4fb8-a700-228fee3e4627@redhat.com>
Date: Fri, 12 Sep 2025 19:56:46 +0200
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/16] mm: add vma_desc_size(), vma_desc_pages()
 helpers
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
 Guo Ren <guoren@kernel.org>, Thomas Bogendoerfer
 <tsbogend@alpha.franken.de>, Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, "David S . Miller"
 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dan Williams <dan.j.williams@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Nicolas Pitre <nico@fluxnic.net>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
 Dave Young <dyoung@redhat.com>, Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Dave Martin <Dave.Martin@arm.com>, James Morse <james.morse@arm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Uladzislau Rezki <urezki@gmail.com>,
 Dmitry Vyukov <dvyukov@google.com>, Andrey Konovalov <andreyknvl@gmail.com>,
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, nvdimm@lists.linux.dev,
 linux-cxl@vger.kernel.org, linux-mm@kvack.org, ntfs3@lists.linux.dev,
 kexec@lists.infradead.org, kasan-dev@googlegroups.com,
 Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1757534913.git.lorenzo.stoakes@oracle.com>
 <5ac75e5ac627c06e62401dfda8c908eadac8dfec.1757534913.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <5ac75e5ac627c06e62401dfda8c908eadac8dfec.1757534913.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.09.25 22:21, Lorenzo Stoakes wrote:
> It's useful to be able to determine the size of a VMA descriptor range used
> on f_op->mmap_prepare, expressed both in bytes and pages, so add helpers
> for both and update code that could make use of it to do so.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   fs/ntfs3/file.c    |  2 +-
>   include/linux/mm.h | 10 ++++++++++
>   mm/secretmem.c     |  2 +-
>   3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
> index c1ece707b195..86eb88f62714 100644
> --- a/fs/ntfs3/file.c
> +++ b/fs/ntfs3/file.c
> @@ -304,7 +304,7 @@ static int ntfs_file_mmap_prepare(struct vm_area_desc *desc)
>   
>   	if (rw) {
>   		u64 to = min_t(loff_t, i_size_read(inode),
> -			       from + desc->end - desc->start);
> +			       from + vma_desc_size(desc));
>   
>   		if (is_sparsed(ni)) {
>   			/* Allocate clusters for rw map. */
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 892fe5dbf9de..0b97589aec6d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3572,6 +3572,16 @@ static inline unsigned long vma_pages(const struct vm_area_struct *vma)
>   	return (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
>   }
>   
> +static inline unsigned long vma_desc_size(struct vm_area_desc *desc)
> +{
> +	return desc->end - desc->start;
> +}
> +
> +static inline unsigned long vma_desc_pages(struct vm_area_desc *desc)
> +{
> +	return vma_desc_size(desc) >> PAGE_SHIFT;
> +}

Should parameters in both functions be const * ?

> +
>   /* Look up the first VMA which exactly match the interval vm_start ... vm_end */
>   static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
>   				unsigned long vm_start, unsigned long vm_end)
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 60137305bc20..62066ddb1e9c 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -120,7 +120,7 @@ static int secretmem_release(struct inode *inode, struct file *file)
>   
>   static int secretmem_mmap_prepare(struct vm_area_desc *desc)
>   {
> -	const unsigned long len = desc->end - desc->start;
> +	const unsigned long len = vma_desc_size(desc);
>   
>   	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
>   		return -EINVAL;

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


