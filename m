Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE64866DDC2
	for <lists+linux-csky@lfdr.de>; Tue, 17 Jan 2023 13:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbjAQMjG (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 17 Jan 2023 07:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236129AbjAQMjF (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 17 Jan 2023 07:39:05 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52BC535252;
        Tue, 17 Jan 2023 04:39:04 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B5E8310C;
        Tue, 17 Jan 2023 13:38:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673959141;
        bh=0xanUWyMoxJnvXqqNZ5UOGy3oyg6sQdr/aJLg0bLmX0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lhXA6EOBtju3hz7RVGApa3gFkm8IjwyEevWIttJjwuSssA6tWWX3VMk4dP6KCwshf
         D1TXAw5l8b9t1Vd5W0sbVT1fBO26Skg59JiGVMd89TgWhDkXbpcp0S0PTFKKS9B67y
         fFirV+o2rzHN81rIAuhffeTrNvXXekunotwKsK54=
Message-ID: <808e831f-4282-0e58-ebb2-2f556aaeaca4@ideasonboard.com>
Date:   Tue, 17 Jan 2023 14:38:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [RFC PATCH 3/4] dt-bindings: panel: Introduce dual-link LVDS
 panel
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
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
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230103064615.5311-1-a-bhatia1@ti.com>
 <20230103064615.5311-4-a-bhatia1@ti.com>
 <09f1ca83-c7d5-a186-6fa6-09cdd7a0b9cc@collabora.com>
 <431ddd82-055b-2526-3d5e-f6563e48d264@ti.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <431ddd82-055b-2526-3d5e-f6563e48d264@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 09/01/2023 18:21, Aradhya Bhatia wrote:
> Hi Angelo,
> 
> Thanks for taking a look at the patches!
> 
> On 03-Jan-23 17:21, AngeloGioacchino Del Regno wrote:
>> Il 03/01/23 07:46, Aradhya Bhatia ha scritto:
>>> Dual-link LVDS interfaces have 2 links, with even pixels traveling on
>>> one link, and odd pixels on the other. These panels are also generic in
>>> nature, with no documented constraints, much like their single-link
>>> counterparts, "panel-lvds".
>>>
>>> Add a new compatible, "panel-dual-lvds", and a dt-binding document for
>>> these panels.
>>>
>>> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
>>> ---
>>>   .../display/panel/panel-dual-lvds.yaml        | 157 ++++++++++++++++++
>>>   MAINTAINERS                                   |   1 +
>>>   2 files changed, 158 insertions(+)
>>>   create mode 100644 
>>> Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml
>>>
>>> diff --git 
>>> a/Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml b/Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml
>>> new file mode 100644
>>> index 000000000000..88a7aa2410be
>>> --- /dev/null
>>> +++ 
>>> b/Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml
>>> @@ -0,0 +1,157 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/display/panel/panel-dual-lvds.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Generic Dual-Link LVDS Display Panel
>>> +
>>> +maintainers:
>>> +  - Aradhya Bhatia <a-bhatia1@ti.com>
>>> +  - Thierry Reding <thierry.reding@gmail.com>
>>> +
>>> +description: |
>>> +  A dual-LVDS interface is a dual-link connection with the even pixels
>>> +  traveling on one link, and the odd pixels traveling on the other.
>>> +
>>> +allOf:
>>> +  - $ref: panel-common.yaml#
>>> +  - $ref: /schemas/display/lvds.yaml/#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    oneOf:
>>> +      - items:
>>> +          - enum:
>>> +              - lincolntech,lcd185-101ct
>>> +              - microtips,13-101hieb0hf0-s
>>> +          - const: panel-dual-lvds
>>> +      - const: panel-dual-lvds
>>> +
>>> +  ports:
>>> +    $ref: /schemas/graph.yaml#/properties/ports
>>> +
>>> +    properties:
>>> +      port@0:
>>> +        $ref: /schemas/graph.yaml#/$defs/port-base
>>> +        unevaluatedProperties: false
>>> +        description: The sink for first set of LVDS pixels.
>>> +
>>> +        properties:
>>> +          dual-lvds-odd-pixels:
>>> +            type: boolean
>>> +
>>> +          dual-lvds-even-pixels:
>>> +            type: boolean
>>> +
>>> +        oneOf:
>>> +          - required: [dual-lvds-odd-pixels]
>>
>> One question: why do we need a "panel-dual-lvds" compatible?
>> A Dual-LVDS panel is a LVDS panel using two ports, hence still a 
>> panel-lvds.
>>
>> If you're doing this to clearly distinguish, for human readability 
>> purposes,
>> single-link vs dual-link panels, I think that this would still be 
>> clear even
>> if we use panel-lvds alone because dual-link panels, as you wrote in this
>> binding, does *require* two ports, with "dual-lvds-{odd,even}-pixels" 
>> properties.
> 
> Yes, while they are both LVDS based panels the extra LVDS sink in these
> panels, and the capability to decode and display the 2 sets of signals
> are enough hardware differences that warrant for an addition of a new
> compatible.
> 
>>
>> So... the devicetree node would look like this:
>>
>> panel {
>>      compatible = "vendor,panel", "panel-lvds";
>>      ....
>>      ports {
>>          port@0 {
>>              .....
>>              -> dual-lvds-odd-pixels <-
>>          }
>>
>>          port@1 {
>>              .....
>>              -> dual-lvds-even-pixels <-
>>          };
>>      };
>> };
>>
>>> +          - required: [dual-lvds-even-pixels]
>>
>> ...Though, if you expect dual-lvds panels to get other quirks in the 
>> future,
>> that's a whole different story and you may actually need the 
>> panel-dual-lvds
>> compatible.
> 
> Yes, exactly. Even while being non-smart, there are going to be more
> quirks in future. And it would be better if they have their own
> compatible/binding, and are not getting appended in an ever-growing
> if-else ladder. :)

I can imagine a panel which you can use with a single LVDS link if the 
clock is high enough, or two LVDS links if the clock has to be lower. Is 
that a dual-lvds panel? =)

But probably that situation is no different than a panel that can work 
with DSI or DPI input.

Still, I'm agree with Angelo in that a new compatible string for dual 
link lvds feels a bit odd. That said, it's possible the panel-lvds 
bindings might get rather confusing. So I don't have a strong feeling here.

  Tomi

