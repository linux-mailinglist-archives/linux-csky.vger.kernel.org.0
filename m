Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49EE8480BC0
	for <lists+linux-csky@lfdr.de>; Tue, 28 Dec 2021 18:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbhL1RDg (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 28 Dec 2021 12:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236120AbhL1RDg (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 28 Dec 2021 12:03:36 -0500
X-Greylist: delayed 420 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Dec 2021 09:03:35 PST
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B536CC061574;
        Tue, 28 Dec 2021 09:03:35 -0800 (PST)
Received: from [81.101.6.87] (port=39590 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1n2FlV-0004u6-5t; Tue, 28 Dec 2021 16:55:57 +0000
Date:   Tue, 28 Dec 2021 17:01:25 +0000
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-csky@vger.kernel.org, linux-iio@vger.kernel.org,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [RFC 12/32] iio: adc: Kconfig: add HAS_IOPORT dependencies
Message-ID: <20211228170031.12dac755@jic23-huawei>
In-Reply-To: <b21410ee32857b4913e4ba4595f9e8da299c501f.camel@linux.ibm.com>
References: <20211227164317.4146918-1-schnelle@linux.ibm.com>
        <20211227164317.4146918-13-schnelle@linux.ibm.com>
        <CAMuHMdXDL6XXfohzJFTTV6tR=gg=bcCQq935eKUbNaNLHp9xiw@mail.gmail.com>
        <b21410ee32857b4913e4ba4595f9e8da299c501f.camel@linux.ibm.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

On Tue, 28 Dec 2021 13:50:20 +0100
Niklas Schnelle <schnelle@linux.ibm.com> wrote:

> On Tue, 2021-12-28 at 11:32 +0100, Geert Uytterhoeven wrote:
> > Hi Niklas,
> > 
> > On Mon, Dec 27, 2021 at 5:53 PM Niklas Schnelle <schnelle@linux.ibm.com> wrote:  
> > > In a future patch HAS_IOPORT=n will result in inb()/outb() and friends
> > > not being declared. We thus need to add HAS_IOPORT as dependency for
> > > those drivers using them.
> > > 
> > > Co-developed-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Arnd Bergmann <arnd@kernel.org>
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>  

As a side note, whilst it doesn't always happen and I regularly forget
to fix it up whilst applying, it's really helpful to make sure the driver
name is somewhere in the patch title.

e.g. iio: adc: ad7606: add HAS_IOPORT dependencies.

> > 
> > Thanks for your patch!
> >   
> > > --- a/drivers/iio/adc/Kconfig
> > > +++ b/drivers/iio/adc/Kconfig
> > > @@ -119,7 +119,7 @@ config AD7606
> > > 
> > >  config AD7606_IFACE_PARALLEL
> > >         tristate "Analog Devices AD7606 ADC driver with parallel interface support"
> > > -       depends on HAS_IOMEM
> > > +       depends on HAS_IOPORT  
> > 
> > While this driver uses ins[bw](), this seems unrelated to legacy
> > I/O space, as the driver maps a MMIO region.  Probably different
> > accessors should be used instead.  
> 
> You're right on first glance it looks like a misuse of the ins[bw]()
> accessors. I do wonder how that even works, if PCI_IOBASE is 0 it would
> result in readsw()/readsb() with presumably the correct address but no
> idea how this interacts witth x86's special I/O instructions.
> 
> > 
> > Note that this driver has no in-tree users. Same for the SPI variant,
> > but at least that one has modern json-schema DT bindings ;-)  
> 
> Can't find any mention in the MAINTAINERS file either.

It falls under the Analog devices catch all.
We don't list them all individually because there are a lot of them and
it would just be noise in many case.

Added Michael to CC. You already have Lars.

ANALOG DEVICES INC IIO DRIVERS
M:	Lars-Peter Clausen <lars@metafoo.de>
M:	Michael Hennerich <Michael.Hennerich@analog.com>
S:	Supported
W:	http://wiki.analog.com/
W:	http://ez.analog.com/community/linux-device-drivers
F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9523
F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4350
F:	Documentation/devicetree/bindings/iio/*/adi,*
F:	Documentation/devicetree/bindings/iio/dac/adi,ad5758.yaml
F:	drivers/iio/*/ad*
F:	drivers/iio/adc/ltc249*
F:	drivers/iio/amplifiers/hmc425a.c
F:	drivers/staging/iio/*/ad*
X:	drivers/iio/*/adjd*

https://wiki.analog.com/resources/tools-software/linux-drivers/iio-adc/ad7606
includes some details.

I'll leave it to the Lars or Michael to confirm what is going on here.

Jonathan

> 
> >   
> > >         select AD7606
> > >         help
> > >           Say yes here to build parallel interface support for Analog Devices:  
> > 
> > Gr{oetje,eeting}s,
> > 
> >                         Geert
> > 
> > --
> > Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> > 
> > In personal conversations with technical people, I call myself a hacker. But
> > when I'm talking to journalists I just say "programmer" or something like that.
> >                                 -- Linus Torvalds  
> 

