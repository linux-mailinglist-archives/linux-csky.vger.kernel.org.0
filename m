Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 262F42A8D1D
	for <lists+linux-csky@lfdr.de>; Fri,  6 Nov 2020 03:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgKFCqQ (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Thu, 5 Nov 2020 21:46:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgKFCqQ (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Thu, 5 Nov 2020 21:46:16 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6079C0613CF
        for <linux-csky@vger.kernel.org>; Thu,  5 Nov 2020 18:46:14 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id g12so2803737pgm.8
        for <linux-csky@vger.kernel.org>; Thu, 05 Nov 2020 18:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d/BRJD/KDMrwiKnkef4fD3+5wFXs6srhLr5J1DR5iBc=;
        b=N+mqYIXEZa7JVpPA/Kard288U5IivNHMi1+LX6CDSFrRM4prWt/JeIBI3xzjsZBp4q
         dtUk4JVtnevKt2aCZnmzAm8jOJLV64jGTMgJrFWPnJrxhCax5rYif4e88Ow0h3+L06+j
         E1PhHVA8QHFdf4vUSc2jPMDRJDIhlhUE7AZJZ+BQv1QlabSU7rymG9nk8ed/hV7pQpu+
         wkAGnUsbcLlC7+gyrmiVAm1OsZfMRnIdfWFn8JyMXvu85CQ94MOuB/J1zLZaA5bli9K2
         e4wckFJOvwXjWs2drPR1AM1FX1b3BFQE6fkIeyCEQtbDHI0Sf0Wk4YqlyIow54xRuIBv
         YosQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d/BRJD/KDMrwiKnkef4fD3+5wFXs6srhLr5J1DR5iBc=;
        b=aYEOh8Q7ikVI4XBeYF2THxM2z35lb+o3b1S6Ajy/uqkeRpLqldFA3f3p6c3/BJRfN7
         g0gulupQ4xB1YTLmeez1v7u8IinSp5PjhOuoZs0LLU64OzQPizu2CAHZOZIbDq4viEZl
         hE5lIH1n1vX3gLUi1g5DvGXDbEy7dyuyPz59LvGWV8DQxrQw8jc67VfceiuWsWiAdsjN
         mrFr+j4whLBrkn3tqeX4d/XWgBs31d0/jincn5C+NTGgIA4+MYcrpZ78rsF6RnhnPfrY
         hAyk324uNQX5k0oA72f9vAmASjTbCfuUpQ8M1pP/1i2qmQqhcJ/AndT/bO6jgwlN+pXS
         ra7A==
X-Gm-Message-State: AOAM530lId1Q1tcyKQjkxaeXmjWncK5Nov8zVNKNbpT7MFXXuAYCZuXl
        8tg4USXbkX7clxYfUODUiYTqbPgGLhg0yA==
X-Google-Smtp-Source: ABdhPJwnlOqBjPcak6hc/gPGoVpAW4ta1eAcsvx2LmGA1V/BxJY6von81tK9o9B1ht31hDAvDxDJfQ==
X-Received: by 2002:a63:c90b:: with SMTP id o11mr5325399pgg.453.1604630774233;
        Thu, 05 Nov 2020 18:46:14 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id l22sm4079015pff.27.2020.11.05.18.46.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 18:46:13 -0800 (PST)
Subject: Re: [PATCH] csky: add support for TIF_NOTIFY_SIGNAL
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-csky@vger.kernel.org
References: <4f498dfd-00eb-3f15-4529-672264fdab0f@kernel.dk>
 <19e5bad9-2421-0f40-446f-23479b365477@kernel.dk>
 <CAJF2gTT=xm7vrEdw_je8vfHgkHk5t07htNJX+59tGKbb-co2vg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b23283b3-1f8e-6526-19c5-68f353327c95@kernel.dk>
Date:   Thu, 5 Nov 2020 19:46:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJF2gTT=xm7vrEdw_je8vfHgkHk5t07htNJX+59tGKbb-co2vg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On 11/5/20 6:50 PM, Guo Ren wrote:
> I haven't tested the whole patchset of notify_signal, but the wire-up
> code is ok for me.
> 
> Acked-by: Guo Ren <guoren@kernel.org>

Great thanks, added.

-- 
Jens Axboe

