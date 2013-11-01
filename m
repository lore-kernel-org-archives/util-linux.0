Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:48767 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab3KAQyQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 1 Nov 2013 12:54:16 -0400
Message-ID: <5273DCB6.4020909@ubuntu.com>
Date: Fri, 01 Nov 2013 12:54:14 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: /proc/mounts doesn't store bind flag
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When symlinking /etc/mtab to /proc/mounts, bind mounts no longer have
the bind option stored.  Is this a bug or working as intended?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSc9y2AAoJEJrBOlT6nu75ihwH/A/rKo6GYPN+fIS+eA271n2X
jqeGjHZr3mLfu5NGv+ihBWc9DM7zpxUXjWLzgY6+kyZ0RKyYbsbruQJLK3m+DPh5
+QASQ0p7ptKEArimKGeRMwqOlg0rRscZZRcPiT26ntwaS4aTreKtM2MvkJOdx2nR
XqQTFyWOlu6neo4cS1fZse+sFO6PcwnsyB1zclRVcQbSMS0e/8qS7SKZ9PO8KRzS
goT7gzvM/ShXmpOSblurFn3HFuVFswElDQ6WgWoNGHnJL9ClenBygUT7pMMj3Pbx
qyHJzCW67Tc4iBDBN3V6g3y3ZmyCzKvTe2BQop009KnPeutlv8yzEVYW0f7XST0=
=+HTn
-----END PGP SIGNATURE-----
