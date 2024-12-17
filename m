Return-Path: <linux-csky+bounces-1364-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230A79F41E5
	for <lists+linux-csky@lfdr.de>; Tue, 17 Dec 2024 06:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59813165931
	for <lists+linux-csky@lfdr.de>; Tue, 17 Dec 2024 05:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF7C1487FE;
	Tue, 17 Dec 2024 05:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="BxJlFQXE"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61346145A09
	for <linux-csky@vger.kernel.org>; Tue, 17 Dec 2024 05:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734411943; cv=none; b=YI85QtA6S1n4gLGFJ6G6FiJIknGO8DM+5RSSIk/bmqWUy1aMPEROuK6j+OfnUFn8DnoU06iqSN25TZeV6H2l4i/C5/gAh0lu+EvrtmfaBzk+eyxEAluk7B5vr9pdU28VSE5ur/epUewF+7gx3MyAZcdwXIVDQkJS1T21ae/eO0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734411943; c=relaxed/simple;
	bh=U5fPZ6NRnWKY13beauatUjr9nDkGGLKnVQVgewsb9GM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wkkyg+9aMlN+C2w1nx10KiIjPI3TLrloE2mTr480Nc+SZT4ef5hUByNhCivh8TMOvOImuml/Da+Pb4afAEfP8tQK9CBTniQIrWOHztMfxjKvurvLoIa4OTCAlzY0Ha3RsQqTdGrJKwScGW6kYjTYlv1d8Q7W/aJnUjBPpKAqZhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=BxJlFQXE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21644aca3a0so57483035ad.3
        for <linux-csky@vger.kernel.org>; Mon, 16 Dec 2024 21:05:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1734411939; x=1735016739; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+9x4X6VsXmnlXwHD6ZB1McxUa09s6mP82ERI0J8/h/c=;
        b=BxJlFQXEtEHJ8kN3PUPoJzTtXHkTUYngaJNjQktV/iiPr8QM9D+z9QVtnZuG9Jn3Ex
         +2BeUslX0tuQPit1ffvrWcPW6NHjuwoAB1x+8VFKukZ+6Jeri0YUbLKmj9C4/cQJrBoi
         vDY4JTW4CvWxuswcFMU3TKB7Y5Uj2Rfs4YBE0Z540/CHukxc6aFrg6tt1ux1A1y4ZOE2
         gssouHf7rqoRrnzrR1ZIWPxV/i6EnTaolJAO8ir50FDETt16QIsawivAl4EZtWwpRB5W
         3bpc2hITE1kKtccqX9fE7heDqrtPhqlXngY8bAIAO53cIUP+7itrz40G5Y0gbS5H3iKF
         fH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734411939; x=1735016739;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+9x4X6VsXmnlXwHD6ZB1McxUa09s6mP82ERI0J8/h/c=;
        b=nJO+UHtUH6/DSbIGMJMOzQU0nbYmGmnxoe9xQsidWyaPftJxv4s0/QI2a7qKKjj6XQ
         sTLO+c5caQtXHO+D4ZFvu/hk8FQU5i//ikYVlgnkhMZFgNoZw6E8fNZk6jq1MZQyIzBD
         ruiixXnyPm4R1902jP4ROLGerVNSAuuvWoPxRC9KJsrs4l9vRzPr90Uapa4R6o2ddaxR
         C+b3zdx9sN3jB5exINbRLc4cGgn//S/ojkaKPEfvMEQE5m2hPiWtU5n8awi90xr6fUA7
         HIwlyNHZnlJ6aHZ/W6dZ+3M6uVorTCVtJ1q3iXOwbr7i8EgaxUBPzwieQASAWSYTkcyq
         CowQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyJ0Y1DKVB9lwbQrw8KrHJ7oKAWbCz5lpnPACLoV1k+2gtW6VF88hBnrqnmUnSiJ50RsK06Uc06amk@vger.kernel.org
X-Gm-Message-State: AOJu0YyKgnKiv4Nwu19IwA1jSx2gltXe7tuq2d0z5o5ncidlRzULsvxY
	TBuXrmp4Z+/HvasyXVJrRX3vhoehKTCOA9ymRcgv4NJEqgGUfw0b7lBF+ILAy3E=
X-Gm-Gg: ASbGncuqVFG2fQvzjmdklEzCsqHpiziKuZvb4nj4FCKdS6+5+r+oGUXnyGBqXuIzizz
	erbRa2Z1BQ0qlwlJmNexYNduXH6gNTTHlHg5euBy3uuIYfLCsWa9E5cSrKnZtqcN2/pprmvy1u1
	q48KHWCmQ5c28bUlI7N3l/9R/If5OJhzHvECqL5Y5RbbugfC8I4aoWY3ShwCaudYTI79JJPNwPq
	GYpd/yw/WCE1SJ1HU8Hp4eeLejyJVFySfQ29ul17pen70vPJ3c=
