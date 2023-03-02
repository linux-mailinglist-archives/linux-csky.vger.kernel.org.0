Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C666A8A93
	for <lists+linux-csky@lfdr.de>; Thu,  2 Mar 2023 21:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229959AbjCBUm1 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 2 Mar 2023 15:42:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjCBUm0 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 2 Mar 2023 15:42:26 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E903BDA0
        for <linux-csky@vger.kernel.org>; Thu,  2 Mar 2023 12:42:25 -0800 (PST)
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 964573F231
        for <linux-csky@vger.kernel.org>; Thu,  2 Mar 2023 20:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1677789743;
        bh=VPNnC6C1cy3MGBtKJ7RY2J7qDK3sxM2tBtUziWuIYdg=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
         Content-Type:MIME-Version;
        b=cwsORZACNKdUFjmD2O+0eraH3LIIbbVwDr40QqDWeb6hXl2/KfCjhG0WhgHtUdFE4
         pvtvz6yMZtpli8IkdnWqzYdiu7vS1uky/3NJDb9MheGpt4/KwJF7ysSUswtUnOdBmg
         xHdckwdwvnRIV4HID06QYgz3lzP6Uh1+BUuaj2cGJJii9HukEI+OWV0mNe0iBw3Tqv
         sHRi7thpnrvwSPSvG2Q26Ax4hzvxyjQ+luQzjq1+/wTWprK945CaGgFEwdD0FKzcaZ
         slRMsYsO3sHsakgpUuACAP38n6O44bs3Ga24LvRjPCr7Nl28wVmkiejInEVYASQHBm
         7rINeMto2Te6A==
Received: by mail-oo1-f72.google.com with SMTP id f206-20020a4a58d7000000b005250d9d616aso269974oob.20
        for <linux-csky@vger.kernel.org>; Thu, 02 Mar 2023 12:42:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677789740;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VPNnC6C1cy3MGBtKJ7RY2J7qDK3sxM2tBtUziWuIYdg=;
        b=ENjgyWqO+l75nui3BXOlXf68eMNJoPYNFjVm9NOUyCAUY7qJ2wSoGf7nBL5colrtdg
         /tBjcRdCZPtoEwLV1/R+ipuZOhgUk6HvNadI2dNoOMHI+ym+Ar6doLJEr4QSrDdy4fl0
         lL7slZtfYMIKObU9Qo9D02CO9SBrUmTi3OLd49QJtuBnc6PvKNTpKRLuP+HNDLNT65Ho
         ivbojRpEDbzR/XIgOuBvXvUyzChUsEYmonXuaflYe17SPma4YmbpL9jfT1ODDftK3HwG
         vQS1n+0lqFBCy702vYIQyFUU4HH6ChnyfzGXR0SYoTXPlcJKp7L2C8AQ0+qiUaZqO9uq
         RMOQ==
X-Gm-Message-State: AO0yUKVaG/76nOwbRo0G9Lo+CQXorV7dOYyUglOvIIEZI2xFTcgKvixh
        Axz5TLxiM4owSnNyKSyLSd0exNAuKHsxIZzhtuNYdQ7A4JyeUS0b8vutH5WmM0XD+KGqLIQtFWT
        KOkRfRyNEpr9jOLcpffp0O2DkVoTbMLIKxZt2Kjg=
X-Received: by 2002:a9d:803:0:b0:690:d198:4d1e with SMTP id 3-20020a9d0803000000b00690d1984d1emr1669414oty.8.1677789740522;
        Thu, 02 Mar 2023 12:42:20 -0800 (PST)
X-Google-Smtp-Source: AK7set+mzZi4KGEKQQVH4HIHgt8mr09sF5ZEI/y0N5gvVHOM4lDo9PhDEhWGcQyAF/1JU7UCO5GrTA==
X-Received: by 2002:a9d:803:0:b0:690:d198:4d1e with SMTP id 3-20020a9d0803000000b00690d1984d1emr1669391oty.8.1677789740223;
        Thu, 02 Mar 2023 12:42:20 -0800 (PST)
Received: from ?IPv6:2804:1b3:a7c3:d46d:73b6:f440:93a4:30? ([2804:1b3:a7c3:d46d:73b6:f440:93a4:30])
        by smtp.gmail.com with ESMTPSA id d11-20020a9d72cb000000b0068bcef4f543sm327296otk.21.2023.03.02.12.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 12:42:19 -0800 (PST)
Message-ID: <c010472791aa57c8ea838b5e85780f5be98898d5.camel@canonical.com>
Subject: Re: [PATCH 04/11] apparmor: simplify sysctls with
 register_sysctl_init()
From:   Georgia Garcia <georgia.garcia@canonical.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, ebiederm@xmission.com,
        keescook@chromium.org, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, jeffxu@google.com,
        ebiggers@kernel.org, tytso@mit.edu, guoren@kernel.org
Cc:     j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 02 Mar 2023 17:42:07 -0300
In-Reply-To: <20230302202826.776286-5-mcgrof@kernel.org>
References: <20230302202826.776286-1-mcgrof@kernel.org>
         <20230302202826.776286-5-mcgrof@kernel.org>
Organization: Canonical
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Thu, 2023-03-02 at 12:28 -0800, Luis Chamberlain wrote:
> Using register_sysctl_paths() is really only needed if you have
> subdirectories with entries. We can use the simple register_sysctl()
> instead.
>=20
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  security/apparmor/lsm.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
>=20
> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index d6cc4812ca53..47c7ec7e5a80 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -1764,11 +1764,6 @@ static int apparmor_dointvec(struct ctl_table *tab=
le, int write,
>  	return proc_dointvec(table, write, buffer, lenp, ppos);
>  }
> =20
> -static struct ctl_path apparmor_sysctl_path[] =3D {
> -	{ .procname =3D "kernel", },
> -	{ }
> -};
> -
>  static struct ctl_table apparmor_sysctl_table[] =3D {
>  	{
>  		.procname       =3D "unprivileged_userns_apparmor_policy",
> @@ -1790,8 +1785,7 @@ static struct ctl_table apparmor_sysctl_table[] =3D=
 {
> =20
>  static int __init apparmor_init_sysctl(void)
>  {
> -	return register_sysctl_paths(apparmor_sysctl_path,
> -				     apparmor_sysctl_table) ? 0 : -ENOMEM;
> +	return register_sysctl("kernel", apparmor_sysctl_table) ? 0 : -ENOMEM;
>  }
>  #else
>  static inline int apparmor_init_sysctl(void)

Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>

