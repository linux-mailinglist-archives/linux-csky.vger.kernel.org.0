Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D84717D854
	for <lists+linux-csky@lfdr.de>; Mon,  9 Mar 2020 04:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgCIDlv (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sun, 8 Mar 2020 23:41:51 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40778 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgCIDlv (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sun, 8 Mar 2020 23:41:51 -0400
Received: by mail-qt1-f196.google.com with SMTP id n5so2445711qtv.7
        for <linux-csky@vger.kernel.org>; Sun, 08 Mar 2020 20:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CNYYFTCalmUuSxAWR7XaCM/gxKPhcvr0JtZkj6eTI9Y=;
        b=VHknv8LB3GFRw23ZbiPdreuz6d01GLWWAJvdX5EgeD9/c/GcOS3IP+ZhkeICb0JhfH
         XVw67cYfVsHCMH6qw7HsKBL6jpr+j6KBSqMec750uAs+10sQ6riV2cVg2oqfVtKcQHyP
         Z9hT3Z+Ws38DjPnOB/+jFMRTCz1yayzN6dXEs0YuebKNXz0BN2awgZsy5VV/cWs6MZoZ
         d94/E5LVYK9fXw1NUB6hQ8fdh3XQZyglH788D+Wk2e0T7MP2IAqDsaAincG5B8kjJe9i
         NQzh+apsnX9PlOHTG2BZPhAyc6uIbxHgmQJKN3JkWRl0MO23Fvjem4bcygW4f+/zlNW8
         V8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CNYYFTCalmUuSxAWR7XaCM/gxKPhcvr0JtZkj6eTI9Y=;
        b=ir8qhxenk+tBozp1++tZBtbiIyujjOmQ5R1QRj1bDmsZAXIhau1V3XW8LlZC1xkYYZ
         3bdapfNCzQ8UdDCJqSbPL4jZdmuqrNqYkj/4XA10ebyjpcZFMIzuolK6b6bOa1UcQIpp
         eT/kreusCWHzQDBD1Zn7lqRe94g+vlbn37zgrU5fuSYRvjAOaxmmlYJlQOJb72j70+/H
         gj2g6bhRhXysnRTgAaZakODYj7AxB5n8ukTEV/3Vtket9ePy+RJas3s6zCgOOas2iXmL
         TRRSQZOjmtvpHQc/XvgDiFovfOJ+mZn0bWFzEfJYdZwkLe5TypkkdZHrXEAFzkLy+hqG
         xDlA==
X-Gm-Message-State: ANhLgQ2wbd2WKRgIHKV/H2/ZczY3qPb8kEBb3wZ710nFdSHhPxlfwZKI
        9CT2E9go3QYvFefJndQtfYAHiPVcx8Eexfi6v4He4A==
X-Google-Smtp-Source: ADFU+vt7hRKCpjY9Y/6PbDXX5/P/aKDMHT0L5G/8Gt3a3KMISifEbxYw8sWoZVsjM25ruYRMFoTYggX7kXK+ZNULFqA=
X-Received: by 2002:ac8:1345:: with SMTP id f5mr12999290qtj.128.1583725308848;
 Sun, 08 Mar 2020 20:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200308094954.13258-1-guoren@kernel.org>
In-Reply-To: <20200308094954.13258-1-guoren@kernel.org>
From:   Greentime Hu <greentime.hu@sifive.com>
Date:   Mon, 9 Mar 2020 11:41:37 +0800
Message-ID: <CAHCEeh+XYD3uVmaQRGpY=VGxpO9hzMeKasNmAojhkZe9PJ9Lug@mail.gmail.com>
Subject: Re: [RFC PATCH V3 00/11] riscv: Add vector ISA support
To:     guoren@kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, Anup.Patel@wdc.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, arnd@arndb.de,
        linux-csky@vger.kernel.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Liu Zhiwei <zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sun, Mar 8, 2020 at 5:50 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> The implementation follow the RISC-V "V" Vector Extension draft v0.8 with
> 128bit-vlen and it's based on linux-5.6-rc3 and tested with qemu [1].
>
> The patch implement basic context switch, sigcontext save/restore and
> ptrace interface with a new regset NT_RISCV_VECTOR. Only fixed 128bit-vlen
> is implemented. We need to discuss about vlen-size for libc sigcontext and
> ptrace (the maximum size of vlen is unlimited in spec).
>
> Puzzle:
> Dave Martin has talked "Growing CPU register state without breaking ABI" [2]
> before, and riscv also met vlen size problem. Let's discuss the common issue
> for all architectures and we need a better solution for unlimited vlen.
>
> Any help are welcomed :)
>
>  1: https://github.com/romanheros/qemu.git branch:vector-upstream-v3

Hi Guo,

Thanks for your patch.
It seems the qemu repo doesn't have this branch?
