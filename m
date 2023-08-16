Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773B877E0C2
	for <lists+linux-csky@lfdr.de>; Wed, 16 Aug 2023 13:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242848AbjHPLs6 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Wed, 16 Aug 2023 07:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244774AbjHPLsg (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Wed, 16 Aug 2023 07:48:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3B3E68;
        Wed, 16 Aug 2023 04:48:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7D9C666EE;
        Wed, 16 Aug 2023 11:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4427C433C8;
        Wed, 16 Aug 2023 11:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692186514;
        bh=v2m2BK3GGd11X74j40insUcmDxokoIf6Czvuxm4GLe0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIQ+3GZqZqX0YR2G3PxIKU4z7PLWBtwM1cFVVGQ7TYpvNN9lOIKya5TYcEllvV5/r
         +W8yXiXqVRP/pyu1E7I1vsZS3Jmp1oPKegOA3D++BcgVc2hV56aJ/5pykDa8EoW5RM
         pn1sIBsV+LvX31A82MRtST79dD+bQ4uCQ6zuHoF9bLeJWYVhMYnHiEsAM3ZE+A5xhP
         OlEOpJtaeMdzzlm7S5bBj8a/ri7rIyXml8SPM1N3iPUt7Pr4hNL9zEtmTp2QT6Jsj7
         o/nDUGMASQ/yVc/jLwynWG2VYzo1rluHDyXfJ0BrGMmMW0oFDUNL9ETcMIMJlZfEuF
         sn8f0KkVIYj8A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 00D32404DF; Wed, 16 Aug 2023 08:48:30 -0300 (-03)
Date:   Wed, 16 Aug 2023 08:48:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Guo Ren <guoren@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Huacai Chen <chenhuacai@kernel.org>,
        Ming Wang <wangming01@loongson.cn>,
        Eric Lin <eric.lin@sifive.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Sandipan Das <sandipan.das@amd.com>,
        Ivan Babrou <ivan@cloudflare.com>,
        Fangrui Song <maskray@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 0/6] perf parse-regs: Refactor architecture functions
Message-ID: <ZNy3jg7xxBp4161E@kernel.org>
References: <20230606014559.21783-1-leo.yan@linaro.org>
 <CAP-5=fV1m440mKc0R=m5C4N2NtoiixchtnpX2eR3PA_5hXbqEQ@mail.gmail.com>
 <ZNvCxM/ULdUfzHtR@kernel.org>
 <ZNvHx+KxIL6JzEl/@kernel.org>
 <ZNvJdsVmmAWLmfH6@kernel.org>
 <ZNvKjeFkXY8ezf9e@kernel.org>
 <20230816020715.GA135657@leoy-huanghe.lan>
 <ZNy3D6DV3Q9YjxKd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZNy3D6DV3Q9YjxKd@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

