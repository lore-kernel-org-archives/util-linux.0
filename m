Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59743 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030349AbcCQLxt (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 07:53:49 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 7BF1F20C9E
	for <util-linux@vger.kernel.org>; Thu, 17 Mar 2016 07:53:42 -0400 (EDT)
Message-Id: <1458215622.795504.551872786.40E5990C@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_14582156227955040";
 charset="utf-8"
Subject: Re: cancelling the tests says that they all passed
Date: Thu, 17 Mar 2016 12:53:42 +0100
In-Reply-To: <201603171135.19679.sweet_f_a@gmx.de>
References: <1458207847.751745.551787010.6EE6554F@webmail.messagingengine.com>
 <201603171135.19679.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.

--_----------=_14582156227955040
Content-Transfer-Encoding: 7bit
Content-Type: text/plain


On Thu, Mar 17, 2016, at 11:35, Ruediger Meier wrote:
> On Thursday 17 March 2016, Benno Schulenberg wrote:
> > When one hits ^C when the compilation phase of 'make check'
> > finishes and the first tests start executing, the script prints
> 
> I don't manage to reproduce that. How do you run make exactly (-j)?

Just plain 'make' and 'make check'.

> If I hit ctrl-C during compilation then the test script does not start 
> at all. Maybe there is a dependency problem and your tests start before 
> compilation is finished?

No, I don't hit ^C during compilation but when it has finished,
when that scary warning "Don't execute on production system!"
has been printed and the first "OK"s have appeared.

> Could you show us the test diffs?
> $ find tests/diff/ -type f | xargs -r cat

Attached.

> Maybe also warnings durning the test run (if any).

Only the ipcs one prints warnings:

         ipcs: mk-rm-msg                                     ... OK
         ipcs: mk-rm-sem                                     ... OK
ipcs: id 1048595 not found
ipcs: id 1081363 not found
         ipcs: mk-rm-shm                                     ... FAILED (ipcs/mk-rm-shm)

Benno

-- 
http://www.fastmail.com - A no graphics, no pop-ups email service


--_----------=_14582156227955040
Content-Disposition: attachment; filename="thediffs"
Content-Id: <1458215492.795118.4d0cf1709b628dfca110e0969db9cdfa3b57dc0d.14C109AD@content.messagingengine.com>
Content-Transfer-Encoding: base64
Content-Type: application/octet-stream; name="thediffs"

LS0tIC9ob21lL2Jlbi9Qcm9ncmFtb2ovdXRpbC1saW51eC0yLjI4LXJjMS90
ZXN0cy9leHBlY3RlZC9taXNjL3N3YXBsYWJlbAkyMDE2LTAxLTI2IDE2OjQ5
OjA5LjAwMDAwMDAwMCArMDEwMAorKysgL2hvbWUvYmVuL1Byb2dyYW1vai91
dGlsLWxpbnV4LTIuMjgtcmMxL3Rlc3RzL291dHB1dC9taXNjL3N3YXBsYWJl
bAkyMDE2LTAzLTE3IDEyOjQ2OjI2LjAwMDAwMDAwMCArMDEwMApAQCAtMSw3
ICsxLDMgQEAKIG1rc3dhcDogZXJyb3I6IHN3YXAgYXJlYSBuZWVkcyB0byBi
ZSBhdCBsZWFzdCAxMCBwYWdlcwotbWtzd2FwOiA8c3dhcGZpbGU+OiBpbnNl
Y3VyZSBwZXJtaXNzaW9ucyA8cGVybT4sIDA2MDAgc3VnZ2VzdGVkLgotbWtz
d2FwOiBMYWJlbCB3YXMgdHJ1bmNhdGVkLgotU2V0dGluZyB1cCBzd2Fwc3Bh
Y2UgdmVyc2lvbiAxLCBzaXplID0gOSBwYWdlcyAoOXhQR1NaIGJ5dGVzKQot
TEFCRUw9MTIzNDU2Nzg5MGFiY2RlLCBVVUlEPTEyMzQ1Njc4LWFiY2QtYWJj
ZC1hYmNkLTEyMzQ1Njc4OTBhYgotTEFCRUw6IDEyMzQ1Njc4OTBhYmNkZQot
VVVJRDogIDEyMzQ1Njc4LWFiY2QtYWJjZC1hYmNkLTEyMzQ1Njc4OTBhYgor
bWtzd2FwOiBlcnJvcjogc3dhcCBhcmVhIG5lZWRzIHRvIGJlIGF0IGxlYXN0
IDQwIEtpQgorc3dhcGxhYmVsOiAvaG9tZS9iZW4vUHJvZ3JhbW9qL3V0aWwt
bGludXgtMi4yOC1yYzEvdGVzdHMvb3V0cHV0L21pc2Mvc3dhcGxhYmVsLmZp
bGU6IG5vdCBhIHZhbGlkIHN3YXAgcGFydGl0aW9uCi0tLSAvaG9tZS9iZW4v
UHJvZ3JhbW9qL3V0aWwtbGludXgtMi4yOC1yYzEvdGVzdHMvZXhwZWN0ZWQv
bWlzYy9mYWxsb2NhdGUJMjAxNS0xMC0wNSAxNjoxODowNi4wMDAwMDAwMDAg
KzAyMDAKKysrIC9ob21lL2Jlbi9Qcm9ncmFtb2ovdXRpbC1saW51eC0yLjI4
LXJjMS90ZXN0cy9vdXRwdXQvbWlzYy9mYWxsb2NhdGUJMjAxNi0wMy0xNyAx
Mjo0NjoyMC4wMDAwMDAwMDAgKzAxMDAKQEAgLTEgKzEgQEAKLTM4NAorMAot
LS0gL2hvbWUvYmVuL1Byb2dyYW1vai91dGlsLWxpbnV4LTIuMjgtcmMxL3Rl
c3RzL2V4cGVjdGVkL21pc2MvdWwJMjAxNS0xMC0wNSAxNjoxODowNi4wMDAw
MDAwMDAgKzAyMDAKKysrIC9ob21lL2Jlbi9Qcm9ncmFtb2ovdXRpbC1saW51
eC0yLjI4LXJjMS90ZXN0cy9vdXRwdXQvbWlzYy91bAkyMDE2LTAzLTE3IDEy
OjQ2OjI2LjAwMDAwMDAwMCArMDEwMApAQCAtMSwzICsxLDMgQEAKLRtbMW1h
GyhCG1ttYhtbNG1jG1syNG0KKxtbMW1hG1ttGyhCYhtbNG1jG1syNG0KICAg
ICAgICAgdGFiCiAMClwgTm8gbmV3bGluZSBhdCBlbmQgb2YgZmlsZQotLS0g
L2hvbWUvYmVuL1Byb2dyYW1vai91dGlsLWxpbnV4LTIuMjgtcmMxL3Rlc3Rz
L2V4cGVjdGVkL2lwY3MvbWstcm0tc2htCTIwMTUtMTAtMDUgMTY6MTg6NDMu
MDAwMDAwMDAwICswMjAwCisrKyAvaG9tZS9iZW4vUHJvZ3JhbW9qL3V0aWwt
bGludXgtMi4yOC1yYzEvdGVzdHMvb3V0cHV0L2lwY3MvbWstcm0tc2htCTIw
MTYtMDMtMTcgMTI6NDU6MzcuMDAwMDAwMDAwICswMTAwCkBAIC0xLDQgKzEs
MyBAQAogU2hhcmVkIG1lbW9yeSBpZDogPHdhc19udW1iZXI+Ci1ieXRlcz0x
CiBTaGFyZWQgbWVtb3J5IGlkOiA8d2FzX251bWJlcj4KLWJ5dGVzPTEyCitp
cGNybTogZmFpbGVkIHRvIHBhcnNlIGFyZ3VtZW50OiAnJwo=

--_----------=_14582156227955040--

