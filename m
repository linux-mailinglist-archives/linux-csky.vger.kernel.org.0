Return-Path: <linux-csky+bounces-491-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C47F8B62D8
	for <lists+linux-csky@lfdr.de>; Mon, 29 Apr 2024 21:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7081F227C3
	for <lists+linux-csky@lfdr.de>; Mon, 29 Apr 2024 19:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA99713C66A;
	Mon, 29 Apr 2024 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nona.1cooldns.com header.i=ghim@nona.1cooldns.com header.b="OsiPN2n0"
X-Original-To: linux-csky@vger.kernel.org
Received: from rdns0.nona.1cooldns.com (rdns0.nona.1cooldns.com [31.192.235.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EAF13C3F6
	for <linux-csky@vger.kernel.org>; Mon, 29 Apr 2024 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.192.235.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420177; cv=none; b=PR6zt3NZSAd5LLN2rCY6RPby8q6AQv+gzIYYaZ0UHmCZAwZVHQ+MauFk9920uNuRmCaUyYNDcDa9sQsR2KZAaBv1YFn9+6mtI6KqWcJuGka8a+1GBeaHjDtRCorOEtHttWfxwyWFhrth5Vv5+XfxMEeVbiTUnlgJzgoHLFf6kWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420177; c=relaxed/simple;
	bh=JG0SV9hXY/1TtbjjSQkLyMvYYfN5KWdFuiRFpI+nqE8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OVJRJcZpcv1AKlL2qWb7jL7hk6H+t552UNKUe/1qbSHaf3KQ00AxtZPuhivHZ6g5kotasgrUBkFLLtnDvODOU8LM3DPeRK7SR50EpxmhI1hpAtcMFYrpKC80QvjKPn7LbNVGtGRSFbIuZr+IhpzjiuOo1bFv5bi9K35yC+bsTbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=nona.1cooldns.com; spf=pass smtp.mailfrom=nona.1cooldns.com; dkim=pass (1024-bit key) header.d=nona.1cooldns.com header.i=ghim@nona.1cooldns.com header.b=OsiPN2n0; arc=none smtp.client-ip=31.192.235.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=nona.1cooldns.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nona.1cooldns.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=default; d=nona.1cooldns.com;
 h=Reply-To:From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; i=ghim@nona.1cooldns.com;
 bh=JG0SV9hXY/1TtbjjSQkLyMvYYfN5KWdFuiRFpI+nqE8=;
 b=OsiPN2n0gWR6zC2MSCa4XC737ZeWewpbD3kyI/rMN7QU6pE9t6hs4kXe4fDW7qCHytgmtN5s8+Jt
   hVLqIPdNoacTeXkfbLPuK45WEaAFFO7w8KLE+l2IFswgqYj6xXRAIs7lgxotkdS9Na8fAk+WsRh/
   9SPknynFWbazbxyf/c0=
Reply-To: stanislav.marcel@aliancegroup-se.com
From: "Support" <ghim@nona.1cooldns.com>
To: linux-csky@vger.kernel.org
Subject: request for quote from sweden
Date: 30 Apr 2024 05:49:32 +1000
Message-ID: <20240430054932.A05DA178AD74A7FB@nona.1cooldns.com>
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

My name is Stanislav Head of Department, purchase. We would
like to know if you export to Sweden, as we need some of your
products for our client, kindly gives us a reply so we can send
you the full specifications and details of what we would like to
purchase.


We would appreciate your prompt attention to this request, as we
should begin a cooperation as soon as possible.


thanks & best regards.


Sten Arnlund

Purchase Manager
stanislav.marcel@aliancegrup-se.com


a: Veddige by 2, Holmerskulle, 432 68 Sweden.

