Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED3517DF444
	for <lists+linux-csky@lfdr.de>; Thu,  2 Nov 2023 14:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjKBNsU (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 2 Nov 2023 09:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjKBNsT (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 2 Nov 2023 09:48:19 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9A183
        for <linux-csky@vger.kernel.org>; Thu,  2 Nov 2023 06:48:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28035cf6a30so917286a91.3
        for <linux-csky@vger.kernel.org>; Thu, 02 Nov 2023 06:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698932897; x=1699537697; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=iEdJtCz9oT8GSY3+FeeJpRlcmZRPpdhnpq7Tflld/QmE770Q71JaO9GNxpYrcjHMHs
         1cnNoS+2xJAxZeJaZK9v5xTyotPAMVnW5xrCEv3KBcgZAanTe6YQYspLYLaBngdYalik
         DUi7aRNC5c5O48ZUW6dEJ0r9S0F+Xuw0gdlvHjrX/Q6HVcbIVdSVz6+GWSaFE3fNxKn4
         oTDp9fKFV7a8nsYwRoYBZUs/OIqCp0fKmG1DI2JP60K+aAxHEtE3MCmEv3uUGqLScIyA
         ioL5D12JgItnTUb5nlzVYFN/6ovhrIchlvbe2Yc+YpYz5DuwJp9H4l8o5sHFeN5yCBnE
         4+5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698932897; x=1699537697;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=NkPpKkL2O4nMfCIDp7UnrWBPKKHe/RqV6YDEZLM5cB7f4Srmie46I9CXbrB33hNc0c
         abA1ythft7477UMOzip3XcIbkxpdIOO7YzftLtWjeR+4GOHZBFXSbfJxdfkkkLqv+iV+
         waTwj7RzGDXMRXpvnI+BHes89WvaQOg2Vziq0qZUJfzlv59WLOuFn1lfpnnyFsR0Y9QL
         ZszFQr08Aq93+f00zve6qqCZvVUmfphe73b1UI/CoT4eJkDyWnbLAYIBWjcZ+dEChYZs
         zX+xvQ23YqAPkQV5GYbiJU5l7fzAwzNAFFrOz9nM5Mt+nk+aK3ulePXJJbuGMc4iSRqO
         D4Dg==
X-Gm-Message-State: AOJu0YzVTyK/5SkTRU5u9Lydo5ToV9JYJNj966K0MvhChSfbm697dc4q
        thbOWmrfCT4Kv+h6F7VEqGVgaTDqxbrzQh2Cus0=
X-Google-Smtp-Source: AGHT+IHtTlz3yoO7+ORBQ7FRS7jCYrXOxtHtV3HDxcv1CW5Z5bWS+gKTisI53ZCgRk9awCStY4lZHopnPa022wKkJj4=
X-Received: by 2002:a17:90b:1a8d:b0:274:616e:3fc4 with SMTP id
 ng13-20020a17090b1a8d00b00274616e3fc4mr15243919pjb.34.1698932896879; Thu, 02
 Nov 2023 06:48:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:92b:b0:6e:e303:a059 with HTTP; Thu, 2 Nov 2023
 06:48:16 -0700 (PDT)
Reply-To: oj616414@gmail.com
From:   johnson pattaego <alidjiman00229@gmail.com>
Date:   Thu, 2 Nov 2023 13:48:16 +0000
Message-ID: <CAECK7AYJ973G-p5dG7z6XN6w6Y9eoMqnWh8fd5W==RmNs0Wayw@mail.gmail.com>
Subject: =?UTF-8?B?w5xkdsO2emzDtm0sIHZhbiBlZ3kgdsOhbGxhbGtvesOhc29tLCBhbWVseXJlIMO6Z3kgaA==?=
        =?UTF-8?B?aXZhdGtvenRhbSByw6FkLCBtaW50IG5la2VkIHVneWFuYXogYSB2ZXpldMOpa27DqXYsIG1pbnQgYSBu?=
        =?UTF-8?B?w6loYWkgw7xneWZlbGVtLCBkZSBhIHLDqXN6bGV0ZWsgYXogYWzDoWJiaWFrIGxlc3puZWsgw6lydGVz?=
        =?UTF-8?B?w610asO8ayDDlm50LCBhbWlrb3IgbWVnZXLFkXPDrXRpIGVubmVrIGF6IGUtbWFpbG5layBhIGvDqXpo?=
        =?UTF-8?B?ZXp2w6l0ZWzDqXQuIMOcZHbDtnpsZXR0ZWw=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,EMPTY_MESSAGE,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org


