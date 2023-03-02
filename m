Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1BE6A8C48
	for <lists+linux-csky@lfdr.de>; Thu,  2 Mar 2023 23:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjCBW4J (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 2 Mar 2023 17:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbjCBW4I (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 2 Mar 2023 17:56:08 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4083F360B3
        for <linux-csky@vger.kernel.org>; Thu,  2 Mar 2023 14:56:07 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id z2so835453plf.12
        for <linux-csky@vger.kernel.org>; Thu, 02 Mar 2023 14:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677797767;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fDa++rPUZHG1cADT97wEka7i9XpBCSMw+BsUJit3tM8=;
        b=apW6CO+GriA5ax10w+Ltl21EZyiCuiEkrosyVJE39MbM7iiqBxUYPqTnJSZJrvIQ5m
         AyBgf/dBZT8ggeDyaszfb5BRhMl3PsNMujEvWYmubxg2OsoEQS9fDcbnxUg4wG8mHx8b
         JSd7FVNrEyw/RGhiZ1WY6WaWHYqk9swiQFrcM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677797767;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDa++rPUZHG1cADT97wEka7i9XpBCSMw+BsUJit3tM8=;
        b=bMPecypJCZQm67IPpgLRsWhWO5EhHmAhZDMAaicef476YXQAsarOAPU0R/+H7vVaf2
         pEBK1cEmEclOLXQKkwMjZGb7mfRoVjK/aRgO9HIyjttmSfSBzwASIBFXqjlQD19Us6Vz
         XBEL//A0zQRuBE3apcuH72TJXzyEbd/H6zuuVb9akStp0x/3dx9sEbUCn/hmmdVBSMAh
         zCFK2Qh+utmeH1yfDXNaQZ5bYR/aoYsWjo0KyoRUOpAdi85Qf3DEK9vyCCdS6RwAdfDM
         Mw1q8PZXAeq/mQkXvt0QuECmQCrBE24e7w8gFfRwkBJ0+ixmKy1JUEmZ6jCutbPKNtR6
         iRHA==
X-Gm-Message-State: AO0yUKUWO1hmj16FZIuDu7SXqswBM9jTzqBg21tlVhqd+xweIPdiFhrx
        rblwLRXXSONrCc5GkkaC7aT5GQ==
X-Google-Smtp-Source: AK7set+MEnLjHdrL/UF2pQiGl3CRsjFYnt0FAye8NGhtXVtdNjGBD457Drx+Q5YR8VVMf1FPUpgIMQ==
X-Received: by 2002:a17:90b:4a8c:b0:237:b702:49c0 with SMTP id lp12-20020a17090b4a8c00b00237b70249c0mr12768587pjb.45.1677797766720;
        Thu, 02 Mar 2023 14:56:06 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x13-20020a17090a294d00b00234a2f6d9c0sm224637pjf.57.2023.03.02.14.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:56:06 -0800 (PST)
Message-ID: <64012986.170a0220.67312.124e@mx.google.com>
X-Google-Original-Message-ID: <202303021455.@keescook>
Date:   Thu, 2 Mar 2023 14:56:05 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     ebiederm@xmission.com, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, jeffxu@google.com,
        ebiggers@kernel.org, tytso@mit.edu, guoren@kernel.org,
        j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/11] loadpin: simplify sysctls use with
 register_sysctl()
References: <20230302202826.776286-1-mcgrof@kernel.org>
 <20230302202826.776286-6-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302202826.776286-6-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Thu, Mar 02, 2023 at 12:28:20PM -0800, Luis Chamberlain wrote:
> register_sysctl_paths() is not required, we can just use
> register_sysctl() with the required path specified.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
