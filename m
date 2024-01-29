Received: from info.physics.ubc.ca (info.physics.ubc.ca [142.103.234.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F7F62C6B0
	for <util-linux@vger.kernel.org>; Mon, 29 Jan 2024 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.103.234.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567765; cv=none; b=IXswnfO+5iq8KFIluWv/Kt6H+MHqfSU+dGhEA0QEcUIMUlNwBGgXggq7OFCfyXbn6vW9vetwBYiKdNfZVzvqzC6TgKPFoeJLWdJdAG6mpqgzGD1knMf+DfroZefkgE92YLwMPbl90PjSGaFQB0Ob4q2dANQJ/2HSEKzVc1y3nzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567765; c=relaxed/simple;
	bh=fhUHDEPrUl6Ysqc+ayx9CTbg022UUlsSl3PkFrJhnWk=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VChj3l3XiXiI4z0VjGTISl+5zwPOD52Fwi+EJECvKlPaUsvAulRziNrZkl/xyG4+lHiWjZ69tr85NDkOLQaJKNvgBQ4NYUTWC2wA8mpHzizQwDOfOwRvfnlc9u3iQ3qjjH8Z8nP2EDK4lzvR9rdK5+0b9M0nyAyymdk4a79xBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physics.ubc.ca; spf=pass smtp.mailfrom=physics.ubc.ca; arc=none smtp.client-ip=142.103.234.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physics.ubc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=physics.ubc.ca
Received: by info.physics.ubc.ca (Postfix, from userid 1000)
	id 1E634121126; Mon, 29 Jan 2024 14:36:04 -0800 (PST)
Date: Mon, 29 Jan 2024 14:36:04 -0800 (PST)
From: Bill Unruh <unruh@physics.ubc.ca>
To: Thorsten Glaser <tg@debian.org>
cc: util-linux@vger.kernel.org
Subject: Re: fdisk corrupts data on USB stick
In-Reply-To: <Pine.BSM.4.64L.2401292219080.19873@herc.mirbsd.org>
Message-ID: <10251865-9fc4-2dff-1054-673e64c67fe2@physics.ubc.ca>
References: <Pine.BSM.4.64L.2401291659410.19873@herc.mirbsd.org> <478ec62d-5485-42c3-b492-6ccfa9bf62c8@t-8ch.de> <Pine.BSM.4.64L.2401292023270.19873@herc.mirbsd.org> <5b8f9459-cc95-4c08-b68c-39abb2ff9f68@t-8ch.de> <20240129205623.sgvkhcyyepbsjzh3@ws.net.home>
 <Pine.BSM.4.64L.2401292118320.19873@herc.mirbsd.org> <70cac0f2-ec94-33f7-4a5d-c17f8eb82588@physics.ubc.ca> <Pine.BSM.4.64L.2401292219080.19873@herc.mirbsd.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1737365482-1127008003-1706567764=:1879755"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1737365482-1127008003-1706567764=:1879755
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE



William G. Unruh __| Canadian Institute for|____ Tel: +1(604)822-3273
Physics&Astronomy _|___ Advanced Research _|____ Fax: +1(604)822-5324
UBC, Vancouver,BC _|_ Program in Cosmology |____ unruh@physics.ubc.ca
Canada V6T 1Z1 ____|____ and Gravity ______|_    theory.physics.ubc.ca/

On Mon, 29 Jan 2024, Thorsten Glaser wrote:

> [CAUTION: Non-UBC Email]
>
> Bill Unruh dixit:
>
>> the usb. Now you will have a 2GB partition on the usb that you can write=
 to
>> etc. It will I believe be ext4 by default although you can choose others=
=2E No
>
> Again, I prefer to keep the original ISO 9660 filesystem
> at the beginning of the stick so it doesn=E2=80=99t get modified
> (by accident or not).

isodumper does install the iso filesystem at the beginning of the usb. The
persistant partition uses up the free end of the usb.

>
> I=E2=80=99ve been doing this for ages, in fact I good as invented
> making ISOs directly bootable (before isohybrid reinvented
> the same thing, though mine for MirBSD also boot on sparc)
> under the name manifold-boot. Incidentally also for grml.

Great. I am just pointing out a program which seems to do exactly what you
want. Using it is of course up to you. Of course if you are not on Mageia o=
r a
close derivative, I have no idea if it will work for you without some work,=
 so
another solution might well be better. But solutions already exist.
Clearly had others know of your manifold-boot, they might well have used th=
at
instead of instead of reinventing isohybrid.
>
> bye,
> //mirabilos
> --=20
> 16:47=E2=8E=9C=C2=ABmika:#grml=C2=BB .oO(mira ist einfach gut....)      2=
3:22=E2=8E=9C=C2=ABmikap:#grml=C2=BB
> mirabilos: und dein bootloader ist geil :)    23:29=E2=8E=9C=C2=ABmikap:#=
grml=C2=BB und ich
> finds saugeil dass ich ein bsd zum booten mit grml hab, das muss ich dann
> gleich mal auf usb-stick installieren=09-- Michael Prokop =C3=BCber MirOS=
 bsd4grml
>
>
--1737365482-1127008003-1706567764=:1879755--
