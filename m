Return-Path: <linux-csky+bounces-722-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8D995900E
	for <lists+linux-csky@lfdr.de>; Tue, 20 Aug 2024 23:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FA7E1C20FDD
	for <lists+linux-csky@lfdr.de>; Tue, 20 Aug 2024 21:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E7C1C7B9E;
	Tue, 20 Aug 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="MwOAla87"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8217C1C6891
	for <linux-csky@vger.kernel.org>; Tue, 20 Aug 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724190998; cv=none; b=jHq9IDcJhvy3X68ZJ4nNXnbjV9TvYL964uf6ODnc10+1hvdGggd7DfE9ixS0xO4hVjwhuA1uWznoEnREi7AdERj4TcCnGfQEe2wPMsdysBy/sEwGxbwXQUCDQdpqxoUBmwjOZqpt8/WC9Eat9nXJ9yAblme3Y/3UlISR/WuXN44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724190998; c=relaxed/simple;
	bh=MQjzVsRoskVav5wmwGwVl6YY70G5XfPvo5+K1w/bqqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=guwQk+d7ISwi2fPm1juZrPLjnicnSzRj1MRyNC3M+bvpG2oLtqgQfvlXisHaLGheffEX9Bw0RQqQP0HtBpDlEZLx1xM2m6BuiNNNup5OY7AqdointxVDsrA++D99XgAsMS+gq9l5xJJZYFZPfunx+NCbckyeMZ/K1uWGyQ1XJvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net; spf=none smtp.mailfrom=landley.net; dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b=MwOAla87; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44ff6f3c427so31501321cf.1
        for <linux-csky@vger.kernel.org>; Tue, 20 Aug 2024 14:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1724190995; x=1724795795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eN6vzCvlT/pCItFp6f4PyJvyvmOiWowl22YtM6dmQFA=;
        b=MwOAla87+7deAUoxWzSqe9jkP64UWEslN9+NgkHu1cTUepEYEYSwn16PcYFBA40itR
         tV0KSR0os2UI9QcFh8ugX6AaTyIGzxY9Y6oOpeSpjTctfmZTgoQn2TQPJ/6TG7DKPYmw
         M6BUtBqmim2akOllY2DDNMaTxboZzZgVMA7smfsZxUrI1O8B5WxVIL6ehyUxKwFBBClF
         d5DXq/zaEK0uqaFG+LVvrnkC5q7Xxe5uN6M6UK1ie2v++ackwplFKP2YzmeSgAwHM3Ht
         jJ0I0sJ8ca8+l4mMzSYUNCr+YovFowTaBi0+pUUaE/JMa3T5cCgZ2BHMMwJAir8YHtUW
         rpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724190995; x=1724795795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eN6vzCvlT/pCItFp6f4PyJvyvmOiWowl22YtM6dmQFA=;
        b=CqWHTwy7orvf7wTULgd0Eow89U4aQgugj+uqpm+6K4+Hvo5UolZ7qlXRdaLA/DTz3x
         vAbdQxMDnBLw4wulVcSJ6WjNHN8CiNccjnI0XGyVi8Z5795QvrJYTfbQFigtPxaNkUYi
         LmVdCjp4Mj8i3uw9NZFNo0IWGVnNI99vhsTBUAermYUJ/XXcBKmFzJpVhOt1hiDnLBng
         2myAtRPeM3oRA+6dyOqdEyjugkvv9fO70INfD+plsTU0iZt2aAUIo3JsbsNkZy+JV+1E
         HMipWPBjl21/niJt2t2o5jtSehnwlLbtEXtWfQ/P6FQu1lguxRWIJc8PlYnd4pbnSyEr
         9F0g==
X-Forwarded-Encrypted: i=1; AJvYcCU++miGIj9IZsX4z4hF5EkaqC67R2ObbDirTYV1vg3LVyf8DoLqqUOBjP75CicfnZXNTDu+bnxtz6jA@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ILgUhsJmH9hobpu8yLwdyGrXQC1Cohp+e4J/moe/zdEtEqaY
	OVIv48kOxzCsB3I7hJ+2JviyXCEdkjHMgST18cnWYvVi1qr24UdK2ey5pw+xnR4=
