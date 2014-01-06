Return-Path: bensberg@justemail.net
Message-Id: <1389041754.20901.67345501.1AAE5142@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Karel Zak <kzak@redhat.com>
Cc: Sami Kerola <kerolasa@iki.fi>, "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="_----------=_1389041754209010";
 charset="utf-8"
Subject: [patch] cal: improve wording about when Gregorian reformation happened
Date: Mon, 06 Jan 2014 21:55:54 +0100
In-Reply-To: <20140106112608.GA14933@x2.net.home>
References: <1387645415.1452.62357161.76BB1F01@webmail.messagingengine.com>
 <1387627066-29740-1-git-send-email-kerolasa@iki.fi>
 <1387737102-32083-1-git-send-email-kerolasa@iki.fi>
 <20140106112608.GA14933@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.

--_----------=_1389041754209010
Content-Transfer-Encoding: 7bit
Content-Type: text/plain


On Mon, Jan 6, 2014, at 12:26, Karel Zak wrote:
> On Sun, Dec 22, 2013 at 06:31:42PM +0000, Sami Kerola wrote:
> >  misc-utils/cal.1 | 18 ++++++++++++------
> >  1 file changed, 12 insertions(+), 6 deletions(-)
> 
>  Applied, thanks.

Hmm...  I reviewed that change, but it appears Sami did not actually
process any of my comments into the second version of the patch --
or probably forgot to regenerate it?

Attached patch now makes the proposed changes to the current state.

Regards,

Benno

-- 
http://www.fastmail.fm - Accessible with your email software
                          or over the web


--_----------=_1389041754209010
Content-Disposition: attachment; filename="0001-cal-in-man-page-improve-grammar-and-wording-of-the-r.patch"
Content-Id: <1389041699.20209.fc3f511464f94fd771c9652ff3b9bcc624320a9a.6421D970@messagingengine.com>
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0001-cal-in-man-page-improve-grammar-and-wording-of-the-r.patch"

RnJvbSAyNmRkN2E5MGNmNWIwYTZhZjM3M2M0NGVjMzJjNWM5MjU2MjYxM2M2
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBCZW5ubyBTY2h1bGVu
YmVyZyA8YmVuc2JlcmdAanVzdGVtYWlsLm5ldD4KRGF0ZTogTW9uLCA2IEph
biAyMDE0IDIxOjQzOjQ0ICswMTAwClN1YmplY3Q6IFtQQVRDSF0gY2FsOiBp
biBtYW4gcGFnZSBpbXByb3ZlIGdyYW1tYXIgYW5kIHdvcmRpbmcgb2YgdGhl
IHJlZm9ybWF0aW9uIGxpbWl0YXRpb24KClNpZ25lZC1vZmYtYnk6IEJlbm5v
IFNjaHVsZW5iZXJnIDxiZW5zYmVyZ0BqdXN0ZW1haWwubmV0PgotLS0KIG1p
c2MtdXRpbHMvY2FsLjEgfCAgIDExICsrKysrKy0tLS0tCiAxIGZpbGVzIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9taXNjLXV0aWxzL2NhbC4xIGIvbWlzYy11dGlscy9jYWwuMQpp
bmRleCBjMzA1ZWVlLi40NzBkMjMxIDEwMDY0NAotLS0gYS9taXNjLXV0aWxz
L2NhbC4xCisrKyBiL21pc2MtdXRpbHMvY2FsLjEKQEAgLTExMSwxMSArMTEx
LDEyIEBAIGlzIHVzZWQsIHdoZXJlIHRoZSBmaXJzdCBUaHVyc2RheSBvZiB0
aGUgeWVhciBpcyBpbiB3ZWVrIG51bWJlciAxLgogLlBQCiBUaGUKIC5CIGNh
bAotaXMgdXNpbmcgZm9yIEdyZWdvcmlhbiByZWZvcm1hdGlvbiB0aGUgZGF0
ZSBvZiAxNzUyIG9uIHRoZSAzcmQgb2YKLVNlcHRlbWJlciB3aGVuIGl0IGhh
cHBlbiBpbiBHcmVhdCBCcml0YWluIGFuZCBpdCdzIGNvbG9uaWVzIChpbmNs
dWRpbmcKLXdoYXQgaXMgbm93IHRoZSBVU0EpLiAgVGVuIGRheXMgZm9sbG93
aW5nIHRoYXQgZGF0ZSB3ZXJlIGVsaW1pbmF0ZWQgYnkKLXRoZSByZWZvcm1h
dGlvbiwgc28gdGhlIGNhbGVuZGFyIGZvciB0aGF0IG1vbnRoIGlzIGEgYml0
IHVudXN1YWwuICBUaGUKLWhpc3Rvcnkgd2hlbiBjYWxlbmRhciByZWZvcm1h
dGlvbiBoYXBwZW4gaW4gZGlmZmVyZW50IGxvY2FsZXMgaXMgaWdub3JlZC4K
K3Byb2dyYW0gdXNlcyB0aGUgM3JkIG9mIFNlcHRlbWJlciAxNzUyIGFzIHRo
ZSBkYXRlIG9mIHRoZSBHcmVnb3JpYW4gY2FsZW5kYXIKK3JlZm9ybWF0aW9u
IC0tIHRoYXQgaXMgd2hlbiBpdCBoYXBwZW5lZCBpbiBHcmVhdCBCcml0YWlu
IGFuZCBpdHMgY29sb25pZXMKKyhpbmNsdWRpbmcgd2hhdCBpcyBub3cgdGhl
IFVTQSkuICBUZW4gZGF5cyBmb2xsb3dpbmcgdGhhdCBkYXRlIHdlcmUgZWxp
bWluYXRlZAorYnkgdGhpcyByZWZvcm1hdGlvbiwgc28gdGhlIGNhbGVuZGFy
IGZvciB0aGF0IG1vbnRoIGlzIHJhdGhlciB1bnVzdWFsLgorVGhlIGFjdHVh
bCBoaXN0b3JpY2FsIGRhdGVzIGF0IHdoaWNoIHRoZSBjYWxlbmRhciByZWZv
cm0gaGFwcGVuZWQgaW4gYWxsIHRoZQorZGlmZmVyZW50IGNvdW50cmllcyAo
bG9jYWxlcykgYXJlIGlnbm9yZWQuCiAuUFAKIEFsdGVybmF0aXZlIGNhbGVu
ZGFycywgc3VjaCBhcyB0aGUgVW1tIGFsLVF1cmEsIHRoZSBTb2xhciBIaWpy
aSwgdGhlIEdlJ2V6LAogb3IgdGhlIGx1bmlzb2xhciBIaW5kdSwgYXJlIG5v
dCBzdXBwb3J0ZWQuCi0tIAoxLjcuMC40Cgo=

--_----------=_1389041754209010--
