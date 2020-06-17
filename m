Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BA41FD5A6
	for <lists+linux-csky@lfdr.de>; Wed, 17 Jun 2020 21:58:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbgFQT6O (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 17 Jun 2020 15:58:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58253 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726941AbgFQT6O (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 17 Jun 2020 15:58:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592423892;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gmJWpSwHVjxD6GXTAJ69IeIkc8fh7DM3r6hkTC0cWeE=;
        b=VgA8Zy7wMoR/1lzsmCN9WMUvteeUwIUoVLkS0gQqhtb3Z6RhHsuuTEKG5rFV9/rihnLKi1
        sTsaFJqwhedVbsjHshw2kyfyBI+ZJVAfrBuvcKQ+ySH0y6U6tYVndohsj8lxMGh+YLnNej
        +zHEQ2w9OFfW6+4Q0RRh+MfVX8L1OwA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-YYNBfwHPOQGdDDpH7tr3Mg-1; Wed, 17 Jun 2020 15:58:10 -0400
X-MC-Unique: YYNBfwHPOQGdDDpH7tr3Mg-1
Received: by mail-qv1-f71.google.com with SMTP id a8so2422931qvt.7
        for <linux-csky@vger.kernel.org>; Wed, 17 Jun 2020 12:58:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gmJWpSwHVjxD6GXTAJ69IeIkc8fh7DM3r6hkTC0cWeE=;
        b=SwUIuqFVIK9c4nbpYW3Spm1ataBodUNOJ+gaHgW8w8pWVKjG/d/vUwNsGF4tDwYrPS
         OReSc0GNYVkGVqwGinunO1CRZtIFD5dbT0sFfuvLNp0qE+7/45w8oj8broaGKM6bJ+m3
         eZ+JrfHoMLz/Sr2VAo56xAhjwuEvhFG7uPItAwHO1QMUHD0X8+/PihSxumGXdiGSKe2I
         cFjtZ+rVTgNq7COtLrxNzdss3IcEqtoD8vjW0ggGjJ7tiOgJyg4ADrN3XFZR2XaSevKv
         PFM7JFgtu75ee8KRV4Yti8IqfYzULCF27qb2AtaKZTOcmxkat9Cn1MnWF5v7Es5b1N7u
         +Ieg==
X-Gm-Message-State: AOAM533rG6eM5ucm0Du0Y+SLR5jtKVYGeD65xAkyI/lUyoyheA3c68Yg
        OXQm5DLzAA0syqAPXvlX/Z/Rdq/L1O95jIQo/kDth0b9cBdYjeQ+wJPS6JyKuDWwVFjPYX148xB
        khYpVv5pflWj8v6YiYIULag==
X-Received: by 2002:a05:620a:218b:: with SMTP id g11mr302082qka.251.1592423890285;
        Wed, 17 Jun 2020 12:58:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwcgg+y34wH1kZsiZl1638g4VhObYVYEjy0Zq1p0HEwGO4go5ztwMhAOlTkmaJl++mH9IdRGQ==
X-Received: by 2002:a05:620a:218b:: with SMTP id g11mr302063qka.251.1592423890039;
        Wed, 17 Jun 2020 12:58:10 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id y19sm837132qki.19.2020.06.17.12.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 12:58:08 -0700 (PDT)
Date:   Wed, 17 Jun 2020 15:58:07 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guo Ren <guoren@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH 07/25] mm/csky: Use mm_fault_accounting()
Message-ID: <20200617195807.GH76766@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615221607.7764-8-peterx@redhat.com>
 <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
 <20200617154925.GC76766@xz-x1>
 <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Wed, Jun 17, 2020 at 10:53:23AM -0700, Linus Torvalds wrote:
> On Wed, Jun 17, 2020 at 8:49 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > I don't think it's a must, but mmap_sem should not be required at least by
> > observing current code.  E.g., do_user_addr_fault() of x86 does the accounting
> > without mmap_sem even before this series.
> 
> All the accounting should be per-thread and not need any locking.
> 
> Which is why a remote GUP should never account to the remote mm - not
> only isn't there an unambiguous thread to account to (an mm can share
> many threads), but it would require locking not just for the remote
> update, but for all normal page faults.

But currently remote GUP will still do the page fault accounting on the remote
task_struct, am I right?  E.g., when the get_user_pages_remote() is called with
"tsk != current", it seems the faultin_page() will still do maj_flt/min_flt
accounting for that remote task/thread?

Thanks,

-- 
Peter Xu

