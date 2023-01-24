Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824436794E0
	for <lists+linux-csky@lfdr.de>; Tue, 24 Jan 2023 11:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjAXKNW (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 24 Jan 2023 05:13:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAXKNV (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 24 Jan 2023 05:13:21 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6994222E4;
        Tue, 24 Jan 2023 02:13:19 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 30OACjLK088019;
        Tue, 24 Jan 2023 04:12:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1674555165;
        bh=y98f6JcfN3LVqyfn9v+xxR4SH8jrP9djJmUQfnsRA+I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vIO7JTDHunTiaXAQlODfNliKQgBNy2A0nZV0gDriJb+DF3O5vloTrdDd2ZGhGtEYt
         MyWvysPDEdrGHumeDN/i1XMdMymDyUQ7RGnhi3d72kZ6bbX//e08Otx5ypLURvvt89
         XoOCG1blH8mNbbc1CVk16p5ND+lmT/bW56CCzlHE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 30OACjTo070565
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 24 Jan 2023 04:12:45 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 24
 Jan 2023 04:12:45 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 24 Jan 2023 04:12:45 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 30OACiY0018496;
        Tue, 24 Jan 2023 04:12:45 -0600
From:   Aradhya Bhatia <a-bhatia1@ti.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guo Ren <guoren@kernel.org>
CC:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux RISC-V List <linux-riscv@lists.infradead.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Mediatek List <linux-mediatek@lists.infradead.org>,
        Linux C-SKY Arch List <linux-csky@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Aradhya Bhatia <a-bhatia1@ti.com>
Subject: [PATCH v2 4/4] drm: panel-lvds: Introduce dual-link panels
Date:   Tue, 24 Jan 2023 15:42:38 +0530
Message-ID: <20230124101238.4542-5-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124101238.4542-1-a-bhatia1@ti.com>
References: <20230124101238.4542-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Add a new compatible, "panel-dual-lvds".

Dual-link LVDS interfaces have 2 links, with even pixels traveling on
one link, and odd pixels on the other. These panels are also generic in
nature, with no documented constraints, much like their single-link
counterparts, "panel-lvds".

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 drivers/gpu/drm/panel/panel-lvds.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index de8758c30e6e..bf6f84af0730 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -241,6 +241,7 @@ static int panel_lvds_remove(struct platform_device *pdev)
 
 static const struct of_device_id panel_lvds_of_table[] = {
 	{ .compatible = "panel-lvds", },
+	{ .compatible = "panel-dual-lvds", },
 	{ /* Sentinel */ },
 };
 
-- 
2.39.0

