Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E41D8149B6E
	for <lists+linux-csky@lfdr.de>; Sun, 26 Jan 2020 16:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgAZPfC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-csky@lfdr.de>); Sun, 26 Jan 2020 10:35:02 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:30268 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgAZPfC (ORCPT <rfc822;linux-csky@vger.kernel.org>);
        Sun, 26 Jan 2020 10:35:02 -0500
Received: from ymorin.is-a-geek.org (unknown [IPv6:2a01:cb19:8b51:cb00:383c:9d3:6333:ab7c])
        (Authenticated sender: yann.morin.1998)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id D700A20040F;
        Sun, 26 Jan 2020 16:34:43 +0100 (CET)
Received: by ymorin.is-a-geek.org (sSMTP sendmail emulation); Sun, 26 Jan 2020 16:34:43 +0100
Date:   Sun, 26 Jan 2020 16:34:43 +0100
From:   "Yann E. MORIN" <yann.morin.1998@free.fr>
To:     Thomas De Schampheleire <patrickdepinguin@gmail.com>
Cc:     Mao Han <han_mao@c-sky.com>, xianmiao_qu@c-sky.com,
        ren_guo@c-sky.com, linux-csky@vger.kernel.org,
        hongdeng_chen@c-sky.com, thomas.petazzoni@bootlin.com,
        buildroot <buildroot@buildroot.org>
Subject: Re: [Buildroot] [PATCH 1/2] package/toolchain-external: ensure
 ARCH_LIB_DIR exist
Message-ID: <20200126153443.GP32369@scaer>
References: <1577937441-18703-1-git-send-email-han_mao@c-sky.com>
 <CAAXf6LUVA4QkSmz8OaSOyqzKaw--eD5r0zAD+zONfyGROv1MZw@mail.gmail.com>
 <20200113033451.GA15150@vmh-VirtualBox>
 <CAAXf6LWZZKCW=g=ReXz00hLJSiBw6sJfsmSxu0=Q_J4FVda32g@mail.gmail.com>
 <20200117023547.GA12999@vmh-VirtualBox>
 <CAAXf6LV-f9o_9oY4+Me4qHRJeQhCWA75H1GOEYMoRPu5j4m-Jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <CAAXf6LV-f9o_9oY4+Me4qHRJeQhCWA75H1GOEYMoRPu5j4m-Jg@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Mao, All,

On 2020-01-24 16:00 +0100, Thomas De Schampheleire spake thusly:
> El vie., 17 ene. 2020 a las 3:35, Mao Han (<han_mao@c-sky.com>) escribió:
[--SNIP--]
> > There is another patch in the same thread:
> > [PATCH 2/2] toolchain: Get ld.so name if available
> > http://buildroot-busybox.2317881.n4.nabble.com/PATCH-1-2-package-toolchain-external-ensure-ARCH-LIB-DIR-exist-td243604.html#a244193
> > Tried to get the corresponding ld.so name with certain configuration.
> Thanks. Using this patch '[PATCH 2/2] toolchain: Get ld.so name if
> available' I actually can compile correctly.
> So, PATCH 1/2 is not actually needed.
> 
> Do you agree that only PATCH 2/2 is required?
> If so I will perform a more thorough review of that patch.

Given the feedback from Thomas, and the coments I provided on the second
patch, I've marked the two patches as Changes Requested on patchwork.

Thank you! :-)

Regards,
Yann E. MORIN.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +33 662 376 056 | Software  Designer | \ / CAMPAIGN     |  ___               |
| +33 561 099 427 `------------.-------:  X  AGAINST      |  \e/  There is no  |
| http://ymorin.is-a-geek.org/ | _/*\_ | / \ HTML MAIL    |   v   conspiracy.  |
'------------------------------^-------^------------------^--------------------'
