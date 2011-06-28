Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:33418 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756431Ab1F1I5Z (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Jun 2011 04:57:25 -0400
Date: Tue, 28 Jun 2011 10:57:24 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: khlebnikov@openvz.org
Subject: Re: [BUG] umount does not work for disconected nfs mounts
Message-ID: <20110628085724.GE22770@foxbat.suse.cz>
References: <4E098E3B.5060707@openvz.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JBi0ZxuS5uaEhkUZ"
In-Reply-To: <4E098E3B.5060707@openvz.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--JBi0ZxuS5uaEhkUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 28, 2011 at 12:18:03PM +0400, Konstantin Khlebnikov wrote:
> commit 33cee6675edecbd27c0628f8b7c74c7d88fc02b2
> http://git.kernel.org/?p=3Dutils/util-linux/util-linux-ng.git;a=3Dcommitd=
iff;h=3D33cee6675edecbd27c0628f8b7c74c7d88fc02b2;hp=3Dfde25e6be6e00a0998eb5=
8b4b9d0d0b9ad65dbfd
> "umount: allow unmounting loopdev specified by associated file"
> broke umounting (by mountpoint) for broken nfs mounts,
> because now umount always call stat() for target argument and umount hang=
 inside nfs-rpc:
>=20
> [<ffffffff8163df3f>] rpc_wait_bit_killable+0x1f/0x40
> [<ffffffff8163eb85>] __rpc_execute+0xe5/0x2f0
> [<ffffffff8163eebe>] rpc_execute+0x3e/0x50
> [<ffffffff816372f0>] rpc_run_task+0x70/0x90
> [<ffffffff816373fe>] rpc_call_sync+0x3e/0x70
> [<ffffffff812228f3>] nfs3_rpc_wrapper.constprop.11+0x43/0x70
> [<ffffffff81223bd2>] nfs3_proc_getattr+0x42/0x80
> [<ffffffff81212955>] __nfs_revalidate_inode+0x95/0x1f0
> [<ffffffff81212bf1>] nfs_revalidate_inode+0x31/0x60
> [<ffffffff81212cca>] nfs_getattr+0x5a/0x110
> [<ffffffff8112caea>] vfs_getattr+0x1a/0x30
> [<ffffffff8112cce3>] vfs_fstatat+0x53/0x70
> [<ffffffff8112cd36>] vfs_stat+0x16/0x20
> [<ffffffff8112d0c5>] sys_newstat+0x15/0x30
> [<ffffffff816c45bb>] tracesys+0xd9/0xde
> [<ffffffffffffffff>] 0xffffffffffffffff

Shouldn't this be handled in the kernel? Or is stat() really
supposed to fail in such way with broken nfs?

>=20
> so mount /mnt/nfs get stuck, umounting by device is still possible.

We might first scan through mtab to check if umount arg is known
mountpoint and only if we fail, we would look for associated loopfile.

Karel?


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--JBi0ZxuS5uaEhkUZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk4Jl3QACgkQnZxG0T6qDD1xwACfTiSOLhWHbPIzPrG1ARdRj7M6
xLkAn2eh9D8kUj9h/mSnVRZF5+o+mgx8
=4mL9
-----END PGP SIGNATURE-----

--JBi0ZxuS5uaEhkUZ--
