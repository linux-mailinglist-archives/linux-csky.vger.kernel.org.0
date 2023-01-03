Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79EBF65BAE8
	for <lists+linux-csky@lfdr.de>; Tue,  3 Jan 2023 07:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbjACGrk (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 3 Jan 2023 01:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbjACGrI (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 3 Jan 2023 01:47:08 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C749639F;
        Mon,  2 Jan 2023 22:47:07 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3036kLwp036782;
        Tue, 3 Jan 2023 00:46:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672728381;
        bh=b0z+/hBdGdVLdLi21sE8VV0IYVdDrIzO1ouT2JZpjtM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BCFc5nTBx+vUGLfqxyuBUAEwmYbBXBfffMPEV2nyqZF5VYthxYtOkcB/9gZIooWq4
         CSAiwIeqhZudz9LbENd71VEOQI6zbF4J7ia3cKTGjNelcqL1IFV9x988A+j/z0SGUA
         IiWqhEAgrTW6PIq0nBxTWwCMbJahAMcChHGH5dXM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3036kLZ0077095
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Jan 2023 00:46:21 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 3
 Jan 2023 00:46:21 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 3 Jan 2023 00:46:21 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3036kKAR085946;
        Tue, 3 Jan 2023 00:46:20 -0600
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
Subject: [RFC PATCH 3/4] dt-bindings: panel: Introduce dual-link LVDS panel
Date:   Tue, 3 Jan 2023 12:16:14 +0530
Message-ID: <20230103064615.5311-4-a-bhatia1@ti.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230103064615.5311-1-a-bhatia1@ti.com>
References: <20230103064615.5311-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Dual-link LVDS interfaces have 2 links, with even pixels traveling on
one link, and odd pixels on the other. These panels are also generic in
nature, with no documented constraints, much like their single-link
counterparts, "panel-lvds".

Add a new compatible, "panel-dual-lvds", and a dt-binding document for
these panels.

Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
---
 .../display/panel/panel-dual-lvds.yaml        | 157 ++++++++++++++++++
 MAINTAINERS                                   |   1 +
 2 files changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml
new file mode 100644
index 000000000000..88a7aa2410be
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml
@@ -0,0 +1,157 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/panel-dual-lvds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Generic Dual-Link LVDS Display Panel
+
+maintainers:
+  - Aradhya Bhatia <a-bhatia1@ti.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+description: |
+  A dual-LVDS interface is a dual-link connection with the even pixels
+  traveling on one link, and the odd pixels traveling on the other.
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/display/lvds.yaml/#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - lincolntech,lcd185-101ct
+              - microtips,13-101hieb0hf0-s
+          - const: panel-dual-lvds
+      - const: panel-dual-lvds
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: The sink for first set of LVDS pixels.
+
+        properties:
+          dual-lvds-odd-pixels:
+            type: boolean
+
+          dual-lvds-even-pixels:
+            type: boolean
+
+        oneOf:
+          - required: [dual-lvds-odd-pixels]
+          - required: [dual-lvds-even-pixels]
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: The sink for second set of LVDS pixels.
+
+        properties:
+          dual-lvds-even-pixels:
+            type: boolean
+
+          dual-lvds-odd-pixels:
+            type: boolean
+
+        oneOf:
+          - required: [dual-lvds-even-pixels]
+          - required: [dual-lvds-odd-pixels]
+
+    allOf:
+      - if:
+          properties:
+            port@0:
+              properties:
+                dual-lvds-odd-pixels: true
+              required:
+                - dual-lvds-odd-pixels
+        then:
+          properties:
+            port@1:
+              properties:
+                dual-lvds-even-pixels: true
+                dual-lvds-odd-pixels: false
+
+      - if:
+          properties:
+            port@0:
+              properties:
+                dual-lvds-even-pixels: true
+              required:
+                - dual-lvds-even-pixels
+        then:
+          properties:
+            port@1:
+              properties:
+                dual-lvds-odd-pixels: true
+                dual-lvds-even-pixels: false
+
+    required:
+      - port@0
+      - port@1
+
+  port: false
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - width-mm
+  - height-mm
+  - data-mapping
+  - panel-timing
+  - ports
+
+examples:
+  - |+
+    panel-dual-lvds {
+      compatible = "microtips,13-101hieb0hf0-s", "panel-dual-lvds";
+
+      width-mm = <217>;
+      height-mm = <136>;
+
+      data-mapping = "vesa-24";
+
+      panel-timing {
+        clock-frequency = <150275000>;
+        hactive = <1920>;
+        vactive = <1200>;
+        hfront-porch = <32>;
+        hsync-len = <52>;
+        hback-porch = <24>;
+        vfront-porch = <24>;
+        vsync-len = <8>;
+        vback-porch = <3>;
+        de-active = <1>;
+      };
+
+      ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+          dual-lvds-odd-pixels;
+          lcd_in0: endpoint {
+            remote-endpoint = <&oldi_out0>;
+          };
+        };
+
+        port@1 {
+          reg = <1>;
+          dual-lvds-even-pixels;
+          lcd_in1: endpoint {
+            remote-endpoint = <&oldi_out1>;
+          };
+        };
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427..c13f24293ab1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6595,6 +6595,7 @@ T:	git git://anongit.freedesktop.org/drm/drm-misc
 S:	Maintained
 F:	drivers/gpu/drm/panel/panel-lvds.c
 F:	Documentation/devicetree/bindings/display/lvds.yaml
+F:	Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml
 F:	Documentation/devicetree/bindings/display/panel/panel-lvds.yaml
 
 DRM DRIVER FOR MANTIX MLAF057WE51 PANELS
-- 
2.39.0

