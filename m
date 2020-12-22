Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD74C2E0F61
	for <lists+linux-csky@lfdr.de>; Tue, 22 Dec 2020 21:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727245AbgLVUa3 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 22 Dec 2020 15:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726825AbgLVUa3 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 22 Dec 2020 15:30:29 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0ECC061793
        for <linux-csky@vger.kernel.org>; Tue, 22 Dec 2020 12:29:48 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id be12so8007537plb.4
        for <linux-csky@vger.kernel.org>; Tue, 22 Dec 2020 12:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=1uYO5gb8l22kkJBNYBKF4BpoBbkwVbyfFkGg5GIkRf8=;
        b=tNmThOcEL3wKkZ/mser/opC9H2K0uIdWblQmaWHo8rNKGuNVPu8tXaPsuRFzmdKCrF
         a+izjHmcd+U1nb/pimozzgs5HERTz7g6Wr/7SUbQeJyOkXfuSOb4sDDSbfQ9UcjoOqN0
         7R+ohRlSK+d313ZwjIOUC2VIW8TPuzP2T57c3WSSs0VfoiZ6/U9dHiB5ok9SwAFQDsnM
         lJ31iul44tafXtXpPAZ8Hwo81i7r5EclBr4kOnRfCLeDQToIdU6uRFvLT5K+Rs6f6MC2
         WIalUN5TLkuC+QGy998xOucT0sMwnTYOyyU1Y2lxVHZRlIWP5dzO5Z8xfL+TaLZ3O+YG
         fDqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=1uYO5gb8l22kkJBNYBKF4BpoBbkwVbyfFkGg5GIkRf8=;
        b=ruqXA7v2veXEsySqpOti6m4oFCoAOZ93pzKJDHrKMd/6XLsYhnygQyURLnBwgOqrsL
         i+uP65Y7i4FwDs0V8puGKpL6N4IFOH/dTLBgMSf6cfH3UZnhg4IglTZgFP08XUwfyZPB
         QDFbG1B2wGrvB1qNKqU9213CjW/syQTbakYjENIRHhFNVF22CrVegwdZdYMLbiMSqrJk
         cZujuGuNvRjQedw4PopeMAbhbLDh+0N4AKvfSJ1rYHtgTEyxj8umKruKzCHTC9++7+y4
         Z1YIKosSERZ2EDGOfW0H8F9xD2K7A1o48kj1kjtMRcC9myivcmy4urC06bhgGm0Z7Kv0
         6c3A==
X-Gm-Message-State: AOAM533nsHrnbjT4Piu8/FEp3oUmhebcSyrEjem0e2h8qfrmQkTuuyGp
        4iWHH/wjopI9Y+648sPTleY4K+3BJADlGhmOIVCRkQ==
X-Google-Smtp-Source: ABdhPJz9swd7VzUDCz8TW/NXCMcoXhe/xUMJYDX4nWy7LSE9Qfj3Td/x1Z2lL6L9RlJEcG+cRmpmGWG0OutDg8kxofo=
X-Received: by 2002:a17:902:26a:b029:da:af47:77c7 with SMTP id
 97-20020a170902026ab02900daaf4777c7mr22812796plc.10.1608668988122; Tue, 22
 Dec 2020 12:29:48 -0800 (PST)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 22 Dec 2020 12:29:37 -0800
Message-ID: <CAKwvOdmnhsPU0UA9uEd1HTQ_yoBO8h741+sKrtebcPsXpXn8_g@mail.gmail.com>
Subject: building csky with CC=clang
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-csky@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Hello!
I was playing with some of LLVM's experimental backends (m68k) and saw
there was a CSKY backend. I rebuilt LLVM to support CSKY, but I ran
into trouble building the kernel before even getting to the compiler
invocation:

$ ARCH=csky CROSS_COMPILE=csky-linux-gnu- make CC=clang -j71 defconfig
...
scripts/Kconfig.include:40: linker 'csky-linux-gnu-ld' not found

My distro doesn't package binutils-csky-linux-gnu, is there
documentation on how to build the kernel targeting CSKY, starting with
building GNU binutils configured with CSKY emulation?
-- 
Thanks,
~Nick Desaulniers
