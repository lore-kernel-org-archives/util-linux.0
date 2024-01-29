Received: from herc.mirbsd.org (bonn.mirbsd.org [217.91.129.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75AC4F88E
	for <util-linux@vger.kernel.org>; Mon, 29 Jan 2024 22:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.91.129.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706568601; cv=none; b=D3xMGBBB4dwXyZRVnmb+g0jPF/LDjDj57aQAbtB0Dobzku0sjQQPQK1/UqDJgzVxRGJBS6pgbeCk9tJkI0cghvNN9xXolGMJdm9/6sYWPMjnqlX5TI7q0jkzoBt92/pTY8Q5MgBUjlH2s+O1x9pIb8VzFHsP1o8Y0gtu4wmOZXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706568601; c=relaxed/simple;
	bh=Fn/T+7/WAel+ySYZuHaPj0jDiDw81yiSpGCatsyP/MY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=IXTwecSS3WROJwtpym/pthwHCrGLQXrS2VTzpHTV2bEmz2U8xX8U1kiiz/4wSu/KCyhC3Zuogz8p7490+8ywOb3vZfG+Co2Lnccey9nCGbqU8zw1nWSRla06dGy+cINWFv5OzKxANjsCzajJmYzEc0ZAFhzWbO3+ADbKvSDAlCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; arc=none smtp.client-ip=217.91.129.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Received: from herc.mirbsd.org (tg@herc.mirbsd.org [192.168.0.82])
	by herc.mirbsd.org (8.14.9/8.14.5) with ESMTP id 40TMjbHD017977
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 Jan 2024 22:45:44 GMT
Date: Mon, 29 Jan 2024 22:45:37 +0000 (UTC)
From: Thorsten Glaser <tg@debian.org>
X-X-Sender: tg@herc.mirbsd.org
To: Bill Unruh <unruh@physics.ubc.ca>
cc: util-linux@vger.kernel.org
Subject: Re: fdisk corrupts data on USB stick
In-Reply-To: <10251865-9fc4-2dff-1054-673e64c67fe2@physics.ubc.ca>
Message-ID: <Pine.BSM.4.64L.2401292243180.19873@herc.mirbsd.org>
References: <Pine.BSM.4.64L.2401291659410.19873@herc.mirbsd.org>
 <478ec62d-5485-42c3-b492-6ccfa9bf62c8@t-8ch.de> <Pine.BSM.4.64L.2401292023270.19873@herc.mirbsd.org>
 <5b8f9459-cc95-4c08-b68c-39abb2ff9f68@t-8ch.de> <20240129205623.sgvkhcyyepbsjzh3@ws.net.home>
 <Pine.BSM.4.64L.2401292118320.19873@herc.mirbsd.org>
 <70cac0f2-ec94-33f7-4a5d-c17f8eb82588@physics.ubc.ca>
 <Pine.BSM.4.64L.2401292219080.19873@herc.mirbsd.org>
 <10251865-9fc4-2dff-1054-673e64c67fe2@physics.ubc.ca>
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

> Great. I am just pointing out a program which seems to do exactly what yo=
u
> want.

It=E2=80=99s called fdisk. This does what I want. Only the one from
util-linux does more.

> Clearly had others know of your manifold-boot, they might well have used =
that
> instead of instead of reinventing isohybrid.

Huh? Grml used it.

Anyway, that=E2=80=99s independent, as the problem here does not come from
initial partitioning but from adding one more partition.

And I got an actually useful reply in the other subthread, so no
need to continue here.

bye,
//mirabilos
--=20
Solange man keine schmutzigen Tricks macht, und ich meine *wirklich*
schmutzige Tricks, wie bei einer doppelt verketteten Liste beide
Pointer XORen und in nur einem Word speichern, funktioniert Boehm ganz
hervorragend.=09=09-- Andreas Bogk =C3=BCber boehm-gc in d.a.s.r
