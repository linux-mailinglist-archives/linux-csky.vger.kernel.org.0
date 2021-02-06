Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECAF311DB6
	for <lists+linux-csky@lfdr.de>; Sat,  6 Feb 2021 15:37:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBFOhL (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 6 Feb 2021 09:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhBFOhK (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sat, 6 Feb 2021 09:37:10 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D940DC061786
        for <linux-csky@vger.kernel.org>; Sat,  6 Feb 2021 06:36:29 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id m7so10730308oiw.12
        for <linux-csky@vger.kernel.org>; Sat, 06 Feb 2021 06:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=gHpg/EPVa3o65RxgJ93Dz4FsLimYxfPncA7a2KVCOQwfvvsopgfCoqbGZ3OasuDtBY
         NLaQ5/frJj5h2jUjGBBJEzaWoP2oO6/7hrQkWhLl+5EeYdY1YwYTV+qr/jcGShOxUfub
         9E6NngAQD+fMrFXDOTbE4lLu2U7SAW1Elxrfe/Nr1URYUHlfBs8WhANRFcWM6fuVVQxH
         x7WS+h4ADL1cTauhB3VSQd+Nq08/6sgSHVBcN8f5j9IAhiJ5wNhdGIQu1zdgn3TYRX0s
         9R0YuDxga+2YbnvpgRs0g2ub6wmafsaWw/5rV/WlV0TiEAzZENWPk+wOZ6eQxtRufx9J
         CPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=sY4fgq/DSyThalwU7QX+pWYKs/8sGH7ZznMUn5qQ1EY=;
        b=FLw1d2cHZDCfHNtuTK6E8RWYqUBgJR5jtLkwLvspgpjKI3vUEYa59iYMlyTs41cKgQ
         VjDRxVKLmp78kywbCp6tEEl9C6kdiv9ZfIFJl2uaoCFk8hNp0OUqsrQh2SwOMtIexbbh
         EaIFFSGAmkRRe18PuuZ1KZ+rvn+aXQ5aVOqMPPlhl0HR1gdnQ4FhoRIChsKlyWB291p9
         r0i8i5jinVLNYDNa5yQUuElF2tYRfRt8vMN7ktlLfFRubT7ocO23TRSRM2bdjeBQQoaz
         4pzqQgkU+ErGBduiXVD126YyEnP/5SZ3kRe1WMt67zQEZxYmU01gl1jSZy0rhI55ZmEK
         Uvkg==
X-Gm-Message-State: AOAM533mtHEnPO7yhbGqiIaZ1zck73w+6jGjwo8+rhxf0CrsWf+iRTz8
        eZqMr9+BMbAaSEA4C+f/3mknRlhQ8QwqHvisOAk=
X-Google-Smtp-Source: ABdhPJxxOkZ9eesacHgFT16nNuNsQv0hUyTQOKzDpKw383+60c+4v4cLHAWYmj3m8Pi3iOPWdpWUgdSl8/8QKjZ03zg=
X-Received: by 2002:aca:d4ce:: with SMTP id l197mr6047804oig.36.1612622188580;
 Sat, 06 Feb 2021 06:36:28 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:3e4c:0:0:0:0:0 with HTTP; Sat, 6 Feb 2021 06:36:28 -0800 (PST)
Reply-To: lawyer.nba@gmail.com
From:   Barrister Daven Bango <stephennbada@gmail.com>
Date:   Sat, 6 Feb 2021 15:36:28 +0100
Message-ID: <CAO_fDi_zRL0RZsSMJLO0kYQQR8Q-LoDSYrtGDk0k=aEez6w44Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

--=20
Korisnik fonda =C4=8Destitanja, Va=C5=A1a sredstva za naknadu od 850.000,00
ameri=C4=8Dkih dolara odobrila je Me=C4=91unarodna monetarna organizacija (=
MMF)
u suradnji s (FBI) nakon mnogo istraga. =C4=8Cekamo da se obratimo za
dodatne informacije

Advokat: Daven Bango
Telefon: +22891667276
(URED MMF-a LOME TOGO)
