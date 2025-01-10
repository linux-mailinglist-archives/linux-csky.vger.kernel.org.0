Return-Path: <linux-csky+bounces-1621-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDE5A099F9
	for <lists+linux-csky@lfdr.de>; Fri, 10 Jan 2025 19:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1213A549A
	for <lists+linux-csky@lfdr.de>; Fri, 10 Jan 2025 18:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FF5222574;
	Fri, 10 Jan 2025 18:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="daSPyeIy"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997B421B1BF
	for <linux-csky@vger.kernel.org>; Fri, 10 Jan 2025 18:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534472; cv=none; b=NWOEcW3K/9wPulpr6K1M+RExACZ5yeQKjLCSMTTNoR7LJHehsbLYBFujjVsGCU9yVMziNsIawRQS06X8sVljlDdezq6Lgq0Fruh7BYXw3AMe0DYcgNyL3ff/9rpDtCdHI1f0rUga1eYvPpkSNkZj9wwSzkiOHDE8WXOirIkY3M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534472; c=relaxed/simple;
	bh=/mfc3OXZKkMfjutCKVHn2IBTQNtJN2eL6dFZpIMjD6c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XuxKvhkbYx2rPUQSXA/+9N6P2vn0rT5SC8/9JeWpmhFBFvNuTfN+33/O3DOQdJPPEdmEiJxNOwpMkD7qqlij9HNsWAU2SW7JZe6sC9m+2FSF914kR53C+1DTmZhqe/oC/GDFevh8b+DY+ErRJjjU0RAommjQcOA71T55C1JVx2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=daSPyeIy; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-436248d1240so11542655e9.0
        for <linux-csky@vger.kernel.org>; Fri, 10 Jan 2025 10:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534464; x=1737139264; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NdZ1cQRVb5G6t/AzbRzOJmiK1PmEXn2j4H5pJNPFFDE=;
        b=daSPyeIyBPIsSgowHXYJtgHj6XtYA3XMkLR6T0xN8aDtbXLKHuzkLA5toAKySqpg3Y
         fVylXdVKxN72v3IuLI7U+KDKYYJ+rHhV0G/eXzLoM+KWXRma6vBd7W3ziBv2xzluXsRq
         IbXLyeJxNI19q9sQFxZMFfhNJSZmkx8xYskG33g/Uj4Bg5SSV9cRx9+0JZGgPv4s2220
         s06GRgWySEj4pt4EnIV9RQfyKRGq0pOChMy1Y0DgqjK3Yk3LDIH4A3SJ0kJDyWfvUMR1
         B1lE1NsZHvfcL7Y3uJK6ymU/vRhfMUICIgPFZNJw2Rab8spYVyhykzjxMXNdBoq0vtQc
         ihpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534464; x=1737139264;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NdZ1cQRVb5G6t/AzbRzOJmiK1PmEXn2j4H5pJNPFFDE=;
        b=t7VmZ4vo6K7ZS3Y8pYEkaaTQX7crBBefu7bMBqGxKeiTbHFeGPBPuHQhWFmn7r2Da+
         IzDMlG1u6YkoADBLNhpWl3KrISzgKVG0hFt2D8lLXhrMAkq/AQAH6nyG1bFwM9SEBAvf
         ip2ybyZYruSs2kWealRZ0Qoj5RefCts5giQjqmKR/FdMrVR0AInYUmTecCFb4Ori/UYl
         LfK6sSna/qDgPKQod2xyGXCaFlSOmOqssyQrzDFvbtyLRnBrPlU5/QbmxpRidGSVUKl+
         P9tOhMwyGf2XC/AfS+6EJHEO0+RELjbRAG3GxIjRbhTBp4rsSRPB1Do7jGmBMnU2yGNs
         9YkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTUsmysjsTM7o6dLPTAPrWu2pfihXX6A6nG6ITAeGF0GsOWgvtYC4RP74Vyud6aQ5kEOdbHQeit0Ay@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+UX2AEzCIp5ufPHjLXPNmLkw54oEHUhulqnAvhTWOg2fCAd48
	WbF3gT/VDA7GmNuOdG1mrZcpO1c1pDzg9VeBogHTMvmTU0ZleKEqunEhRG4pVR0RJonKDzacTmQ
	AiyRlEG62xg==
