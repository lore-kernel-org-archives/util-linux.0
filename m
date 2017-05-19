Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:58944 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751708AbdESHOb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 19 May 2017 03:14:31 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B4F18AD03
        for <util-linux@vger.kernel.org>; Fri, 19 May 2017 07:14:29 +0000 (UTC)
From: NeilBrown <neilb@suse.com>
To: util-linux@vger.kernel.org
Date: Fri, 19 May 2017 17:14:24 +1000
Subject: "mount -o remount,rw" sometimes doesn't work as expected.
Message-ID: <87wp9djp2n.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--=-=-=
Content-Type: text/plain



Suppose /foo and /bar are bind mounts to the same
filesystem which is currently mounted read-only,
and suppose the /etc/fstab contains

  /dev/sda1 /bar ext4 defaults 0 1
  /bar /foo none bind 0 0

Now if I want /foo to be writeable I might try:

  mount /foo -o remount,rw

and would then be surprised that this doesn't work.

What is happening is that because only one path has been given, mount
needs to find the other and goes looking in /etc/fstab.
If finds an appropriate line and parses out the options.
Then the mount system call used is

 mount( "/bar", "/foo", ..., MS_REMOUNT | MS_BIND ,....)

This changes the per-mountpoint ro flag to rw, but doesn't change the
filesystem itself.  This can be seen in /proc/self/mountinfo.  There
are two r[wo] flags, and they are different.

Had I run:

  mount /foo -o remount,bind,rw

I would have expected this.  But as I didn't explicitly ask for "bind",
it is confusing.

I think it might be good to ignore "bind" in /etc/fstab when "remount"
is used.
However.... when "remount" is used, the "device" is ignored, so there
isn't a lot of point hunting through /etc/fstab to find it.
If mount is given just one path and the "remount" option, then maybe
it shouldn't try to find an /etc/fstab entry at all?
I guess you might want to remount a device??
Is
   mount -o remount,rw /dev/sda1
allowed?  In that case, don't look through /etc/fstab if the path
is a directory.

I haven't provided a patch because I'm not 100% sure what the best
approach would be.
Does anyone have opinions on what mount should or shouldn't do when
remounting and only one path is given?

You could possibly argue that the current behaviour is correct
as /foo is listed as bind mount.  That doesn't stop is being surprising.
Also
   mount /bar /foo -o remount,rw

doesn't pick up the "bind" flag, so the filesystem gets remounted.
So I think there is definitely something wrong.

Thanks,
NeilBrown

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlkem1AACgkQOeye3VZi
gbk0pA//cwVbaKgBn8sKb2xj405DFpwG8rFSKeIuU2oAaX3wQyzIjtIkSbiQsX7S
GMrFTAabb1z8Y5TONY+YOGAJHENIqcLhBqkN9kd85gbl3DDN+9bTHZyztrX1LTIQ
u+BPXq0vE8JNaRAyHomZ5lgAcJBpcAp46xa/uDHQkBodnH6qR0uWVUeCGu9+BzfA
VS7nA+1U34sDH73MTFv9uVLMslgnQ80ILa1kKF/40coQ6+jnxBQNdXBUwKhPte6E
eAK4r/nndMxy9mqqbfjPVyHv4AQYxK8Cb53IdsFa+TJOLPxEHWDWZNf60IPNUSyF
0+19h+kr8fFRtuZ5Zz3KEQHObc0t21/eX5UW0F9FosCPVUQIncUlY4AeP/q3MwU3
uyuU7IGf2aJMgEzrQfjFrZ0F3aJv53lZyIklp9Crbvqp3FziYSu9LZdat0z6/PMJ
2nACg4zrRU7XimbrvJYxLzVxCuj/spwDKU1nQxyP0xQ6JYcPHMMqLULRomEZgkuC
v+cHVuDFDDFk6Qet3HckUzOxvnxolrjND/kuFwRE7sTl19SFYxyAHZXTYh27zKVR
FV/JPER0+/H8t/0owQzvkIS+jsWbrwd1WTS5nYd+cQ3+7iHITgmhdEt5puwkxVu7
bGhPeDXHRJ2pdaQGdaotb8QLZfaHtQtJ9khhBZ6gP4S3hz1ZU2c=
=odhj
-----END PGP SIGNATURE-----
--=-=-=--
