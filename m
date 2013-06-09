Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44847 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750827Ab3FIIyy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Jun 2013 04:54:54 -0400
Message-Id: <1370768088.29446.140661241694937.4E337ABA@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: =?UTF-8?Q?Krzysztof=20=C5=BBelechowski?= <giecrilj@stegny.2a.pl>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_1370768088294460";
 charset="utf-8"
In-Reply-To: <kotrf8$s14$1@ger.gmane.org>
References: <kotrf8$s14$1@ger.gmane.org>
Subject: Re: [PATCH] Fix typos found by misspellings
Date: Sun, 09 Jun 2013 10:54:48 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.

--_----------=_1370768088294460
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"


On Sat, Jun 8, 2013, at 1:49, Krzysztof =C5=BBelechowski wrote:
>> The
>>  .BR rootcontext=3D
>>  option allows you to explicitly label the root inode of a FS being moun=
ted
>> -before that FS or inode because visable to userspace. This was found to=
 be
>> +before that FS or inode because visible to userspace. This was found to=
 be
>>  useful for things like stateless linux.
>=20
> I still do not understand the first sentence.  What is that supposed to=20
> mean?

Maybe s/because/becomes/?

Attached patch makes that change, plus some grammar fixes.

Regards,

Benno

--=20
http://www.fastmail.fm - Email service worth paying for. Try it for free


--_----------=_1370768088294460
Content-Disposition: attachment; filename="0001-docs-fix-mistaken-word-and-some-grammar-in-man-page-.patch"
Content-Id: <1370768067.29439.2db28e085b2c006360ec1b453d8cee5135eee2e1.36C8B4CC@messagingengine.com>
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-docs-fix-mistaken-word-and-some-grammar-in-man-page-.patch"

