Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583D647D169
	for <lists+linux-csky@lfdr.de>; Wed, 22 Dec 2021 13:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244744AbhLVMA5 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 22 Dec 2021 07:00:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235474AbhLVMA4 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 22 Dec 2021 07:00:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97ACC061574;
        Wed, 22 Dec 2021 04:00:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 558DD619D7;
        Wed, 22 Dec 2021 12:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADACCC36AE5;
        Wed, 22 Dec 2021 12:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640174454;
        bh=W/moysiPtkLHqaL8rrk0AAUZ4J8EeLXSyR47GkuKRq8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KOUFA9wPTfiEC9+hWyUY2qFnyPIrL7WFh6dcTnlh3xHa46asvNBrUz6m38DSXcLg7
         yzE74BJA3IbKOqP2OfY0L4814vLQvPupOk9FaxeWFLnFKfv4LK/aA9Vp/racO3YA11
         nmTQGrxpYPK2mAUpcdj/T0rJsz3/r5ini+7RnZia8K+AQitekJzPfpyM2g+f+9k770
         N5bD7OMDQiipXbYzfcbh7r9lbS1gxomaKNLo7nCQFBtyi4iL0PghIyCtr5gLc94x4z
         zcPHW3oFSNIkiH9e1aoYAH/XITlYm0e16yvP89mHVjEdxDhrBxn6H9SdE2iT+Fri4d
         Rwyqsn1MQl7yg==
Received: by mail-ua1-f53.google.com with SMTP id 30so3660749uag.13;
        Wed, 22 Dec 2021 04:00:54 -0800 (PST)
X-Gm-Message-State: AOAM5333fN+g5t04tFGzrmHdkU6PMgnZoTE0v6E8NCtB7JoEVv1Y3RkW
        12VwD0jrbCxhG5bV8gNVujgu6lP+uljwzBxAFKk=
X-Google-Smtp-Source: ABdhPJy/IQsauuui0UoC5qe0NjQF67kPsMhP9ZoKMuMQtrKgbUZWi9Lbd15QMr7H7a56hnzdj1CvaKk8G+R0l4FuZMk=
X-Received: by 2002:ab0:3c4f:: with SMTP id u15mr876153uaw.108.1640174453602;
 Wed, 22 Dec 2021 04:00:53 -0800 (PST)
MIME-Version: 1.0
References: <20211221163532.2636028-1-guoren@kernel.org>
In-Reply-To: <20211221163532.2636028-1-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 22 Dec 2021 20:00:42 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS0K=S_zn0DRO5D25mGntYMK1+1hYFCf1LiohCLUG0joQ@mail.gmail.com>
Message-ID: <CAJF2gTS0K=S_zn0DRO5D25mGntYMK1+1hYFCf1LiohCLUG0joQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] riscv: compat: Add COMPAT mode support for rv64
To:     Guo Ren <guoren@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup.patel@wdc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        liush <liush@allwinnertech.com>, Wei Fu <wefu@redhat.com>,
        Drew Fustini <drew@beagleboard.org>,
        Wang Junqiang <wangjunqiang@iscas.ac.cn>,
        =?UTF-8?B?V2VpIFd1ICjlkLTkvJ8p?= <lazyparser@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Wed, Dec 22, 2021 at 12:35 AM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Currently, most 64-bit architectures (x86, parisc, powerpc, arm64,
> s390, mips, sparc) have supported COMPAT mode. But they all have
> history issues and can't use standard linux unistd.h. RISC-V would
> be first standard __SYSCALL_COMPAT user of include/uapi/asm-generic
> /unistd.h.
>
> The patchset are based on v5.16-rc6, you can compare rv64-compat32
> v.s. rv32-whole in qemu with following step:
>
>  - Prepare rv32 rootfs & fw_jump.bin by buildroot.org
>    $ git clone git://git.busybox.net/buildroot
>    $ cd buildroot
>    $ make qemu_riscv32_virt_defconfig O=3Dqemu_riscv32_virt_defconfig
>    $ make -C qemu_riscv32_virt_defconfig
>    $ make qemu_riscv64_virt_defconfig O=3Dqemu_riscv64_virt_defconfig
>    $ make -C qemu_riscv64_virt_defconfig
>    (Got fw_jump.bin & rootfs.ext2 in qemu_riscvXX_virt_defconfig/images)
>
>  - Prepare Linux rv32 & rv64 Image
>    $ git clone git@github.com:c-sky/csky-linux.git -b riscv_compat_v1 lin=
ux
>    $ cd linux
>    $ make ARCH=3Driscv CROSS_COMPILE=3Driscv32-buildroot-linux-gnu- O=3D.=
./build-rv32/ rv32_defconfig
>    $ make ARCH=3Driscv CROSS_COMPILE=3Driscv32-buildroot-linux-gnu- O=3D.=
./build-rv32/ Image
>    $ make ARCH=3Driscv CROSS_COMPILE=3Driscv64-buildroot-linux-gnu- O=3D.=
./build-rv64/ defconfig
You need menuconfig to enable CONFIG_COMPAT, here.

