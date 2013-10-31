Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:41982 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753825Ab3JaPx1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 31 Oct 2013 11:53:27 -0400
Message-ID: <52727CF6.5050604@ubuntu.com>
Date: Thu, 31 Oct 2013 11:53:26 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: umount: it seems %s is mounted multiple times
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When non root tries to umount a directory that has multiple mounts in
it, mount dies with this error message.  Why is this?  Why doesn't it
check for the user option and either give the permission error, or
allow the umount?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJScnz2AAoJEJrBOlT6nu75un4H/0PN4ClIVnepvvP7u1/Ozl1c
98dMHTTUuJKNWF/3ad1/RsUVk1HH7IxwE+PsgSuqcDAQV70uJV62RIWokDhlA5UM
8SZbpppENUiDY1lo9dmWOq3ZNbOVOIfhMA9xCnVGsUgUJOozGsRbUAJ0u2Y5SGC+
LKVFqNG6k/LSKce4cxFkZmB4R0/VByBmnztiXt4/bDAgRWDTS9iVAu7pMcuLprhV
kBtuBEGBal9prUq2gSUUOV7+16TBW5r7uZq3AT+lNSBnVBzg0hokf8rwDyb8Iz/3
mVO68THRyyJu5pKp6oJKsFi7JOD4/CnuHAKEun4yTPn5q0dXIhB8lwTvT23ji+8=
=fDSY
-----END PGP SIGNATURE-----
