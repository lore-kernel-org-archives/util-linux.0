Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:49696 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732Ab3KAO73 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 1 Nov 2013 10:59:29 -0400
Message-ID: <5273C1CF.8020000@ubuntu.com>
Date: Fri, 01 Nov 2013 10:59:27 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: blkid does not escape quotes in volume labels
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

e2label /dev/loop0 'La"bel'
blkid -p /dev/loop0
/dev/loop0: LABEL="La"bel" UUID="cb71cd2a-5237-44b6-92f1-d2bff59ed688"
VERSION="1.0" TYPE="ext2" USAGE="files
ystem"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSc8HPAAoJEJrBOlT6nu75jGQH/jMMW9Hahbwhbp1Op+7HBP8Z
zkPqZiglRtk3JPsH8jGCvbLHWTC0GQse1cp8ySC0xfaUIaNkU+ikpajovpaNqhuE
O9sZ0g3pWjGGw/pFEHbWygEmAVFi8RVPyPz/FIuH++Vm/D2wXau7D+/lCJRamT+3
NE4EEdDm40ISn5NNvRJcm08Hjaxe98cAa9bGZcklxAyJFEWLf3iBCrDah3tkfFnA
FtzbOZn/fVTnpTxXVjP0A2tF0UmXKthFzRreUhpz7Xn3wN2vykLEdMDVUgBJPqea
I8I3VFL+Pf0C1TUq2Q62u0gnGeUKk4F4nlY1aIf3OoR3VRh/Tq4GOrx7B1/80sI=
=rLB4
-----END PGP SIGNATURE-----
