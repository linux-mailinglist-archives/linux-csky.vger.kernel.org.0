Return-Path: <linux-csky+bounces-519-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B31C904639
	for <lists+linux-csky@lfdr.de>; Tue, 11 Jun 2024 23:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A25C9281D89
	for <lists+linux-csky@lfdr.de>; Tue, 11 Jun 2024 21:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CC2152E17;
	Tue, 11 Jun 2024 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="M+h5gXwC"
X-Original-To: linux-csky@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2115.outbound.protection.outlook.com [40.107.237.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D01101E2;
	Tue, 11 Jun 2024 21:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718141016; cv=fail; b=BWDQAdG20h8eYC95rRt0z/8qL8mNMCziXSQqubPe/tTOGdVVkBLjPFG+TVQ0RPmlFviWIfzQ5H6OJU5uOBtA1EttR/3kua7k5Xl44r+Oouol67TkUe38DXP7hcssSPw7iWb0e+jDEkx1ENMCM/UEinRXpWlhuBNb1ajgMe6ecHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718141016; c=relaxed/simple;
	bh=n//Sd8bS6BiWfF1XHMEseW13K1rImSyiX5GV00gDhXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DTl/3fOFjm1dojygr80kZKQVKoOhDECXq+FVEMUwwt3xxj66nJOJr6YgvZVOYOu2wLszB6uHrGDMELT8k4HLhANP2sZWPGH873Y/sHpi0DHHJodURRm3w7DD9w2OOyxswWX/H9HSvdb4yi7GlLlPrKuOgL59tHGYybdmAnnObb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=M+h5gXwC; arc=fail smtp.client-ip=40.107.237.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Go1GOYjjuhoP4iMk2BnqhUYxPSD9w6eoRadsTtcTu/Qrw4r6JWfSo0MycnTwVea5iN+Q17AZshH7eoCvGpF0jFTPbvMqsl8/tEPQbo73aupI0466ZV08OjeeuOqL7ur1ZLZ3FG+mJL92dFlePkRy3m6AhIf8kCmoF7uHG9llY02KXx0vty+MuDEZjdfe+JUeprSI8fnZMUUa76qUg0WNWaZq6/prhzRkOWC4lEAV1ZE7rREKYpRSqmoCH4HZ0wR9D9dlDqQVMe4tyN07nk45qTeR02P0nTny2skHKHYfbtk4mQ4un0ZTG1D4X5q3PirMpkjaZS+g3bijg+CGGjsgXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JsGQPCHIipY+q1a4JbEoPvuB6RYPi9yNu4vVqMHpzAw=;
 b=G7CoClSbaU1ZlxKVqPL+tvNIXDUvMTLfQwukZpqbiZ1Q5t51dcCSj/C58KrP0hmoZ31CjOxgys3Zcjm32EZCykMJrI+knH4E2FHXywjqmt+vocubEm7gQMQtD6rj1lljBT459mDw1/gj0zdKP6qngWzNmuz+3Y122gYGaD3Nkj2kPnNq/co/DQ5fa01FM/0vvAY86DHxRzAo+K1XJ1ieVLVp+zIdSb5Quxd33HTYwYcbQvsEO+pevRjzw8//kYRN0fLgBrORf1PQ0wp9bpTAuh3fTu29PvnosfgBj/Jv+xl0IlJotEUW5rsJzx4p3nXqtUbumu1AZE1jRU2x2d4NoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JsGQPCHIipY+q1a4JbEoPvuB6RYPi9yNu4vVqMHpzAw=;
 b=M+h5gXwCkpX9w2JH5i5OEqRYSZ9imGTyMykCX2t7U5I1+oRDCHOsyxYSaUwU/bEdVwSjwxq1LZYx08Y996u+7qb7Ku0ygdKiKDZYvQnyhwjaB6qm/4pJ46J5qnu6KopL0W05HwFKIWVQ8qZOBpVXIiZGr6QJ9fBmlN0Tn8VE8bQ=
Received: from CH2PR01MB5894.prod.exchangelabs.com (2603:10b6:610:45::11) by
 PH0PR01MB7994.prod.exchangelabs.com (2603:10b6:510:28a::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Tue, 11 Jun 2024 21:23:29 +0000
Received: from CH2PR01MB5894.prod.exchangelabs.com
 ([fe80::b5cc:1692:8c7d:8beb]) by CH2PR01MB5894.prod.exchangelabs.com
 ([fe80::b5cc:1692:8c7d:8beb%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 21:23:29 +0000
From: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "ampere-linux-kernel@lists.amperecomputing.com"
	<ampere-linux-kernel@lists.amperecomputing.com>, Uladzislau Rezki
	<urezki@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "cl@linux.com" <cl@linux.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"guoren@kernel.org" <guoren@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "xiongwei.song@windriver.com"
	<xiongwei.song@windriver.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-csky@vger.kernel.org"
	<linux-csky@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v5] vmalloc: Modify the alloc_vmap_area() error message
 for better diagnostics
Thread-Topic: [PATCH v5] vmalloc: Modify the alloc_vmap_area() error message
 for better diagnostics
Thread-Index: AQHavDmRZpr65ASmm0yKhLm7LH+QBLHDEN0h
Date: Tue, 11 Jun 2024 21:23:28 +0000
Message-ID:
 <CH2PR01MB589437889263FA99CC3F7DEAF5C72@CH2PR01MB5894.prod.exchangelabs.com>
References:
 <CH2PR01MB5894B0182EA0B28DF2EFB916F5C72@CH2PR01MB5894.prod.exchangelabs.com>
 <20240611125713.eeef88483f5a782e3df71b21@linux-foundation.org>
In-Reply-To: <20240611125713.eeef88483f5a782e3df71b21@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Enabled=True;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SiteId=3bc2b170-fd94-476d-b0ce-4229bdc904a7;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SetDate=2024-06-11T21:23:27.943Z;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Name=Confidential;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_ContentBits=0;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR01MB5894:EE_|PH0PR01MB7994:EE_
x-ms-office365-filtering-correlation-id: f1ab6a6a-15aa-4e6e-0dd9-08dc8a5cbcca
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230032|376006|7416006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?q3OuNslMFxPHMWFKThp96OCfJmW9FuWWXNiRKjJom/4wT7Tx43ZvQyRhMYKZ?=
 =?us-ascii?Q?TOsxyGtT8AD27T/4O4AHw2WnbxegssNdcNg4InMZDlUuPTN3Qd6S2LKe6+7t?=
 =?us-ascii?Q?1uWHGGHRAxp8g5kzkJJeaiuPi3hRdDAguuijiM1rdG63swIGF/CiCmDN8Oz9?=
 =?us-ascii?Q?O3pXQ2ELi4Wz/cvU6IbVOXAt60LMk6urWrcBMYy84MBjn4kflIV/y/slPigZ?=
 =?us-ascii?Q?8W+4k9f5YlyD8eLR5cLWl3kyw3nvpW2l3LochLG5wYmLvejw/x9zUW9MrBCp?=
 =?us-ascii?Q?7MZqykfGm2KboU3iFYJOCUgDrVk7xJKV/jYvfCnzY2Up/owtG3DN5+9cREzG?=
 =?us-ascii?Q?UOTvmH+Dxcz6/5lBHL1IAd6mPX9sE2ugQ34DOLBsqrfeo4n7KobgJleKKhqC?=
 =?us-ascii?Q?D7mTQE4doPOWZ39JUgeXCrPervJkBp1qJLATP/HSVOpL8i3EZewbNvxUkv4g?=
 =?us-ascii?Q?5K664oYqHYjDUPew2EkSQ21Yp5U8L4i9L+MErGH/vJ4thDjcJktgXYHHH9dA?=
 =?us-ascii?Q?6Bwy9PBt77ZVgLInRFSIEDRUE6XNEKD7Gc5Bc3n6VB2xJTVl73rMBhhWtlKE?=
 =?us-ascii?Q?6e3sclDNWfR0iS1ulkABFXvoV8CB9MSQvysPuTUmqOUIkN10RByURIaqpWU9?=
 =?us-ascii?Q?XvwWPNQaRBTSRuoMPqX7ptUKbrraxXKFs/hGqHhgn4BbLpdpnPpPA/ylJPL3?=
 =?us-ascii?Q?ZRqS07Fu92xCDu587kiMSDRfZqBCHwSZ6WSzhwulLLEWJ4QzEOFpkZygQ+em?=
 =?us-ascii?Q?dIb6V6DkiCrwpUhQDzbCbArBorbUJwkppp8zbRa7l3AaJL25d1z9hi2nFGPo?=
 =?us-ascii?Q?tJLtyWxbQzsSYyDvqRX1US5fUg6v/NpOp9IyxRRf5dKw3qgnVkHWntGNFhjt?=
 =?us-ascii?Q?ho5B33ZTMw0Nuow/0DGj8vwXyR3/toDxL9zPtSOdwFQEV6vWpk2e7vFuVN/1?=
 =?us-ascii?Q?ZQQfX8WttX6kfqcR/dBRfueBvWKERPUuQ+K1ZEW7cvxVMaAQaRm8AYY8aswC?=
 =?us-ascii?Q?km4L816xIUy57Z593qIBefo970yT70E3EccA+quAEDGlhFwJNo5O/sUKANSB?=
 =?us-ascii?Q?8DHj70zUmjCDwqWybcspIqI867vvhSupMJ9U91eRSUG2mwKncwuh2S95DWCT?=
 =?us-ascii?Q?9pt+eRxzEowGoRDDY2/yFNBUakBP9FqHVQl7wSl5D/5smbT4B6NabO4MfBUT?=
 =?us-ascii?Q?nuvqM3XGLPSgYlo27m5434ZJheybBkpV/5Mm3GARK98zllLOn3pex8HwB8YF?=
 =?us-ascii?Q?iVCEB0OEGnlBvxZtVsZgcO/yXmTXM9YkdU0dnozfW0FmNH/VInYOKkoy4MKm?=
 =?us-ascii?Q?2PCoN+LLwRlulgD9kbkfn5O1XlTPXt5CKvguMQLwA/WZcLACBZJ/h6kuAkoZ?=
 =?us-ascii?Q?rXMo6Y0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR01MB5894.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(7416006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YVvIILkymPAOD1WchvehA5wNSBMfamiR8pjROZFBJER+7NvA44iOEvb3xVtl?=
 =?us-ascii?Q?5cpF7BDkMYT66IovPTS2TFcUawtDRbkVbQ2FFOU4NpxyaeDGCaHqxHDmOPp+?=
 =?us-ascii?Q?JVqqyLdBWCzYXLY7ToWV/WwZuM0qxfky7g3wVJZl5TZp8IkOCCMetKG/gkvp?=
 =?us-ascii?Q?L4ZcCCxrdbQ4Jm89fnNRhWbP2obXvzLmnyAT00LCdsmLQSLr8Z+5jcA+oGhR?=
 =?us-ascii?Q?vMT2gxYfUIueUwEqh1dFD4WWGBHqsey19YVgOHsf/+ottsYoSKNpxtoKb3gz?=
 =?us-ascii?Q?Jd4JYxaqbhm2rr0CkvDY/teYHHcLQQB7eidQkg2nOqUd+FiO1SLVv/kZmZuB?=
 =?us-ascii?Q?WdyKun2NLTB2lIr2pnQhILQ05Fpa4E6gFgZUwGds1qXb/exQrDgdOFPtMsdg?=
 =?us-ascii?Q?BtQRAK9aoVs4FcsaszUVxdrQRvVjRjkPwEaCWIayLBBr9iQWrL9kBNzHFYl+?=
 =?us-ascii?Q?ndv2U7PFON4A310Rl6M+NJz5OtcoNykiuJ+J2buw28DIW/rJoz2hoFs6U442?=
 =?us-ascii?Q?aBVzFZ6sUrcKf/GZ+hiibXDihSyL3BGAhYqR//RwTTl+5a1Zv1sQ7MLunfEe?=
 =?us-ascii?Q?kBe+YTW+GLlegjE+Lq3bhB5LE3+wCOwhIy+t09cUg+GboCNHKCSBu5iIeZys?=
 =?us-ascii?Q?DZl7ZMwdo0BBQx2lgf43AHrnaSlnoOU0MqyWhJBM/tf94D9KbKh074xx/QMF?=
 =?us-ascii?Q?vS5ImsEajEZp1n42Zr/HSTT6FHjwl6ncnO8fhxienfFTcDy+mljtbsRFRIVc?=
 =?us-ascii?Q?c7UpJlHqngvkM0aLw1+S+ps2wgssbIZ2bDSsd3mwY7xfDl0pEhnOlu1W0Pra?=
 =?us-ascii?Q?m3Pv4NQrzh+TNLQTt4YL3Qz+CeKsyTSsVU1rgIgpbuM5UXyWmytvyDa8Wokq?=
 =?us-ascii?Q?30OXXqsWNL2z8CsNEpH1vHAvR6Wx7npRkKVt+V4LRjsxtNtCMhPME2SsXz5p?=
 =?us-ascii?Q?xgNuAVd6Xn3KJpNf4ihf0Ujv4iMGRnwLvQCoh2X1Zd8TtUbS9yNGmv5cHmF7?=
 =?us-ascii?Q?D3P3JI/2FVouoTeJ06Ze67VLjLcN0IMWJkaAXHYeYUpHdpaJBO1Xw4gZKw+W?=
 =?us-ascii?Q?d2vIM22jjIm5bSXxcuawpL/Aw3tVksy+DFUeQ3O7fX7GbU6pUrTMmDzMNu6k?=
 =?us-ascii?Q?NNATTCeXZRgCtfnW/cXk884Wi2jegcSrjjRB4TvbJJ18weCzi9HIgAy2MZD0?=
 =?us-ascii?Q?K3tsWv49CQdqlsD1RSLiFesqBLG5HIHPRiJgermbEU+yVsWK4eMX3B18VcMo?=
 =?us-ascii?Q?l35a17aOnwxs0XyyYybAp1odfLPn5dFt8BagdELr9ovtDiPgfkbN2JE3JaXn?=
 =?us-ascii?Q?YWWMOo46+VAB1rlQwA5yaZWWvmh3vVq+ExzOH2/oYChXLzL2LEZUEE/gV2Cd?=
 =?us-ascii?Q?NEoppnLcLkjsoQKOGSMe9ZcDlnea7LrboJbKejLyNJquRioSURk0huLqEye8?=
 =?us-ascii?Q?qbvl9nkGswWo7S3uva7qOYYFseGj8b5NP01nZ8Ig+DtVdp79kzYTG+4EL8cL?=
 =?us-ascii?Q?ntSw5/CGdjTKXBlXhkMY8mRDXvruGzUwK/Lgt4gqSP93uakWiWno8wlb4mc/?=
 =?us-ascii?Q?to7YJADXtoww2N+C/da2ntQn/d4y5rIOaa1UerKNkzlw6XWFWnad5eRk85fD?=
 =?us-ascii?Q?p7eG5+nk2FdaOOrysJ2Rn6A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR01MB5894.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1ab6a6a-15aa-4e6e-0dd9-08dc8a5cbcca
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 21:23:28.8290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIigFJv1JaOgLFQYgoKuDO3BkPa2cJu6jYdkwYZMmZ6nb3B6H1uiM9hrwJGep8bc20R0KsW3RSWYg9Tob4XYJ90aO+gpVvMB9BZcvJjsHpfpXWESKmEVDC5WGNy2jIYa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR01MB7994

Okay, will follow that protocol. This update is to replace the vmalloc rang=
e parameters in the overflow warning message to be between vstart and vend.

________________________________________
From: Andrew Morton <akpm@linux-foundation.org>
Sent: Tuesday, June 11, 2024 12:57 PM
To: Shubhang Kaushik OS
Cc: ampere-linux-kernel@lists.amperecomputing.com; Uladzislau Rezki; linux-=
arm-kernel@lists.infradead.org; cl@linux.com; corbet@lwn.net; linux-mm@kvac=
k.org; guoren@kernel.org; linux-doc@vger.kernel.org; xiongwei.song@windrive=
r.com; linux-riscv@lists.infradead.org; linux-csky@vger.kernel.org; Matthew=
 Wilcox
Subject: Re: [PATCH v5] vmalloc: Modify the alloc_vmap_area() error message=
 for better diagnostics

On Tue, 11 Jun 2024 19:38:44 +0000 Shubhang Kaushik OS <Shubhang@os.amperec=
omputing.com> wrote:

> 'vmap allocation for size %lu failed: use vmalloc=3D<size> to increase si=
ze'
> The above warning is seen in the kernel functionality for allocation of t=
he restricted virtual memory range till exhaustion.
>
> This message is misleading because 'vmalloc=3D' is supported on arm32, x8=
6 platforms and is not a valid kernel parameter on a number of other platfo=
rms (in particular its not supported on arm64, alpha, loongarch, arc, csky,=
 hexagon, microblaze, mips, nios2, openrisc, parisc, m64k, powerpc, riscv, =
sh, um, xtensa, s390, sparc). With the update, the output gets modified to =
include the function parameters along with the start and end of the virtual=
 memory range allowed.
>
> The warning message after fix on kernel version 6.10.0-rc1+:
>
> vmalloc_node_range for size 33619968 failed: Address range restricted bet=
ween 0xffff800082640000 - 0xffff800084650000
>
> Backtrace with the misleading error message:
>
>       vmap allocation for size 33619968 failed: use vmalloc=3D<size> to i=
ncrease size
>       insmod: vmalloc error: size 33554432, vm_struct allocation failed, =
mode:0xcc0(GFP_KERNEL), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0
>       CPU: 46 PID: 1977 Comm: insmod Tainted: G            E      6.10.0-=
rc1+ #79
>       Hardware name: INGRASYS Yushan Server iSystem TEMP-S000141176+10/Yu=
shan Motherboard, BIOS 2.10.20230517 (SCP: xxx) yyyy/mm/dd
>       Call trace:
>               dump_backtrace+0xa0/0x128
>               show_stack+0x20/0x38
>               dump_stack_lvl+0x78/0x90
>               dump_stack+0x18/0x28
>               warn_alloc+0x12c/0x1b8
>               __vmalloc_node_range_noprof+0x28c/0x7e0
>               custom_init+0xb4/0xfff8 [test_driver]
>               do_one_initcall+0x60/0x290
>               do_init_module+0x68/0x250
>               load_module+0x236c/0x2428
>               init_module_from_file+0x8c/0xd8
>               __arm64_sys_finit_module+0x1b4/0x388
>               invoke_syscall+0x78/0x108
>               el0_svc_common.constprop.0+0x48/0xf0
>               do_el0_svc+0x24/0x38
>               el0_svc+0x3c/0x130
>               el0t_64_sync_handler+0x100/0x130
>               el0t_64_sync+0x190/0x198

When sending an updated version, please describe what was changed since
the previous version.  After the changelog's ^---$ separator is the
usual place.

I'm seeing this:

--- a/mm/vmalloc.c~vmalloc-modify-the-alloc_vmap_area-error-message-for-bet=
ter-diagnostics-v5
+++ a/mm/vmalloc.c
@@ -2057,7 +2057,7 @@ overflow:

        if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
                pr_warn("vmalloc_node_range for size %lu failed: Address ra=
nge restricted to %#lx - %#lx\n",
-                               size, addr, addr+size);
+                               size, vstart, vend);

        kmem_cache_free(vmap_area_cachep, va);
        return ERR_PTR(-EBUSY);
_

which I assume has no effect?

