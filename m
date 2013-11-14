Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:44835 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761Ab3KNSpX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 14 Nov 2013 13:45:23 -0500
Message-ID: <52851A42.7090401@ubuntu.com>
Date: Thu, 14 Nov 2013 13:45:22 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: cfdisk trips on out of order logical partitions
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

cfdisk's partition parsing logic is flawed in that it assumes they are
in order, so if you have out of order partitions it complains that
they overlap.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJShRpCAAoJEJrBOlT6nu75jiYIAJJrq7QAm0uvYUqXlrH9PaD4
EKNdda9uoDdQ77ZbT69X3/53SLq/pG3MPrnKvrJvZ3O1xELNoxiqddxDYoYc+gR1
09EKiFoF+3ifMoK+h3DrRVBGyBsoJoKD47EwSBK6CehVdvfUZJifkq3Shs6YhURT
PukmY3r5jfWGWi/5FRNXu75zR8IJHlgH1Y9MIk7RsIO2rt8WMWAblSxu5W1SLH6G
9ChxK7hiEebxLtimIACzcie7CmE5ZdwDKo8bM2OLeAxt4XCqgzDM59p0wJX0v/h1
oIGM7EASTFFB/iabZZSoBlNblHnS5Mx6hA7+WcZ6VNmccX72fU8hqStBL90USSE=
=ZNSa
-----END PGP SIGNATURE-----
