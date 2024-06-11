Return-Path: <linux-csky+bounces-515-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C13589042A2
	for <lists+linux-csky@lfdr.de>; Tue, 11 Jun 2024 19:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46C8C1F24635
	for <lists+linux-csky@lfdr.de>; Tue, 11 Jun 2024 17:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E9F5674A;
	Tue, 11 Jun 2024 17:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="NqPVNsr0"
X-Original-To: linux-csky@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2109.outbound.protection.outlook.com [40.107.94.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C912817721;
	Tue, 11 Jun 2024 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718127905; cv=fail; b=KZsJqcPWFbZWlD+Rns7A7trlhhM/BDwMnggss1BfoA0kTKQiMbbWokeJNGbxnhpqaj/JlJEE1Xiz9pGdEkP0vDbein8zvGmxrLOlb3/MgjcyiJT80p0vob6oo/jFllzrBIu49FytIQkZCLHUAo5/LXmp43iS2fvZFlCC0RN2qfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718127905; c=relaxed/simple;
	bh=a752+0UHrQG5WrJqWuuZdmUgtXVi2tqPCeDcKYNheSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JSfwzTNbxN2fNAflh8tAHK+wiHYacpBmlui5RILZuz0uTPfmHgV1yY493zLuXzUhTJ0HeZodWEU560qVQLBB56sYsfhVzamE98wkGvFtP/jSDz3fv9aokufjYxO1rF/t2vNYA1tHtc8mwd4dUfj03aj0hbRBw6YIQZV+WugnK34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=NqPVNsr0; arc=fail smtp.client-ip=40.107.94.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itoWIgSedjmUCYic/n7tDXK0uEp2Hv9yVI5oeEuN/L2GtQoa6bjFzXR+wxm9lXhLTDKRhwiwClCT7MXjzB2w6a1+6e4Y7RVajT5hU5DsYNXRjLKfviK5v7slqsRITJqDaxoNzUrEJ/gGsPPhKteNNuK+IXU/TtD0ZwblWKbX1beyOyupIThaXWuMg5KS+3ZpkAzBatxKQjtMoorwXeXQZ9y2tUAWS+7/QSM0HSGPlymzzhveFd43Z888o8Rt8Zlr+jXGGsc7TaPyWSegYqAo9CNbxCIiFwDSxXW+f8UJvFx9vHMiWdaQa4f7TfnBi52FQuU3RscpA0R5CVLeMj6RpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3c4VJ2trXzoTisN7eDrEjsMbatJN8TWjC9p8SbZ0cU=;
 b=YjkTkdaTM2CIKsgPRLlmyAWtCUJsnR03mv/C0N5widHdYHee+tJGd9CYibZTKguSUJ0dIYXfx6jiQ3jQuhgkQygSDzdSeHLc9ezLPIqcInd0mihvbjUJKDEvpz/DJfiTRkItu3Utdyl9KgB/O6ADVlx3WDuzpPP724cpbnekzt0E4bYm+LcEMN3kZvTkbU8BN/l5MRdIfQjc5FUsj3raCiU5sz6GWJlmGeUYMOFR4qwKO7zUnwmVelmf3YXCaaR1c1lKUwsX40yuEeQkLEGSk7MazGSz/NlcnQrnua/ZUGfu6JqcbwTjmEoFeS6nkRLwip4rHE95rZVygwjhyDeO2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3c4VJ2trXzoTisN7eDrEjsMbatJN8TWjC9p8SbZ0cU=;
 b=NqPVNsr0osas3ZW/KH0x3YVFcf6G2TyM3RMhWE8IpDiHtbfebTEAHMfVDwRltTK9xICetie8510LPhV5oPyK6o0FtUdiN1VHIrTGYua2Z9iGegnX5lW7lYdewg8eiwD/rUPBYgzmxOWtstj4E4wtgPs/BbMaGgGSbLJskYWaUG4=
Received: from CH2PR01MB5894.prod.exchangelabs.com (2603:10b6:610:45::11) by
 CYYPR01MB8611.prod.exchangelabs.com (2603:10b6:930:bc::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.37; Tue, 11 Jun 2024 17:45:00 +0000
Received: from CH2PR01MB5894.prod.exchangelabs.com
 ([fe80::b5cc:1692:8c7d:8beb]) by CH2PR01MB5894.prod.exchangelabs.com
 ([fe80::b5cc:1692:8c7d:8beb%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 17:44:59 +0000
From: Shubhang Kaushik OS <Shubhang@os.amperecomputing.com>
To: Uladzislau Rezki <urezki@gmail.com>
CC: "ampere-linux-kernel@lists.amperecomputing.com"
	<ampere-linux-kernel@lists.amperecomputing.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "cl@linux.com" <cl@linux.com>,
	"corbet@lwn.net" <corbet@lwn.net>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"guoren@kernel.org" <guoren@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "xiongwei.song@windriver.com"
	<xiongwei.song@windriver.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-csky@vger.kernel.org"
	<linux-csky@vger.kernel.org>, "willy@infradead.org" <willy@infradead.org>
Subject: Re: [PATCH v4] vmalloc: Modify the alloc_vmap_area() error message
 for better diagnostics
Thread-Topic: [PATCH v4] vmalloc: Modify the alloc_vmap_area() error message
 for better diagnostics
Thread-Index: AQHau+dprF4b1k9RvEeooQHbFQHPMbHC07Wi
Date: Tue, 11 Jun 2024 17:44:59 +0000
Message-ID:
 <CH2PR01MB58942C3696E4FD0181782F4DF5C72@CH2PR01MB5894.prod.exchangelabs.com>
References:
 <MN2PR01MB59025CC02D1D29516527A693F5C62@MN2PR01MB5902.prod.exchangelabs.com>
 <ZmgiPTHGy-kHNe5x@pc636>
In-Reply-To: <ZmgiPTHGy-kHNe5x@pc636>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Enabled=True;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SiteId=3bc2b170-fd94-476d-b0ce-4229bdc904a7;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_SetDate=2024-06-11T17:44:58.626Z;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Name=Confidential;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_ContentBits=0;MSIP_Label_5b82cb1d-c2e0-4643-920a-bbe7b2d7cc47_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH2PR01MB5894:EE_|CYYPR01MB8611:EE_
x-ms-office365-filtering-correlation-id: fb560eff-68de-48a8-df0d-08dc8a3e3710
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230032|376006|7416006|366008|1800799016|38070700010;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sfJ3o1J4A0PRsOUXXvDz5Rlbjxg+wmAvQatdTx1RnjrWchZtr+OcXkyd6WYM?=
 =?us-ascii?Q?sQ9tcQQQNDswBHrpe4uv4/baoV8ghQRz0CNtaztJ11bCfpmFPDvn/hatZqsF?=
 =?us-ascii?Q?zKF4ane8623YGFCWxAYcf8q1ENTrmmkKo4hLvuRYZmwpzdoku0voN82KwPBz?=
 =?us-ascii?Q?lAQNaTLGGH00xflG9z6Tjaj0agMCt9wwa1gMaMw9NldhJ2eo/49s4zBy8shi?=
 =?us-ascii?Q?5ucWoldqiSwi4AJ38oeEHklx9/Nn4uTD9m43aQbC2+LH+I6H7htZCHlASqHD?=
 =?us-ascii?Q?uwlXLWvLAaxv8UHjFbWMqzpS/CWfQ5EkybjFfRtaxXtA7YYfCX+gxIpg1YB3?=
 =?us-ascii?Q?bBu3k/OwYyfZjFHxFFXxWAfs9dmIzXzKm3AWt8smAuP4SGgctWDMIRNod30j?=
 =?us-ascii?Q?XZNABgwJshAQu5fy0uxd4bB9G2NIMpb7cRxHmaYelfbQZRr+1j8vtdU2AYNg?=
 =?us-ascii?Q?ry8qMzKXIdJDNiaM6rZTPuKFcquP94CzMqyLNnSOwS1VzhiLzEg3Jufq8lKN?=
 =?us-ascii?Q?gW87D1Vj3D89MtWTN3cIJVbXsbT8LZ7Qw2W/Z026Dp0Z8zoMXd+2F8Ws8NqC?=
 =?us-ascii?Q?Vlacac0u/KKDb3TPPNnzMURgfB5U9fqtCnbet+/yOFpvnkPWYROkg1C+b/Kt?=
 =?us-ascii?Q?flYfnJByx4Hus7Gc+ZaiR17adZ6qlG0hkA57CEKJ0ptk21FuaHV8z2gCkT/Q?=
 =?us-ascii?Q?Aj6T7qnADqfLD+kvhjvJ7QmqySVJ6oWk8PZ8hwG021xzl4ZiT8bfddAUaGmw?=
 =?us-ascii?Q?IaISSTXmuhRqOF86Y2wzcHcsQiYA8e9DoOxNO7T26jQh5/XQflzwwbIGSkrc?=
 =?us-ascii?Q?uWgvHb1QQZSJLCBiQHTLQjJ10l7ttIpNwAchicS6oDfayUzfvJcdwgXHbnFn?=
 =?us-ascii?Q?O4vbC3xY4JQldnjHcULDlncoUyLTcoSjMnyZp/hz5LtR53YFT5jzWRW6IL6j?=
 =?us-ascii?Q?rfFt6z4lm9G/aIFIyJE1ivrNy1b3xpiTC/wcVWfcn7FzyQoaHhzoZpKEMkOs?=
 =?us-ascii?Q?LASyfu9RZSSue9YlOJRixj/KY3AvxIvEqVGbI3KS1Jhe/Vx9hIXLZrDA01Y4?=
 =?us-ascii?Q?GxOydsNior6P+yjOojEvLdccN5ut/KHgVuAImdT4G3MCkdInWdiDwVV5d/yf?=
 =?us-ascii?Q?Wt3xXBT6eoTNiqPL9rmGlQ13Bi85Q/if70zeOyvik8/XXUTz4cvBELe07DOk?=
 =?us-ascii?Q?1RI8qXpbQommGa3jDxEdbB6v1XFjv/bbvnRZEBX3R8VV0T4MxEgRMEtjmDBo?=
 =?us-ascii?Q?n9GZ3uA2xAkBkFJ0DsJ0FFJzakowGfmCoK4cRwpLvIN4VMXQdVbqiTGadcpq?=
 =?us-ascii?Q?miRaD2AY3pDXgIUVklo48Ay2eWwUc9tEw6fQ2JZHNrHJ2HFdLvNJ0WwWndJf?=
 =?us-ascii?Q?wXdhwuY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR01MB5894.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(7416006)(366008)(1800799016)(38070700010);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?t6IAmVxi4jRYptJK2FKn4Ks2cfx7Ji3Sh7p+aVSLNHGcfvZegpFzaD6DM12+?=
 =?us-ascii?Q?Q99vJhrKIZqFXaJFKR0kLKoOVFaAyZCao1c4NdLk4McPu8EhQyPE4ycuvgpA?=
 =?us-ascii?Q?IBZB0TkYcqG0PggMDESGbYKQJTnil777Z0BOP0pieUMJZGaXXPRHvuOPrzqx?=
 =?us-ascii?Q?MUr8eMEpEE62HO7USgOirWMht9zwbIAT5/wquJeOAhpboOh+eeDLiWFtrb7z?=
 =?us-ascii?Q?zTqRMmz7htmNf3Tr1SY4GqJAm6KcQl+FxTZer6bteZboUuSkzxst5sHwGw9v?=
 =?us-ascii?Q?7829CjWDj0OSAN2q3XTL8IiAluPdLZ6cNntD5mBQbaoY9VBK8UalF/M/oqBj?=
 =?us-ascii?Q?ZCGWC0THeB0OJEAVlloxPVFkMOTVt36SKtBkByI0huh5iI2qCO1jZWuMy+Ox?=
 =?us-ascii?Q?74sVYGMLGG21qQkDWjUQW5JdnvRzivOElbHYl3AuzsEC/dMn/kTbgiv6w2DE?=
 =?us-ascii?Q?586vlcxiMWT9Pm4LlwdJ8CU58jlWT0Bh4umuOMYFXfBviFpS4dLO8wgb4AEg?=
 =?us-ascii?Q?ZWE5r+/YwOAX3M3mxK+nNknsDzK+23aI8lgZV3HEH8eAj7XqBdcPICeOk1pZ?=
 =?us-ascii?Q?/cx0eeiUbsrcasaA9tZNfbJNcUGneefsWQor3IaFt4vXkgem8ZuB0otmL/9J?=
 =?us-ascii?Q?pjs7WeshuYFvsEKeokpHdMussnt8Yu0a8EjDxbWLUSEjPbILbkXuaGNQfVZT?=
 =?us-ascii?Q?XIkE+0qFmiyUHrLwV4VPR+/zgsjC2aqJHbJejBd2sqTluT2AusMBpPFt1Plm?=
 =?us-ascii?Q?oOoJlIg0BI1+yImREuDIgTl1yv4LHCKi7X+vKzJx9+YMTTeHRM/FItF79w7D?=
 =?us-ascii?Q?kUxqDZ518bYGUXLG9fsvk1wH9ccA/TAFiGE58f8VTbYmFTSWjur2HWoJqy9/?=
 =?us-ascii?Q?VyduUQvcaXuMVz4Md160rILTvQ2XUusKrrQa/mySfB7jCF88LPq6wBjvEwUU?=
 =?us-ascii?Q?pTsbjZ7C2a5onz/Ur2ga0o3nccW3w+8K8hEQ/SZ8f6GsXvSj0VsUJhnYskSg?=
 =?us-ascii?Q?C1Vc6EvACqjlQ9bRSvddTDpcU4o5fjb0dLhh/FdMxaZCBHfxnV+SQ1tDikwS?=
 =?us-ascii?Q?Kq9WyCNdb6dngsVDt/4IxwJb4BgIbpMU6K8aNq6YQF+qk6rZPTNIq62XH9Rv?=
 =?us-ascii?Q?rcN5SRqs2encNbbe52TsBWuLxovVEvK9NgofRbo7HUBGpPW0bi3xKPNEhvAG?=
 =?us-ascii?Q?IcXkIMU0qvWcjM7Lobyb8KXfI2et2+CRDiFIsf1iFPMBcZ+TXtH7D1d90Dmr?=
 =?us-ascii?Q?XdEdAoywuoC4vBr6XTZ3damermInGLtGU2Ig5KzM0KRZ9j5d3kg3RI9vsNZ6?=
 =?us-ascii?Q?ZxlqdS5w9WPeHgOE5ZU5XcBqkStf9/nIRXE7fhL8kjylP5d2Ilb1139GhpEr?=
 =?us-ascii?Q?fSqf4GSz/Fs8CsMALkD2YcfYjyy8S+v3LPvhK2A4KWxbebXY9mh3Qz7DD5v0?=
 =?us-ascii?Q?Ibq7OO5PjsxMql1Yn9z4wse7tyuADAIIvf1/ERoM82KpNYJfBPqwl/RuGPyo?=
 =?us-ascii?Q?eM3I/IQIPV3uN+JzSjFUV2bVd52YxkQUcca2ac8tDjdyW7WfvDpfXx41UBbe?=
 =?us-ascii?Q?DnIPd1j/IuMUQpWML5mogL7OR0IT8KGNTUnjefcWEUoaf52R/LjZZIBFGu6b?=
 =?us-ascii?Q?+g=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb560eff-68de-48a8-df0d-08dc8a3e3710
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 17:44:59.5857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E0+fL0GhKdEV0UsPG+wu/YQAAMglIGP/0om2D1Ks5Dr5D/Sw7mf3YJ8hVOGLwFr7wwt3nIwVU1R8/wx70yB44sMmaY9kucE/+Eh+82dimYozbnEozAZcRiktQ0qfH817
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8611

This is intentional.  When 'addr' equals 'vend' the overflow path is trigge=
red, but then the 'vstart' and 'vend' values are not carried in the overflo=
w path - making them point to no address. That is the reason 'addr' is used=
 in the warning message to specify the restrictive range - that gets assign=
ed to 'va_start' and 'va_end' in the ideal case.

Shubhang Kaushik

________________________________________
From: Uladzislau Rezki <urezki@gmail.com>
Sent: Tuesday, June 11, 2024 3:09 AM
To: Shubhang Kaushik OS
Cc: ampere-linux-kernel@lists.amperecomputing.com; linux-arm-kernel@lists.i=
nfradead.org; cl@linux.com; corbet@lwn.net; akpm@linux-foundation.org; urez=
ki@gmail.com; linux-mm@kvack.org; guoren@kernel.org; linux-doc@vger.kernel.=
org; xiongwei.song@windriver.com; linux-riscv@lists.infradead.org; linux-cs=
ky@vger.kernel.org; willy@infradead.org
Subject: Re: [PATCH v4] vmalloc: Modify the alloc_vmap_area() error message=
 for better diagnostics

On Mon, Jun 10, 2024 at 05:22:58PM +0000, Shubhang Kaushik OS wrote:
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
>
> Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
> Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 ++++++---
>  mm/vmalloc.c                                    | 4 ++--
>  2 files changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index b600df82669d..9b8f8ab90284 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -7245,9 +7245,12 @@
>
>       vmalloc=3Dnn[KMG] [KNL,BOOT,EARLY] Forces the vmalloc area to have =
an
>                       exact size of <nn>. This can be used to increase
> -                     the minimum size (128MB on x86). It can also be
> -                     used to decrease the size and leave more room
> -                     for directly mapped kernel RAM.
> +                     the minimum size (128MB on x86, arm32 platforms).
> +                     It can also be used to decrease the size and leave =
more room
> +                     for directly mapped kernel RAM. Note that this para=
meter does
> +                     not exist on many other platforms (including arm64,=
 alpha,
> +                     loongarch, arc, csky, hexagon, microblaze, mips, ni=
os2, openrisc,
> +                     parisc, m64k, powerpc, riscv, sh, um, xtensa, s390,=
 sparc).
>
>       vmcp_cma=3Dnn[MG] [KNL,S390,EARLY]
>                       Sets the memory size reserved for contiguous memory
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5d3aa2dc88a8..75ad551e90ba 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2055,8 +2055,8 @@ static struct vmap_area *alloc_vmap_area(unsigned l=
ong size,
>       }
>
>       if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
> -             pr_warn("vmap allocation for size %lu failed: use vmalloc=
=3D<size> to increase size\n",
> -                     size);
> +             pr_warn("vmalloc_node_range for size %lu failed: Address ra=
nge restricted to %#lx - %#lx\n",
> +                             size, addr, addr+size);
>
One question. I see that you would like to see the range, i.e. its "start"
and "end" addresses for failure case. For such purpose, why do not you use
"vstart" and "vend" variables which specify a range?

An "addr" points here on "vend". Or is this intentional?

Sorry for late looking at this. I was on a vacation last week.

--
Uladzislau Rezki