Em Wed, Aug 16, 2023 at 08:46:23AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Aug 16, 2023 at 10:07:15AM +0800, Leo Yan escreveu:
> > On Tue, Aug 15, 2023 at 03:57:17PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Aug 15, 2023 at 03:52:38PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Em Tue, Aug 15, 2023 at 03:45:27PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > > > Agreed, applied to perf-tools-next, sorry for the delay.
> > > > > 
> > > > > Had to add this to make 'perf test python' to work. Please run 'perf
> > > > > test' before sending patches.
> > > > 
> > > > One more, please also do a 'make -C tools/perf build-test', with it I
> > > > caught this:
> > > > 
> > > >          make_no_libunwind_O: cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.yeEGyQq2HR DESTDIR=/tmp/tmp.ITgoO16jjH
> > > > cd . && make NO_LIBUNWIND=1 FEATURES_DUMP=/var/home/acme/git/perf-tools-next/tools/perf/BUILD_TEST_FEATURE_DUMP -j32 O=/tmp/tmp.yeEGyQq2HR DESTDIR=/tmp/tmp.ITgoO16jjH
> > > 
> > > +#include "util/env.h"
> > > 
> > > As now we need it for perf_env__arch(ui->machine->env)
> > 
> > Sorry for inconvenience.
> > 
> > I saw this patch series has been picked into the branch:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf-tools-next
> > 
> > If want me to follow up, let me know.  Thank you!
> 
> Right, I'll fix this ones:
> 
> [perfbuilder@five ~]$ grep "unused variable" dm.log/*:*
> dm.log/ubuntu:18.04-x-m68k:util/evsel.c:848:14: error: unused variable 'arch' [-Werror=unused-variable]
> dm.log/ubuntu:18.04-x-riscv64:util/evsel.c:848:14: error: unused variable 'arch' [-Werror=unused-variable]
> dm.log/ubuntu:18.04-x-sh4:util/evsel.c:848:14: error: unused variable 'arch' [-Werror=unused-variable]
> dm.log/ubuntu:18.04-x-sparc64:util/evsel.c:848:14: error: unused variable 'arch' [-Werror=unused-variable]
> [perfbuilder@five ~]$
> 
> And move that to perf-tools-next, we can go on from there.
> 
> The above is because we don't define CONFIG_PERF_REGS for these
> architectures and thus that variable ends up not being used, so I'm
> fixing up like below, in the cset where you made DWARF_MINIMAL_REGS
> receive the arch parameter.

I added this to the cset commit message:

Committer notes:

Make DWARF_MINIMAL_REGS() an inline function, so that we can use the
__maybe_unused attribute for the 'arch' parameter, as this will avoid a
build failure when that variable is unused in the callers. That happens
when building on unsupported architectures, the ones without
HAVE_PERF_REGS_SUPPORT defined.

 
> Also I haven't checked how gracefully we react when processing a
> perf.data collected in one of those unsupported arches, can you please
> check?
> 
> - Arnaldo
> 
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 790c1a26bbfe9b4b..de1673057e502de9 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -32,9 +32,6 @@ extern const struct sample_reg sample_reg_masks[];
>  
>  #include <perf_regs.h>
>  
> -#define DWARF_MINIMAL_REGS(arch)	\
> -	((1ULL << perf_arch_reg_ip(arch)) | (1ULL << perf_arch_reg_sp(arch)))
> -
>  const char *perf_reg_name(int id, const char *arch);
>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
>  uint64_t perf_arch_reg_ip(const char *arch);
> @@ -67,11 +64,19 @@ const char *__perf_reg_name_x86(int id);
>  uint64_t __perf_reg_ip_x86(void);
>  uint64_t __perf_reg_sp_x86(void);
>  
> +static inline uint64_t DWARF_MINIMAL_REGS(const char *arch)
> +{
> +	return (1ULL << perf_arch_reg_ip(arch)) | (1ULL << perf_arch_reg_sp(arch));
> +}
> +
>  #else
>  #define PERF_REGS_MASK	0
>  #define PERF_REGS_MAX	0
>  
> -#define DWARF_MINIMAL_REGS(arch)	PERF_REGS_MASK
> +static inline uint64_t DWARF_MINIMAL_REGS(const char *arch __maybe_unused)
> +{
> +	return PERF_REGS_MASK;
> +}
>  
>  static inline const char *perf_reg_name(int id __maybe_unused, const char *arch __maybe_unused)
>  {
>  
> > > >   CC      /tmp/tmp.yeEGyQq2HR/util/expr-flex.o
> > > > util/unwind-libdw.c: In function ‘memory_read’:
> > > > util/unwind-libdw.c:173:28: error: implicit declaration of function ‘perf_env__arch’ [-Werror=implicit-function-declaration]
> > > >   173 |         const char *arch = perf_env__arch(ui->machine->env);
> > > >       |                            ^~~~~~~~~~~~~~
> > > > util/unwind-libdw.c:173:28: error: initialization of ‘const char *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
> > > > util/unwind-libdw.c: In function ‘unwind__get_entries’:
> > > > util/unwind-libdw.c:258:28: error: initialization of ‘const char *’ from ‘int’ makes pointer from integer without a cast [-Werror=int-conversion]
> > > >   258 |         const char *arch = perf_env__arch(ui_buf.machine->env);
> > > >       |                            ^~~~~~~~~~~~~~
> > > > cc1: all warnings being treated as errors
> > > > make[6]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:98: /tmp/tmp.yeEGyQq2HR/util/unwind-libdw.o] Error 1
> > > > make[6]: *** Waiting for unfinished jobs....
> > > > make[5]: *** [/var/home/acme/git/perf-tools-next/tools/build/Makefile.build:150: util] Error 2
> > > > make[4]: *** [Makefile.perf:662: /tmp/tmp.yeEGyQq2HR/perf-in.o] Error 2
> > > > make[4]: *** Waiting for unfinished jobs....
> > > >   CC      /tmp/tmp.yeEGyQq2HR/pmu-events/pmu-events.o
> > > >   LD      /tmp/tmp.yeEGyQq2HR/pmu-events/pmu-events-in.o
> > > > make[3]: *** [Makefile.perf:238: sub-make] Error 2
> > > > make[2]: *** [Makefile:70: all] Error 2
> > > > make[1]: *** [tests/make:337: make_no_libunwind_O] Error 1
> > > > make: *** [Makefile:103: build-test] Error 2
> > > > make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
> > > > 
> > > > real	1m29.784s
> > > > user	10m41.597s
> > > > sys	2m55.948s
> > > > ⬢[acme@toolbox perf-tools-next]$
> > > > 
> > > > I'm trying to fix
> > > 
> > > -- 
> > > 
> > > - Arnaldo
> 
> -- 
> 
> - Arnaldo

-- 

- Arnaldo
