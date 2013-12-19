Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f52.google.com ([209.85.160.52]:43769 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751140Ab3LSJq2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 19 Dec 2013 04:46:28 -0500
Received: by mail-pb0-f52.google.com with SMTP id uo5so931118pbc.11
        for <util-linux@vger.kernel.org>; Thu, 19 Dec 2013 01:46:28 -0800 (PST)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <201312182232.rBIMWPWN020104@hobgoblin.ariadne.com>
References: <201312182232.rBIMWPWN020104@hobgoblin.ariadne.com>
Date: Thu, 19 Dec 2013 09:46:27 +0000
Message-ID: <CAG27Bk0jsee=nEOUz-m-RRF0cO=u36mqduhd-w1226=S+Yw_SQ@mail.gmail.com>
Subject: Re: losetup "-p" option is not documented
From: Sami Kerola <kerolasa@iki.fi>
To: "Dale R. Worley" <worley@alum.mit.edu>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: multipart/mixed; boundary=047d7b33d62819fcbf04ede009c9
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--047d7b33d62819fcbf04ede009c9
Content-Type: text/plain; charset=ISO-8859-1

On 18 December 2013 22:32, Dale R. Worley <worley@alum.mit.edu> wrote:
> (My understanding is that this is the correct place to report bugs for
> util-linux.)

Hi Dale,

Correct. You reached right audience.

> In the manual page for losetup (in util-linux-2.23.2-4.fc19.x86_64) is
> the text:
>
>        Setup loop device:
>
>             losetup [-o offset] [--sizelimit size]
>                     [-p pfd] [-rP] {-f[--show]|loopdev} file
>
> However, the "-p" option is not described in the text.
>
> There also should be a space after "-f".

That help output looks a little old. Never the less the point about
manual page not informing the --pass-fd not being supported is valid.

Karel, sorry about the attachment. Mail relays in the office are git
send-email hostile.

-- 
Sami Kerola
http://www.iki.fi/kerolasa/

--047d7b33d62819fcbf04ede009c9
Content-Type: text/plain; charset=US-ASCII;
	name="0001-losetup-mention-in-manual-page-pass-fd-is-not-supporte.txt"
Content-Disposition: attachment;
	filename="0001-losetup-mention-in-manual-page-pass-fd-is-not-supporte.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hpdtmro40

RnJvbSAxZWM3ZjM0M2Q0NjBmNzAyZjc5YzM5NTM4MDI1ZWY2ZmNhMDU0OGM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTYW1pIEtlcm9sYSA8c2FtaS5rZXJvbGFAc2FicmUuY29tPgpE
YXRlOiBUaHUsIDE5IERlYyAyMDEzIDA5OjQxOjE4ICswMDAwClN1YmplY3Q6IFtQQVRDSF0gbG9z
ZXR1cDogbWVudGlvbiBpbiBtYW51YWwgcGFnZSAtLXBhc3MtZmQgaXMgbm90IHN1cHBvcnRlZApP
cmdhbml6YXRpb246IGxhc3RtaW51dGUuY29tCgpBbmQgc3VwcHJlc3Mgd2FybigpIGVycm5vIGNv
bnZlcnNpb24gdG8gJ1N1Y2Nlc3MnIHRoYXQgZG9lcyBub3QgbWFrZQpzZW5zZS4KClNpZ25lZC1v
ZmYtYnk6IFNhbWkgS2Vyb2xhIDxzYW1pLmtlcm9sYUBzYWJyZS5jb20+Ci0tLQogc3lzLXV0aWxz
L2xvc2V0dXAuOCB8IDIgKysKIHN5cy11dGlscy9sb3NldHVwLmMgfCAyICstCiAyIGZpbGVzIGNo
YW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3N5cy11
dGlscy9sb3NldHVwLjggYi9zeXMtdXRpbHMvbG9zZXR1cC44CmluZGV4IGM2MWE2MWUuLjEwOTky
MTAgMTAwNjQ0Ci0tLSBhL3N5cy11dGlscy9sb3NldHVwLjgKKysrIGIvc3lzLXV0aWxzL2xvc2V0
dXAuOApAQCAtMTIyLDYgKzEyMiw4IEBAIG9wdGlvbiBhbmQgYQogYXJndW1lbnQgYXJlIHByZXNl
bnQuCiAuSVAgIlxmQlwtdiwgXC1cLXZlcmJvc2VcZlAiCiB2ZXJib3NlIG1vZGUKKy5JUCAiXGZC
XC1wLCBcLVwtcGFzcy1mZFxmUCBcZklmaWxlIGRlc2NyaXB0aW9yXGZQIgorVGhpcyBvcHRpb24g
aXMgbm8gbG9uZ2VyIHN1cHBvcnRlZC4KIAogLlNIIEVOQ1JZUFRJT04KIC5CIENyeXB0b2xvb3Ag
aXMgbm8gbG9uZ2VyIHN1cHBvcnRlZCBpbiBmYXZvciBvZiBkbS1jcnlwdC4gRm9yIG1vcmUgZGV0
YWlscyBzZWUKZGlmZiAtLWdpdCBhL3N5cy11dGlscy9sb3NldHVwLmMgYi9zeXMtdXRpbHMvbG9z
ZXR1cC5jCmluZGV4IDcwZDkxNTUuLjc3MDhmZDkgMTAwNjQ0Ci0tLSBhL3N5cy11dGlscy9sb3Nl
dHVwLmMKKysrIGIvc3lzLXV0aWxzL2xvc2V0dXAuYwpAQCAtNTM4LDcgKzUzOCw3IEBAIGludCBt
YWluKGludCBhcmdjLCBjaGFyICoqYXJndikKIAkJCWxpc3QgPSAxOwogCQkJYnJlYWs7CiAJCWNh
c2UgJ3AnOgotICAgICAgICAgICAgICAgICAgICAgICAgd2FybihfKCItLXBhc3MtZmQgaXMgbm8g
bG9uZ2VyIHN1cHBvcnRlZCIpKTsKKwkJCXdhcm54KF8oIi0tcGFzcy1mZCBpcyBubyBsb25nZXIg
c3VwcG9ydGVkIikpOwogCQkJYnJlYWs7CiAJCWNhc2UgJ1AnOgogCQkJbG9fZmxhZ3MgfD0gTE9f
RkxBR1NfUEFSVFNDQU47Ci0tIAoxLjguNS4yCgo=
--047d7b33d62819fcbf04ede009c9--