RnJvbSA3NTNhY2IyMzFmNWNiYmU4NDZmMGNkYjA3MTdhZDkxZTgyNTVjYjRi
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCZW5ubyBTY2h1bGVu
YmVyZyA8YmVuc2JlcmdAanVzdGVtYWlsLm5ldD4KRGF0ZTogU3VuLCA5IEp1
biAyMDEzIDEwOjUwOjAxICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZG9jczog
Zml4IG1pc3Rha2VuIHdvcmQgYW5kIHNvbWUgZ3JhbW1hciBpbiBtYW4gcGFn
ZSBvZiBtb3VudApNSU1FLVZlcnNpb246IDEuMApDb250ZW50LVR5cGU6IHRl
eHQvcGxhaW47IGNoYXJzZXQ9VVRGLTgKQ29udGVudC1UcmFuc2Zlci1FbmNv
ZGluZzogOGJpdAoKUmVwb3J0ZWQtYnk6IEtyenlzenRvZiDFu2VsZWNob3dz
a2kgPGdpZWNyaWxqQHN0ZWdueS4yYS5wbD4KU2lnbmVkLW9mZi1ieTogQmVu
bm8gU2NodWxlbmJlcmcgPGJlbnNiZXJnQGp1c3RlbWFpbC5uZXQ+Ci0tLQog
c3lzLXV0aWxzL21vdW50LjggfCAgIDIzICsrKysrKysrKysrLS0tLS0tLS0t
LS0tCiAxIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEyIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3N5cy11dGlscy9tb3VudC44IGIv
c3lzLXV0aWxzL21vdW50LjgKaW5kZXggM2ZmZGIyNC4uYTljNjhmZCAxMDA2
NDQKLS0tIGEvc3lzLXV0aWxzL21vdW50LjgKKysrIGIvc3lzLXV0aWxzL21v
dW50LjgKQEAgLTk0NiwyOCArOTQ2LDI3IEBAIGZpbGVzeXN0ZW0gdGhhdCBz
dXBwb3J0cyB4YXR0ciBsYWJlbGluZy4KIFRoZQogLkJSIHJvb3Rjb250ZXh0
PQogb3B0aW9uIGFsbG93cyB5b3UgdG8gZXhwbGljaXRseSBsYWJlbCB0aGUg
cm9vdCBpbm9kZSBvZiBhIEZTIGJlaW5nIG1vdW50ZWQKLWJlZm9yZSB0aGF0
IEZTIG9yIGlub2RlIGJlY2F1c2UgdmlzaWJsZSB0byB1c2Vyc3BhY2UuIFRo
aXMgd2FzIGZvdW5kIHRvIGJlCitiZWZvcmUgdGhhdCBGUyBvciBpbm9kZSBi
ZWNvbWVzIHZpc2libGUgdG8gdXNlcnNwYWNlLiAgVGhpcyB3YXMgZm91bmQg
dG8gYmUKIHVzZWZ1bCBmb3IgdGhpbmdzIGxpa2Ugc3RhdGVsZXNzIGxpbnV4
LgogCi1Ob3RlIHRoYXQga2VybmVsIHJlamVjdHMgYW55IHJlbW91bnQgcmVx
dWVzdCB0aGF0IGluY2x1ZGVzIHRoZSBjb250ZXh0Ci1vcHRpb24gZXZlbiBp
ZiB1bmNoYW5nZWQgZnJvbSB0aGUgY3VycmVudCBjb250ZXh0LgorTm90ZSB0
aGF0IHRoZSBrZXJuZWwgcmVqZWN0cyBhbnkgcmVtb3VudCByZXF1ZXN0IHRo
YXQgaW5jbHVkZXMgdGhlIGNvbnRleHQKK29wdGlvbiwgXGZCZXZlblxmUCB3
aGVuIHVuY2hhbmdlZCBmcm9tIHRoZSBjdXJyZW50IGNvbnRleHQuCiAKLS5C
IFdhcm5pbmcgdGhhdCBcZkljb250ZXh0XGZQIHZhbHVlIG1pZ2h0IGNvbnRh
aW5zIGNvbW1hCi1hbmQgaW4gdGhpcyBjYXNlIHRoZSB2YWx1ZSBoYXMgdG8g
YmUgcHJvcGVybHkgcXVvdGVkIG90aGVyd2lzZQorLkJSICJXYXJuaW5nOiB0
aGUgXGZJY29udGV4dFxmUCB2YWx1ZSBtaWdodCBjb250YWluIGNvbW1hcyIg
LAoraW4gd2hpY2ggY2FzZSB0aGUgdmFsdWUgaGFzIHRvIGJlIHByb3Blcmx5
IHF1b3RlZCwgb3RoZXJ3aXNlCiAuQlIgbW91bnQgKDgpCi13aWxsIGludGVy
cHJldCB0aGUgY29tbWEgYXMgc2VwYXJhdG9yIGJldHdlZW4gbW91bnQgb3B0
aW9ucy4gRG9uJ3QgZm9yZ2V0IHRoYXQKLXNoZWxsIHN0cmlwcyBvZmYgcXVv
dGVzIGFuZAotLkJSICJkb3VibGUgcXVvdGluZyBpcyByZXF1aXJlZCIgLAot
Zm9yIGV4YW1wbGU6Cit3aWxsIGludGVycHJldCB0aGUgY29tbWEgYXMgYSBz
ZXBhcmF0b3IgYmV0d2VlbiBtb3VudCBvcHRpb25zLiAgRG9uJ3QgZm9yZ2V0
IHRoYXQKK3RoZSBzaGVsbCBzdHJpcHMgb2ZmIHF1b3RlcyBhbmQgdGh1cwor
LkJSICJkb3VibGUgcXVvdGluZyBpcyByZXF1aXJlZCIgLgorRm9yIGV4YW1w
bGU6CiAuUlMKIC5SUwogLnNwCi1tb3VudCAtdCB0bXBmcyBub25lIC9tbnQg
XC1vICdjb250ZXh0PSJzeXN0ZW1fdTpvYmplY3Rfcjp0bXBfdDpzMDpjMTI3
LGM0NTYiLG5vZXhlYycKKy5CIG1vdW50IC10IHRtcGZzIG5vbmUgL21udCBc
LW8gJ2NvbnRleHQ9InN5c3RlbV91Om9iamVjdF9yOnRtcF90OnMwOmMxMjcs
YzQ1NiIsbm9leGVjJwogLnNwCiAuUkUKLQogRm9yIG1vcmUgZGV0YWlscywg
c2VlCi0uQlIgc2VsaW51eCAoOCkKKy5CUiBzZWxpbnV4ICg4KS4KIC5SRQog
CiAuVFAKLS0gCjEuNy4wLjQKCg==

--_----------=_1370768088294460--

