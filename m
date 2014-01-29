Return-Path: util-linux-owner@vger.kernel.org
Received: from mailgw02.dd24.net ([193.46.215.43]:46787 "EHLO
	mailgw02.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754026AbaA2BG1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Jan 2014 20:06:27 -0500
Received: from localhost (amavis02.dd24.net [192.168.1.113])
	by mailgw02.dd24.net (Postfix) with ESMTP id AB69B3569D1
	for <util-linux@vger.kernel.org>; Wed, 29 Jan 2014 01:06:25 +0000 (GMT)
Received: from mailgw02.dd24.net ([192.168.1.197])
	by localhost (amavis02.dd24.net [192.168.1.106]) (amavisd-new, port 10197)
	with ESMTP id EygeXktRV5qG for <util-linux@vger.kernel.org>;
	Wed, 29 Jan 2014 01:06:23 +0000 (GMT)
Received: from [192.168.0.102] (ppp-88-217-95-172.dynamic.mnet-online.de [88.217.95.172])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mailgw02.dd24.net (Postfix) with ESMTPSA id 9768135667A
	for <util-linux@vger.kernel.org>; Wed, 29 Jan 2014 01:06:23 +0000 (GMT)
Message-ID: <1390957543.10482.18.camel@heisenberg.scientia.net>
Subject: Re: fdisk: add GPT partition types for plain dm-crypt and LUKS
From: Christoph Anton Mitterer <calestyo@scientia.net>
To: util-linux@vger.kernel.org
Date: Wed, 29 Jan 2014 02:05:43 +0100
In-Reply-To: <52E850D1.6090807@ubuntu.com>
References: <1390934933.15213.17.camel@heisenberg.scientia.net>
			 <52E819BF.4090503@ubuntu.com>
		 <1390943356.7021.7.camel@heisenberg.scientia.net>
		 <52E8210F.2000007@ubuntu.com>
	 <1390945287.7021.16.camel@heisenberg.scientia.net>
	 <52E850D1.6090807@ubuntu.com>
Content-Type: multipart/signed; micalg="sha-512";
	protocol="application/x-pkcs7-signature";
	boundary="=-5531u6VY2NHI57+ooHBJ"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--=-5531u6VY2NHI57+ooHBJ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2014-01-28 at 19:52 -0500, Phillip Susi wrote:
> On 01/28/2014 04:41 PM, Christoph Anton Mitterer wrote:
> > Well some people don't want to do so... whether that makes sense
> > or not.. is probably up to them :)
>=20
> Sure, but they are just as likely to continue to be ignorant of this
> type code and never use it.
>=20
> > Sure and that's likely the best approach,... but there is not only=20
> > Linux ;-)
>=20
> So are there any other operating systems that want to or already are
> using these codes?
>=20
> > Again... other systems may use it... there is the ID for the ESP,
> > which is definitely used... and you never know which other system
> > (other OS, bootloader) comes a long and tries to do something based
> > on it.
>=20
> The possibility that someone some day may use it isn't a good reason
> to add it.  The ESP has a special ID because the UEFI standard
> requires it, and that causes enough trouble as it is.

As I've said... use it or not... :) ... this mail was just an
information which I've sent to all GPT capable open source partition
editors I knew.


> I also don't see any point in a
> code for LUKS, though pure a pure dm-crypt code would at least have a use=
.
Well the reason for that is simply, that I think, conceptually it would
be a bad idea to have the same code used for both, since these are
different types of "containers" (the one having the LUKS header the
other not).
Now I only a dm-crypt GPT type would have been defined, people would
have used that for LUKS as well... which is - as said - IMHO not very
clean.


> Ummm... how does it prove your point?  You admit that it was a bad
> idea that caused many issues... and somehow that makes repeating the
> same mistake a good idea?
The bad thing about 0xFD for MD auto assembly is not that there was some
type defined, but that it was used for something fragile.

Defining a GPT type for LUKS/dm-crypt is just like a placeholder-type,
so that people/tools who do set a type in any case aren't tempted to set
something stupid.


