Received: from herc.mirbsd.org (bonn.mirbsd.org [217.91.129.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84741429F
	for <util-linux@vger.kernel.org>; Mon, 29 Jan 2024 20:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.91.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560097; cv=none; b=UMkSimP2ZGrjunVM2m0rTqy2vZJGIgjtwZ4vt4Cgx4n2jk0aTnPq6SHi+kT03aR+TG1SBE3JQA9l9gB91UwZwhFbE5XZ88qJd4ZkdyZS5PUhEltL+2Uz69Gvfw5P29GkEkyjA54jpwjG/x564FAZvXZfYuNB71LHGe70XbkLKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560097; c=relaxed/simple;
	bh=IJK1Zm02vf6xbg8jcq0TgPXjR51uAQTVl9+zqySCwg0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=k5aI/vAXSo/8xFfzFzl23dKeKRYSNqXiTOBHRfcisFedjo/DXHWYk+YzBW9fsMrHSrtYHdJKbiZmwzWOx0O6CGGeIRrAFxxpY58mWTFnknNWx2+LFxfrlJAlAkYANO2Eus5lkkRrNVBPzV01wyz2IyRRkxKw5OrKEj73xXYQPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.91.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 40TKRDdu025474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jan 2024 20:27:19 GMT
Date: Mon, 29 Jan 2024 20:27:13 +0000 (UTC)
From: Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
cc: util-linux@vger.kernel.org
Subject: Re: fdisk corrupts data on USB stick
In-Reply-To: <478ec62d-5485-42c3-b492-6ccfa9bf62c8@t-8ch.de>
Message-ID: <Pine.BSM.4.64L.2401292023270.19873@herc.mirbsd.org>
References: <Pine.BSM.4.64L.2401291659410.19873@herc.mirbsd.org>
 <478ec62d-5485-42c3-b492-6ccfa9bf62c8@t-8ch.de>
Content-Language: de-Zsym-DE-1901-u-em-text-rg-denw-tz-utc, en-Zsym-GB-u-cu-eur-em-text-fw-mon-hc-h23-ms-metric-mu-celsius-rg-denw-tz-utc-va-posix
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Thomas Wei=C3=9Fschuh dixit:

>    The device contains 'iso9660' signature and it will be removed by a
>    write command. See fdisk(8) man page and --wipe option for more
>    details.

>I guess your version does the same, but maybe is not printing the
>warning.

Hm, maybe it does, maybe it doesn=E2=80=99t, but even so, why should it?

>So the disk gets converted to a normal MBR layout and the ISO signature
>get wiped. Which makes sense as the ISO image would need to be
>remastered.

Totally not! First of, the ISO already contained an MBR with a
partition table in the first sector, which I extended, and second,
it=E2=80=99s fdisk=E2=80=99s task to precisely edit the MBR partition table=
 (and,
if the 55h AAh magic is missing, create it), nothing else (okay,
extended partitions if someone uses them, but nothing else).

>> Is there a way we can make it not corrupt such media?
>
>Did you look into grml2usb?

I know that, but I wanted to keep the original ISO 9660 filesystem
so things don=E2=80=99t accidentally get changed on it. (And the original
EFI thingy, in case it=E2=80=99s needed.)

So, how do I get fdisk to not corrupt the ISO 9660 part?
MirBSD fdisk doesn=E2=80=99t do that, it sticks to the MBR.

Thanks,
//mirabilos
--=20
=E2=80=9ECool, /usr/share/doc/mksh/examples/uhr.gz ist ja ein Grund,
mksh auf jedem System zu installieren.=E2=80=9C
=09-- XTaran auf der OpenRheinRuhr, ganz begeistert
(EN: =E2=80=9C[=E2=80=A6]uhr.gz is a reason to install mksh on every system=
=2E=E2=80=9D)
