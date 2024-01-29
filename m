Received: from info.physics.ubc.ca (info.physics.ubc.ca [142.103.234.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F1F15697F
	for <util-linux@vger.kernel.org>; Mon, 29 Jan 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=142.103.234.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706561546; cv=none; b=FFe3XUg29YlpCLQQojZ7y1/DzlGscbvc+YkQF5+NRjOE0rrblAbd1N4wFYAxgmUVFjkq08nmt4HH/2zo5/QA4A95ee5W/wboTEiQuLjRN114chrlFjDxKO2rRxVO/Jth/Ptdys7FDamuANMhOY1pb2m78V1Sfm+9dg+aQNIcOiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706561546; c=relaxed/simple;
	bh=4pVW6qeGbeLembbHf3EV863u0zJH3shaW/gzTKkhEWU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tixk3hahxikzjHgojpvX1MAMeT4z3xTPB3kj+s2UTiyKBntLYlTgRSGmsTMkuU2e70z/EETElnISK1q4ybh4reRtRlRYoh+UBew5m80jJiclOI6Uo+CzpxNWnVoHYpyDAxJx2TCleYmkRwKQHu4WoXuUW0f20Dg9982C4CvbcUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physics.ubc.ca; spf=pass smtp.mailfrom=physics.ubc.ca; arc=none smtp.client-ip=142.103.234.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physics.ubc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=physics.ubc.ca
Received: by info.physics.ubc.ca (Postfix, from userid 1000)
	id E8E1E121126; Mon, 29 Jan 2024 12:44:22 -0800 (PST)
Date: Mon, 29 Jan 2024 12:44:22 -0800 (PST)
From: Bill Unruh <unruh@physics.ubc.ca>
To: Thorsten Glaser <tg@debian.org>
cc: =?ISO-8859-15?Q?Thomas_Wei=DFschuh?= <thomas@t-8ch.de>, 
    util-linux@vger.kernel.org
Subject: Re: fdisk corrupts data on USB stick
In-Reply-To: <Pine.BSM.4.64L.2401292023270.19873@herc.mirbsd.org>
Message-ID: <4c3c12d9-7b15-c6e3-913-ad6a96671858@physics.ubc.ca>
References: <Pine.BSM.4.64L.2401291659410.19873@herc.mirbsd.org> <478ec62d-5485-42c3-b492-6ccfa9bf62c8@t-8ch.de> <Pine.BSM.4.64L.2401292023270.19873@herc.mirbsd.org>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1737365482-173047697-1706561062=:1871672"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1737365482-173047697-1706561062=:1871672
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

Perhaps if you told us what you really wanted to do, instead of asking why
your first method did not work and how to fix it. Eg, you wnat to add anoth=
er
partition to the usb disk since the boot system only used 5GB of a 128GB us=
b,
and you don't want to waste 123GB of space. Or some other problem you want =
to
solve. That way you might get ways of solving your real problem you never
thought of.




William G. Unruh __| Canadian Institute for|____ Tel: +1(604)822-3273
Physics&Astronomy _|___ Advanced Research _|____ Fax: +1(604)822-5324
UBC, Vancouver,BC _|_ Program in Cosmology |____ unruh@physics.ubc.ca
Canada V6T 1Z1 ____|____ and Gravity ______|_    theory.physics.ubc.ca/

On Mon, 29 Jan 2024, Thorsten Glaser wrote:

> [CAUTION: Non-UBC Email]
>
> Thomas Wei=C3=9Fschuh dixit:
>
>>    The device contains 'iso9660' signature and it will be removed by a
>>    write command. See fdisk(8) man page and --wipe option for more
>>    details.
>
>> I guess your version does the same, but maybe is not printing the
>> warning.
>
> Hm, maybe it does, maybe it doesn=E2=80=99t, but even so, why should it?
>
>> So the disk gets converted to a normal MBR layout and the ISO signature
>> get wiped. Which makes sense as the ISO image would need to be
>> remastered.
>
> Totally not! First of, the ISO already contained an MBR with a
> partition table in the first sector, which I extended, and second,
> it=E2=80=99s fdisk=E2=80=99s task to precisely edit the MBR partition tab=
le (and,
> if the 55h AAh magic is missing, create it), nothing else (okay,
> extended partitions if someone uses them, but nothing else).
>
>>> Is there a way we can make it not corrupt such media?
>>
>> Did you look into grml2usb?
>
> I know that, but I wanted to keep the original ISO 9660 filesystem
> so things don=E2=80=99t accidentally get changed on it. (And the original
> EFI thingy, in case it=E2=80=99s needed.)
>
> So, how do I get fdisk to not corrupt the ISO 9660 part?
> MirBSD fdisk doesn=E2=80=99t do that, it sticks to the MBR.
>
> Thanks,
> //mirabilos
> --=20
> =E2=80=9ECool, /usr/share/doc/mksh/examples/uhr.gz ist ja ein Grund,
> mksh auf jedem System zu installieren.=E2=80=9C
> =09-- XTaran auf der OpenRheinRuhr, ganz begeistert
> (EN: =E2=80=9C[=E2=80=A6]uhr.gz is a reason to install mksh on every syst=
em.=E2=80=9D)
>
>
--1737365482-173047697-1706561062=:1871672--