I forgot add CONFIG_COMPAT in defconfig or make CONFIG_COMPAT with def_bool=
.

>    $ make ARCH=3Driscv CROSS_COMPILE=3Driscv64-buildroot-linux-gnu- O=3D.=
./build-rv64/ Image
>
>  - Prepare Qemu: (made by LIU Zhiwei <zhiwei_liu@c-sky.com>)
>    $ git clone https://github.com/romanheros/qemu.git -b riscv-upstream-u=
xl-v5
>    $ cd qemu
>    $ ./configure --target-list=3D"riscv64-softmmu riscv32-softmmu"
>    $ make
>
>  - Run rv64 with rv32 rootfs in compat mode:
>    $ ./build/qemu-system-riscv64 -cpu rv64,x-h=3Dtrue -M virt -m 64m -nog=
raphic -bios qemu_riscv64_virt_defconfig/images/fw_jump.bin -kernel build-r=
v64/Image -drive file qemu_riscv32_virt_defconfig/images/rootfs.ext2,format=
=3Draw,id=3Dhd0 -device virtio-blk-device,drive=3Dhd0 -append "rootwait roo=
t=3D/dev/vda ro console=3DttyS0 earlycon=3Dsbi" -netdev user,id=3Dnet0 -dev=
ice virtio-net-device,netdev=3Dnet0
>
> QEMU emulator version 6.2.50 (v6.2.0-29-g196d7182c8)
> OpenSBI v0.9
> [    0.000000] Linux version 5.16.0-rc6-00013-g60f122c486d0 (guoren@guore=
n-Z87-HD3) (riscv64-unknown-linux-gnu-gcc (GCC) 10.2.0, GNU ld (GNU Binutil=
s) 2.37) #62 SMP Tue Dec 21 22:54:05 CST 2021
> [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80200000
> [    0.000000] Machine model: riscv-virtio,qemu
> [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
> [    0.000000] printk: bootconsole [sbi0] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] Zone ranges:
> [    0.000000]   DMA32    [mem 0x0000000080200000-0x0000000083ffffff]
> [    0.000000]   Normal   empty
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080200000-0x0000000083ffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080200000-0x0000000083f=
fffff]
> [    0.000000] SBI specification v0.2 detected
> [    0.000000] SBI implementation ID=3D0x1 Version=3D0x9
> [    0.000000] SBI TIME extension detected
> [    0.000000] SBI IPI extension detected
> [    0.000000] SBI RFENCE extension detected
> [    0.000000] SBI v0.2 HSM extension detected
> [    0.000000] riscv: compat: 32bit U-mode applications support
> [    0.000000] riscv: ISA extensions acdfhimsu
> [    0.000000] riscv: ELF capabilities acdfim
> [    0.000000] percpu: Embedded 17 pages/cpu s30696 r8192 d30744 u69632
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 156=
55
> [    0.000000] Kernel command line: rootwait root=3D/dev/vda ro console=
=3DttyS0 earlycon=3Dsbi
> [    0.000000] Dentry cache hash table entries: 8192 (order: 4, 65536 byt=
es, linear)
> [    0.000000] Inode-cache hash table entries: 4096 (order: 3, 32768 byte=
s, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]       fixmap : 0xffffffcefee00000 - 0xffffffceff000000   (=
2048 kB)
> [    0.000000]       pci io : 0xffffffceff000000 - 0xffffffcf00000000   (=
  16 MB)
> [    0.000000]      vmemmap : 0xffffffcf00000000 - 0xffffffcfffffffff   (=
4095 MB)
> [    0.000000]      vmalloc : 0xffffffd000000000 - 0xffffffdfffffffff   (=
65535 MB)
> [    0.000000]       lowmem : 0xffffffe000000000 - 0xffffffe003e00000   (=
  62 MB)
