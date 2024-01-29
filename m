Received: from herc.mirbsd.org (bonn.mirbsd.org [217.91.129.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9A9159577
	for <util-linux@vger.kernel.org>; Mon, 29 Jan 2024 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.91.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567332; cv=none; b=ZeBQ56/ZWKQIyIdSzY3iSG5kqPAwE8m4PD5FUDk5YBpE9inNqWxvvKsMdf2bfsEkPuFKa5Lep+7J2XWA9Q1Y/9XOoNM/wWP2ZlltfC5lSkUA4cBhxiDdN2wUCdifb4iaDmP8dYZy1OEgDjSIL4mY62s/GaH1bYjB+bZXRH1f0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567332; c=relaxed/simple;
	bh=b+RBrlwtvRxIc9rCyZntJhYHZD7nutfc5fef8RBCPlI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Bbx84cU5oxsipocK0PfXcxsxcSkBZUap7kbjM478ss7NndNn6XDfpAJA8azZVgQtB0BMPt9RJp89UJAioMGlMAK/ufvobIq75CVEHQAxPI/iftJKItHAz27cMozw+Nhi9Q7Les50dSNMRUmBhF3I3tjhxndEmsfjsBZS9cJwLXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.91.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 40TMR3h4012881
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jan 2024 22:27:11 GMT
Date: Mon, 29 Jan 2024 22:27:03 +0000 (UTC)
From: Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To: Bill Unruh <unruh@physics.ubc.ca>
cc: util-linux@vger.kernel.org
Subject: Re: fdisk corrupts data on USB stick
In-Reply-To: <70cac0f2-ec94-33f7-4a5d-c17f8eb82588@physics.ubc.ca>
Message-ID: <Pine.BSM.4.64L.2401292219080.19873@herc.mirbsd.org>
References: <Pine.BSM.4.64L.2401291659410.19873@herc.mirbsd.org>
 <478ec62d-5485-42c3-b492-6ccfa9bf62c8@t-8ch.de> <Pine.BSM.4.64L.2401292023270.19873@herc.mirbsd.org>
 <5b8f9459-cc95-4c08-b68c-39abb2ff9f68@t-8ch.de> <20240129205623.sgvkhcyyepbsjzh3@ws.net.home>
 <Pine.BSM.4.64L.2401292118320.19873@herc.mirbsd.org>
 <70cac0f2-ec94-33f7-4a5d-c17f8eb82588@physics.ubc.ca>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Bill Unruh dixit:

> the usb. Now you will have a 2GB partition on the usb that you can write =
to
> etc. It will I believe be ext4 by default although you can choose others.=
 No

Again, I prefer to keep the original ISO 9660 filesystem
at the beginning of the stick so it doesn=E2=80=99t get modified
(by accident or not).

I=E2=80=99ve been doing this for ages, in fact I good as invented
making ISOs directly bootable (before isohybrid reinvented
the same thing, though mine for MirBSD also boot on sparc)
under the name manifold-boot. Incidentally also for grml.

bye,
//mirabilos
--=20
16:47=E2=8E=9C=C2=ABmika:#grml=C2=BB .oO(mira ist einfach gut....)      23:=
22=E2=8E=9C=C2=ABmikap:#grml=C2=BB
mirabilos: und dein bootloader ist geil :)    23:29=E2=8E=9C=C2=ABmikap:#gr=
ml=C2=BB und ich
finds saugeil dass ich ein bsd zum booten mit grml hab, das muss ich dann
gleich mal auf usb-stick installieren=09-- Michael Prokop =C3=BCber MirOS b=
sd4grml