> > Aprart from that one would usually rather try not to run around
> > shouting that one has an encrypted container...
> Yet you propose doing exactly that via the partition type code.
Yeah I know... but again... one isn't forced to set it... ;-)

People also tend to use plain dm-crypt for swap... and if such partition
is wanted to be marked as plain dm-crypt... that would be the way to
go...



Anyway... guess we can stop that pointless discussion...
Some people wanted such code... whether it's useful or not is something
everybody can decide on his own... I just wanted to inform the part
editors about this, so that they can take it up in their lists of well
known types - if they want.


Cheers,
Chris.

--=-5531u6VY2NHI57+ooHBJ
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgMFADCABgkqhkiG9w0BBwEAAKCCEP4w
ggV1MIIDXaADAgECAgMBAYIwDQYJKoZIhvcNAQEFBQAwVDEUMBIGA1UEChMLQ0FjZXJ0IEluYy4x
HjAcBgNVBAsTFWh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZzEcMBoGA1UEAxMTQ0FjZXJ0IENsYXNzIDMg
Um9vdDAeFw0xMjA3MjMxNDU2NDVaFw0xNDA3MjMxNDU2NDVaMHwxITAfBgNVBAMTGENocmlzdG9w
aCBBbnRvbiBNaXR0ZXJlcjEkMCIGCSqGSIb3DQEJARYVY2FsZXN0eW9Ac2NpZW50aWEubmV0MTEw
LwYJKoZIhvcNAQkBFiJtYWlsQGNocmlzdG9waC5hbnRvbi5taXR0ZXJlci5uYW1lMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAqv+F91K5vyBwiGFMqj6wTehWdqZnfFeXqT8g5b3qrXWL
ywSzcoD9xtyoRqAgOCX+PSmBpm6pPhe31VnBtc3HcBMe4rSico9/Z2H9h1l6IMVEnyhabWzoKbE3
BFrsYJGthJCbhK072G8AhCk+5p+L+knLhQXN0Ph7MJbdY26o3M4vjsXFNbJL8TOYxo80cGD1LIh2
SUZFqaIG24TVmTW8F4jD5Z9/NEwJa8kQK+VBNHUntXYNah4Reh0jSsGnq9Pg3Hf4KC+F0IR8QgBm
SnwitMFUX9UnhLEvRQxjDI1tm+h6RxfjlV7moI68Ulh7bcdPhM/z2Q16XmaY12rc85pSRQIDAQAB
o4IBJjCCASIwDAYDVR0TAQH/BAIwADBWBglghkgBhvhCAQ0ESRZHVG8gZ2V0IHlvdXIgb3duIGNl
cnRpZmljYXRlIGZvciBGUkVFIGhlYWQgb3ZlciB0byBodHRwOi8vd3d3LkNBY2VydC5vcmcwQAYD
VR0lBDkwNwYIKwYBBQUHAwQGCCsGAQUFBwMCBgorBgEEAYI3CgMEBgorBgEEAYI3CgMDBglghkgB
hvhCBAEwMgYIKwYBBQUHAQEEJjAkMCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5jYWNlcnQub3Jn
MEQGA1UdEQQ9MDuBFWNhbGVzdHlvQHNjaWVudGlhLm5ldIEibWFpbEBjaHJpc3RvcGguYW50b24u
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
+G8T/HNZ92ZCdB6K4/jc0m+YnMtHmJVABfvpAgMBAAGjgb8wgbwwDwYDVR0TAQH/BAUwAwEB/zBd
BggrBgEFBQcBAQRRME8wIwYIKwYBBQUHMAGGF2h0dHA6Ly9vY3NwLkNBY2VydC5vcmcvMCgGCCsG
AQUFBzAChhxodHRwOi8vd3d3LkNBY2VydC5vcmcvY2EuY3J0MEoGA1UdIARDMEEwPwYIKwYBBAGB
kEowMzAxBggrBgEFBQcCARYlaHR0cDovL3d3dy5DQWNlcnQub3JnL2luZGV4LnBocD9pZD0xMDAN
BgkqhkiG9w0BAQQFAAOCAgEAfwiIodoaUEnaifuhCHLzivcexDq0eVsgMLFF3sJd02Vp8cJdVFQ8
hV+5e0KRwpn9G1Gbq0aloRBTnm2IrHNuLDOm8PSe4HXBPohFqeFmQ/5WWtF6QXj3QNpKOvELW6W7
FgbmwueTuYVNl0+xHjhDgO+bDYzvuKdgAIdXfR5EHMsj75s8mZ2vtSkcRXkWlk0nbfEcbMPCVWSz
vBTi86QfHjL8JxUFz90urj6CYXvwIRAY9kTqUzn53NCaIODGu+C7Wk/EmcgHvbW9otsuYg1CNEG8
/4uK9VEiqogwAOKw1Ly+ZbrVA1d5m+jcyE34UO2RpVIooqz7Nlg+6ZQrkVCHG9Ze1ozM9w8QDFJO
0BZh5eUKbL8Xx3JGV5yY9WxgY3pvXrlOL8i5ubtqhbyYDe35PpeENJSuAK+h5eeSbk698+LZFItc
0usBbKAXpS0Q65x6Sr297s797SJAq3A4iPUKh2rCqwVgyUgF2lPB3kR3arPzPDztgLymOEopJF/+
WTubJXpWYwBkuV2kYn1XNk+tg+8fklOgjndX3eVhET0jAJBMPPqjYJMEo6819g5qj09KYKeFBWxG
oY/0x3bjoVlX93GyxG4UXG1tQWbfG5Ox1ADD7svPPD0hgKlfY2X83eBfpPQr8IVxQdRnJfsasZeu
1pmCE0HSbqUbmSeA5wupqAAxggLtMIIC6QIBATBbMFQxFDASBgNVBAoTC0NBY2VydCBJbmMuMR4w
HAYDVQQLExVodHRwOi8vd3d3LkNBY2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFzcyAzIFJv
b3QCAwEBgjANBglghkgBZQMEAgMFAKCCAWMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkq
hkiG9w0BCQUxDxcNMTQwMTI5MDEwNTQzWjBPBgkqhkiG9w0BCQQxQgRAC+uFIaebmCXadHyPbEKH
5fuJ6opgd1piA4pWCyGEh4yBuHitI79ZUceSGi6j5Gy8bK/XvZMrkgCOSJxXhEd+1zBqBgkrBgEE
AYI3EAQxXTBbMFQxFDASBgNVBAoTC0NBY2VydCBJbmMuMR4wHAYDVQQLExVodHRwOi8vd3d3LkNB
Y2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFzcyAzIFJvb3QCAwEBgjBsBgsqhkiG9w0BCRAC
CzFdoFswVDEUMBIGA1UEChMLQ0FjZXJ0IEluYy4xHjAcBgNVBAsTFWh0dHA6Ly93d3cuQ0FjZXJ0
Lm9yZzEcMBoGA1UEAxMTQ0FjZXJ0IENsYXNzIDMgUm9vdAIDAQGCMA0GCSqGSIb3DQEBAQUABIIB
AJ5Z/+B9R8Be9d+XEGWQnPLyIVE7PoBjBOkLo1xo+MQL5ogjGTBRI2NBBr5OsymjHRzR9mU+a6rK
7S++7wbVNL06hpFl480qMB0Erz7Ke2Vfu5ok17NaEoRCkkW6AkSBUsTxK4yFvyIGnXvkRfq67rn9
N3jd9v0Wlnn7pU9Y4OBpKimcgosIxX8kZ/8Ru045BDhHkAmIZMoExNsW8A4xDGkN+ohzx75OVsUp
h0n6/3ZpdPpGKwU6iUkZqEJrRhp9/YeqjXA5WvDRnTpV02Mb/Bm1kHyPVUtCuzzwNV0zkyp6JGQ/
ThOW4N/lNKbNBAf5qiZaaX5G6CGeS77Oc8Lbky4AAAAAAAA=


--=-5531u6VY2NHI57+ooHBJ--

