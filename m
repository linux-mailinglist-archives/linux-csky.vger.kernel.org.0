Return-Path: <linux-csky+bounces-517-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6761A90450C
	for <lists+linux-csky@lfdr.de>; Tue, 11 Jun 2024 21:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E694F1F23670
	for <lists+linux-csky@lfdr.de>; Tue, 11 Jun 2024 19:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0889643AD7;
	Tue, 11 Jun 2024 19:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="u35R5li/"
X-Original-To: linux-csky@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2094.outbound.protection.outlook.com [40.107.101.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46E13A27B;
	Tue, 11 Jun 2024 19:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718134729; cv=fail; b=ONZVUfT5ZGZkiAij5cPUDHuI4DysxNmB2/oCPfyAtNSAwTiRaM3jDeXED0sVlxWQHUH/hCenB+ogF0lm2J8H7gVSrIdu1e+NG1f2ewyolo8tW6vXMMzkGyq6ydz2gIKv5zgt8UDh4bgeSaTXn8vfYMkUXzMC+ycjLMOT2gGs/BQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718134729; c=relaxed/simple;
	bh=myGKSSkrP5fRemxPB0qbPuou5X1eomQRf8ioV/6a9v8=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Dx3xoUBJUMZA5o/2rHG22h982KooAQFetXcLO/xBj499y5rJ9ZPutR1iMd/bTjCLGfj055+mKnTcunyrwGGarNcLYPdYM0cyRwXu5r52Uso4mejGK7GiuEchJ9pG6IzcpUMuBi/cOPqtM3vhnqZTpHIMtnIeX0PVALgCkHuVJPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=u35R5li/; arc=fail smtp.client-ip=40.107.101.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGD8kRYHoh4j7iFTcTjBItzXOPnYVsipVK7vELg/nQDp8gg1inBWIdZqAILcmu9rqECoR6SCDjZAr1fetdALr1S0+i7x6OjmSa7NOiIQ6FtEtKTUVXGIIYJyf1X11Ne8YUsGAHehoENcQSqnX0iMLPm8jiRxzmkiadUoa6q6fNfq8YzpAfDR106H3AXxpQuHXOchcKVT8F1eJGaRu3Ymjy0vZATpD1fbFsPqHK6FX3MZeTVVw4e06KjRbCLL0Vknp7T4cOgfVaU2q0RmYpjO44aNlZYg3ykAmhTwm5qzqSiqRXnt6pIHMCzq3j2iviDWf7jIv8Z5sJE9P5ayHJ/V2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LRjY3+M8TCpBtBDZF2UBYSgsSQHyh7HHpYnbEjfJIYM=;
 b=DvHmZlWxSVgo4zkk3C2ptFhSD1xhABwCbrYJ0Eb4v+HDK+MCunEWhq4bTEXfT0fdYvIrfL4SU0JHf+oZ0QdUKn2T3gYeIntWtMrPNimqtXcftXKPbyZFePksKms2Y2IHDkxljonFmx6X8x5xATlKbmV6fhNb1SNHmMiRtRfCjgWkc+uAZRJz2zQgk414JEgJoihwlv/OwfCfWAOC8JVCPtDo9eq9lchgOUFxA143EsHU6cfiHQk1X7rxN0RFgnCyYlqo8vwwMsvQ4vY84DO31EiHrYxGo6zGxMJ6K2qQx9c0E74avBxt/OmwAkbJvKy1X4VqG41dm52QBfow9Z6jJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LRjY3+M8TCpBtBDZF2UBYSgsSQHyh7HHpYnbEjfJIYM=;
 b=u35R5li/Tndzzz3rsfMUs6vwzfBVUe0akSBPZE/yU7Dcnl886FZ29TaxTOq8sxpQVv1HPaPMDZpd6+oYTmkNycaZ69YgfRUS3HItZEUzOi0vhDNqAREKC9Pe0Y6xk542HbeQhe+KHBgTGKN1yg+dvH7Yk8YYb1+URIHQn7xQrVo=
Received: from CH2PR01MB5894.prod.exchangelabs.com (2603:10b6:610:45::11) by
 MW4PR01MB6323.prod.exchangelabs.com (2603:10b6:303:78::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.37; Tue, 11 Jun 2024 19:38:44 +0000
Received: from CH2PR01MB5894.prod.exchangelabs.com
 ([fe80::b5cc:1692:8c7d:8beb]) by CH2PR01MB5894.prod.exchangelabs.com
 ([fe80::b5cc:1692:8c7d:8beb%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 19:38:44 +0000
From: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>
To: "ampere-linux-kernel@lists.amperecomputing.com"
	<ampere-linux-kernel@lists.amperecomputing.com>
CC: Uladzislau Rezki <urezki@gmail.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "cl@linux.com" <cl@linux.com>,
	"corbet@lwn.net" <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "guoren@kernel.org"
	<guoren@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"xiongwei.song@windriver.com" <xiongwei.song@windriver.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, Matthew Wilcox
	<willy@infradead.org>
Subject: [PATCH v5] vmalloc: Modify the alloc_vmap_area() error message for
  better diagnostics
Thread-Topic: [PATCH v5] vmalloc: Modify the alloc_vmap_area() error message
 for  better diagnostics
Thread-Index: AQHavDYcN0EphoQrWUSinj2sRxMflA==
Date: Tue, 11 Jun 2024 19:38:44 +0000
Message-ID:
 <CH2PR01MB5894B0182EA0B28DF2EFB916F5C72@CH2PR01MB5894.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Enabled=True;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SiteId=3bc2b170-fd94-476d-b0ce-4229bdc904a7;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SetDate=2024-06-11T19:38:43.157Z;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Name=Confidential;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_ContentBits=0;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR01MB5894:EE_|MW4PR01MB6323:EE_
x-ms-office365-filtering-correlation-id: f6e74a85-5732-4cc7-fe6f-08dc8a4e1ae5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230032|376006|7416006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?9oyK6SQi1lo/+yjMnfrltrSXdCOQYVWHSuXQOi+tBap3F5aXQAGQCW9HxO?=
 =?iso-8859-1?Q?gD3wjtNnqBj8Xz6HDnubiEDfm2HWVHdK1O6/4Z7yB7RADRD60agelR0J+j?=
 =?iso-8859-1?Q?tS22V85S95wify72O1h3in1SAa3+N49oe+hF7icR5ILr/Vik6IviLZLdTb?=
 =?iso-8859-1?Q?S1u+o8dvIyHxcuwmKi3JH5veXVImdSjSmzjyJbjiJLnVp0GeHmPoLEqT+/?=
 =?iso-8859-1?Q?4k+qNnHhESLt0uCH6x403Xvok5KfnCpf+WEFQE+4hdQt1RHOFtf/osZOzK?=
 =?iso-8859-1?Q?eIIJFmhEvc8zeYW0BFyZjcwci1DrmVu65tnt/tU3nMeS31VMI1H+7E+PyT?=
 =?iso-8859-1?Q?TT4rMiHIZ4hC6snH9wDkhd+Zo3+BJ3s7cw1RaPRdrMQqbixlnTa/romdvA?=
 =?iso-8859-1?Q?OfrcWkscye5j5yRhPBULSjbmXG4H9O4ScOLCXCh2byUfum+p4SAxYuf0q9?=
 =?iso-8859-1?Q?LtwrZhR4NSXxKs8u3R+4vReLwdEBngWNHSQSjBjuXcjJ48OjzW0+EV3g7k?=
 =?iso-8859-1?Q?FSRQA6zQuvrknY6KsDH/BHm1L1bXlkQGi1reEqXIedyasL1hXhc1piJ6bW?=
 =?iso-8859-1?Q?W9ls8XXg2sTHgWxrsqVyS+jOGluL12vvlccG0VfONIYBPMvHw6wog+Z7da?=
 =?iso-8859-1?Q?+HFSAr0TbP4eoTWkedcUyYL3lR5j4HcOHWtfKqB0cea9rMp6q6JntaXHQI?=
 =?iso-8859-1?Q?sxHhiqgS97q9C0eqCrn2V8+ztIOn12GKOl6IEnjIfjNtX1WOBbKln4s1CK?=
 =?iso-8859-1?Q?qlggJm+G2G1qM895fPPXCq/CsaT1zC3NL04ZRq9izaf7NH1ZHgm5rkb82p?=
 =?iso-8859-1?Q?x67MrSWX1iaeI/ncZ1tkihYt91PBJEvSFMHbFSSkFd1nFaEB+H3UW6QDrS?=
 =?iso-8859-1?Q?EvWXZPsrqWzq0c37KbfEHaVyCcfDIBQQEdTiIaytNiLwq5NHldzAEmRzLk?=
 =?iso-8859-1?Q?nH+Zah9S2lmG8vJ/cbGdZbbr6p7zG3e0H1bU+89DP2PU4T2n3Aog3BLP8E?=
 =?iso-8859-1?Q?2dO/10Emr1JJbFnk+L5ljPul/mNtYJKjA26HrMjTztyJThUO0/yYOJiqIC?=
 =?iso-8859-1?Q?amH6xn4gHtLHEuwEylqd8EcMv1XehW01bm6G0AKwFHUOYMsBygWlYEee6g?=
 =?iso-8859-1?Q?L8cZ0xZe2qyfGej5TBd5NCaoJ6Qg90gRUyXg8RKakMWyi8rElVVSCyO2vr?=
 =?iso-8859-1?Q?48Nivf7cKVHu7oIuwnGwjG39ELbTV/LX7cZ6BGDIa1jIqRlYCNZT71dggb?=
 =?iso-8859-1?Q?TKFjKXC9NDgCccZDuBxLVKrPCXfzxBEcrAMI4lQxBPsAyLWETGSCcheQIJ?=
 =?iso-8859-1?Q?84WcEgfZHoOG50WjmQE1E8ZCM39WdJsaFXldQI0j7gsrq25Py4QgZQNo9w?=
 =?iso-8859-1?Q?hK1xn/8pVNr8BKJ/vMbGR1dr81PnpOHi3v5OMf3Z17SLFiN7zZARg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR01MB5894.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(7416006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?ur7JQTnLMjn6vsoY8kPmVAPqYUZynQ7qfJjhUs/bwn9qh8qzTQ4HUG0QbH?=
 =?iso-8859-1?Q?31HO4jIF6DNzcrajEjf+SqrcFdzz6A3khYBluPtjMrHZf1FLc0VEfBHGFF?=
 =?iso-8859-1?Q?GX2nsAO6qLWMtz8HeTG7MbAjAsviTyKptUFfeJrXKEKIWM7TaF556UG1zH?=
 =?iso-8859-1?Q?5BGGwHSwzC6aTyr6CNl9DvYlT7IVISgq/H2wd5w1uJ6lixdQOTnXbmFOrv?=
 =?iso-8859-1?Q?ph1Qgat2NW3dTr+4PIWRrjWM4BmS+9CrD4oJ/ENJRg2bIj/cUQI4OevByW?=
 =?iso-8859-1?Q?fzxU+2gc/xaye1KQH8DfyJRM2pZYgAMn4KpmvxoJxjR8O9woCnqqc2A+gD?=
 =?iso-8859-1?Q?6Ldse9TeB+1JnMmGeMtS8WlQa+ZgfroSa/Q7bE2y1nCzkDhZx4JXJUGOXs?=
 =?iso-8859-1?Q?dsvVo4eEf4YIEYDt0UOmT200ogdrsOZ81fjtDczhIcHjtgrmV96aTuqDbZ?=
 =?iso-8859-1?Q?B5KJCaIYpuTC4DcRAeyO40jJjvhFwaXLrWL+oLNwF9Pm38RFiCBTCiHaOK?=
 =?iso-8859-1?Q?65I/O5CUQKEA3vfI8bOCCkTuh3S0TKN4wF8F2D/Py47VH/tXWxu5KKYOhq?=
 =?iso-8859-1?Q?YVKiDDrgl4QTyZW08AkSzm7Tt1U3RWKTeXsdJXMK8nE+Pfu5mUcCECFJHr?=
 =?iso-8859-1?Q?sNrUMrmj61yTAgWNdjPJSp5cZzwBngQ5fKanFULI1vl2Z9+M8HCguoWOXA?=
 =?iso-8859-1?Q?A7H2MQU0oRkt/fWC8rSi7T0VxOyHedM8hJS6jiym+hysF4h6/rodKN7Png?=
 =?iso-8859-1?Q?BCvssNOxsVZXuFY/csNZElJOPw/h9aUGh6cb1AuloaNZ041mPP68TWP32+?=
 =?iso-8859-1?Q?0w9LGjZOhH59RS+X4XeOGQwUqzeH0yGbHGLUMWNRidI/dQ8SvPc7WPy2xg?=
 =?iso-8859-1?Q?UiFbtmfs+eAWgYv3xWMZVWJkvWotn2Qx2Ne1Lj6YQwdJ0gvuDGXa+4Vw72?=
 =?iso-8859-1?Q?n2rArz5OqOrMjm13vNcXX6j42cNioCS8WdDd18AMMmhcmskd1dl4rOte+E?=
 =?iso-8859-1?Q?v44no2BUQL5LkAqBe2pWFhmxxHtSh/7dbR/pT2ZNe+vAglvL8BWC1fR6n+?=
 =?iso-8859-1?Q?bmXR4elffnn5RxsQH8ZuQ52lBTrJla4uQSSRKFYsOTkmjwD4R27FuBdlJJ?=
 =?iso-8859-1?Q?jZcHtJEeWYtW/5GCagxAQLsc1vUHYuzAucQWPQvzRsYxO88UijsuvMfPkI?=
 =?iso-8859-1?Q?miIrWCl9xqQ9A6udBh6y+EplN+4aMMFm1/xDFs6F3ypzv6WJigSZ+ln9Ws?=
 =?iso-8859-1?Q?qoJ672K+/o0px01unbWojdpTqag6B94Ilg4Vxg2dhHQX8U5MP1hMFouriQ?=
 =?iso-8859-1?Q?255g31uj/8qUsMOpX5Gx+wDt5YtVRuX/AfF2euPj2uDOSDJrtWKiPtS1fI?=
 =?iso-8859-1?Q?uZRNQMaqpIBJUutF4jPdhCZnGvtyMh90zaCOSokwS1DjI+VEAGujg5W8lD?=
 =?iso-8859-1?Q?BgkpGqSNtap0UTL9DqNgZCBudYE7zxQmZ9KBC8/nxUKzT/bUVvSqzte+aQ?=
 =?iso-8859-1?Q?jz9HZ/VUmWM655pWB1/Zq2W6GM/LtOXdaijIyde5TEpm1TEbUI5xmOtJSU?=
 =?iso-8859-1?Q?b6g8D37tFU3BAwVfNUu4w3wR22OkeyGAvtyaul1g0e6EoHFaargqVzpGvR?=
 =?iso-8859-1?Q?ri8FpaqNq4vZFnetO7T4XtxWPfiUriYe4RxFEFHUBsvuyNzXudX2Q6Ew?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e74a85-5732-4cc7-fe6f-08dc8a4e1ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 19:38:44.3085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bsQV1oKJPyHikjjNDhID4GYBtgdziLLku99ASfTCl7wbIG4fVSSj4ZX0keWlIT5FOcqufzhNs8McWJvtMa3cvbNSRXHIqV3SBjdKBoY3cHwznzLxPM5dZZMd8s8fyhew
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR01MB6323

'vmap allocation for size %lu failed: use vmalloc=3D<size> to increase size=
'=0A=
The above warning is seen in the kernel functionality for allocation of the=
 restricted virtual memory range till exhaustion.=0A=
=0A=
This message is misleading because 'vmalloc=3D' is supported on arm32, x86 =
platforms and is not a valid kernel parameter on a number of other platform=
s (in particular its not supported on arm64, alpha, loongarch, arc, csky, h=
exagon, microblaze, mips, nios2, openrisc, parisc, m64k, powerpc, riscv, sh=
, um, xtensa, s390, sparc). With the update, the output gets modified to in=
clude the function parameters along with the start and end of the virtual m=
emory range allowed.=0A=
=0A=
The warning message after fix on kernel version 6.10.0-rc1+:=0A=
=0A=
vmalloc_node_range for size 33619968 failed: Address range restricted betwe=
en 0xffff800082640000 - 0xffff800084650000=0A=
=0A=
Backtrace with the misleading error message:=0A=
=0A=
	vmap allocation for size 33619968 failed: use vmalloc=3D<size> to increase=
 size=0A=
	insmod: vmalloc error: size 33554432, vm_struct allocation failed, mode:0x=
cc0(GFP_KERNEL), nodemask=3D(null),cpuset=3D/,mems_allowed=3D0=0A=
	CPU: 46 PID: 1977 Comm: insmod Tainted: G            E      6.10.0-rc1+ #7=
9=0A=
	Hardware name: INGRASYS Yushan Server iSystem TEMP-S000141176+10/Yushan Mo=
therboard, BIOS 2.10.20230517 (SCP: xxx) yyyy/mm/dd=0A=
	Call trace:=0A=
		dump_backtrace+0xa0/0x128=0A=
		show_stack+0x20/0x38=0A=
		dump_stack_lvl+0x78/0x90=0A=
		dump_stack+0x18/0x28=0A=
		warn_alloc+0x12c/0x1b8=0A=
		__vmalloc_node_range_noprof+0x28c/0x7e0=0A=
		custom_init+0xb4/0xfff8 [test_driver]=0A=
		do_one_initcall+0x60/0x290=0A=
		do_init_module+0x68/0x250=0A=
		load_module+0x236c/0x2428=0A=
		init_module_from_file+0x8c/0xd8=0A=
		__arm64_sys_finit_module+0x1b4/0x388=0A=
		invoke_syscall+0x78/0x108=0A=
		el0_svc_common.constprop.0+0x48/0xf0=0A=
		do_el0_svc+0x24/0x38=0A=
		el0_svc+0x3c/0x130=0A=
		el0t_64_sync_handler+0x100/0x130=0A=
		el0t_64_sync+0x190/0x198=0A=
=0A=
Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>=0A=
Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>=0A=
---=0A=
 Documentation/admin-guide/kernel-parameters.txt | 9 ++++++---=0A=
 mm/vmalloc.c                                    | 4 ++--=0A=
 2 files changed, 8 insertions(+), 5 deletions(-)=0A=
=0A=
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt=0A=
index b600df82669d..9b8f8ab90284 100644=0A=
--- a/Documentation/admin-guide/kernel-parameters.txt=0A=
+++ b/Documentation/admin-guide/kernel-parameters.txt=0A=
@@ -7245,9 +7245,12 @@=0A=
 =0A=
 	vmalloc=3Dnn[KMG]	[KNL,BOOT,EARLY] Forces the vmalloc area to have an=0A=
 			exact size of <nn>. This can be used to increase=0A=
-			the minimum size (128MB on x86). It can also be=0A=
-			used to decrease the size and leave more room=0A=
-			for directly mapped kernel RAM.=0A=
+			the minimum size (128MB on x86, arm32 platforms).=0A=
+			It can also be used to decrease the size and leave more room=0A=
+			for directly mapped kernel RAM. Note that this parameter does=0A=
+			not exist on many other platforms (including arm64, alpha,=0A=
+			loongarch, arc, csky, hexagon, microblaze, mips, nios2, openrisc,=0A=
+			parisc, m64k, powerpc, riscv, sh, um, xtensa, s390, sparc).=0A=
 =0A=
 	vmcp_cma=3Dnn[MG]	[KNL,S390,EARLY]=0A=
 			Sets the memory size reserved for contiguous memory=0A=
diff --git a/mm/vmalloc.c b/mm/vmalloc.c=0A=
index 45e1506d58c3..3827c4197522 100644=0A=
--- a/mm/vmalloc.c=0A=
+++ b/mm/vmalloc.c=0A=
@@ -2055,8 +2055,8 @@ static struct vmap_area *alloc_vmap_area(unsigned lon=
g size,=0A=
 	}=0A=
 =0A=
 	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())=0A=
-		pr_warn("vmap allocation for size %lu failed: use vmalloc=3D<size> to in=
crease size\n",=0A=
-			size);=0A=
+		pr_warn("vmalloc_node_range for size %lu failed: Address range restricte=
d to %#lx - %#lx\n",=0A=
+				size, vstart, vend);=0A=
 =0A=
 	kmem_cache_free(vmap_area_cachep, va);=0A=
 	return ERR_PTR(-EBUSY);=0A=
-- =0A=
2.39.2=0A=

