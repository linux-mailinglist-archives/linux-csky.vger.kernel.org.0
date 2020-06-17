Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB881FD5D8
	for <lists+linux-csky@lfdr.de>; Wed, 17 Jun 2020 22:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbgFQUPw (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 17 Jun 2020 16:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgFQUPw (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 17 Jun 2020 16:15:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A1FC061755
        for <linux-csky@vger.kernel.org>; Wed, 17 Jun 2020 13:15:51 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y11so4475716ljm.9
        for <linux-csky@vger.kernel.org>; Wed, 17 Jun 2020 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lI2Hh6Mc9lbq4P5SHOG2frOmNNisPciXDqLrKSi5quQ=;
        b=JRwdzkhIJDOrMpfZT45E/imRK0NnwIAVZMsxXA24BPG2uMtTMCs/0ZlIDtBzN/to8U
         +fuq9YHs51ZvvXMgQga51CzGBHv7TMJSAp8h9UUfFnVJRxBiZnIV+x52Ui634biatVxH
         mVXJrjlsQ3cjNy4mSkfNPuGE+YInAkmPcl62E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lI2Hh6Mc9lbq4P5SHOG2frOmNNisPciXDqLrKSi5quQ=;
        b=nRsCROmStesFUXnN8JiVPEh+OP/zoSHo+CurWKR/niRLPXXUwIaCq7nzAWW/TJwGnh
         Hbe6DQygdXPHb9Bg0PqcDCJ6G0MCwbU2d93BqhRAUgzDVVlQKsibfimSVmYz55WfYkyp
         9wgebpU5mEH/o0EpYt5vAYbz59w7LvY0Y2lP1J7hryEmFihUOwqFgjhiFfX5EV2kzoKZ
         WB4Ws4Ev2cdWls8jkoeJAnkw+1cN6dQv+PZR6Q9Aisjsf4xymGvxZeLrwPHmJx6Eko9c
         HCQStHLHi34Hkfa9/oD+u9SQLpDUH4jBZfZPQQjXkDgS0SgQjpSgTn7Ku87IqiY5fRbJ
         rPNg==
X-Gm-Message-State: AOAM531JjvFiXllnTa2vlfeemuC7BwXu9zidzDls8R/7AZWLUni8NWLv
        SA8kXrOPghC3C153PMXn6gzIXJK9Soo=
X-Google-Smtp-Source: ABdhPJzhorP57ZyWjEy14hOJFf/8mk7ZrLXxzWBvbhVRBdncmUtiu2yCIG8lfPvLTtaXQLImxOZszA==
X-Received: by 2002:a2e:2202:: with SMTP id i2mr486982lji.199.1592424949393;
        Wed, 17 Jun 2020 13:15:49 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id m13sm158463ljj.20.2020.06.17.13.15.48
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 13:15:48 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id n24so4455762lji.10
        for <linux-csky@vger.kernel.org>; Wed, 17 Jun 2020 13:15:48 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr505029ljn.285.1592424947773;
 Wed, 17 Jun 2020 13:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200615221607.7764-1-peterx@redhat.com> <20200615221607.7764-8-peterx@redhat.com>
 <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
 <20200617154925.GC76766@xz-x1> <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
 <20200617195807.GH76766@xz-x1>
In-Reply-To: <20200617195807.GH76766@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Jun 2020 13:15:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com>
Message-ID: <CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com>
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

On Wed, Jun 17, 2020 at 12:58 PM Peter Xu <peterx@redhat.com> wrote:
>
> But currently remote GUP will still do the page fault accounting on the remote
> task_struct, am I right?  E.g., when the get_user_pages_remote() is called with
> "tsk != current", it seems the faultin_page() will still do maj_flt/min_flt
> accounting for that remote task/thread?

Well, that would be a data race and fundamentally buggy.

It would be ok with something like ptrace (which only works when the
target is quiescent), but is completely wrong otherwise.

I guess it works fine in practice, and it's only statistics so even if
you were to have a data race it doesn't much matter, but it's
definitely conceptually very very wrong.

The fault stats should be about who does the fault (they are about the
_thread_) not about who the fault is done to (which is about the
_mm_).

Allocating the fault data to somebody else sounds frankly silly and
stupid to me, exactly because it's (a) racy and (b) not even
conceptually correct. The other thread literally _isn't_ doing a major
page fault, for crissake!

Now, there are some actual per-mm statistics too (the rss stuff etc),
and it's fundamentally harder exactly because of the shared data. See
the mm_counter stuff etc. Those are not about who does soemthing, they
are about the resulting MM state.

            Linus
