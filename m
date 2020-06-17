Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6E41FD3C8
	for <lists+linux-csky@lfdr.de>; Wed, 17 Jun 2020 19:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgFQRxq (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 17 Jun 2020 13:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbgFQRxn (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 17 Jun 2020 13:53:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C1CC06174E
        for <linux-csky@vger.kernel.org>; Wed, 17 Jun 2020 10:53:43 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n24so3942611lji.10
        for <linux-csky@vger.kernel.org>; Wed, 17 Jun 2020 10:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sB1OuBZA7DtTPT+JKpS9ljNrWqiq79YyA1UBAjPiLg=;
        b=SqBvh/YZgdjQM5HMhNcsKSD2rQ13XdBGTz+sfY2UTr8t7HpuWrbXaEzHHY5W5EYGRm
         f9Bx5l7AXegybXBFlj9eOK2b5YUyGkv06DlkcI5Uq54Y8Pk3IjUVd5IQbuZHh9g40Vfk
         4ihMpPOayhZWKB4r2JP3qCH6wyygzsJEN64Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sB1OuBZA7DtTPT+JKpS9ljNrWqiq79YyA1UBAjPiLg=;
        b=sWZrrhoZkNvxeCFqLqL4J7ucn6C0EZPEsmwzK8qN0vXKE3yhbzbJysFrvfUyDfDHzj
         pUnv2Mi7CU7Nt4BReRrvU6HtWTCASfeALK2waYfxT4ExrnHxW/jABq4L7XGvX/Hnmz4n
         gu4mIbqwM9jLZBJAVfmr6quH0E6Oh88d0WgH+RKZzpVIg0kOU4UKyI+mSm6i58keASDG
         Klc2u8IPxlWVSVXF+xHE0DxXFS1mFmgl4BdFPcz12pDxrpl0S0ZUhzYp+MAAJIadkHWv
         1mAqGsPb0km5fy5R3uALd1gT1x3YK2qKCjg0RdzXH1BkGsUN85yQrFSxKtxz3MpMbZJC
         Iraw==
X-Gm-Message-State: AOAM531+1azo0QQ5jbR/knU8n56GibNKAg0V4qGsmgsDc6S9It+fRrHn
        kdAJvUv1X28fC4giBm1heJ+RZ3cqavw=
X-Google-Smtp-Source: ABdhPJxvJwQm3PqzcZGFd3nKXEQpQXMUmNGtZALNas0760sfkg39bREkSmIdOWeKBbhUYbWNFvRnFQ==
X-Received: by 2002:a2e:8744:: with SMTP id q4mr218441ljj.91.1592416421173;
        Wed, 17 Jun 2020 10:53:41 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id t16sm17644ljo.22.2020.06.17.10.53.40
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 10:53:40 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id x18so3996098lji.1
        for <linux-csky@vger.kernel.org>; Wed, 17 Jun 2020 10:53:40 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr222760ljn.70.1592416419967;
 Wed, 17 Jun 2020 10:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200615221607.7764-1-peterx@redhat.com> <20200615221607.7764-8-peterx@redhat.com>
 <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com> <20200617154925.GC76766@xz-x1>
In-Reply-To: <20200617154925.GC76766@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Jun 2020 10:53:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
Message-ID: <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
Subject: Re: [PATCH 07/25] mm/csky: Use mm_fault_accounting()
To:     Peter Xu <peterx@redhat.com>
Cc:     Guo Ren <guoren@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-csky@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Wed, Jun 17, 2020 at 8:49 AM Peter Xu <peterx@redhat.com> wrote:
>
> I don't think it's a must, but mmap_sem should not be required at least by
> observing current code.  E.g., do_user_addr_fault() of x86 does the accounting
> without mmap_sem even before this series.

All the accounting should be per-thread and not need any locking.

Which is why a remote GUP should never account to the remote mm - not
only isn't there an unambiguous thread to account to (an mm can share
many threads), but it would require locking not just for the remote
update, but for all normal page faults.

                 Linus
