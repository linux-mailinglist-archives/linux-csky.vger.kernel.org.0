Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D3D276AE4
	for <lists+linux-csky@lfdr.de>; Thu, 24 Sep 2020 09:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgIXHgf (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 24 Sep 2020 03:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbgIXHgc (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 24 Sep 2020 03:36:32 -0400
Received: from mail-out.m-online.net (mail-out.m-online.net [IPv6:2001:a60:0:28:0:1:25:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FD6C0613CE
        for <linux-csky@vger.kernel.org>; Thu, 24 Sep 2020 00:36:32 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4Bxn0p4dj1z1rtZW;
        Thu, 24 Sep 2020 09:36:25 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4Bxn0n4X4Kz1qyXD;
        Thu, 24 Sep 2020 09:36:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id j-KCvUrx7nDZ; Thu, 24 Sep 2020 09:36:24 +0200 (CEST)
X-Auth-Info: 8ronH07tWdu1XzNhwoSiBMOdcXov5iGOJ61TwDCB0oH2QygpST0od5Si4bxqvrCq
Received: from igel.home (ppp-46-244-184-54.dynamic.mnet-online.de [46.244.184.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Thu, 24 Sep 2020 09:36:24 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id EA4C42C278E; Thu, 24 Sep 2020 09:36:23 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH V2 1/3] riscv: Fixup static_obj() fail
References: <1593266228-61125-1-git-send-email-guoren@kernel.org>
        <1593266228-61125-2-git-send-email-guoren@kernel.org>
        <20200911204512.GA2705@aurel32.net>
        <CAJF2gTQiLV8sDE5cnvP=aBog4zaiMvMeieg_JtXwRODky1u3Hg@mail.gmail.com>
        <20200914103836.GB2705@aurel32.net>
X-Yow:  ..  are the STEWED PRUNES still in the HAIR DRYER?
Date:   Thu, 24 Sep 2020 09:36:23 +0200
In-Reply-To: <20200914103836.GB2705@aurel32.net> (Aurelien Jarno's message of
        "Mon, 14 Sep 2020 12:38:36 +0200")
Message-ID: <87lfgzeidk.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sep 14 2020, Aurelien Jarno wrote:

> How should we proceed to get that fixed in time for 5.9? For the older
> branches where it has been backported (so far 5.7 and 5.8), should we
> just get that commit reverted instead?

Can this please be resolved ASAP?

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
