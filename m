Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52192D73A0
	for <util-linux@vger.kernel.org>; Tue,  5 May 2026 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973994; cv=none; b=tyg2A9X/eKw1lH2auuTgl+P2XsItdZPfReC3ibCO72SDbu+ng6U36pkv3//T1EvBwpIFmlogu+RL9Z1Jmxv8zMZs2y6oWVckMmFsZc1RYnjKumXE1udwr5RC08RsNq0FJJXCMmH7ZlmaDQMLBCwSHUYO5h1FWAsIjaldZGmlxCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973994; c=relaxed/simple;
	bh=xTKsapwNyx6zf+dV3HneBhrmacZN+FsQvzdPSj9dFUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fznW0tMqH4eGW1E6dKoi0WFJ3et+ibsC3jP9JMdCo/azyWnj5l2qocF25YjrIiL8BKuD83y6uxgv+I82mfUcVPW8c6zpbv2n9iw0bu5D3vi7M+p0/QLBIubkbe+PncCtZfMjYMgqu0B/LRuF5s0tRc8136ELoiFzWtEWtQgx10M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RIWBymet; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XPYtYQLv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=A7ovLQFY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JMVWGmi/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RIWBymet";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XPYtYQLv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="A7ovLQFY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JMVWGmi/"
Received: from boole.nue2.suse.org (unknown [IPv6:2a07:de40:a101:3:21c:c0ff:fea4:1c14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5C3E55BD6F;
	Tue,  5 May 2026 09:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777973989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8QWD2I+LSHD0IgGkiOO3WZdeh0htK251JkHzDa+mRs=;
	b=RIWBymetmStlToW2GWH4oEnlBUa16d2r0/DSk80i/7c+ZqDiH+IVQ+qDIrfRy9iVlNY+oM
	Ui/2dWzSoG3dS1RwLBQNtTk6LPCd9XYty3hZzixmf1Ltv+jJ/3QGomgw8c4ry/cgSWT65C
	w7Z68J+x+7NkITIVQzuJPeYsKJLXIFg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777973989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8QWD2I+LSHD0IgGkiOO3WZdeh0htK251JkHzDa+mRs=;
	b=XPYtYQLvQDGCn0MPJ9iZqvAzAhtsxGvx+ANpNUpUFjCE0We9YK7dU/Z4yoSdCEovHKLqjZ
	PolD45Sise596+Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=A7ovLQFY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="JMVWGmi/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777973988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8QWD2I+LSHD0IgGkiOO3WZdeh0htK251JkHzDa+mRs=;
	b=A7ovLQFYE4i4AGUA6HeGvbWXKJyEfaj35fQY9NInR/OOcSvfjGMe5HVGGefnLWF+5Ol+Fh
	F9uz3Xc1an6ZLDFTIo3Aj2lXvtDRYqf1BlsN5G38PSHVRqjVPplU9Y5xPiYI/j4iq5iehl
	lYHUhf311gA9w60lQ0dZB6QdCrV2q6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777973988;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+8QWD2I+LSHD0IgGkiOO3WZdeh0htK251JkHzDa+mRs=;
	b=JMVWGmi/xLUGpYiRY2+oCZB9uLuMj4X8cfIxoW4ikl67W7p8qkcmbH1TaEtkXFkZOsLLkg
	1LG8I+YYwpJ7+xBA==
Received: from boole.nue2.suse.org (localhost [127.0.0.1])
	by boole.nue2.suse.org (8.18.1/8.18.1/SUSE Linux 0.8) with ESMTPS id 6459djEq006948
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 5 May 2026 11:39:48 +0200
Received: (from werner@localhost)
	by boole.nue2.suse.org (8.18.1/8.18.1/Submit) id 6459djtt006947;
	Tue, 5 May 2026 11:39:45 +0200
Date: Tue, 5 May 2026 11:39:41 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Secure login and sulogin on S390x
Message-ID: <afm64TLjowwedG4l@boole.nue2.suse.org>
Mail-Followup-To: Chris Hofstaedtler <zeha@debian.org>,
	util-linux@vger.kernel.org
References: <20260429092825.17623-2-werner@suse.de>
 <afjqh57bXkLJ_FKr@zeha.at>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qrXG9ok1cYkYRYof"
Content-Disposition: inline
In-Reply-To: <afjqh57bXkLJ_FKr@zeha.at>
X-GPG-Fingerprint: 1B06 BF5A 3829 90FB CBA2  75BE 50E9 0D55 1DC1 6B2E
X-MS-Reactions: disallow
X-Spamd-Result: default: False [0.19 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	HFILTER_HOSTNAME_UNKNOWN(2.50)[];
	SIGNED_PGP(-2.00)[];
	RDNS_NONE(2.00)[];
	FROM_NAME_HAS_TITLE(1.00)[dr];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HFILTER_HELO_IP_A(1.00)[boole.nue2.suse.org];
	HFILTER_HELO_NORES_A_OR_MX(0.30)[boole.nue2.suse.org];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:a101:3:21c:c0ff:fea4:1c14:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:a101:3:21c:c0ff:fea4:1c14:from];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:a101:3:21c:c0ff:fea4:1c14:from];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_HAS_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,boole.nue2.suse.org:mid,boole.nue2.suse.org:helo]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 5C3E55BD6F
