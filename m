Return-Path: <linux-csky+bounces-735-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A347F9603C3
	for <lists+linux-csky@lfdr.de>; Tue, 27 Aug 2024 09:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC22B1C2143B
	for <lists+linux-csky@lfdr.de>; Tue, 27 Aug 2024 07:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45D717BEC1;
	Tue, 27 Aug 2024 07:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b="OslJO7jU"
X-Original-To: linux-csky@vger.kernel.org
Received: from mail.tradeharmony.pl (mail.tradeharmony.pl [5.196.29.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5015B54C
	for <linux-csky@vger.kernel.org>; Tue, 27 Aug 2024 07:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.196.29.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745535; cv=none; b=irngRFunAt/Msvw7x5ZclV5Gi8PQBPRdCpF2qna5wI5BGOS+E1H1mhOfS6WGsFE7qONBbXLskV0bNpWB4p1j7w/dJhyv9ZiboPyOhFCoJOPSjTYY8ArWQyvqY0gpGSGDSG39y7x7lip4QqnsoXfhWlLEdqQbV/chkCSeuRP3ego=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745535; c=relaxed/simple;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=cVI95ZDgJS1dlI7dSyHjSksLsYDA2vqmM6WfCyXxN5NrMx8lUCx/vzpC4epfoscto/JaiMlbn+D7Bzb+yldaqsbaBtwBez0dLOMadRsmcCly4J6MKNHXLqX7Y0V34Fn1vCl1x0p1UT/86Yx5iX89RScBYP/qAPrZ5zhkuiXHsKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl; spf=pass smtp.mailfrom=tradeharmony.pl; dkim=pass (2048-bit key) header.d=tradeharmony.pl header.i=@tradeharmony.pl header.b=OslJO7jU; arc=none smtp.client-ip=5.196.29.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=tradeharmony.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tradeharmony.pl
Received: by mail.tradeharmony.pl (Postfix, from userid 1002)
	id 11E58270F6; Tue, 27 Aug 2024 09:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tradeharmony.pl;
	s=mail; t=1724745445;
	bh=siHX5jVClg4W32F/NjlCmIL8w17yqZEkZP0Dfrdd7Ok=;
	h=Date:From:To:Subject:From;
	b=OslJO7jUt4h1XhOXOuoOurI6ZZHAxLPwMlwjPYO3LK/qEZ3OelDOlNobVbSvOjCkT
	 Xn5BMYjCE8nNqTPdQCWfB9I4zj1vJ1XTrJgvgr9zEEzPvMXdCzmSmx5clTzoFRoBoj
	 NNkqES84u6/AJ4Vx6gaF1I96ZEB7i2OeMWDEAzEYFL7Q0dPJB3BYYla/eOnVyQjjXk
	 4K98vLbz7xf46OkjtRpUbXM15CilkatXBi0b1TIilI7REfr2fwCNrBI5/vUSqlQA7R
	 AfSPTuUuIgMRNLVf57dp7/cc+QLJp6JRpqJqlBK2pI0hZAFJ5t4Kfs6KNVtX+Cmu5n
	 x0zhj8UtH79Yw==
Received: by mail.tradeharmony.pl for <linux-csky@vger.kernel.org>; Tue, 27 Aug 2024 07:55:59 GMT
Message-ID: <20240827084500-0.1.8a.2xj9z.0.2mjtj59g26@tradeharmony.pl>
Date: Tue, 27 Aug 2024 07:55:59 GMT
From: "Karol Michun" <karol.michun@tradeharmony.pl>
To: <linux-csky@vger.kernel.org>
Subject: =?UTF-8?Q?Pytanie_o_samoch=C3=B3d_?=
X-Mailer: mail.tradeharmony.pl
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dzie=C5=84 dobry,

Czy interesuje Pa=C5=84stwa rozwi=C4=85zanie umo=C5=BCliwiaj=C4=85ce moni=
torowanie samochod=C3=B3w firmowych oraz optymalizacj=C4=99 koszt=C3=B3w =
ich utrzymania?=20


Pozdrawiam
Karol Michun

