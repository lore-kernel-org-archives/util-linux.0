Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:35557 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755888AbaBROuR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 18 Feb 2014 09:50:17 -0500
Message-ID: <53037325.3090808@ubuntu.com>
Date: Tue, 18 Feb 2014 09:50:13 -0500
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Option to create missing mount point
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

A debian bug has requested that mount create the mount point if it
does not exist yet.  My initial reaction was no, but one use case does
seem to be a good reason.  That would be if you want to set up a tmpfs
mount with several sub mounts in /etc/fstab.  You currently can't do
that since when the tmpfs is mounted, it is empty.  Is this something
that might be a good idea?

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTA3MlAAoJEI5FoCIzSKrwb0EH/RN9N2CflAi5xhegkPk+wtcH
pJnoHZROF2vID8eRy4tLxIoWhsKDAhIjEG7GWWOnrQwBpTJqf36+4ah8djuYAZDq
TfVIuEG/Ww1ByoP2K7AqgN2URKW8Z91SxSZM2PLLAg91lg7nM8WTbnhCm2znOABj
lQsXEYdKh/8n8bb8w/SULhF3ffbj0tMPpnY3LjI1RkbQcp3CjqqBtmJG4XM9M0L0
7PUAdDpk2FiiWGYi/PfMMajfjeb8S80n+v/Gmvz0LJWPBkdeW2hP1gosyGL3gKgm
MzpV8bInWV18s0qWcqgrfxoS8mWxgTSZowf0/cQVkNKnsleET3UMxo/Qo55O1n4=
=Cdtu
-----END PGP SIGNATURE-----
