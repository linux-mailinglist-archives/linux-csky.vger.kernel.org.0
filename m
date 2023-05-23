Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E109F70D44C
	for <lists+linux-csky@lfdr.de>; Tue, 23 May 2023 08:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbjEWGtU (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 23 May 2023 02:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjEWGtT (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 23 May 2023 02:49:19 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A70119
        for <linux-csky@vger.kernel.org>; Mon, 22 May 2023 23:49:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-25275edf6caso3199511a91.1
        for <linux-csky@vger.kernel.org>; Mon, 22 May 2023 23:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684824557; x=1687416557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/CIN3k3pgEX900re7PcWc+Ixgh9Bvf8RnAPTzy/Q9qA=;
        b=cvzXNBZcONpo9ubWJ3RJzuhpxW2KbOHQ7DyYNvAc6zjsDwkoebi1Cb5OK1Si5f9EkR
         7oTDI3fOalzwEfxtNnjihGdUMwDKSXZkE1HxrdBA6wmIpDrDdXEuHHx+k5U8WxTjUW6a
         mu753zyCxef2tvJdD9aw9+fAS79oQq8BvweBwSgvtEh+sI7C8jHfILbMxxemelnlc3hv
         TQ76LfGIYbtcp4Xin0+PZPpMPCazlIiSEf0zHBPlJ/lt04cX+mrF/dfXBXOD6CJSsLoI
         4UXwZa6kWsBRXaq6cv37NKE/oQi4+8PAY+qFC8UB3Ei+yLADc6sD5PlY57Ui2VfaCgdA
         FoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684824557; x=1687416557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/CIN3k3pgEX900re7PcWc+Ixgh9Bvf8RnAPTzy/Q9qA=;
        b=Exi0Lc9Cve0jAo6aV80R56ltWL5S6KlzQKoKgSoTq/j0aCe0s75AXBPPeh2V6FT/WT
         1wEcZxJxyopaEon52v35U/et81UeMOo6pINNSsKnCTJXdXm2/qKlNgWqP2x6nszSjK1v
         YqQOpJMGK6Jqc5DPIirpAZuisCgTBoWqUH08BvNIWn+IqFz4fQ4Jc4ie4Wh0qENN2J9n
         H9jW34j9Fz06Vjk93WpmvMShZiaYH6aYHdUHgZvmG/uGmlifk41EFbmTj3S3H05B3Q4R
         4lqH4H5LFFtDHIoS29u0aImU4e5Yc/j/+cONkVzrlZ7kcg/0ZvsFyIV5SUH1GwH39UR4
         04cg==
X-Gm-Message-State: AC+VfDwH+H4zXYffT8o8VorbaMSX9Hhp1HIBAIH2GvH0ngcgHHCsfKMa
        q6X9YxMOhLICKmaRyukqmDJ6Fw==
X-Google-Smtp-Source: ACHHUZ7nNz4A5dl27YEbGjluXzF+Iu6AoPCKpNsPdYErA3ftUxN2fDxtCgclj2E7xLaUJ53OH6sH7g==
X-Received: by 2002:a17:90a:984:b0:253:9548:91e1 with SMTP id 4-20020a17090a098400b00253954891e1mr12132128pjo.17.1684824556586;
        Mon, 22 May 2023 23:49:16 -0700 (PDT)
Received: from leoy-yangtze.lan ([107.151.177.126])
        by smtp.gmail.com with ESMTPSA id w62-20020a17090a6bc400b00246774a9addsm7391986pjj.48.2023.05.22.23.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 23:49:16 -0700 (PDT)
Date:   Tue, 23 May 2023 14:49:04 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        Eric Lin <eric.lin@sifive.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Qi Liu <liuqi115@huawei.com>,
        Sandipan Das <sandipan.das@amd.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 2/5] perf parse-regs: Introduce functions
 arch__reg_{ip|sp}()
Message-ID: <20230523064904.GA1969788@leoy-yangtze.lan>
References: <20230520025537.1811986-1-leo.yan@linaro.org>
 <20230520025537.1811986-3-leo.yan@linaro.org>
 <CAP-5=fU-+8Sdw0tfQNYN40tXanrzUgqv0=6jsHqGR9cgjkQa2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU-+8Sdw0tfQNYN40tXanrzUgqv0=6jsHqGR9cgjkQa2A@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Mon, May 22, 2023 at 11:08:12AM -0700, Ian Rogers wrote:

[...]

> > diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> > index 8720ec6cf147..334c9a2b785d 100644
> > --- a/tools/perf/util/perf_regs.c
> > +++ b/tools/perf/util/perf_regs.c
> > @@ -20,6 +20,16 @@ uint64_t __weak arch__user_reg_mask(void)
> >         return PERF_REGS_MASK;
> >  }
> >
> > +uint64_t __weak arch__reg_ip(void)
> > +{
> > +       return 0;
> > +}
> > +
> > +uint64_t __weak arch__reg_sp(void)
> > +{
> > +       return 0;
> > +}
> > +
> 
> Is there a need for the weak function if there is a definition for
> every architecture?

In current code, some archs don't support register parsing (e.g.
arch/alpha, arch/parisc, arch/riscv64, etc), this is why I added weak
functions to avoid building breakage for these archs.

> A problem with weak definitions is that they are
> not part of the C standard, so strange things can happen such as
> inlining - although I think this code is safe.

Good to know this info, thanks for sharing.

> Not having the weak
> functions means that if someone tries to bring up a new architecture
> they will get linker failures until they add the definitions. Failing
> to link seems better than silently succeeding but then having to track
> down runtime failures because these functions are returning 0.

I agreed that removing weak functions is better way to move forward.

If removing the weak functions, we need to handle cases for below
archs which don't support register parsing:

  arch/alpha/
  arch/arc/
  arch/parisc/
  arch/riscv64/
  arch/sh/
  arch/sparc/
  arch/xtensa/

As James pointed out perf fails to support cross unwinding, I will update
this patch, the new version's arch__reg_ip() / arch__reg_sp() will return
IP and SP registers based on the passed 'arch' parameter; for above
unsupported archs, arch__reg_ip() / arch__reg_sp() will return error and
architecture developers can extend register parsing in the future.

In this way, we also can remove weak definitions, this can give us an
extra benefit :)

Thanks,
Leo
