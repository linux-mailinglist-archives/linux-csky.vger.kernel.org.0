Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E033B5B44F8
	for <lists+linux-csky@lfdr.de>; Sat, 10 Sep 2022 09:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiIJHx1 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 10 Sep 2022 03:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiIJHxZ (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sat, 10 Sep 2022 03:53:25 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5971561D8E
        for <linux-csky@vger.kernel.org>; Sat, 10 Sep 2022 00:53:23 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id u22so3798574plq.12
        for <linux-csky@vger.kernel.org>; Sat, 10 Sep 2022 00:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date;
        bh=JE+O0JjBaUaKaVbXBPjztEKOPO7pJKl9qx1EvIyCmeg=;
        b=cvZJIBqGw+0ibOxmX+2fb/j2Y70TPEysHn1ZyDWt4NtukFlD84lWxjHmLm+5vXJ+VJ
         KXVReY8lhuzBkeoQdI7cqq4CEGfH6ZTdjzNeF13E1LDMcxz87nP6HidR7yqXFQU1vbnh
         AFBCIQriexf4bFS7x6XlHr4yXe5h214hVucA3T2xooH1iY/urtq9/xFfF+fNYNhSazGp
         s44Y7FJm+0cx4aAai0rYk6VbcIjmSTh5h7jqgPsI7/RNW8pRFTd8/HnYFNpqYW6qV08Q
         u4byXDmpYkU4fdgZVV/tCI7UrKUMeRH8yPvPvt+aTkXy8pnKHYljhWXg0m7Nm+SlAE88
         zgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JE+O0JjBaUaKaVbXBPjztEKOPO7pJKl9qx1EvIyCmeg=;
        b=Bz2JV4hbbzNrOLSgWOqpZqtc/xjUutV07LSaLtnH1nOELPqBhYVHd/m4grLuD/BQVg
         lcFu7W3TP7uKJyLzqMbsDrB3cIN30k3tAkPRvuwocEBVj8foAclq3Rp8h/ySFXjeFlVi
         Syxf5YbamJxeQtyDUf3mA6fGBvbR8X5gGnWZW8Wlv/FYvuM5SZ2waciliJRauoBvwSPC
         hgsAxNSjV9CqU8VWkLD97D/BSqC7EAFUyPyFrPo6fJ+a/hfEaQyvZ/D5K2u6Zn23rb/8
         XR8CrCp3gWhULccf/T38qVazSpHEErgpBO9O8gHa6z60KHrNYFfFK4dzX4J2qT9wlk9Q
         Br2A==
X-Gm-Message-State: ACgBeo16VP7dEUj+X5WrI3+Fy3IVEWaAXQLBSFpIdBhzIUdB1+u79/EG
        WcjEOeu6r1W7ZUq9+4pa+7jUiA==
X-Google-Smtp-Source: AA6agR5WNWyuopz0i+tWtj4d6z/9P1Jiwgf7f0mslhclROc9ftNMoa4vQmNLf5f/958mh31IrCT/nw==
X-Received: by 2002:a17:90b:1d02:b0:1fe:36a:6e01 with SMTP id on2-20020a17090b1d0200b001fe036a6e01mr13521195pjb.102.1662796402707;
        Sat, 10 Sep 2022 00:53:22 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:3bf1:3d60:1b12:a903])
        by smtp.gmail.com with ESMTPSA id z12-20020a170903018c00b00176d4b093e1sm1717555plg.16.2022.09.10.00.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 00:53:21 -0700 (PDT)
Date:   Sat, 10 Sep 2022 00:53:16 -0700
From:   Fangrui Song <maskray@google.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH] vdso: Improve cmd_vdso_check to check all dynamic
 relocations
Message-ID: <20220910075316.no72fdyqjvunomwm@google.com>
References: <20220830193701.1702962-1-maskray@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220830193701.1702962-1-maskray@google.com>
X-Spam-Status: No, score=-15.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 2022-08-30, Fangrui Song wrote:
>The actual intention is that no dynamic relocation exists. However, some
>GNU ld ports produce unneeded R_*_NONE. (If a port is not care enough to
>determine the exact .rel[a].dyn size, the trailing zeros become R_*_NONE
>relocations. E.g. powerpc64le ld as of 2.38 has the issue with
>defconfig.) R_*_NONE are generally no-op in the dynamic loaders. So just
>ignore them.
>
>With the change, we can remove ARCH_REL_TYPE_ABS. ARCH_REL_TYPE_ABS is a
>bit misnomer as ports may check RELAVETIVE/GLOB_DAT/JUMP_SLOT which are
>not called "absolute relocations". (The patch is motivated by the arm64
>port missing R_AARCH64_RELATIVE.)
>
>While here, replace "egrep" with "grep" as "egrep" is deprecated in GNU
>grep 3.7.
>
>Signed-off-by: Fangrui Song <maskray@google.com>
>---
>[...]
>

Ping.