X-Google-Smtp-Source: AGHT+IGVrWrXaPQFFobqmyGa1VQFE8sVuxv4oAOdc9G/v3DOHotCQVtFV+VjZ0E8Lez8hAQY+NAQgw==
X-Received: by 2002:a17:902:dac6:b0:215:72aa:693f with SMTP id d9443c01a7336-21892980fecmr213696615ad.9.1734411939584;
        Mon, 16 Dec 2024 21:05:39 -0800 (PST)
Received: from ghost ([2601:647:6700:64d0:9708:a71e:40e6:860])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e50aadsm50867095ad.156.2024.12.16.21.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 21:05:38 -0800 (PST)
Date: Mon, 16 Dec 2024 21:05:35 -0800
From: Charlie Jenkins <charlie@rivosinc.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Christian Brauner <brauner@kernel.org>, Guo Ren <guoren@kernel.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	James Clark <james.clark@linaro.org>,
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
	Jonathan Corbet <corbet@lwn.net>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
	linux-csky@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 01/16] perf tools: Create generic syscall table support
Message-ID: <Z2EGn2V1OPqqKxKZ@ghost>
References: <20241212-perf_syscalltbl-v2-0-f8ca984ffe40@rivosinc.com>
 <20241212-perf_syscalltbl-v2-1-f8ca984ffe40@rivosinc.com>
 <Z1zBzTgEYXw1DbEL@google.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1zBzTgEYXw1DbEL@google.com>

