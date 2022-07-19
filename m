Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A6657AA21
	for <lists+linux-csky@lfdr.de>; Wed, 20 Jul 2022 01:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbiGSXC2 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 19 Jul 2022 19:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240075AbiGSXCF (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 19 Jul 2022 19:02:05 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B628A61727
        for <linux-csky@vger.kernel.org>; Tue, 19 Jul 2022 16:02:02 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id f73so29013676yba.10
        for <linux-csky@vger.kernel.org>; Tue, 19 Jul 2022 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=IidRqp259LnIGwKSY8eSnwY2pSvVpnXgD6l4DtZ0nS1en5/eIODexxA8HY1P3fOj1G
         k3L2dqT2adyYNMP0Xveqboy+8rHiXHxkUk7eN+Z4c1u4A1dmYZTv8XeBq3Mcqc8JpY/J
         Y+FZqCw+ctBHW93xydCMO1T2zbJgKE6zi4yOKnSgCU0wXAb68jTgzbksOw/WF0fuySr4
         IszSqaPAblIoqFUVbDoenHDcU4oM8zz2T2X2YOFu4paIHinYHYAEpHDagNDILO9VwXpP
         1+8RZDNcKixJbUOVKzMHhr00ZyE0o1uffduD4Jla0qSaybMZB4f9mMaQZtZwFiKbVkVp
         7loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=qwtX4V9v0PSwZTKmpOw0/bqT+kysuJfie0sepMsnmgxb8hT/L0QIwGXo+EBivf3i4m
         PQflZCv+97rQkQEbsDby/X0fQ7rlQ6esxU6CdYN6ZebVpCkVyJzH+Jk9MpkGYMZ3bMXg
         KAQz7UL4YYnYvvpl3Xggv8RNx3BrsivP9wTwyz1ISTS9Mc8GeGFR6zbRIiV8rqd1WmtW
         hFc6Y8AR4CS7pldyCchFdKq+5d2YU67Pwi32zEsH1GpkCFuz5zqTboI+uyqhenBNkhK5
         ekboNp8mxVwibNeAg/MQz9sDMZqQwoBcrYCSnJICS49zaoaxuQbor7t3dJhuICajg/KM
         zigA==
X-Gm-Message-State: AJIora9ag1KdD0U5e+NCHkrai8N8xTW4G8YTjqQNgJRphwF4wvo1Pw35
        K5QW26I/cAzsdsjUJkpCKyUEvLL274hLeGK0U+k=
X-Google-Smtp-Source: AGRyM1sl0J4NyfzC2f29bqXT9oPchs8cDVndRHRbS2Q3refz6ns6Y35SIupBWILMCNYHx3pJ+wk7AlhI9UdwA1sMqK0=
X-Received: by 2002:a25:850b:0:b0:66c:d287:625a with SMTP id
 w11-20020a25850b000000b0066cd287625amr35727355ybk.31.1658271721069; Tue, 19
 Jul 2022 16:02:01 -0700 (PDT)
MIME-Version: 1.0
Sender: belloashawu72@gmail.com
Received: by 2002:a05:7000:26b1:0:0:0:0 with HTTP; Tue, 19 Jul 2022 16:02:00
 -0700 (PDT)
From:   Lisa Williams <lw23675851@gmail.com>
Date:   Wed, 20 Jul 2022 00:02:00 +0100
X-Google-Sender-Auth: BO4DmyfvjRINBOwOOpcYOq24sHk
Message-ID: <CAOjupQKQ6zRjFB_6SefXkEmKaf0_dwC_KfS2LmZFQLFEaDr30A@mail.gmail.com>
Subject: My name is Dr Lisa Williams
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lisa
