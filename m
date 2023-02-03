Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4E5689BA0
	for <lists+linux-csky@lfdr.de>; Fri,  3 Feb 2023 15:31:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbjBCObG (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 3 Feb 2023 09:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjBCObE (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 3 Feb 2023 09:31:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE956D5E1
        for <linux-csky@vger.kernel.org>; Fri,  3 Feb 2023 06:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675434618;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FGqA/t5BHooNtKKmgY/P/RvUeTIDhJpfv4X01I3UuzM=;
        b=P8qzXveJOOKidGroGDRSjJif7Ju7vo86XrAFwhoVMgmLeJZ4pDxyVrH7oMrR2TRofK/YYY
        7qZf5SgymR7l3UHX48wuoFjsJhI+FkJKOnjeOOUtT5ecnQfpvYbYyZJ5pQb22kKEgOPZ7L
        j2ZtkNwN2jk0CEA8r0TACMnlZZu8RPs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-489-WII6RuwGOPGaKJkPikUq9w-1; Fri, 03 Feb 2023 09:30:17 -0500
X-MC-Unique: WII6RuwGOPGaKJkPikUq9w-1
Received: by mail-wm1-f70.google.com with SMTP id n7-20020a05600c3b8700b003dc55dcb298so2693392wms.8
        for <linux-csky@vger.kernel.org>; Fri, 03 Feb 2023 06:30:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FGqA/t5BHooNtKKmgY/P/RvUeTIDhJpfv4X01I3UuzM=;
        b=E9yrngL3UG14vjo8CENFLC/0IzhjSEvLl6LH8Tb/o50uKjtmz4xjANz2MprtUhSo8F
         YnrE1utMZNMthOoTB5fRCkC3g3RYaZbxIeeZHhaPhswgB2yTzuNYVRlUBM6d6L2lgydc
         3AUAhFVne0nnWxF8hobqu4wuzn2uJBqbIKsoz/xL8HPSit4pO4ryl0hZNFfhDM6dE4+d
         Z7Ol/0b7dB3W92vzFvP4LOEr3UBrlPv4ClxhhshVvIysOLJsNPwIkT2XkSZSWgzHRL5B
         DMXLBWf0MynM7zlsxL9/XKgjswIvVzMf7CY4BgdWdueN9Kcv0po50fdlIPSbIFgLPIi9
         KtWg==
X-Gm-Message-State: AO0yUKVv8A4VmMIIUzbpg2V0i/Yr66Wb0BLv8SRm05HJscYdRDsehJgb
        iOPAiCrQwRuzSI1WArT2RGd/VvG3JObLiC0WM18CJbpb94KH+vSkjo1oCxq3XNLyJAGWmPp1nP3
        kgaUBgwHiwxCHMjI2GOV4bw==
X-Received: by 2002:a05:600c:3588:b0:3df:e1e9:200e with SMTP id p8-20020a05600c358800b003dfe1e9200emr4472895wmq.39.1675434616186;
        Fri, 03 Feb 2023 06:30:16 -0800 (PST)
X-Google-Smtp-Source: AK7set+3Fxk3nALXFhpoXy/lSyMSFcdmxLuZvgb86YYfx4M4JIQvKCJs/tKTkc3VpDPsDt8toFavpA==
X-Received: by 2002:a05:600c:3588:b0:3df:e1e9:200e with SMTP id p8-20020a05600c358800b003dfe1e9200emr4472869wmq.39.1675434615896;
        Fri, 03 Feb 2023 06:30:15 -0800 (PST)
Received: from [192.168.3.108] (p5b0c6376.dip0.t-ipconnect.de. [91.12.99.118])
        by smtp.gmail.com with ESMTPSA id h27-20020a05600c2cbb00b003db12112fcfsm3203111wmc.4.2023.02.03.06.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Feb 2023 06:30:15 -0800 (PST)
Message-ID: <569308c6-558b-de6e-1e98-2f50c1c56755@redhat.com>
Date:   Fri, 3 Feb 2023 15:30:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 1/4] arm: include asm-generic/memory_model.h from
 page.h rather than memory.h
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rich Felker <dalias@libc.org>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vineet Gupta <vgupta@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        x86@kernel.org
References: <20230129124235.209895-1-rppt@kernel.org>
 <20230129124235.209895-2-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230129124235.209895-2-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 29.01.23 13:42, Mike Rapoport wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> 
> Makes it consistent with other architectures and allows for generic
> definition of pfn_valid() in asm-generic/memory_model.h with clear override
> in arch/arm/include/asm/page.h
> 
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

