Received: from router.bayer.uni.cx (ip-89-102-24-34.bb.vodafone.cz [89.102.24.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FB41C27
	for <util-linux@vger.kernel.org>; Sun,  6 Apr 2025 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.102.24.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743936723; cv=none; b=k7d/i1bHsnyod9LkhYtCNj9JHTEqrdZ8UdL/vZg8FSNiwqkcAlmHb9lp7pJpxSC9IXC5h50qe9kgH30+XqYIUvVqo/bPVnf4EMrBjbeylzGwmroAO6DFgjyXvzoVD9HNwDfSBGhNGeatwZUx4Ev5zj6PNdL3TlR2/ni3ybQP0Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743936723; c=relaxed/simple;
	bh=1I9pI3cMZpd5KY0wWpURWKD/FY9jafJ6OKVN/Ps4720=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GMzXAXcSdNMUkFBaGPlHPehoDbxOAon/03FBt9APe8bvtNhPsdbvCJfIx+MeSIon2Y+JRRUPlcPEdSTk+GFXTiTncAgceStw6fOWp6CLpyPKFdj7POyL8qBII3l6eB+j5qeEpA+/IVFG/E1j7ZCRI8AXksaCtNfdrQzbohkqx1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=atlas.cz; spf=fail smtp.mailfrom=atlas.cz; arc=none smtp.client-ip=89.102.24.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=atlas.cz
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atlas.cz
Received: from album.bayer.uni.cx (album.bayer.uni.cx [IPv6:2001:470:993c:1:5246:5dff:fe8e:a186])
	by router.bayer.uni.cx (Postfix) with SMTP id 4FC45A0A5D
	for <util-linux@vger.kernel.org>; Sun, 06 Apr 2025 12:45:53 +0200 (CEST)
Received: by album.bayer.uni.cx (sSMTP sendmail emulation); Sun, 06 Apr 2025 12:45:53 +0200
Date: Sun, 6 Apr 2025 12:45:53 +0200
From: Petr Pisar <petr.pisar@atlas.cz>
To: util-linux@vger.kernel.org
Subject: Message typos in util-linux-2.41-rc2
Message-ID: <Z_JbYZ-SdnjxZB0K@album.bayer.uni.cx>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5eQ6JJQCWyrEtTvy"
Content-Disposition: inline


--5eQ6JJQCWyrEtTvy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

when translation util-linux-2.41-rc2 to Czech language I found these issues in
the orginial messages:

# FIXME: Wrong manual section: setuid(1)
#: lsfd-cmd/lsfd.c:2197
msgid ""
"     --_drop-privilege        (testing purpose) do setuid(1) just after "
"starting\n"

# FIXME: Superfluous \t\t\t\t
#: sys-utils/ipcrm.c:59
msgid ""
" -m, --shmem-id <id>        \t\t\t\tremove shared memory segment by id\n"

# FIXME: Superfluous \t\t\t\t
#: sys-utils/ipcrm.c:60
msgid ""
" -M, --shmem-key <key>      \t\t\t\tremove shared memory segment by key\n"

# FIXME: Superfluous \t\t\t\t
#: sys-utils/ipcrm.c:61
msgid ""
"     --posix-shmem <name>   \t\t\t\tremove POSIX shared memory segment by "
"name\n"

# FIXME: Superfluous \t\t\t\t
#: sys-utils/ipcrm.c:62
msgid " -q, --queue-id <id>        \t\t\t\tremove message queue by id\n"

# FIXME: Superfluous \t\t\t\t
#: sys-utils/ipcrm.c:63
msgid " -Q, --queue-key <key>      \t\t\t\tremove message queue by key\n"

# FIXME: Superfluous \t\t\t\t
#: sys-utils/ipcrm.c:64
msgid ""
"     --posix-mqueue <name>  \t\t\t\tremove POSIX message queue by name\n"

# FIXME: Superfluous \t\t\t\t
#: sys-utils/ipcrm.c:65
msgid " -s, --semaphore-id <id>    \t\t\t\tremove semaphore by id\n"

# FIXME: Superfluous \t\t\t\t
#: sys-utils/ipcrm.c:66
msgid " -S, --semaphore-key <key>  \t\t\t\tremove semaphore by key\n"

# FIXME: Superfluous \t\t\t\t
#: sys-utils/ipcrm.c:67
msgid "     --posix-semaphore <name> \t\t\t\tremove POSIX semaphore by name\n"

# FIXME: See, no superfluous \t\t\t\t here.
#: sys-utils/ipcrm.c:68
msgid ""
" -a, --all[=shm|pshm|msg|pmsg|sem|psem]\tremove all (in the specified "
"category)\n"

# FIXME: Superfluous \t\t\t\t
#: sys-utils/ipcrm.c:69
msgid " -v, --verbose              \t\t\t\texplain what is being done\n"

# FIXME: missing "than in human readable format"
#: sys-utils/lsipc.c:340
msgid " -b, --bytes              print SIZE in bytes rather\n"

# FIXME: Typo in --seccomp-filter option name
#: sys-utils/setpriv.c:1028
msgid "duplicate --secccomp-filter option"

-- Petr

--5eQ6JJQCWyrEtTvy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE4/QvzhVoMKgDWObpT9GuwzZa978FAmfyW2EACgkQT9GuwzZa
97+2Pw//e12v01GYJVJj0ZxZF77gqD3YbO32V7YVCV6X+hkSyrrMjOzHZ6GlsF92
D6sJRsCfvf/p7XfYLQbX9JthHzvLTg09yKfAOKLEk7dqkUWkzn0wmECEq3LryZIr
meY69cTlu/EnkIV7MNHm1fY39EVsHptArS8p9+GvA316y7Svc0c8ugzQvcdtvTZW
/AV/H3gDKbEk1yBw5tv7HJpp1gg3B/0F/i7UI3RCYdTikqm/Yru7udxgXfRP34Vf
ige7eCs2M439L5+CuKEQ0RY1HU2SKs+sCiRHtNALDKfPegNfg65L6JKnWgTsTy92
e8oQoUEQw6GVWBQOCIkEOor42YWJ9s8zC95prZngX40rYNqdv6FYFYQnNhOwt60h
ilT2WjgaqL53jq56hh9MqdtRMnacdCV5TQSB83uBG63JtJPmSThcitdsHlYUH4H3
97tV3MLVHCBqjWmYPLIQCwXdCIhj54JtOTcc/niuOlzaQVA3btpdkyBIbIxebVk1
TZOzEvzo+/T408JHsDTQFwe3JuO8ChjrNUpviKrGqunzcsEVs4PT1souFsQk3kL0
QJsU4DWuY77F7w1GcVoat4CLanZQ2GpYKBtVHJzZsO1cPj2sLfPGhMbRrDDNlHsd
8VH1bi5Ydi/FvPEZJtruoMcJQA6+rCWkhbTWE5V6tl+pHqv/Ons=
=4gTw
-----END PGP SIGNATURE-----

--5eQ6JJQCWyrEtTvy--
