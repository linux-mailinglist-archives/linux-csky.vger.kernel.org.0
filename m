Return-Path: <linux-csky+bounces-2270-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D75B4A830
	for <lists+linux-csky@lfdr.de>; Tue,  9 Sep 2025 11:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C93531887293
	for <lists+linux-csky@lfdr.de>; Tue,  9 Sep 2025 09:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB142D248C;
	Tue,  9 Sep 2025 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FIau1DiM"
X-Original-To: linux-csky@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D5E288CB5
	for <linux-csky@vger.kernel.org>; Tue,  9 Sep 2025 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757409992; cv=none; b=c3pKg+U5sShBXu21ROuUrJDJYxzDD77axcBhE590DRcwQOKatqwQn6Y/WIpxfqdouRWXzR9NaEEw13pr/RGP++3JBWx/TFPV8E2lLd1UmEhaxKKGUbv+XYgY1Pnn8ko5xrEwP4Qgl2XTw/Geuw9q1y5hkaUNjR/5tm8vUE8P3I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757409992; c=relaxed/simple;
	bh=CAjkASl3Kw0SHk511xgoj+VcTreDuYnw5V5zpEIPpvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bn3QJJ1oqHsBWQ6UV/yPm5fQHEE8r3HuLYZQCWpa5oKU3VHXmtIJKJBbwHKrKp7WQfIru6mtxUI/So8H5axQQ3Sp+JDJi+e72oTw+Al+Vk+jnx4675zF97UMWorwgPYobTWihqHkefk5HLxTuQgWD3lffzXmr+NcqT1u6rOWhR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FIau1DiM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757409988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OurCkvo8cRfbGgLYwYff0XkxeLDF9OohYudpKg0Q2Mc=;
	b=FIau1DiMRicThLT/pfqhL9J3pt0vKCPADedalRdVcVHY+xQLpcjraYrEv1qoJ6Wjy6lax2
	Ecu7jyrlW6ilgoiPCBkbFbbzgQh2DIuHQluLF9uRgjTKllhnCTBwUr0HghcHBvp64LkC6F
	/fHLYG9mJ42lv2SSnSOZkI7VVovbNrg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-4ssWfDzvM_-vXwcumfRmlg-1; Tue, 09 Sep 2025 05:26:27 -0400
X-MC-Unique: 4ssWfDzvM_-vXwcumfRmlg-1
X-Mimecast-MFC-AGG-ID: 4ssWfDzvM_-vXwcumfRmlg_1757409986
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3e753e78902so113795f8f.1
        for <linux-csky@vger.kernel.org>; Tue, 09 Sep 2025 02:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757409986; x=1758014786;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OurCkvo8cRfbGgLYwYff0XkxeLDF9OohYudpKg0Q2Mc=;
        b=tIYVscSxc/U3ov+Z3NE16pTtdY/lcGQSpjhWIUrobQT1+zCoCg4TuDr6DEwIhc8M8j
         Om5K87uVoHspiz+sZe8QvhEB8XwvZxSLtFeYTH8h4TSzNlIvPHf6gJQCzwS1q+8iWuu4
         4xcYesA/FsreHSBTb9ZpC+vXfyXL7stnuHszS0jYLNQZiY9D3vjH2M6OP/M9QCNK4Jc3
         kKrERbQuL6p66Nx0gzxEYy6rRkv0J+6HdBy3IY32bcR6N3wKWWX+M2qwUojPGOx7ngEI
         LtRBTnqN4KaeXE1u9BjBjpTTR3dYQiHjnrTTY0t1HeCIQb/ZFWGfPglmrXHNcw3YrG5M
         8b+g==
X-Forwarded-Encrypted: i=1; AJvYcCUHU7kkEkqAKColSPUPQq11Q5jIGS7rHwyt4JylYxssuNfKZuv4ayDizlfEglxE14mN09Yd+qo/oVtx@vger.kernel.org
X-Gm-Message-State: AOJu0YzRj0zWfstwTID/lhL4UK3N77RanS7gr0HRF3BgHQneVtRAr3BE
	3dDvpZNELwGBjjUSzFPGx2suIBTyF4fHFTFBesVM4z3KN/CHGxqu78GySAZPSthU0bFMQeFSg2K
	AVpEH2+OBZDuvr3YuXuw77C29r8HjVqBNhG7FRW7mB19/x6DHnPU/fb4mAeQ8gyM=
X-Gm-Gg: ASbGnctbMlRStKYA5Qbwp5vlJeZ/P0VZ7PcU9gK9ev8z7wZ2rQszIMYLN+5REBvy2yd
	G19/SHSCdKgN287gi3xGZKDbbkm71kv+98ggJzTRRa9q6YCOlC41VV2PPjC8rKwa9zS4HbHqtYE
	ENUSjODbdg9yioHWjb5HKWUZgKgAFkU3XibL6M95ZD2jvlrxlXge/5y++BuZWPdUPc5T79Lzxb9
	PJCIh+XgxlSc2q5vDq9fM+Iz0M3lShxVpG0O1unxr3RP+kAEUcwgMQK+lddLKv1nyywb/2XxQbk
	gYNa0r97CE0KycS4SrTIL3sJoNivfKFDNOpvuHFlc+i8uHTC/u+HzQNPDRnIVcjb3VUIoYUj0ja
	Bu/hrXZjFNjtmEcS3QEPVa3er62YpgshO/eE+hUvFPIyjrQk7KMPMA1wBxr0ZZN2Vw9k=
