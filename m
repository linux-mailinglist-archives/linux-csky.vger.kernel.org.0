Return-Path: <linux-csky+bounces-2560-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E7ACB4D55
	for <lists+linux-csky@lfdr.de>; Thu, 11 Dec 2025 07:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 155003000B7D
	for <lists+linux-csky@lfdr.de>; Thu, 11 Dec 2025 06:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBE61A9F90;
	Thu, 11 Dec 2025 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rustsyndi.cat header.i=@rustsyndi.cat header.b="W1p2mnMF"
X-Original-To: linux-csky@vger.kernel.org
Received: from out-02.pe-bsn.jellyfish.systems (out-02.pe-bsn.jellyfish.systems [66.29.159.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D25FC0A
	for <linux-csky@vger.kernel.org>; Thu, 11 Dec 2025 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.29.159.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765433103; cv=none; b=cImHACNPkF4b1TFFM4sMM/l7y5pUI7t3XZDq2TY+QvSXH7X+tX4rM/jbNVsc3GMsJ9bCjHPV1wwpzjXKFMDDVCsO6aYRd2AlA8qUUCxd51ZDKoBC8eJeVsKcz8p+CRGTEToyfKGdR32w17YlIaeIgnvK1zZEQQ1RRGxj2V58bNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765433103; c=relaxed/simple;
	bh=5GNl5dCGyS1qZTbbCohgmIREBKqBFFOzj1KjL4Ardz4=;
	h=Content-Type:MIME-Version:From:To:Subject:Message-Id:Date; b=ENeCWZTud1CISXu72wiYwyNjtBSUgnkKlzEB6M93je3eUHKmzF8z2ro9e4TpGW9fA5L7NK/7zRepxGd/tQObaBqOinWdVxklC53gWlHhyRJIE8rJHdI7RbDDMdzxCmOBRwEmQWEyhtMuzcrAi29XkQtRkatMfJHTqONj96xka28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rustsyndi.cat; spf=pass smtp.mailfrom=rustsyndi.cat; dkim=pass (2048-bit key) header.d=rustsyndi.cat header.i=@rustsyndi.cat header.b=W1p2mnMF; arc=none smtp.client-ip=66.29.159.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rustsyndi.cat
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rustsyndi.cat
Received: from MTA-15.privateemail.com (unknown [10.50.14.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by BSN-01.privateemail.com (Postfix) with ESMTPS id 4dRhkF631jz3hhTh
	for <linux-csky@vger.kernel.org>; Thu, 11 Dec 2025 00:59:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=rustsyndi.cat;
	s=default; t=1765432773;
	bh=5GNl5dCGyS1qZTbbCohgmIREBKqBFFOzj1KjL4Ardz4=;
	h=From:To:Subject:Date:From;
	b=W1p2mnMFl4A6h9PWOMZhlofvOHt7bQlfGvT5Zdo7Zx4eeBaBWw5Kmepzbxjc0eO95
	 c2R6sp9qCYjly/q/LxH5PG+APdr1AQ+HkIh1ZFmIc067LeeC4n/RvjqVM/ueTHnTJ6
	 fkKET/t9McN9NMX9amYkBeVCFpo/VdpgHilxPEjiWYVUkBs0YxASwyKu9RmClB4a/F
	 3NOPqyuWwlXk2wWXkYaHSitx9LoYLFQJHOp9ZXIrnUxSzVi7WN1bMRsOxzfBWHldDj
	 PUE2TMN3h1pu3zdOwyzUwQCA7luRk6IBEOK9Mjk8iQg/pmhkSfTIiwAnODBJETV5Gr
	 j6pUxy4OSxv2Q==
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
	by mta-15.privateemail.com (Postfix) with ESMTP id 4dRhkF4vTsz3hhTn
	for <linux-csky@vger.kernel.org>; Thu, 11 Dec 2025 00:59:33 -0500 (EST)
Received: from [127.0.1.1] (static.226.230.55.162.clients.your-server.de [162.55.230.226])
	by mta-15.privateemail.com (Postfix) with ESMTPA
	for <linux-csky@vger.kernel.org>; Thu, 11 Dec 2025 00:59:33 -0500 (EST)
Content-Type: multipart/mixed; boundary="===============1451202154452877548=="
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/145.0
From: Orjan hr | Rust Syndicate <hr@rustsyndi.cat>
To: linux-csky@vger.kernel.org
Subject: Are there any developer roles open?
X-Virus-Scanned: ClamAV using ClamSMTP
Message-Id: <4dRhkF4vTsz3hhTn@mta-15.privateemail.com>
Date: Thu, 11 Dec 2025 00:59:33 -0500 (EST)

--===============1451202154452877548==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

R3JlZXRpbmdzIFRlYW0sCgpNeSBuYW1lIGlzIE9yamFuIFBlcm90dGkgYW5kIEknbSBhIFJ1c3Qg
cHJvZ3JhbW1pbmcgYWR2b2NhdGUgYW5kIGVudGh1c2lhc3QhIFBsZWFzdXJlIHRvIGUtbWVldCB5
b3UgZ3V5cyEgCgpJIHNhdyB0aGF0IHlvdSBndXlzIGhhdmUgc29tZSBydXN0IGNvZGUgb24geW91
ciBwdWJsaWMgZ2l0aHViLCBBd2Vzb21lIQoKSSB3YXMganVzdCB3b25kZXJpbmcsIGFyZSB5b3Ug
Z3V5cyBjdXJyZW50bHkgaGlyaW5nIGRldmVsb3BlcnM/CgpCZWluZyBmcm9tIHRoZSBSdXN0IGNv
bW11bml0eSB3ZSBrbm93IHdoYXQgYSBwYWluIGluIGl0IGlzIHRvIHJlYWNoIHRoZSBjb3JyZWN0
IHBlb3BsZSBmb3IgdGhlIHJvbGUsIHRoYXQgaXMgd2h5IGEgZmV3IHllYXJzIGFnbyB3aGVuIE1v
emlsbGEgc3RhcnRlZCB0byBmaXJlIGZlbGxvdyBSdXN0IGRldmVsb3BlcnMsIHdlIHJvc2UgdXAg
YW5kIGNyZWF0ZWQgUnVzdC5DYXJlZXJzLCBUaGUgbnVtYmVyIDEgcGxhY2UgYW5kIG9sZGVzdCBz
dGlsbCBydW5uaW5nIFJ1c3QgZGV2ZWxvcGVyIGpvYiBib2FyZCwgYW5kIGZvciB0aGUgbGFzdCBm
ZXcgeWVhcnMgd2UgYXJlIGEgc3RhYmxlIHBpbGxhciBpbiB0aGUgUnVzdCBkZXZlbG9wZXIgY29t
bXVuaXR5ISBCZWluZyB0aGUgYnJpZGdlIGJldHdlZW4gZW50ZXJwcmlzZSBhbmQgY29tbXVuaXR5
LCBoZWxwaW5nIHNlcmlvdXMgY29tcGFuaWVzIGZpbmQgdGFsZW50ZWQgZGV2ZWxvcGVycywgd2hp
Y2ggaW4gdGhlc2UgdGltZXMgc2VlbXMgbGlrZSBhIGRpbWUgaW4gYSBkb3plbiDwn5mCCgpJZiB5
b3UgZ3V5cyBhcmUgaGlyaW5nIHdlIHdvdWxkIGxvdmUgdG8gaGF2ZSB5b3VyIFJ1c3QgZGV2ZWxv
cGVyIHJvbGVzIGxpc3RlZCBvbiBSdXN0LkNhcmVlcnMhClBhcnQgb2Ygb3VyIG1pc3Npb24gaXMg
dG8gbWFrZSB0aGUgUnVzdCBjb21tdW5pdHkgc3Ryb25nZXIsIGFuZCB0aGF0IGlzIHdoeSB3ZSBh
cmUgb2ZmZXJpbmcgZXh0cmVtZSBkaXNjb3VudHMgdG8gQ29tcGFuaWVzIHdvcmtpbmcgb24gb3Bl
bnNvdXJjZS4gQW5kIEknbSBhbHdheXMgaGVyZSB0byBoZWxwLgoKSGF2ZSBhIHByb2R1Y3RpdmUg
d2VlayEKCkNoZWVyaW8hCgotLSAKU2luY2VyZWx5LApPcmphbiB2b24gUGVyb3R0aQpSdXN0LkNh
cmVlcnMKCiAgICA=

--===============1451202154452877548==--

