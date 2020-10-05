Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00F82283CA1
	for <lists+linux-csky@lfdr.de>; Mon,  5 Oct 2020 18:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgJEQjx (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Mon, 5 Oct 2020 12:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgJEQjx (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Mon, 5 Oct 2020 12:39:53 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCE2C0613CE
        for <linux-csky@vger.kernel.org>; Mon,  5 Oct 2020 09:39:53 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id w21so7283282pfc.7
        for <linux-csky@vger.kernel.org>; Mon, 05 Oct 2020 09:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bgKuiZru+fzYOW+rknHpx1Qb/5rCkL8zdBgqBiopZMo=;
        b=l6LKrMfjBVohHwxF9jv9cqtVCwnHkEr5vlQIuvPbeEgaOLBzDUY+wRtP25s/t70Hhk
         5kWV73hIpokOwi1l3tHFPB2vRCReQJOQ4ip2SfbDgwGkEVVTeChIsI38ZzqFLsIBYJ54
         Co2LtOtfJKXU4ezUVwnCkRZlXHoLRNgYZANjYnRB2g2PAYqQGWe+iLcKStDvNMwo9wl4
         2IEPUjd/4a30CwRyaXqR5Y/7BZTsWDS/rqJ5l9ENklSFMXLNAF4CIFlDSZ3Q4xVN9M0O
         H3omOE7p1NxvhbLbxwFC1f0wKnxwTlqnG1HOfQuubft5h5kKaYf0aCI7hgPx+yG0l8YJ
         X32g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bgKuiZru+fzYOW+rknHpx1Qb/5rCkL8zdBgqBiopZMo=;
        b=qSouQwFan/iA9Dq80Tx7aWzM3xuv/47lItHQgv6+KrwDPvD95F+loVmIgSaudi/njm
         1qw/2Or0mRYKxq1DQ4bSIsvhA6wzoO3mSkq1sxgLXvPpylni2hqB95pIMZtMauV0nggf
         IKsDkOXDKrxNUx9hKqq4LJ2NKew62AUKUM10/alMNKBsCKKIC/isW35OqsRZPIbYIFYI
         rh3YczrmTKPV3mokJoBc8N7RWqRF8F4DAPyh//swTyFc2w0fxJIiGpEVbpCnZO1t5LPd
         i1K45MuHSwXmExZtDZYJQbLdIYUB9060x+SPeZXlOPy8H0zpCsY/9DzR6/xIaOS8Zm8B
         92eg==
X-Gm-Message-State: AOAM533r7EkbUFaUwDoxt88s2hbY69BzheQpbZUb6UnzkpTuCcNYvc2Z
        kyK7h65VKM43Y/bqe8lr0jnT1A==
X-Google-Smtp-Source: ABdhPJzscDCmybkxTYMeNPHRJvgED0ZxQ648JzxM13dAod0j3fjEo4NfbnuwNAzcN1JII0PYa0oCnw==
X-Received: by 2002:a05:6a00:1356:b029:13e:5203:fba3 with SMTP id k22-20020a056a001356b029013e5203fba3mr565585pfu.3.1601915992319;
        Mon, 05 Oct 2020 09:39:52 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z9sm418686pfk.118.2020.10.05.09.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 09:39:51 -0700 (PDT)
Date:   Mon, 05 Oct 2020 09:39:51 -0700 (PDT)
X-Google-Original-Date: Mon, 05 Oct 2020 09:39:45 PDT (-0700)
Subject:     Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
In-Reply-To: <87lfglt6z1.fsf@igel.home>
CC:     guoren@kernel.org, Paul Walmsley <paul.walmsley@sifive.com>,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        aou@eecs.berkeley.edu, tglx@linutronix.de, tycho@tycho.ws,
        nickhu@andestech.com, linux-riscv@lists.infradead.org,
        guoren@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     schwab@linux-m68k.org
Message-ID: <mhng-847e71cf-64bc-464b-8d09-3bcec40aa491@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Mon, 05 Oct 2020 01:25:22 PDT (-0700), schwab@linux-m68k.org wrote:
> On Sep 14 2020, Aurelien Jarno wrote:
>
>> How should we proceed to get that fixed in time for 5.9? For the older
>> branches where it has been backported (so far 5.7 and 5.8), should we
>> just get that commit reverted instead?
>
> Why is this still broken?

Sorry, I hadn't seen this.  I'm not seeing a boot failure on 5.9-rc8 with just
CONFIG_HARDENED_USERCPOY=y in addition to defconfig (on QEMU, though I doubt
that's relevant here).  It looks like the fix is to essentially revert this,
which I'm fine with, but I'd prefer to have a failing test to make sure this
doesn't break again.

Guo: I don't see an actual patch (signed off and such) posted for this, do you
mind posting one?  Otherwise I'll take a crack at constructing the revert
myself.
