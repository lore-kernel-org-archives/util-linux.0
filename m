Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:48842 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785Ab3KATVO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 1 Nov 2013 15:21:14 -0400
Message-ID: <5273FF29.1090403@ubuntu.com>
Date: Fri, 01 Nov 2013 15:21:13 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: external mount utilities and utab
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

When mount runs mount.cifs, /run/mount/utab is not updated, so the
user mount flag is lost and thus, I can't umount as the user.  Running
mount -i works correctly.  Is this a bug in mount.cifs, or should
mount be recording these options whether it runs the external helper
or not?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJSc/8pAAoJEJrBOlT6nu75ybMH/jtQUtC2FJ78ohCc7jsFYh6u
UU+lL4K4AdUQBZ44/cW23N8KV1fNppeF4JhYeHaIiCv0DWw4pglMsMN2HhCJuY01
8rYXRo5MVvvO/TpZlomm5JPIbuTaAyCChgU7doQXCyVTzXSi+On8KOFpXachqMiq
fPWL1wBQpSCS11n3+f4O7trkg8pB8pXuNYk+TcUEzRM11yEpu0Q+XvYN6po9faZc
YDJKyb4Zq2+b3Xp3jbfa15wMQ01hpVG6XZBFeBkmOdvdMmHvzO0Qgj1bYAPp+WEr
Ea4lDFtgedNlL0dGYmlyktywK8mkKTTMpq/dGE3ChTSZLl/DSFfx6s5nSQi5s5k=
=JvkV
-----END PGP SIGNATURE-----
