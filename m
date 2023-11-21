Return-Path: <linux-csky+bounces-127-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B60BD7F2EEF
	for <lists+linux-csky@lfdr.de>; Tue, 21 Nov 2023 14:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FEF282A21
	for <lists+linux-csky@lfdr.de>; Tue, 21 Nov 2023 13:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A363C524B4;
	Tue, 21 Nov 2023 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zthaC3NJ"
X-Original-To: linux-csky@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C07B19B9;
	Tue, 21 Nov 2023 05:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zdijYGgjIDtQT2jKhkBP2A4StKqFWhBpmdXXWpH39K4=; b=zthaC3NJYZUzFjufwMEMyoi60e
	OFjHTixvecHXj9yvJHdHzLuN6llKJ8pzaUndONQ8QKEpSo3FlFOr78HA/dV89HG72QhS6/eCPTiSR
	DBNcSZ5Scq2EXbq1ODPBVUrvJUs4O6wCrZ/4Ip3Y7fY6R9ENuqZ09wwM5c4iQ7MUO5X9bx/wczS8w
	KFNcUCCIdxrXc6bwLZFIEYsyBdY7+0r67ZbqiUJTwVJULj/KyvxdvNky7GU7BwAMkOb4R1N6pgrJ1
	zeJ36j0AUoVlL02hD08SwvTsvhRCfvGgAdeDOvAPqfH6bkL3A+VRRVZgpva1vPt92sKmuYDmApS0a
	bADC841A==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35580 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r5R3j-00079x-37;
	Tue, 21 Nov 2023 13:45:00 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r5R3l-00Cszm-UA; Tue, 21 Nov 2023 13:45:01 +0000
In-Reply-To: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
References: <ZVyz/Ve5pPu8AWoA@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: linux-pm@vger.kernel.org,
	 loongarch@lists.linux.dev,
	 linux-acpi@vger.kernel.org,
	 linux-arch@vger.kernel.org,
	 linux-kernel@vger.kernel.org,
	 linux-arm-kernel@lists.infradead.org,
	 linux-riscv@lists.infradead.org,
	 kvmarm@lists.linux.dev,
	 x86@kernel.org,
	 linux-csky@vger.kernel.org,
	 linux-doc@vger.kernel.org,
	 linux-ia64@vger.kernel.org,
	 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
	 Jean-Philippe Brucker <jean-philippe@linaro.org>,
	 jianyong.wu@arm.com,
	 justin.he@arm.com,
	 James Morse <james.morse@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 14/21] x86/topology: Switch over to GENERIC_CPU_DEVICES
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r5R3l-00Cszm-UA@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 21 Nov 2023 13:45:01 +0000

From: James Morse <james.morse@arm.com>

Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
overridden by the arch code, switch over to this to allow common code
to choose when the register_cpu() call is made.

x86's struct cpus come from struct x86_cpu, which has no other members
or users. Remove this and use the version defined by common code.

This is an intermediate step to the logic being moved to drivers/acpi,
where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.

This patch also has the effect of moving the registration of CPUs from
subsys to driver core initialisation, prior to any initcalls running.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
----
Changes since RFC:
 * Fixed the second copy of arch_register_cpu() used for non-hotplug
Changes since RFC v2:
 * Remove duplicate of the weak generic arch_register_cpu(), spotted
   by Jonathan Cameron. Add note about initialisation order change.
Changes since RFC v3:
 * Adapt to removal of EXPORT_SYMBOL()s
---
 arch/x86/Kconfig           |  1 +
 arch/x86/include/asm/cpu.h |  4 ----
 arch/x86/kernel/topology.c | 27 ++++-----------------------
 3 files changed, 5 insertions(+), 27 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index dbdcfc708369..8330c4ac26b3 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -148,6 +148,7 @@ config X86
 	select GENERIC_CLOCKEVENTS_MIN_ADJUST
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_CPU_AUTOPROBE
+	select GENERIC_CPU_DEVICES
 	select GENERIC_CPU_VULNERABILITIES
 	select GENERIC_EARLY_IOREMAP
 	select GENERIC_ENTRY
diff --git a/arch/x86/include/asm/cpu.h b/arch/x86/include/asm/cpu.h
index fecc4fe1d68a..f8f9a9b79395 100644
--- a/arch/x86/include/asm/cpu.h
+++ b/arch/x86/include/asm/cpu.h
@@ -23,10 +23,6 @@ static inline void prefill_possible_map(void) {}
 
 #endif /* CONFIG_SMP */
 
-struct x86_cpu {
-	struct cpu cpu;
-};
-
 #ifdef CONFIG_HOTPLUG_CPU
 extern void soft_restart_cpu(void);
 #endif
diff --git a/arch/x86/kernel/topology.c b/arch/x86/kernel/topology.c
index fcb62cfdf946..c2ed3145a93b 100644
--- a/arch/x86/kernel/topology.c
+++ b/arch/x86/kernel/topology.c
@@ -35,36 +35,17 @@
 #include <asm/io_apic.h>
 #include <asm/cpu.h>
 
-static DEFINE_PER_CPU(struct x86_cpu, cpu_devices);
-
 #ifdef CONFIG_HOTPLUG_CPU
 int arch_register_cpu(int cpu)
 {
-	struct x86_cpu *xc = per_cpu_ptr(&cpu_devices, cpu);
+	struct cpu *c = per_cpu_ptr(&cpu_devices, cpu);
 
-	xc->cpu.hotpluggable = cpu > 0;
-	return register_cpu(&xc->cpu, cpu);
+	c->hotpluggable = cpu > 0;
+	return register_cpu(c, cpu);
 }
 
 void arch_unregister_cpu(int num)
 {
-	unregister_cpu(&per_cpu(cpu_devices, num).cpu);
-}
-#else /* CONFIG_HOTPLUG_CPU */
-
-int __init arch_register_cpu(int num)
-{
-	return register_cpu(&per_cpu(cpu_devices, num).cpu, num);
+	unregister_cpu(&per_cpu(cpu_devices, num));
 }
 #endif /* CONFIG_HOTPLUG_CPU */
-
-static int __init topology_init(void)
-{
-	int i;
-
-	for_each_present_cpu(i)
-		arch_register_cpu(i);
-
-	return 0;
-}
-subsys_initcall(topology_init);
-- 
2.30.2


