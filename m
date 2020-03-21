Return-Path: <linux-csky-owner@vger.kernel.org>
X-Original-To: lists+linux-csky@lfdr.de
Delivered-To: lists+linux-csky@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A07B318DFFB
	for <lists+linux-csky@lfdr.de>; Sat, 21 Mar 2020 12:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgCULfQ (ORCPT <rfc822;lists+linux-csky@lfdr.de>);
        Sat, 21 Mar 2020 07:35:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38516 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbgCULfG (ORCPT
        <rfc822;linux-csky@vger.kernel.org>); Sat, 21 Mar 2020 07:35:06 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jFcOX-0002Hj-QZ; Sat, 21 Mar 2020 12:34:26 +0100
Received: from nanos.tec.linutronix.de (localhost [IPv6:::1])
        by nanos.tec.linutronix.de (Postfix) with ESMTP id 9EB21FFBBF;
        Sat, 21 Mar 2020 12:34:21 +0100 (CET)
Message-Id: <20200321113242.427089655@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 21 Mar 2020 12:26:01 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, kbuild test robot <lkp@intel.com>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org,
        Brian Cain <bcain@codeaurora.org>,
        linux-hexagon@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-ia64@vger.kernel.org,
        Michal Simek <monstr@monstr.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Geoff Levand <geoff@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [patch V3 17/20] lockdep: Introduce wait-type checks
References: <20200321112544.878032781@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-transfer-encoding: base64
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-csky-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-csky.vger.kernel.org>
X-Mailing-List: linux-csky@vger.kernel.org

RnJvbTogUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPgoKRXh0ZW5kIGxvY2tk
ZXAgdG8gdmFsaWRhdGUgbG9jayB3YWl0LXR5cGUgY29udGV4dC4KClRoZSBjdXJyZW50IHdhaXQt
dHlwZXMgYXJlOgoKCUxEX1dBSVRfRlJFRSwJCS8qIHdhaXQgZnJlZSwgcmN1IGV0Yy4uICovCglM
RF9XQUlUX1NQSU4sCQkvKiBzcGluIGxvb3BzLCByYXdfc3BpbmxvY2tfdCBldGMuLiAqLwoJTERf
V0FJVF9DT05GSUcsCQkvKiBDT05GSUdfUFJFRU1QVF9MT0NLLCBzcGlubG9ja190IGV0Yy4uICov
CglMRF9XQUlUX1NMRUVQLAkJLyogc2xlZXBpbmcgbG9ja3MsIG11dGV4X3QgZXRjLi4gKi8KCldo
ZXJlIGxvY2tkZXAgdmFsaWRhdGVzIHRoYXQgdGhlIGN1cnJlbnQgbG9jayAodGhlIG9uZSBiZWlu
ZyBhY3F1aXJlZCkKZml0cyBpbiB0aGUgY3VycmVudCB3YWl0LWNvbnRleHQgKGFzIGdlbmVyYXRl
ZCBieSB0aGUgaGVsZCBzdGFjaykuCgpUaGlzIGVuc3VyZXMgdGhhdCB0aGVyZSBpcyBubyBhdHRl
bXB0IHRvIGFjcXVpcmUgbXV0ZXhlcyB3aGlsZSBob2xkaW5nCnNwaW5sb2NrcywgdG8gYWNxdWly
ZSBzcGlubG9ja3Mgd2hpbGUgaG9sZGluZyByYXdfc3BpbmxvY2tzIGFuZCBzbyBvbi4gSW4Kb3Ro
ZXIgd29yZHMsIGl0cyBhIG1vcmUgZmFuY3kgbWlnaHRfc2xlZXAoKS4KCk9idmlvdXNseSBSQ1Ug
bWFkZSB0aGUgZW50aXJlIG9yZGVhbCBtb3JlIGNvbXBsZXggdGhhbiBhIHNpbXBsZSBzaW5nbGUK
dmFsdWUgdGVzdCBiZWNhdXNlIFJDVSBjYW4gYmUgYWNxdWlyZWQgaW4gKHByZXR0eSBtdWNoKSBh
bnkgY29udGV4dCBhbmQKd2hpbGUgaXQgcHJlc2VudHMgYSBjb250ZXh0IHRvIG5lc3RlZCBsb2Nr
cyBpdCBpcyBub3QgdGhlIHNhbWUgYXMgaXQKZ290IGFjcXVpcmVkIGluLgoKVGhlcmVmb3JlIGl0
cyBuZWNlc3NhcnkgdG8gc3BsaXQgdGhlIHdhaXRfdHlwZSBpbnRvIHR3byB2YWx1ZXMsIG9uZQpy
ZXByZXNlbnRpbmcgdGhlIGFjcXVpcmUgKG91dGVyKSBhbmQgb25lIHJlcHJlc2VudGluZyB0aGUg
bmVzdGVkIGNvbnRleHQKKGlubmVyKS4gRm9yIG1vc3QgJ25vcm1hbCcgbG9ja3MgdGhlc2UgdHdv
IGFyZSB0aGUgc2FtZS4KClsgVG8gbWFrZSBzdGF0aWMgaW5pdGlhbGl6YXRpb24gZWFzaWVyIHdl
IGhhdmUgdGhlIHJ1bGUgdGhhdDoKICAub3V0ZXIgPT0gSU5WIG1lYW5zIC5vdXRlciA9PSAuaW5u
ZXI7IGJlY2F1c2UgSU5WID09IDAuIF0KCkl0IGZ1cnRoZXIgbWVhbnMgdGhhdCBpdHMgcmVxdWly
ZWQgdG8gZmluZCB0aGUgbWluaW1hbCAuaW5uZXIgb2YgdGhlIGhlbGQKc3RhY2sgdG8gY29tcGFy
ZSBhZ2FpbnN0IHRoZSBvdXRlciBvZiB0aGUgbmV3IGxvY2s7IGJlY2F1c2Ugd2hpbGUgJ25vcm1h
bCcKUkNVIHByZXNlbnRzIGEgQ09ORklHIHR5cGUgdG8gbmVzdGVkIGxvY2tzLCBpZiBpdCBpcyB0
YWtlbiB3aGlsZSBhbHJlYWR5CmhvbGRpbmcgYSBTUElOIHR5cGUgaXQgb2J2aW91c2x5IGRvZXNu
J3QgcmVsYXggdGhlIHJ1bGVzLgoKQmVsb3cgaXMgYW4gZXhhbXBsZSBvdXRwdXQgZ2VuZXJhdGVk
IGJ5IHRoZSB0cml2aWFsIHRlc3QgY29kZToKCiAgcmF3X3NwaW5fbG9jaygmZm9vKTsKICBzcGlu
X2xvY2soJmJhcik7CiAgc3Bpbl91bmxvY2soJmJhcik7CiAgcmF3X3NwaW5fdW5sb2NrKCZmb28p
OwoKIFsgQlVHOiBJbnZhbGlkIHdhaXQgY29udGV4dCBdCiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQogc3dhcHBlci8wLzEgaXMgdHJ5aW5nIHRvIGxvY2s6CiBmZmZmYzkwMDAwMDEzZjIw
ICgmYmFyKXsuLi4ufS17MzozfSwgYXQ6IGtlcm5lbF9pbml0KzB4ZGIvMHgxODcKIG90aGVyIGlu
Zm8gdGhhdCBtaWdodCBoZWxwIHVzIGRlYnVnIHRoaXM6CiAxIGxvY2sgaGVsZCBieSBzd2FwcGVy
LzAvMToKICAjMDogZmZmZmM5MDAwMDAxM2VlMCAoJmZvbyl7Ky4rLn0tezI6Mn0sIGF0OiBrZXJu
ZWxfaW5pdCsweGQxLzB4MTg3CgpUaGUgd2F5IHRvIHJlYWQgaXQgaXMgdG8gbG9vayBhdCB0aGUg
bmV3IC17bixtfSBwYXJ0IGluIHRoZSBsb2NrCmRlc2NyaXB0aW9uOyAtezM6M30gZm9yIHRoZSBh
dHRlbXB0ZWQgbG9jaywgYW5kIHRyeSBhbmQgbWF0Y2ggdGhhdCB1cCB0bwp0aGUgaGVsZCBsb2Nr
cywgd2hpY2ggaW4gdGhpcyBjYXNlIGlzIHRoZSBvbmU6IC17MiwyfS4KClRoaXMgdGVsbHMgdGhh
dCB0aGUgYWNxdWlyaW5nIGxvY2sgcmVxdWlyZXMgYSBtb3JlIHJlbGF4ZWQgZW52aXJvbm1lbnQg
dGhhbgpwcmVzZW50ZWQgYnkgdGhlIGxvY2sgc3RhY2suCgpDdXJyZW50bHkgb25seSB0aGUgbm9y
bWFsIGxvY2tzIGFuZCBSQ1UgYXJlIGNvbnZlcnRlZCwgdGhlIHJlc3Qgb2YgdGhlCmxvY2tkZXAg
dXNlcnMgZGVmYXVsdHMgdG8gLmlubmVyID0gSU5WIHdoaWNoIGlzIGlnbm9yZWQuIE1vcmUgY29u
dmVyc2lvbnMKY2FuIGJlIGRvbmUgd2hlbiBkZXNpcmVkLgoKVGhlIGNoZWNrIGZvciBzcGlubG9j
a190IG5lc3RpbmcgaXMgbm90IGVuYWJsZWQgYnkgZGVmYXVsdC4gSXQncyBhIHNlcGFyYXRlCmNv
bmZpZyBvcHRpb24gZm9yIG5vdyBhcyB0aGVyZSBhcmUga25vd24gcHJvYmxlbXMgd2hpY2ggYXJl
IGN1cnJlbnRseQphZGRyZXNzZWQuIFRoZSBjb25maWcgb3B0aW9uIGFsbG93cyB0byBpZGVudGlm
eSB0aGVzZSBwcm9ibGVtcyBhbmQgdG8KdmVyaWZ5IHRoYXQgdGhlIHNvbHV0aW9ucyBmb3VuZCBh
cmUgaW5kZWVkIHNvbHZpbmcgdGhlbS4KClRoZSBjb25maWcgc3dpdGNoIHdpbGwgYmUgcmVtb3Zl
ZCBhbmQgdGhlIGNoZWNrcyB3aWxsIHBlcm1hbmVudGx5IGVuYWJsZWQKb25jZSB0aGUgdmFzdCBt
YWpvcml0eSBvZiBpc3N1ZXMgaGFzIGJlZW4gYWRkcmVzc2VkLgoKWyBiaWdlYXN5OiBNb3ZlIExE
X1dBSVRfRlJFRSzigKYgb3V0IG9mIENPTkZJR19MT0NLREVQIHRvIGF2b2lkIGNvbXBpbGUKCSAg
IGZhaWx1cmUgd2l0aCBDT05GSUdfREVCVUdfU1BJTkxPQ0sgKyAhQ09ORklHX0xPQ0tERVBdClsg
dGdseDogQWRkIHRoZSBjb25maWcgb3B0aW9uIF0KClJlcXVlc3RlZC1ieTogVGhvbWFzIEdsZWl4
bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+ClNpZ25lZC1vZmYtYnk6IFBldGVyIFppamxzdHJhIChJ
bnRlbCkgPHBldGVyekBpbmZyYWRlYWQub3JnPgpTaWduZWQtb2ZmLWJ5OiBTZWJhc3RpYW4gQW5k
cnplaiBTaWV3aW9yIDxiaWdlYXN5QGxpbnV0cm9uaXguZGU+ClNpZ25lZC1vZmYtYnk6IFRob21h
cyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgotLS0KVjI6IEZpeCB0aGUgTE9DS0RFUD15
ICYmIExPQ0tfUFJPVkU9biBjYXNlCi0tLQogaW5jbHVkZS9saW51eC9pcnFmbGFncy5oICAgICAg
ICB8ICAgIDggKysKIGluY2x1ZGUvbGludXgvbG9ja2RlcC5oICAgICAgICAgfCAgIDcxICsrKysr
KysrKysrKysrKysrLS0tCiBpbmNsdWRlL2xpbnV4L211dGV4LmggICAgICAgICAgIHwgICAgNyAr
LQogaW5jbHVkZS9saW51eC9yd2xvY2tfdHlwZXMuaCAgICB8ICAgIDYgKwogaW5jbHVkZS9saW51
eC9yd3NlbS5oICAgICAgICAgICB8ICAgIDYgKwogaW5jbHVkZS9saW51eC9zY2hlZC5oICAgICAg
ICAgICB8ICAgIDEgCiBpbmNsdWRlL2xpbnV4L3NwaW5sb2NrLmggICAgICAgIHwgICAzNSArKysr
KysrLS0tCiBpbmNsdWRlL2xpbnV4L3NwaW5sb2NrX3R5cGVzLmggIHwgICAyNCArKysrKy0KIGtl
cm5lbC9pcnEvaGFuZGxlLmMgICAgICAgICAgICAgfCAgICA3ICsrCiBrZXJuZWwvbG9ja2luZy9s
b2NrZGVwLmMgICAgICAgIHwgIDEzOCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tCiBrZXJuZWwvbG9ja2luZy9tdXRleC1kZWJ1Zy5jICAgIHwgICAgMiAKIGtlcm5lbC9s
b2NraW5nL3J3c2VtLmMgICAgICAgICAgfCAgICAyIAoga2VybmVsL2xvY2tpbmcvc3BpbmxvY2tf
ZGVidWcuYyB8ICAgIDYgLQoga2VybmVsL3JjdS91cGRhdGUuYyAgICAgICAgICAgICB8ICAgMjQg
KysrKystCiBsaWIvS2NvbmZpZy5kZWJ1ZyAgICAgICAgICAgICAgIHwgICAxNyArKysrCiAxNSBm
aWxlcyBjaGFuZ2VkLCAzMDcgaW5zZXJ0aW9ucygrKSwgNDcgZGVsZXRpb25zKC0pCgotLS0gYS9p
bmNsdWRlL2xpbnV4L2lycWZsYWdzLmgKKysrIGIvaW5jbHVkZS9saW51eC9pcnFmbGFncy5oCkBA
IC0zNyw3ICszNywxMiBAQAogIyBkZWZpbmUgdHJhY2Vfc29mdGlycXNfZW5hYmxlZChwKQkoKHAp
LT5zb2Z0aXJxc19lbmFibGVkKQogIyBkZWZpbmUgdHJhY2VfaGFyZGlycV9lbnRlcigpCQkJXAog
ZG8gewkJCQkJCVwKLQljdXJyZW50LT5oYXJkaXJxX2NvbnRleHQrKzsJCVwKKwlpZiAoIWN1cnJl
bnQtPmhhcmRpcnFfY29udGV4dCsrKQlcCisJCWN1cnJlbnQtPmhhcmRpcnFfdGhyZWFkZWQgPSAw
OwlcCit9IHdoaWxlICgwKQorIyBkZWZpbmUgdHJhY2VfaGFyZGlycV90aHJlYWRlZCgpCQlcCitk
byB7CQkJCQkJXAorCWN1cnJlbnQtPmhhcmRpcnFfdGhyZWFkZWQgPSAxOwkJXAogfSB3aGlsZSAo
MCkKICMgZGVmaW5lIHRyYWNlX2hhcmRpcnFfZXhpdCgpCQkJXAogZG8gewkJCQkJCVwKQEAgLTU5
LDYgKzY0LDcgQEAgZG8gewkJCQkJCVwKICMgZGVmaW5lIHRyYWNlX2hhcmRpcnFzX2VuYWJsZWQo
cCkJMAogIyBkZWZpbmUgdHJhY2Vfc29mdGlycXNfZW5hYmxlZChwKQkwCiAjIGRlZmluZSB0cmFj
ZV9oYXJkaXJxX2VudGVyKCkJCWRvIHsgfSB3aGlsZSAoMCkKKyMgZGVmaW5lIHRyYWNlX2hhcmRp
cnFfdGhyZWFkZWQoKQlkbyB7IH0gd2hpbGUgKDApCiAjIGRlZmluZSB0cmFjZV9oYXJkaXJxX2V4
aXQoKQkJZG8geyB9IHdoaWxlICgwKQogIyBkZWZpbmUgbG9ja2RlcF9zb2Z0aXJxX2VudGVyKCkJ
ZG8geyB9IHdoaWxlICgwKQogIyBkZWZpbmUgbG9ja2RlcF9zb2Z0aXJxX2V4aXQoKQkJZG8geyB9
IHdoaWxlICgwKQotLS0gYS9pbmNsdWRlL2xpbnV4L2xvY2tkZXAuaAorKysgYi9pbmNsdWRlL2xp
bnV4L2xvY2tkZXAuaApAQCAtMjEsNiArMjEsMjIgQEAgZXh0ZXJuIGludCBsb2NrX3N0YXQ7CiAK
ICNpbmNsdWRlIDxsaW51eC90eXBlcy5oPgogCitlbnVtIGxvY2tkZXBfd2FpdF90eXBlIHsKKwlM
RF9XQUlUX0lOViA9IDAsCS8qIG5vdCBjaGVja2VkLCBjYXRjaCBhbGwgKi8KKworCUxEX1dBSVRf
RlJFRSwJCS8qIHdhaXQgZnJlZSwgcmN1IGV0Yy4uICovCisJTERfV0FJVF9TUElOLAkJLyogc3Bp
biBsb29wcywgcmF3X3NwaW5sb2NrX3QgZXRjLi4gKi8KKworI2lmZGVmIENPTkZJR19QUk9WRV9S
QVdfTE9DS19ORVNUSU5HCisJTERfV0FJVF9DT05GSUcsCQkvKiBDT05GSUdfUFJFRU1QVF9MT0NL
LCBzcGlubG9ja190IGV0Yy4uICovCisjZWxzZQorCUxEX1dBSVRfQ09ORklHID0gTERfV0FJVF9T
UElOLAorI2VuZGlmCisJTERfV0FJVF9TTEVFUCwJCS8qIHNsZWVwaW5nIGxvY2tzLCBtdXRleF90
IGV0Yy4uICovCisKKwlMRF9XQUlUX01BWCwJCS8qIG11c3QgYmUgbGFzdCAqLworfTsKKwogI2lm
ZGVmIENPTkZJR19MT0NLREVQCiAKICNpbmNsdWRlIDxsaW51eC9saW5rYWdlLmg+CkBAIC0xMTEs
NiArMTI3LDkgQEAgc3RydWN0IGxvY2tfY2xhc3MgewogCWludAkJCQluYW1lX3ZlcnNpb247CiAJ
Y29uc3QgY2hhcgkJCSpuYW1lOwogCisJc2hvcnQJCQkJd2FpdF90eXBlX2lubmVyOworCXNob3J0
CQkJCXdhaXRfdHlwZV9vdXRlcjsKKwogI2lmZGVmIENPTkZJR19MT0NLX1NUQVQKIAl1bnNpZ25l
ZCBsb25nCQkJY29udGVudGlvbl9wb2ludFtMT0NLU1RBVF9QT0lOVFNdOwogCXVuc2lnbmVkIGxv
bmcJCQljb250ZW5kaW5nX3BvaW50W0xPQ0tTVEFUX1BPSU5UU107CkBAIC0xNTgsNiArMTc3LDgg
QEAgc3RydWN0IGxvY2tkZXBfbWFwIHsKIAlzdHJ1Y3QgbG9ja19jbGFzc19rZXkJCSprZXk7CiAJ
c3RydWN0IGxvY2tfY2xhc3MJCSpjbGFzc19jYWNoZVtOUl9MT0NLREVQX0NBQ0hJTkdfQ0xBU1NF
U107CiAJY29uc3QgY2hhcgkJCSpuYW1lOworCXNob3J0CQkJCXdhaXRfdHlwZV9vdXRlcjsgLyog
Y2FuIGJlIHRha2VuIGluIHRoaXMgY29udGV4dCAqLworCXNob3J0CQkJCXdhaXRfdHlwZV9pbm5l
cjsgLyogcHJlc2VudHMgdGhpcyBjb250ZXh0ICovCiAjaWZkZWYgQ09ORklHX0xPQ0tfU1RBVAog
CWludAkJCQljcHU7CiAJdW5zaWduZWQgbG9uZwkJCWlwOwpAQCAtMjk5LDggKzMyMCwyMSBAQCBl
eHRlcm4gdm9pZCBsb2NrZGVwX3VucmVnaXN0ZXJfa2V5KHN0cnVjCiAgKiB0byBsb2NrZGVwOgog
ICovCiAKLWV4dGVybiB2b2lkIGxvY2tkZXBfaW5pdF9tYXAoc3RydWN0IGxvY2tkZXBfbWFwICps
b2NrLCBjb25zdCBjaGFyICpuYW1lLAotCQkJICAgICBzdHJ1Y3QgbG9ja19jbGFzc19rZXkgKmtl
eSwgaW50IHN1YmNsYXNzKTsKK2V4dGVybiB2b2lkIGxvY2tkZXBfaW5pdF9tYXBfd2FpdHMoc3Ry
dWN0IGxvY2tkZXBfbWFwICpsb2NrLCBjb25zdCBjaGFyICpuYW1lLAorCXN0cnVjdCBsb2NrX2Ns
YXNzX2tleSAqa2V5LCBpbnQgc3ViY2xhc3MsIHNob3J0IGlubmVyLCBzaG9ydCBvdXRlcik7CisK
K3N0YXRpYyBpbmxpbmUgdm9pZAorbG9ja2RlcF9pbml0X21hcF93YWl0KHN0cnVjdCBsb2NrZGVw
X21hcCAqbG9jaywgY29uc3QgY2hhciAqbmFtZSwKKwkJICAgICAgc3RydWN0IGxvY2tfY2xhc3Nf
a2V5ICprZXksIGludCBzdWJjbGFzcywgc2hvcnQgaW5uZXIpCit7CisJbG9ja2RlcF9pbml0X21h
cF93YWl0cyhsb2NrLCBuYW1lLCBrZXksIHN1YmNsYXNzLCBpbm5lciwgTERfV0FJVF9JTlYpOwor
fQorCitzdGF0aWMgaW5saW5lIHZvaWQgbG9ja2RlcF9pbml0X21hcChzdHJ1Y3QgbG9ja2RlcF9t
YXAgKmxvY2ssIGNvbnN0IGNoYXIgKm5hbWUsCisJCQkgICAgIHN0cnVjdCBsb2NrX2NsYXNzX2tl
eSAqa2V5LCBpbnQgc3ViY2xhc3MpCit7CisJbG9ja2RlcF9pbml0X21hcF93YWl0KGxvY2ssIG5h
bWUsIGtleSwgc3ViY2xhc3MsIExEX1dBSVRfSU5WKTsKK30KIAogLyoKICAqIFJlaW5pdGlhbGl6
ZSBhIGxvY2sga2V5IC0gZm9yIGNhc2VzIHdoZXJlIHRoZXJlIGlzIHNwZWNpYWwgbG9ja2luZyBv
cgpAQCAtMzA4LDE4ICszNDIsMjkgQEAgZXh0ZXJuIHZvaWQgbG9ja2RlcF9pbml0X21hcChzdHJ1
Y3QgbG9jawogICogb2YgZGVwZW5kZW5jaWVzIHdyb25nOiB0aGV5IGFyZSBlaXRoZXIgdG9vIGJy
b2FkICh0aGV5IG5lZWQgYSBjbGFzcy1zcGxpdCkKICAqIG9yIHRoZXkgYXJlIHRvbyBuYXJyb3cg
KHRoZXkgc3VmZmVyIGZyb20gYSBmYWxzZSBjbGFzcy1zcGxpdCk6CiAgKi8KLSNkZWZpbmUgbG9j
a2RlcF9zZXRfY2xhc3MobG9jaywga2V5KSBcCi0JCWxvY2tkZXBfaW5pdF9tYXAoJihsb2NrKS0+
ZGVwX21hcCwgI2tleSwga2V5LCAwKQotI2RlZmluZSBsb2NrZGVwX3NldF9jbGFzc19hbmRfbmFt
ZShsb2NrLCBrZXksIG5hbWUpIFwKLQkJbG9ja2RlcF9pbml0X21hcCgmKGxvY2spLT5kZXBfbWFw
LCBuYW1lLCBrZXksIDApCi0jZGVmaW5lIGxvY2tkZXBfc2V0X2NsYXNzX2FuZF9zdWJjbGFzcyhs
b2NrLCBrZXksIHN1YikgXAotCQlsb2NrZGVwX2luaXRfbWFwKCYobG9jayktPmRlcF9tYXAsICNr
ZXksIGtleSwgc3ViKQotI2RlZmluZSBsb2NrZGVwX3NldF9zdWJjbGFzcyhsb2NrLCBzdWIpCVwK
LQkJbG9ja2RlcF9pbml0X21hcCgmKGxvY2spLT5kZXBfbWFwLCAjbG9jaywgXAotCQkJCSAobG9j
ayktPmRlcF9tYXAua2V5LCBzdWIpCisjZGVmaW5lIGxvY2tkZXBfc2V0X2NsYXNzKGxvY2ssIGtl
eSkJCQkJXAorCWxvY2tkZXBfaW5pdF9tYXBfd2FpdHMoJihsb2NrKS0+ZGVwX21hcCwgI2tleSwg
a2V5LCAwLAlcCisJCQkgICAgICAgKGxvY2spLT5kZXBfbWFwLndhaXRfdHlwZV9pbm5lciwJXAor
CQkJICAgICAgIChsb2NrKS0+ZGVwX21hcC53YWl0X3R5cGVfb3V0ZXIpCisKKyNkZWZpbmUgbG9j
a2RlcF9zZXRfY2xhc3NfYW5kX25hbWUobG9jaywga2V5LCBuYW1lKQkJXAorCWxvY2tkZXBfaW5p
dF9tYXBfd2FpdHMoJihsb2NrKS0+ZGVwX21hcCwgbmFtZSwga2V5LCAwLAlcCisJCQkgICAgICAg
KGxvY2spLT5kZXBfbWFwLndhaXRfdHlwZV9pbm5lciwJXAorCQkJICAgICAgIChsb2NrKS0+ZGVw
X21hcC53YWl0X3R5cGVfb3V0ZXIpCisKKyNkZWZpbmUgbG9ja2RlcF9zZXRfY2xhc3NfYW5kX3N1
YmNsYXNzKGxvY2ssIGtleSwgc3ViKQkJXAorCWxvY2tkZXBfaW5pdF9tYXBfd2FpdHMoJihsb2Nr
KS0+ZGVwX21hcCwgI2tleSwga2V5LCBzdWIsXAorCQkJICAgICAgIChsb2NrKS0+ZGVwX21hcC53
YWl0X3R5cGVfaW5uZXIsCVwKKwkJCSAgICAgICAobG9jayktPmRlcF9tYXAud2FpdF90eXBlX291
dGVyKQorCisjZGVmaW5lIGxvY2tkZXBfc2V0X3N1YmNsYXNzKGxvY2ssIHN1YikJCQkJCVwKKwls
b2NrZGVwX2luaXRfbWFwX3dhaXRzKCYobG9jayktPmRlcF9tYXAsICNsb2NrLCAobG9jayktPmRl
cF9tYXAua2V5LCBzdWIsXAorCQkJICAgICAgIChsb2NrKS0+ZGVwX21hcC53YWl0X3R5cGVfaW5u
ZXIsCQlcCisJCQkgICAgICAgKGxvY2spLT5kZXBfbWFwLndhaXRfdHlwZV9vdXRlcikKIAogI2Rl
ZmluZSBsb2NrZGVwX3NldF9ub3ZhbGlkYXRlX2NsYXNzKGxvY2spIFwKIAlsb2NrZGVwX3NldF9j
bGFzc19hbmRfbmFtZShsb2NrLCAmX19sb2NrZGVwX25vX3ZhbGlkYXRlX18sICNsb2NrKQorCiAv
KgogICogQ29tcGFyZSBsb2NraW5nIGNsYXNzZXMKICAqLwpAQCAtNDMyLDYgKzQ3NywxMCBAQCBz
dGF0aWMgaW5saW5lIHZvaWQgbG9ja2RlcF9zZXRfc2VsZnRlc3RfCiAjIGRlZmluZSBsb2NrX3Nl
dF9jbGFzcyhsLCBuLCBrLCBzLCBpKQkJZG8geyB9IHdoaWxlICgwKQogIyBkZWZpbmUgbG9ja19z
ZXRfc3ViY2xhc3MobCwgcywgaSkJCWRvIHsgfSB3aGlsZSAoMCkKICMgZGVmaW5lIGxvY2tkZXBf
aW5pdCgpCQkJCWRvIHsgfSB3aGlsZSAoMCkKKyMgZGVmaW5lIGxvY2tkZXBfaW5pdF9tYXBfd2Fp
dHMobG9jaywgbmFtZSwga2V5LCBzdWIsIGlubmVyLCBvdXRlcikgXAorCQlkbyB7ICh2b2lkKShu
YW1lKTsgKHZvaWQpKGtleSk7IH0gd2hpbGUgKDApCisjIGRlZmluZSBsb2NrZGVwX2luaXRfbWFw
X3dhaXQobG9jaywgbmFtZSwga2V5LCBzdWIsIGlubmVyKSBcCisJCWRvIHsgKHZvaWQpKG5hbWUp
OyAodm9pZCkoa2V5KTsgfSB3aGlsZSAoMCkKICMgZGVmaW5lIGxvY2tkZXBfaW5pdF9tYXAobG9j
aywgbmFtZSwga2V5LCBzdWIpIFwKIAkJZG8geyAodm9pZCkobmFtZSk7ICh2b2lkKShrZXkpOyB9
IHdoaWxlICgwKQogIyBkZWZpbmUgbG9ja2RlcF9zZXRfY2xhc3MobG9jaywga2V5KQkJZG8geyAo
dm9pZCkoa2V5KTsgfSB3aGlsZSAoMCkKLS0tIGEvaW5jbHVkZS9saW51eC9tdXRleC5oCisrKyBi
L2luY2x1ZGUvbGludXgvbXV0ZXguaApAQCAtMTA5LDggKzEwOSwxMSBAQCBkbyB7CQkJCQkJCQkJ
XAogfSB3aGlsZSAoMCkKIAogI2lmZGVmIENPTkZJR19ERUJVR19MT0NLX0FMTE9DCi0jIGRlZmlu
ZSBfX0RFUF9NQVBfTVVURVhfSU5JVElBTElaRVIobG9ja25hbWUpIFwKLQkJLCAuZGVwX21hcCA9
IHsgLm5hbWUgPSAjbG9ja25hbWUgfQorIyBkZWZpbmUgX19ERVBfTUFQX01VVEVYX0lOSVRJQUxJ
WkVSKGxvY2tuYW1lKQkJCVwKKwkJLCAuZGVwX21hcCA9IHsJCQkJCVwKKwkJCS5uYW1lID0gI2xv
Y2tuYW1lLAkJCVwKKwkJCS53YWl0X3R5cGVfaW5uZXIgPSBMRF9XQUlUX1NMRUVQLAlcCisJCX0K
ICNlbHNlCiAjIGRlZmluZSBfX0RFUF9NQVBfTVVURVhfSU5JVElBTElaRVIobG9ja25hbWUpCiAj
ZW5kaWYKLS0tIGEvaW5jbHVkZS9saW51eC9yd2xvY2tfdHlwZXMuaAorKysgYi9pbmNsdWRlL2xp
bnV4L3J3bG9ja190eXBlcy5oCkBAIC0yMiw3ICsyMiwxMSBAQCB0eXBlZGVmIHN0cnVjdCB7CiAj
ZGVmaW5lIFJXTE9DS19NQUdJQwkJMHhkZWFmMWVlZAogCiAjaWZkZWYgQ09ORklHX0RFQlVHX0xP
Q0tfQUxMT0MKLSMgZGVmaW5lIFJXX0RFUF9NQVBfSU5JVChsb2NrbmFtZSkJLmRlcF9tYXAgPSB7
IC5uYW1lID0gI2xvY2tuYW1lIH0KKyMgZGVmaW5lIFJXX0RFUF9NQVBfSU5JVChsb2NrbmFtZSkJ
CQkJCVwKKwkuZGVwX21hcCA9IHsJCQkJCQkJXAorCQkubmFtZSA9ICNsb2NrbmFtZSwJCQkJCVwK
KwkJLndhaXRfdHlwZV9pbm5lciA9IExEX1dBSVRfQ09ORklHLAkJCVwKKwl9CiAjZWxzZQogIyBk
ZWZpbmUgUldfREVQX01BUF9JTklUKGxvY2tuYW1lKQogI2VuZGlmCi0tLSBhL2luY2x1ZGUvbGlu
dXgvcndzZW0uaAorKysgYi9pbmNsdWRlL2xpbnV4L3J3c2VtLmgKQEAgLTcxLDcgKzcxLDExIEBA
IHN0YXRpYyBpbmxpbmUgaW50IHJ3c2VtX2lzX2xvY2tlZChzdHJ1Y3QKIC8qIENvbW1vbiBpbml0
aWFsaXplciBtYWNyb3MgYW5kIGZ1bmN0aW9ucyAqLwogCiAjaWZkZWYgQ09ORklHX0RFQlVHX0xP
Q0tfQUxMT0MKLSMgZGVmaW5lIF9fUldTRU1fREVQX01BUF9JTklUKGxvY2tuYW1lKSAsIC5kZXBf
bWFwID0geyAubmFtZSA9ICNsb2NrbmFtZSB9CisjIGRlZmluZSBfX1JXU0VNX0RFUF9NQVBfSU5J
VChsb2NrbmFtZSkJCQlcCisJLCAuZGVwX21hcCA9IHsJCQkJCVwKKwkJLm5hbWUgPSAjbG9ja25h
bWUsCQkJXAorCQkud2FpdF90eXBlX2lubmVyID0gTERfV0FJVF9TTEVFUCwJXAorCX0KICNlbHNl
CiAjIGRlZmluZSBfX1JXU0VNX0RFUF9NQVBfSU5JVChsb2NrbmFtZSkKICNlbmRpZgotLS0gYS9p
bmNsdWRlL2xpbnV4L3NjaGVkLmgKKysrIGIvaW5jbHVkZS9saW51eC9zY2hlZC5oCkBAIC05NzAs
NiArOTcwLDcgQEAgc3RydWN0IHRhc2tfc3RydWN0IHsKIAogI2lmZGVmIENPTkZJR19UUkFDRV9J
UlFGTEFHUwogCXVuc2lnbmVkIGludAkJCWlycV9ldmVudHM7CisJdW5zaWduZWQgaW50CQkJaGFy
ZGlycV90aHJlYWRlZDsKIAl1bnNpZ25lZCBsb25nCQkJaGFyZGlycV9lbmFibGVfaXA7CiAJdW5z
aWduZWQgbG9uZwkJCWhhcmRpcnFfZGlzYWJsZV9pcDsKIAl1bnNpZ25lZCBpbnQJCQloYXJkaXJx
X2VuYWJsZV9ldmVudDsKLS0tIGEvaW5jbHVkZS9saW51eC9zcGlubG9jay5oCisrKyBiL2luY2x1
ZGUvbGludXgvc3BpbmxvY2suaApAQCAtOTMsMTIgKzkzLDEzIEBACiAKICNpZmRlZiBDT05GSUdf
REVCVUdfU1BJTkxPQ0sKICAgZXh0ZXJuIHZvaWQgX19yYXdfc3Bpbl9sb2NrX2luaXQocmF3X3Nw
aW5sb2NrX3QgKmxvY2ssIGNvbnN0IGNoYXIgKm5hbWUsCi0JCQkJICAgc3RydWN0IGxvY2tfY2xh
c3Nfa2V5ICprZXkpOwotIyBkZWZpbmUgcmF3X3NwaW5fbG9ja19pbml0KGxvY2spCQkJCVwKLWRv
IHsJCQkJCQkJCVwKLQlzdGF0aWMgc3RydWN0IGxvY2tfY2xhc3Nfa2V5IF9fa2V5OwkJCVwKLQkJ
CQkJCQkJXAotCV9fcmF3X3NwaW5fbG9ja19pbml0KChsb2NrKSwgI2xvY2ssICZfX2tleSk7CQlc
CisJCQkJICAgc3RydWN0IGxvY2tfY2xhc3Nfa2V5ICprZXksIHNob3J0IGlubmVyKTsKKworIyBk
ZWZpbmUgcmF3X3NwaW5fbG9ja19pbml0KGxvY2spCQkJCQlcCitkbyB7CQkJCQkJCQkJXAorCXN0
YXRpYyBzdHJ1Y3QgbG9ja19jbGFzc19rZXkgX19rZXk7CQkJCVwKKwkJCQkJCQkJCVwKKwlfX3Jh
d19zcGluX2xvY2tfaW5pdCgobG9jayksICNsb2NrLCAmX19rZXksIExEX1dBSVRfU1BJTik7CVwK
IH0gd2hpbGUgKDApCiAKICNlbHNlCkBAIC0zMjcsMTIgKzMyOCwyNiBAQCBzdGF0aWMgX19hbHdh
eXNfaW5saW5lIHJhd19zcGlubG9ja190ICpzCiAJcmV0dXJuICZsb2NrLT5ybG9jazsKIH0KIAot
I2RlZmluZSBzcGluX2xvY2tfaW5pdChfbG9jaykJCQkJXAotZG8gewkJCQkJCQlcCi0Jc3Bpbmxv
Y2tfY2hlY2soX2xvY2spOwkJCQlcCi0JcmF3X3NwaW5fbG9ja19pbml0KCYoX2xvY2spLT5ybG9j
ayk7CQlcCisjaWZkZWYgQ09ORklHX0RFQlVHX1NQSU5MT0NLCisKKyMgZGVmaW5lIHNwaW5fbG9j
a19pbml0KGxvY2spCQkJCQlcCitkbyB7CQkJCQkJCQlcCisJc3RhdGljIHN0cnVjdCBsb2NrX2Ns
YXNzX2tleSBfX2tleTsJCQlcCisJCQkJCQkJCVwKKwlfX3Jhd19zcGluX2xvY2tfaW5pdChzcGlu
bG9ja19jaGVjayhsb2NrKSwJCVwKKwkJCSAgICAgI2xvY2ssICZfX2tleSwgTERfV0FJVF9DT05G
SUcpOwlcCit9IHdoaWxlICgwKQorCisjZWxzZQorCisjIGRlZmluZSBzcGluX2xvY2tfaW5pdChf
bG9jaykJCQlcCitkbyB7CQkJCQkJXAorCXNwaW5sb2NrX2NoZWNrKF9sb2NrKTsJCQlcCisJKihf
bG9jaykgPSBfX1NQSU5fTE9DS19VTkxPQ0tFRChfbG9jayk7CVwKIH0gd2hpbGUgKDApCiAKKyNl
bmRpZgorCiBzdGF0aWMgX19hbHdheXNfaW5saW5lIHZvaWQgc3Bpbl9sb2NrKHNwaW5sb2NrX3Qg
KmxvY2spCiB7CiAJcmF3X3NwaW5fbG9jaygmbG9jay0+cmxvY2spOwotLS0gYS9pbmNsdWRlL2xp
bnV4L3NwaW5sb2NrX3R5cGVzLmgKKysrIGIvaW5jbHVkZS9saW51eC9zcGlubG9ja190eXBlcy5o
CkBAIC0zMyw4ICszMywxOCBAQCB0eXBlZGVmIHN0cnVjdCByYXdfc3BpbmxvY2sgewogI2RlZmlu
ZSBTUElOTE9DS19PV05FUl9JTklUCSgodm9pZCAqKS0xTCkKIAogI2lmZGVmIENPTkZJR19ERUJV
R19MT0NLX0FMTE9DCi0jIGRlZmluZSBTUElOX0RFUF9NQVBfSU5JVChsb2NrbmFtZSkJLmRlcF9t
YXAgPSB7IC5uYW1lID0gI2xvY2tuYW1lIH0KKyMgZGVmaW5lIFJBV19TUElOX0RFUF9NQVBfSU5J
VChsb2NrbmFtZSkJCVwKKwkuZGVwX21hcCA9IHsJCQkJCVwKKwkJLm5hbWUgPSAjbG9ja25hbWUs
CQkJXAorCQkud2FpdF90eXBlX2lubmVyID0gTERfV0FJVF9TUElOLAlcCisJfQorIyBkZWZpbmUg
U1BJTl9ERVBfTUFQX0lOSVQobG9ja25hbWUpCQkJXAorCS5kZXBfbWFwID0gewkJCQkJXAorCQku
bmFtZSA9ICNsb2NrbmFtZSwJCQlcCisJCS53YWl0X3R5cGVfaW5uZXIgPSBMRF9XQUlUX0NPTkZJ
RywJXAorCX0KICNlbHNlCisjIGRlZmluZSBSQVdfU1BJTl9ERVBfTUFQX0lOSVQobG9ja25hbWUp
CiAjIGRlZmluZSBTUElOX0RFUF9NQVBfSU5JVChsb2NrbmFtZSkKICNlbmRpZgogCkBAIC01MSw3
ICs2MSw3IEBAIHR5cGVkZWYgc3RydWN0IHJhd19zcGlubG9jayB7CiAJewkJCQkJXAogCS5yYXdf
bG9jayA9IF9fQVJDSF9TUElOX0xPQ0tfVU5MT0NLRUQsCVwKIAlTUElOX0RFQlVHX0lOSVQobG9j
a25hbWUpCQlcCi0JU1BJTl9ERVBfTUFQX0lOSVQobG9ja25hbWUpIH0KKwlSQVdfU1BJTl9ERVBf
TUFQX0lOSVQobG9ja25hbWUpIH0KIAogI2RlZmluZSBfX1JBV19TUElOX0xPQ0tfVU5MT0NLRUQo
bG9ja25hbWUpCVwKIAkocmF3X3NwaW5sb2NrX3QpIF9fUkFXX1NQSU5fTE9DS19JTklUSUFMSVpF
Uihsb2NrbmFtZSkKQEAgLTcyLDExICs4MiwxNyBAQCB0eXBlZGVmIHN0cnVjdCBzcGlubG9jayB7
CiAJfTsKIH0gc3BpbmxvY2tfdDsKIAorI2RlZmluZSBfX19TUElOX0xPQ0tfSU5JVElBTElaRVIo
bG9ja25hbWUpCVwKKwl7CQkJCQlcCisJLnJhd19sb2NrID0gX19BUkNIX1NQSU5fTE9DS19VTkxP
Q0tFRCwJXAorCVNQSU5fREVCVUdfSU5JVChsb2NrbmFtZSkJCVwKKwlTUElOX0RFUF9NQVBfSU5J
VChsb2NrbmFtZSkgfQorCiAjZGVmaW5lIF9fU1BJTl9MT0NLX0lOSVRJQUxJWkVSKGxvY2tuYW1l
KSBcCi0JeyB7IC5ybG9jayA9IF9fUkFXX1NQSU5fTE9DS19JTklUSUFMSVpFUihsb2NrbmFtZSkg
fSB9CisJeyB7IC5ybG9jayA9IF9fX1NQSU5fTE9DS19JTklUSUFMSVpFUihsb2NrbmFtZSkgfSB9
CiAKICNkZWZpbmUgX19TUElOX0xPQ0tfVU5MT0NLRUQobG9ja25hbWUpIFwKLQkoc3BpbmxvY2tf
dCApIF9fU1BJTl9MT0NLX0lOSVRJQUxJWkVSKGxvY2tuYW1lKQorCShzcGlubG9ja190KSBfX1NQ
SU5fTE9DS19JTklUSUFMSVpFUihsb2NrbmFtZSkKIAogI2RlZmluZSBERUZJTkVfU1BJTkxPQ0so
eCkJc3BpbmxvY2tfdCB4ID0gX19TUElOX0xPQ0tfVU5MT0NLRUQoeCkKIAotLS0gYS9rZXJuZWwv
aXJxL2hhbmRsZS5jCisrKyBiL2tlcm5lbC9pcnEvaGFuZGxlLmMKQEAgLTE0NSw2ICsxNDUsMTMg
QEAgaXJxcmV0dXJuX3QgX19oYW5kbGVfaXJxX2V2ZW50X3BlcmNwdShzdAogCWZvcl9lYWNoX2Fj
dGlvbl9vZl9kZXNjKGRlc2MsIGFjdGlvbikgewogCQlpcnFyZXR1cm5fdCByZXM7CiAKKwkJLyoK
KwkJICogSWYgdGhpcyBJUlEgd291bGQgYmUgdGhyZWFkZWQgdW5kZXIgZm9yY2VfaXJxdGhyZWFk
cywgbWFyayBpdCBzby4KKwkJICovCisJCWlmIChpcnFfc2V0dGluZ3NfY2FuX3RocmVhZChkZXNj
KSAmJgorCQkgICAgIShhY3Rpb24tPmZsYWdzICYgKElSUUZfTk9fVEhSRUFEIHwgSVJRRl9QRVJD
UFUgfCBJUlFGX09ORVNIT1QpKSkKKwkJCXRyYWNlX2hhcmRpcnFfdGhyZWFkZWQoKTsKKwogCQl0
cmFjZV9pcnFfaGFuZGxlcl9lbnRyeShpcnEsIGFjdGlvbik7CiAJCXJlcyA9IGFjdGlvbi0+aGFu
ZGxlcihpcnEsIGFjdGlvbi0+ZGV2X2lkKTsKIAkJdHJhY2VfaXJxX2hhbmRsZXJfZXhpdChpcnEs
IGFjdGlvbiwgcmVzKTsKLS0tIGEva2VybmVsL2xvY2tpbmcvbG9ja2RlcC5jCisrKyBiL2tlcm5l
bC9sb2NraW5nL2xvY2tkZXAuYwpAQCAtNjUzLDcgKzY1Myw5IEBAIHN0YXRpYyB2b2lkIHByaW50
X2xvY2tfbmFtZShzdHJ1Y3QgbG9ja18KIAogCXByaW50ayhLRVJOX0NPTlQgIiAoIik7CiAJX19w
cmludF9sb2NrX25hbWUoY2xhc3MpOwotCXByaW50ayhLRVJOX0NPTlQgIil7JXN9IiwgdXNhZ2Up
OworCXByaW50ayhLRVJOX0NPTlQgIil7JXN9LXslaGQ6JWhkfSIsIHVzYWdlLAorCQkJY2xhc3Mt
PndhaXRfdHlwZV9vdXRlciA/OiBjbGFzcy0+d2FpdF90eXBlX2lubmVyLAorCQkJY2xhc3MtPndh
aXRfdHlwZV9pbm5lcik7CiB9CiAKIHN0YXRpYyB2b2lkIHByaW50X2xvY2tkZXBfY2FjaGUoc3Ry
dWN0IGxvY2tkZXBfbWFwICpsb2NrKQpAQCAtMTIzMCw2ICsxMjMyLDggQEAgcmVnaXN0ZXJfbG9j
a19jbGFzcyhzdHJ1Y3QgbG9ja2RlcF9tYXAgKgogCVdBUk5fT05fT05DRSghbGlzdF9lbXB0eSgm
Y2xhc3MtPmxvY2tzX2JlZm9yZSkpOwogCVdBUk5fT05fT05DRSghbGlzdF9lbXB0eSgmY2xhc3Mt
PmxvY2tzX2FmdGVyKSk7CiAJY2xhc3MtPm5hbWVfdmVyc2lvbiA9IGNvdW50X21hdGNoaW5nX25h
bWVzKGNsYXNzKTsKKwljbGFzcy0+d2FpdF90eXBlX2lubmVyID0gbG9jay0+d2FpdF90eXBlX2lu
bmVyOworCWNsYXNzLT53YWl0X3R5cGVfb3V0ZXIgPSBsb2NrLT53YWl0X3R5cGVfb3V0ZXI7CiAJ
LyoKIAkgKiBXZSB1c2UgUkNVJ3Mgc2FmZSBsaXN0LWFkZCBtZXRob2QgdG8gbWFrZQogCSAqIHBh
cmFsbGVsIHdhbGtpbmcgb2YgdGhlIGhhc2gtbGlzdCBzYWZlOgpAQCAtMzY4Miw2ICszNjg2LDEx
MyBAQCBzdGF0aWMgaW50IG1hcmtfbG9jayhzdHJ1Y3QgdGFza19zdHJ1Y3QKIAlyZXR1cm4gcmV0
OwogfQogCitzdGF0aWMgaW50CitwcmludF9sb2NrX2ludmFsaWRfd2FpdF9jb250ZXh0KHN0cnVj
dCB0YXNrX3N0cnVjdCAqY3VyciwKKwkJCQlzdHJ1Y3QgaGVsZF9sb2NrICpobG9jaykKK3sKKwlp
ZiAoIWRlYnVnX2xvY2tzX29mZigpKQorCQlyZXR1cm4gMDsKKwlpZiAoZGVidWdfbG9ja3Nfc2ls
ZW50KQorCQlyZXR1cm4gMDsKKworCXByX3dhcm4oIlxuIik7CisJcHJfd2FybigiPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT1cbiIpOworCXByX3dhcm4oIlsgQlVHOiBJbnZhbGlkIHdhaXQg
Y29udGV4dCBdXG4iKTsKKwlwcmludF9rZXJuZWxfaWRlbnQoKTsKKwlwcl93YXJuKCItLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLVxuIik7CisKKwlwcl93YXJuKCIlcy8lZCBpcyB0cnlpbmcg
dG8gbG9jazpcbiIsIGN1cnItPmNvbW0sIHRhc2tfcGlkX25yKGN1cnIpKTsKKwlwcmludF9sb2Nr
KGhsb2NrKTsKKworCXByX3dhcm4oIm90aGVyIGluZm8gdGhhdCBtaWdodCBoZWxwIHVzIGRlYnVn
IHRoaXM6XG4iKTsKKwlsb2NrZGVwX3ByaW50X2hlbGRfbG9ja3MoY3Vycik7CisKKwlwcl93YXJu
KCJzdGFjayBiYWNrdHJhY2U6XG4iKTsKKwlkdW1wX3N0YWNrKCk7CisKKwlyZXR1cm4gMDsKK30K
KworLyoKKyAqIFZlcmlmeSB0aGUgd2FpdF90eXBlIGNvbnRleHQuCisgKgorICogVGhpcyBjaGVj
ayB2YWxpZGF0ZXMgd2UgdGFrZXMgbG9ja3MgaW4gdGhlIHJpZ2h0IHdhaXQtdHlwZSBvcmRlcjsg
dGhhdCBpcyBpdAorICogZW5zdXJlcyB0aGF0IHdlIGRvIG5vdCB0YWtlIG11dGV4ZXMgaW5zaWRl
IHNwaW5sb2NrcyBhbmQgZG8gbm90IGF0dGVtcHQgdG8KKyAqIGFjcXVpcmUgc3BpbmxvY2tzIGlu
c2lkZSByYXdfc3BpbmxvY2tzIGFuZCB0aGUgc29ydC4KKyAqCisgKiBUaGUgZW50aXJlIHRoaW5n
IGlzIHNsaWdodGx5IG1vcmUgY29tcGxleCBiZWNhdXNlIG9mIFJDVSwgUkNVIGlzIGEgbG9jayB0
aGF0CisgKiBjYW4gYmUgdGFrZW4gZnJvbSAocHJldHR5IG11Y2gpIGFueSBjb250ZXh0IGJ1dCBh
bHNvIGhhcyBjb25zdHJhaW50cy4KKyAqIEhvd2V2ZXIgd2hlbiB0YWtlbiBpbiBhIHN0cmljdGVy
IGVudmlyb25tZW50IHRoZSBSQ1UgbG9jayBkb2VzIG5vdCBsb29zZW4KKyAqIHRoZSBjb25zdHJh
aW50cy4KKyAqCisgKiBUaGVyZWZvcmUgd2UgbXVzdCBsb29rIGZvciB0aGUgc3RyaWN0ZXN0IGVu
dmlyb25tZW50IGluIHRoZSBsb2NrIHN0YWNrIGFuZAorICogY29tcGFyZSB0aGF0IHRvIHRoZSBs
b2NrIHdlJ3JlIHRyeWluZyB0byBhY3F1aXJlLgorICovCitzdGF0aWMgaW50IGNoZWNrX3dhaXRf
Y29udGV4dChzdHJ1Y3QgdGFza19zdHJ1Y3QgKmN1cnIsIHN0cnVjdCBoZWxkX2xvY2sgKm5leHQp
Cit7CisJc2hvcnQgbmV4dF9pbm5lciA9IGhsb2NrX2NsYXNzKG5leHQpLT53YWl0X3R5cGVfaW5u
ZXI7CisJc2hvcnQgbmV4dF9vdXRlciA9IGhsb2NrX2NsYXNzKG5leHQpLT53YWl0X3R5cGVfb3V0
ZXI7CisJc2hvcnQgY3Vycl9pbm5lcjsKKwlpbnQgZGVwdGg7CisKKwlpZiAoIWN1cnItPmxvY2tk
ZXBfZGVwdGggfHwgIW5leHRfaW5uZXIgfHwgbmV4dC0+dHJ5bG9jaykKKwkJcmV0dXJuIDA7CisK
KwlpZiAoIW5leHRfb3V0ZXIpCisJCW5leHRfb3V0ZXIgPSBuZXh0X2lubmVyOworCisJLyoKKwkg
KiBGaW5kIHN0YXJ0IG9mIGN1cnJlbnQgaXJxX2NvbnRleHQuLgorCSAqLworCWZvciAoZGVwdGgg
PSBjdXJyLT5sb2NrZGVwX2RlcHRoIC0gMTsgZGVwdGggPj0gMDsgZGVwdGgtLSkgeworCQlzdHJ1
Y3QgaGVsZF9sb2NrICpwcmV2ID0gY3Vyci0+aGVsZF9sb2NrcyArIGRlcHRoOworCQlpZiAocHJl
di0+aXJxX2NvbnRleHQgIT0gbmV4dC0+aXJxX2NvbnRleHQpCisJCQlicmVhazsKKwl9CisJZGVw
dGgrKzsKKworCS8qCisJICogU2V0IGFwcHJvcHJpYXRlIHdhaXQgdHlwZSBmb3IgdGhlIGNvbnRl
eHQ7IGZvciBJUlFzIHdlIGhhdmUgdG8gdGFrZQorCSAqIGludG8gYWNjb3VudCBmb3JjZV9pcnF0
aHJlYWQgYXMgdGhhdCBpcyBpbXBsaWVkIGJ5IFBSRUVNUFRfUlQuCisJICovCisJaWYgKGN1cnIt
PmhhcmRpcnFfY29udGV4dCkgeworCQkvKgorCQkgKiBDaGVjayBpZiBmb3JjZV9pcnF0aHJlYWRz
IHdpbGwgcnVuIHVzIHRocmVhZGVkLgorCQkgKi8KKwkJaWYgKGN1cnItPmhhcmRpcnFfdGhyZWFk
ZWQpCisJCQljdXJyX2lubmVyID0gTERfV0FJVF9DT05GSUc7CisJCWVsc2UKKwkJCWN1cnJfaW5u
ZXIgPSBMRF9XQUlUX1NQSU47CisJfSBlbHNlIGlmIChjdXJyLT5zb2Z0aXJxX2NvbnRleHQpIHsK
KwkJLyoKKwkJICogU29mdGlycXMgYXJlIGFsd2F5cyB0aHJlYWRlZC4KKwkJICovCisJCWN1cnJf
aW5uZXIgPSBMRF9XQUlUX0NPTkZJRzsKKwl9IGVsc2UgeworCQljdXJyX2lubmVyID0gTERfV0FJ
VF9NQVg7CisJfQorCisJZm9yICg7IGRlcHRoIDwgY3Vyci0+bG9ja2RlcF9kZXB0aDsgZGVwdGgr
KykgeworCQlzdHJ1Y3QgaGVsZF9sb2NrICpwcmV2ID0gY3Vyci0+aGVsZF9sb2NrcyArIGRlcHRo
OworCQlzaG9ydCBwcmV2X2lubmVyID0gaGxvY2tfY2xhc3MocHJldiktPndhaXRfdHlwZV9pbm5l
cjsKKworCQlpZiAocHJldl9pbm5lcikgeworCQkJLyoKKwkJCSAqIFdlIGNhbiBoYXZlIGEgYmln
Z2VyIGlubmVyIHRoYW4gYSBwcmV2aW91cyBvbmUKKwkJCSAqIHdoZW4gb3V0ZXIgaXMgc21hbGxl
ciB0aGFuIGlubmVyLCBhcyB3aXRoIFJDVS4KKwkJCSAqCisJCQkgKiBBbHNvIGR1ZSB0byB0cnls
b2Nrcy4KKwkJCSAqLworCQkJY3Vycl9pbm5lciA9IG1pbihjdXJyX2lubmVyLCBwcmV2X2lubmVy
KTsKKwkJfQorCX0KKworCWlmIChuZXh0X291dGVyID4gY3Vycl9pbm5lcikKKwkJcmV0dXJuIHBy
aW50X2xvY2tfaW52YWxpZF93YWl0X2NvbnRleHQoY3VyciwgbmV4dCk7CisKKwlyZXR1cm4gMDsK
K30KKwogI2Vsc2UgLyogQ09ORklHX1BST1ZFX0xPQ0tJTkcgKi8KIAogc3RhdGljIGlubGluZSBp
bnQKQEAgLTM3MDEsMTMgKzM4MTIsMjAgQEAgc3RhdGljIGlubGluZSBpbnQgc2VwYXJhdGVfaXJx
X2NvbnRleHQocwogCXJldHVybiAwOwogfQogCitzdGF0aWMgaW5saW5lIGludCBjaGVja193YWl0
X2NvbnRleHQoc3RydWN0IHRhc2tfc3RydWN0ICpjdXJyLAorCQkJCSAgICAgc3RydWN0IGhlbGRf
bG9jayAqbmV4dCkKK3sKKwlyZXR1cm4gMDsKK30KKwogI2VuZGlmIC8qIENPTkZJR19QUk9WRV9M
T0NLSU5HICovCiAKIC8qCiAgKiBJbml0aWFsaXplIGEgbG9jayBpbnN0YW5jZSdzIGxvY2stY2xh
c3MgbWFwcGluZyBpbmZvOgogICovCi12b2lkIGxvY2tkZXBfaW5pdF9tYXAoc3RydWN0IGxvY2tk
ZXBfbWFwICpsb2NrLCBjb25zdCBjaGFyICpuYW1lLAotCQkgICAgICBzdHJ1Y3QgbG9ja19jbGFz
c19rZXkgKmtleSwgaW50IHN1YmNsYXNzKQordm9pZCBsb2NrZGVwX2luaXRfbWFwX3dhaXRzKHN0
cnVjdCBsb2NrZGVwX21hcCAqbG9jaywgY29uc3QgY2hhciAqbmFtZSwKKwkJCSAgICBzdHJ1Y3Qg
bG9ja19jbGFzc19rZXkgKmtleSwgaW50IHN1YmNsYXNzLAorCQkJICAgIHNob3J0IGlubmVyLCBz
aG9ydCBvdXRlcikKIHsKIAlpbnQgaTsKIApAQCAtMzcyOCw2ICszODQ2LDkgQEAgdm9pZCBsb2Nr
ZGVwX2luaXRfbWFwKHN0cnVjdCBsb2NrZGVwX21hcAogCiAJbG9jay0+bmFtZSA9IG5hbWU7CiAK
Kwlsb2NrLT53YWl0X3R5cGVfb3V0ZXIgPSBvdXRlcjsKKwlsb2NrLT53YWl0X3R5cGVfaW5uZXIg
PSBpbm5lcjsKKwogCS8qCiAJICogTm8ga2V5LCBubyBqb3ksIHdlIG5lZWQgdG8gaGFzaCBzb21l
dGhpbmcuCiAJICovCkBAIC0zNzYxLDcgKzM4ODIsNyBAQCB2b2lkIGxvY2tkZXBfaW5pdF9tYXAo
c3RydWN0IGxvY2tkZXBfbWFwCiAJCXJhd19sb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7CiAJfQog
fQotRVhQT1JUX1NZTUJPTF9HUEwobG9ja2RlcF9pbml0X21hcCk7CitFWFBPUlRfU1lNQk9MX0dQ
TChsb2NrZGVwX2luaXRfbWFwX3dhaXRzKTsKIAogc3RydWN0IGxvY2tfY2xhc3Nfa2V5IF9fbG9j
a2RlcF9ub192YWxpZGF0ZV9fOwogRVhQT1JUX1NZTUJPTF9HUEwoX19sb2NrZGVwX25vX3ZhbGlk
YXRlX18pOwpAQCAtMzg2Miw3ICszOTgzLDcgQEAgc3RhdGljIGludCBfX2xvY2tfYWNxdWlyZShz
dHJ1Y3QgbG9ja2RlcAogCiAJY2xhc3NfaWR4ID0gY2xhc3MgLSBsb2NrX2NsYXNzZXM7CiAKLQlp
ZiAoZGVwdGgpIHsKKwlpZiAoZGVwdGgpIHsgLyogd2UncmUgaG9sZGluZyBsb2NrcyAqLwogCQlo
bG9jayA9IGN1cnItPmhlbGRfbG9ja3MgKyBkZXB0aCAtIDE7CiAJCWlmIChobG9jay0+Y2xhc3Nf
aWR4ID09IGNsYXNzX2lkeCAmJiBuZXN0X2xvY2spIHsKIAkJCWlmICghcmVmZXJlbmNlcykKQEAg
LTM5MDQsNiArNDAyNSw5IEBAIHN0YXRpYyBpbnQgX19sb2NrX2FjcXVpcmUoc3RydWN0IGxvY2tk
ZXAKICNlbmRpZgogCWhsb2NrLT5waW5fY291bnQgPSBwaW5fY291bnQ7CiAKKwlpZiAoY2hlY2tf
d2FpdF9jb250ZXh0KGN1cnIsIGhsb2NrKSkKKwkJcmV0dXJuIDA7CisKIAkvKiBJbml0aWFsaXpl
IHRoZSBsb2NrIHVzYWdlIGJpdCAqLwogCWlmICghbWFya191c2FnZShjdXJyLCBobG9jaywgY2hl
Y2spKQogCQlyZXR1cm4gMDsKQEAgLTQxMzksNyArNDI2Myw5IEBAIHN0YXRpYyBpbnQKIAkJcmV0
dXJuIDA7CiAJfQogCi0JbG9ja2RlcF9pbml0X21hcChsb2NrLCBuYW1lLCBrZXksIDApOworCWxv
Y2tkZXBfaW5pdF9tYXBfd2FpdHMobG9jaywgbmFtZSwga2V5LCAwLAorCQkJICAgICAgIGxvY2st
PndhaXRfdHlwZV9pbm5lciwKKwkJCSAgICAgICBsb2NrLT53YWl0X3R5cGVfb3V0ZXIpOwogCWNs
YXNzID0gcmVnaXN0ZXJfbG9ja19jbGFzcyhsb2NrLCBzdWJjbGFzcywgMCk7CiAJaGxvY2stPmNs
YXNzX2lkeCA9IGNsYXNzIC0gbG9ja19jbGFzc2VzOwogCi0tLSBhL2tlcm5lbC9sb2NraW5nL211
dGV4LWRlYnVnLmMKKysrIGIva2VybmVsL2xvY2tpbmcvbXV0ZXgtZGVidWcuYwpAQCAtODUsNyAr
ODUsNyBAQCB2b2lkIGRlYnVnX211dGV4X2luaXQoc3RydWN0IG11dGV4ICpsb2NrCiAJICogTWFr
ZSBzdXJlIHdlIGFyZSBub3QgcmVpbml0aWFsaXppbmcgYSBoZWxkIGxvY2s6CiAJICovCiAJZGVi
dWdfY2hlY2tfbm9fbG9ja3NfZnJlZWQoKHZvaWQgKilsb2NrLCBzaXplb2YoKmxvY2spKTsKLQls
b2NrZGVwX2luaXRfbWFwKCZsb2NrLT5kZXBfbWFwLCBuYW1lLCBrZXksIDApOworCWxvY2tkZXBf
aW5pdF9tYXBfd2FpdCgmbG9jay0+ZGVwX21hcCwgbmFtZSwga2V5LCAwLCBMRF9XQUlUX1NMRUVQ
KTsKICNlbmRpZgogCWxvY2stPm1hZ2ljID0gbG9jazsKIH0KLS0tIGEva2VybmVsL2xvY2tpbmcv
cndzZW0uYworKysgYi9rZXJuZWwvbG9ja2luZy9yd3NlbS5jCkBAIC0zMjksNyArMzI5LDcgQEAg
dm9pZCBfX2luaXRfcndzZW0oc3RydWN0IHJ3X3NlbWFwaG9yZSAqcwogCSAqIE1ha2Ugc3VyZSB3
ZSBhcmUgbm90IHJlaW5pdGlhbGl6aW5nIGEgaGVsZCBzZW1hcGhvcmU6CiAJICovCiAJZGVidWdf
Y2hlY2tfbm9fbG9ja3NfZnJlZWQoKHZvaWQgKilzZW0sIHNpemVvZigqc2VtKSk7Ci0JbG9ja2Rl
cF9pbml0X21hcCgmc2VtLT5kZXBfbWFwLCBuYW1lLCBrZXksIDApOworCWxvY2tkZXBfaW5pdF9t
YXBfd2FpdCgmc2VtLT5kZXBfbWFwLCBuYW1lLCBrZXksIDAsIExEX1dBSVRfU0xFRVApOwogI2Vu
ZGlmCiAjaWZkZWYgQ09ORklHX0RFQlVHX1JXU0VNUwogCXNlbS0+bWFnaWMgPSBzZW07Ci0tLSBh
L2tlcm5lbC9sb2NraW5nL3NwaW5sb2NrX2RlYnVnLmMKKysrIGIva2VybmVsL2xvY2tpbmcvc3Bp
bmxvY2tfZGVidWcuYwpAQCAtMTQsMTQgKzE0LDE0IEBACiAjaW5jbHVkZSA8bGludXgvZXhwb3J0
Lmg+CiAKIHZvaWQgX19yYXdfc3Bpbl9sb2NrX2luaXQocmF3X3NwaW5sb2NrX3QgKmxvY2ssIGNv
bnN0IGNoYXIgKm5hbWUsCi0JCQkgIHN0cnVjdCBsb2NrX2NsYXNzX2tleSAqa2V5KQorCQkJICBz
dHJ1Y3QgbG9ja19jbGFzc19rZXkgKmtleSwgc2hvcnQgaW5uZXIpCiB7CiAjaWZkZWYgQ09ORklH
X0RFQlVHX0xPQ0tfQUxMT0MKIAkvKgogCSAqIE1ha2Ugc3VyZSB3ZSBhcmUgbm90IHJlaW5pdGlh
bGl6aW5nIGEgaGVsZCBsb2NrOgogCSAqLwogCWRlYnVnX2NoZWNrX25vX2xvY2tzX2ZyZWVkKCh2
b2lkICopbG9jaywgc2l6ZW9mKCpsb2NrKSk7Ci0JbG9ja2RlcF9pbml0X21hcCgmbG9jay0+ZGVw
X21hcCwgbmFtZSwga2V5LCAwKTsKKwlsb2NrZGVwX2luaXRfbWFwX3dhaXQoJmxvY2stPmRlcF9t
YXAsIG5hbWUsIGtleSwgMCwgaW5uZXIpOwogI2VuZGlmCiAJbG9jay0+cmF3X2xvY2sgPSAoYXJj
aF9zcGlubG9ja190KV9fQVJDSF9TUElOX0xPQ0tfVU5MT0NLRUQ7CiAJbG9jay0+bWFnaWMgPSBT
UElOTE9DS19NQUdJQzsKQEAgLTM5LDcgKzM5LDcgQEAgdm9pZCBfX3J3bG9ja19pbml0KHJ3bG9j
a190ICpsb2NrLCBjb25zdAogCSAqIE1ha2Ugc3VyZSB3ZSBhcmUgbm90IHJlaW5pdGlhbGl6aW5n
IGEgaGVsZCBsb2NrOgogCSAqLwogCWRlYnVnX2NoZWNrX25vX2xvY2tzX2ZyZWVkKCh2b2lkICop
bG9jaywgc2l6ZW9mKCpsb2NrKSk7Ci0JbG9ja2RlcF9pbml0X21hcCgmbG9jay0+ZGVwX21hcCwg
bmFtZSwga2V5LCAwKTsKKwlsb2NrZGVwX2luaXRfbWFwX3dhaXQoJmxvY2stPmRlcF9tYXAsIG5h
bWUsIGtleSwgMCwgTERfV0FJVF9DT05GSUcpOwogI2VuZGlmCiAJbG9jay0+cmF3X2xvY2sgPSAo
YXJjaF9yd2xvY2tfdCkgX19BUkNIX1JXX0xPQ0tfVU5MT0NLRUQ7CiAJbG9jay0+bWFnaWMgPSBS
V0xPQ0tfTUFHSUM7Ci0tLSBhL2tlcm5lbC9yY3UvdXBkYXRlLmMKKysrIGIva2VybmVsL3JjdS91
cGRhdGUuYwpAQCAtMjI3LDE4ICsyMjcsMzAgQEAgY29yZV9pbml0Y2FsbChyY3Vfc2V0X3J1bnRp
bWVfbW9kZSk7CiAKICNpZmRlZiBDT05GSUdfREVCVUdfTE9DS19BTExPQwogc3RhdGljIHN0cnVj
dCBsb2NrX2NsYXNzX2tleSByY3VfbG9ja19rZXk7Ci1zdHJ1Y3QgbG9ja2RlcF9tYXAgcmN1X2xv
Y2tfbWFwID0KLQlTVEFUSUNfTE9DS0RFUF9NQVBfSU5JVCgicmN1X3JlYWRfbG9jayIsICZyY3Vf
bG9ja19rZXkpOworc3RydWN0IGxvY2tkZXBfbWFwIHJjdV9sb2NrX21hcCA9IHsKKwkubmFtZSA9
ICJyY3VfcmVhZF9sb2NrIiwKKwkua2V5ID0gJnJjdV9sb2NrX2tleSwKKwkud2FpdF90eXBlX291
dGVyID0gTERfV0FJVF9GUkVFLAorCS53YWl0X3R5cGVfaW5uZXIgPSBMRF9XQUlUX0NPTkZJRywg
LyogWFhYIFBSRUVNUFRfUkNVID8gKi8KK307CiBFWFBPUlRfU1lNQk9MX0dQTChyY3VfbG9ja19t
YXApOwogCiBzdGF0aWMgc3RydWN0IGxvY2tfY2xhc3Nfa2V5IHJjdV9iaF9sb2NrX2tleTsKLXN0
cnVjdCBsb2NrZGVwX21hcCByY3VfYmhfbG9ja19tYXAgPQotCVNUQVRJQ19MT0NLREVQX01BUF9J
TklUKCJyY3VfcmVhZF9sb2NrX2JoIiwgJnJjdV9iaF9sb2NrX2tleSk7CitzdHJ1Y3QgbG9ja2Rl
cF9tYXAgcmN1X2JoX2xvY2tfbWFwID0geworCS5uYW1lID0gInJjdV9yZWFkX2xvY2tfYmgiLAor
CS5rZXkgPSAmcmN1X2JoX2xvY2tfa2V5LAorCS53YWl0X3R5cGVfb3V0ZXIgPSBMRF9XQUlUX0ZS
RUUsCisJLndhaXRfdHlwZV9pbm5lciA9IExEX1dBSVRfQ09ORklHLCAvKiBQUkVFTVBUX0xPQ0sg
YWxzbyBtYWtlcyBCSCBwcmVlbXB0aWJsZSAqLworfTsKIEVYUE9SVF9TWU1CT0xfR1BMKHJjdV9i
aF9sb2NrX21hcCk7CiAKIHN0YXRpYyBzdHJ1Y3QgbG9ja19jbGFzc19rZXkgcmN1X3NjaGVkX2xv
Y2tfa2V5Owotc3RydWN0IGxvY2tkZXBfbWFwIHJjdV9zY2hlZF9sb2NrX21hcCA9Ci0JU1RBVElD
X0xPQ0tERVBfTUFQX0lOSVQoInJjdV9yZWFkX2xvY2tfc2NoZWQiLCAmcmN1X3NjaGVkX2xvY2tf
a2V5KTsKK3N0cnVjdCBsb2NrZGVwX21hcCByY3Vfc2NoZWRfbG9ja19tYXAgPSB7CisJLm5hbWUg
PSAicmN1X3JlYWRfbG9ja19zY2hlZCIsCisJLmtleSA9ICZyY3Vfc2NoZWRfbG9ja19rZXksCisJ
LndhaXRfdHlwZV9vdXRlciA9IExEX1dBSVRfRlJFRSwKKwkud2FpdF90eXBlX2lubmVyID0gTERf
V0FJVF9TUElOLAorfTsKIEVYUE9SVF9TWU1CT0xfR1BMKHJjdV9zY2hlZF9sb2NrX21hcCk7CiAK
IHN0YXRpYyBzdHJ1Y3QgbG9ja19jbGFzc19rZXkgcmN1X2NhbGxiYWNrX2tleTsKLS0tIGEvbGli
L0tjb25maWcuZGVidWcKKysrIGIvbGliL0tjb25maWcuZGVidWcKQEAgLTEwODYsNiArMTA4Niwy
MyBAQCBjb25maWcgUFJPVkVfTE9DS0lORwogCiAJIEZvciBtb3JlIGRldGFpbHMsIHNlZSBEb2N1
bWVudGF0aW9uL2xvY2tpbmcvbG9ja2RlcC1kZXNpZ24ucnN0LgogCitjb25maWcgUFJPVkVfUkFX
X0xPQ0tfTkVTVElORworCWJvb2wgIkVuYWJsZSByYXdfc3BpbmxvY2sgLSBzcGlubG9jayBuZXN0
aW5nIGNoZWNrcyIKKwlkZXBlbmRzIG9uIFBST1ZFX0xPQ0tJTkcKKwlkZWZhdWx0IG4KKwloZWxw
CisJIEVuYWJsZSB0aGUgcmF3X3NwaW5sb2NrIHZzLiBzcGlubG9jayBuZXN0aW5nIGNoZWNrcyB3
aGljaCBlbnN1cmUKKwkgdGhhdCB0aGUgbG9jayBuZXN0aW5nIHJ1bGVzIGZvciBQUkVFTVBUX1JU
IGVuYWJsZWQga2VybmVscyBhcmUKKwkgbm90IHZpb2xhdGVkLgorCisJIE5PVEU6IFRoZXJlIGFy
ZSBrbm93biBuZXN0aW5nIHByb2JsZW1zLiBTbyBpZiB5b3UgZW5hYmxlIHRoaXMKKwkgb3B0aW9u
IGV4cGVjdCBsb2NrZGVwIHNwbGF0cyB1bnRpbCB0aGVzZSBwcm9ibGVtcyBoYXZlIGJlZW4gZnVs
bHkKKwkgYWRkcmVzc2VkIHdoaWNoIGlzIHdvcmsgaW4gcHJvZ3Jlc3MuIFRoaXMgY29uZmlnIHN3
aXRjaCBhbGxvd3MgdG8KKwkgaWRlbnRpZnkgYW5kIGFuYWx5emUgdGhlc2UgcHJvYmxlbXMuIEl0
IHdpbGwgYmUgcmVtb3ZlZCBhbmQgdGhlCisJIGNoZWNrIHBlcm1hbmVudGVseSBlbmFibGVkIG9u
Y2UgdGhlIG1haW4gaXNzdWVzIGhhdmUgYmVlbiBmaXhlZC4KKworCSBJZiB1bnN1cmUsIHNlbGVj
dCBOLgorCiBjb25maWcgTE9DS19TVEFUCiAJYm9vbCAiTG9jayB1c2FnZSBzdGF0aXN0aWNzIgog
CWRlcGVuZHMgb24gREVCVUdfS0VSTkVMICYmIExPQ0tfREVCVUdHSU5HX1NVUFBPUlQKCg==
