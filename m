Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B60C7344CB
	for <lists+linux-csky@lfdr.de>; Sun, 18 Jun 2023 05:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjFRDdk (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 17 Jun 2023 23:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjFRDdi (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sat, 17 Jun 2023 23:33:38 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413D7BE
        for <linux-csky@vger.kernel.org>; Sat, 17 Jun 2023 20:33:37 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-55b3d77c9deso1689453eaf.0
        for <linux-csky@vger.kernel.org>; Sat, 17 Jun 2023 20:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687059216; x=1689651216;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wWTmMQSsiLodfdKu7C8lcuyX7WesZia949PML8BXbEI=;
        b=Yg1i1pWU5GTt025oqiO+Fa5DRnlwycRV7fzBXdYJBKG0NdxpYSsicZB2OfgeXACKdb
         46WGp+EWRipVItU28c9raRy5nHMyju0oz/+DKQra8Yo/ifK2iUGO2swVAJBXEg3ZiHNN
         1eB8ilQyDp6/buiCBunYPNNe1uKItfvXrFwG54+/PLss6QLrieMTQEqW5YcbL1yv7JIi
         KDm7a18VNHwiJc+Z4zoTKtgTW0fDctMSC+/IRLqzSlQLHwRbTl+j+8R24xz2pXhEV96S
         wj3CEDk949g7AO87Q64R7gzRWmJmdF/tYEgR+DP+7GA8OJmyXgoODskx5oc1KELk36b6
         pW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687059216; x=1689651216;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wWTmMQSsiLodfdKu7C8lcuyX7WesZia949PML8BXbEI=;
        b=aWrB/k1Bepiu5AYXQ/b5FvStz0RzPNGMKcBSfktNBaNQ7s+inV28DE1TFJfLRr81f1
         UFqreC9uqUTLWXjZjDYAw5Br7t1ioNcdDJ7ETw9QIKk6yqj84Rt87seXtS23PFdAWn81
         q1gE00u5PGdBtl/tkYhB7jppKYt4zRkgNtL6LMCS8+Jk/H+TNmaYRYRXii1yZRm0y9kt
         WMP1C3pRMokfKHzJ5V2GrDiaepQbuj1mesOZ4bf7rna391eIFwSi83r495/NaDDCKCJe
         23E0oZL5sjzqe3cFyslxu113F/uQoSq86tMMG6k+aH3R7TMc6myja70MhD7/EwSdn/G8
         XTLQ==
X-Gm-Message-State: AC+VfDz3fu4N6N7Hu4D6CYrTEMpdYNmzh3IXmprhHWZAp3Jc7dJyLI5x
        SGwaXnZH34+DqpCmWFq8vpU2M/qRqMegD1Saa98=
X-Google-Smtp-Source: ACHHUZ7FZ2E+IDVAepfUpEzR2FA4RobRbUv2ntIQNha2zxzfscsHEpsOpOTHlbUlxkmh+DYx95RcFdKV8E1du5ESSPI=
X-Received: by 2002:a4a:3956:0:b0:55b:85b9:68f5 with SMTP id
 x22-20020a4a3956000000b0055b85b968f5mr3363529oog.3.1687059216485; Sat, 17 Jun
 2023 20:33:36 -0700 (PDT)
MIME-Version: 1.0
Sender: hubertinecoul@gmail.com
Received: by 2002:ac9:5b55:0:b0:4d9:6a76:96b3 with HTTP; Sat, 17 Jun 2023
 20:33:36 -0700 (PDT)
From:   "Mrs. Ruth Roberto" <robertoruth48@gmail.com>
Date:   Sat, 17 Jun 2023 19:33:36 -0800
X-Google-Sender-Auth: cdVRiWXgWrSgICgdhA9FurFo6zY
Message-ID: <CAAEzwMkTLiodBhF-hR1AEvWvo=J_nAAD+_zEVPULXgib7zTwQQ@mail.gmail.com>
Subject: I trust in God
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MONEY_FRAUD_3,NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Dear,
It is true we do not know each other before but please bear with me,
I=E2=80=99m writing you this mail from a Hospital bed. My name is Mrs.
Ruth Roberto. I am a widow and very sick now. I am suffering from
Endometrial Cancer which my doctor has confirmed that I will not
survive it because of some damages. Now because of the condition of my
health I have decided to donate out my late husband hard earn money
the sum of ($3, 500,000.00) Three Million, Five Hundred Thousand Us
Dollars on Charity Purpose through your help.if you are interested get
back for more details.
Mrs. Ruth Roberto
