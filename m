Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC46440B78
	for <lists+linux-csky@lfdr.de>; Sat, 30 Oct 2021 21:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbhJ3T3U (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 30 Oct 2021 15:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhJ3T3T (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sat, 30 Oct 2021 15:29:19 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88DCC061767
        for <linux-csky@vger.kernel.org>; Sat, 30 Oct 2021 12:26:48 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id d10so22497813ybe.3
        for <linux-csky@vger.kernel.org>; Sat, 30 Oct 2021 12:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mCr5/4rNHz6GYCicN2tT+Hiw70XmtWpugzIrUIfj/IA=;
        b=pOkgD/CTaK49AVoAP0oXhyBA0xxRbjX0YWExIBKqS6NUKccr3vLUgYYp77efnHc4PU
         6E9PgaVlKQRsSMGdWFhvkLMEhnIlezx2NFx2GFSTCXc/g4DhI9uIoEshDZ2N6aoHn6Fd
         UC799NaS2VU+whl+HFnl3NIl9z5VCc1GpGHXXmBIqDD1Jmc8xeRvRRme3tio0f8Dngz3
         pEDoXS3D6wQAJQb4D15aersNaN9CMhVqFCFp1cAxnjnolKMXXX0njqLqpZCwdYq0N6C0
         mCMbjLCF8uF4TEttI22glWIdvZMzQ6QX/xLA1FApeT7EViPztol3r8Qw5Nod/70+MxmM
         uFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=mCr5/4rNHz6GYCicN2tT+Hiw70XmtWpugzIrUIfj/IA=;
        b=1NsU/ryqWsD16GEBF+FnqI/vjo57/9xlpyVxiM9zTdDGyG2LmO9TyyCoIkIvHUfUZR
         WWAIGaFG5fWrjsfPT73lwTS6a1YrHaWJKgk1UQDecFAfuVR01N6Kyu4MQBgPTPwhamrG
         FlmLhYxOV4z6NIJ2owu4dUghXuqzPMa1lnsgPHxDsOLlWWq0+B9lsP6LYvIhHOrsOqu3
         9z+AFte8IgvRKGyf6t2zlpMsMgbhq/67o2JhgxLYLC0yW+GZnNyfp47kQKRFz7vK6zeQ
         y71TN0RjwI2f490ssq+NxaX9TBcPPh0KWDvFKsrxjKst5U3PMQdxvDZSn8qsLaJcvcnq
         GQYQ==
X-Gm-Message-State: AOAM532GG8BaqoV+G8oAiMkrJaS1FBhuWGvaVOS86c6fhkALTe9TwdIO
        QJoDeSOrHcGcUjaJFgzze5Clf6OgU7BkGTV5myk=
X-Google-Smtp-Source: ABdhPJxUq6CRWqB0SNTfhi0Y8EqcmyncFVrg/VVbnooWKevxllNSfoO3GpXKQy4HrIMKNIu9s1vCLfwT5nH0e+cgPt4=
X-Received: by 2002:a25:6185:: with SMTP id v127mr871489ybb.100.1635622008005;
 Sat, 30 Oct 2021 12:26:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7110:3341:b0:100:c391:ea15 with HTTP; Sat, 30 Oct 2021
 12:26:47 -0700 (PDT)
Reply-To: barrcharleskoffi002@gmail.com
From:   charles koffi <barrcharleskoffi003@gmail.com>
Date:   Sat, 30 Oct 2021 21:26:47 +0200
Message-ID: <CAE9QbT7qmq6EOZLkQ2fQ_yY+6CWZc+eW5aGiBuM6unWunmJ3=A@mail.gmail.com>
Subject: If you are interested, get back to me so that I can give you
 comprehensive details on how to proceed.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Hello, Good Day,
I have emailed you twice with no response. It is with trust and
sincerity that I approach you, please accept my apologies if my email
violates your personal ethics. My name is Charles Koffi, I am a
private lawyer based here in Lom=C3=A9, Togo.
I contacted you to act as the next of kin to my deceased client, a US
citizen who made a deposit of $9.6 million with a Bank here in Togo.
He died in a car accident on April 21, 2011, with his wife and only
daughter without any registered next of kin. Several efforts were made
to find his extended family through their embassy but without success.
I have received an official letter from my client's bank suggesting a
likely proceeding for confiscation of the Fund in line with existing
laws of Togo. According to the Government Law here, at the expiration
of 10 years, the fund will revert to the ownership of the Togo
Government, if nobody applies to claim the fund. It=E2=80=99s been 10 years
and six months now and no one has come forward to claim the fund.
My proposition to you is to present you to the bank as the Next of kin
to my late client for the bank to pay the $9.6 Million Dollars to you
as his beneficiary so that we can share the amount on a mutually
agreed percentage of 45% for me 45% for you and 10% will be donated to
charity than having the Government confiscate the fund.
All legal documents to back up your claim will be provided by me. All
I require is your honest cooperation to enable us to see this
transaction through. I also guarantee you that this will be executed
under a legitimate arrangement that will protect you from any breach
of the law here or in your country, as I will use my legal power as
the deceased family lawyer to perfect the smooth transfer of the $9.6
Million Dollars to your account.
If you are interested, get back to me so that I can give you
comprehensive details on how to proceed.
Your immediate response will be highly appreciated.
Yours sincerely,
Barrister Charles Koffi,