On Fri, Dec 13, 2024 at 03:22:53PM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Thu, Dec 12, 2024 at 04:32:51PM -0800, Charlie Jenkins wrote:
> > Currently each architecture in perf independently generates syscall
> > headers. Adapt the work that has gone into unifying syscall header
> > implementations in the kernel to work with perf tools. Introduce this
> > framework with riscv at first. riscv previously relied on libaudit, but
> > with this change, perf tools for riscv no longer needs this external
> > dependency.
> 
> Nice work!
> 
> > 
> > Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> > ---
> >  tools/perf/Makefile.config                         |  11 +-
> >  tools/perf/Makefile.perf                           |   4 +
> >  tools/perf/arch/riscv/Makefile                     |  22 --
> >  tools/perf/arch/riscv/entry/syscalls/Kbuild        |   2 +
> >  .../arch/riscv/entry/syscalls/Makefile.syscalls    |   4 +
> >  tools/perf/arch/riscv/entry/syscalls/mksyscalltbl  |  47 ---
> >  tools/perf/arch/riscv/include/syscall_table.h      |   8 +
> >  tools/perf/check-headers.sh                        |   1 +
> >  tools/perf/scripts/Makefile.syscalls               |  60 +++
> >  tools/perf/scripts/syscalltbl.sh                   |  86 +++++
> >  tools/perf/util/syscalltbl.c                       |   8 +-
> >  tools/scripts/syscall.tbl                          | 409 +++++++++++++++++++++
> >  12 files changed, 585 insertions(+), 77 deletions(-)
> > 
> > diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
> > index 2916d59c88cd08b299202a48ddb42fa32aac04a6..a72f25162714f0117a88d94474da336814d4f030 100644
> > --- a/tools/perf/Makefile.config
> > +++ b/tools/perf/Makefile.config
> > @@ -35,6 +35,13 @@ ifneq ($(NO_SYSCALL_TABLE),1)
> >      NO_SYSCALL_TABLE := 0
> >    endif
> >  
> > +  # architectures that use the generic syscall table scripts
> > +  ifeq ($(SRCARCH),riscv)
> > +    NO_SYSCALL_TABLE := 0
> > +    CFLAGS += -DGENERIC_SYSCALL_TABLE
> > +    CFLAGS += -I$(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated
> > +  endif
> > +
> >    ifneq ($(NO_SYSCALL_TABLE),1)
> >      CFLAGS += -DHAVE_SYSCALL_TABLE_SUPPORT
> >    endif
> > @@ -83,10 +90,6 @@ ifeq ($(ARCH),mips)
> >    LIBUNWIND_LIBS = -lunwind -lunwind-mips
> >  endif
> >  
> > -ifeq ($(ARCH),riscv)
> > -  CFLAGS += -I$(OUTPUT)arch/riscv/include/generated
> > -endif
> > -
> >  # So far there's only x86 and arm libdw unwind support merged in perf.
> >  # Disable it on all other architectures in case libdw unwind
> >  # support is detected in system. Add supported architectures
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index d74241a151313bd09101aabb5d765a5a0a6efc84..f5278ed9f778f928436693a14e016c5c3c5171c1 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -310,6 +310,10 @@ ifeq ($(filter feature-dump,$(MAKECMDGOALS)),feature-dump)
> >  FEATURE_TESTS := all
> >  endif
> >  endif
> > +# architectures that use the generic syscall table
> > +ifeq ($(SRCARCH),riscv)
> > +include $(srctree)/tools/perf/scripts/Makefile.syscalls
> > +endif
> >  include Makefile.config
> >  endif
> >  
> > diff --git a/tools/perf/arch/riscv/Makefile b/tools/perf/arch/riscv/Makefile
> > index 18ad078000e2bba595f92efc5d97a63fdb83ef45..087e099fb453a9236db34878077a51f711881ce0 100644
> > --- a/tools/perf/arch/riscv/Makefile
> > +++ b/tools/perf/arch/riscv/Makefile
> > @@ -1,25 +1,3 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  PERF_HAVE_JITDUMP := 1
> >  HAVE_KVM_STAT_SUPPORT := 1
> > -
> > -#
> > -# Syscall table generation for perf
> > -#
> > -
> > -out    := $(OUTPUT)arch/riscv/include/generated/asm
> > -header := $(out)/syscalls.c
> > -incpath := $(srctree)/tools
> > -sysdef := $(srctree)/tools/arch/riscv/include/uapi/asm/unistd.h
> > -sysprf := $(srctree)/tools/perf/arch/riscv/entry/syscalls/
> > -systbl := $(sysprf)/mksyscalltbl
> > -
> > -# Create output directory if not already present
> > -$(shell [ -d '$(out)' ] || mkdir -p '$(out)')
> > -
> > -$(header): $(sysdef) $(systbl)
> > -	$(Q)$(SHELL) '$(systbl)' '$(CC)' '$(HOSTCC)' $(incpath) $(sysdef) > $@
> > -
> > -clean::
> > -	$(call QUIET_CLEAN, riscv) $(RM) $(header)
> > -
> > -archheaders: $(header)
> > diff --git a/tools/perf/arch/riscv/entry/syscalls/Kbuild b/tools/perf/arch/riscv/entry/syscalls/Kbuild
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..9a41e3572c3afd4f202321fd9e492714540e8fd3
> > --- /dev/null
> > +++ b/tools/perf/arch/riscv/entry/syscalls/Kbuild
> > @@ -0,0 +1,2 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +syscall-y += syscalls_64.h
> > diff --git a/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls b/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..9668fd1faf60e828ed2786c2ee84739ac1f153fc
> > --- /dev/null
> > +++ b/tools/perf/arch/riscv/entry/syscalls/Makefile.syscalls
> > @@ -0,0 +1,4 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +syscall_abis_32 += riscv memfd_secret
> > +syscall_abis_64 += riscv rlimit memfd_secret
> > diff --git a/tools/perf/arch/riscv/entry/syscalls/mksyscalltbl b/tools/perf/arch/riscv/entry/syscalls/mksyscalltbl
> > deleted file mode 100755
> > index c59f5e852b97712a9a879b89e6ef6999ed4b6cd7..0000000000000000000000000000000000000000
> > --- a/tools/perf/arch/riscv/entry/syscalls/mksyscalltbl
> > +++ /dev/null
> > @@ -1,47 +0,0 @@
> > -#!/bin/sh
> > -# SPDX-License-Identifier: GPL-2.0
> > -#
> > -# Generate system call table for perf. Derived from
> > -# powerpc script.
> > -#
> > -# Copyright IBM Corp. 2017
> > -# Author(s):  Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
> > -# Changed by: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> > -# Changed by: Kim Phillips <kim.phillips@arm.com>
> > -# Changed by: Bj�rn T�pel <bjorn@rivosinc.com>
> > -
> > -gcc=$1
> > -hostcc=$2
> > -incpath=$3
> > -input=$4
> > -
> > -if ! test -r $input; then
> > -	echo "Could not read input file" >&2
> > -	exit 1
> > -fi
> > -
> > -create_sc_table()
> > -{
> > -	local sc nr max_nr
> > -
> > -	while read sc nr; do
> > -		printf "%s\n" "	[$nr] = \"$sc\","
> > -		max_nr=$nr
> > -	done
> > -
> > -	echo "#define SYSCALLTBL_RISCV_MAX_ID $max_nr"
> > -}
> > -
> > -create_table()
> > -{
> > -	echo "#include \"$input\""
> > -	echo "static const char *const syscalltbl_riscv[] = {"
> > -	create_sc_table
> > -	echo "};"
> > -}
> > -
> > -$gcc -E -dM -x c -I $incpath/include/uapi $input \
> > -	|awk '$2 ~ "__NR" && $3 !~ "__NR3264_" {
> > -		sub("^#define __NR(3264)?_", "");
> > -		print | "sort -k2 -n"}' \
> > -	|create_table
> > diff --git a/tools/perf/arch/riscv/include/syscall_table.h b/tools/perf/arch/riscv/include/syscall_table.h
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..7ff51b783000d727ec48be960730b81ecdb05575
> > --- /dev/null
> > +++ b/tools/perf/arch/riscv/include/syscall_table.h
> > @@ -0,0 +1,8 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#include <asm/bitsperlong.h>
> > +
> > +#if __BITS_PER_LONG == 64
> > +#include <asm/syscalls_64.h>
> > +#else
> > +#include <asm/syscalls_32.h>
> > +#endif
> > diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> > index a05c1c105c51bf1bd18a59195220894598eb7461..692f48db810ccbef229e240db29261f0c60db632 100755
> > --- a/tools/perf/check-headers.sh
> > +++ b/tools/perf/check-headers.sh
> > @@ -71,6 +71,7 @@ FILES=(
> >    "include/uapi/asm-generic/ioctls.h"
> >    "include/uapi/asm-generic/mman-common.h"
> >    "include/uapi/asm-generic/unistd.h"
> > +  "scripts/syscall.tbl"
> >  )
> >  
> >  declare -a SYNC_CHECK_FILES
> > diff --git a/tools/perf/scripts/Makefile.syscalls b/tools/perf/scripts/Makefile.syscalls
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..e2b0c4b513d5c42c8e9ac51a9ea774c34a1311b7
> > --- /dev/null
> > +++ b/tools/perf/scripts/Makefile.syscalls
> > @@ -0,0 +1,60 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +# This Makefile generates tools/perf/arch/$(SRCARCH)/include/generated/asm from
> > +# the generic syscall table if that is supported by the architecture, otherwise
> > +# from the architecture's defined syscall table.
> > +
> > +PHONY := all
> > +all:
> > +
> > +obj := $(OUTPUT)/tools/perf/arch/$(SRCARCH)/include/generated/asm
> > +
> > +syscall_abis_32  += common,32
> > +syscall_abis_64  += common,64
> 
> Couldn't it be := instead of += ?

