Return-Path: <linux-csky+bounces-9-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B0A7E3941
	for <lists+linux-csky@lfdr.de>; Tue,  7 Nov 2023 11:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A43C1C20B97
	for <lists+linux-csky@lfdr.de>; Tue,  7 Nov 2023 10:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61FD1DDDA;
	Tue,  7 Nov 2023 10:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="uYWeT36t"
X-Original-To: linux-csky@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDE414F7A;
	Tue,  7 Nov 2023 10:30:17 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7003D10E5;
	Tue,  7 Nov 2023 02:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Q80acMOYYyCsBO4DF+q5UzwIza1MpFhs36lmqhGxrto=; b=uYWeT36tOVZqQLHW8tNA+MO8rE
	NiPMKiW9gaelNRus/s5Ndwtp0uSmK/lvfdHkfE4QcP/onqrPhkLvgI35Ka5HmjSXEMAvbiYgMQVrl
	+R1eLD7PmsVjOI1TNlTNJRTsoWihSZNGPC8J/VQBlPMIKcPEChGWuQz77MLr+t/Uf5ufYUqvafSN0
	7bG6U12ZWtCSTuitSJr5zW6rpcvmvn/XnQxS0bVmGJ5oE34UB2knVJ9Qi+6Hm9JyKYkj3TtsoxQ3H
	CuMUVTUeU2RvU6pywO/4Kxgjk0b+YaN9BUYz70gksgowZhGLmvsIhHdh7ATzTnUC7vy/yOGwcGPKT
	kUW8Cxeg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:41338 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1r0JLN-0000F3-0m;
	Tue, 07 Nov 2023 10:30:03 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1r0JLG-00CTx8-CG; Tue, 07 Nov 2023 10:29:54 +0000
In-Reply-To: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH RFC 07/22] drivers: base: Allow parts of GENERIC_CPU_DEVICES
 to be overridden
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1r0JLG-00CTx8-CG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 07 Nov 2023 10:29:54 +0000

From: James Morse <james.morse@arm.com>

Architectures often have extra per-cpu work that needs doing
before a CPU is registered, often to determine if a CPU is
hotpluggable.

To allow the ACPI architectures to use GENERIC_CPU_DEVICES, move
the cpu_register() call into arch_register_cpu(), which is made __weak
so architectures with extra work can override it.
This aligns with the way x86, ia64 and loongarch register hotplug CPUs
when they become present.

Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFC:
 * Dropped __init from x86/ia64 arch_register_cpu()
Changes since RFC v2:
 * Dropped unnecessary Loongarch asm/cpu.h changes
---
 drivers/base/cpu.c  | 14 ++++++++++----
 include/linux/cpu.h |  4 ++++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 34b48f660b6b..579064fda97b 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -525,19 +525,25 @@ bool cpu_is_hotpluggable(unsigned int cpu)
 EXPORT_SYMBOL_GPL(cpu_is_hotpluggable);
 
 #ifdef CONFIG_GENERIC_CPU_DEVICES
-static DEFINE_PER_CPU(struct cpu, cpu_devices);
+DEFINE_PER_CPU(struct cpu, cpu_devices);
+
+int __weak arch_register_cpu(int cpu)
+{
+	return register_cpu(&per_cpu(cpu_devices, cpu), cpu);
+}
 #endif
 
 static void __init cpu_dev_register_generic(void)
 {
-#ifdef CONFIG_GENERIC_CPU_DEVICES
 	int i;
 
+	if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
+		return;
+
 	for_each_present_cpu(i) {
-		if (register_cpu(&per_cpu(cpu_devices, i), i))
+		if (arch_register_cpu(i))
 			panic("Failed to register CPU device");
 	}
-#endif
 }
 
 #ifdef CONFIG_GENERIC_CPU_VULNERABILITIES
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index fc8094419084..1e982d63eae8 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -88,6 +88,10 @@ extern ssize_t arch_cpu_probe(const char *, size_t);
 extern ssize_t arch_cpu_release(const char *, size_t);
 #endif
 
+#ifdef CONFIG_GENERIC_CPU_DEVICES
+DECLARE_PER_CPU(struct cpu, cpu_devices);
+#endif
+
 /*
  * These states are not related to the core CPU hotplug mechanism. They are
  * used by various (sub)architectures to track internal state
-- 
2.30.2


