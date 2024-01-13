Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F196E168A3
	for <util-linux@vger.kernel.org>; Sat, 13 Jan 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabijaczleweli.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabijaczleweli.xyz header.i=@nabijaczleweli.xyz header.b="XWv3kHBB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
	s=202305; t=1705185331;
	bh=+4Rxm3iYlvbckjKj5wkbcxSd0n09jw7pDrTXdmxYGgA=;
	h=Date:From:To:Subject:From;
	b=XWv3kHBBlYVpAUbWMtnxWG2rt9DsFHivuvpSPiXgHP5oyhcfh6CCSAw62XeQXmJ/1
	 9YmzMHSuk0b5RAEnnp9xphUhUB0p1paomiWPllejiW1adnrD1BjVE10Rx9jTpqK1QI
	 ACaePdrgG629U8mdhKaJ+pru10NHP4XzJh0HhCTZgHgFlF9DIBQyI5HhheujOq/M6W
	 RjP8m6SzDGajY0wEpe2veJLeDy+b9Grrm5ynPulc3VrbzB06sVPuMsAV4LpAXAUzJa
	 wDJgZcxK5xbGfClwPCQfxERO7fp+GQJVg8ncXc3MV42kFBxnD9U+dGCqeuRoA7tdBW
	 g+rO2/fo9zQUw==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
	by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id DD65B15790
	for <util-linux@vger.kernel.org>; Sat, 13 Jan 2024 23:35:31 +0100 (CET)
Date: Sat, 13 Jan 2024 23:35:31 +0100
From: =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To: util-linux@vger.kernel.org
Subject: [PATCH] libfdisk: fdisk_deassign_device: only sync(2) blockdevs
Message-ID: <utso6yacwbluj5pou2vwllxfb5dxmhbly5qaumlshga3o5fbgg@tarta.nabijaczleweli.xyz>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xbwxmdw2ngllewu2"
Content-Disposition: inline
User-Agent: NeoMutt/20231221-2-4202cf-dirty


--xbwxmdw2ngllewu2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When not editing a blockdev, syncing disks provides no benefit
(we already fsync() above), takes a long time,
and affects unrelated caches.

BLKRRPART is similarly gated on !S_ISBLK(st_mode) in
fdisk_reread_partition_table.
---
Based on the 2.39 tarball.

diff '--color=auto' -ru util-linux-2.39.orig/libfdisk/src/context.c util-linux-2.39/libfdisk/src/context.c
--- util-linux-2.39.orig/libfdisk/src/context.c	2023-05-11 10:24:24.840187437 +0200
+++ util-linux-2.39/libfdisk/src/context.c	2024-01-13 23:25:56.358057182 +0100
@@ -773,7 +773,7 @@
 					cxt->dev_path);
 			return -errno;
 		}
-		if (!nosync) {
+		if (S_ISBLK(cxt->dev_st.st_mode) && !nosync) {
 			fdisk_info(cxt, _("Syncing disks."));
 			sync();
 		}

--xbwxmdw2ngllewu2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmWjEDAACgkQvP0LAY0m
WPEDjRAAqDfF97TwtHqXqeWVdiPHwom6CSYJBeVnNw+tgjN/2vdMY6oLgSFFOeeQ
2GKDyT0ebRVoj7laiKYGUds+U0YORPzH/Z8aMesCZxGhloW452Gu4mpLyNE5p79R
bh95tX8LCSrxSlVPlmIFMHC1JC/Xl+sSr+UdXPgD9g/L2JG5+ASlyAES1ncg0Wgk
rHOSgBD8txVb5NQ2TW15QkgSWC10DIOaz60nrmK3QxE07NFOzcI+kNBADyxbojpR
M8592kIT935084uEWO++PGDDJRVLwJdKmYP6oZMkvbUCf6UGoBALJE1S6ceVmTp6
RFCXGFn+PAB/Tex6f6IGm5xXF4zBBWli4aYfj7nZsOIeHHHJEax5mf6mgRzPjRuC
fS5O97h0opYRa6OXXISnYpiJ7OLpZxt2Jr3gVOw1BtDv+G4ESF3NXKHydzIYVb3Q
nsQP9L+BwCQ6NJIiZkPIeeEHqUuWW0ZM4eyF8HB86M9l+iP5ZtJ2cLDaDjiBWjJr
SbgHxQYzZK4YNXPgUVonsZiOE503P6QhfrRa9EqC04DnjPyx3DH4TQ9ussRZ6BQ7
8mn0i8Er94RGTl4SQw4adU2TG9Lwna+zjMS0XnPrC7FRMKDh8FH6eRcED5BQQcX+
nSiTGsn2rM9cCtl3hbGakEeUrOf2xAjV6MosNcIpBmwUYkbmSM0=
=OBaM
-----END PGP SIGNATURE-----

--xbwxmdw2ngllewu2--
