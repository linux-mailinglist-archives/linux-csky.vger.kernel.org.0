Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583024EB5C6
	for <lists+linux-csky@lfdr.de>; Wed, 30 Mar 2022 00:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiC2WUz (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 29 Mar 2022 18:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236609AbiC2WUy (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 29 Mar 2022 18:20:54 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075D1522E9
        for <linux-csky@vger.kernel.org>; Tue, 29 Mar 2022 15:19:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q20so11194364wmq.1
        for <linux-csky@vger.kernel.org>; Tue, 29 Mar 2022 15:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=jpwuI1yldKV1VcBLTuMgiGibAn1GNBEhWkHYPzE4kjoiNskcwLddxdK0RGx9CVNG1x
         egRfQEOIACa/2sf35QjwufxH09wd/0eqNjBlp28/rS+rikrgsVuUzpPaxTyiSXj6fKsa
         dqaQzDCIFUJd4lEN6qXjd5vpyg/gCG0/gDFgorlTDfvLK4WXqU1XkMU97Ya2uuUv51nb
         StRJu0CqSlS2MoF7Nwt+hmIvjUqjCXCyB3dX+pX8MMbaXLHfgGZPE521XUOzt+3J6460
         yNcMlwjqb+1jmqt1ybd2TKaJz9mj4FBvE5QSXtNFIy+X5PbXbrTVnkLQ4K35ymN7ffi2
         ny6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=kfMifiI5/NgnNytDNw4nNrJtDAa6xkglzAJHJcTjPA+46u5b1NQ7gCLxIiayHllwhA
         Fq2AORuSfmeBHI3qY3I4J5B74LC4BxDBXBjlUzo+ZiFadJ9B86sCTUeZB8Yp6ypy0y9D
         9XtUwaGnrUCAfAZN5dbiSVvx8UhTuynTb8GM8H0TUaNjK0lhpJF4olfD9vi6kyTGFE+E
         2UB9w6juUe/T61/MxS31JKaVsDCC3Is85a/sMN1Dr7O24yaoBpmCjr0zcWhDibjZYOku
         iwoHQWySBwc874wJ3GezvXnY/vrTm8Qf5F635ldAp99ItRx+mhdvhD4XIi2l75z+q7cM
         J0WA==
X-Gm-Message-State: AOAM530kTejJSA9Hty3641xCrQU7+y8Emgp8aiNqbVGjBAHSNynI5eCx
        L/VrTrRIDW+mqOPaHgZoNn4=
X-Google-Smtp-Source: ABdhPJw9Jp/UkPhh9Siui1Y5tTtJ8irThMonnYbB260MsuLEv1cG3+BxGfP7P61t57A5plvvzsfrgA==
X-Received: by 2002:a05:600c:a4a:b0:389:e8fd:54b4 with SMTP id c10-20020a05600c0a4a00b00389e8fd54b4mr1533107wmq.168.1648592349662;
        Tue, 29 Mar 2022 15:19:09 -0700 (PDT)
Received: from [172.20.10.4] ([102.91.4.172])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c4ed100b0038ca32d0f26sm3545064wmq.17.2022.03.29.15.19.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 15:19:08 -0700 (PDT)
Message-ID: <624385dc.1c69fb81.545b4.ec42@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Gefeliciteerd, er is geld aan je gedoneerd
To:     Recipients <adeboyejofolashade55@gmail.com>
From:   adeboyejofolashade55@gmail.com
Date:   Tue, 29 Mar 2022 23:19:00 +0100
Reply-To: mike.weirsky.foundation003@gmail.com
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3 autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Beste begunstigde,

 Je hebt een liefdadigheidsdonatie van ($ 10.000.000,00) van Mr. Mike Weirs=
ky, een winnaar van een powerball-jackpotloterij van $ 273 miljoen.  Ik don=
eer aan 5 willekeurige personen als je deze e-mail ontvangt, dan is je e-ma=
il geselecteerd na een spin-ball. Ik heb vrijwillig besloten om het bedrag =
van $ 10 miljoen USD aan jou te doneren als een van de geselecteerde 5, om =
mijn winst te verifi=EBren
 =

  Vriendelijk antwoord op: mike.weirsky.foundation003@gmail.com
 Voor uw claim.
