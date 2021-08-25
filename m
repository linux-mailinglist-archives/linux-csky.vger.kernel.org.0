Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE6C3F6DDE
	for <lists+linux-csky@lfdr.de>; Wed, 25 Aug 2021 05:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238132AbhHYDuh (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 24 Aug 2021 23:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbhHYDu3 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 24 Aug 2021 23:50:29 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1759C06179A
        for <linux-csky@vger.kernel.org>; Tue, 24 Aug 2021 20:49:38 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d17so13496072plr.12
        for <linux-csky@vger.kernel.org>; Tue, 24 Aug 2021 20:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=CbvF3gcMl15CsJvEJlvAwV4jg0kS7/1c0/243X9NmVQ=;
        b=nS8Xfv5Np514ewOr71qM5OVYQ4om375+9iia5AAYDaK3OM+hzJenuJr7dAU5cYremk
         lMJSdk/H6gRuWyoAZ38Dxo4xTOwzwlYBTQ7mHvrJGvY2eRlpd9btrTwCc/T4R+lnp2Oz
         tfjjB9XYA84IA+sxs7E0+0bjR3ImZY/NCblTCqWV1vz8ngiUx+QRlaWbVMisVRWW3rOO
         yK85Pgi7JMY0nVAg9WrPZrM52PG/5lW+DmvVcQIgBTfNfdcKCdUHJCl4J+hHtwrGzLzq
         JQXK/nMftIjnNhxqPt/IHdPMmbV0SixoX/iiQ7rUV+IDNkS5Y0uflbsJwBJg2KghrkLe
         Gahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CbvF3gcMl15CsJvEJlvAwV4jg0kS7/1c0/243X9NmVQ=;
        b=QN4RGB+FFDnMPlhs0IQ9V3KAxp2Wpr6k9seU26yO/jyeEEvrW0cLF7NDzOEYU19YRa
         /0pgFWk4P95UVK5ijSocqn6/oMvDfk+XgftemVd63Jx/sVjF/qa34Ocz3M1WooqKE9Be
         914UE2BMB30R0t2kQ8LQR/MPp5eRD0KokZlcwB+dhVFLLYoVPgthSSiGswaR7Lr3YpKU
         bWwAknix2phZgT2Les9H4u6jTUJ7O+n9+vAbJopWqLfokStSv/bjviMlRddcHfoyS3f5
         /JeF1SVuMOc0TdxFQn3K7yJ40Gq89yjBWj9TvByF2tI3MHWPn78dezr4HyWReTi4LuEu
         it7Q==
X-Gm-Message-State: AOAM5321veT5O+KTLd2NBgLEoYLEoongbRiQVsHG/sE8a2KcxZ+WpaU3
        kUmvAx+wFMQOLfxtjQP6U1EAsA==
X-Google-Smtp-Source: ABdhPJyuW0xG5fzwlVnm+V74njUWhK4iHoDYuJqptloS8iraqWcj5+LzzcKnLTPVDHS2p7IwfcePKA==
X-Received: by 2002:a17:90a:428f:: with SMTP id p15mr8241589pjg.75.1629863378109;
        Tue, 24 Aug 2021 20:49:38 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id q21sm23393107pgk.71.2021.08.24.20.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 20:49:37 -0700 (PDT)
Date:   Tue, 24 Aug 2021 20:49:37 -0700 (PDT)
X-Google-Original-Date: Tue, 24 Aug 2021 20:42:18 PDT (-0700)
Subject:     Re: [PATCH 2/3] trace: refactor TRACE_IRQFLAGS_SUPPORT in Kconfig
In-Reply-To: <20210731052233.4703-2-masahiroy@kernel.org>
CC:     rostedt@goodmis.org, mingo@redhat.com, masahiroy@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, ardb@kernel.org, bp@alien8.de,
        linus.walleij@linaro.org, ley.foon.tan@intel.com, x86@kernel.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        anshuman.khandual@arm.com, nickhu@andestech.com,
        tglx@linutronix.de, rppt@kernel.org, geert@linux-m68k.org,
        peterz@infradead.org, catalin.marinas@arm.com,
        linux-riscv@lists.infradead.org, yifeifz2@illinois.edu,
        green.hu@gmail.com, monstr@monstr.eu, deller@gmx.de,
        linux-sh@vger.kernel.org, vgupta@synopsys.com,
        u.kleine-koenig@pengutronix.de, guoren@kernel.org,
        samitolvanen@google.com, richard@nod.at, borntraeger@de.ibm.com,
        dalias@libc.org, aou@eecs.berkeley.edu, hca@linux.ibm.com,
        jdike@addtoit.com, jcmvbkbc@gmail.com,
        linux-hexagon@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        hpa@zytor.com, will@kernel.org, tsbogend@alpha.franken.de,
        stefan.kristiansson@saunalahti.fi, linux-s390@vger.kernel.org,
        ysato@users.sourceforge.jp, James.Bottomley@HansenPartnership.com,
        linux-um@lists.infradead.org, andreyknvl@gmail.com,
        frederic@kernel.org, npiggin@gmail.com, benh@kernel.crashing.org,
        bcain@codeaurora.org, linux-csky@vger.kernel.org, shorne@gmail.com,
        linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>, chris@zankel.net,
        gor@linux.ibm.com, linux-snps-arc@lists.infradead.org,
        jonas@southpole.se, linux-parisc@vger.kernel.org,
        keescook@chromium.org, krzysztof.kozlowski@canonical.com,
        colin.king@canonical.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org, deanbo422@gmail.com,
        anton.ivanov@cambridgegreys.com, akpm@linux-foundation.org,
        mpe@ellerman.id.au, paulus@samba.org, mark.rutland@arm.com,
        viresh.kumar@linaro.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     masahiroy@kernel.org
Message-ID: <mhng-fae2ea79-c261-4e5d-8eae-21e60810a957@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Fri, 30 Jul 2021 22:22:32 PDT (-0700), masahiroy@kernel.org wrote:
> Make architectures select TRACE_IRQFLAGS_SUPPORT instead of
> having many defines.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/riscv/Kconfig            | 4 +---

Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>

Thanks!
