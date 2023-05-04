Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D8B6F7277
	for <lists+linux-csky@lfdr.de>; Thu,  4 May 2023 21:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjEDTDR (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 4 May 2023 15:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjEDTCt (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 4 May 2023 15:02:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663C383D8;
        Thu,  4 May 2023 12:02:20 -0700 (PDT)
Message-ID: <20230504185936.974986973@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683226938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=RWqZkjYspaeM2luDJ1kekjLX+eDwzhj89fWzaE+vcuc=;
        b=TB5oV9Aq6dUI1CYTG3Mfudq6NtZlPsW1Oex7yGf2LM/kO8/BZ25DUu+2zHE2ckb9PInfKC
        ThIb3r9/3b15wBd6uRdROhA10S5AgTJxEM2bEGeorA2NaJWuHDmSYm2szq80TnIJGzO87r
        81wUI2m9b4yt/h5OEp4tiu/Eej4ESXtZF7nf623HNABJkB4ypUwiLWY/CryJlS2D49iF4g
        VpdQdELsDbtjD2eM41gRwO8hH6r1xMhcJOplan7xyugn92wquyXDsHqitGavw4pzelheUe
        iefDvimqKcNsabrSPDXx2VGoczs/C1VurUq3fWakhAv9b6MMDMg5hc8nUdPY/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683226938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=RWqZkjYspaeM2luDJ1kekjLX+eDwzhj89fWzaE+vcuc=;
        b=iEvC6KRjnzhtqcLL+LMevDrfOV+QfKnfRTDjoCA4Yw0ERn9sWjSc3oID7BBkVgcY89imxw
        v8or+5vf+SaSUADQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Brian Gerst <brgerst@gmail.com>,
        Arjan van de Veen <arjan@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Piotr Gorski <lucjan.lucjanov@gmail.com>,
        Usama Arif <usama.arif@bytedance.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        xen-devel@lists.xenproject.org,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        linux-csky@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Sabin Rapan <sabrapan@amazon.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Subject: [patch V2 12/38] x86/smpboot: Make TSC synchronization function call based
References: <20230504185733.126511787@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu,  4 May 2023 21:02:17 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Spin-waiting on the control CPU until the AP reaches the TSC
synchronization is just a waste especially in the case that there is no
synchronization required.

As the synchronization has to run with interrupts disabled the control CPU
part can just be done from a SMP function call. The upcoming AP issues that
call async only in the case that synchronization is required.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/tsc.h |    2 --
 arch/x86/kernel/smpboot.c  |   20 +++-----------------
 arch/x86/kernel/tsc_sync.c |   36 +++++++++++-------------------------
 3 files changed, 14 insertions(+), 44 deletions(-)
---
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -55,12 +55,10 @@ extern bool tsc_async_resets;
 #ifdef CONFIG_X86_TSC
 extern bool tsc_store_and_check_tsc_adjust(bool bootcpu);
 extern void tsc_verify_tsc_adjust(bool resume);
-extern void check_tsc_sync_source(int cpu);
 extern void check_tsc_sync_target(void);
 #else
 static inline bool tsc_store_and_check_tsc_adjust(bool bootcpu) { return false; }
 static inline void tsc_verify_tsc_adjust(bool resume) { }
-static inline void check_tsc_sync_source(int cpu) { }
 static inline void check_tsc_sync_target(void) { }
 #endif
 
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -278,11 +278,7 @@ static void notrace start_secondary(void
 	/* Otherwise gcc will move up smp_processor_id() before cpu_init() */
 	barrier();
 
-	/*
-	 * Check TSC synchronization with the control CPU, which will do
-	 * its part of this from wait_cpu_online(), making it an implicit
-	 * synchronization point.
-	 */
+	/* Check TSC synchronization with the control CPU. */
 	check_tsc_sync_target();
 
 	/*
@@ -1144,21 +1140,11 @@ static void wait_cpu_callin(unsigned int
 }
 
 /*
- * Bringup step four: Synchronize the TSC and wait for the target AP
- * to reach set_cpu_online() in start_secondary().
+ * Bringup step four: Wait for the target AP to reach set_cpu_online() in
+ * start_secondary().
  */
 static void wait_cpu_online(unsigned int cpu)
 {
-	unsigned long flags;
-
-	/*
-	 * Check TSC synchronization with the AP (keep irqs disabled
-	 * while doing so):
-	 */
-	local_irq_save(flags);
-	check_tsc_sync_source(cpu);
-	local_irq_restore(flags);
-
 	/*
 	 * Wait for the AP to mark itself online, so the core caller
 	 * can drop sparse_irq_lock.
--- a/arch/x86/kernel/tsc_sync.c
+++ b/arch/x86/kernel/tsc_sync.c
@@ -245,7 +245,6 @@ bool tsc_store_and_check_tsc_adjust(bool
  */
 static atomic_t start_count;
 static atomic_t stop_count;
-static atomic_t skip_test;
 static atomic_t test_runs;
 
 /*
@@ -344,21 +343,14 @@ static inline unsigned int loop_timeout(
 }
 
 /*
- * Source CPU calls into this - it waits for the freshly booted
- * target CPU to arrive and then starts the measurement:
+ * The freshly booted CPU initiates this via an async SMP function call.
  */
-void check_tsc_sync_source(int cpu)
+static void check_tsc_sync_source(void *__cpu)
 {
+	unsigned int cpu = (unsigned long)__cpu;
 	int cpus = 2;
 
 	/*
-	 * No need to check if we already know that the TSC is not
-	 * synchronized or if we have no TSC.
-	 */
-	if (unsynchronized_tsc())
-		return;
-
-	/*
 	 * Set the maximum number of test runs to
 	 *  1 if the CPU does not provide the TSC_ADJUST MSR
 	 *  3 if the MSR is available, so the target can try to adjust
@@ -368,16 +360,9 @@ void check_tsc_sync_source(int cpu)
 	else
 		atomic_set(&test_runs, 3);
 retry:
-	/*
-	 * Wait for the target to start or to skip the test:
-	 */
-	while (atomic_read(&start_count) != cpus - 1) {
-		if (atomic_read(&skip_test) > 0) {
-			atomic_set(&skip_test, 0);
-			return;
-		}
+	/* Wait for the target to start. */
+	while (atomic_read(&start_count) != cpus - 1)
 		cpu_relax();
-	}
 
 	/*
 	 * Trigger the target to continue into the measurement too:
@@ -397,14 +382,14 @@ void check_tsc_sync_source(int cpu)
 	if (!nr_warps) {
 		atomic_set(&test_runs, 0);
 
-		pr_debug("TSC synchronization [CPU#%d -> CPU#%d]: passed\n",
+		pr_debug("TSC synchronization [CPU#%d -> CPU#%u]: passed\n",
 			smp_processor_id(), cpu);
 
 	} else if (atomic_dec_and_test(&test_runs) || random_warps) {
 		/* Force it to 0 if random warps brought us here */
 		atomic_set(&test_runs, 0);
 
-		pr_warn("TSC synchronization [CPU#%d -> CPU#%d]:\n",
+		pr_warn("TSC synchronization [CPU#%d -> CPU#%u]:\n",
 			smp_processor_id(), cpu);
 		pr_warn("Measured %Ld cycles TSC warp between CPUs, "
 			"turning off TSC clock.\n", max_warp);
@@ -457,11 +442,12 @@ void check_tsc_sync_target(void)
 	 * SoCs the TSC is frequency synchronized, but still the TSC ADJUST
 	 * register might have been wreckaged by the BIOS..
 	 */
-	if (tsc_store_and_check_tsc_adjust(false) || tsc_clocksource_reliable) {
-		atomic_inc(&skip_test);
+	if (tsc_store_and_check_tsc_adjust(false) || tsc_clocksource_reliable)
 		return;
-	}
 
+	/* Kick the control CPU into the TSC synchronization function */
+	smp_call_function_single(cpumask_first(cpu_online_mask), check_tsc_sync_source,
+				 (unsigned long *)(unsigned long)cpu, 0);
 retry:
 	/*
 	 * Register this CPU's participation and wait for the

