Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.foxkit.us ([192.65.240.226]:42762 "EHLO
	mail.wilcox-tech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753617AbcAGWNS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Jan 2016 17:13:18 -0500
From: Andrew Wilcox <AWilcox@Wilcox-Tech.com>
Subject: [PATCH] fdisk: Add GPT type GUID for Itanium Linux root
To: util-linux@vger.kernel.org
Message-ID: <568EE16A.8010609@Wilcox-Tech.com>
Date: Thu, 7 Jan 2016 16:06:34 -0600
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ibqmR0Q9gM3gfBmAEEOkS3AcS9D3uLHGF"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ibqmR0Q9gM3gfBmAEEOkS3AcS9D3uLHGF
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This adds a new GUID partition type for Linux roots on Itanium (IA-64).

Ref:
http://www.freedesktop.org/wiki/Specifications/DiscoverablePartitionsSpec=
/

Signed-off-by: Andrew Wilcox <awilfox@adelielinux.org>
---
 libfdisk/src/gpt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libfdisk/src/gpt.c b/libfdisk/src/gpt.c
index 607cb32..8289ac4 100644
--- a/libfdisk/src/gpt.c
+++ b/libfdisk/src/gpt.c
@@ -196,6 +196,7 @@ static struct fdisk_parttype gpt_parttypes[] =3D
        DEF_GUID("69DAD710-2CE4-4E3C-B16C-21A1D49ABED3", N_("Linux
root (ARM)")),
        DEF_GUID("4F68BCE3-E8CD-4DB1-96E7-FBCAF984B709", N_("Linux
root (x86-64)")),
        DEF_GUID("B921B045-1DF0-41C3-AF44-4C6F280D3FAE", N_("Linux root
(ARM-64)")),
+       DEF_GUID("993D8D3D-F80E-4225-855A-9DAF8ED7EA97", N_("Linux root
(IA-64)")),
        DEF_GUID("8DA63339-0007-60C0-C436-083AC8230908", N_("Linux
reserved")),
        DEF_GUID("933AC7E1-2EB4-4F13-B844-0E14E2AEF915", N_("Linux
home")),
        DEF_GUID("A19D880F-05FC-4D3B-A006-743F0F84911E", N_("Linux
RAID")),
--=20
2.6.4




--ibqmR0Q9gM3gfBmAEEOkS3AcS9D3uLHGF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWjuFqAAoJEMspy1GSK50UF/YQAKGpDbsiUSzdGxwyiRbY1ji5
QZ/mhrUvsNY7B5B1TRIcK54e2lZBVtaxy1p4JOLBxaZwm6HaXRHX5BxUqFKCEoxW
srJYr+LzulE/Quh6F0jGmrqp0gA3tlknszoIcANPu8jCOYTVQBmNGpb/TxRR2Lgn
DWwfg9f88JxPbCWRPdkbIm7DakAKtWsnphCzVhX/RTQ81+UiIHa9WHn6mkvxWe8C
HF4ufc9jJ+znCtOApJHYb95L9cYUdLnVBTU+0ewMQJbKG1i2CpcnfSdxkQvj5vGT
YxHKPys46qe/7dZ9z4XNnal3kZTeW2r/6t0eBGZ/1LUi4cj7Pp/QYI7GMILsdd0Y
NAA9IEoi1KrYdosKpeOtZnBeoiRZqLZlEldEEzUxX3gWWq/U10QMzMSMjGFyhjdY
3gT8s24TgnbQpnJIzdHMzJNRxA6loltJyEdTta0kdtijKtqmrhACBP4yjLF/1Mdh
9G/gmMzW56q7NcSfowHS6XIFmWaOdnfT/fqTTAkqDXY5Q8GxRn4kR5zmrAqH8A/0
3zReE5RxEYnYaWE5/2VBVb06d3XR0WvX6OYx75xdl7oCoSaxmUdu2WwV0x0UtlcF
wUDWrmSy+DCzO3v/u5DMbhpNgvP/xNniOsgJRCPxkYg6RcYy85L4fvu3M6urtSEM
dH5nb48tOQf/MTHeqJ1S
=voDl
-----END PGP SIGNATURE-----

--ibqmR0Q9gM3gfBmAEEOkS3AcS9D3uLHGF--
