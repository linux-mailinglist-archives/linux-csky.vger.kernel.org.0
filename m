Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A505207B4
	for <lists+linux-csky@lfdr.de>; Tue, 10 May 2022 00:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiEIWgX (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Mon, 9 May 2022 18:36:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiEIWgW (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Mon, 9 May 2022 18:36:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03F42B9C93
        for <linux-csky@vger.kernel.org>; Mon,  9 May 2022 15:32:27 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id bo5so13420364pfb.4
        for <linux-csky@vger.kernel.org>; Mon, 09 May 2022 15:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=pWbw2Mwy88SDSkfpA4D7g/Rmsq9eS9lL/9r9k9KvO7g=;
        b=aKb0kPhWVd5eMpmlkl9NknitMxg8gh5oazT3otM1H7wNssSLITeEgVYd3fLrFpqhAN
         6lW7y7N8edPrk+YAtulN/xaP8NiOVNXKZAi6KA0NNveYzfnxDp9ggPIafs2mYWMuEWpF
         yisEk6Vl9il9YEGMryMzMjf2wBlPJtypJNMiXj/O7kxrK4628fYPSch836eJYFLJD5Wl
         OrKTh30iRJgEMKA4TvqbYiX+DIHWjjGEmbm+VHeiIrDIZkzUjvIVMUmJT2O64m4s1rq4
         s75jC01yaX0ljYX5/96b4XICWLQpDnMGWrtzgp0A1FvhK7kRpUekOBDbUefjzvvkL2IY
         V5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=pWbw2Mwy88SDSkfpA4D7g/Rmsq9eS9lL/9r9k9KvO7g=;
        b=6uXAg8kq+MV5aQk2qVEQ5HmM4GiFrIntC4bxcwThD2D7lokBzpuH3f+9NZc8lhVKo+
         9xdbZ9HnHk52aj7YRUVf4PEVOG3M8qDPLw9ELU9iHvqpUvgl4WlPo9df5Mf1Q85F8hDM
         sIrlU3yqfyptmHaC/xvdAcAzKJPfyi/fUytSHPxOEV+r/Qb7ZwoP4iYwoa9SaXv/y12U
         tcAwfzUeV6lSpIwrwu+F12oQJKV3OzKe5LSrMj42TTE8n6KTY00xtF214HzQjGR/U6Za
         bqFZP5grdQPUACVYSfsDacyZdj5QZ1uCOz7rRp9mcDOXyN9Boq6livlmFzfIIV1EK7jI
         bYHg==
X-Gm-Message-State: AOAM531IU3eXJJ+chV4cPU2Z851sET4bi4sTe/s/IEs5MYmvkamZgon7
        gJIVG5YZN7Er5rHz92D9uI8JGw==
X-Google-Smtp-Source: ABdhPJxUc/qGM9x1mbDewFdh0f2iSebcv/MH281VDWnsTPJAYa63hm5brMdaLkqzPiol6IuhZdvYkA==
X-Received: by 2002:a05:6a02:10d:b0:381:f4c8:ad26 with SMTP id bg13-20020a056a02010d00b00381f4c8ad26mr14585787pgb.135.1652135546996;
        Mon, 09 May 2022 15:32:26 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id w19-20020a1709029a9300b0015e8d4eb1ddsm407885plp.39.2022.05.09.15.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 15:32:26 -0700 (PDT)
Subject: [PATCH v5 3/7] asm-generic: qrwlock: Document the spinlock fairness requirements
Date:   Mon,  9 May 2022 15:29:52 -0700
Message-Id: <20220509222956.2886-4-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220509222956.2886-1-palmer@rivosinc.com>
References: <20220509222956.2886-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     guoren@kernel.org, peterz@infradead.org, mingo@redhat.com,
        Will Deacon <will@kernel.org>, longman@redhat.com,
        boqun.feng@gmail.com, jonas@southpole.se,
        stefan.kristiansson@saunalahti.fi, shorne@gmail.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        Arnd Bergmann <arnd@arndb.de>, macro@orcam.me.uk,
        Greg KH <gregkh@linuxfoundation.org>,
        sudipm.mukherjee@gmail.com, jszhang@kernel.org,
        linux-csky@vger.kernel.org, linux-kernel@vger.kernel.org,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

I could only find the fairness requirements documented as the C code,
this calls them out in a comment just to be a bit more explicit.

Reviewed-by: Arnd Bergmann <arnd@arndb.de
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 include/asm-generic/qrwlock.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/asm-generic/qrwlock.h b/include/asm-generic/qrwlock.h
index 7ae0ece07b4e..24ae09c1db9f 100644
--- a/include/asm-generic/qrwlock.h
+++ b/include/asm-generic/qrwlock.h
@@ -2,6 +2,10 @@
 /*
  * Queue read/write lock
  *
+ * These use generic atomic and locking routines, but depend on a fair spinlock
+ * implementation in order to be fair themselves.  The implementation in
+ * asm-generic/spinlock.h meets these requirements.
+ *
  * (C) Copyright 2013-2014 Hewlett-Packard Development Company, L.P.
  *
  * Authors: Waiman Long <waiman.long@hp.com>
-- 
2.34.1

