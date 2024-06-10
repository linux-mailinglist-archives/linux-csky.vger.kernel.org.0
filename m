Return-Path: <linux-csky+bounces-510-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBD89027A9
	for <lists+linux-csky@lfdr.de>; Mon, 10 Jun 2024 19:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66C292847A1
	for <lists+linux-csky@lfdr.de>; Mon, 10 Jun 2024 17:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA17145B38;
	Mon, 10 Jun 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="dLjggEF9"
X-Original-To: linux-csky@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2093.outbound.protection.outlook.com [40.107.96.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA358145354;
	Mon, 10 Jun 2024 17:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718040184; cv=fail; b=SGNgwZuz8IeOOnMHu/k9qqcq4yjM7fDQ/1IGZu7LNmxjZPVLseakoJm4327uWYDB8oE0V/CZTbuYvy5L1LFDQaJb6Es594PzTBIMcbYqFC4uuQl6LXoDo/j2fFjm3P0Eqxr+8I4CUAdigRpCRjhUE4ZulHnaLPhddYeXCg3zQMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718040184; c=relaxed/simple;
	bh=4gsZbbfVCbzzmlCk4XO0fdaIE+nOOpRf3ZaAR9zasN0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DVWMDe3kM5TLRb3lQFcSszO6qH04K+qrzQ82KF1VAFfEvdjWWHdXN2b8twR8fHh9TJUXCIqvaZ6mH5zQrHTmIUxPhW+Xp7GKPgQpJW3RAUteyg7zKrh5zProeWHq9LuoOzDPSibVaQHj2FVBMpfx6pTijQ0dp7tOKVljA6MnSxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=dLjggEF9; arc=fail smtp.client-ip=40.107.96.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJ7ZzRdZfh8pSg1ASEI39qQ1L0RmBPaOgtOSG9sUEphW7oYlMv4aBIEZ73wNwHLri/URG5tbAulXDZiMwRnkpgF+3AIqsSoroZIyX3+Omr1KP+H1wraiLRpu5RlE9l5FclOrJTQuTf0HV1tznP/P4S71dG2xcgdSrJ7deYjfS4caK7zJ80t6febIc7YdUp42fG9mEHj9P4SLXQBOOu7dg0EIIZKwQ/RH9WUdhLkJMY6ivUsu0PpqGDK4TD80QPgwaqY27yZe+EVQbihAdQfILJzYWSobM5GlI0EGPCEX/G74QQ4HfYzJX+U8YS2/Q42WDHWkPou65/rVzd/w+nzm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+c6LagmdiEVsHOOIiSHgCKcSy1gzHN6s0iVEnwzCwE=;
 b=YxhjuRvA/7p92FUBGPRDKUDy21TLoSmZl7lH5pu9la9Di9WkKW5wXetJyKvKok7fLF6cSQgrJiqNzydKih1jWL90eiL2eHp7uP3VyfyUJ3poH9MpWVGQMchjOvjYnFDxKAR+QA3504tuI7EXj9xqNoMOZdDpjzdcFIZdP4bR6JPfAWitYFgDNuS81FBWzKMCgYwFUXBlgnU6oo2p1bjuj9BSzECnja4XpyZJKJTCzTaVazFsg9usHV4YUb5tpKYPpubmt0NdoxQoSnGqRvSKEcxtqIel8BaKbNccAUkw1DbMvWbu6TEiB+eoBFrWebmHDx3HcQs/qf6TOUF1cpKWlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+c6LagmdiEVsHOOIiSHgCKcSy1gzHN6s0iVEnwzCwE=;
 b=dLjggEF9EOsteEAtH23Bk2o4w25+yofXZ7IcqdatPLCta/2aazgkM2TzyzGSon4k/GFS1Qd4yTL85PIwRh+XcnN7iVm5V+1UPAmZbNdCPyeMXzfwNnufZMIW/i1Q9n+LTb9QcJ8RB8xLksR3E4m5CfUznFHauAJl1yLF0bdb8f8=
Received: from MN2PR01MB5902.prod.exchangelabs.com (2603:10b6:208:18e::20) by
 SA0PR01MB6395.prod.exchangelabs.com (2603:10b6:806:db::9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.36; Mon, 10 Jun 2024 17:22:58 +0000
Received: from MN2PR01MB5902.prod.exchangelabs.com
 ([fe80::1a99:8110:f593:d3f5]) by MN2PR01MB5902.prod.exchangelabs.com
 ([fe80::1a99:8110:f593:d3f5%2]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 17:22:58 +0000
From: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>
To: "ampere-linux-kernel@lists.amperecomputing.com"
	<ampere-linux-kernel@lists.amperecomputing.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "cl@linux.com" <cl@linux.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "urezki@gmail.com" <urezki@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "guoren@kernel.org"
	<guoren@kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"xiongwei.song@windriver.com" <xiongwei.song@windriver.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	"willy@infradead.org" <willy@infradead.org>
Subject: [PATCH v4] vmalloc: Modify the alloc_vmap_area() error message for
  better diagnostics
Thread-Topic: [PATCH v4] vmalloc: Modify the alloc_vmap_area() error message
 for  better diagnostics
Thread-Index: AQHau1SHksZ9UR+dPEq1NkWJFBdqIg==
Date: Mon, 10 Jun 2024 17:22:58 +0000
Message-ID:
 <MN2PR01MB59025CC02D1D29516527A693F5C62@MN2PR01MB5902.prod.exchangelabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Enabled=True;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SiteId=3bc2b170-fd94-476d-b0ce-4229bdc904a7;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SetDate=2024-06-10T17:22:57.847Z;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Name=Confidential;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_ContentBits=0;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR01MB5902:EE_|SA0PR01MB6395:EE_
x-ms-office365-filtering-correlation-id: ecbeb634-3c20-4ac0-5914-08dc8971f8f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?P4jxqVxOctQLZYDhY6Yxqnl88Fva457WV5f3rP3xRlHEaGeK6IJPYUcfyj?=
 =?iso-8859-1?Q?4gytQ/02VAQ3Ipbywh7jynaXLQG1A1S4U7ir2UFScVRybxZQpMcOFJAz5N?=
 =?iso-8859-1?Q?FDzOsL/6BQjZ502UVlY/YYWC7iTbn9o2li3HI6qNS9Zyouoo4JL7Byvx7n?=
 =?iso-8859-1?Q?9gpjwQJ/zNU+xiQJZkUYbgkI1dMD5E3ZkG2a2CO+T/vP4mjHV4SilDOhMz?=
 =?iso-8859-1?Q?RQQteeRv+4bQjFkWUTj6OPxaRlry6vjffKQgKPmRrUkswRTrNNIGJ9kN+w?=
 =?iso-8859-1?Q?HB7bQaWMpeJKqCxzV0jJOEwgQ7JAjVPODCKWBerXx+mGgP2kK/lBqffuVK?=
 =?iso-8859-1?Q?voKa7kIIJ7K73v8UR8r5mH/CLRG8hHfVOqNGGfKkuGXqUVrgyTJy/aN9ia?=
 =?iso-8859-1?Q?3h2WuaVf13EtkxvESPeYkOakiGMPylECA9DB06nZYMCc9Vv1ZF7oCKL55a?=
 =?iso-8859-1?Q?aVwE/SIY4nJ65yxR4ljXFUWMtJnjb+BdFHJv2tsFhwmbgWExn1QvfsWmJk?=
 =?iso-8859-1?Q?optbAQvkr/s/RE65wVg5IQU7ej+Vd3Ta5gNnRfTx3RZEwTr4HNN5U7DNfK?=
 =?iso-8859-1?Q?2do4rkDpk5I/92cpt6qpOldKz0sjqxtfw1dgZ9naDDZGhziyiVCBykSjgd?=
 =?iso-8859-1?Q?KViTyzGUUKYkuRnQd8tzfkQWaaQ7FmGtpXLqQJQ731PsUc9WPlsoei75cQ?=
 =?iso-8859-1?Q?VTTfvwx+1Fms2vCpHcBimVp8BOn+Hc05OyxsIWBxHCi+0Yp8/TBcEMp+9b?=
 =?iso-8859-1?Q?08mDKecG64IqzI+tulit4bnt8njzVSqG+a3MM/Kn281oU4NphsPR8r9sVJ?=
 =?iso-8859-1?Q?6Dvf/1JY7IJGmujWb8v7gUFChRiYHwK4+De2KH9b4eNCtJlKG4jJINamdc?=
 =?iso-8859-1?Q?O0sAtkKVsd1IYpteO9jpmmAlH30K2Bauoz8IWP63IGBWATb0ImlHimnxr1?=
 =?iso-8859-1?Q?QlKMeuJ/OBlj6RkfLNfGznkWjH88Ny8MxLbJZhmOTazwdhv+rrPzUDR6ic?=
 =?iso-8859-1?Q?QbT0VHrylxP3JsOpXHsjMAhUqTx7UtKu929EE8Wy4FPUqjI7SLZspyIsIa?=
 =?iso-8859-1?Q?WgZaC8a0CTORklzYY2l4YpHdOe1UTU+eFeREyw2cuYbVJ2JEyNhiBAQcQq?=
 =?iso-8859-1?Q?mVVXOBu9R4YOTaiFSiO008MopNvFFKj7I/C+KExx/GMkW2lygdXEPUQvTk?=
 =?iso-8859-1?Q?uaIKkNy0cnh0IMyetgDIYANXYwCRH3bDmOyrvUaNICXVqlgdNiyE7IbVSz?=
 =?iso-8859-1?Q?R3SNBEJ+8m5g42VTZapPGug29wdkpqMzi1Q/Ot8xgOhuuDgCoyJEjH7Js/?=
 =?iso-8859-1?Q?AiL6s4pLEP0uQFvZqWPJmbbuoHYk7GS3LXVb0f2E9zSTYdr0g++95paAPm?=
 =?iso-8859-1?Q?5pAGSbyinuYLQSDv2o4/DAb8YNN6UW1V2sDBtX0H75475EdDppu7g=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5902.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HCWoPIVniOGLxbYYgB+mHt0TPI217qjRjvAX9Cm834JMXN1b88KLReqb9I?=
 =?iso-8859-1?Q?L3zTpwN7P/OpC1t6Qbz2Xt2HPacybLrIhUj45P7KLng8QaaqRI/V5JliUR?=
 =?iso-8859-1?Q?E+3/SXIQ5zNOEfLXte2Jr0nrkgTXNfyHqNZgPvRoDgK8OIcjohaemwTgjJ?=
 =?iso-8859-1?Q?ykLkzpkr+AMYkWUVkYP7krKIaWNdatKqpU/eEQZw7xAsRzfOnhmW1DmFtI?=
 =?iso-8859-1?Q?/mNApw5uD4D70Z/LwP5iyLrxPN0/HMtEeD1y3XCOuvFEo8DQvMDcd7t5q4?=
 =?iso-8859-1?Q?hptQhlbaz8GSgXY7OKr/DH/ScXV3Nc6lp9a9IudyHs26X+r87sUattWajI?=
 =?iso-8859-1?Q?rAXFXMBiDF0Vv/2VyjTCoK0vNyVK+CZ96JPpF0i3rsnIrVY4Rn/g6e6aIR?=
 =?iso-8859-1?Q?sFvSWNFpQ8yun4fD+naZFL3JwyklombUW1sf7oH+eGQJd1TzAYrLsYGr5b?=
 =?iso-8859-1?Q?XFJS5SLr8cOehxxRXeSYEKqRjZ02HMaNWUYUI6rWDD7Ny8vjG1q0S2eC8L?=
 =?iso-8859-1?Q?QKjZB88t2D2YGPDTSmdgSK2cstwySCcYENgDPzS7F0cPWdpe+dpsOQ9Jif?=
 =?iso-8859-1?Q?p+LfPN1+oTg75Ooc7OPQtj99ietV1I2PdTW5T5VqqVD4hdsxgXyE6BkvRX?=
 =?iso-8859-1?Q?tamrrIgIyq0UkZplPCazDvQdueJhjs+tsY7mii7FAvgO/voyRtivBJxD3P?=
 =?iso-8859-1?Q?RgMptFDgK4MJMtfLEe/axTd2/m1pmINszexUWRIZRxhDpPpNWQT7bD+AQb?=
 =?iso-8859-1?Q?7t67mPVJJXG2kW3dLrCVE3a3Tv+l2p3nEiVFev23Kqv2yjp8lMDkno+bjH?=
 =?iso-8859-1?Q?hOUxMEHkyV5LVQ/v7Vyev5e/RspuXKjDzuqbdx61IaR/Bwsy1+u5xoDbqV?=
 =?iso-8859-1?Q?GbW8kd8QhxCXm2VYH4zWk38rgDmEIxLy3etWw8HkMs7BDsZ3j18SGEnH6W?=
 =?iso-8859-1?Q?OnPgKb159/ZZPXH7UoRb9CT31TWp5pRhKVQNXotslHFC0NJYd6QYNEkZXU?=
 =?iso-8859-1?Q?Nv6zVhQkGoEoI9d5104O2ToYZfVSwMyarzlnqNZD3biRtol3ZZY91sICE7?=
 =?iso-8859-1?Q?dUDw7mSqn23rJCcjRJrowKW2Fp9Zufhz3BMKPRqEw2PouaqvcLRFzpF62g?=
 =?iso-8859-1?Q?CQ30j0PoSnM2nQC2BbDLddYXtoh3UlJSe2ZCvYx8IlspLxKrynsiT6ji1V?=
 =?iso-8859-1?Q?sy1i4OI2qkK80a+++Ajq6au+0V/P1OmGHcmk8EGkKmsNPsce2J54ZZBFtz?=
 =?iso-8859-1?Q?QQprBeQSM/uq18n8jD0+3YR7MlpPzMNb20JuUhyKwgZfq0OlPNxLYtROkJ?=
 =?iso-8859-1?Q?eu00wKeNSQ6bLkntaZR1ASzVOmNeNKfA1hAqNhOlTkZjtZgGcm1JuU1xNi?=
 =?iso-8859-1?Q?HqaOG6gLIggGgkuxXJP1Kb8cpDU2VaXjm65+/x+eCGgEOhXT1xC1FZTRm4?=
 =?iso-8859-1?Q?/p+tTbbUUX6vrJhqaXzxcsQMxWUFim5l9XsbjM7QKV1RgpZ2cTMbNQHF6T?=
 =?iso-8859-1?Q?h8n1r6rGlcqgr7GjJdR3c2s/LnLnurujqfzdFSfkAowKhLlTV3LXhOcJ2/?=
 =?iso-8859-1?Q?FSzEGVPfUlXDnVVwAepKxuHYJ5mfR7Vc9/ZDQ4ex3T5ZfrQSYwkGNKiekc?=
 =?iso-8859-1?Q?bWfs55mGplVmVE90zXPfWejsZRVNjy0k6AKwsCDn/KKhlvUYqD+GTW2Zxb?=
 =?iso-8859-1?Q?74rWZTvsvoG7sx5x5Js=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5902.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecbeb634-3c20-4ac0-5914-08dc8971f8f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2024 17:22:58.1008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ch/HMRUw3blctu6DftJAj+cp18h0OWVQhP4lc55xp+Sb/mtFrY++JhT0uSvmtLQA+jqiwmDZaRaJCeHyp7ZhF/N3Ab/qdDzAIgRJFNpTyXHAisV7yTJ1BHh/vd76aOgY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6395

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
index 5d3aa2dc88a8..75ad551e90ba 100644=0A=
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
+				size, addr, addr+size);=0A=
 =0A=
 	kmem_cache_free(vmap_area_cachep, va);=0A=
 	return ERR_PTR(-EBUSY);=0A=
-- =0A=
2.39.2=0A=

