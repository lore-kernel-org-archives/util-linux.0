Return-Path: util-linux-owner@vger.kernel.org
Received: from mx5-phx2.redhat.com ([209.132.183.37]:53682 "EHLO
	mx5-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754468AbaIHRuG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Sep 2014 13:50:06 -0400
Date: Mon, 8 Sep 2014 13:50:02 -0400 (EDT)
From: Jaromir Capik <jcapik@redhat.com>
To: Karel Zak <kzak@redhat.com>
Cc: kerolasa@gmail.com, util-linux <util-linux@vger.kernel.org>
Message-ID: <2108552981.7794894.1410198602679.JavaMail.zimbra@redhat.com>
In-Reply-To: <1340617573.25924027.1406633523481.JavaMail.zimbra@redhat.com>
References: <844628876.22654954.1406302034993.JavaMail.zimbra@redhat.com> <2139170067.22662578.1406302189694.JavaMail.zimbra@redhat.com> <CAG27Bk1hbE+WE7+CeMPv03YYR-78jGm8cG-kQNufgLfAU6f3qQ@mail.gmail.com> <969740755.24655086.1406558319251.JavaMail.zimbra@redhat.com> <20140728151034.GM8533@x2.net.home> <1340617573.25924027.1406633523481.JavaMail.zimbra@redhat.com>
Subject: Re: [PATCH] fdformat: Add new switches -f/--from, -t/--to,
 -r/--repair
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_7794892_3064061.1410198602677"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

------=_Part_7794892_3064061.1410198602677
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

Hello everyone.

I often re-check my patches few weeks after the push
and that allowed me to find a copy'n'paste issue
in the manual.

The fix is attached.

Thanks for pushing.

Regards,
Jaromir.

--
Jaromir Capik
Red Hat Czech, s.r.o.
Software Engineer / Secondary Arch

Email: jcapik@redhat.com
Web: www.cz.redhat.com
Red Hat Czech s.r.o., Purkynova 99/71, 612 45, Brno, Czech Republic
IC: 27690016 


----- Original Message -----
> From: "Jaromir Capik" <jcapik@redhat.com>
> To: "Karel Zak" <kzak@redhat.com>
> Cc: kerolasa@gmail.com, "util-linux" <util-linux@vger.kernel.org>
> Sent: Tuesday, July 29, 2014 1:32:03 PM
> Subject: Re: [PATCH] fdformat: Add new switches -f/--from, -t/--to, -r/--repair
> 
> Hello guys.
> 
> The reworked patch is attached.
> 
> Please, review once more.
> 
> Thanks,
> Jaromir.
> 
> --
> Jaromir Capik
> Red Hat Czech, s.r.o.
> Software Engineer / Secondary Arch
> 
> Email: jcapik@redhat.com
> Web: www.cz.redhat.com
> Red Hat Czech s.r.o., Purkynova 99/71, 612 45, Brno, Czech Republic
> IC: 27690016
> 

------=_Part_7794892_3064061.1410198602677
Content-Type: text/x-patch; name=fdformat-man-copy-n-paste-bug.patch
Content-Disposition: attachment; filename=fdformat-man-copy-n-paste-bug.patch
Content-Transfer-Encoding: base64

RnJvbSA1NDBiOTRkNzg2ZTJjNjAyYjRiOTlkYTA2Y2FlM2M2ZjgxZmExMzE1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYXJvbWlyIENhcGlrIDxqY2FwaWtAcmVkaGF0LmNvbT4KRGF0
ZTogTW9uLCA4IFNlcCAyMDE0IDE5OjQyOjEwICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZmRmb3Jt
YXQ6IGZpeGluZyBjb3B5J24ncGFzdGUgaXNzdWUgaW4gdGhlIG1hbnVhbAoKVGhlIGVuZCB0cmFj
ayBkZWZhdWx0IGlzIG1lZGlhIHNwZWNpZmljLCBub3QgemVyby4KLS0tCiBkaXNrLXV0aWxzL2Zk
Zm9ybWF0LjggfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRp
b24oLSkKCmRpZmYgLS1naXQgYS9kaXNrLXV0aWxzL2ZkZm9ybWF0LjggYi9kaXNrLXV0aWxzL2Zk
Zm9ybWF0LjgKaW5kZXggNzk3ZjUwZi4uYWUxZTUzMCAxMDA2NDQKLS0tIGEvZGlzay11dGlscy9m
ZGZvcm1hdC44CisrKyBiL2Rpc2stdXRpbHMvZmRmb3JtYXQuOApAQCAtNDksNyArNDksNyBAQCB0
byBsb2FkIHRoZSBkaXNrIHBhcmFtZXRlcnMuCiBTdGFydCBhdCB0aGUgdHJhY2sgXGZJTlxmUiAo
ZGVmYXVsdCBpcyAwKS4KIC5UUAogXGZCXC10XGZSLCBcZkJcLVwtdG9cZlIgXGZJTlxmUgotU3Rv
cCBhdCB0aGUgdHJhY2sgXGZJTlxmUiAoZGVmYXVsdCBpcyAwKS4KK1N0b3AgYXQgdGhlIHRyYWNr
IFxmSU5cZlIuCiAuVFAKIFxmQlwtclxmUiwgXGZCXC1cLXJlcGFpclxmUiBcZklOXGZSCiBUcnkg
dG8gcmVwYWlyIHRyYWNrcyBmYWlsZWQgZHVyaW5nIHRoZSB2ZXJpZmljYXRpb24gKG1heCBcZklO
XGZSIHJldHJpZXMpLgotLSAKMS45LjMKCg==
------=_Part_7794892_3064061.1410198602677--