X-Spam-Score: 0.19
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO


--qrXG9ok1cYkYRYof
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 5 May 2026 11:39:41 +0200
From: "Dr. Werner Fink" <werner@suse.de>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Secure login and sulogin on S390x

On 2026/05/04 20:53:30 +0200, Chris Hofstaedtler wrote:
> * Werner Fink <werner@suse.de> [260429 11:30]:
> > Some remarks: on S390x architecture of modern zSeries the hypervisor
> > does log the console I/O.  For both the 3215 half duplex line mode as
> > well as the 3270 full-screen/block mode console type the I/O is logged
> > on the hypervisor's side.  To control this there are command send via
> > /dev/vmcp to tell the  z/VM control program of the hypervisor not to
> > log during entering the password.  For the 3215 console also automatic
> > scroll is enabled which avoid to press CLEAR to get the password prompt
> > if on the next block.
>=20
> [..]
> > 9 files changed, 436 insertions(+), 12 deletions(-)
>=20
> This seems to add a lot of code to util-linux. I was wondering if sulogin=
 is
> the only place that needs this log filtering. What about su, sudo, doas a=
nd
> so on? Note that there are different su (and probably doas) versions in u=
se
> across distributions.
>=20
> Wouldn't it be better if the hypervisor would not log input if the termin=
al
> output was disabled? That seems like behaviour commonly found in other
> virtual terminal emulators.
>=20
> Best,
> Chris

Maybe other hypervisors have the same behaviour.  Nevertheless the
3215 console is half duplex printer like a punchcard based teletypewriter
running within the hypervisor of an zSystem firmware.  Means every zOS and
Linux instances are VMs on such zSystem.  The 3270 console type is a bit
better as it understands escape sequences and is a block mode console type,
but still you have primitiv local prompt within the hypervisor and not on
the linux side its self.   You can compare this with qemu within virt-manag=
er,
but AFAIK qemu does not log keystrokes.

The vmcp.c is a copy of the version I use for my blogd in the showconsole
project at https://github.com/bitstreamout/showconsole

Werner

--=20
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr

--qrXG9ok1cYkYRYof
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJgBAABCABKFiEEGwa/WjgpkPvLonW+UOkNVR3Bay4FAmn5ut0sFIAAAAAAFQAO
cGthLWFkZHJlc3NAZ251cGcub3Jnd2VybmVyQHN1c2UuZGUACgkQUOkNVR3Bay70
Iw/+PXZ5Vm2dUQXqFoG14tleZj3ZGXHkeHTY/vlMMQ2WF1KxrF6wLh45MCELjvUt
nvu+VGn89vodJIAnp96q0QMWTYjbiuc8V+Zqz4QUyRea61Z9/gU/jhUIz6UAXWv8
RXMl8Qp1cdDqEn6UcjLoN2Vsqfg3Kd5XZDoNMVoUsjZc+zcI+8OUJHOx3bXKkknk
+npt94gpNjDkI6xIC8zoUDFq16ch9kEnoSiPFu8arwgO+wqBHn9h+oKv74v3EKKO
iZUp1NAy9e6sIyavGL5NLYIkn4MU2XxoCVwNP6/QxQkWmTzXltc03rEdKQFSONMG
YybZzICBKs96UN2PQXl4Wy+S8RI6doZp354uBoh4oV6G6+qSV60zgpAKIkwG5/J9
a8vsYc0y2cli+WCwmLYlHlhltoDmjNCIxgR24XpU6PSUKCNV3g0j9rTcq1IdqFOW
X7HVRvnWrfKm/VLySzs2aH3JqBM+V2aZ8izjOttlPg2vL6129RHv7/dmJuKU4OHH
73m9No6m4orL5H1gYHq12J5gXGSQ814Au0F+/WUadCKk1dwyt6RIOj4zqFiABTXa
gtIMipNadjr3l/aqplQVOs+a9pVPCNCGLD7u9dI1C0bmAj6T9MN1yTJANc4uk6Gb
FXs7ytewvtz7uyKA/zbUvrh8JZiBNQbtHsQ2gis+DASoESg=
=zgqy
-----END PGP SIGNATURE-----

--qrXG9ok1cYkYRYof--
