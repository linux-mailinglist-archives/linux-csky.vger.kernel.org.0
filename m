Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82314B5B95
	for <lists+linux-csky@lfdr.de>; Mon, 14 Feb 2022 22:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiBNUxq (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Mon, 14 Feb 2022 15:53:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbiBNUxb (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Mon, 14 Feb 2022 15:53:31 -0500
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93BFADF97;
        Mon, 14 Feb 2022 12:53:10 -0800 (PST)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D8D9792009C; Mon, 14 Feb 2022 21:16:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id D2C4C92009B;
        Mon, 14 Feb 2022 20:16:50 +0000 (GMT)
Date:   Mon, 14 Feb 2022 20:16:50 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] parport_pc: Also enable driver for PCI systems
Message-ID: <alpine.DEB.2.21.2202141955550.34636@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,HDRS_LCASE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Nowadays PC-style parallel ports come in the form of PCI and PCIe option 
cards and there are some combined parallel/serial option cards as well 
that we handle in the parport subsystem.  There is nothing in particular 
that would prevent them from being used in any system equipped with PCI 
or PCIe connectivity, except that we do not permit the PARPORT_PC config 
option to be selected for platforms for which ARCH_MIGHT_HAVE_PC_PARPORT 
has not been set for.

The only PCI platforms that actually can't make use of PC-style parallel 
port hardware are those newer PCIe systems that have no support for I/O 
cycles in the host bridge, required by such parallel ports.  Notably, 
this includes the s390 arch, which has port I/O accessors that cause 
compilation warnings (promoted to errors with `-Werror'), and there are 
other cases such as the POWER9 PHB4 device, though this one has variable 
port I/O accessors that depend on the particular system.  Also it is not 
clear whether the serial port side of devices enabled by PARPORT_SERIAL 
uses port I/O or MMIO.  Finally Super I/O solutions are always either 
ISA or platform devices.

Make the PARPORT_PC option selectable also for PCI systems then, except 
for the s390 arch, however limit the availability of PARPORT_PC_SUPERIO 
to platforms that enable ARCH_MIGHT_HAVE_PC_PARPORT.  Update platforms 
accordingly for the required <asm/parport.h> header.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
---
Hi,

 I have verified this lightly by booting a kernel with PARPORT_PC and 
PARPORT_SERIAL enabled on a RISC-V HiFive Unmatched system.  While I do 
have a PCIe parallel port option available that I could use with my RISC-V 
machine (based on the OxSemi OXPCIe952 chip) it is currently plugged in 
the wrong system, and both machines are in my remote lab I have currently 
no visit scheduled to in the near future.  For the record the device 
reports as:

PCI parallel port detected: 1415:c118, I/O at 0x1000(0x1008), IRQ 18
parport1: PC-style at 0x1000 (0x1008), irq 18, using FIFO [PCSPP,TRISTATE,COMPAT,EPP,ECP]

in the other system.  I'll see if I can verify it with the Unmatched at 
the next opportunity, though it seems like an overkill to me given that a 
PC-style parallel port is a generic PCIe device.  The OXPCIe952 implements 
a multifunction device, so it doesn't rely on PARPORT_SERIAL.

 NB platforms to be updated for <asm/parport.h> generation were chosen by 
the presence of the HAVE_PCI or FORCE_PCI option from ones that do not 
already have or generate that header, except for s390, now excluded.  Let 
me know if I got anything wrong here.

  Maciej

Changes from v1:

- Exclude s390 systems, update the change description accordingly.
---
 arch/arm64/include/asm/Kbuild  |    1 +
 arch/csky/include/asm/Kbuild   |    1 +
 arch/riscv/include/asm/Kbuild  |    1 +
 arch/um/include/asm/Kbuild     |    1 +
 arch/xtensa/include/asm/Kbuild |    1 +
 drivers/parport/Kconfig        |    4 ++--
 6 files changed, 7 insertions(+), 2 deletions(-)

linux-parport-pc-pci.diff
Index: linux-macro/arch/arm64/include/asm/Kbuild
===================================================================
--- linux-macro.orig/arch/arm64/include/asm/Kbuild
+++ linux-macro/arch/arm64/include/asm/Kbuild
@@ -3,6 +3,7 @@ generic-y += early_ioremap.h
 generic-y += mcs_spinlock.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
+generic-y += parport.h
 generic-y += user.h
 
 generated-y += cpucaps.h
Index: linux-macro/arch/csky/include/asm/Kbuild
===================================================================
--- linux-macro.orig/arch/csky/include/asm/Kbuild
+++ linux-macro/arch/csky/include/asm/Kbuild
@@ -4,5 +4,6 @@ generic-y += extable.h
 generic-y += gpio.h
 generic-y += kvm_para.h
 generic-y += qrwlock.h
+generic-y += parport.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
Index: linux-macro/arch/riscv/include/asm/Kbuild
===================================================================
--- linux-macro.orig/arch/riscv/include/asm/Kbuild
+++ linux-macro/arch/riscv/include/asm/Kbuild
@@ -2,5 +2,6 @@
 generic-y += early_ioremap.h
 generic-y += flat.h
 generic-y += kvm_para.h
+generic-y += parport.h
 generic-y += user.h
 generic-y += vmlinux.lds.h
Index: linux-macro/arch/um/include/asm/Kbuild
===================================================================
--- linux-macro.orig/arch/um/include/asm/Kbuild
+++ linux-macro/arch/um/include/asm/Kbuild
@@ -17,6 +17,7 @@ generic-y += mcs_spinlock.h
 generic-y += mmiowb.h
 generic-y += module.lds.h
 generic-y += param.h
+generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
 generic-y += softirq_stack.h
Index: linux-macro/arch/xtensa/include/asm/Kbuild
===================================================================
--- linux-macro.orig/arch/xtensa/include/asm/Kbuild
+++ linux-macro/arch/xtensa/include/asm/Kbuild
@@ -4,6 +4,7 @@ generic-y += extable.h
 generic-y += kvm_para.h
 generic-y += mcs_spinlock.h
 generic-y += param.h
+generic-y += parport.h
 generic-y += qrwlock.h
 generic-y += qspinlock.h
 generic-y += user.h
Index: linux-macro/drivers/parport/Kconfig
===================================================================
--- linux-macro.orig/drivers/parport/Kconfig
+++ linux-macro/drivers/parport/Kconfig
@@ -42,7 +42,7 @@ if PARPORT
 
 config PARPORT_PC
 	tristate "PC-style hardware"
-	depends on ARCH_MIGHT_HAVE_PC_PARPORT
+	depends on ARCH_MIGHT_HAVE_PC_PARPORT || (PCI && !S390)
 	help
 	  You should say Y here if you have a PC-style parallel port. All
 	  IBM PC compatible computers and some Alphas have PC-style
@@ -77,7 +77,7 @@ config PARPORT_PC_FIFO
 
 config PARPORT_PC_SUPERIO
 	bool "SuperIO chipset support"
-	depends on PARPORT_PC && !PARISC
+	depends on ARCH_MIGHT_HAVE_PC_PARPORT && PARPORT_PC && !PARISC
 	help
 	  Saying Y here enables some probes for Super-IO chipsets in order to
 	  find out things like base addresses, IRQ lines and DMA channels.  It
