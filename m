Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f173.google.com ([209.85.128.173]:35890 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751760AbdFNVEh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 14 Jun 2017 17:04:37 -0400
Received: by mail-wr0-f173.google.com with SMTP id 36so17261105wry.3
        for <util-linux@vger.kernel.org>; Wed, 14 Jun 2017 14:04:37 -0700 (PDT)
From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
To: util-linux@vger.kernel.org
Subject: libblkid & empty identifier values
Date: Wed, 14 Jun 2017 23:04:34 +0200
Cc: Karel Zak <kzak@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6191489.qGPn2sgcKh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201706142304.34356@pali>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart6191489.qGPn2sgcKh
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello!

Technically UDF filesystem allows to store empty string values.=20
LogicalVolumeIdentifier (label) according to UDF specification shall not=20
be null, but it is possible to store empty string there.

Question is, what should libblkid's udf code do if e.g. LABEL identifier=20
is empty string? Should it set empty LABEL for libblkid? Or it should=20
not set LABEL at all?

Currently in blkid_probe_set_label() is check for len > 1, so empty=20
string is not possible to store for LABEL. But when check fails function=20
return non-negative value which is understood as succeeded -- even it=20
did not store empty string. It does not looks good... Or it is expected?

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart6191489.qGPn2sgcKh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAllBpOIACgkQi/DJPQPkQ1LBvACZATvUJr5T+SfrhqFqb83YpaRd
SDUAoJzdCOzcYOGQPoi1/zrrB8672Kp3
=RX+v
-----END PGP SIGNATURE-----

--nextPart6191489.qGPn2sgcKh--
