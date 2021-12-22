Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF1247D275
	for <lists+linux-csky@lfdr.de>; Wed, 22 Dec 2021 13:51:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241232AbhLVMvl (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 22 Dec 2021 07:51:41 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:35665 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241182AbhLVMvl (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 22 Dec 2021 07:51:41 -0500
Received: from mail-lf1-f54.google.com ([209.85.167.54]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MUGuZ-1mqUZ62iW3-00RLXz for <linux-csky@vger.kernel.org>; Wed, 22 Dec 2021
 13:51:39 +0100
Received: by mail-lf1-f54.google.com with SMTP id j11so3424781lfg.3
        for <linux-csky@vger.kernel.org>; Wed, 22 Dec 2021 04:51:39 -0800 (PST)
X-Gm-Message-State: AOAM530B7IJ0c5SxPB6N23nf+n4SjWP0YV1ELpyYckbuCDLin+UDMq5A
        EB1vaczmW2BIV4Sxjw/W2hkFKtcfzn+FYNBb2UE=
X-Google-Smtp-Source: ABdhPJyMFXz7aqbM7KdvBb77zETinuaSKzit22o64H1Git0wpQHkxlanFxDaPfbOiMZL+6FwJBcCxSM41Y+rYzB+cVs=
X-Received: by 2002:a5d:6989:: with SMTP id g9mr1836953wru.12.1640173469025;
 Wed, 22 Dec 2021 03:44:29 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-3-guoren@kernel.org>
 <CAK8P3a3dS=Ne0Pd2qZc8vB2whM7AUcJ1BNbhtf6EEboWAPpSug@mail.gmail.com> <CAJF2gTTN1HZeycK-WOFH0EjmjtBB4T=9de6Qrjs=uhAsLoOFaQ@mail.gmail.com>
In-Reply-To: <CAJF2gTTN1HZeycK-WOFH0EjmjtBB4T=9de6Qrjs=uhAsLoOFaQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Dec 2021 12:44:13 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3m2Mz4Tvu+3cdji6iq_wvFZsYoyKvnaNKTEjE+ivex6A@mail.gmail.com>
Message-ID: <CAK8P3a3m2Mz4Tvu+3cdji6iq_wvFZsYoyKvnaNKTEjE+ivex6A@mail.gmail.com>
Subject: Re: [PATCH 02/13] riscv: Fixup difference with defconfig
To:     Guo Ren <guoren@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Anup Patel <anup.patel@wdc.com>,
        gregkh <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:vvmV9ylRoL4pU4zx0JD/Ta2++Yv0dWydR32NKCpxOhfCypG5HJR
 A7dpx3YNcbk/A+M/p8fbZvS6GyDtdqVuXzec9U4B48JkzkO3+PtNgRl2bO7bx/lCEBMKHtT
 ghxUudVzfbXN+m6qfv+Am0UCmOSjFxp+AlJr9DJJ5Pd3YXGq/1w2Zw4uek+gsFj/51wK7zh
 b2DpcdSRm+bQJme1JFULQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Lm0Yo7s3oDw=:MXFMe+XcfcFstX0HCYXSLU
 C4MLju4wgQWrgL3WP0XZhAHTzhNU3BZQFupZsrbpq0P++I609sOGe//rYMk7N0/wWJZhCQ406
 0N1QyuKt7XCBmlzHA1989/FBZI/yMp5nzUsHqTGw5taXAGFEgpGvoIpyZz0fIWQ/lrlHfhZ5e
 6wgdTY5h2OvzG/Wh/T4huVlHZ/eZvxWNuIcZ/qqji4+++vS8tPeIDqWOyHcAEZ3Ic5Q+DsWIT
 EYyyfn3K09jR/zUmi6ex9Sa/8DP/Lc4zZiSEeoW9BcliqBDRsmzXqp7YPdgTHTI2yOr2eqPrc
 RGXFuDE4Ve+KlDT/SLT7CpIctU7eH4mxuf39jn6xG8HDS4ATiiq/Xpb7ScxImcFct+rC5bDRS
 sKU50u/44ba4ECkRnZnHxMYtKK9XolxFfYrYwIaMIeWjqeNJUwAA+M48yBwlh7LwuZ5Qma8Gn
 CMFutzMlM8wybKRQldV9m9YPkWyd0GAlqSbntSRlwqlmzxdwJU/kbrBI7KHYXhhbcQ9GLmsiX
 KX8OzPK59XukI/85xjdZ0wJUNnVQ+gKoBrwXB47vpknKikUBZLQ5PsQ20BWEZHXgMW8OQ3eY5
 wLKYD2JQoCO+q1OshRvpoP4bVD8vs4EVx5nMZcoNRV674XN/NvP20G5RLzbzz1PXkyfE/B5N9
 Cr/jtkuBWpE6UJdw3+oY15kxYR+OC3EHsUNtFjFvrUdlf/TOS8JI92IL5qCgSnx9YqFjJRghs
 GdJX9g9RjSJm+/khQGa7FyZP4B3foYP1sflK6RNz1THnkBv5PMlgz16uyrGN6m9ANEhMAFxSN
 XjwnNO15DZWrerIjKNgviCdX0p58oFM2lHjQGg1HCcFleafoyA=
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Wed, Dec 22, 2021 at 12:34 PM Guo Ren <guoren@kernel.org> wrote:
> On Wed, Dec 22, 2021 at 1:09 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tue, Dec 21, 2021 at 5:35 PM <guoren@kernel.org> wrote:
> > If the intention is to keep them in sync, maybe use a fragment for 32-bit
> > mode, like powerpc or mips do.
>
> Some people are familiar with "make rv32_defconfig". There has a
> 32-bit.config fragment config in arch/riscv/configs/.
>
> I've tested with:
>
> make ARCH=riscv CROSS_COMPILE=riscv32-buildroot-linux-gnu-
> EXTRA_CFLAGS+=-g O=../build-rv32/ defconfig 32-bit.config
>
> The above is tested Okay, do you mean we should delete rv32_defconfig?
> I think it's another topic, I just want them the same in "compat"
> patchset.

I think what you can do is to add rv32_defconfig as a target in
arch/riscv/Makefile the same way as rv32_randconfig, and then
delete the other file, that will keep the existing process working
for any existing users.

Given that there are no specific rv32 SoC implementations supported
by the kernel today (other than SOC_VIRT), the number of users
would be close to zero anyway.

       Arnd
