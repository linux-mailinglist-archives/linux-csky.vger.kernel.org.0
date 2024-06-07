Return-Path: <linux-csky+bounces-509-lists+linux-csky=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FD98FF8BE
	for <lists+linux-csky@lfdr.de>; Fri,  7 Jun 2024 02:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788B2B2146D
	for <lists+linux-csky@lfdr.de>; Fri,  7 Jun 2024 00:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3119223AD;
	Fri,  7 Jun 2024 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="U6saFYOZ"
X-Original-To: linux-csky@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2120.outbound.protection.outlook.com [40.107.102.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653FA10F4;
	Fri,  7 Jun 2024 00:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717721185; cv=fail; b=izJfr8S6UxdLFW4JJ961BPudSJsnwxUZk7tSZjPwHx4J51dwoWWeRGlw5K4HuGB7Hww/woI+GP3cfhGc5LxEeAFFdZLuD1yCtRwhkz5WEk40TM3GGXwHM1ow2YLLxkl7jP6YoXeUBoKU0tCOOZ3zNlNvsHu2pNBo5Ep3EZslJq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717721185; c=relaxed/simple;
	bh=GIO1Vgq+lPhs+fKGVp4gFfcxXPGyClCdkydFtF5PtLg=;
	h=Date:From:To:cc:Subject:Message-ID:Content-Type:MIME-Version; b=VDNUxlsCUNuJzb3Nj9dGxnUbO85C8ZqyCrQL1Axw0qbpazfofvYIBlyt/1rZWRjes113L4AY8NpOeW4ivMvcRWcW89S0O/HIR8ke6GgawxJZFDJd6h7lxf6DJdlaESCES2QKMLQFRqHNPwYPkJKpyfq6HiFfSCIpNoFxUR+sxOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=U6saFYOZ; arc=fail smtp.client-ip=40.107.102.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxUlKDQ21chwOMMtwAoCdqUDnCdlBvrIIF/95lMQSD5voSx8g8TcwiWU1FOW9uzu+Lhj2ID/HdxCv2x2660PR4bE5DfSaxP7vxpjtnY2Ir3O2EFPBWRa+hFyj0wrvniaZj+plXiV+YfCMsYJ0pR61q3VF8lDKTGk7KfsGFXo41zriYlsvsvfnJHmiyuwzgjQLzktBRkIeZpF4+bXTkOX1kJuVGZrL4Cxt8Z57Y05QFBJZ1waFkF7AiBaBjW3fxoCeriP55wNAdGc9N5sDKh7epPOfQQh2xsvz5UrYDTwEPPX0GgUbZ8pp0XdISS1afolzUDCHZhXEmGiwR0cQ7/99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+c4NPeknrN2huAh8WNjJOicmesWq/xGWo+NXuaddLr0=;
 b=OMlp+57Iy5F1w/WRfraim5A1IQnw+qENbJ76NLHM0fWoKaHgmMEmWfqJZMCpOgxdiPe2NdUsQ7UI5q0ATfvWMivl3mDSaA9P5sbWtG4M/+sFM17cvMBKXhuaPETW/VsWx9+VN3boOw8L9RP2L9qBMUssSYWwz8Tj6UB5VE1ZQUQsisJMNTMtv2heI7juHNHWv5ZWTlUTE4o92YPfxiScFT9cXtpSH/gKjaNXK8pZ1hYjzDSVZ8bVc8zEGa7E/7O+k+UnuYZhJGsx4jJy+nNK4GvpKwIAdJiTF7kN/IUTkmMFr0m/rG7SHCGb8KDk2Z9szEEZ6AOO1UjtGJFIzLGYZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+c4NPeknrN2huAh8WNjJOicmesWq/xGWo+NXuaddLr0=;
 b=U6saFYOZEh7baQKvXuie1Mnr8oAy6LHNbd3ztQYU5XSv1ZpGMGjCUaIRLC9YvT9kkZWJ0aFa/tWpbnS/uVtJVwz89zZq9gM42AmRFB9ZVKUbrvJpaXSsVg9I+4IoB6W9z7G+CDgJ2TPr0IEvil2QvgwP1vYcsz8MwiOSeFh3D+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from MN2PR01MB5902.prod.exchangelabs.com (2603:10b6:208:18e::20) by
 LV2PR01MB7791.prod.exchangelabs.com (2603:10b6:408:170::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.21; Fri, 7 Jun 2024 00:46:21 +0000
Received: from MN2PR01MB5902.prod.exchangelabs.com
 ([fe80::1a99:8110:f593:d3f5]) by MN2PR01MB5902.prod.exchangelabs.com
 ([fe80::1a99:8110:f593:d3f5%2]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 00:46:21 +0000
Date: Thu, 6 Jun 2024 17:46:16 -0700 (PDT)
From: Shubhang Kaushik <shubhang@os.amperecomputing.com>
To: ampere-linux-kernel@lists.amperecomputing.com
cc: linux-arm-kernel@lists.infradead.org, cl@linux.com, corbet@lwn.net, 
    akpm@linux-foundation.org, urezki@gmail.com, linux-mm@kvack.org, 
    guoren@kernel.org, linux-doc@vger.kernel.org, xiongwei.song@windriver.com, 
    linux-riscv@lists.infradead.org, linux-csky@vger.kernel.org, 
    linux-arm-kernel@lists.infradead.org, willy@infradead.org
Subject: [PATCH v3] vmalloc: Modify the alloc_vmap_area() error message for
 better diagnostics
Message-ID: <8a4c62ea-f0be-1644-5c33-18072c1c82de@os.amperecomputing.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH5PR02CA0013.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::27) To MN2PR01MB5902.prod.exchangelabs.com
 (2603:10b6:208:18e::20)
Precedence: bulk
X-Mailing-List: linux-csky@vger.kernel.org
List-Id: <linux-csky.vger.kernel.org>
List-Subscribe: <mailto:linux-csky+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-csky+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR01MB5902:EE_|LV2PR01MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d1a9c45-7ecd-4b0d-beef-08dc868b3fba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|7416005|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l1s5J75cs4gYncDi1/bzt0PWYudntMQmape9BpR3acyLuMVJa3cRcdq2Bkl/?=
 =?us-ascii?Q?VEurZWYub2g/4XJH58oyLIqZjDiW1hTHwdI5tPOxLlhQfxk1c5lbMfPXJg+t?=
 =?us-ascii?Q?vYojuAZ9HssIyTi/5174PDhVaurMYGbMj96+4WDuSHZZ/MqL6eaY8ABOuI0c?=
 =?us-ascii?Q?U49W87jVwi3fWo9nBPlICnbBcZ8NwDItuvCdwY1NpaW94lXpiLfeVp7gS6NF?=
 =?us-ascii?Q?bCz2mXearZyEkt32nA7gWhD7wmy2ZUZtu8Rl2mQ5MzCm32Ah5QGsGLyibfbw?=
 =?us-ascii?Q?md2wKx2oqhsnIi0mr1D2XZ2BvhyEXIhqWhbnh+WCOKEFNW8hhw02Y2hO2NPr?=
 =?us-ascii?Q?COHbzt4a2w2+++dXDKiJVptX6w5ySDp61PcQfkpLefq+BxOtvkskty4JU/7H?=
 =?us-ascii?Q?vrYPJNmLF3FLbwloYyr72SXBQ3qfehIfUFchkcV/t5gC1E5/b81h5YtKHIpF?=
 =?us-ascii?Q?eQ2PzD9j3Js2xzfSwawh678CW5+Rn6QfNs5dar8IED2NTq4vibv8LO4hRHaQ?=
 =?us-ascii?Q?ljVaTf+ttRy1czc03C7Q2mMTPu7b9LLgPHCaKVDG38b/+1N0oLQx0HORpnxm?=
 =?us-ascii?Q?/WYcSBpmaQ8PNszD+TdSdb7LxhPBrEO9+ufK/DLYLpI9314tvVrnbdTQ+8sB?=
 =?us-ascii?Q?ZoPtPa/+3/QLUNDm6ctEeiOZB7wj7rmpcwVvg1Ia/2peu9NBUx9BNBxRNUJ+?=
 =?us-ascii?Q?GpEPUN3NUlA0Uboyi2zmmBB1dMjU2J9l+vLl0Omih2wxcpY8Pk5tvwwAKjsM?=
 =?us-ascii?Q?u0amYQ/puouLIOOGSO/EbTKv8bQvOV4fpe815AeaqUmTnng+/uaVKK/F//hH?=
 =?us-ascii?Q?9UsFhp5c7MRYhLx1VVtWJ3ayMi1Dh7Z7zmLP7zy8fjIK4a5CXEb8av+aRvB6?=
 =?us-ascii?Q?cFttrbInrg3fZOzusR0R/3GBGrOoXbwD+Jhb27eMbBCgwPGmGx1zOHkyOl7u?=
 =?us-ascii?Q?iw6k3QHRKoTM5SCcqqgx9KMRWQKJhR5C8/TcoLXFse/z3oh3NWRUWPe4r0hI?=
 =?us-ascii?Q?sir+69+8g7BqcEe2vQtJNdPp7KKVgN+4aXLAsYzgNjMPPD9c9X3td7TfLl9g?=
 =?us-ascii?Q?NwjhQTCUH4eTDC+wnbUpuJJBEQMRuZ0CnxhNwHqnile0L5hhyLYdyM+Qgj+8?=
 =?us-ascii?Q?kqAajGtDsykmN52u2h3fjzhRdao5rXBaXyZOjYZxN2ebsN/GLFJUQw8tvQ70?=
 =?us-ascii?Q?gvPAaxUIyY4P5F9daOiX1eCSUgU6wpSCvYw0lLxJeqsZ7saZsjO35IiX9bbi?=
 =?us-ascii?Q?gop3DetpNdd0xacz8tWoYyuqg5SIZeJBkk177OXhi1SMvgIJtk92U2SYDL8u?=
 =?us-ascii?Q?WhjykQD6j/7nTKzCEI2zftok?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR01MB5902.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?izkao55Uf7BQofY/BCUlM+6N5BbSpnumao5nWpxv1qqAvq46sdBmoZH06cSa?=
 =?us-ascii?Q?5eQzxTm6Cg2ege9vMYPzJZOQKoy75hNK/HZ+Nw3zXeQ47C1AnWRZiKwxOY7O?=
 =?us-ascii?Q?XijgXStc+I6BTA/FSx+1ZoPDMalRhgplbEnX3EdxaiOfr+6OZcACavDq+auH?=
 =?us-ascii?Q?PXpzB5UIFh/k44itQJfI4Q+nOcBHDpgQ5NLEGp42q9m4Fzm7X1RA6o7EWNDp?=
 =?us-ascii?Q?megI8YzFRt2r8ZtkIbS1JSrtU+WkvjQ79ahQfex4PXgqIIg5va7REWxnmkN8?=
 =?us-ascii?Q?MipjWeuuohNYSxjweI8xsNBJ22L7OlQXzMLd5fqYBRskunE/FHp3ChgEnWBO?=
 =?us-ascii?Q?6gDqBdZaKxHskxf/DH6r1DqLDTS13B0a8CyYbSPdMKKlEnXg5lvIUMnbd5Mi?=
 =?us-ascii?Q?JDw9Z4c4vsAZCAK2E/Am0OaMSbaDxlOmVT2zjqkQ0OGMk4Grd84gaixSZL59?=
 =?us-ascii?Q?tB4csqH2NoR6DXWvdvo45yGcKi3xo0LxOTqgJvnxRXl3FjSNbcOB2+NphaUm?=
 =?us-ascii?Q?ltq8g5blWTx04W7h34iXuzzHSpXxpUF54nWSvKaVKSNF4fnMIC2VIg+CmFnV?=
 =?us-ascii?Q?9/DiwIOfaHWsUPc4exHQhnLvsfEoDSCTTim33vSNrVrninGvTz5u7iOUYViN?=
 =?us-ascii?Q?0aLZtnB9HCeAizgbcIqvWKhp300PvUqIdRXYjrk8IR2yrpn71QtBz/6B8e+U?=
 =?us-ascii?Q?yU+rbXjetuN6lUkMFOBK2e+xlDYo4NLoEJ0JMmJ3LIDue1FrGIlQyeOncmP9?=
 =?us-ascii?Q?Q9OfZWh+1DTK/I9zViVMy1z2TukrEGttrFgMhm3azSQk2VRtGL2uN6olPm3x?=
 =?us-ascii?Q?cmXccxFdGMybuGlU3BQeGIfcH9pVJq6gmw7Nby7NkRZ2mrZrSa8S6rzyGa3x?=
 =?us-ascii?Q?tSDsgw/YVMZP8qw8roz2omdu1TGXpZQxIPiV7wc/1o9tLhml/vNBbG9U6s4H?=
 =?us-ascii?Q?OtU7uWwSntjGsl8c1NnMz4C4eHiGBrzh/eSycutYtpVMYEBurnwm5yRArcAl?=
 =?us-ascii?Q?Zvz88iS02rGQm5Be1f3M6WJOj1tIrDZGdfv5UurrvsKbFsgYvSR5Zf8BdzRT?=
 =?us-ascii?Q?Inr5gqlhpQhCmMfK6ZETsgIIhGcIA1If0mtJgCqB6RVoiIgIERg1NP/I/xi6?=
 =?us-ascii?Q?/00MPhSXpv7MkD7wEQVgwNIzT6033edatPbJEggZYFMR/OeeS2+kE3cQ7vKp?=
 =?us-ascii?Q?MweRCI3Mpz5kKo66EouwnAIESlyRltzVPJPKwT4fbX15jH9EubypzNBtwM3H?=
 =?us-ascii?Q?A/79v9Ou/UfBItGiOKlN7miCXHLWcFoXkgiI+eDuDKMWKs3fRIbinYg/OxwO?=
 =?us-ascii?Q?d5pEua9wSFR7Z0qqCP1FQtB+79V4yxmQBzTY8iiGfupIpjHrMIrGdEUgfsU4?=
 =?us-ascii?Q?yedFvxYcEQxoesGHPPmSOj/JOieyr6iuhcLDCQzSVEGR8iWM5VYKQuJXnCkr?=
 =?us-ascii?Q?2WQLrOpW4FH68M35yHfzYrrolWtP8RiTVn7O630DqAKTsI4H6VGDBqVZPL/X?=
 =?us-ascii?Q?P+l+ddSK0Z163qHNYm9e1OgJZSrHKL/3WwwbwJvnTCzXadksHanYrBwhe+Rs?=
 =?us-ascii?Q?hLvWBRllBXe03/8Ia6EbkV+tBt3E1q0JQlmoL9++Bg9UCOGH4C5u9wiJ8YM4?=
 =?us-ascii?Q?++bDZDp+18q4AopEJdzXtzc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d1a9c45-7ecd-4b0d-beef-08dc868b3fba
X-MS-Exchange-CrossTenant-AuthSource: MN2PR01MB5902.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 00:46:20.8981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lj/cIcvztlQFZ3YVCAJMVR8nClPhNA4r7cFYIpjvjvldwsNSweIE+sKvIr0oI5TZltgx+PRw/MI2jxxeFEX1AJDBRaED6+PUzNj2Sydy9CFsAKb1wqqN5HOb3WIesEQK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR01MB7791

'vmap allocation for size %lu failed: use vmalloc=<size> to increase size'
The above warning is seen in the kernel functionality for allocation of
the restricted virtual memory range till exhaustion.

This message is misleading because 'vmalloc=' is supported on arm32, x86 
platforms and is not a valid kernel parameter on a number of other 
platforms (in particular its not supported on arm64,alpha,loongarch,arc, 
csky,hexagon,microblaze,mips,nios2,openrisc,parisc,m64k,powerpc,riscv,sh, 
um,xtensa,s390,sparc). With the update, the output gets modified to
include the function parameters along with the start and end of the 
virtual memory range allowed.

The warning message after fix on kernel version 6.10.0-rc1+:

vmalloc_node_range for size 33619968 failed: Address range restricted 
between 0xffff800082640000 - 0xffff800084650000

Backtrace with the misleading error message:

 	vmap allocation for size 33619968 failed: use vmalloc=<size> to 
increase size
 	insmod: vmalloc error: size 33554432, vm_struct allocation failed, 
mode:0xcc0(GFP_KERNEL), nodemask=(null),cpuset=/,mems_allowed=0
 	CPU: 46 PID: 1977 Comm: insmod Tainted: G            E 
6.10.0-rc1+ #79
 	Hardware name: INGRASYS Yushan Server iSystem 
TEMP-S000141176+10/Yushan Motherboard, BIOS 2.10.20230517 (SCP: xxx) 
yyyy/mm/dd
 	Call trace:
 		dump_backtrace+0xa0/0x128
 		show_stack+0x20/0x38
 		dump_stack_lvl+0x78/0x90
 		dump_stack+0x18/0x28
 		warn_alloc+0x12c/0x1b8
 		__vmalloc_node_range_noprof+0x28c/0x7e0
 		custom_init+0xb4/0xfff8 [test_driver]
 		do_one_initcall+0x60/0x290
 		do_init_module+0x68/0x250
 		load_module+0x236c/0x2428
 		init_module_from_file+0x8c/0xd8
 		__arm64_sys_finit_module+0x1b4/0x388
 		invoke_syscall+0x78/0x108
 		el0_svc_common.constprop.0+0x48/0xf0
 		do_el0_svc+0x24/0x38
 		el0_svc+0x3c/0x130
 		el0t_64_sync_handler+0x100/0x130
 		el0t_64_sync+0x190/0x198

Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
Signed-off-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
---
  Documentation/admin-guide/kernel-parameters.txt | 9 ++++++---
  mm/vmalloc.c                                    | 4 ++--
  2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt 
b/Documentation/admin-guide/kernel-parameters.txt
index b600df82669d..d98df8f5c448 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7245,9 +7245,12 @@

  	vmalloc=nn[KMG]	[KNL,BOOT,EARLY] Forces the vmalloc area to have 
an
  			exact size of <nn>. This can be used to increase
-			the minimum size (128MB on x86). It can also be
-			used to decrease the size and leave more room
-			for directly mapped kernel RAM.
+			the minimum size (128MB on x86,arm32 platforms).
+			It can also be used to decrease the size and leave 
more room
+			for directly mapped kernel RAM. Note that this 
parameter does
+			not exist on many other platforms (including 
arm64,alpha,
+ 
loongarch,arc,csky,hexagon,microblaze,mips,nios2,openrisc,
+ 
parisc,m64k,powerpc,riscv,sh,um,xtensa,s390,sparc).

  	vmcp_cma=nn[MG]	[KNL,S390,EARLY]
  			Sets the memory size reserved for contiguous 
memory
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5d3aa2dc88a8..75ad551e90ba 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2055,8 +2055,8 @@ static struct vmap_area *alloc_vmap_area(unsigned 
long size,
  	}

  	if (!(gfp_mask & __GFP_NOWARN) && printk_ratelimit())
-		pr_warn("vmap allocation for size %lu failed: use 
vmalloc=<size> to increase size\n",
-			size);
+		pr_warn("vmalloc_node_range for size %lu failed: Address 
range restricted to %#lx - %#lx\n",
+				size, addr, addr+size);

  	kmem_cache_free(vmap_area_cachep, va);
  	return ERR_PTR(-EBUSY);
-- 
2.39.2