> [    0.000000]       kernel : 0xffffffff80000000 - 0xffffffffffffffff   (=
2047 MB)
> [    0.000000] Memory: 43952K/63488K available (6180K kernel code, 4873K =
rwdata, 2048K rodata, 2146K init, 297K bss, 19536K reserved, 0K cma-reserve=
d)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1,=
 Nodes=3D1
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_i=
ds=3D1.
> [    0.000000] rcu:     RCU debug extended QS entry/exit.
> [    0.000000]  Tracing variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is=
 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D1
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] riscv-intc: 64 local interrupts mapped
> [    0.000000] plic: plic@c000000: mapped 53 interrupts with 1 handlers f=
or 2 contexts.
> ...
> Welcome to Buildroot
> buildroot login: root
> # cat /proc/cpuinfo
> processor       : 0
> hart            : 0
> isa             : rv64imafdcsuh
> mmu             : sv48
>
> # file /bin/busybox
> /bin/busybox: setuid ELF 32-bit LSB shared object, UCB RISC-V, version 1 =
(SYSV), dynamically linked, interpreter /lib/ld-linux-riscv32-ilp32d.so.1, =
for GNU/Linux 5.15.0, stripped
> # cat /proc/meminfo
> MemTotal:          46096 kB
> MemFree:           30116 kB
> MemAvailable:      32824 kB
> Buffers:             664 kB
> Cached:             3900 kB
> SwapCached:            0 kB
> Active:             3164 kB
> Inactive:           1920 kB
> Active(anon):         40 kB
> Inactive(anon):      524 kB
> Active(file):       3124 kB
> Inactive(file):     1396 kB
> Unevictable:           0 kB
> Mlocked:               0 kB
> SwapTotal:             0 kB
> SwapFree:              0 kB
> Dirty:                 8 kB
> Writeback:             0 kB
> AnonPages:           556 kB
> Mapped:             2084 kB
> Shmem:                44 kB
> KReclaimable:        964 kB
> Slab:               5760 kB
> SReclaimable:        964 kB
> SUnreclaim:         4796 kB
> KernelStack:         624 kB
> PageTables:          132 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:       23048 kB
> Committed_AS:       2088 kB
> VmallocTotal:   67108863 kB
> VmallocUsed:         636 kB
> VmallocChunk:          0 kB
> Percpu:               80 kB
> #
>
>  - Run rv32 with rv32 rootfs:
>    $ ./build/qemu-system-riscv32 -cpu rv32,x-h=3Dtrue -M virt -m 64m -nog=
raphic -bios qemu_riscv32_virt_defconfig/images/fw_jump.bin -kernel build-r=
v32/Image -drive file qemu_riscv32_virt_defconfig/images/rootfs.ext2,format=
=3Draw,id=3Dhd0 -device virtio-blk-device,drive=3Dhd0 -append "rootwait roo=
t=3D/dev/vda ro console=3DttyS0 earlycon=3Dsbi" -netdev user,id=3Dnet0 -dev=
ice virtio-net-device,netdev=3Dnet0
>
> QEMU emulator version 6.2.50 (v6.2.0-29-g196d7182c8)
> OpenSBI v0.9
> [    0.000000] Linux version 5.16.0-rc6-00013-g60f122c486d0 (guoren@guore=
n-Z87-HD3) (riscv32-buildroot-linux-gnu-gcc.br_real (Buildroot 2021.11-201-=
g7600ca7960-dirty) 10.3.0, GNU ld (GNU Binutils) 2.36.1) #4 SMP Tue Dec 21 =
22:54:43 CST 2021
> [    0.000000] OF: fdt: Ignoring memory range 0x80000000 - 0x80400000
> [    0.000000] Machine model: riscv-virtio,qemu
> [    0.000000] earlycon: sbi0 at I/O port 0x0 (options '')
> [    0.000000] printk: bootconsole [sbi0] enabled
> [    0.000000] efi: UEFI not found.
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000080400000-0x0000000083ffffff]
> [    0.000000] Movable zone start for each node
> [    0.000000] Early memory node ranges
> [    0.000000]   node   0: [mem 0x0000000080400000-0x0000000083ffffff]
> [    0.000000] Initmem setup node 0 [mem 0x0000000080400000-0x0000000083f=
fffff]
> [    0.000000] SBI specification v0.2 detected
> [    0.000000] SBI implementation ID=3D0x1 Version=3D0x9
> [    0.000000] SBI TIME extension detected
> [    0.000000] SBI IPI extension detected
> [    0.000000] SBI RFENCE extension detected
> [    0.000000] SBI v0.2 HSM extension detected
> [    0.000000] riscv: ISA extensions acdfhimsu
> [    0.000000] riscv: ELF capabilities acdfim
> [    0.000000] percpu: Embedded 12 pages/cpu s16600 r8192 d24360 u49152
> [    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 152=
40
> [    0.000000] Kernel command line: rootwait root=3D/dev/vda ro console=
=3DttyS0 earlycon=3Dsbi
> [    0.000000] Dentry cache hash table entries: 8192 (order: 3, 32768 byt=
es, linear)
> [    0.000000] Inode-cache hash table entries: 4096 (order: 2, 16384 byte=
s, linear)
> [    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.000000] Virtual kernel memory layout:
> [    0.000000]       fixmap : 0x9dc00000 - 0x9e000000   (4096 kB)
> [    0.000000]       pci io : 0x9e000000 - 0x9f000000   (  16 MB)
> [    0.000000]      vmemmap : 0x9f000000 - 0x9fffffff   (  15 MB)
> [    0.000000]      vmalloc : 0xa0000000 - 0xbfffffff   ( 511 MB)
> [    0.000000]       lowmem : 0xc0000000 - 0xc3c00000   (  60 MB)
> [    0.000000] Memory: 35332K/61440K available (6073K kernel code, 8814K =
rwdata, 4096K rodata, 4160K init, 241K bss, 26108K reserved, 0K cma-reserve=
d)
> [    0.000000] SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D1,=
 Nodes=3D1
> [    0.000000] rcu: Hierarchical RCU implementation.
> [    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=3D8 to nr_cpu_i=
ds=3D1.
> [    0.000000] rcu:     RCU debug extended QS entry/exit.
> [    0.000000]  Tracing variant of Tasks RCU enabled.
> [    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is=
 25 jiffies.
> [    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_i=
ds=3D1
> [    0.000000] NR_IRQS: 64, nr_irqs: 64, preallocated irqs: 0
> [    0.000000] riscv-intc: 32 local interrupts mapped
> [    0.000000] plic: plic@c000000: mapped 53 interrupts with 1 handlers f=
or 2 contexts.
> ...
> Welcome to Buildroot
> buildroot login: root
> # cat /proc/cpuinfo
> processor       : 0
> hart            : 0
> isa             : rv32imafdcsuh
> mmu             : sv32
>
> # file /bin/busybox
> /bin/busybox: setuid ELF 32-bit LSB shared object, UCB RISC-V, version 1 =
(SYSV), dynamically linked, interpreter /lib/ld-linux-riscv32-ilp32d.so.1, =
for GNU/Linux 5.15.0, stripped
> # cat /proc/meminfo
> MemTotal:          39492 kB
> MemFree:           26756 kB
> MemAvailable:      29552 kB
> Buffers:             668 kB
> Cached:             3908 kB
> SwapCached:            0 kB
> Active:             3156 kB
> Inactive:           1936 kB
> Active(anon):         40 kB
> Inactive(anon):      520 kB
> Active(file):       3116 kB
> Inactive(file):     1416 kB
> Unevictable:           0 kB
> Mlocked:               0 kB
> SwapTotal:             0 kB
> SwapFree:              0 kB
> Dirty:                 0 kB
> Writeback:             0 kB
> AnonPages:           552 kB
> Mapped:             2144 kB
> Shmem:                44 kB
> KReclaimable:        624 kB
> Slab:               3660 kB
> SReclaimable:        624 kB
> SUnreclaim:         3036 kB
> KernelStack:         312 kB
> PageTables:           92 kB
> NFS_Unstable:          0 kB
> Bounce:                0 kB
> WritebackTmp:          0 kB
> CommitLimit:       19744 kB
> Committed_AS:       2088 kB
> VmallocTotal:     524287 kB
> VmallocUsed:          12 kB
> VmallocChunk:          0 kB
> Percpu:               60 kB
> #
>
>  Some conclusions:
>  - rv32 linux kernel code, data sizes are larger than rv64.
>    (complier's issue?)
>  - rv32 kernel runtime KernelStack, Slab... are smaller,
>    but not so much for memory footprint saving.
>  - Totally rv64 kernel is much better than rv32.
>  - Qemu, kernel, rv32 =3D rv64 defconfig, rootfs, opensbi
>    are the same in this comparison.
>
> Guo Ren (13):
>   syscalls: compat: Fix the missing part for __SYSCALL_COMPAT
>   riscv: Fixup difference with defconfig
>   riscv: compat: Add basic compat date type implementation
>   riscv: compat: Re-implement TASK_SIZE for COMPAT_32BIT
>   riscv: compat: syscall: Add compat_sys_call_table implementation
>   riscv: compat: syscall: Add entry.S implementation
>   riscv: compat: Add elf.h implementation
>   riscv: compat: Add COMPAT Kbuild skeletal support
>   riscv: compat: init: Add hw-cap detect in setup_arch
>   riscv: compat: vdso: Add rv32 VDSO base code implementation
>   riscv: compat: vdso: Add setup additional pages implementation
>   riscv: compat: signal: Add rt_frame implementation
>   riscv: compat: ptrace: Add compat_arch_ptrace implement
>
>  arch/riscv/Kconfig                            |  22 ++
>  arch/riscv/Makefile                           |   5 +
>  arch/riscv/configs/rv32_defconfig             |  20 +-
>  arch/riscv/include/asm/compat.h               | 259 ++++++++++++++++++
>  arch/riscv/include/asm/csr.h                  |   7 +
>  arch/riscv/include/asm/elf.h                  |  53 +++-
>  arch/riscv/include/asm/mmu.h                  |   1 +
>  arch/riscv/include/asm/pgtable.h              |  11 +-
>  arch/riscv/include/asm/processor.h            |  10 +
>  arch/riscv/include/asm/syscall.h              |   3 +
>  arch/riscv/include/asm/thread_info.h          |   1 +
>  arch/riscv/include/asm/vdso.h                 |   9 +
>  arch/riscv/kernel/Makefile                    |   3 +
>  arch/riscv/kernel/compat_signal.c             | 243 ++++++++++++++++
>  arch/riscv/kernel/compat_syscall_table.c      |  84 ++++++
>  arch/riscv/kernel/compat_vdso/.gitignore      |   2 +
>  arch/riscv/kernel/compat_vdso/Makefile        |  68 +++++
>  arch/riscv/kernel/compat_vdso/compat_vdso.S   |   8 +
>  .../kernel/compat_vdso/compat_vdso.lds.S      |   3 +
>  arch/riscv/kernel/compat_vdso/flush_icache.S  |   3 +
>  .../compat_vdso/gen_compat_vdso_offsets.sh    |   5 +
>  arch/riscv/kernel/compat_vdso/getcpu.S        |   3 +
>  arch/riscv/kernel/compat_vdso/note.S          |   3 +
>  arch/riscv/kernel/compat_vdso/rt_sigreturn.S  |   3 +
>  arch/riscv/kernel/entry.S                     |  18 +-
>  arch/riscv/kernel/process.c                   |  32 +++
>  arch/riscv/kernel/ptrace.c                    |  87 +++++-
>  arch/riscv/kernel/setup.c                     |   5 +
>  arch/riscv/kernel/signal.c                    |  13 +-
>  arch/riscv/kernel/vdso.c                      | 104 +++++--
>  arch/riscv/kernel/vdso/vdso.S                 |   6 +-
>  drivers/firmware/efi/libstub/efi-stub.c       |   2 +-
>  include/uapi/asm-generic/unistd.h             |   4 +-
>  tools/include/uapi/asm-generic/unistd.h       |   4 +-
>  34 files changed, 1055 insertions(+), 49 deletions(-)
>  create mode 100644 arch/riscv/include/asm/compat.h
>  create mode 100644 arch/riscv/kernel/compat_signal.c
>  create mode 100644 arch/riscv/kernel/compat_syscall_table.c
>  create mode 100644 arch/riscv/kernel/compat_vdso/.gitignore
>  create mode 100644 arch/riscv/kernel/compat_vdso/Makefile
>  create mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.S
>  create mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
>  create mode 100644 arch/riscv/kernel/compat_vdso/flush_icache.S
>  create mode 100755 arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets=
.sh
>  create mode 100644 arch/riscv/kernel/compat_vdso/getcpu.S
>  create mode 100644 arch/riscv/kernel/compat_vdso/note.S
>  create mode 100644 arch/riscv/kernel/compat_vdso/rt_sigreturn.S
>
> --
> 2.25.1
>


--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
