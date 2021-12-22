Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532A847D3AC
	for <lists+linux-csky@lfdr.de>; Wed, 22 Dec 2021 15:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241065AbhLVOat (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 22 Dec 2021 09:30:49 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:38927 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbhLVOat (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 22 Dec 2021 09:30:49 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MSss2-1mu1qz3wAo-00UHbl for <linux-csky@vger.kernel.org>; Wed, 22 Dec 2021
 15:30:47 +0100
Received: by mail-wr1-f53.google.com with SMTP id r17so5333264wrc.3
        for <linux-csky@vger.kernel.org>; Wed, 22 Dec 2021 06:30:47 -0800 (PST)
X-Gm-Message-State: AOAM531yzCo6vtCXML11wMfdrHTibyIP3TaGnKiiMAvUZ357pWc6AAEu
        Q5qbLYxLaRc5EVW4lN9gcbGvM4/kAEaP0O7xsz8=
X-Google-Smtp-Source: ABdhPJzZqUV3m/4gBi9PAOChOgb2RpOg4jQAP0/DgyHh+MJob01VsDYVK0s1Stco5K8zA3yLynfQmmGKPYOk7XFmlEE=
X-Received: by 2002:adf:a352:: with SMTP id d18mr2189656wrb.317.1640181632663;
 Wed, 22 Dec 2021 06:00:32 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org> <20211221163532.2636028-6-guoren@kernel.org>
 <CAK8P3a2XOVYB1Fm5TBdjtKx9DXoG93Zrw7TiquYL_Zy916dLwQ@mail.gmail.com>
 <CAJF2gTR2fAU=+0fvW_VCqaZfDkSTAxQ=cKE9iAYOoGORb3m+4g@mail.gmail.com> <CAK8P3a17A3MU_atWNEretDcr5sLRc7540tM4vfc=H4M8qVCDEg@mail.gmail.com>
In-Reply-To: <CAK8P3a17A3MU_atWNEretDcr5sLRc7540tM4vfc=H4M8qVCDEg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 22 Dec 2021 15:00:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2b0zun=b84d=LhrjrwLDiKh5_KgyZbBAjTz+40NZri=A@mail.gmail.com>
Message-ID: <CAK8P3a2b0zun=b84d=LhrjrwLDiKh5_KgyZbBAjTz+40NZri=A@mail.gmail.com>
Subject: Re: [PATCH 05/13] riscv: compat: syscall: Add compat_sys_call_table implementation
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
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
X-Provags-ID: V03:K1:x8HlQhBmXGg8u5ndM9FI/7klqTWnCzAgbJqZlUzrQ605PZCYbTE
 K2ZGX3BNeBDs7tDHFhZVhPArmisYZbabwrs7osDpwGspM5k0pzPjDmS5v4zZrvDQm6GqSLt
 Tc3AajtYM98VbmwG35zjOeq/Gq73uu0Go6+mSMaSFiR6P6Lhes7v3imyudC7CcCp++pavG9
 MQKvK4MN5fuSmzPt1UVMA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:XWPkxrzLb38=:7UWbGX1kUrTmMbDGXDLPah
 7pPMnkOFNQGjuuFPzNec5NsurKNSZBycjj8L9oL+AZZYAmhllPUb0vEQ7z8nCOn4yz2/IGYzf
 0ca9+X366wGFJtqHwx4vGqQ2IvDTEpPseLeVlHgw/cn9QYrivqb4aEv90T+THW3XZ96/7jcsP
 jqwPwDTkysp1XRWl0mWDHphGESeFO98oIXzCE9XzT8mhKvO9uA5CXzrtPY0A+dJNjPpOPw9vj
 kzzNozmfqtGABdfAHXskEZW4o8RXxb3GX7K8wnpzj4ZbjuixptcjojXnPxHN/2j+RM9RdKUPE
 +Ztbh9GeTXW9yisO452aA8wLKJez5NN5gLyDFsFdPlq03PStOzpCgGPGbG9n832SS/KA7+yxz
 OZZudCI09j1CoWNf/ACCGksTDtVzUcDPhzCj4OpLtoyo1/e1IiOhSdVWooLwCT1yW8Vbo3mud
 18Iy4bZTMXpWaaeS53tV9rtNcwPsLCB2LRKi2JGffj4pwnbXd7L2FBIHkVFjlfLej7brw+g//
 t8ZsQHgu4pp6vzRCrQjLUbwSl2jySxuLr5ePigPDAWZzUc887967lbIsqiQvYU3uDqJImOOy7
 eRgWO+EtlU/pen5e0D2kdpGSaf+gxvNLfAxveZxeoumA++K9aiCyGEXh9hjtk6aT0vMhUp2X6
 3yh4ysgU7P2eYst9RBtqh7UhbYOZRe8nVWA7mcHCpgiJc5798Nrgt1a/I5LKhTpeFfWLeXK4e
 ERf0MsNSAC8iITyq7iMVN2DFowSgKKRgRtwXRogU6niE26VvJB0oWEa8v2Oi5xDykPDcNixDw
 qugNMuVr7V2ixq79rc5IaICqwQ+9JxUVsfJWH/052TpPq+YLTA=
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Wed, Dec 22, 2021 at 2:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Dec 22, 2021 at 1:43 PM Guo Ren <guoren@kernel.org> wrote:
>
> Right, I think the patch would be a nice cleanup, but it appears that
> riscv is among the few architectures that have defined their own
> nonstandard mmap2() syscall after all, despite using the standard
> name for the entry point. Not sure how this slipped past my original
> review, but it certainly can't be changed now.

No, I misread, the calling conventions are fine after all, it's
just written in a rather odd way.

> Maybe leave it there and change the #ifdef to build mmap2 for both
> native rv32 and compat mode.

This bit still applies though, I don't think you need to add another
helper, just use the one that is already there.

        Arnd
