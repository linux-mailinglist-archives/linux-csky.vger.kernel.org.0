Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F8B53C9E1
	for <lists+linux-csky@lfdr.de>; Fri,  3 Jun 2022 14:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244281AbiFCMSO (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Fri, 3 Jun 2022 08:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244277AbiFCMSL (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Fri, 3 Jun 2022 08:18:11 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90051.outbound.protection.outlook.com [40.107.9.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2012657A;
        Fri,  3 Jun 2022 05:18:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ok9A7QL3kEXbfSYeobH/ZhjYKV/Pthq4qMVoElTD0O3pbRdN5EKQUv0UoY3fMqitkrGBHTXbPlngsk5MPwqcKj9TCtSkH6JMb38HUV7l/0iBACyPNBi8+yZJqhOs38bS2M1You2Iba+fkZbucUEpMjJHqckvei4BBAfB8hT/RZj19OT4DxaqYFtbuvsId98ugi6FAen/GVTXxbaKdxyevmasCINJ+Q8GnwMEpnsFEJ/d3ovrckIY+jDcJNIehbi5QmASUUw8bnoAkyUEJpTO4xrPXnkAIL6pmh64nGsSzHihu0dK2dFggZ1mEMLYcbNobf5/bnEJoOFPEZd+RT0zew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Q6lHtFZcNrAbc2wgFRBXVPn4IfamgIkBebQy9DixiY=;
 b=W9/TSZwpvI513rfmr1fdHuk8eMBHp8uPMHIVo5hwwOrAeeh8nVfOFlkaPHBvG2CqkyXvpr/H4FWgNEzCYoaDfTS8bUVZZviiz+I92QZEmnt8jRAQ1+5e6CqWNJS+GXSV/BV+dLsskIPOxtIUvfcPnpugF0LHnn7xHZcRL+52n7DdjNh97mbzhLz1X3mQHd2Ryyfv7z73LNnwXGfcawXTHmnNk0pDU9VEf3mjQSiz3GRjvY5v4ctcwsonlr8wsXKO1PIlZ4DGmuW44mZyTm9IsNHa2ibrzjlWzK8LDNK+xaKE4L5ngt/haCKSWTAnRYp7GzWe8yKC/7r1TGx7bGYjBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Q6lHtFZcNrAbc2wgFRBXVPn4IfamgIkBebQy9DixiY=;
 b=OevLhqgoMOcjASahgsuvV4toHQ5tWA/9TbM0CBVigpc5r42xscwCAdCJgAkxXtktuM1foggTkPAuQ/6NzlcowE0x0uYbMviMIkcIFBTMxhg2eoZqpToitu4h+mlFS6JV+9b/iOW7KZjSIUbiYOuUtMV8beMmyLVnFpKKvaxb17xWAqj04ll44wfRlXeGFSb9VT1TfObbLivHneF4RGIWy9m5jwhAQxYh4sfRvxOYF/t635h9eG9ygedlnB+UCQlBQGOsS7at4oWmSeYRcjq3Prky3W9MmOR0HZVbf2g0xu2vgExIWQ2u5mQQ2ft96LEAZu7Z5mhZogsB5oFhCEVVnw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2326.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 3 Jun
 2022 12:18:07 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356%6]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 12:18:07 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Jonas Bonn <jonas@southpole.se>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/6] mm/mmap: Restrict generic protection_map[] array
 visibility
Thread-Topic: [PATCH 1/6] mm/mmap: Restrict generic protection_map[] array
 visibility
Thread-Index: AQHYdzLl/DSejCoWwki4ZHdWAMXJ3a09mY8A
Date:   Fri, 3 Jun 2022 12:18:07 +0000
Message-ID: <cd27ea20-73c1-443a-b6ad-6d22b8b1145f@csgroup.eu>
References: <20220603101411.488970-1-anshuman.khandual@arm.com>
 <20220603101411.488970-2-anshuman.khandual@arm.com>
In-Reply-To: <20220603101411.488970-2-anshuman.khandual@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 162600c7-1049-432d-71a5-08da455b1e15
x-ms-traffictypediagnostic: PR0P264MB2326:EE_
x-microsoft-antispam-prvs: <PR0P264MB2326E7652E1D2A133894C9F3EDA19@PR0P264MB2326.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I8DJCuyUfkzHpWfLhOgfZvJ+kMmlm0SxrTMtgLJhtdMVjru/zzjYxaX8NVmrrVud2RznRus/e0wJFU1zvWndN02sRYU/XJeP8ZZE0k4DG/ncUSlDpMUsvHaq8Oir4rWxAMb1eWfm2w3+upl2YBcZ1ZZ1hZdNxpc7CD0UaamzJc70CT1sG601LYstItlAKqRiPRGZCfa55FgNBDoaT49UoC+uFfA6WlhBA6r8WjDG08kLvqEbxHZzmWudAGhit04s4njiEdoIgb8iGYYZ38yoUXtxJ3p+YQyceaYTInemiOfruzG0OGSTo5yfCDh7M77y9uUpvAdqkQjk03v92WY+9k6Kf4LAuQ4IqZV45a+/pf+P+WTsQjiPGZA0iybIAkUKV/0VsZI6fZJ+tfh7GyATMx6/kqBk3YaZLSEq69I8ehpkJo/odxVWGgiMsSzNfhQNdm4jeQMRJq/ezExSvW6uHBANtTgtXfvSbN/0cM1IuFzyeMgLkVLWJ2xR1dO3Z1AMSKJf2CRG3gevUQ3pCTikPXvJU6Unm7TCUxRLfA4L/5mg64M4662CVD0K8htC7bElhql5VWe09bwDKtvvxSSt4yt9cxMMQmacR72XDy26CGyzsli6pQ9OyP7zyKOguVBjBaWK+YCSsRxPZWIgBxtp7DBtbLqJXJIw83rD/DcZJ4tF42wquApxC1VkerhPddCN6q7uwSJWgrvBD03UASlKodwCp0eXD5vicUGznD0TFF8O20PrA6U6v0jRjXrrfhqoqU8cb4ZWDs8ie28iqA0C/JPYPXCWqhxZRhOwD4qdtzM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(91956017)(4326008)(122000001)(66946007)(31696002)(86362001)(110136005)(38100700002)(316002)(54906003)(186003)(31686004)(36756003)(5660300002)(8936002)(8676002)(66476007)(2616005)(66446008)(64756008)(66556008)(2906002)(508600001)(26005)(6506007)(7416002)(83380400001)(6512007)(71200400001)(44832011)(6486002)(38070700005)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFRCYzFDRWRNbjh5dDFOYVJmKzBWWi8rWWNXY1FGRWFXMTFRL3FtdmhUanFH?=
 =?utf-8?B?aEdWb3JJSXBlcjRRNUM1SmNUeFZicVliLytrTThQTGJpdlV1YlpXS1pZNEVs?=
 =?utf-8?B?dHdZVE8yZ3RZeVF5ekFMaW8rS0gvYVZLY1R6bUlQeHVzV0cxa3Q4cksrd2RR?=
 =?utf-8?B?bnRoV3hUM3hnU29Pb1dWTTM5aHpSM24rdmRqSE5nZWdKcmRQaWlLYk1aQWtC?=
 =?utf-8?B?eVNKOVJvSkxLdHI0dFpMZS8yQ3JCMzYxOHFmOWd2SmFjcWR3c1NkVWIrV0hD?=
 =?utf-8?B?Snc1MXdkdkRENjUrVjdBc1RMM1JraTduSzFKNUV6ZStZR1N4ZEo2bmg5U2tj?=
 =?utf-8?B?UURobzMvbzU5dEYzL2pnR3pmZHNhL1ZONUViYk1ac3laQkZwam4zLzZBTXpp?=
 =?utf-8?B?c25yZXNrc3RmMjBJVnNWZnQ2ZVMvOW1hMUJGSkFicERWRWR4RTBxamU1NFA5?=
 =?utf-8?B?MmUra3FqS2RPT1lPbTlkSkJNLzBqREhBUzBaZEhYRkFZY1duUEN2bzIxMjRJ?=
 =?utf-8?B?Z2wrYTk2ckErMllJUC9JRHNVN0IwblpHR29IRFZRN3FuQjN0d2dNSW9Oa3lP?=
 =?utf-8?B?QmExTDIvaFdIaUQwOVQzeWI2dXVLVUtCYnp5T2pDdFFXK3R4bCtMRXhWeUVU?=
 =?utf-8?B?MGRFTm4zcjJ0SGp3a2pIQldTQkVwNDFVMEFRVnJGWGlWVTdKNktEN2J1Zkph?=
 =?utf-8?B?TmJGdGE4RlgvUHVwcTVVaFE0WGp5bnFZRDRmZm9qY215cHNKTHpQRzc2MDhw?=
 =?utf-8?B?eUZrVFhGbGJwZ3MzZHRLVWpYd2pBYXJSZVhTSFN0c0xDR3FvL3IrWUxmRHpY?=
 =?utf-8?B?NWFrRUVUUmw5ZVU3ZzhQNGRYWXpvMzNmcW5USDJXOXphenFRZzNHQllCcEpC?=
 =?utf-8?B?VXlTQU1mNXlhcC9PMGpVUnJERmdZTklsSERNR0JVcU1vN0lOVHJyWE1Ydnlk?=
 =?utf-8?B?U3k2WSsyaXhzYytKRjBQeFpUNVJ2UEo5bElCdmJ2Y2dsUWluTE4ySG02T3RW?=
 =?utf-8?B?SFl4MG8yMmRlbDdmR0ErYUlKNlJDZnB4MDdIL1I1THd1VWdzVHE3Q2h3bVJM?=
 =?utf-8?B?NEMzbnlDR3ZUSTB5bEU4TkprVE9ncWFRbnBIQnFOSjFJR1RkeFlvS2x4eEV4?=
 =?utf-8?B?aWpQdEhDUjIyeC84eDJoc0xUYlFLcVRzemhyeWpPTWkwdFZiR3JJNFB1dkU1?=
 =?utf-8?B?TEV3TUJTQzI1dGdiV2haanpsa3R6QzNZa2Q5TjJ4d2dkU3ZRMDh2THJWRDJR?=
 =?utf-8?B?TUF1S1B1WWhlcmVCa25YTGVvVEpRY1lsN0E3eHZWR01ERnFEbjlWY0hYWUVC?=
 =?utf-8?B?MmkwYW1wTDhXeUd4WmhCV1VEMUxwdnl0SnZWTkR5Y05JN0o5VGJvZlBDMCtV?=
 =?utf-8?B?dzdESjNQc00xVEtONkQwRzBjWHBCRUZwdEliamN2TWFJQzJESjdoZ1hwU3hz?=
 =?utf-8?B?MUIxYkU3Rk45WHBaL1FWSUxxaU9Yckp0REJsMjhhV0J0OWVHaUw0VUV1TUtJ?=
 =?utf-8?B?SDdrR3hLQ09id2NxVm0zVVlDTlN1eGlrdVJFU3RwNE01RGYxYlRSLzRNc2lv?=
 =?utf-8?B?S2pqNTc2ZllkMWVxN1hNUmJMVmUybmluUUR4RElEcTNDc0dqSHp6dUluUTd5?=
 =?utf-8?B?dm9LTnd3cXVQd20zZkVONHF5eVZ5NHhGN0FOQmp4bW9SVFFiZlVwU1JCZ2NB?=
 =?utf-8?B?eGtRZUNxSzNYYStWZDN3bE0rdjFRTkVIcDRZTUhYN0RsZnFLTDZlb1YyN2FX?=
 =?utf-8?B?bnh4SzhBVEVMY045QW1RSUcwYWl3QzJsdEVsRCtsUjI1eVZ3YXFyV1NqN1lz?=
 =?utf-8?B?RmRCTkgzN0w4OVc1M3gvT293ck9pUU9jcFZsSWVLZVdKcTdEZmYxVS9jdGZ6?=
 =?utf-8?B?YVlObTZVcVRwR2RYdzBFTm1xcjVXdjRJRHdjcUxqQ2UvOEc5cU1PNlhRSUZQ?=
 =?utf-8?B?bSt3NGRCWGludkFndmU4TkRvSi96WmdtUVpCTmx1ZlRTbHpJZE8veFAvMGNP?=
 =?utf-8?B?ejdSaFdrRDFMTmF3cFBoRldxOFNLdXBCV0FyRmEzRjNiMmFVNkJtZkFBaDZZ?=
 =?utf-8?B?UVh6cGN6QnNPU2c3ZThoWWwzbGxCSjdBcEI2NzQ1SWRnRVlFcDJmRzk3UmVy?=
 =?utf-8?B?bDZEWHdRbWxIRk9GWXBDUThidG5JOTFPZ2xnVFVUT25pZ3FrdnBjcTNtbm1R?=
 =?utf-8?B?RTJ1RVJOa3hIZDVDWVlqYWExZkxRTmZad0NZaXhBdjg5TEdURWxYakJWRGp1?=
 =?utf-8?B?KzJ2cFJTSnB4b0hLc0FnRmlkb1B3b1UxWUNxcW1mMDNmSi94TEt4RWoxeERu?=
 =?utf-8?B?QlcrQUlJTmErODFOUXplTUlkakFsaUdDMkMzSUkxRWNvT0txZ3NxUmxVanZs?=
 =?utf-8?Q?jWMrskIvKHW5ttbG1M84G86W9H8xY72fLp4xC?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <81037A43A607014C93FD764FCF9594AA@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 162600c7-1049-432d-71a5-08da455b1e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 12:18:07.5096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: taXQBTXEtEekHd7af4vKRPagBqvQsLWygoh5MT7R5uEV7hZTEnC72Voc/ekoUqQ8V75S0pIYLeL3amSeyBLGl0N54AGtjtSJsAda4amkC7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2326
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

DQoNCkxlIDAzLzA2LzIwMjIgw6AgMTI6MTQsIEFuc2h1bWFuIEtoYW5kdWFsIGEgw6ljcml0wqA6
DQo+IFJlc3RyaWN0IGdlbmVyaWMgcHJvdGVjdGlvbl9tYXBbXSBhcnJheSB2aXNpYmlsaXR5IG9u
bHkgZm9yIHBsYXRmb3JtcyB3aGljaA0KPiBkbyBub3QgZW5hYmxlIEFSQ0hfSEFTX1ZNX0dFVF9Q
QUdFX1BST1QuIEZvciBvdGhlciBwbGF0Zm9ybXMgdGhhdCBkbyBkZWZpbmUNCj4gdGhlaXIgb3du
IHZtX2dldF9wYWdlX3Byb3QoKSBlbmFibGluZyBBUkNIX0hBU19WTV9HRVRfUEFHRV9QUk9ULCBj
b3VsZCBoYXZlDQo+IHRoZWlyIHByaXZhdGUgc3RhdGljIHByb3RlY3Rpb25fbWFwW10gc3RpbGwg
aW1wbGVtZW50aW5nIGFuIGFycmF5IGxvb2sgdXAuDQo+IFRoZXNlIHByaXZhdGUgcHJvdGVjdGlv
bl9tYXBbXSBhcnJheSBjb3VsZCBkbyB3aXRob3V0IF9fUFhYWC9fX1NYWFggbWFjcm9zLA0KPiBt
YWtpbmcgdGhlbSByZWR1bmRhbnQgYW5kIGRyb3BwaW5nIHRoZW0gb2ZmLg0KPiANCj4gQnV0IHBs
YXRmb3JtcyB3aGljaCBkbyBub3QgZGVmaW5lIHRoZWlyIGN1c3RvbSB2bV9nZXRfcGFnZV9wcm90
KCkgZW5hYmxpbmcNCj4gQVJDSF9IQVNfVk1fR0VUX1BBR0VfUFJPVCwgd2lsbCBzdGlsbCBoYXZl
IHRvIHByb3ZpZGUgX19QWFhYL19fU1hYWCBtYWNyb3MuDQo+IEFsdGhvdWdoIHRoaXMgbm93IHBy
b3ZpZGVzIGEgbWV0aG9kIGZvciBvdGhlciB3aWxsaW5nIHBsYXRmb3JtcyB0byBkcm9wIG9mZg0K
PiBfX1BYWFgvX19TWFggbWFjcm9zIGNvbXBsZXRlbHkuDQo+IA0KPiBDYzogQ2F0YWxpbiBNYXJp
bmFzIDxjYXRhbGluLm1hcmluYXNAYXJtLmNvbT4NCj4gQ2M6IFdpbGwgRGVhY29uIDx3aWxsQGtl
cm5lbC5vcmc+DQo+IENjOiBNaWNoYWVsIEVsbGVybWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+DQo+
IENjOiBQYXVsIE1hY2tlcnJhcyA8cGF1bHVzQHNhbWJhLm9yZz4NCj4gQ2M6ICJEYXZpZCBTLiBN
aWxsZXIiIDxkYXZlbUBkYXZlbWxvZnQubmV0Pg0KPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4
QGxpbnV0cm9uaXguZGU+DQo+IENjOiBJbmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT4NCj4g
Q2M6IEFuZHJldyBNb3J0b24gPGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc+DQo+IENjOiB4ODZA
a2VybmVsLm9yZw0KPiBDYzogbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+
IENjOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZw0KPiBDYzogc3BhcmNsaW51eEB2Z2Vy
Lmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LW1tQGt2YWNrLm9yZw0KPiBDYzogbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBBbnNodW1hbiBLaGFuZHVhbCA8YW5z
aHVtYW4ua2hhbmR1YWxAYXJtLmNvbT4NCj4gLS0tDQo+ICAgYXJjaC9hcm02NC9pbmNsdWRlL2Fz
bS9wZ3RhYmxlLXByb3QuaCB8IDE4IC0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIGFyY2gvYXJtNjQv
bW0vbW1hcC5jICAgICAgICAgICAgICAgICAgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4g
ICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcGd0YWJsZS5oICAgIHwgIDIgKysNCj4gICBhcmNo
L3Bvd2VycGMvbW0vYm9vazNzNjQvcGd0YWJsZS5jICAgIHwgMjAgKysrKysrKysrKysrKysrKysr
KysNCj4gICBhcmNoL3NwYXJjL2luY2x1ZGUvYXNtL3BndGFibGVfMzIuaCAgIHwgIDIgKysNCj4g
ICBhcmNoL3NwYXJjL2luY2x1ZGUvYXNtL3BndGFibGVfNjQuaCAgIHwgMTkgLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiAgIGFyY2gvc3BhcmMvbW0vaW5pdF82NC5jICAgICAgICAgICAgICAgfCAyMCAr
KysrKysrKysrKysrKysrKysrKw0KPiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BndGFibGVfdHlw
ZXMuaCAgfCAxOSAtLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAgYXJjaC94ODYvbW0vcGdwcm90LmMg
ICAgICAgICAgICAgICAgICB8IDE5ICsrKysrKysrKysrKysrKysrKysNCj4gICBpbmNsdWRlL2xp
bnV4L21tLmggICAgICAgICAgICAgICAgICAgIHwgIDIgKysNCj4gICBtbS9tbWFwLmMgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgIDIgKy0NCj4gICAxMSBmaWxlcyBjaGFuZ2VkLCA4NyBp
bnNlcnRpb25zKCspLCA1NyBkZWxldGlvbnMoLSkNCj4gDQoNCj4gZGlmZiAtLWdpdCBhL2FyY2gv
cG93ZXJwYy9pbmNsdWRlL2FzbS9wZ3RhYmxlLmggYi9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20v
cGd0YWJsZS5oDQo+IGluZGV4IGQ1NjRkMGVjZDRjZC4uOGVkMmE4MGM4OTZlIDEwMDY0NA0KPiAt
LS0gYS9hcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcGd0YWJsZS5oDQo+ICsrKyBiL2FyY2gvcG93
ZXJwYy9pbmNsdWRlL2FzbS9wZ3RhYmxlLmgNCj4gQEAgLTIxLDYgKzIxLDcgQEAgc3RydWN0IG1t
X3N0cnVjdDsNCj4gICAjZW5kaWYgLyogIUNPTkZJR19QUENfQk9PSzNTICovDQo+ICAgDQo+ICAg
LyogTm90ZSBkdWUgdG8gdGhlIHdheSB2bSBmbGFncyBhcmUgbGFpZCBvdXQsIHRoZSBiaXRzIGFy
ZSBYV1IgKi8NCj4gKyNpZm5kZWYgQ09ORklHX0FSQ0hfSEFTX1ZNX0dFVF9QQUdFX1BST1QNCg0K
T2ssIHNvIHVudGlsIG5vdyBpdCB3YXMgY29tbW9uIHRvIGFsbCBwb3dlcnBjIHBsYXRmb3Jtcy4g
Tm93IHlvdSBkZWZpbmUgDQphIGRpZmZlcmVudCB3YXkgd2hldGhlciBpdCBpcyBhIFBQQ19CT09L
M1NfNjQgb3IgYW5vdGhlciBwbGF0Zm9ybSA/IA0KV2hhdCdzIHRoZSBwb2ludCA/DQoNCj4gICAj
ZGVmaW5lIF9fUDAwMAlQQUdFX05PTkUNCj4gICAjZGVmaW5lIF9fUDAwMQlQQUdFX1JFQURPTkxZ
DQo+ICAgI2RlZmluZSBfX1AwMTAJUEFHRV9DT1BZDQo+IEBAIC0zOCw2ICszOSw3IEBAIHN0cnVj
dCBtbV9zdHJ1Y3Q7DQo+ICAgI2RlZmluZSBfX1MxMDEJUEFHRV9SRUFET05MWV9YDQo+ICAgI2Rl
ZmluZSBfX1MxMTAJUEFHRV9TSEFSRURfWA0KPiAgICNkZWZpbmUgX19TMTExCVBBR0VfU0hBUkVE
X1gNCj4gKyNlbmRpZg0KPiAgIA0KPiAgICNpZm5kZWYgX19BU1NFTUJMWV9fDQo+ICAgDQo+IGRp
ZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMvbW0vYm9vazNzNjQvcGd0YWJsZS5jIGIvYXJjaC9wb3dl
cnBjL21tL2Jvb2szczY0L3BndGFibGUuYw0KPiBpbmRleCA3Yjk5NjY0MDJiMjUuLjJjZjEwYTE3
YzBhOSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL21tL2Jvb2szczY0L3BndGFibGUuYw0K
PiArKysgYi9hcmNoL3Bvd2VycGMvbW0vYm9vazNzNjQvcGd0YWJsZS5jDQo+IEBAIC01NTEsNiAr
NTUxLDI2IEBAIHVuc2lnbmVkIGxvbmcgbWVtcmVtYXBfY29tcGF0X2FsaWduKHZvaWQpDQo+ICAg
RVhQT1JUX1NZTUJPTF9HUEwobWVtcmVtYXBfY29tcGF0X2FsaWduKTsNCj4gICAjZW5kaWYNCj4g
ICANCj4gKy8qIE5vdGUgZHVlIHRvIHRoZSB3YXkgdm0gZmxhZ3MgYXJlIGxhaWQgb3V0LCB0aGUg
Yml0cyBhcmUgWFdSICovDQo+ICtzdGF0aWMgcGdwcm90X3QgcHJvdGVjdGlvbl9tYXBbMTZdIF9f
cm9fYWZ0ZXJfaW5pdCA9IHsNCg0KSSBkb24ndCB0aGluayBwb3dlcnBjIG1vZGlmaWVzIHRoYXQg
YXQgYWxsLiBDb3VsZCBiZSBjb25zdCBpbnN0ZWFkIG9mIA0Kcm9fYWZ0ZXJfaW5pdC4NCg0KPiAr
CVtWTV9OT05FXQkJCQkJPSBQQUdFX05PTkUsDQo+ICsJW1ZNX1JFQURdCQkJCQk9IFBBR0VfUkVB
RE9OTFksDQo+ICsJW1ZNX1dSSVRFXQkJCQkJPSBQQUdFX0NPUFksDQo+ICsJW1ZNX1dSSVRFIHwg
Vk1fUkVBRF0JCQkJPSBQQUdFX0NPUFksDQo+ICsJW1ZNX0VYRUNdCQkJCQk9IFBBR0VfUkVBRE9O
TFlfWCwNCj4gKwlbVk1fRVhFQyB8IFZNX1JFQURdCQkJCT0gUEFHRV9SRUFET05MWV9YLA0KPiAr
CVtWTV9FWEVDIHwgVk1fV1JJVEVdCQkJCT0gUEFHRV9DT1BZX1gsDQo+ICsJW1ZNX0VYRUMgfCBW
TV9XUklURSB8IFZNX1JFQURdCQkJPSBQQUdFX0NPUFlfWCwNCj4gKwlbVk1fU0hBUkVEXQkJCQkJ
PSBQQUdFX05PTkUsDQo+ICsJW1ZNX1NIQVJFRCB8IFZNX1JFQURdCQkJCT0gUEFHRV9SRUFET05M
WSwNCj4gKwlbVk1fU0hBUkVEIHwgVk1fV1JJVEVdCQkJCT0gUEFHRV9TSEFSRUQsDQo+ICsJW1ZN
X1NIQVJFRCB8IFZNX1dSSVRFIHwgVk1fUkVBRF0JCT0gUEFHRV9TSEFSRUQsDQo+ICsJW1ZNX1NI
QVJFRCB8IFZNX0VYRUNdCQkJCT0gUEFHRV9SRUFET05MWV9YLA0KPiArCVtWTV9TSEFSRUQgfCBW
TV9FWEVDIHwgVk1fUkVBRF0JCQk9IFBBR0VfUkVBRE9OTFlfWCwNCj4gKwlbVk1fU0hBUkVEIHwg
Vk1fRVhFQyB8IFZNX1dSSVRFXQkJPSBQQUdFX1NIQVJFRF9YLA0KPiArCVtWTV9TSEFSRUQgfCBW
TV9FWEVDIHwgVk1fV1JJVEUgfCBWTV9SRUFEXQk9IFBBR0VfU0hBUkVEX1gNCj4gK307DQoNClRo
YXQncyBuaWNlIGJ1dCBpdCBjb3VsZCBhcHBseSB0byBhbGwgcG93ZXJwYyBwbGF0Zm9ybXMuIFdo
eSByZXN0cmljdCBpdCANCnRvIGJvb2szcy82NCA/DQoNCj4gKw0KPiAgIHBncHJvdF90IHZtX2dl
dF9wYWdlX3Byb3QodW5zaWduZWQgbG9uZyB2bV9mbGFncykNCj4gICB7DQo+ICAgCXVuc2lnbmVk
IGxvbmcgcHJvdCA9IHBncHJvdF92YWwocHJvdGVjdGlvbl9tYXBbdm1fZmxhZ3MgJg0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9wZ3RhYmxlXzMyLmggYi9hcmNoL3NwYXJj
L2luY2x1ZGUvYXNtL3BndGFibGVfMzIuaA0KPiBpbmRleCA0ODY2NjI1ZGEzMTQuLmJjYTk4YjI4
MGZkZCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9wZ3RhYmxlXzMyLmgN
Cj4gKysrIGIvYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9wZ3RhYmxlXzMyLmgNCj4gQEAgLTY1LDYg
KzY1LDcgQEAgdm9pZCBwYWdpbmdfaW5pdCh2b2lkKTsNCj4gICBleHRlcm4gdW5zaWduZWQgbG9u
ZyBwdHJfaW5fY3VycmVudF9wZ2Q7DQo+ICAgDQo+ICAgLyogICAgICAgICB4d3IgKi8NCj4gKyNp
Zm5kZWYgQ09ORklHX0FSQ0hfSEFTX1ZNX0dFVF9QQUdFX1BST1QNCg0KQ09ORklHX0FSQ0hfSEFT
X1ZNX0dFVF9QQUdFX1BST1QgaXMgc2VsZWN0ZWQgYnkgc3BhcmM2NCBvbmx5LCBpcyB0aGF0IA0K
aWZkZWYgbmVlZGVkIGF0IGFsbCA/DQoNCj4gICAjZGVmaW5lIF9fUDAwMCAgUEFHRV9OT05FDQo+
ICAgI2RlZmluZSBfX1AwMDEgIFBBR0VfUkVBRE9OTFkNCj4gICAjZGVmaW5lIF9fUDAxMCAgUEFH
RV9DT1BZDQo+IEBAIC04Miw2ICs4Myw3IEBAIGV4dGVybiB1bnNpZ25lZCBsb25nIHB0cl9pbl9j
dXJyZW50X3BnZDsNCj4gICAjZGVmaW5lIF9fUzEwMQlQQUdFX1JFQURPTkxZDQo+ICAgI2RlZmlu
ZSBfX1MxMTAJUEFHRV9TSEFSRUQNCj4gICAjZGVmaW5lIF9fUzExMQlQQUdFX1NIQVJFRA0KPiAr
I2VuZGlmDQo+ICAgDQo+ICAgLyogRmlyc3QgcGh5c2ljYWwgcGFnZSBjYW4gYmUgYW55d2hlcmUs
IHRoZSBmb2xsb3dpbmcgaXMgbmVlZGVkIHNvIHRoYXQNCj4gICAgKiB2YS0tPnBhIGFuZCB2aWNl
IHZlcnNhIGNvbnZlcnNpb25zIHdvcmsgcHJvcGVybHkgd2l0aG91dCBwZXJmb3JtYW5jZQ0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0LmggYi9hcmNoL3Nw
YXJjL2luY2x1ZGUvYXNtL3BndGFibGVfNjQuaA0KPiBpbmRleCA0Njc5ZTQ1YzgzNDguLmE3Nzk0
MThjZWJhOSAxMDA2NDQNCj4gLS0tIGEvYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0
LmgNCj4gKysrIGIvYXJjaC9zcGFyYy9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0LmgNCj4gQEAgLTE4
NywyNSArMTg3LDYgQEAgYm9vbCBrZXJuX2FkZHJfdmFsaWQodW5zaWduZWQgbG9uZyBhZGRyKTsN
Cj4gICAjZGVmaW5lIF9QQUdFX1NaSFVHRV80VQlfUEFHRV9TWjRNQl80VQ0KPiAgICNkZWZpbmUg
X1BBR0VfU1pIVUdFXzRWCV9QQUdFX1NaNE1CXzRWDQo+ICAgDQo+IC0vKiBUaGVzZSBhcmUgYWN0
dWFsbHkgZmlsbGVkIGluIGF0IGJvb3QgdGltZSBieSBzdW40e3Usdn1fcGdwcm90X2luaXQoKSAq
Lw0KPiAtI2RlZmluZSBfX1AwMDAJX19wZ3Byb3QoMCkNCj4gLSNkZWZpbmUgX19QMDAxCV9fcGdw
cm90KDApDQo+IC0jZGVmaW5lIF9fUDAxMAlfX3BncHJvdCgwKQ0KPiAtI2RlZmluZSBfX1AwMTEJ
X19wZ3Byb3QoMCkNCj4gLSNkZWZpbmUgX19QMTAwCV9fcGdwcm90KDApDQo+IC0jZGVmaW5lIF9f
UDEwMQlfX3BncHJvdCgwKQ0KPiAtI2RlZmluZSBfX1AxMTAJX19wZ3Byb3QoMCkNCj4gLSNkZWZp
bmUgX19QMTExCV9fcGdwcm90KDApDQo+IC0NCj4gLSNkZWZpbmUgX19TMDAwCV9fcGdwcm90KDAp
DQo+IC0jZGVmaW5lIF9fUzAwMQlfX3BncHJvdCgwKQ0KPiAtI2RlZmluZSBfX1MwMTAJX19wZ3By
b3QoMCkNCj4gLSNkZWZpbmUgX19TMDExCV9fcGdwcm90KDApDQo+IC0jZGVmaW5lIF9fUzEwMAlf
X3BncHJvdCgwKQ0KPiAtI2RlZmluZSBfX1MxMDEJX19wZ3Byb3QoMCkNCj4gLSNkZWZpbmUgX19T
MTEwCV9fcGdwcm90KDApDQo+IC0jZGVmaW5lIF9fUzExMQlfX3BncHJvdCgwKQ0KPiAtDQo+ICAg
I2lmbmRlZiBfX0FTU0VNQkxZX18NCj4gICANCj4gICBwdGVfdCBta19wdGVfaW8odW5zaWduZWQg
bG9uZywgcGdwcm90X3QsIGludCwgdW5zaWduZWQgbG9uZyk7DQo+IGRpZmYgLS1naXQgYS9hcmNo
L3NwYXJjL21tL2luaXRfNjQuYyBiL2FyY2gvc3BhcmMvbW0vaW5pdF82NC5jDQo+IGluZGV4IGY2
MTc0ZGYyZDVhZi4uNmVkYzJhNjhiNzNjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3NwYXJjL21tL2lu
aXRfNjQuYw0KPiArKysgYi9hcmNoL3NwYXJjL21tL2luaXRfNjQuYw0KPiBAQCAtMjYzNCw2ICsy
NjM0LDI2IEBAIHZvaWQgdm1lbW1hcF9mcmVlKHVuc2lnbmVkIGxvbmcgc3RhcnQsIHVuc2lnbmVk
IGxvbmcgZW5kLA0KPiAgIH0NCj4gICAjZW5kaWYgLyogQ09ORklHX1NQQVJTRU1FTV9WTUVNTUFQ
ICovDQo+ICAgDQo+ICsvKiBUaGVzZSBhcmUgYWN0dWFsbHkgZmlsbGVkIGluIGF0IGJvb3QgdGlt
ZSBieSBzdW40e3Usdn1fcGdwcm90X2luaXQoKSAqLw0KPiArc3RhdGljIHBncHJvdF90IHByb3Rl
Y3Rpb25fbWFwWzE2XSBfX3JvX2FmdGVyX2luaXQgPSB7DQo+ICsJW1ZNX05PTkVdCQkJCQk9IF9f
cGdwcm90KDApLA0KPiArCVtWTV9SRUFEXQkJCQkJPSBfX3BncHJvdCgwKSwNCj4gKwlbVk1fV1JJ
VEVdCQkJCQk9IF9fcGdwcm90KDApLA0KPiArCVtWTV9XUklURSB8IFZNX1JFQURdCQkJCT0gX19w
Z3Byb3QoMCksDQo+ICsJW1ZNX0VYRUNdCQkJCQk9IF9fcGdwcm90KDApLA0KPiArCVtWTV9FWEVD
IHwgVk1fUkVBRF0JCQkJPSBfX3BncHJvdCgwKSwNCj4gKwlbVk1fRVhFQyB8IFZNX1dSSVRFXQkJ
CQk9IF9fcGdwcm90KDApLA0KPiArCVtWTV9FWEVDIHwgVk1fV1JJVEUgfCBWTV9SRUFEXQkJCT0g
X19wZ3Byb3QoMCksDQo+ICsJW1ZNX1NIQVJFRF0JCQkJCT0gX19wZ3Byb3QoMCksDQo+ICsJW1ZN
X1NIQVJFRCB8IFZNX1JFQURdCQkJCT0gX19wZ3Byb3QoMCksDQo+ICsJW1ZNX1NIQVJFRCB8IFZN
X1dSSVRFXQkJCQk9IF9fcGdwcm90KDApLA0KPiArCVtWTV9TSEFSRUQgfCBWTV9XUklURSB8IFZN
X1JFQURdCQk9IF9fcGdwcm90KDApLA0KPiArCVtWTV9TSEFSRUQgfCBWTV9FWEVDXQkJCQk9IF9f
cGdwcm90KDApLA0KPiArCVtWTV9TSEFSRUQgfCBWTV9FWEVDIHwgVk1fUkVBRF0JCQk9IF9fcGdw
cm90KDApLA0KPiArCVtWTV9TSEFSRUQgfCBWTV9FWEVDIHwgVk1fV1JJVEVdCQk9IF9fcGdwcm90
KDApLA0KPiArCVtWTV9TSEFSRUQgfCBWTV9FWEVDIHwgVk1fV1JJVEUgfCBWTV9SRUFEXQk9IF9f
cGdwcm90KDApDQo+ICt9Ow0KDQpfX3BncHJvdCgwKSBpcyAwIHNvIHlvdSBkb24ndCBuZWVkIHRv
IGluaXRpYWxpc2UgdGhlIGZpZWxkcyBhdCBhbGwsIGl0IA0KaXMgemVyb2l6ZWQgYXQgc3RhcnR1
cCBhcyBwYXJ0IG9mIEJTUyBzZWN0aW9uLg0KDQo+ICsNCj4gICBzdGF0aWMgdm9pZCBwcm90X2lu
aXRfY29tbW9uKHVuc2lnbmVkIGxvbmcgcGFnZV9ub25lLA0KPiAgIAkJCSAgICAgdW5zaWduZWQg
bG9uZyBwYWdlX3NoYXJlZCwNCj4gICAJCQkgICAgIHVuc2lnbmVkIGxvbmcgcGFnZV9jb3B5LA0K
DQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tLmggYi9pbmNsdWRlL2xpbnV4L21tLmgN
Cj4gaW5kZXggYmM4ZjMyNmJlMGNlLi4yMjU0YzE5ODBjOGUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1
ZGUvbGludXgvbW0uaA0KPiArKysgYi9pbmNsdWRlL2xpbnV4L21tLmgNCj4gQEAgLTQyMCwxMSAr
NDIwLDEzIEBAIGV4dGVybiB1bnNpZ25lZCBpbnQga29ianNpemUoY29uc3Qgdm9pZCAqb2JqcCk7
DQo+ICAgI2VuZGlmDQo+ICAgI2RlZmluZSBWTV9GTEFHU19DTEVBUgkoQVJDSF9WTV9QS0VZX0ZM
QUdTIHwgVk1fQVJDSF9DTEVBUikNCj4gICANCj4gKyNpZm5kZWYgQ09ORklHX0FSQ0hfSEFTX1ZN
X0dFVF9QQUdFX1BST1QNCj4gICAvKg0KPiAgICAqIG1hcHBpbmcgZnJvbSB0aGUgY3VycmVudGx5
IGFjdGl2ZSB2bV9mbGFncyBwcm90ZWN0aW9uIGJpdHMgKHRoZQ0KPiAgICAqIGxvdyBmb3VyIGJp
dHMpIHRvIGEgcGFnZSBwcm90ZWN0aW9uIG1hc2suLg0KPiAgICAqLw0KPiAgIGV4dGVybiBwZ3By
b3RfdCBwcm90ZWN0aW9uX21hcFsxNl07DQo+ICsjZW5kaWYNCj4gICANCj4gICAvKg0KPiAgICAq
IFRoZSBkZWZhdWx0IGZhdWx0IGZsYWdzIHRoYXQgc2hvdWxkIGJlIHVzZWQgYnkgbW9zdCBvZiB0
aGUNCj4gZGlmZiAtLWdpdCBhL21tL21tYXAuYyBiL21tL21tYXAuYw0KPiBpbmRleCA2MWU2MTM1
YzU0ZWYuLmU2NjkyMDQxNDk0NSAxMDA2NDQNCj4gLS0tIGEvbW0vbW1hcC5jDQo+ICsrKyBiL21t
L21tYXAuYw0KPiBAQCAtMTAxLDYgKzEwMSw3IEBAIHN0YXRpYyB2b2lkIHVubWFwX3JlZ2lvbihz
dHJ1Y3QgbW1fc3RydWN0ICptbSwNCj4gICAgKgkJCQkJCQkJdzogKG5vKSBubw0KPiAgICAqCQkJ
CQkJCQl4OiAoeWVzKSB5ZXMNCj4gICAgKi8NCj4gKyNpZm5kZWYgQ09ORklHX0FSQ0hfSEFTX1ZN
X0dFVF9QQUdFX1BST1QNCj4gICBwZ3Byb3RfdCBwcm90ZWN0aW9uX21hcFsxNl0gX19yb19hZnRl
cl9pbml0ID0gew0KPiAgIAlbVk1fTk9ORV0JCQkJCT0gX19QMDAwLA0KPiAgIAlbVk1fUkVBRF0J
CQkJCT0gX19QMDAxLA0KPiBAQCAtMTIwLDcgKzEyMSw2IEBAIHBncHJvdF90IHByb3RlY3Rpb25f
bWFwWzE2XSBfX3JvX2FmdGVyX2luaXQgPSB7DQo+ICAgCVtWTV9TSEFSRUQgfCBWTV9FWEVDIHwg
Vk1fV1JJVEUgfCBWTV9SRUFEXQk9IF9fUzExMQ0KPiAgIH07DQo+ICAgDQo+IC0jaWZuZGVmIENP
TkZJR19BUkNIX0hBU19WTV9HRVRfUEFHRV9QUk9UDQoNCldoeSBub3QgbGV0IGFyY2hpdGVjdHVy
ZXMgcHJvdmlkZSB0aGVpciBwcm90ZWN0aW9uX21hcFtdIGFuZCBrZWVwIHRoYXQgDQpmdW5jdGlv
biA/DQoNCj4gICBwZ3Byb3RfdCB2bV9nZXRfcGFnZV9wcm90KHVuc2lnbmVkIGxvbmcgdm1fZmxh
Z3MpDQo+ICAgew0KPiAgIAlyZXR1cm4gcHJvdGVjdGlvbl9tYXBbdm1fZmxhZ3MgJiAoVk1fUkVB
RHxWTV9XUklURXxWTV9FWEVDfFZNX1NIQVJFRCldOw==
