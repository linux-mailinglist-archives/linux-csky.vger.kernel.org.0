Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9794F136BC5
	for <lists+linux-csky@lfdr.de>; Fri, 10 Jan 2020 12:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgAJLPx (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 10 Jan 2020 06:15:53 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:57133 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgAJLPx (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 10 Jan 2020 06:15:53 -0500
X-Originating-IP: 90.76.211.102
Received: from windsurf (lfbn-tou-1-1151-102.w90-76.abo.wanadoo.fr [90.76.211.102])
        (Authenticated sender: thomas.petazzoni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 386431BF211;
        Fri, 10 Jan 2020 11:15:51 +0000 (UTC)
Date:   Fri, 10 Jan 2020 12:15:50 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Thomas De Schampheleire <patrickdepinguin@gmail.com>
Cc:     Mao Han <han_mao@c-sky.com>, buildroot <buildroot@buildroot.org>,
        Qu Xianmiao <xianmiao_qu@c-sky.com>,
        Guo Ren <ren_guo@c-sky.com>,
        Mark Corbin <mark.corbin@embecosm.com>,
        linux-csky@vger.kernel.org, Chen Hongdeng <hongdeng_chen@c-sky.com>
Subject: Re: [Buildroot] [PATCH 1/2] package/toolchain-external: ensure
 ARCH_LIB_DIR exist
Message-ID: <20200110121550.36c1aba9@windsurf>
In-Reply-To: <CAAXf6LUVA4QkSmz8OaSOyqzKaw--eD5r0zAD+zONfyGROv1MZw@mail.gmail.com>
References: <1577937441-18703-1-git-send-email-han_mao@c-sky.com>
        <CAAXf6LUVA4QkSmz8OaSOyqzKaw--eD5r0zAD+zONfyGROv1MZw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4git82 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Fri, 10 Jan 2020 11:57:00 +0100
Thomas De Schampheleire <patrickdepinguin@gmail.com> wrote:

> Finally, please provide a defconfig that allows to reproduce and test
> this problem.

I agree that we need to have access to the toolchain causing problems,
so that we can understand better what are the issues, and what is the
best solution to solve them.

This would also ideally allow to add a test case in Buildroot for this
toolchain, to make sure it keeps working moving forward.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
