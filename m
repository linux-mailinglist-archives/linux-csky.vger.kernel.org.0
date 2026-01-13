Return-Path: <linux-csky+bounces-2698-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B6162D16585
	for <lists+linux-csky@lfdr.de>; Tue, 13 Jan 2026 03:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 709FF30213CE
	for <lists+linux-csky@lfdr.de>; Tue, 13 Jan 2026 02:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6332E7F3E;
	Tue, 13 Jan 2026 02:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3Xb02yV"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3367827FD68
	for <linux-csky@vger.kernel.org>; Tue, 13 Jan 2026 02:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768272110; cv=pass; b=Pv0zQrg8AGEgVEIuRZc/npDUHV1QDASQ5v4f2nke/pAQk23taxKMr6L02HF9A+2WOXjQTIOyHBcwHFcf9oTxrdK3KiW2O/U/Lx03EYMFqJvbI7lygR/7kzWnIMQCpcOepuwCtG2Pnkx/Q/dQScvcAvOsVE4t9WwA/nC/r737i9g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768272110; c=relaxed/simple;
	bh=svMl9ux70KbV7Le/Pt6s4iHYNT8ivSU0DHGMDPo2Wvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvRA3AlslS7M43v6KgNR0Ep4bBuodj7fReXvTtNvP3My1DNXLVKcx3IMECQykw7U9UoCqDkmxE9pRj+i76V9G/8ery+WjFZM/Xwy/zTxK6wcC6lITsjg4afwpicrmtrryMv0FwRRk03h2kZMFNWaD2KLcVzuhmZofVYcDft40Gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3Xb02yV; arc=pass smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-11a247de834so3738c88.0
        for <linux-csky@vger.kernel.org>; Mon, 12 Jan 2026 18:41:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768272107; cv=none;
        d=google.com; s=arc-20240605;
        b=hU0Cwb8+N6JA4bOGn11fFSCCQHpsakYwdZIkhN00L04Hy71t4QXeITcw9546/s2Muz
         pN2cA52YgQwhrLci35Epm6TOWohyeWH0Ceos0UvCm4VP2NIVPCucsAKPNpeY0BLm9gUG
         5e7ZlwzmUL8TFe0pjCAd+D1R7DD+ZYLgnhXG0vcAtmj09XvpOk//ej+RSnYTBt1MV3B1
         /TBFWXzF2dmrmzcIg/be9z9KOiiCCls8JnhgiImvYa+OSHuOXpjunA/LSZO6e0B3PNwW
         dYU2IXbqb0auaVlDl7s2UnvOlr8gAHLe+r/JJlpHyxkZSwWqRr1CzGzWhLbuQnyWZBsk
         iYKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C6AKUL58zxtdwBeVn+jBaylK1k4DvcK76gK8pdSrhoo=;
        fh=FZ/hyH7W04EqtC4fIqKzofOKcXEK+dMJruedmhbZ5xQ=;
        b=KY5tmar63R2X1J1wiDXvQ2RpVLk2FsUvbr7VPDrKZRT1RyO6qC+DRXOjAhyWlarXWj
         xSk8sqrS1La/Inx8aAtm+hMUoEVIMQsln2LFgZ6LqRa9O4P+kb3B5+d4WkYzZ+zFJAXy
         jmhoSdbkI85vZXHglKFDmreqF4JtiRxBmzQu9YzYl5HZo3cU22oVPDkYjo75lUi6smMy
         FEwiviSrzO70KzmVVH3lXGHuiGC7xO/6YsRobgu2EXEWosDeEceMdqxfE1gRxoSXn0Ww
         2ouDUP42zVawc6zEfEPX/Ne9IVRJajYYe6IPsx+2g+I6LCVe1Kf5zZavElNJOjWO/UWg
         GUKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768272107; x=1768876907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C6AKUL58zxtdwBeVn+jBaylK1k4DvcK76gK8pdSrhoo=;
        b=Q3Xb02yVJC/CcunH8dPuUyParP2/m6xIVJyGaI9J0/svu5AVY8CKDJmTkI/lU9nSfV
         Osg4f0S5HLUBZhZpsZPDILJ66SBrnzJtnCsTBRU7GqgPjRoPxNlrE/Uqb2hs+tQtUlml
         8VEr+GAMe8UCPa62Qv92NkjTdq/Fz98kzc2wA6hZ1L8EPa4beHFLioUg4iJq0p3bWL+F
         c+aukIvuG5J5/l18m5nN9m6ob9NPyfk+662Z07fscluc5jSgg9WVL7f/FL7lBDuUa+cA
         ijQyNPcHbAgezySGb5buqp7KIUCxxNuBUhwoM9LCrBEgi+lLWJnz6a5AwiZsWP8L/w+X
         5Crw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768272107; x=1768876907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C6AKUL58zxtdwBeVn+jBaylK1k4DvcK76gK8pdSrhoo=;
        b=J4NkLRJOOqk/0rwkb+M80WAXLwtfEPpRrfGmKFh/nJ1z6URPl4gc8Op+xauED1B6Sl
         tQL2A+Z10I6r90IQLERP6MFcER8pv09DQbvxLQAkaF2yhcSOhjlO5ajsM+e2Oa0PTSGT
         M+emm4MpSQgWAgi+SCjC1NZQNd1IQy2+lYBP0CV3I/kbsd7wRB/eaynjxidmb1kjfA9i
         crXFuAwG+rfdj21j9P1oY9NtuZfT3hWTnUs9uYBHdNPGP8dto7LQzpDGMELajxQOPl24
         qLh460+msdzey1ljH5etlto17XJa1Upl1vDyVpZuZ9H9j1HljIbBOWrfy52Ad8oq+jOx
         6VOw==
