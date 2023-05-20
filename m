Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BDA70A4BF
	for <lists+linux-csky@lfdr.de>; Sat, 20 May 2023 04:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjETC41 (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 19 May 2023 22:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjETC4X (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 19 May 2023 22:56:23 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34518E50
        for <linux-csky@vger.kernel.org>; Fri, 19 May 2023 19:56:12 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5341737d7aeso3524588a12.2
        for <linux-csky@vger.kernel.org>; Fri, 19 May 2023 19:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684551371; x=1687143371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=recTry7bFKm4wzLhlG9hQCZazqye+5oXd/1+UMeTYjY=;
        b=sD8iZAJjSSBUahh7dJQAISY6FjE9iqiYw5EYMplq4IMpAbKP1XRpx6/GpPEwJDdLFT
         yv9R+L4aKYuUVMYffC6/Irn+s06hfoSfxFJN6v5YRWjF+xEWGXo5Scfqdoed8jbKVcTB
         PAK4Yoh/X1XJ1Ihsy6gYYlH+bIsDR/SCv0OEyOMr5kSsl+M7OzRhYcDy002+NUhR6y+s
         OWQR1V1BZgOtUpK8aDycvFFJkUfU09ulKCQqZ1CnMxtG2ZJ7r2EhWXN5uiG0hDjpB/XT
         4tmqG8MgF/kV/PZI8lEX/ds7gSzQJgovc5UH+QlPcpRS5NUR+0p7gNqwsffCNSks3CKW
         mPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684551371; x=1687143371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=recTry7bFKm4wzLhlG9hQCZazqye+5oXd/1+UMeTYjY=;
        b=GGvRtHlz7VGdXbXZHd1UKqel+0eOVjh3gJgZH4oMyQja8FZ8fFgh1TTCfyaENwcf2h
         OHJF2F0wAkjbbgu2iHn9tVEVUjsf7JCyDm0VcgnSOVWfBMuqrEQPkvtjRTkMpBF6YnJv
         zurCoVrxXEPRxRsbZ2CexPj0mRBmmKzTqBbEPRD0Ystd5xfxhtD4OVIJy6Reo6nn08HK
         3sTbxwh7Ktx/rYNMUAeJuyjRwEQC3TiUdCaEacs3qtmD3g80jo/Z38NRngFaPKg9zaVI
         3ql1tS3gApLnrxpkjt3di1gpqCk4BcLOIjpNfyBls2H99x2pDe/0ACfeOpUe4UBeKT2I
         lu7g==
X-Gm-Message-State: AC+VfDyS6sp8DPJ84yGvPpHpEDwS9r3/p09Di+EU5IXYRK4Uzd5xjfqq
        PnMwCKoUkQViLj4GomtU88oC3Q==
X-Google-Smtp-Source: ACHHUZ7qxcjc3CZcoBE1hsRJjLPpLwYgASAN3M4aNC/9blApuhqFcYiFRj7ZoRAsQUe6kxz1kOZ+PA==
X-Received: by 2002:a17:902:c412:b0:1ae:4:da97 with SMTP id k18-20020a170902c41200b001ae0004da97mr5440280plk.4.1684551371580;
        Fri, 19 May 2023 19:56:11 -0700 (PDT)
Received: from leoy-yangtze.lan ([156.59.236.113])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902d50600b001a95aef9728sm346100plg.19.2023.05.19.19.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 19:56:11 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
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
        Ian Rogers <irogers@google.com>,
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
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 3/5] perf parse-regs: Remove unused macros PERF_REG_{IP|SP}
Date:   Sat, 20 May 2023 10:55:35 +0800
Message-Id: <20230520025537.1811986-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520025537.1811986-1-leo.yan@linaro.org>
References: <20230520025537.1811986-1-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

The macros PERF_REG_{IP|SP} have been replaced by arch__reg_{ip|sp}()
respectively, remove them!

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/arch/arm/include/perf_regs.h     | 3 ---
 tools/perf/arch/arm64/include/perf_regs.h   | 3 ---
 tools/perf/arch/csky/include/perf_regs.h    | 3 ---
 tools/perf/arch/mips/include/perf_regs.h    | 2 --
 tools/perf/arch/powerpc/include/perf_regs.h | 3 ---
 tools/perf/arch/riscv/include/perf_regs.h   | 3 ---
 tools/perf/arch/s390/include/perf_regs.h    | 3 ---
 tools/perf/arch/x86/include/perf_regs.h     | 2 --
 8 files changed, 22 deletions(-)

diff --git a/tools/perf/arch/arm/include/perf_regs.h b/tools/perf/arch/arm/include/perf_regs.h
index 99a06550e25d..75ce1c370114 100644
--- a/tools/perf/arch/arm/include/perf_regs.h
+++ b/tools/perf/arch/arm/include/perf_regs.h
@@ -12,7 +12,4 @@ void perf_regs_load(u64 *regs);
 #define PERF_REGS_MAX	PERF_REG_ARM_MAX
 #define PERF_SAMPLE_REGS_ABI	PERF_SAMPLE_REGS_ABI_32
 
-#define PERF_REG_IP	PERF_REG_ARM_PC
-#define PERF_REG_SP	PERF_REG_ARM_SP
-
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/arm64/include/perf_regs.h b/tools/perf/arch/arm64/include/perf_regs.h
index 35a3cc775b39..58639ee9f7ea 100644
--- a/tools/perf/arch/arm64/include/perf_regs.h
+++ b/tools/perf/arch/arm64/include/perf_regs.h
@@ -14,7 +14,4 @@ void perf_regs_load(u64 *regs);
 #define PERF_REGS_MAX	PERF_REG_ARM64_MAX
 #define PERF_SAMPLE_REGS_ABI	PERF_SAMPLE_REGS_ABI_64
 
-#define PERF_REG_IP	PERF_REG_ARM64_PC
-#define PERF_REG_SP	PERF_REG_ARM64_SP
-
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/csky/include/perf_regs.h b/tools/perf/arch/csky/include/perf_regs.h
index 1afcc0e916c2..076c7746c8a2 100644
--- a/tools/perf/arch/csky/include/perf_regs.h
+++ b/tools/perf/arch/csky/include/perf_regs.h
@@ -12,7 +12,4 @@
 #define PERF_REGS_MAX	PERF_REG_CSKY_MAX
 #define PERF_SAMPLE_REGS_ABI	PERF_SAMPLE_REGS_ABI_32
 
-#define PERF_REG_IP	PERF_REG_CSKY_PC
-#define PERF_REG_SP	PERF_REG_CSKY_SP
-
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/mips/include/perf_regs.h b/tools/perf/arch/mips/include/perf_regs.h
index b8cd8bbb37ba..7082e91e0ed1 100644
--- a/tools/perf/arch/mips/include/perf_regs.h
+++ b/tools/perf/arch/mips/include/perf_regs.h
@@ -7,8 +7,6 @@
 #include <asm/perf_regs.h>
 
 #define PERF_REGS_MAX PERF_REG_MIPS_MAX
-#define PERF_REG_IP PERF_REG_MIPS_PC
-#define PERF_REG_SP PERF_REG_MIPS_R29
 
 #define PERF_REGS_MASK ((1ULL << PERF_REG_MIPS_MAX) - 1)
 
diff --git a/tools/perf/arch/powerpc/include/perf_regs.h b/tools/perf/arch/powerpc/include/perf_regs.h
index 9bb17c3f370b..1c66f6ba6773 100644
--- a/tools/perf/arch/powerpc/include/perf_regs.h
+++ b/tools/perf/arch/powerpc/include/perf_regs.h
@@ -16,7 +16,4 @@ void perf_regs_load(u64 *regs);
 	#define PERF_SAMPLE_REGS_ABI	PERF_SAMPLE_REGS_ABI_32
 #endif
 
-#define PERF_REG_IP     PERF_REG_POWERPC_NIP
-#define PERF_REG_SP     PERF_REG_POWERPC_R1
-
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/riscv/include/perf_regs.h b/tools/perf/arch/riscv/include/perf_regs.h
index 6944bf0de53e..d482edb413e5 100644
--- a/tools/perf/arch/riscv/include/perf_regs.h
+++ b/tools/perf/arch/riscv/include/perf_regs.h
@@ -16,7 +16,4 @@
 #define PERF_SAMPLE_REGS_ABI	PERF_SAMPLE_REGS_ABI_32
 #endif
 
-#define PERF_REG_IP	PERF_REG_RISCV_PC
-#define PERF_REG_SP	PERF_REG_RISCV_SP
-
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/s390/include/perf_regs.h b/tools/perf/arch/s390/include/perf_regs.h
index 52fcc0891da6..130dfad2b96a 100644
--- a/tools/perf/arch/s390/include/perf_regs.h
+++ b/tools/perf/arch/s390/include/perf_regs.h
@@ -11,7 +11,4 @@ void perf_regs_load(u64 *regs);
 #define PERF_REGS_MAX PERF_REG_S390_MAX
 #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_64
 
-#define PERF_REG_IP PERF_REG_S390_PC
-#define PERF_REG_SP PERF_REG_S390_R15
-
 #endif /* ARCH_PERF_REGS_H */
diff --git a/tools/perf/arch/x86/include/perf_regs.h b/tools/perf/arch/x86/include/perf_regs.h
index 16e23b722042..f209ce2c1dd9 100644
--- a/tools/perf/arch/x86/include/perf_regs.h
+++ b/tools/perf/arch/x86/include/perf_regs.h
@@ -20,7 +20,5 @@ void perf_regs_load(u64 *regs);
 #define PERF_REGS_MASK (((1ULL << PERF_REG_X86_64_MAX) - 1) & ~REG_NOSUPPORT)
 #define PERF_SAMPLE_REGS_ABI PERF_SAMPLE_REGS_ABI_64
 #endif
-#define PERF_REG_IP PERF_REG_X86_IP
-#define PERF_REG_SP PERF_REG_X86_SP
 
 #endif /* ARCH_PERF_REGS_H */
-- 
2.39.2

