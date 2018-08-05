Return-Path: util-linux-owner@vger.kernel.org
Received: from vmicros1.altlinux.org ([194.107.17.57]:32864 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeHEMrV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Aug 2018 08:47:21 -0400
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B2F5A72D1DE
        for <util-linux@vger.kernel.org>; Sun,  5 Aug 2018 13:43:11 +0300 (MSK)
Date: Sun, 5 Aug 2018 13:43:11 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: util-linux@vger.kernel.org
Subject: Re: =?utf-8?Q?Debian=C2=B4?= =?utf-8?Q?s?= change of "su" to the one
 in util-linux
Message-ID: <20180805104311.GC11394@altlinux.org>
References: <1734536.DseMWcvaqb@merkaba>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NKoe5XOeduwbEQHU"
In-Reply-To: <1734536.DseMWcvaqb@merkaba>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 05, 2018 at 10:35:34AM +0200, Martin Steigerwald wrote:
[...]
> And then: How to implement a backup script that needs root access for=20
> most operations, but also requires access to SSH agent from a user=20
> setup? Dig out the environment variables of the SSH agent myself?

If all you need from the ssh agent is the socket, then just symlink it
to a fixed location trusted both by you and by root, then you can override
$SSH_AUTH_SOCK to the new location, e.g.

if [ -S "$SSH_AUTH_SOCK" ]; then
	ln -snf "$SSH_AUTH_SOCK" fixed_trusted_location
	SSH_AUTH_SOCK=3Dfixed_trusted_location
fi


--=20
ldv

--NKoe5XOeduwbEQHU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJbZtS/AAoJEAVFT+BVnCUIrBQP/1ENENKsbHl60UFbyje1bV+/
hQcJ2wjZpn9RvhYlPEYgMyoVcxClGy0F/MRU6nkKUY638tkrVyoYIwVX9kc6TEiD
rQrMzlt2Pfagx56grE6eyAKLUALaJG1hTU88ordbvYwQd3syVxfrmHilf/ZRQWIc
P6w1Q9KS/8R+2aR04IqnU4vuRXzD+aV0yqyL24GWYvr0+irUqVbxW3JPjJlt0ql8
XvK53BVrlqLrLYK5/ZcnzBc60UbE40dD9Gr8bDvb2yTO4HUKTKS62TVWAg1sZngz
xNI5B1qhRSB6pnecC58mX3DRHJHlPUCanAcnCsCtb61j2njQ2Xy/MTiFCLTAmgD8
d3e/1FeHK1KCulgqFqHVVfDKL3Obx+ZpIZyE6SLfu8x6z4Gd3Re9hnrR/ujtCF/8
dDLfePT167uhOk3gagGcVUtOgSxTeLtCeekEZgMrNv/pJd0RPbyeG3BKVS4G4Ube
mIWwGprLJipVH3NnB1Rz/1qNxfSLcstb/zwODGR3Rc/RgoN7N+gxz5xGQb0CmFkw
pd5BJ6HpOR92ljp1O0OVI8LRIawBCPta9jhPsho1oRp/cerhyNaMBfJok1IjgqNc
itbovHJGjf1XXN4sA5Caryhz+z/rGMcS87ZO3l4OEEh8lkCD7qsiaobxhYzyUuqo
6WKmaAmJaiH5ThKEpHeb
=6qKI
-----END PGP SIGNATURE-----

--NKoe5XOeduwbEQHU--
