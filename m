Received: from mx10.gouders.net (mx10.gouders.net [202.61.206.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2043770B
	for <util-linux@vger.kernel.org>; Sun, 12 Jul 2026 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.206.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783847858; cv=none; b=OoAz4Dy5VOt+rgs0SLW558OaxMIWa79UJCAWX9QRqq2oGPPEdRwJkM74VIBnTYiV8cwkgSPqpX7d3LNM38+5l5aXBa+29PeynxYN77L9TPZi/Wiww278mi0FQqZTf/rnU3zAitVVPvbB9Jkm/wA+51f258D+mxBRkfo+UejhGws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783847858; c=relaxed/simple;
	bh=gCm4tep+pOrWA3BLDSXfR9ocnNTITJGoYOtYKaywgkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pg/NOJQwEVOemKr4VBwFEiPfrm12kcIdYMRA/BxOgX/VZ1wC8KVDeDINyq/7YGbH1qjUXWsotwwtwIkFimV0JuZoHQq+m2rhEjyYBTSAYf8zhesaeMlOIjgeUFuUC3rqa1GbVPoAIoF5pLtjDCXpcu0F0BUFVACnn0G7uIUmEvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net; spf=pass smtp.mailfrom=gouders.net; dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b=mbVO8HkO; arc=none smtp.client-ip=202.61.206.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gouders.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gouders.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gouders.net header.i=@gouders.net header.b="mbVO8HkO"
Received: from localhost (ip-109-41-50-22.web.vodafone.de [109.41.50.22])
	(authenticated bits=0)
	by mx10.gouders.net (8.18.2/8.17.1.9) with ESMTPSA id 66C92DwD2420697
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sun, 12 Jul 2026 11:02:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gouders.net; s=gnet;
	t=1783846934; bh=gCm4tep+pOrWA3BLDSXfR9ocnNTITJGoYOtYKaywgkI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mbVO8HkOgGSzg1OylwpFx4rvzYfv/619FO1bZFqIIjJQwOioIxHGHc/zz2xPVRYt1
	 ikiESCfZ2QvUHkfwUk7F5LHb+iAKwe4iAfd4GhdYpqTEZm4WZhnwG8eAiEK6COnVXP
	 XHvmYMee65gTjb36ElhU/js29vbvC/qDC6RCZtIw=
From: Dirk Gouders <dirk@gouders.net>
To: Chris Hofstaedtler <zeha@debian.org>
Cc: util-linux@vger.kernel.org, Marc Lehmann <debian-reportbug@plan9.de>,
        1141670@bugs.debian.org,
        =?utf-8?B?0L3QsNCx?=
 <nabijaczleweli@nabijaczleweli.xyz>
Subject: Re: Bug#1141670: util-linux: very slow code and undefined behaviour
 in handle_interrupt
In-Reply-To: <alLEV6xOOwA1RzU_@zeha.at> (Chris Hofstaedtler's message of "Sat,
	11 Jul 2026 19:34:41 -0300")
References: <178350371646.36377.6056214111743171473.reportbug@cerebro.laendle>
	<alLEV6xOOwA1RzU_@zeha.at>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Sun, 12 Jul 2026 11:02:12 +0200
Message-ID: <ghbjccr36z.fsf@gouders.net>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Sat, Jul 11 2026, Chris Hofstaedtler wrote:

> the following was reported to Debian, regarding the hardlink
> utility. It appears to be an upstream issue. Maybe someone can look at
> it. CC:ing =D0=BD=D0=B0=D0=B1 who seems to have touched the relevant func=
tion last.

it seems, this regression was fixed with:

87831fa19 (hardlink: fix performance regression (inefficient signal evaluat=
ion), 2025-04-29)

The commit message says it improved performance by factor ten.

Regards,

Dirk

> * Marc Lehmann <debian-reportbug@plan9.de> [260708 07:23]:
>>Version: 2.41-5
>>
>>Dear Maintainer,
>>
>>while strace'ing to find out why hardlink is so slow, IO found it does th=
is sequence between every fstatat call:
>>
>>   gettid()                                =3D 36482
>>   getpid()                                =3D 36482
>>   tgkill(36482, 36482, 0)                 =3D 0
>>
>>this seems to be a pretty weird thing to do in a tighht scanning
>>loop. Looking at the code, handle_interrupt is responsible:
>>
>>   /**
>>    * handle_interrupt - Handle a signal
>>    */
>>   static void handle_interrupt(void)
>>   {
>>           switch (last_signal) {
>>           case SIGUSR1:
>>                   print_stats();
>>                   putchar('\n');
>>                   break;
>>           default:
>>                   signal(last_signal, SIG_DFL);
>>                   raise(last_signal);
>>                   break;
>>           }
>>           last_signal =3D 0;
>>   }
>>
>>this is already a weird function to begin with, but crucially, it calls s=
ignal(0,... and raise(0).
>>
>>it seems to me the former is likely undefined behaviour and the latter is
>>just unnecessartily slow.
>>
>>most likely, handle_interrupt simply should not be called after every fst=
atat, or at all, without last_signal bering set beforehand.
>>