Yes good point.

> 
> 
> > +syscalltbl := $(srctree)/tools/scripts/syscall.tbl
> > +
> > +# let architectures override $(syscall_abis_%) and $(syscalltbl)
> > +-include $(srctree)/tools/perf/arch/$(SRCARCH)/entry/syscalls/Makefile.syscalls
> > +include $(srctree)/scripts/Kbuild.include
> > +-include $(srctree)/tools/perf/arch/$(SRCARCH)/entry/syscalls/Kbuild
> > +
> > +systbl := $(srctree)/tools/perf/scripts/syscalltbl.sh
> > +
> > +syscall-y   := $(addprefix $(obj)/, $(syscall-y))
> > +
> > +# Remove stale wrappers when the corresponding files are removed from generic-y
> > +old-headers := $(wildcard $(obj)/*.c)
> > +unwanted    := $(filter-out $(syscall-y),$(old-headers))
> 
> Can you elaborate?  What's the stable wrappers?
> 
> I think syscall-y and old-headers have .h files but the wildcard above
> is called for .c files?

Oh yes! I meant to change that to .h, thank you for mentioning that, I
had .c at some point during development but changed it to .h files.

- Charlie

> 
> Thanks,
> Namhyung
> 
> > +
> > +quiet_cmd_remove = REMOVE  $(unwanted)
> > +      cmd_remove = rm -f $(unwanted)
> > +
> > +quiet_cmd_systbl = SYSTBL  $@
> > +      cmd_systbl = $(CONFIG_SHELL) $(systbl) \
> > +		   $(if $(systbl-args-$*),$(systbl-args-$*),$(systbl-args)) \
> > +		   --abis $(subst $(space),$(comma),$(strip $(syscall_abis_$*))) \
> > +		   $< $@
> > +
> > +all: $(syscall-y)
> > +	$(if $(unwanted),$(call cmd,remove))
> > +	@:
> > +
> > +$(obj)/syscalls_%.h: $(syscalltbl) $(systbl) FORCE
> > +	$(call if_changed,systbl)
> > +
> > +targets := $(syscall-y)
> > +
> > +# Create output directory. Skip it if at least one old header exists
> > +# since we know the output directory already exists.
> > +ifeq ($(old-headers),)
> > +$(shell mkdir -p $(obj))
> > +endif
> > +
> > +PHONY += FORCE
> > +
> > +FORCE:
> > +
> > +existing-targets := $(wildcard $(sort $(targets)))
> > +
> > +-include $(foreach f,$(existing-targets),$(dir $(f)).$(notdir $(f)).cmd)
> > +
> > +.PHONY: $(PHONY)

