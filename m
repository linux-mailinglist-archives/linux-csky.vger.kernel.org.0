Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B36626A124
	for <lists+linux-csky@lfdr.de>; Tue, 15 Sep 2020 10:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgIOIni (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 15 Sep 2020 04:43:38 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12263 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbgIOInh (ORCPT <rfc822;linux-csky@vger.kernel.org>);
        Tue, 15 Sep 2020 04:43:37 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 45AAE387E0E933AA5B0E;
        Tue, 15 Sep 2020 16:43:35 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.253) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Tue, 15 Sep 2020 16:43:30 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Guo Ren <guoren@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-csky <linux-csky@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, Libin <huawei.libin@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        "Jianguo Chen" <chenjianguo3@huawei.com>
Subject: [PATCH v4 0/4] irqchip: dw-apb-ictl: support hierarchy irq domain
Date:   Tue, 15 Sep 2020 16:43:01 +0800
Message-ID: <20200915084305.3085-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.253]
X-CFilter-Loop: Reflected
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

v3 --> v4:
1. remove "gc->chip_types[0].chip.irq_eoi = irq_gc_noop;", the "chip.irq_eoi" hook
   is not needed by handle_level_irq(). Thanks for Marc Zyngier's review.
2. Add a new patch: define an empty function set_handle_irq() if !GENERIC_IRQ_MULTI_HANDLER
   to avoid compilation error on arch/arc system.

v2 --> v3:
1. change (1 << hwirq) to BIT(hwirq).
2. change __exception_irq_entry to __irq_entry, so we can "#include <linux/interrupt.h>"
   instead of "#include <asm/exception.h>". Ohterwise, an compilation error will be
   reported on arch/csky.
   drivers/irqchip/irq-dw-apb-ictl.c:20:10: fatal error: asm/exception.h: No such file or directory
3. use "if (!parent || (np == parent))" to determine whether it is primary interrupt controller.
4. make the primary interrupt controller case also use function handle_level_irq(), I used 
   handle_fasteoi_irq() as flow_handler before.
5. Other minor changes are not detailed.

v1 --> v2:
According to Marc Zyngier's suggestion, discard adding an independent SD5203-VIC
driver, but make the dw-apb-ictl irqchip driver to support hierarchy irq domain.
It was originally available only for secondary interrupt controller, now it can
also be used as primary interrupt controller. The related dt-bindings is updated
appropriately.

Add "Suggested-by: Marc Zyngier <maz@kernel.org>".
Add "Tested-by: Haoyu Lv <lvhaoyu@huawei.com>".


v1:
The interrupt controller of SD5203 SoC is VIC(vector interrupt controller), it's
based on Synopsys DesignWare APB interrupt controller (dw_apb_ictl) IP, but it
can not directly use dw_apb_ictl driver. The main reason is that VIC is used as
primary interrupt controller and dw_apb_ictl driver worked for secondary
interrupt controller. So add a new driver: "hisilicon,sd5203-vic".


Zhen Lei (4):
  genirq: define an empty function set_handle_irq() if
    !GENERIC_IRQ_MULTI_HANDLER
  irqchip: dw-apb-ictl: prepare for support hierarchy irq domain
  irqchip: dw-apb-ictl: support hierarchy irq domain
  dt-bindings: dw-apb-ictl: support hierarchy irq domain

 .../interrupt-controller/snps,dw-apb-ictl.txt      | 14 +++-
 drivers/irqchip/Kconfig                            |  2 +-
 drivers/irqchip/irq-dw-apb-ictl.c                  | 83 ++++++++++++++++++----
 include/linux/irq.h                                |  2 +
 4 files changed, 87 insertions(+), 14 deletions(-)

-- 
1.8.3


