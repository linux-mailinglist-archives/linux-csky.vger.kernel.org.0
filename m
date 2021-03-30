Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15F234E0E4
	for <lists+linux-csky@lfdr.de>; Tue, 30 Mar 2021 07:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhC3Fyg (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 30 Mar 2021 01:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhC3FyU (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 30 Mar 2021 01:54:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58934C061764
        for <linux-csky@vger.kernel.org>; Mon, 29 Mar 2021 22:54:20 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id v10so10899457pgs.12
        for <linux-csky@vger.kernel.org>; Mon, 29 Mar 2021 22:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=C/GOnzGh3SqlPD+cVcmlRhjiUhMBfsMKLeWTg6MJ7jY=;
        b=j6+00ZGEEZ1AP2f/5GfoGcA0GsMEI6/C21ZD0lbg/XP4wPkwJoYipktdJubitpgDP+
         wgcah0URjkl6AYXpG9cgWLRGXBLiMfR52o6o689Vreh0v+Lt7OvC8x1fB/5TTyRzxVF8
         +IX08t8qK8hY6fl+cjZgCAcCHu+878OR2plvgVpyscHGsghufy9UmaGd89FOrEUlPan9
         nG9gH1rRhXzv6eObqA1GS+3olKEarHx9O2bHn0GxV3LgaIXJwqlzB7vaHg7mDPBfn74V
         M9q/5gFNLQPxJVxCGZV+Bo3GZhwX1ibxendhmE+iRq4Ugx4AwkIkXrvScKbd4CD2siGj
         TIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=C/GOnzGh3SqlPD+cVcmlRhjiUhMBfsMKLeWTg6MJ7jY=;
        b=lsr83+ePySNa30nzLjRMfAGm5aXZ9+nDZc37rzJYQomPn/KnMHktngdXa5W6zuAEHK
         Sjh32q62mno3VIEF2gIAzP0As2JnDqNHQoRvvgw/nlw/TCSQx6D/xYY1Z0ufccf+V3r1
         fYisGXnodo5ZL8ps/vIfRB7H5F9bfS4usE7fHseNizLvD8LYdRN5cew4Rko5jUUrBmB6
         j5n3fb0bWf5/CoaDRpGgRasb3bNbWz/1B5PZGPxUNFQf7HF0UMHxG+CS3C69+GxQEoVC
         zOO3KQAwITrgwBQXIT8D9WN/3OMx66GXrXtvY6AceyH1NFBzcw1iR9bu7nqsLOunGilr
         SaEg==
X-Gm-Message-State: AOAM531vZPtjwgmMnnUP+R0cGBSI0CX6Yg+gULaCxv9BhoZWc2kmEUEJ
        0xNkpkC/HVttjws6jW3hoKqdJg==
X-Google-Smtp-Source: ABdhPJw/6ycpvDSr4lA7omfOMiOjOM0m49OLwTpyVDudwQ7+YSNbP232TmXlPl85GjuTFN0yM22rIg==
X-Received: by 2002:a63:1921:: with SMTP id z33mr27276370pgl.211.1617083659752;
        Mon, 29 Mar 2021 22:54:19 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id x22sm12044732pfa.24.2021.03.29.22.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 22:54:19 -0700 (PDT)
Date:   Mon, 29 Mar 2021 22:54:19 -0700 (PDT)
X-Google-Original-Date: Mon, 29 Mar 2021 22:54:11 PDT (-0700)
Subject:     Re: [PATCH] ftrace: Fix spelling mistake "disabed" -> "disabled"
In-Reply-To: <20210317094223.34797d5d@gandalf.local.home>
CC:     colin.king@canonical.com, guoren@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     rostedt@goodmis.org
Message-ID: <mhng-54032ff9-fc8d-48fb-87a0-ff075313d077@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Wed, 17 Mar 2021 06:42:23 PDT (-0700), rostedt@goodmis.org wrote:
> On Tue, 16 Mar 2021 21:21:08 -0700 (PDT)
> Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
>> Thanks, this is on fixes.
>
> What does this mean? Is there a tree that spelling fixes go through now?
>
> I had already pulled this patch into my queue for the next merge window
> (and it's still in the testing phase with other patches before going to
> linux-next).
>
> Should I drop it?

Oh, sorry.  It's on the fixes branch of the riscv tree 
<https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git> .  
It's what I sent up to Linus every week, this one already went up.

I must have not been looking closely enough, for some reason I thought 
this only touched the riscv tree.  I wouldn't have taken it without an 
Ack if I'd noticed, I guess just because it was only a comment spelling 
change I hadn't checked the paths.  I'll try not to do that again.