X-Forwarded-Encrypted: i=1; AJvYcCVxdz+4Nrfryd/6eIZb0nSUDpsd71hDh7P77Beexk20GaD6iOfHIXxWskccsvkNY5EbB/IgHb8FA1Xi@vger.kernel.org
X-Gm-Message-State: AOJu0YzHvzi+E54cv20yHanBxletglO76utH2iT26rqx5TuKLD9OwmMW
	hBFnxp43Ax0b4KvOoB545zwo1ZhwPsUvTbbYMgTrYBqDRbHmObbf9I3soJzGCMI0r1Zux+8aFy0
	bWW0HJ1OtijPfWVK7Qfxxi5ctl4zZe4r1H8tOawWg
X-Gm-Gg: AY/fxX6y+OEc2NlggncNPWqikI5Y+q7Eat/lyycdHHaqWmTH4LhrpbXIqIN0uzy8mgw
	wlXEzaShruGoSdr8adehbxDnKUlWrGHtoks7QHc28TnFTdnUZuoGXyrtTFP2yLCw9z64zNOULAh
	0sEJcuHK7A1KaCP+vNGX1LQn+JQDe262t/+1IY8vbazOxc7lxGPfYbWglR5CRnyQurjlrKlpZtI
	6XxMRtfRxFtVYkiUIVRQNt08inkhnWxpEaxS9U9J3JVb91ztwnDF7MSW/79hMOxrNC+SOEf
X-Received: by 2002:a05:7022:7e07:b0:120:5719:1853 with SMTP id
 a92af1059eb24-1232ca6fdf1mr31130c88.17.1768272106334; Mon, 12 Jan 2026
 18:41:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260107-cross-arch-unwind-v3-1-db0e37c8a652@skydio.com>
