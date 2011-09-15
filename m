Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:46475 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162Ab1IOIXB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 15 Sep 2011 04:23:01 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 858308C061
	for <util-linux@vger.kernel.org>; Thu, 15 Sep 2011 10:23:00 +0200 (CEST)
Date: Thu, 15 Sep 2011 10:23:00 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>, Michal Kubecek <mkubecek@suse.cz>
Subject: Re: [PATCH] flock: make flock(3) work on NFSv4
Message-ID: <20110915082259.GD15191@foxbat.suse.cz>
References: <20110915081916.GA11152@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GpGaEY17fSl8rd50"
In-Reply-To: <20110915081916.GA11152@foxbat.suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--GpGaEY17fSl8rd50
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 15, 2011 at 10:19:17AM +0200, Petr Uzel wrote:
> To pleace an exclusive lock on a file, NFSv4 requires
> the file to be opened RW because of the emulation of flock()
> by fcntl():

Argh, the subject be:

s/flock(3)/flock(1)

... sorry


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--GpGaEY17fSl8rd50
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk5xteMACgkQnZxG0T6qDD3MNQCeIUY4ekjALeohdzghAZPq/cGt
5FcAnj580MSh204mAyJI8qjE1QC4j0xZ
=cMq7
-----END PGP SIGNATURE-----

--GpGaEY17fSl8rd50--
