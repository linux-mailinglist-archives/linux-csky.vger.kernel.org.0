Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D718E4B0886
	for <lists+linux-csky@lfdr.de>; Thu, 10 Feb 2022 09:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbiBJIgy (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 10 Feb 2022 03:36:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbiBJIgy (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 10 Feb 2022 03:36:54 -0500
X-Greylist: delayed 346 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 00:36:54 PST
Received: from mail.trixen.pl (mail.trixen.pl [192.71.213.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C320BE4F
        for <linux-csky@vger.kernel.org>; Thu, 10 Feb 2022 00:36:54 -0800 (PST)
Received: by mail.trixen.pl (Postfix, from userid 1001)
        id 523FA40A3E; Thu, 10 Feb 2022 09:31:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trixen.pl; s=mail;
        t=1644481866; bh=J50dbWEn9x62xyxY1PWPtYxMwNMcDFoILqXfzM3his0=;
        h=Date:From:To:Subject:From;
        b=rnYPBR89AdObilYlIGLBFYdi6o7A1yniyKm4QrruqeZDAQluVZTkeGmLho8g3Iq2T
         eLmLxw5yG3l/ggM0IJksPApjdog6mCKJ5qjNlC/XdqGSpWdT8KzUIeMnRQoA3ffrOB
         RRGbMBu5Nn/tN4qcAf+jo6REa/sn3ziIot1Mgk7DVKkLFsWFg5pdOZx5bj8GWJoXhz
         FMi4wVNxBEzDbSE2r8tFvUM3L/N3dD54jqOm+rd0CKqYt+ZNsBAXCh7xQXgUwLE/q4
         3WVkCTbHavQu8Telb0NiTlZr4ugGsA+o1zTVIOXEGFYwA7Q8o9dmWqbCq+INgSHxD0
         b/+hmiAEVwxbw==
Received: by mail.trixen.pl for <linux-csky@vger.kernel.org>; Thu, 10 Feb 2022 08:30:57 GMT
Message-ID: <20220210084500-0.1.t.1svo.0.wd9bj0jk6b@trixen.pl>
Date:   Thu, 10 Feb 2022 08:30:57 GMT
From:   =?UTF-8?Q? "Rados=C5=82aw_Grabowski" ?= 
        <radoslaw.grabowski@trixen.pl>
To:     <linux-csky@vger.kernel.org>
Subject: Monitorowanie samochodu
X-Mailer: mail.trixen.pl
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Dzie=C5=84 dobry,

Chcia=C5=82bym przedstawi=C4=87 rozwi=C4=85zanie, kt=C3=B3re poprzez wyko=
rzystanie GPS monitoruje samochody w czasie rzeczywistym.=20

Dzi=C4=99ki temu mog=C4=85 Pa=C5=84stwo odczytywa=C4=87 wszelkie warto=C5=
=9Bci dotycz=C4=85ce np. zu=C5=BCycia paliwa czy obrot=C3=B3w silnika.

System automatycznie generuje rozbudowane raporty i pozwala dokonywa=C4=87=
 istotnych analiz.

Je=C5=BCeli interesuje Pa=C5=84stwa zwi=C4=99kszenie wydajno=C5=9Bci prac=
y i kontrola wszelkich parametr=C3=B3w floty - prosz=C4=99 o kontakt.


Pozdrawiam,
Rados=C5=82aw Grabowski
