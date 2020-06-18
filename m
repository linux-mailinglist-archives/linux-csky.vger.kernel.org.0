Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93471FF9FC
	for <lists+linux-csky@lfdr.de>; Thu, 18 Jun 2020 19:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgFRRQP (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 18 Jun 2020 13:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727926AbgFRRQL (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 18 Jun 2020 13:16:11 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4606AC0613ED
        for <linux-csky@vger.kernel.org>; Thu, 18 Jun 2020 10:16:10 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so8196201ljc.8
        for <linux-csky@vger.kernel.org>; Thu, 18 Jun 2020 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r9B0DNNPzxgoPyAfRSYd3ZQODRChafMlEGcqG+QaP/o=;
        b=h52vOHaaEhC9DvyZeZVKRtkDsBNc1neXdsILt1AApD0+khpSnxXAdCDCgo2wU3M5h7
         PqD+tj2/3V6xVGY6ZCNUt1yeLJK2Pu5VDp9eAPX+IIHX7MqgaSDAH7sE1O3E7CEu8V+p
         RkBxiIt06D883sHelU68GdNIffT6LEJn+15dI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r9B0DNNPzxgoPyAfRSYd3ZQODRChafMlEGcqG+QaP/o=;
        b=COFDYCan83aB3evJ1tNT9ltIGRwtg+0Y4w3nVmKxN66MZxvNfVfZtWH+8h43ck9VS2
         AvK/+F44ZKmBrbExBMn84BgYztaqSZ/zGybmG6imeMjXsSFJAVdeYxzLkyQOHihzEROM
         F0ekyAyq6qt76i+2byAmM2DutAHcpLrcCsI8iUaOwxowQYYjQOri3ARZQfTQI/YNtVkR
         6L49B6bVVeFAVuTiWHB6l0+ib0bx2KTipdsXrdFzjNsRlN1lzFIJ2au35u3WCVdJYx+F
         XEYizA/b14pmBBdItc8y6BMXX7xYEMnY0x1MwfZIKDF5w4cf9xnEzNTDGJB+NPztrFWk
         Wr2w==
X-Gm-Message-State: AOAM532vDEYfXShq14gGWuGxZ9Xb//zVeOL80zCk4PL/t8XGIWdjxOEO
        g8orx0oZKTeWbuoBMxoRBaWXoS2h/z0=
X-Google-Smtp-Source: ABdhPJxa65S4MgXJ9nZbDg+UajGM3JYBvBOsEMZZma+h85sCyEIfTuB4PISFrp4haVYZL95pqVTuHw==
X-Received: by 2002:a05:651c:299:: with SMTP id b25mr3107213ljo.13.1592500568567;
        Thu, 18 Jun 2020 10:16:08 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id m15sm728481ljc.129.2020.06.18.10.16.07
        for <linux-csky@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 10:16:07 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id m26so3913407lfo.13
        for <linux-csky@vger.kernel.org>; Thu, 18 Jun 2020 10:16:07 -0700 (PDT)
X-Received: by 2002:ac2:4422:: with SMTP id w2mr2864426lfl.152.1592500566754;
 Thu, 18 Jun 2020 10:16:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200615221607.7764-1-peterx@redhat.com> <20200615221607.7764-8-peterx@redhat.com>
 <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
 <20200617154925.GC76766@xz-x1> <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
 <20200617195807.GH76766@xz-x1> <CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com>
 <20200618143801.GK76766@xz-x1>
In-Reply-To: <20200618143801.GK76766@xz-x1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Jun 2020 10:15:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=whFEZbTJZaNwEkyevUV2aqRwbeVmtp6hhk1sK2mW4vaGA@mail.gmail.com>
Message-ID: <CAHk-=whFEZbTJZaNwEkyevUV2aqRwbeVmtp6hhk1sK2mW4vaGA@mail.gmail.com>
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

On Thu, Jun 18, 2020 at 7:38 AM Peter Xu <peterx@redhat.com> wrote:
>
> GUP needs the per-task accounting, but not the perf events.  We can do that by
> slightly changing the new approach into:
>
>         bool major = (ret & VM_FAULT_MAJOR) || (flags & FAULT_FLAG_TRIED);
>
>         if (major)
>                 current->maj_flt++;
>         else
>                 current->min_flt++;
>
>         if (!regs)
>                 return ret;
>
>         if (major)
>                 perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1, regs, address);
>         else
>                 perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1, regs, address);

Ack, I think this is the right thing to do.

No normal situation will ever notice the difference, with remote
accesses being as rare and specialized as they are. But being able to
remote the otherwise unused 'tsk' parameter sounds like the right
thing to do too.

It might be worth adding a comment about why.

Also, honestly, how about we remove the 'major' variable entirely, and
instead make the code be something like

        unsigned long *flt;
        int event_type;
        ...

        /* Major fault */
        if ((ret & VM_FAULT_MAJOR) || (flags & FAULT_FLAG_TRIED)) {
                flt = &current->maj_flt;
                event_type = PERF_COUNT_SW_PAGE_FAULTS_MAJ;
        } else {
                flt = &current->min_flt;
                event_type = PERF_COUNT_SW_PAGE_FAULTS_MIN;
        }
        *flt++;
        if (regs)
                perf_sw_event(event_type, 1, regs, address);

instead. Less source code duplication, and I bet it improves code
generation too.

             Linus
