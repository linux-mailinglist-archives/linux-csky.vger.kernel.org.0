Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C387D5518
	for <lists+linux-csky@lfdr.de>; Tue, 24 Oct 2023 17:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjJXPQb (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Tue, 24 Oct 2023 11:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbjJXPQ1 (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Tue, 24 Oct 2023 11:16:27 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD17DE;
        Tue, 24 Oct 2023 08:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
        In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jgOua7XG/wnLF83C9dm9FB0uL6rg1MROYA8EjBMPhHA=; b=J2mp06g9NQqtqT3uv6Ylw6MUGl
        t7fj+2TzW7pWDsG+AfTTqVbVrFQ7E01xmS7KhXSk9a3NMdtC4NdTDMho53IISz5KGe6ZPGeG+M1o8
        W7UuBj8Tu6mPnTeK65XF5jjxwYD+3gTzqrzc4PQIgOnvIgKky6ZpA8cWYur8KkqIX6A8NlQL7S/oY
        ccYWnfYCURmqRXx13tS5qqYWGz+nejtRLJuL6igjZaiOoVIjRQxerM0ZboNIvlJyfpSDylqTeHJ5K
        2uZgq8xSxHqf9f109wLtiZsaqELT9K1GTBkwTscEaLOpZ9Xbvn05u5bRuwq65t9b9ZPhTuOxhBDtb
        bjaD9I+g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:43856 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1qvJ8k-0004LV-0H;
        Tue, 24 Oct 2023 16:16:18 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1qvJ8l-00AqOy-J5; Tue, 24 Oct 2023 16:16:19 +0100
In-Reply-To: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
References: <ZTffkAdOqL2pI2la@shell.armlinux.org.uk>
From:   Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org
Cc:     Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH 02/39] ACPI: Use the acpi_device_is_present() helper in more
 places
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qvJ8l-00AqOy-J5@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 24 Oct 2023 16:16:19 +0100
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

From: James Morse <james.morse@arm.com>

acpi_device_is_present() checks the present or functional bits
from the cached copy of _STA.

A few places open-code this check. Use the helper instead to
improve readability.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/acpi/scan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 691d4b7686ee..ed01e19514ef 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -304,7 +304,7 @@ static int acpi_scan_device_check(struct acpi_device *adev)
 	int error;
 
 	acpi_bus_get_status(adev);
-	if (adev->status.present || adev->status.functional) {
+	if (acpi_device_is_present(adev)) {
 		/*
 		 * This function is only called for device objects for which
 		 * matching scan handlers exist.  The only situation in which
@@ -338,7 +338,7 @@ static int acpi_scan_bus_check(struct acpi_device *adev, void *not_used)
 	int error;
 
 	acpi_bus_get_status(adev);
-	if (!(adev->status.present || adev->status.functional)) {
+	if (!acpi_device_is_present(adev)) {
 		acpi_scan_device_not_present(adev);
 		return 0;
 	}
-- 
2.30.2