In-Reply-To: <20260107-cross-arch-unwind-v3-1-db0e37c8a652@skydio.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 12 Jan 2026 18:41:34 -0800
X-Gm-Features: AZwV_Qjx81xRN3u9yzvKPm3mk0d4T_8c0mUYxuqp5IG3DlF6QWOu6fa5DL4Gbzg
Message-ID: <CAP-5=fXOC5kUQDE-GbbYGgXJNRpvm_p=ssYc31pMJhxqzfbkEg@mail.gmail.com>
Subject: Re: [PATCH v3] perf unwind-libdw: fix a cross-arch unwinding bug
To: shimin.guo@skydio.com
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 7, 2026 at 8:41=E2=80=AFPM Shimin Guo via B4 Relay
<devnull+shimin.guo.skydio.com@kernel.org> wrote:
>
> From: Shimin Guo <shimin.guo@skydio.com>
>
> The set_initial_registers field of Dwfl_Thread_Callbacks needs to be set
> according to the arch of the stack samples being analyzed, not the arch
> that perf itself is built for. Currently perf fails to unwind stack sampl=
es
> collected from archs different from that of the host perf is running on.
> This patch moves the arch-specific implementations of set_initial_registe=
rs
> from tools/perf/arch to tools/perf/utli/unwind-libdw-arch, similar to the
> way the perf-regs-arch folder contains arch-specific functions related to
> registers, and chooses the implementation based on the arch of the data
> being processed.
>
> Signed-off-by: Shimin Guo <shimin.guo@skydio.com>
> ---
> Changes in v3:
> - tools/perf/util/unwind-libdw-arch/Build: replacing
> perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) with simply perf-util-y, as the
> directory itself is included based on CONFIG_LIBDW_DWARF_UNWIND. Also
> adding a missing newline at the end.
> - Changed the include paths in the moved files to be relative to tools/pe=
rf
> - Link to v2: https://lore.kernel.org/r/20260105-cross-arch-unwind-v2-1-9=
a8b0b14ce7b@skydio.com
>
> Fix a cross-architecture libdw DWARF unwinding bug in perf
>
> Changes in v2:
> - Fixed the include path for perf_regs.h in unwind-libdw-x86.c
> - Removed one level of "../" from the include paths in the moved files
> now that they are two directory levels under tools/perf instead of three.
> - Link to v1: https://lore.kernel.org/r/20251223-cross-arch-unwind-v1-1-4=
d71ee7db512@skydio.com
> ---
>  tools/perf/arch/arm/util/Build                     |  1 -
>  tools/perf/arch/arm64/util/Build                   |  1 -
>  tools/perf/arch/csky/util/Build                    |  2 -
>  tools/perf/arch/powerpc/util/Build                 |  1 -
>  tools/perf/arch/riscv/util/Build                   |  1 -
>  tools/perf/arch/s390/util/Build                    |  2 -
>  tools/perf/arch/x86/util/Build                     |  1 -
>  tools/perf/util/Build                              |  1 +
>  tools/perf/util/unwind-libdw-arch/Build            |  8 ++++
>  .../unwind-libdw-arch/unwind-libdw-arm.c}          | 10 ++---
>  .../unwind-libdw-arch/unwind-libdw-arm64.c}        | 10 ++---
>  .../unwind-libdw-arch/unwind-libdw-csky.c}         | 10 ++---
>  .../unwind-libdw-arch/unwind-libdw-loongarch.c}    | 10 ++---
>  .../unwind-libdw-arch/unwind-libdw-powerpc.c}      | 10 ++---
>  .../unwind-libdw-arch/unwind-libdw-riscv.c}        | 10 ++---
>  .../unwind-libdw-arch/unwind-libdw-s390.c}         | 14 +++---
>  .../unwind-libdw-arch/unwind-libdw-x86.c}          |  8 ++--
>  tools/perf/util/unwind-libdw.c                     | 51 ++++++++++++++++=
+++---
>  tools/perf/util/unwind-libdw.h                     | 10 ++++-
>  19 files changed, 104 insertions(+), 57 deletions(-)
>
> diff --git a/tools/perf/arch/arm/util/Build b/tools/perf/arch/arm/util/Bu=
ild
> index fd695e1fdaee2ccc300a206131b8b38a763b00ce..3291f893b943df0722dff5835=
23fff4ae79919bc 100644
> --- a/tools/perf/arch/arm/util/Build
> +++ b/tools/perf/arch/arm/util/Build
> @@ -1,6 +1,5 @@
>  perf-util-y +=3D perf_regs.o
>
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
>
>  perf-util-y +=3D pmu.o auxtrace.o cs-etm.o
> diff --git a/tools/perf/arch/arm64/util/Build b/tools/perf/arch/arm64/uti=
l/Build
> index d63881081d2eb1e9a83eabf82104d75308f7fc79..0177af19cc00038d6a6005592=
ddc530bf7eb1557 100644
> --- a/tools/perf/arch/arm64/util/Build
> +++ b/tools/perf/arch/arm64/util/Build
> @@ -1,4 +1,3 @@
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
>  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND) +=3D unwind-libunwind.o
>  perf-util-y +=3D ../../arm/util/auxtrace.o
> diff --git a/tools/perf/arch/csky/util/Build b/tools/perf/arch/csky/util/=
Build
> index 5e6ea82c42021d3d5651ca4c4a3a6e5138574e4e..6b2d0e021b11464e46d6b5397=
4260d32ea969732 100644
> --- a/tools/perf/arch/csky/util/Build
> +++ b/tools/perf/arch/csky/util/Build
> @@ -1,3 +1 @@
>  perf-util-y +=3D perf_regs.o
> -
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> diff --git a/tools/perf/arch/powerpc/util/Build b/tools/perf/arch/powerpc=
/util/Build
> index 3d0d5427aef7f26a8c05c883cc7ad763f08cbb30..5fd28ec713a4db74ecd1d2686=
6a65ddb20e94bd3 100644
> --- a/tools/perf/arch/powerpc/util/Build
> +++ b/tools/perf/arch/powerpc/util/Build
> @@ -9,5 +9,4 @@ perf-util-y +=3D evsel.o
>  perf-util-$(CONFIG_LIBDW) +=3D skip-callchain-idx.o
>
>  perf-util-$(CONFIG_LIBUNWIND) +=3D unwind-libunwind.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
>  perf-util-y +=3D auxtrace.o
> diff --git a/tools/perf/arch/riscv/util/Build b/tools/perf/arch/riscv/uti=
l/Build
> index 58a672246024dd0f72e767d11e9958bd9913ec3c..628b9ebd418bde8cdf1ab1332=
bf79f7c9d50760e 100644
> --- a/tools/perf/arch/riscv/util/Build
> +++ b/tools/perf/arch/riscv/util/Build
> @@ -2,4 +2,3 @@ perf-util-y +=3D perf_regs.o
>  perf-util-y +=3D header.o
>
>  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> diff --git a/tools/perf/arch/s390/util/Build b/tools/perf/arch/s390/util/=
Build
> index c64eb18dbdae93adafabf8542e4c9a763ecfe057..5391d26fedd46b7d30a1bef0b=
ff2ec2d58ec30ed 100644
> --- a/tools/perf/arch/s390/util/Build
> +++ b/tools/perf/arch/s390/util/Build
> @@ -2,8 +2,6 @@ perf-util-y +=3D header.o
>  perf-util-$(CONFIG_LIBTRACEEVENT) +=3D kvm-stat.o
>  perf-util-y +=3D perf_regs.o
>
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> -
>  perf-util-y +=3D machine.o
>  perf-util-y +=3D pmu.o
>
> diff --git a/tools/perf/arch/x86/util/Build b/tools/perf/arch/x86/util/Bu=
ild
> index c0dc5965f3624a6f02525a04d287dff755356d20..fad256252bb95a8f8350b6bb1=
a54e8074eaebbec 100644
> --- a/tools/perf/arch/x86/util/Build
> +++ b/tools/perf/arch/x86/util/Build
> @@ -12,7 +12,6 @@ perf-util-y +=3D evsel.o
>  perf-util-y +=3D iostat.o
>
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind.o
> -perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
>
>  perf-util-y +=3D auxtrace.o
>  perf-util-y +=3D archinsn.o
> diff --git a/tools/perf/util/Build b/tools/perf/util/Build
> index 1c2a43e1dc68e7f751ec6082352b10de9ffeea62..15f8a4f4b24a46b6300e824f6=
72dd9c0d5b7865f 100644
> --- a/tools/perf/util/Build
> +++ b/tools/perf/util/Build
> @@ -226,6 +226,7 @@ perf-util-$(CONFIG_LIBDW) +=3D debuginfo.o
>  perf-util-$(CONFIG_LIBDW) +=3D annotate-data.o
>
>  perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw.o
> +perf-util-$(CONFIG_LIBDW_DWARF_UNWIND) +=3D unwind-libdw-arch/
>  perf-util-$(CONFIG_LOCAL_LIBUNWIND)    +=3D unwind-libunwind-local.o
>  perf-util-$(CONFIG_LIBUNWIND)          +=3D unwind-libunwind.o
>  perf-util-$(CONFIG_LIBUNWIND_X86)      +=3D libunwind/x86_32.o
> diff --git a/tools/perf/util/unwind-libdw-arch/Build b/tools/perf/util/un=
wind-libdw-arch/Build
> new file mode 100644
> index 0000000000000000000000000000000000000000..ef17a83a78136d7ab8d44c62d=
454742638ddf224
> --- /dev/null
> +++ b/tools/perf/util/unwind-libdw-arch/Build
> @@ -0,0 +1,8 @@
> +perf-util-y +=3D unwind-libdw-x86.o
> +perf-util-y +=3D unwind-libdw-arm.o
> +perf-util-y +=3D unwind-libdw-arm64.o
> +perf-util-y +=3D unwind-libdw-csky.o
> +perf-util-y +=3D unwind-libdw-loongarch.o
> +perf-util-y +=3D unwind-libdw-powerpc.o
> +perf-util-y +=3D unwind-libdw-riscv.o
> +perf-util-y +=3D unwind-libdw-s390.o
> diff --git a/tools/perf/arch/arm/util/unwind-libdw.c b/tools/perf/util/un=
wind-libdw-arch/unwind-libdw-arm.c
> similarity index 80%
> rename from tools/perf/arch/arm/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-arm.c
> index fbb643f224ec4b27ce9d67051fe0bc4ad555b05e..56e9b5975bcc60fa1aaae048f=
3b8aab7f1634db1 100644
> --- a/tools/perf/arch/arm/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm.c
> @@ -1,11 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> -#include "../../../util/unwind-libdw.h"
> -#include "../../../util/perf_regs.h"
> -#include "../../../util/sample.h"
> +#include "../arch/arm/include/uapi/asm/perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
> +#include "util/sample.h"
>
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_arm(Dwfl_Thread *thread, void *arg)
>  {
>         struct unwind_info *ui =3D arg;
>         struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> diff --git a/tools/perf/arch/arm64/util/unwind-libdw.c b/tools/perf/util/=
unwind-libdw-arch/unwind-libdw-arm64.c
> similarity index 87%
> rename from tools/perf/arch/arm64/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-arm64.c
> index b89b0a7e5ad919fed23643d219fbdc3d84deff1e..29b6833e036cc0d80322eb1f9=
5aea310df1cba49 100644
> --- a/tools/perf/arch/arm64/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-arm64.c
> @@ -1,11 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> -#include "../../../util/unwind-libdw.h"
> -#include "../../../util/perf_regs.h"
> -#include "../../../util/sample.h"
> +#include "../arch/arm64/include/uapi/asm/perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
> +#include "util/sample.h"
>
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_arm64(Dwfl_Thread *thread, void *arg)
>  {
>         struct unwind_info *ui =3D arg;
>         struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> diff --git a/tools/perf/arch/csky/util/unwind-libdw.c b/tools/perf/util/u=
nwind-libdw-arch/unwind-libdw-csky.c
> similarity index 90%
> rename from tools/perf/arch/csky/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
> index b20b1569783d7e982e91b1b40120d29ccf2f01d1..2556d034c32a464018b4f03ac=
57329249b8b1984 100644
> --- a/tools/perf/arch/csky/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-csky.c
> @@ -2,12 +2,12 @@
>  // Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd.
>
>  #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> -#include "../../util/unwind-libdw.h"
> -#include "../../util/perf_regs.h"
> -#include "../../util/event.h"
> +#include "../arch/csky/include/uapi/asm/perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
> +#include "util/sample.h"
>
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_csky(Dwfl_Thread *thread, void *arg)
>  {
>         struct unwind_info *ui =3D arg;
>         struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> diff --git a/tools/perf/arch/loongarch/util/unwind-libdw.c b/tools/perf/u=
til/unwind-libdw-arch/unwind-libdw-loongarch.c
> similarity index 86%
> rename from tools/perf/arch/loongarch/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> index 60b1144bedd5f325e1512eeab05c29a1e8de2b03..5fca673508be8218d4481a0c9=
5c38b0293789c34 100644
> --- a/tools/perf/arch/loongarch/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-loongarch.c
> @@ -2,12 +2,12 @@
>  /* Copyright (C) 2020-2023 Loongson Technology Corporation Limited */
>
>  #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> -#include "../../util/unwind-libdw.h"
> -#include "../../util/perf_regs.h"
> -#include "../../util/sample.h"
> +#include "../arch/loongarch/include/uapi/asm/perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
> +#include "util/sample.h"
>
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_loongarch(Dwfl_Thread *thread, void *ar=
g)
>  {
>         struct unwind_info *ui =3D arg;
>         struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> diff --git a/tools/perf/arch/powerpc/util/unwind-libdw.c b/tools/perf/uti=
l/unwind-libdw-arch/unwind-libdw-powerpc.c
> similarity index 89%
> rename from tools/perf/arch/powerpc/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
> index 82d0c28ae3459ecdb0039cac1f534420d142739b..1560db45e7b464877a5895feb=
389867937edcf83 100644
> --- a/tools/perf/arch/powerpc/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-powerpc.c
> @@ -1,10 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <elfutils/libdwfl.h>
>  #include <linux/kernel.h>
> -#include "perf_regs.h"
> -#include "../../../util/unwind-libdw.h"
> -#include "../../../util/perf_regs.h"
> -#include "../../../util/sample.h"
> +#include "../arch/powerpc/include/uapi/asm/perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
> +#include "util/sample.h"
>
>  /* See backends/ppc_initreg.c and backends/ppc_regs.c in elfutils.  */
>  static const int special_regs[3][2] =3D {
> @@ -13,7 +13,7 @@ static const int special_regs[3][2] =3D {
>         { 109, PERF_REG_POWERPC_CTR },
>  };
>
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *arg)
>  {
>         struct unwind_info *ui =3D arg;
>         struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> diff --git a/tools/perf/arch/riscv/util/unwind-libdw.c b/tools/perf/util/=
unwind-libdw-arch/unwind-libdw-riscv.c
> similarity index 87%
> rename from tools/perf/arch/riscv/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
> index dc1476e16321736de897ad53a00fbc813bd706db..c2e2c4b6b2e005fff4cb8045e=
f7d44a4d2458b47 100644
> --- a/tools/perf/arch/riscv/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-riscv.c
> @@ -2,12 +2,12 @@
>  /* Copyright (C) 2019 Hangzhou C-SKY Microsystems co.,ltd. */
>
>  #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> -#include "../../util/unwind-libdw.h"
> -#include "../../util/perf_regs.h"
> -#include "../../util/sample.h"
> +#include "../arch/riscv/include/uapi/asm/perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
> +#include "util/sample.h"
>
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg)
>  {
>         struct unwind_info *ui =3D arg;
>         struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> diff --git a/tools/perf/arch/s390/util/unwind-libdw.c b/tools/perf/util/u=
nwind-libdw-arch/unwind-libdw-s390.c
> similarity index 84%
> rename from tools/perf/arch/s390/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
> index c27c7a0d1076c890c35ba19543932c4ed5ac9c2a..1e05e9d9d95faf42cc2d538c8=
2a8e4284a34a426 100644
> --- a/tools/perf/arch/s390/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-s390.c
> @@ -1,14 +1,14 @@
>  #include <linux/kernel.h>
>  #include <elfutils/libdwfl.h>
> -#include "../../util/unwind-libdw.h"
> -#include "../../util/perf_regs.h"
> -#include "../../util/event.h"
> -#include "../../util/sample.h"
> -#include "dwarf-regs-table.h"
> -#include "perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
> +#include "util/event.h"
> +#include "util/sample.h"
> +#include "../arch/s390/include/dwarf-regs-table.h"
> +#include "../arch/s390/include/uapi/asm/perf_regs.h"
>
>
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg)
>  {
>         struct unwind_info *ui =3D arg;
>         struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> diff --git a/tools/perf/arch/x86/util/unwind-libdw.c b/tools/perf/util/un=
wind-libdw-arch/unwind-libdw-x86.c
> similarity index 87%
> rename from tools/perf/arch/x86/util/unwind-libdw.c
> rename to tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
> index 798493e887d7308cb293e29e4ba11054d0fda722..dd27545a4a68c11e3745a2470=
8066d88bc2c7209 100644
> --- a/tools/perf/arch/x86/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw-arch/unwind-libdw-x86.c
> @@ -1,11 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <elfutils/libdwfl.h>
> -#include "perf_regs.h"
> -#include "../../../util/unwind-libdw.h"
> -#include "../../../util/perf_regs.h"
> +#include "../arch/x86/include/uapi/asm/perf_regs.h"
> +#include "util/unwind-libdw.h"
> +#include "util/perf_regs.h"
>  #include "util/sample.h"
>
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg)
> +bool libdw_set_initial_registers_x86(Dwfl_Thread *thread, void *arg)
>  {
>         struct unwind_info *ui =3D arg;
>         struct regs_dump *user_regs =3D perf_sample__user_regs(ui->sample=
);
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index ae70fb56a05729b9f06a411d162eabebbf29ac52..f32694ff4ea52d4bf80a38405=
341864e7ff5e6c8 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -225,11 +225,45 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, =
Dwarf_Addr addr, Dwarf_Word *
>         return true;
>  }
>
> -static const Dwfl_Thread_Callbacks callbacks =3D {
> -       .next_thread            =3D next_thread,
> -       .memory_read            =3D memory_read,
> -       .set_initial_registers  =3D libdw__arch_set_initial_registers,
> -};
> +#define DEFINE_DWFL_THREAD_CALLBACKS(arch)                           \
> +static const Dwfl_Thread_Callbacks callbacks_##arch =3D {              \
> +       .next_thread           =3D next_thread,                        \
> +       .memory_read           =3D memory_read,                        \
> +       .set_initial_registers =3D libdw_set_initial_registers_##arch, \
> +}
> +
> +DEFINE_DWFL_THREAD_CALLBACKS(x86);
> +DEFINE_DWFL_THREAD_CALLBACKS(arm);
> +DEFINE_DWFL_THREAD_CALLBACKS(arm64);
> +DEFINE_DWFL_THREAD_CALLBACKS(csky);
> +DEFINE_DWFL_THREAD_CALLBACKS(loongarch);
> +DEFINE_DWFL_THREAD_CALLBACKS(powerpc);
> +DEFINE_DWFL_THREAD_CALLBACKS(riscv);
> +DEFINE_DWFL_THREAD_CALLBACKS(s390);
> +
> +static const Dwfl_Thread_Callbacks *get_thread_callbacks(const char *arc=
h)
> +{
> +       if (!strcmp(arch, "arm"))
> +               return &callbacks_arm;
> +       else if (!strcmp(arch, "arm64"))
> +               return &callbacks_arm64;
> +       else if (!strcmp(arch, "csky"))
> +               return &callbacks_csky;
> +       else if (!strcmp(arch, "loongarch"))
> +               return &callbacks_loongarch;
> +       else if (!strcmp(arch, "powerpc"))
> +               return &callbacks_powerpc;
> +       else if (!strcmp(arch, "riscv"))
> +               return &callbacks_riscv;
> +       else if (!strcmp(arch, "s390"))
> +               return &callbacks_s390;
> +       else if (!strcmp(arch, "x86"))
> +               return &callbacks_x86;

Not a fault of this change, but I kind of wish we used EM_ and EF_
values as "x86" is less specific than the I386 or X86_64 constants. I
think we need something like a perf_env__e_machine and
perf_env__e_flags and for now that could just reinterpret the
arch/cpuid string. Eventually we should store these values into the
perf.data file.

> +
> +       pr_err("Fail to get thread callbacks for arch %s, returns NULL\n"=
,
> +              arch);
> +       return NULL;
> +}
>
>  static int
>  frame_callback(Dwfl_Frame *state, void *arg)
> @@ -278,6 +312,7 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *a=
rg,
>         const char *arch =3D perf_env__arch(ui_buf.machine->env);
>         Dwarf_Word ip;
>         int err =3D -EINVAL, i;
> +       const Dwfl_Thread_Callbacks *callbacks;
>
>         if (!data->user_regs || !data->user_regs->regs)
>                 return -EINVAL;
> @@ -300,7 +335,11 @@ int unwind__get_entries(unwind_entry_cb_t cb, void *=
arg,
>         if (err)
>                 goto out;
>
> -       err =3D !dwfl_attach_state(ui->dwfl, EM_NONE, thread__tid(thread)=
, &callbacks, ui);
> +       callbacks =3D get_thread_callbacks(arch);
> +       if (!callbacks)
> +               goto out;
> +
> +       err =3D !dwfl_attach_state(ui->dwfl, EM_NONE, thread__tid(thread)=
, callbacks, ui);
>         if (err)
>                 goto out;
>
> diff --git a/tools/perf/util/unwind-libdw.h b/tools/perf/util/unwind-libd=
w.h
> index 8c88bc4f2304b59561ffd482469ca63ce0f531f0..574b29848cce31e6bfd93021f=
752b518cebf73b7 100644
> --- a/tools/perf/util/unwind-libdw.h
> +++ b/tools/perf/util/unwind-libdw.h
> @@ -9,7 +9,15 @@ struct machine;
>  struct perf_sample;
>  struct thread;
>
> -bool libdw__arch_set_initial_registers(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_x86(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_arm(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_arm64(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_csky(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_loongarch(Dwfl_Thread *thread, void *ar=
g);
> +bool libdw_set_initial_registers_mips(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_powerpc(Dwfl_Thread *thread, void *arg)=
;
> +bool libdw_set_initial_registers_riscv(Dwfl_Thread *thread, void *arg);
> +bool libdw_set_initial_registers_s390(Dwfl_Thread *thread, void *arg);
>
>  struct unwind_info {
>         Dwfl                    *dwfl;
>
> ---
> base-commit: cbd41c6d4c26c161a2b0e70ad411d3885ff13507
> change-id: 20260105-cross-arch-unwind-7238af40fb14
>
> Best regards,
> --
> Shimin Guo <shimin.guo@skydio.com>

Less code in arch is always going to lgtm :-)

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