X-Received: by 2002:a05:6000:2f81:b0:3c8:d236:26bd with SMTP id ffacd0b85a97d-3e63736f01fmr10702021f8f.11.1757409985887;
        Tue, 09 Sep 2025 02:26:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFxR9lLCllY89SGP0DnTjf2QCQWH2LpNqo/3CEdj7ZBEWXvSf1n4XCUk73I9R4VihF1/vNGg==
X-Received: by 2002:a05:6000:2f81:b0:3c8:d236:26bd with SMTP id ffacd0b85a97d-3e63736f01fmr10701953f8f.11.1757409985314;
        Tue, 09 Sep 2025 02:26:25 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34? (p200300d82f239c00d1f6f7fe8f147e34.dip0.t-ipconnect.de. [2003:d8:2f23:9c00:d1f6:f7fe:8f14:7e34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e752238832sm1808267f8f.31.2025.09.09.02.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 02:26:24 -0700 (PDT)
Message-ID: <e882bb41-f112-4ec3-a611-0b7fcf51d105@redhat.com>
Date: Tue, 9 Sep 2025 11:26:21 +0200
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16] mm: introduce the f_op->mmap_complete, mmap_abort
 hooks
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>,
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
References: <cover.1757329751.git.lorenzo.stoakes@oracle.com>
 <ea1a5ab9fff7330b69f0b97c123ec95308818c98.1757329751.git.lorenzo.stoakes@oracle.com>
 <ad69e837-b5c7-4e2d-a268-c63c9b4095cf@redhat.com>
 <c04357f9-795e-4a5d-b762-f140e3d413d8@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <c04357f9-795e-4a5d-b762-f140e3d413d8@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.09.25 11:13, Lorenzo Stoakes wrote:
> On Mon, Sep 08, 2025 at 05:27:37PM +0200, David Hildenbrand wrote:
>> On 08.09.25 13:10, Lorenzo Stoakes wrote:
>>> We have introduced the f_op->mmap_prepare hook to allow for setting up a
>>> VMA far earlier in the process of mapping memory, reducing problematic
>>> error handling paths, but this does not provide what all
>>> drivers/filesystems need.
>>>
>>> In order to supply this, and to be able to move forward with removing
>>> f_op->mmap altogether, introduce f_op->mmap_complete.
>>>
>>> This hook is called once the VMA is fully mapped and everything is done,
>>> however with the mmap write lock and VMA write locks held.
>>>
>>> The hook is then provided with a fully initialised VMA which it can do what
>>> it needs with, though the mmap and VMA write locks must remain held
>>> throughout.
>>>
>>> It is not intended that the VMA be modified at this point, attempts to do
>>> so will end in tears.
>>>
>>> This allows for operations such as pre-population typically via a remap, or
>>> really anything that requires access to the VMA once initialised.
>>>
>>> In addition, a caller may need to take a lock in mmap_prepare, when it is
>>> possible to modify the VMA, and release it on mmap_complete. In order to
>>> handle errors which may arise between the two operations, f_op->mmap_abort
>>> is provided.
>>>
>>> This hook should be used to drop any lock and clean up anything before the
>>> VMA mapping operation is aborted. After this point the VMA will not be
>>> added to any mapping and will not exist.
>>>
>>> We also add a new mmap_context field to the vm_area_desc type which can be
>>> used to pass information pertinent to any locks which are held or any state
>>> which is required for mmap_complete, abort to operate correctly.
>>>
>>> We also update the compatibility layer for nested filesystems which
>>> currently still only specify an f_op->mmap() handler so that it correctly
>>> invokes f_op->mmap_complete as necessary (note that no error can occur
>>> between mmap_prepare and mmap_complete so mmap_abort will never be called
>>> in this case).
>>>
>>> Also update the VMA tests to account for the changes.
>>>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>>    include/linux/fs.h               |  4 ++
>>>    include/linux/mm_types.h         |  5 ++
>>>    mm/util.c                        | 18 +++++--
>>>    mm/vma.c                         | 82 ++++++++++++++++++++++++++++++--
>>>    tools/testing/vma/vma_internal.h | 31 ++++++++++--
>>>    5 files changed, 129 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>>> index 594bd4d0521e..bb432924993a 100644
>>> --- a/include/linux/fs.h
>>> +++ b/include/linux/fs.h
>>> @@ -2195,6 +2195,10 @@ struct file_operations {
>>>    	int (*uring_cmd_iopoll)(struct io_uring_cmd *, struct io_comp_batch *,
>>>    				unsigned int poll_flags);
>>>    	int (*mmap_prepare)(struct vm_area_desc *);
>>> +	int (*mmap_complete)(struct file *, struct vm_area_struct *,
>>> +			     const void *context);
>>> +	void (*mmap_abort)(const struct file *, const void *vm_private_data,
>>> +			   const void *context);
>>
>> Do we have a description somewhere what these things do, when they are
>> called, and what a driver may be allowed to do with a VMA?
> 
> Yeah there's a doc patch that follows this.

Yeah, spotted that afterwards.

> 
>>
>> In particular, the mmap_complete() looks like another candidate for letting
>> a driver just go crazy on the vma? :)
> 
> Well there's only so much we can do. In an ideal world we'd treat VMAs as
> entirely internal data structures and pass some sort of opaque thing around, but
> we have to keep things real here :)

Right, we'd pass something around that cannot be easily abused (like 
modifying random vma flags in mmap_complete).

So I was wondering if most operations that driver would perform during 
the mmap_complete() could be be abstracted, and only those then be 
called with whatever opaque thing we return here.

But I have no feeling about what crazy things a driver might do. Just 
calling remap_pfn_range() would be easy, for example, and we could 
abstract that.

-- 
Cheers

David / dhildenb