X-Google-Smtp-Source: AGHT+IHXvZQTYbODvbtiWMvtKaWw7MfhUsJrv1XSsVar7SrJFLG58wKSOeDH8tFL+40SZRU1vcMC1A==
X-Received: by 2002:a05:622a:260b:b0:454:ec22:dd79 with SMTP id d75a77b69052e-454f2218babmr3430781cf.24.1724190995315;
        Tue, 20 Aug 2024 14:56:35 -0700 (PDT)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-454de4fa40esm18021631cf.21.2024.08.20.14.56.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 14:56:35 -0700 (PDT)
Message-ID: <67108df9-7374-a64e-ca82-8c46d67fb55b@landley.net>
Date: Tue, 20 Aug 2024 17:10:32 -0500
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/4] mm: Add optional close() to struct
 vm_special_mapping
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Chancellor <nathan@kernel.org>, Guo Ren <guoren@kernel.org>,
 Brian Cain <bcain@quicinc.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org,
 christophe.leroy@csgroup.eu, jeffxu@google.com, Liam.Howlett@oracle.com,
 linux-kernel@vger.kernel.org, npiggin@gmail.com, oliver.sang@intel.com,
 pedro.falcato@gmail.com, linux-um@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon <linux-hexagon@vger.kernel.org>,
 Linux-sh list <linux-sh@vger.kernel.org>
References: <20240812082605.743814-1-mpe@ellerman.id.au>
 <20240819185253.GA2333884@thelio-3990X>
 <CAHk-=wj9QPhG4CjiX8YLRC1wHj_Qs-T8wJi0WEhkfp0cszvB9w@mail.gmail.com>
 <20240819195120.GA1113263@thelio-3990X>
 <CAHk-=wgsDJ+sA1T01YT-z5TXs3zxJ54f0VDApkZ1pgcr8T=myQ@mail.gmail.com>
 <CAHk-=wjzYKrwSDK3PFMC1C2x37aKzEuC7dVxg0kGt8h+vjZfjQ@mail.gmail.com>
 <87y14rso9o.fsf@mail.lhotse>
 <CAHk-=wiS7PMtL6oR6acNgWZr0NN4Ax4PQD_CYJKCiKS0mT=Z7A@mail.gmail.com>
 <dff57198-7955-ec09-8909-671982834673@landley.net>
 <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
From: Rob Landley <rob@landley.net>
In-Reply-To: <CAHk-=wj78UV2ep6i5JZ-1qhLPZPHV4eUOtjWqqh_3zcqJ7pK-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/20/24 16:31, Linus Torvalds wrote:
> On Tue, 20 Aug 2024 at 14:17, Rob Landley <rob@landley.net> wrote:
>>
>> Hexagon also has &&vdso_page which I don't understand (but have a toolchain for
>> somewhere to at least smoketest...)
> 
> The '&&' is just a typo. It should obviously be just a single '&'. As
> mentioned, the only testing that patch got was a x86-64 UML build
> test.
> 
> Fixed locally.

I deleted the extra ; and arch/sh4 built and qemu-system-sh4 booted to shell prompt:

Freeing initrd memory: 556K
Freeing unused kernel image (initmem) memory: 132K
This architecture does not have kernel memory protection.
Run /init as init process
8139cp 0000:00:02.0 eth0: link up, 100Mbps, full-duplex, lpa 0x05E1
Type exit when done.
# cat /proc/version
Linux version 6.11.0-rc4 (landley@driftwood) (sh4-linux-musl-gcc (GCC) 11.2.0,
GNU ld (GNU Binutils) 2.33.1) #1 Tue Aug 20 16:45:25 CDT 2024
# head -n 3 /proc/cpuinfo
machine		: RTS7751R2D
processor	: 0
cpu family	: sh4

Tested-by: Rob Landley <rob@landley.net>

Rob

