Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385567A5988
	for <lists+linux-csky@lfdr.de>; Tue, 19 Sep 2023 07:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjISFqD (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 19 Sep 2023 01:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjISFpi (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 19 Sep 2023 01:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9493610F
        for <linux-csky@vger.kernel.org>; Mon, 18 Sep 2023 22:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695102291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=krzHPIvPrR+mrHTfBAZKaZNmesVu7Z9/EIlgAX8o7VY=;
        b=G2007Z8ETPPmqbLEjtsGIM2CWB8gp2XKR3ysGKuPZ5w6Fzku/UgQJIzA6ARzCfif9naze1
        ANS82IxkGTBqQe95CQ5Srf59Z0PkEX2mWWilA0a3pvsKPQr/KYJOxWaiTAQc/dpO4hMPJC
        ZUROHCxtAIcsMqHUQhf0/Eynu1fH3AI=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-nT-IgD2tP5mqg4H2dtc0Kg-1; Tue, 19 Sep 2023 01:44:50 -0400
X-MC-Unique: nT-IgD2tP5mqg4H2dtc0Kg-1
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6c0ca2454dbso5817246a34.0
        for <linux-csky@vger.kernel.org>; Mon, 18 Sep 2023 22:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695102289; x=1695707089;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=krzHPIvPrR+mrHTfBAZKaZNmesVu7Z9/EIlgAX8o7VY=;
        b=VgGMOf1MzjTarGWdaYkFOPy+Y/SZnvvjs9DzCS33KoTU0nk4HeZWeGmTh0S7mBz5C+
         5IxjrY5mYGPmbIt1tihlo6C74k0KDCygnR0uxTLzz62pd2HbCODQYchxSzaW0O3u/pUU
         30F/RRRz7W5jbINRYFY5upya/CWXuKr2xFqITFepRSBbLFEvd+pGosexQvKKuPMjzLXp
         M7TS1VHtBiUV6+nzSQM1QFuyQxvPABHFy8Zt2NDOsOwyThw7nzB6ZZyFJseFVCd5GYmK
         E5NKscTSJ7NofZwdUEsnreckE15N+ZWHSqWHCk3k+KNDUHSmsgPuCctJAFVoz7cxBBbL
         Uq+g==
X-Gm-Message-State: AOJu0YzWG+B127qjXBkUtZm3Lp6fS8F02R+3dLotRny2tx5jEn4Wqgwa
        FKbLdKgBy7Lwwq6P79kVk4QQYeIqUynaeEwt+kBVA64Pvz/iWDJCDjq+LrNUwcvUEfvyOwjSxtv
        wV2vepyAk5+LttZ7aE1Svsg==
X-Received: by 2002:a9d:6a8a:0:b0:6bc:be56:6b9b with SMTP id l10-20020a9d6a8a000000b006bcbe566b9bmr10927067otq.2.1695102289556;
        Mon, 18 Sep 2023 22:44:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJdB5NjDEtIXuqheBQo8aYK5FbffK/Ix4sW89JaXCyEgw9gnluw2TIPDkk/2geEreLfqtzrg==
X-Received: by 2002:a9d:6a8a:0:b0:6bc:be56:6b9b with SMTP id l10-20020a9d6a8a000000b006bcbe566b9bmr10927032otq.2.1695102289265;
        Mon, 18 Sep 2023 22:44:49 -0700 (PDT)
Received: from redhat.com ([2804:1b3:a803:677d:42e9:f426:9422:f020])
        by smtp.gmail.com with ESMTPSA id d129-20020a4a5287000000b0057346742d82sm5359793oob.6.2023.09.18.22.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 22:44:48 -0700 (PDT)
Date:   Tue, 19 Sep 2023 02:44:38 -0300
From:   Leonardo Bras <leobras@redhat.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     paul.walmsley@sifive.com, anup@brainfault.org,
        peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        palmer@rivosinc.com, longman@redhat.com, boqun.feng@gmail.com,
        tglx@linutronix.de, paulmck@kernel.org, rostedt@goodmis.org,
        rdunlap@infradead.org, catalin.marinas@arm.com,
        conor.dooley@microchip.com, xiaoguang.xing@sophgo.com,
        bjorn@rivosinc.com, alexghiti@rivosinc.com, keescook@chromium.org,
        greentime.hu@sifive.com, ajones@ventanamicro.com,
        jszhang@kernel.org, wefu@redhat.com, wuwei2016@iscas.ac.cn,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V11 12/17] RISC-V: paravirt: pvqspinlock: Add nopvspin
 kernel parameter
Message-ID: <ZQk1Ri1DrchrrFLw@redhat.com>
References: <20230910082911.3378782-1-guoren@kernel.org>
 <20230910082911.3378782-13-guoren@kernel.org>
 <ZQP0EJc4ClA-iT6J@redhat.com>
 <CAJF2gTQMNu7PXf3JT-nZt1+jp6osqERUvnvEexjK+Ak=ahxcUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTQMNu7PXf3JT-nZt1+jp6osqERUvnvEexjK+Ak=ahxcUA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sun, Sep 17, 2023 at 11:03:30PM +0800, Guo Ren wrote:
> On Fri, Sep 15, 2023 at 2:05 PM Leonardo Bras <leobras@redhat.com> wrote:
> >
> > On Sun, Sep 10, 2023 at 04:29:06AM -0400, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Disables the qspinlock slow path using PV optimizations which
> > > allow the hypervisor to 'idle' the guest on lock contention.
> > >
> > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > Signed-off-by: Guo Ren <guoren@kernel.org>
> > > ---
> > >  Documentation/admin-guide/kernel-parameters.txt |  2 +-
> > >  arch/riscv/kernel/qspinlock_paravirt.c          | 13 +++++++++++++
> > >  2 files changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > > index f75bedc50e00..e74aed631573 100644
> > > --- a/Documentation/admin-guide/kernel-parameters.txt
> > > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > > @@ -3857,7 +3857,7 @@
> > >                       as generic guest with no PV drivers. Currently support
> > >                       XEN HVM, KVM, HYPER_V and VMWARE guest.
> > >
> > > -     nopvspin        [X86,XEN,KVM]
> > > +     nopvspin        [X86,XEN,KVM,RISC-V]
> > >                       Disables the qspinlock slow path using PV optimizations
> > >                       which allow the hypervisor to 'idle' the guest on lock
> > >                       contention.
> > > diff --git a/arch/riscv/kernel/qspinlock_paravirt.c b/arch/riscv/kernel/qspinlock_paravirt.c
> > > index 85ff5a3ec234..a0ad4657f437 100644
> > > --- a/arch/riscv/kernel/qspinlock_paravirt.c
> > > +++ b/arch/riscv/kernel/qspinlock_paravirt.c
> > > @@ -41,8 +41,21 @@ EXPORT_STATIC_CALL(pv_queued_spin_lock_slowpath);
> > >  DEFINE_STATIC_CALL(pv_queued_spin_unlock, native_queued_spin_unlock);
> > >  EXPORT_STATIC_CALL(pv_queued_spin_unlock);
> > >
> > > +static bool nopvspin;
> >
> > It is only used in init, so it makes sense to add __initdata.
> >
> > static bool nopvspin __initdata;
> Okay.

Thx!
Leo

> 
> >
> > Other than that, LGTM:
> > Reviewed-by: Leonardo Bras <leobras@redhat.com>
> >
> > Thanks!
> > Leo
> >
> > > +static __init int parse_nopvspin(char *arg)
> > > +{
> > > +       nopvspin = true;
> > > +       return 0;
> > > +}
> > > +early_param("nopvspin", parse_nopvspin);
> > > +
> > >  void __init pv_qspinlock_init(void)
> > >  {
> > > +     if (nopvspin) {
> > > +             pr_info("PV qspinlocks disabled\n");
> > > +             return;
> > > +     }
> > > +
> > >       if (num_possible_cpus() == 1)
> > >               return;
> > >
> > > --
> > > 2.36.1
> > >
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
> 

