Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD9B61DA6B
	for <lists+linux-csky@lfdr.de>; Sat,  5 Nov 2022 13:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiKEMnx (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 5 Nov 2022 08:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiKEMnw (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sat, 5 Nov 2022 08:43:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DED32317D
        for <linux-csky@vger.kernel.org>; Sat,  5 Nov 2022 05:43:52 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id a67so11132951edf.12
        for <linux-csky@vger.kernel.org>; Sat, 05 Nov 2022 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=mPMWJSv9+I/YyfOX/KhSq6QJxEVF9czxBjlZfOBHyBNprqZzbXMAaGfMuCUz15WUgd
         P8+TrngI9Rc3ViQGUSuldljbiqwUWen18O0hqt/Ie0OeGmALridq11sGaHqFDDc4lalJ
         acwKewZa0Z+JmHCFhOB1EPm3VoCXqyskBeWh+qI8WdUTyGDi2ZRZxfd09WAIYwZTAuE6
         D6FM36pRhxYi0ioJBBk7CWNeJYL6Gz2n7XR51nKKfVaOUPERzSe8HFAiowZB91Qmwfcs
         4SUmlVM/PGDPqE9RxpsHH7kHCVf7N827dpoIMP0fu4UEVHZDK4bGxZoR2Xec1mMJWH/r
         0h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=Z/pXSZ1hE4ZPXHEoUXRkNzeQFo15kzLGT3MCOaEcnIxKyLGWMgoFMnryLThcDv9YDF
         8AK1MiXVRuFGq7gjXqZ8S4ryxv2HRMUh/qeoCmikv5RFLaiY+vNNJ2TZ3R95lDmjd+NP
         WpWrq+CEuX40a0ezZVHzUqzELK8oAraDoTEplilqepXdK+V2kAbvIHsO1rPx9fh/q3lN
         /F+JKq/kJJRIY1/Rxe9+yJ6ql2blM9I1vSXYRx5cbF5S+JZcAbwOQjIUZi9C+FOaCaWy
         BcANP0Qxrd2g3eFW/2NIkJC9ahAvWjReMq3lBFZeylrO0x8PzntSHIpDJa/9sH0pM9ki
         WqSQ==
X-Gm-Message-State: ACrzQf0F67nvq5i+Lx1Ylw3qx75LvToIxUdicFYAgz7SjY9M4fIAyVqB
        ceFGZOW1C60netX7sjIBjwWnpO0SXN0jvDV016E=
X-Google-Smtp-Source: AMsMyM6+i/60GLAa/SmSMCVLMrWq6VlVwX7X2L0dN+kFhjV6izdhKjpdEAZB1JmiGGgnIYpSeGh29lOxg8cgnriAXMM=
X-Received: by 2002:aa7:c504:0:b0:461:122b:882b with SMTP id
 o4-20020aa7c504000000b00461122b882bmr41194609edq.14.1667652230661; Sat, 05
 Nov 2022 05:43:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:33:b0:5c:ee07:e4f3 with HTTP; Sat, 5 Nov 2022
 05:43:49 -0700 (PDT)
Reply-To: stefanopessia755@hotmail.com
From:   Stefano Pessina <francisnzioka80@gmail.com>
Date:   Sat, 5 Nov 2022 15:43:49 +0300
Message-ID: <CAL5scYq=1B=-RX8Eh9M9tf4CevQNnnh7JZ63=g4o=AHLN+9dbg@mail.gmail.com>
Subject: Geldspende
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

--=20
Die Summe von 500.000,00 =E2=82=AC wurde Ihnen von STEFANO PESSINA gespende=
t.
Bitte kontaktieren Sie uns f=C3=BCr weitere Informationen =C3=BCber
stefanopessia755@hotmail.com
