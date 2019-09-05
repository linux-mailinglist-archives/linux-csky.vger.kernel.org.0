Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C077A9C5C
	for <lists+linux-csky@lfdr.de>; Thu,  5 Sep 2019 09:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731609AbfIEHza (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 5 Sep 2019 03:55:30 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33311 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731390AbfIEHza (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 5 Sep 2019 03:55:30 -0400
Received: by mail-io1-f68.google.com with SMTP id m11so2744794ioo.0
        for <linux-csky@vger.kernel.org>; Thu, 05 Sep 2019 00:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=C5c7K1Hw4FjCF2xV5vuGtI/cNoltJZ5oqSBi17hs6i0=;
        b=I2t+igV+hg/20Cs7tSHvQRhOdgxcKrBFnKFMkbgfAOGGLKQ5rD53Fyq8x08c4hM38u
         rQujPpaXuKkVSUOHjfVYjTCq8fMWUZMAxXQfjZ3g6Mpk2o38aAJEKPYW0v9nO4B8WITq
         ki+UPop151pYxHkpNWOg3HyrlfnXCyZ/41la7iMsOo3512dJvfjfLGEHw339fTc2xZ9J
         CLssR4wQHnqV4w26NYHbPTFZ2s2NShfg+5RHYHYKXAug6EZtEtTPSMb1JYElI+BptV2J
         wKT9lhhK0YFtImBGIKPryVgP7cdfdGw5hDLJuYGJvbzjKjXN95cjimp4Cndqiv7HYVMa
         O/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=C5c7K1Hw4FjCF2xV5vuGtI/cNoltJZ5oqSBi17hs6i0=;
        b=Zx+zFIsfu8rMZ4yTM5MXOeJejl4X3ZIxMIS+e2IVgZZaFS4gJBOFJe1o/jzpnZ6JLL
         EN7NQuF2+RogmYEU2LAZ9gMWejsKeLAGJ96F4EgvgYWYI2dqRZWuW9mIvpl4FMmMA71f
         1ePwKRSvYLTqckwhyNU+KmkfD8fAGDVyu0aM8kztSSodLQG0Sbw7rkhcEaC+CLZoCrr8
         Zzr06pWAROcFj1W5ff2uICIwa5oUaTmT0bkeuOZA5OgJPwOp+1aKsu/arXKSMhY49xsG
         YNaKjhw8eNQGdBSOWQqKe9uThjDq8YkvqhF7zfnBffZcSAswgZtd1hKXuIOdv8CDc6xi
         Trdw==
X-Gm-Message-State: APjAAAXVWPlJSC2Bu8h5x61YZTrkpT3IWP7ZFGzgl6qYJFg7cvBcpclP
        RCH5GS5E+NjvO8dDLo4yac7/hg==
X-Google-Smtp-Source: APXvYqyFpbub+uXlwt/4a1kSj0KNHkUibFYHOqfSUlNcIlDIps2KWkPgcOc3xfU2wvTsHUeYG7GTrQ==
X-Received: by 2002:a6b:f806:: with SMTP id o6mr271583ioh.213.1567670129077;
        Thu, 05 Sep 2019 00:55:29 -0700 (PDT)
Received: from localhost ([2601:8c4:0:9294:cb6f:4cf:b239:2fee])
        by smtp.gmail.com with ESMTPSA id z20sm1319236iof.38.2019.09.05.00.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2019 00:55:28 -0700 (PDT)
Date:   Thu, 5 Sep 2019 00:55:26 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Mao Han <han_mao@c-sky.com>
cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, Greentime Hu <green.hu@gmail.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH V7 2/2] riscv: Add support for libdw
In-Reply-To: <e30754638a4eabce6f26ecca9d5292cc7dfa2633.1567653632.git.han_mao@c-sky.com>
Message-ID: <alpine.DEB.2.21.9999.1909050054170.27305@viisi.sifive.com>
References: <cover.1567653632.git.han_mao@c-sky.com> <e30754638a4eabce6f26ecca9d5292cc7dfa2633.1567653632.git.han_mao@c-sky.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Thu, 5 Sep 2019, Mao Han wrote:

> This patch adds support for DWARF register mappings and libdw registers
> initialization, which is used by perf callchain analyzing when
> --call-graph=dwarf is given.
> 
> Signed-off-by: Mao Han <han_mao@c-sky.com>
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Greentime Hu <green.hu@gmail.com>
> Cc: Palmer Dabbelt <palmer@sifive.com>
> Cc: linux-riscv <linux-riscv@lists.infradead.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Guo Ren <guoren@kernel.org>

Thanks, queued for v5.4-rc1 with Greentime's Tested-by: (since the changes 
from v6 to v7 had no functional impact).


- Paul
