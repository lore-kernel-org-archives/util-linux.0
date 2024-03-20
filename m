Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA2E21100
	for <util-linux@vger.kernel.org>; Wed, 20 Mar 2024 20:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968218; cv=none; b=YQE/npdyThoMSfQKJtBV76rkoI2IF+0ShPSZ5dHriODm1jgR7HcK+Tym2qKInhr9JR22N3DX8F9X1el7wJnVUHzwJTJhd5KD8qHfD5LjTwbMoHftHbrJ2NIXUo+FGcXGpcCDTUY5jDc7FecceK7n2/3iQb35E1VKMYIxIf7RY58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968218; c=relaxed/simple;
	bh=gqp1oCpll7JLBWDJfilsfUZOJmMapTXFGTV153dobI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T3wseO3xn0SBLBhBHvSnYzuN+kTmqv3oNzzA6dIsvTsk9rsmvlkmsWQFfZ7LZJoIgJDumzNZLGRTpIYzcu0MTtwdP7EEfxDLjMYR+DhHqVqnl8xtVUNVROC1t9CBz7x2hM0LSRB7sVcMOMynwccAm2NGJnAoeg54f1A/87tNV58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=hOeBXU4Z; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="hOeBXU4Z"
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id B4C4D3C0140A4;
	Wed, 20 Mar 2024 13:56:50 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id Q3L8QIb1HzAM; Wed, 20 Mar 2024 13:56:50 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 5EB853C0140A0;
	Wed, 20 Mar 2024 13:56:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu 5EB853C0140A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1710968210;
	bh=y/tKou4brdzbJCh/VY4w1YNyxY6d8ViPIRvsRyoD+rs=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=hOeBXU4Z2HPuKiMrwQECelG08IiOSbN9yFy52yWvnS1XLlR13YAIF5erCqQZ4GvWS
	 K062SO1kP19xUjfQCybjuo70uUXYdaz6E+wwKqgheG/GYcbRUjF7dbCP6jHr8glzSR
	 Gf0fKa0duR8jzP7T0O5XHcu+nayrXhm0EbmaX/HiKufavTAM3JoMaKLCV7RYXdvXzM
	 kXRBKOvV6XudUQFAJ+VvItQZ3NJ4o4VOGUN8/XWM9kYzyyYE1FEdg3wwBSvGNFgwFD
	 ojr2O7sXDMzvz8Dg9VP2rX8NvjkSulMO+Hke3R9vPDTT0ZLGsbf6UHLOTEcByze4eg
	 WIbqdwdXrCfXw==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 9JECOFSqSffq; Wed, 20 Mar 2024 13:56:50 -0700 (PDT)
Received: from [131.179.64.200] (Penguin.CS.UCLA.EDU [131.179.64.200])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id 3C62B3C0140A4;
	Wed, 20 Mar 2024 13:56:50 -0700 (PDT)
Message-ID: <4356f3eb-544e-4ce9-b9ea-374cd01663d5@cs.ucla.edu>
Date: Wed, 20 Mar 2024 13:56:44 -0700
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug#69532: mv's new -x option should be made orthogonal to
 -t/-T/default
To: Bernhard Voelker <mail@bernhard-voelker.de>,
 =?UTF-8?Q?P=C3=A1draig_Brady?= <P@draigBrady.com>
Cc: Petr Malat <oss@malat.biz>, util-linux <util-linux@vger.kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, 69532@debbugs.gnu.org,
 Karel Zak <kzak@redhat.com>, Rob Landley <rob@landley.net>
References: <10c814a7-cb68-4fb4-ad8d-f88f286fb0b1@cs.ucla.edu>
 <58281f96-f9c6-4567-e3c9-c6a6cfa6ce27@draigBrady.com>
 <ZeZqzB4-OzHYfFeQ@codewreck.org>
 <5914e8b2-48ac-456b-9753-6a7bae7a9bbb@cs.ucla.edu>
 <636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
 <c5622a1c-b59e-4eb3-9d81-111acc1fbddc@cs.ucla.edu>
 <11c9a6a2-c73d-4b99-b071-48e7eab2fd19@bernhard-voelker.de>
Content-Language: en-US
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <11c9a6a2-c73d-4b99-b071-48e7eab2fd19@bernhard-voelker.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/20/24 12:43, Bernhard Voelker wrote:

> This stems from the fact that although mv(1) is a userland frontend
> for renameat(2), the user interface is different:
> while renameat(2) deals exactly with 2 operands, mv(1) has always
> been able to work on more arguments.

Yes, that's mv's original sin, which we cannot realistically change now.


> Now, extending "exchange" to more arguments is confusing and the
> use is not intuitive:
>  =C2=A0 mv -v --exchange=C2=A0 a b c d
>=20
> An "exchange" can literally only be applied to 2 files,

Sure, but that's true for "rename" too: a "rename" can be applied only=20
to 2 files.

When d is a directory, "mv a b c d" does three renames so it is like "mv=20
a d/a; mv b d/b; mv c d/c". This remains true if you uniformly replace=20
"mv" with "mv --exchange", which does three exchanges.


> I have the gut feeling that we didn't think through all cases,
> and that some might be surprising, e.g.:
>=20
>  =C2=A0 $ mkdir d; echo 1 > a; echo 2 > d/a
>  =C2=A0 $ src/mv --exchange a a a a d/a
>=20
> versus
>=20
>  =C2=A0 $ src/mv --exchange a a a a d/a

I don't understand the word "versus" here, as the two examples look the=20
same to me.

If d/a is not a directory, the example is an error, just as it would be=20
without --exchange.

If d/a is a directory and you have permissions etc., "mv a a a a d/a" is=20
like attempting "mv -T a d/a/a; mv -T a d/a/a; mv -T a d/a/a; mv -T a=20
d/a/a". If you use plain "mv" only the first "mv -T a d/a/a" succeeds=20
because "a" goes away, so you get three diagnostics for the remaining=20
three "a"s. If you use "mv --exchange" all four "mv --exchange -T a=20
d/a/a" attempts succeed, and since there are an even number of exchanges=20
the end result is a no-op except for updated directory timestamps. So I=20
don't see any ambiguity about what mv should do with this contrived examp=
le.

