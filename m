Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B566A8C4F
	for <lists+linux-csky@lfdr.de>; Thu,  2 Mar 2023 23:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjCBW4i (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 2 Mar 2023 17:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjCBW4f (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 2 Mar 2023 17:56:35 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E890559D4
        for <linux-csky@vger.kernel.org>; Thu,  2 Mar 2023 14:56:29 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id i3so874659plg.6
        for <linux-csky@vger.kernel.org>; Thu, 02 Mar 2023 14:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1677797788;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qXTwXNN5BPBJ/NZ3OYbXwmxOPd3hLZf5+C8HCX49djg=;
        b=cPNPEoDiS/HfsiIItPLGT3E2KS7Pa2nDCzgKjzoBCNTmF5ovdMVml+ppsm005Cz2gc
         pMD41ueS/rsqWBDjk0Ang+swrwWISO9NpTVI+XcAlfsXxlunEfDcOqSyRkjHfJ2N7W3M
         nXhJv2G01aF56hxwfL9a8N8s/N1YUs1FWh6Ok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677797788;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXTwXNN5BPBJ/NZ3OYbXwmxOPd3hLZf5+C8HCX49djg=;
        b=YlEkxH646mqme9jANY1GzWaWv4wFnOmvxc8F/RMKcit8t2+UHq/4sWUYKARvb0LChA
         vVrlwv4FQobbqxiEWsIpPfhASBE5PZH7rkeKym9mOu0QPmj+3w1Iv16Zp8VVxTpD+Fpf
         8hPJ8vqsAPB4EgLW55bbPhLZPIqA6a0iOM8uzkqsOI4Vx+zUelzDla1Xznsapyd9zeyz
         zDwShmrA+wIlXYyczRyFXNR39qGHNkPWrVW0zn3WFFVWJhCBuSI1UKrnyCFnPhOiORP1
         i8T2axaSW8KW6gAr9rZoZTcfC1FSpfY51jyNVVx738uEzf9+hVOiGO3qXcJb9T3IHPav
         5kiw==
X-Gm-Message-State: AO0yUKWugz9qY1nNq/UsONSGLhUiKxhHAbrgvm9lqqPzWRH2uBTBggcf
        QCSzRpNjoBJvpR60NGVpLzvZ5Q==
X-Google-Smtp-Source: AK7set+MdZhHyeith+B94HrQd6WpkfpBD5XCV21gXOzsSKhUw+dB78RFefTe7N6XbvDbdrdQDA//KA==
X-Received: by 2002:a17:902:ec88:b0:19a:e762:a1af with SMTP id x8-20020a170902ec8800b0019ae762a1afmr3404427plg.33.1677797788585;
        Thu, 02 Mar 2023 14:56:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b9-20020a170903228900b00198d7b52eefsm168326plh.257.2023.03.02.14.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 14:56:28 -0800 (PST)
Message-ID: <6401299c.170a0220.3a2e.0b8a@mx.google.com>
X-Google-Original-Message-ID: <202303021456.@keescook>
Date:   Thu, 2 Mar 2023 14:56:27 -0800
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
Subject: Re: [PATCH 07/11] seccomp: simplify sysctls with
 register_sysctl_init()
References: <20230302202826.776286-1-mcgrof@kernel.org>
 <20230302202826.776286-8-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302202826.776286-8-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Thu, Mar 02, 2023 at 12:28:22PM -0800, Luis Chamberlain wrote:
> register_sysctl_paths() is only needed if you have childs (directories)
> with entries. Just use register_sysctl_init() as it also does the
> kmemleak check for you.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