X-Google-Smtp-Source: AGHT+IHOqPqFuZt9UmOoUeA2JDIFLsGLn/JF5TCYjoXI0XK4RQVEWWzyMiwW2MB3CIHY3dySJS8wD0E+4CgsAA==
X-Received: from wmgg11.prod.google.com ([2002:a05:600d:b:b0:434:ff52:1c7])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ed3:b0:434:f7e3:bfbd with SMTP id 5b1f17b1804b1-436e26dda8cmr98320145e9.23.1736534463780;
 Fri, 10 Jan 2025 10:41:03 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:34 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-8-8419288bc805@google.com>
Subject: [PATCH RFC v2 08/29] mm: asi: Avoid warning from NMI userspace
 accesses in ASI context
From: Brendan Jackman <jackmanb@google.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Richard Henderson <richard.henderson@linaro.org>, Matt Turner <mattst88@gmail.com>, 
	Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@quicinc.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao <naveen@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Christoph Hellwig <hch@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mike Rapoport <rppt@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Ard Biesheuvel <ardb@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, 
	Brendan Jackman <jackmanb@google.com>, Junaid Shahid <junaids@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="utf-8"

nmi_uaccess_okay() emits a warning if current CR3 != mm->pgd.
Limit the warning to only when ASI is not active.

Co-developed-by: Junaid Shahid <junaids@google.com>
Signed-off-by: Junaid Shahid <junaids@google.com>
Co-developed-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/tlb.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index b2a13fdab0c6454c1d9d4e3338801f3402da4191..c41e083c5b5281684be79ad0391c1a5fc7b0c493 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1340,6 +1340,22 @@ void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
 	put_cpu();
 }
 
+static inline bool cr3_matches_current_mm(void)
+{
+	struct asi *asi = asi_get_current();
+	pgd_t *pgd_asi = asi_pgd(asi);
+	pgd_t *pgd_cr3;
+
+	/*
+	 * Prevent read_cr3_pa -> [NMI, asi_exit] -> asi_get_current,
+	 * otherwise we might find CR3 pointing to the ASI PGD but not
+	 * find a current ASI domain.
+	 */
+	barrier();
+	pgd_cr3 = __va(read_cr3_pa());
+	return pgd_cr3 == current->mm->pgd || pgd_cr3 == pgd_asi;
+}
+
 /*
  * Blindly accessing user memory from NMI context can be dangerous
  * if we're in the middle of switching the current user task or
@@ -1355,10 +1371,10 @@ bool nmi_uaccess_okay(void)
 	VM_WARN_ON_ONCE(!loaded_mm);
 
 	/*
-	 * The condition we want to check is
-	 * current_mm->pgd == __va(read_cr3_pa()).  This may be slow, though,
-	 * if we're running in a VM with shadow paging, and nmi_uaccess_okay()
-	 * is supposed to be reasonably fast.
+	 * The condition we want to check that CR3 points to either
+	 * current_mm->pgd or an appropriate ASI PGD. Reading CR3 may be slow,
+	 * though, if we're running in a VM with shadow paging, and
+	 * nmi_uaccess_okay() is supposed to be reasonably fast.
 	 *
 	 * Instead, we check the almost equivalent but somewhat conservative
 	 * condition below, and we rely on the fact that switch_mm_irqs_off()
@@ -1367,7 +1383,7 @@ bool nmi_uaccess_okay(void)
 	if (loaded_mm != current_mm)
 		return false;
 
-	VM_WARN_ON_ONCE(current_mm->pgd != __va(read_cr3_pa()));
+	VM_WARN_ON_ONCE(!cr3_matches_current_mm());
 
 	return true;
 }

-- 
2.47.1.613.gc27f4b7a9f-goog


