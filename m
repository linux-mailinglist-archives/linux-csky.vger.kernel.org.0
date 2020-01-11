Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 501A5137AEA
	for <lists+linux-csky@lfdr.de>; Sat, 11 Jan 2020 02:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgAKBax (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 10 Jan 2020 20:30:53 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33668 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727992AbgAKBax (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 10 Jan 2020 20:30:53 -0500
Received: by mail-il1-f193.google.com with SMTP id v15so3318270iln.0
        for <linux-csky@vger.kernel.org>; Fri, 10 Jan 2020 17:30:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=kJ7xbVxtwPEzAF+se04VqwxgQEGFSkrxN6PInKK4g18=;
        b=f+zFDYAN4/EL5Kpz1xl4MZTusWwAsEndfJyrqc2rm3YlZrxBq0iogepFL9jtdkhT3H
         eUQjXMJZ9S+EIqgikcqaaUTCiBnnugQWTdOVIh7rDgqm6pN0WsQG+mK53NKTRM//tAsN
         m9ThcF11//B/phL21f0wbDiy6lCVvVnVZoNFs8gpnmZ3xkt50+y4FpJQC274DZVE3hZC
         asWW1b9jDpvGYJNYaNuQhtK2rTBZwwMbiQA30e2jSLFB674Df4jESm1P9EOSjEi3NIRW
         06HJO44VYuMkMx6Jls3cNOT1sa9LFbmlqxdjkxu93wKA0Ep2A10FEfZhv87B3NRnbvvh
         7tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=kJ7xbVxtwPEzAF+se04VqwxgQEGFSkrxN6PInKK4g18=;
        b=B5cRbqWW6Cnkoe5hfLDmFRPJdvYOROX+lsM95J7sqiAAm4iOyNpI3BejBUXNwMjAWg
         aYGfprsfsS2b+7En13mhl1jXb9UIyoGxSDsKG/8GAhC/4FyD6zE7UpUO4GwlhFyEk7Y5
         8kkk67yGWnk11kb72fzUT8WEaYf5I5kGPYBqzkubudRz6Bi60xTitqwm4uMhEXy+Y9EV
         uVdaoWTY1sqqLA43Jthh0y5mUkaLwV+IDO4qMUILVAhZxUxwgjKlAGnu23ZxpKD+lKVa
         Gm2G0z/EI2S6HbdXtaADkBnQd+XLrPxJ2UYFaHbrYkT/eASONe0ssNh9RejTRrgchcdi
         eMFw==
X-Gm-Message-State: APjAAAUnrLZKfmSbHCowAZBdXMJFH0HtXCu/+Oxd7mr6yu6+ny/hOl+N
        CMHt8FHgXLsyKj83yX5zUH3VWQ==
X-Google-Smtp-Source: APXvYqzWFX4H4Nqk0plSxJ+POvbf5RF+Ea/qNv/kluRjeJOkrIPJKvY1jK5CswtigjH1VedncaXqyA==
X-Received: by 2002:a92:b11:: with SMTP id b17mr5323857ilf.202.1578706252651;
        Fri, 10 Jan 2020 17:30:52 -0800 (PST)
Received: from localhost ([64.62.168.194])
        by smtp.gmail.com with ESMTPSA id z15sm1224781ill.20.2020.01.10.17.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 17:30:52 -0800 (PST)
Date:   Fri, 10 Jan 2020 17:30:45 -0800 (PST)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     guoren@kernel.org
cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu, Anup.Patel@wdc.com,
        vincent.chen@sifive.com, zong.li@sifive.com,
        greentime.hu@sifive.com, bmeng.cn@gmail.com, atish.patra@wdc.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        arnd@arndb.de, linux-csky@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <ren_guo@c-sky.com>
Subject: Re: [PATCH 1/2] riscv: Fixup obvious bug for fp-regs reset
In-Reply-To: <20200105025215.2522-1-guoren@kernel.org>
Message-ID: <alpine.DEB.2.21.9999.2001101730140.38813@viisi.sifive.com>
References: <20200105025215.2522-1-guoren@kernel.org>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Sun, 5 Jan 2020, guoren@kernel.org wrote:

> From: Guo Ren <ren_guo@c-sky.com>
> 
> CSR_MISA is defined in Privileged Architectures' spec: 3.1.1 Machine
> ISA Register misa. Every bit:1 indicate a feature, so we should beqz
> reset_done when there is no F/D bit in csr_msia register.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

Thanks Guo Ren, queued for v5.5-rc.


- Paul
