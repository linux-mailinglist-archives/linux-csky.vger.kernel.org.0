Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3A22DD4D3
	for <lists+linux-csky@lfdr.de>; Thu, 17 Dec 2020 17:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgLQQEt (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 17 Dec 2020 11:04:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgLQQEs (ORCPT <rfc822;linux-csky@vger.kernel.org>);
        Thu, 17 Dec 2020 11:04:48 -0500
From:   guoren@kernel.org
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        mhiramat@kernel.org, alankao@andestech.com, rostedt@goodmis.org,
        bjorn.topel@intel.com, pdp7pdp7@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        anup@brainfault.org, linux-csky@vger.kernel.org,
        greentime.hu@sifive.com, zong.li@sifive.com, guoren@kernel.org,
        me@packi.ch, Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atish.patra@wdc.com>
Subject: [PATCH v5 4/9] riscv: Fixup patch_text panic in ftrace
Date:   Thu, 17 Dec 2020 16:01:40 +0000
Message-Id: <1608220905-1962-5-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608220905-1962-1-git-send-email-guoren@kernel.org>
References: <1608220905-1962-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Just like arm64, we can't trace the function in the patch_text path.

Here is the bug log:

[   45.234334] Unable to handle kernel paging request at virtual address ffffffd38ae80900
[   45.242313] Oops [#1]
[   45.244600] Modules linked in:
[   45.247678] CPU: 0 PID: 11 Comm: migration/0 Not tainted 5.9.0-00025-g9b7db83-dirty #215
[   45.255797] epc: ffffffe00021689a ra : ffffffe00021718e sp : ffffffe01afabb58
[   45.262955]  gp : ffffffe00136afa0 tp : ffffffe01af94d00 t0 : 0000000000000002
[   45.270200]  t1 : 0000000000000000 t2 : 0000000000000001 s0 : ffffffe01afabc08
[   45.277443]  s1 : ffffffe0013718a8 a0 : 0000000000000000 a1 : ffffffe01afabba8
[   45.284686]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : c4c16ad38ae80900
[   45.291929]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000052464e43
[   45.299173]  s2 : 0000000000000001 s3 : ffffffe000206a60 s4 : ffffffe000206a60
[   45.306415]  s5 : 00000000000009ec s6 : ffffffe0013718a8 s7 : c4c16ad38ae80900
[   45.313658]  s8 : 0000000000000004 s9 : 0000000000000001 s10: 0000000000000001
[   45.320902]  s11: 0000000000000003 t3 : 0000000000000001 t4 : ffffffffd192fe79
[   45.328144]  t5 : ffffffffb8f80000 t6 : 0000000000040000
[   45.333472] status: 0000000200000100 badaddr: ffffffd38ae80900 cause: 000000000000000f
[   45.341514] ---[ end trace d95102172248fdcf ]---
[   45.346176] note: migration/0[11] exited with preempt_count 1

(gdb) x /2i $pc
=> 0xffffffe00021689a <__do_proc_dointvec+196>: sd      zero,0(s7)
   0xffffffe00021689e <__do_proc_dointvec+200>: li      s11,0

(gdb) bt
0  __do_proc_dointvec (tbl_data=0x0, table=0xffffffe01afabba8,
write=0, buffer=0x0, lenp=0x7bf897061f9a0800, ppos=0x4, conv=0x0,
data=0x52464e43) at kernel/sysctl.c:581
1  0xffffffe00021718e in do_proc_dointvec (data=<optimized out>,
conv=<optimized out>, ppos=<optimized out>, lenp=<optimized out>,
buffer=<optimized out>, write=<optimized out>, table=<optimized out>)
at kernel/sysctl.c:964
2  proc_dointvec_minmax (ppos=<optimized out>, lenp=<optimized out>,
buffer=<optimized out>, write=<optimized out>, table=<optimized out>)
at kernel/sysctl.c:964
3  proc_do_static_key (table=<optimized out>, write=1, buffer=0x0,
lenp=0x0, ppos=0x7bf897061f9a0800) at kernel/sysctl.c:1643
4  0xffffffe000206792 in ftrace_make_call (rec=<optimized out>,
addr=<optimized out>) at arch/riscv/kernel/ftrace.c:109
5  0xffffffe0002c9c04 in __ftrace_replace_code
(rec=0xffffffe01ae40c30, enable=3) at kernel/trace/ftrace.c:2503
6  0xffffffe0002ca0b2 in ftrace_replace_code (mod_flags=<optimized
out>) at kernel/trace/ftrace.c:2530
7  0xffffffe0002ca26a in ftrace_modify_all_code (command=5) at
kernel/trace/ftrace.c:2677
8  0xffffffe0002ca30e in __ftrace_modify_code (data=<optimized out>)
at kernel/trace/ftrace.c:2703
9  0xffffffe0002c13b0 in multi_cpu_stop (data=0x0) at kernel/stop_machine.c:224
10 0xffffffe0002c0fde in cpu_stopper_thread (cpu=<optimized out>) at
kernel/stop_machine.c:491
11 0xffffffe0002343de in smpboot_thread_fn (data=0x0) at kernel/smpboot.c:165
12 0xffffffe00022f8b4 in kthread (_create=0xffffffe01af0c040) at
kernel/kthread.c:292
13 0xffffffe000201fac in handle_exception () at arch/riscv/kernel/entry.S:236

   0xffffffe00020678a <+114>:   auipc   ra,0xffffe
   0xffffffe00020678e <+118>:   jalr    -118(ra) # 0xffffffe000204714 <patch_text_nosync>
   0xffffffe000206792 <+122>:   snez    a0,a0

(gdb) disassemble patch_text_nosync
Dump of assembler code for function patch_text_nosync:
   0xffffffe000204714 <+0>:     addi    sp,sp,-32
   0xffffffe000204716 <+2>:     sd      s0,16(sp)
   0xffffffe000204718 <+4>:     sd      ra,24(sp)
   0xffffffe00020471a <+6>:     addi    s0,sp,32
   0xffffffe00020471c <+8>:     auipc   ra,0x0
   0xffffffe000204720 <+12>:    jalr    -384(ra) # 0xffffffe00020459c <patch_insn_write>
   0xffffffe000204724 <+16>:    beqz    a0,0xffffffe00020472e <patch_text_nosync+26>
   0xffffffe000204726 <+18>:    ld      ra,24(sp)
   0xffffffe000204728 <+20>:    ld      s0,16(sp)
   0xffffffe00020472a <+22>:    addi    sp,sp,32
   0xffffffe00020472c <+24>:    ret
   0xffffffe00020472e <+26>:    sd      a0,-24(s0)
   0xffffffe000204732 <+30>:    auipc   ra,0x4
   0xffffffe000204736 <+34>:    jalr    -1464(ra) # 0xffffffe00020817a <flush_icache_all>
   0xffffffe00020473a <+38>:    ld      a0,-24(s0)
   0xffffffe00020473e <+42>:    ld      ra,24(sp)
   0xffffffe000204740 <+44>:    ld      s0,16(sp)
   0xffffffe000204742 <+46>:    addi    sp,sp,32
   0xffffffe000204744 <+48>:    ret

(gdb) disassemble flush_icache_all-4
Dump of assembler code for function flush_icache_all:
   0xffffffe00020817a <+0>:     addi    sp,sp,-8
   0xffffffe00020817c <+2>:     sd      ra,0(sp)
   0xffffffe00020817e <+4>:     auipc   ra,0xfffff
   0xffffffe000208182 <+8>:     jalr    -1822(ra) # 0xffffffe000206a60 <ftrace_caller>
   0xffffffe000208186 <+12>:    ld      ra,0(sp)
   0xffffffe000208188 <+14>:    addi    sp,sp,8
   0xffffffe00020818a <+0>:     addi    sp,sp,-16
   0xffffffe00020818c <+2>:     sd      s0,0(sp)
   0xffffffe00020818e <+4>:     sd      ra,8(sp)
   0xffffffe000208190 <+6>:     addi    s0,sp,16
   0xffffffe000208192 <+8>:     li      a0,0
   0xffffffe000208194 <+10>:    auipc   ra,0xfffff
   0xffffffe000208198 <+14>:    jalr    -410(ra) # 0xffffffe000206ffa <sbi_remote_fence_i>
   0xffffffe00020819c <+18>:    ld      s0,0(sp)
   0xffffffe00020819e <+20>:    ld      ra,8(sp)
   0xffffffe0002081a0 <+22>:    addi    sp,sp,16
   0xffffffe0002081a2 <+24>:    ret

(gdb) frame 5
(rec=0xffffffe01ae40c30, enable=3) at kernel/trace/ftrace.c:2503
2503                    return ftrace_make_call(rec, ftrace_addr);
(gdb) p /x rec->ip
$2 = 0xffffffe00020817a -> flush_icache_all !

When we modified flush_icache_all's patchable-entry with ftrace_caller:
 - Insert ftrace_caller at flush_icache_all prologue.
 - Call flush_icache_all to sync I/Dcache, but flush_icache_all is
just we modified by half.

Link: https://lore.kernel.org/linux-riscv/CAJF2gTT=oDWesWe0JVWvTpGi60-gpbNhYLdFWN_5EbyeqoEDdw@mail.gmail.com/T/#t
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Atish Patra <atish.patra@wdc.com>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/riscv/kernel/Makefile | 1 +
 arch/riscv/mm/Makefile     | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 27f10eb..62de075 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -6,6 +6,7 @@
 ifdef CONFIG_FTRACE
 CFLAGS_REMOVE_ftrace.o	= $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_patch.o	= $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_sbi.o	= $(CC_FLAGS_FTRACE)
 endif
 
 extra-y += head.o
diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
index 6b4b7ec..7ebaef1 100644
--- a/arch/riscv/mm/Makefile
+++ b/arch/riscv/mm/Makefile
@@ -3,6 +3,7 @@
 CFLAGS_init.o := -mcmodel=medany
 ifdef CONFIG_FTRACE
 CFLAGS_REMOVE_init.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_cacheflush.o = $(CC_FLAGS_FTRACE)
 endif
 
 KCOV_INSTRUMENT_init.o := n
-- 
2.7.4

