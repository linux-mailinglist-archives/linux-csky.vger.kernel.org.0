Return-Path: <linux-csky+bounces-1641-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CCBA09A94
	for <lists+linux-csky@lfdr.de>; Fri, 10 Jan 2025 19:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CCB1188A699
	for <lists+linux-csky@lfdr.de>; Fri, 10 Jan 2025 18:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C8228CA3;
	Fri, 10 Jan 2025 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4qXm0akH"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12421D593
	for <linux-csky@vger.kernel.org>; Fri, 10 Jan 2025 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736534544; cv=none; b=R3i09mqfz775Mb0RlrdLoicUol6RvXyosIBYDw3eJNYKfoqVjlQT/J+4c3c1KWT1Po0dQaDiZaOdegAzpLai3dW3wDvbOUIQ8VjwVk5Y0G88LyLyBWau/Muq5lPT0wNOeVWMpXIaEGo708Yk0Hoij8keHe2oxweXycO9j3nZfrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736534544; c=relaxed/simple;
	bh=yFE2RvhsdHiuE5lhdo52Dzo1ojzSWSiC8Ss1voWwr0o=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uhEDDIQlkkkrFHV5Su+mdqHR/fZLXMrHXMOCam+ZJh/yznZETuQLa4BEdaSg7rF4Wv3xTjgAmkReZSWl8aKarJ76oZ7wVRLD9Z9VFQcuM37oTat4q3OncTw8EhfW8AOJU66RSBWKOY2JiSAyjc6wkyVCevjopp5o5hNdx99LHjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4qXm0akH; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-436723db6c4so16407875e9.3
        for <linux-csky@vger.kernel.org>; Fri, 10 Jan 2025 10:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736534511; x=1737139311; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t56obMWOlMyKyO7q6Si1cnEbfn2qyXwrpnzxR+4ONcI=;
        b=4qXm0akHB0cuC/EDQ8VuOoCpDXwtoPfxrekyuf3Jr5mxf6WGp7rbhmhHeDIXklqxd6
         T9lxWQyVYIV47B5OJUReQPTb2cO2OVBUtcNSPlShJjCRvFudrMBkxkEdOt7YD8B8s+2v
         Xr3EQaZc/p07fpcwbTqNiK+qV7HY0Toaji/thgJjB5yEeJhTxg1FeoYSHEY8Jfy2/8EZ
         jiZa5Ti+Lb8moW5SGa97W3jyG6bI8MyoEEfqB2DFyV9BFxFzztzkYfBsUkAjDJ+UDd9H
         nFSU4xK+FYnLvbOSILO7311XYQqvF516GEImEec3eyOp+/ymIWgUdw/GtFKY2TxOmoyN
         vLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736534511; x=1737139311;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t56obMWOlMyKyO7q6Si1cnEbfn2qyXwrpnzxR+4ONcI=;
        b=qLnYEtKNvdFxxNaoD8RiCPD33yPNy9Ps9Z01fS7aODI+5IxHmQ4Iz4V1lSuPi0xJu/
         rvN21RMKuOKajye13T+1jVUA65ziaHJYzZGZ/HDrVqb8HfcCtOwRE5QjFay3A5se+4CH
         JzFdbF2xA/s3jv04ziYC6HKwaEPpljnPGzn5FXtRh0v20DEalwhxstbgkRGyi7TgHoWB
         K64n3zlNShl4egXcay7xOz8zjzxhF73hHlhc7k8HkYfKMFdPNGh5ZAh5mQxwKx6bMN3b
         vF7Fr/ADtnd4O66Sc/72Xd0/NltMxvkzvqxgrAOfEpkYyt+nhM+OxFJrv9gqtSyZm9sK
         z/3A==
X-Forwarded-Encrypted: i=1; AJvYcCWHi6UHnLSxk4fTOoQmAI8ehdsU2n2Mx83h+3vvcwbsbKip9Tul4nNcy3N3nC+i8H1aXkQjgFHTy9FV@vger.kernel.org
X-Gm-Message-State: AOJu0YzvYHmgR0SitquSNiVOZJnLhFnneWjO8eEhPeGZoJUbHwwDF7dw
	pMHjpN+eoJNHHStOI7oXYjBDQ0k+d2gSkebD6+7DhbE6F1eMO+Iim3lnQPxnXpk1glqk3RaR0Zf
	PwfselTEoDA==
X-Google-Smtp-Source: AGHT+IHNze04KHr3mNrPu4oWzk1uJr6kUgfUG8uUPvBwU8SZTj2uxyjbDaOwELGdGilpgEGrHE3bExV1JNVQyA==
X-Received: from wmba16.prod.google.com ([2002:a05:600c:6dd0:b0:434:f350:9fc])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:70a:b0:38a:4184:1519 with SMTP id ffacd0b85a97d-38a873051e1mr10550801f8f.23.1736534511095;
 Fri, 10 Jan 2025 10:41:51 -0800 (PST)
Date: Fri, 10 Jan 2025 18:40:55 +0000
In-Reply-To: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250110-asi-rfc-v2-v2-0-8419288bc805@google.com>
X-Mailer: b4 0.15-dev
Message-ID: <20250110-asi-rfc-v2-v2-29-8419288bc805@google.com>
Subject: [PATCH RFC v2 29/29] mm: asi: Stop ignoring asi=on cmdline flag
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
	Brendan Jackman <jackmanb@google.com>
Content-Type: text/plain; charset="utf-8"

At this point the minimum requirements are in place for the kernel to
operate correctly with ASI enabled.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 arch/x86/mm/asi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/asi.c b/arch/x86/mm/asi.c
index f10f6614b26148e5ba423d8a44f640674573ee40..3e3956326936ea8550308ad004dbbb3738546f9f 100644
--- a/arch/x86/mm/asi.c
+++ b/arch/x86/mm/asi.c
@@ -207,14 +207,14 @@ void __init asi_check_boottime_disable(void)
 		pr_info("ASI disabled through kernel command line.\n");
 	} else if (ret == 2 && !strncmp(arg, "on", 2)) {
 		enabled = true;
-		pr_info("Ignoring asi=on param while ASI implementation is incomplete.\n");
+		pr_info("ASI enabled through kernel command line.\n");
 	} else {
 		pr_info("ASI %s by default.\n",
 			enabled ? "enabled" : "disabled");
 	}
 
 	if (enabled)
-		pr_info("ASI enablement ignored due to incomplete implementation.\n");
+		setup_force_cpu_cap(X86_FEATURE_ASI);
 }
 
 /*

-- 
2.47.1.613.gc27f4b7a9f-goog


