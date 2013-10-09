Return-Path: util-linux-owner@vger.kernel.org
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43236 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751854Ab3JIS5M (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 Oct 2013 14:57:12 -0400
Message-Id: <1381345029.20143.32053929.35B2647B@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: "Util-Linux" <util-linux@vger.kernel.org>,
        =?UTF-8?Q?P=C3=A1draig=20Brady?= <P@draigBrady.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_1381345029201430";
 charset="utf-8"
Subject: Re: docs: improve the cal --help [was: standardizing...]
Date: Wed, 09 Oct 2013 20:57:09 +0200
In-Reply-To: <20131009094712.GK13559@x2.net.home>
References: <1381246807.30460.31493077.03F09F4B@webmail.messagingengine.com>
 <20131009094712.GK13559@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.

--_----------=_1381345029201430
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"


On Wed, Oct 9, 2013, at 11:47, Karel Zak wrote:
>  So I guess we're ready for -rc2, right? (probably tomorrow/Friday)

Oh.  Maybe still apply P=C3=A1draig's patch to improve cal's help text.
I have somehow lost his original message, but I had downloaded
his patch, and have attached a slightly improved version: adding
a tiny doc string and a period, and using "arguments" instead of
"options".  Okay with you, P=C3=A1draig?

Benno

--=20
http://www.fastmail.fm - Or how I learned to stop worrying and
                          love email again


--_----------=_1381345029201430
Content-Disposition: attachment; filename="0001-docs-improve-the-cal-help-text-and-man-page.patch"
Content-Id: <1381344977.19870.6739ebafc1f975ec8b02da92cd797c32862aebda.377557BC@messagingengine.com>
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-docs-improve-the-cal-help-text-and-man-page.patch"

RnJvbSA0ZDE2NzViYzJlNTEzZGNlMzAyOTBjNjc4N2NmNzVjZWFmOWI4MjBk
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiA9P1VURi04P3E/UD1D
Mz1BMWRyYWlnPTIwQnJhZHk/PSA8UEBkcmFpZ0JyYWR5LmNvbT4KRGF0ZTog
V2VkLCA5IE9jdCAyMDEzIDIwOjQ0OjEyICswMjAwClN1YmplY3Q6IFtQQVRD
SF0gZG9jczogaW1wcm92ZSB0aGUgJ2NhbCcgaGVscCB0ZXh0IGFuZCBtYW4g
cGFnZQpNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRleHQvcGxh
aW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNvZGluZzog
OGJpdAoKKiBtaXNjLXV0aWxzL2NhbC5jOiBBZGQgYSBsaXR0bGUgZG9jIHN0
cmluZywgYW5kIG1lbnRpb24gdGhhdCB0aGUKICBjdXJyZW50IG1vbnRoIGlz
IGltcGxpY2l0IGlmIG5vdCBzcGVjaWZpZWQuICBBbHNvIHJlbW92ZSBtZW50
aW9uCiAgb2YgImN1cnJlbnQiIGZyb20gdHdvIG9wdGlvbiBkZXNjcmlwdGlv
bnMgYXMgYSBzcGVjaWZpYyBkYXRlIG1heQogIGhhdmUgYmVlbiBzcGVjaWZp
ZWQuCiogbWlzYy11dGlscy9jYWwuMTogTGlrZXdpc2UuCgpTaWduZWQtb2Zm
LWJ5OiBCZW5ubyBTY2h1bGVuYmVyZyA8YmVuc2JlcmdAanVzdGVtYWlsLm5l
dD4KU2lnbmVkLW9mZi1ieTogUMOhZHJhaWcgQnJhZHkgPFBAZHJhaWdCcmFk
eS5jb20+Ci0tLQogbWlzYy11dGlscy9jYWwuMSB8ICAgIDQgKystLQogbWlz
Yy11dGlscy9jYWwuYyB8ICAgIDkgKysrKysrLS0tCiAyIGZpbGVzIGNoYW5n
ZWQsIDggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1n
aXQgYS9taXNjLXV0aWxzL2NhbC4xIGIvbWlzYy11dGlscy9jYWwuMQppbmRl
eCA0ZTc1NzBkLi4wZTY4NmRkIDEwMDY0NAotLS0gYS9taXNjLXV0aWxzL2Nh
bC4xCisrKyBiL21pc2MtdXRpbHMvY2FsLjEKQEAgLTUxLDcgKzUxLDcgQEAg
RGlzcGxheSBzaW5nbGUgbW9udGggb3V0cHV0LgogKFRoaXMgaXMgdGhlIGRl
ZmF1bHQuKQogLlRQCiBcZkJcLTNcZlIsIFxmQlwtXC10aHJlZVxmUgotRGlz
cGxheSBwcmV2L2N1cnJlbnQvbmV4dCBtb250aCBvdXRwdXQuCitEaXNwbGF5
IHRocmVlIG1vbnRocyBzcGFubmluZyB0aGUgZGF0ZS4KIC5UUAogXGZCXC1z
XGZSLCBcZkJcLVwtc3VuZGF5XGZSCiBEaXNwbGF5IFN1bmRheSBhcyB0aGUg
Zmlyc3QgZGF5IG9mIHRoZSB3ZWVrLgpAQCAtNjMsNyArNjMsNyBAQCBEaXNw
bGF5IE1vbmRheSBhcyB0aGUgZmlyc3QgZGF5IG9mIHRoZSB3ZWVrLgogRGlz
cGxheSBKdWxpYW4gZGF0ZXMgKGRheXMgb25lLWJhc2VkLCBudW1iZXJlZCBm
cm9tIEphbnVhcnkgMSkuCiAuVFAKIFxmQlwteVxmUiwgXGZCXC1cLXllYXJc
ZlIKLURpc3BsYXkgYSBjYWxlbmRhciBmb3IgdGhlIGN1cnJlbnQgeWVhci4K
K0Rpc3BsYXkgYSBjYWxlbmRhciBmb3IgdGhlIHdob2xlIHllYXIuCiAuVFAK
IFxmQlwtXC1jb2xvclxmUiBbXGZJd2hlblxmUl0KIENvbG9yaXplIG91dHB1
dC4gIFRoZQpkaWZmIC0tZ2l0IGEvbWlzYy11dGlscy9jYWwuYyBiL21pc2Mt
dXRpbHMvY2FsLmMKaW5kZXggNzZkNjI1Mi4uMjdmOTRkMSAxMDA2NDQKLS0t
IGEvbWlzYy11dGlscy9jYWwuYworKysgYi9taXNjLXV0aWxzL2NhbC5jCkBA
IC04MDUsMTMgKzgwNSwxNiBAQCBzdGF0aWMgdm9pZCBfX2F0dHJpYnV0ZV9f
ICgoX19ub3JldHVybl9fKSkgdXNhZ2UoRklMRSAqIG91dCkKIAlmcHV0cyhV
U0FHRV9IRUFERVIsIG91dCk7CiAJZnByaW50ZihvdXQsIF8oIiAlcyBbb3B0
aW9uc10gW1tbZGF5XSBtb250aF0geWVhcl1cbiIpLCBwcm9ncmFtX2ludm9j
YXRpb25fc2hvcnRfbmFtZSk7CiAKKwlmcHJpbnRmKG91dCwgXygiXG5EaXNw
bGF5IGEgY2FsZW5kYXIsIG9yIHNvbWUgcGFydCBvZiBpdC5cbiIpKTsKKwlm
cHJpbnRmKG91dCwgXygiV2l0aG91dCBhbnkgYXJndW1lbnRzLCBkaXNwbGF5
IHRoZSBjdXJyZW50IG1vbnRoLlxuIikpOworCiAJZnB1dHMoVVNBR0VfT1BU
SU9OUywgb3V0KTsKLQlmcHV0cyhfKCIgLTEsIC0tb25lICAgICAgICAgICAg
IHNob3cgb25seSBjdXJyZW50IG1vbnRoIChkZWZhdWx0KVxuIiksIG91dCk7
Ci0JZnB1dHMoXygiIC0zLCAtLXRocmVlICAgICAgICAgICBzaG93IHByZXZp
b3VzLCBjdXJyZW50IGFuZCBuZXh0IG1vbnRoXG4iKSwgb3V0KTsKKwlmcHV0
cyhfKCIgLTEsIC0tb25lICAgICAgICAgICAgIHNob3cgb25seSBhIHNpbmds
ZSBtb250aCAoZGVmYXVsdClcbiIpLCBvdXQpOworCWZwdXRzKF8oIiAtMywg
LS10aHJlZSAgICAgICAgICAgc2hvdyB0aHJlZSBtb250aHMgc3Bhbm5pbmcg
dGhlIGRhdGVcbiIpLCBvdXQpOwogCWZwdXRzKF8oIiAtcywgLS1zdW5kYXkg
ICAgICAgICAgU3VuZGF5IGFzIGZpcnN0IGRheSBvZiB3ZWVrXG4iKSwgb3V0
KTsKIAlmcHV0cyhfKCIgLW0sIC0tbW9uZGF5ICAgICAgICAgIE1vbmRheSBh
cyBmaXJzdCBkYXkgb2Ygd2Vla1xuIiksIG91dCk7CiAJZnB1dHMoXygiIC1q
LCAtLWp1bGlhbiAgICAgICAgICBvdXRwdXQgSnVsaWFuIGRhdGVzXG4iKSwg
b3V0KTsKLQlmcHV0cyhfKCIgLXksIC0teWVhciAgICAgICAgICAgIHNob3cg
d2hvbGUgY3VycmVudCB5ZWFyXG4iKSwgb3V0KTsKKwlmcHV0cyhfKCIgLXks
IC0teWVhciAgICAgICAgICAgIHNob3cgdGhlIHdob2xlIHllYXJcbiIpLCBv
dXQpOwogCWZwdXRzKF8oIiAgICAgLS1jb2xvcls9PHdoZW4+XSAgY29sb3Jp
emUgbWVzc2FnZXMgKGF1dG8sIGFsd2F5cyBvciBuZXZlcilcbiIpLCBvdXQp
OwogCiAJZnB1dHMoVVNBR0VfU0VQQVJBVE9SLCBvdXQpOwotLSAKMS43LjAu
NAoK

--_----------=_1381345029201430--

