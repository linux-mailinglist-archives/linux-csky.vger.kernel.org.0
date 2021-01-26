Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6781D304D43
	for <lists+linux-csky@lfdr.de>; Wed, 27 Jan 2021 00:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732029AbhAZXHR (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 26 Jan 2021 18:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbhAZVwh (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 26 Jan 2021 16:52:37 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F19C061573
        for <linux-csky@vger.kernel.org>; Tue, 26 Jan 2021 13:51:57 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id jx18so22871pjb.5
        for <linux-csky@vger.kernel.org>; Tue, 26 Jan 2021 13:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=9AGUrnYhoWJA1kfWhc7TVECC62YzbW1KPUtWDLu+fzU=;
        b=CoF8scV8GMS1FDnoMkt+B8uRJbbDV4uSOzXLMznAWJx7gspLHHagDXhqjTzxLiUI2h
         FCey2UeS/rklKLrJGibOF62TW0gS8ZneJUW2t9JWVwBpZhrCTYFgIOLw821P892kvcEb
         Dl2RMt1HCmoE90fCzuXCrXN/uN+DA6QKa35DP9Njotfi9z7Ouv/UU92I8Egs5vmftAjQ
         NO8SKbNY3b6EWu7zbFPJxsgPFEjyTLN8N7pTSIF1DhpzsXmQu8u57oY6PacxBgkd/GVf
         bIdYFn1a0wpRLpEqmoKVDFQwXiPAaLOYY7Ay7lDRJBK40XEvWLLDcsgGfvLza7jaRZgd
         suQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=9AGUrnYhoWJA1kfWhc7TVECC62YzbW1KPUtWDLu+fzU=;
        b=Lp9lNwemLRk3ruvAo1I2sUJzhdu0up4FGzrxv+tIEIAFq0K+JZrwI7CNfZI6p0sSxt
         9srB6fNgCIVDzybRfWdKfMXCRji3Vbf1hoNbtMDRQn6TAE2gJverHp3S+6ghz/WgK6SG
         6mKQA0CXhosVFz8TGRzFaYWIYoN0SdrHPzOPvq2/eyBttaQ6kdhWY08qJpnyy+2Rnyw7
         o5kW9j4E421sxFGpK+MigqfoqaHeP0pW1jyv6q0SvANCxW6eVJL4I6uSV9lNC6GjzgbB
         U+P/K9ky/x8SyZxde+Wisd8UppfCDsX7Ss4vm8LxSdFK63bx9AIr6rbZIZ5FZBA1qNAq
         PADw==
X-Gm-Message-State: AOAM5339oOlp2SsTOG/eyY1zmVW0VVaJ7KLrNugcxnWfMJuBDAXlXgjs
        m8OJcuCBeOvalpgEkFezLRTzo4GOKOjV32SxtSQg3jgANGA=
X-Google-Smtp-Source: ABdhPJxBIjAqb8gfSDmU64X+/zprHEQtEGNiETCtWpzd47rF+frXRR87DvkSZdnjsTD4JLIRssZhQrbC6RAiBrVCKIw=
X-Received: by 2002:a17:90a:2e0d:: with SMTP id q13mr1881367pjd.101.1611697916681;
 Tue, 26 Jan 2021 13:51:56 -0800 (PST)
MIME-Version: 1.0
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 26 Jan 2021 13:51:46 -0800
Message-ID: <CAKwvOdnQjm2yMfKLcT-9=iQg68=EskMh3Evrx=3rTAJo3UAnZw@mail.gmail.com>
Subject: csky + clangbuiltlinux
To:     zixuan.wu@linux.alibaba.com, guoren@linux.alibaba.com,
        ren_guo@c-sky.com, linux-csky@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Hello,
I was wondering if there's any interest in getting LLVM's csky backend
to compile the Linux kernel?  We maintain LLVM support in the kernel,
and CI in various places.  It would be neat to see these working well
together and actively supported.
-- 
Thanks,
~Nick Desaulniers
