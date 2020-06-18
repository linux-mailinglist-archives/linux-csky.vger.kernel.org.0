Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7A301FFE27
	for <lists+linux-csky@lfdr.de>; Fri, 19 Jun 2020 00:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbgFRW2n (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 18 Jun 2020 18:28:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54134 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728416AbgFRW2m (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 18 Jun 2020 18:28:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592519319;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8+pq5KNQ7cig8DZxEE8yz2Racz4jPXVsBdHBmYL2X34=;
        b=DWUGqFzio+g08B96rqbYGu5tj2H2jvd7sDd/QcCGoWTZq6fVaFPtGTG/ZtZFkKEsEbEXny
        OmGObvRjU3JAKYMCpUtwCbUAY2xd4Cv842c3KvEuQeTHGQsKbSDp3pShxeuJNtglW1z1rH
        hOAoLRwh69iMwfFpzAwgB+fztkQBu3w=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-z4xMlbB8N0mKXSRyyVHwYg-1; Thu, 18 Jun 2020 18:28:38 -0400
X-MC-Unique: z4xMlbB8N0mKXSRyyVHwYg-1
Received: by mail-qt1-f200.google.com with SMTP id y5so5604854qtd.0
        for <linux-csky@vger.kernel.org>; Thu, 18 Jun 2020 15:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8+pq5KNQ7cig8DZxEE8yz2Racz4jPXVsBdHBmYL2X34=;
        b=BvVXEY0NBzkNcZx8RJYdTm5DbVZq84WqffWYOcaT1pNbPr8MHaGSbgAt4mmZgeEJvV
         TxWAnL/xq1v3sUA1gVdyCS4a6dORDaQ9rd4tPPVyLbtXMG/QpNlFh5KylJNH5RdtGZ9p
         v9E7uMnkeahItlMZ9x81bBp225svtrCSvWQNRyCAMV3MJD6N4EsfH6IkOVD5jCW0Zoyt
         mRMaA7BY2LF2kdDa0itSuHSsKutsGQFMpc8C74LvyVGVIsy1Ef3qcxmRKXhhgaQeBbKQ
         MEbdW3pxEFRBDJ/+Qi+unOiChZ0UblBVsSWHMFjFuEsfnq5XC/72pFTTuT9FhW9XJyIp
         Aizg==
X-Gm-Message-State: AOAM530Mph/8akwGX7641cSWgfLfNzG2Ta2Qu55utjc0TTmuN4iw48cU
        SIYCNOIszDHtE9b1pYminXPfhESkKCzEIoBnWDLd6TReNGWmu+zKwoUMMhfQPuK5BhhYm9rr547
        p7AA8715lPt0VpyY7S3OhHQ==
X-Received: by 2002:a0c:f78b:: with SMTP id s11mr6011562qvn.33.1592519317215;
        Thu, 18 Jun 2020 15:28:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbmu34+M16SgAS5U4xG/Drwrjpe5fqjxcuGoBXwT4tgVhl9fkHXVY+rIkocOe/GKWJxylauA==
X-Received: by 2002:a0c:f78b:: with SMTP id s11mr6011543qvn.33.1592519316979;
        Thu, 18 Jun 2020 15:28:36 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f3sm4003549qta.44.2020.06.18.15.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 15:28:36 -0700 (PDT)
Date:   Thu, 18 Jun 2020 18:28:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Guo Ren <guoren@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-csky@vger.kernel.org
Subject: Re: [PATCH 07/25] mm/csky: Use mm_fault_accounting()
Message-ID: <20200618222834.GP76766@xz-x1>
References: <20200615221607.7764-1-peterx@redhat.com>
 <20200615221607.7764-8-peterx@redhat.com>
 <CAJF2gTSVSXO=phc1eeb-ZmDMrSDjSSLd3tN6ng_8n-pCSZh5zw@mail.gmail.com>
 <20200617154925.GC76766@xz-x1>
 <CAHk-=wi=58J7d5iyFyYyHrU+pzjWB55cit_LQCkSkavpH-trsg@mail.gmail.com>
 <20200617195807.GH76766@xz-x1>
 <CAHk-=wj_V2Tps2QrMn20_W0OJF9xqNh52XSGA42s-ZJ8Y+GyKw@mail.gmail.com>
 <20200618143801.GK76766@xz-x1>
 <CAHk-=whFEZbTJZaNwEkyevUV2aqRwbeVmtp6hhk1sK2mW4vaGA@mail.gmail.com>
 <20200618212430.GO76766@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200618212430.GO76766@xz-x1>
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Thu, Jun 18, 2020 at 05:24:30PM -0400, Peter Xu wrote:
> >         /* Major fault */
> >         if ((ret & VM_FAULT_MAJOR) || (flags & FAULT_FLAG_TRIED)) {
> >                 flt = &current->maj_flt;
> >                 event_type = PERF_COUNT_SW_PAGE_FAULTS_MAJ;
> >         } else {
> >                 flt = &current->min_flt;
> >                 event_type = PERF_COUNT_SW_PAGE_FAULTS_MIN;
> >         }
> >         *flt++;
> >         if (regs)
> >                 perf_sw_event(event_type, 1, regs, address);

Sadly, this line seems to fail the compilation:

  CC      mm/memory.o
In file included from ././include/linux/compiler_types.h:68,
                 from <command-line>:                      
./arch/x86/include/asm/jump_label.h: In function ‘handle_mm_fault’:
./include/linux/compiler-gcc.h:120:38: warning: ‘asm’ operand 0 probably does not match constraints
  120 | #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
      |                                      ^~~
./arch/x86/include/asm/jump_label.h:25:2: note: in expansion of macro ‘asm_volatile_goto’
   25 |  asm_volatile_goto("1:" 
      |  ^~~~~~~~~~~~~~~~~
./include/linux/compiler-gcc.h:120:38: error: impossible constraint in ‘asm’
  120 | #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
      |                                      ^~~            
./arch/x86/include/asm/jump_label.h:25:2: note: in expansion of macro ‘asm_volatile_goto’
   25 |  asm_volatile_goto("1:"                                                                                                
      |  ^~~~~~~~~~~~~~~~~
make[1]: *** [scripts/Makefile.build:267: mm/memory.o] Error 1
make: *** [Makefile:1729: mm] Error 2

Frankly speaking I have no solid understanding on what's the error about... But
my gut feeling is that it's about the static keys, where perf_sw_event() may
only support static event types (otherwise we won't be able to know whether to
patch the instruction with no-op or a jump?).

I'll go back to the simple version for now, until I know a solution..

Thanks,

-- 
Peter Xu

