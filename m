Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27264135418
	for <util-linux@vger.kernel.org>; Thu, 21 Mar 2024 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711057558; cv=none; b=SHfzhFWxSzJG0dV97EzK3UqlkAFy/MA1fwdbZ3DQ+BbdoPGZ5Q2blbqAUSrAn969PgXQR5Y3iG3hAv4e7IGxmuFJyi3r1P0DydJNvt/IaO8BmRtWANYBwXhxjp1SqpopQpMoSzzfGLO0UMoqMaeRcS9DZ41IfYsEUsQx0jF+Upc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711057558; c=relaxed/simple;
	bh=uWo1b4kW/LA1IG2krpRkmW8jCBdrHFuSe9nGSxFrfSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IQ8tIDV3jeGjELDUxyFmy5in/kAydWbd1K5FRCRlKAfRWF/VQls+3Gwtxu5BS18YoLua7TQt2BGvHlcYyKcnhIyVuATH0IKthOYkSjYnH8N+/paerd8vXBPvFXevTdzrJ81JrzSGEEWuqyBVmH5KoVGVlkvlonrqqUWpD6dgKzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bernhard-voelker.de; spf=pass smtp.mailfrom=bernhard-voelker.de; dkim=pass (2048-bit key) header.d=bernhard-voelker.de header.i=mail@bernhard-voelker.de header.b=ktaZYLbw; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bernhard-voelker.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bernhard-voelker.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bernhard-voelker.de header.i=mail@bernhard-voelker.de header.b="ktaZYLbw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bernhard-voelker.de; s=s1-ionos; t=1711057526; x=1711662326;
	i=mail@bernhard-voelker.de;
	bh=ATx4+0ICmBNQwgurRPS4yT+RJF+a071y5R+BTVUa4/c=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ktaZYLbw4QxyxU2tie4Tnhg26wuH7/CE30y8ZozfoSB350M6YsD8Qn7JhLzEQhSD
	 I82rDhL2/l2bDCygZNX6OXOiMKbJPxl+30tRwPjaqYG8/c/fzlviQGiQ12TaRgCap
	 gM7w9axhP/dhRO11klQcsaw7NbLrenSvJnfRp2sCMOKdv4A+a41AI7lghp+nVJ5dp
	 m0v1cmtNShH64m5X7mGfllg9m5vpnAqLh4eZpQ7o0U2fEq3+q8o8Pr9iMz3LF1P3g
	 XOWIviH7Bt+UhnoU/DB7vO0RlTZwMlZ8OBRPxs2V2o10ASHWHNFl3lLacpWFTkFbg
	 hmNlKL0k6mKfUquJhg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.101.10] ([91.49.76.118]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1M7JrG-1rfjeU0Ypw-007oE3; Thu, 21 Mar 2024 22:45:26 +0100
Message-ID: <d6530404-4fc7-40d0-be99-cb37426be32d@bernhard-voelker.de>
Date: Thu, 21 Mar 2024 22:45:24 +0100
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: bug#69532: mv's new -x option should be made orthogonal to
 -t/-T/default
Content-Language: en-US
To: Paul Eggert <eggert@cs.ucla.edu>, =?UTF-8?Q?P=C3=A1draig_Brady?=
 <P@draigBrady.com>
Cc: 69532@debbugs.gnu.org, util-linux <util-linux@vger.kernel.org>,
 Dominique Martinet <asmadeus@codewreck.org>, Petr Malat <oss@malat.biz>,
 Karel Zak <kzak@redhat.com>, Rob Landley <rob@landley.net>
References: <10c814a7-cb68-4fb4-ad8d-f88f286fb0b1@cs.ucla.edu>
 <58281f96-f9c6-4567-e3c9-c6a6cfa6ce27@draigBrady.com>
 <ZeZqzB4-OzHYfFeQ@codewreck.org>
 <5914e8b2-48ac-456b-9753-6a7bae7a9bbb@cs.ucla.edu>
 <636f1247-0de0-2f32-cb04-f6952b6807aa@draigBrady.com>
 <c5622a1c-b59e-4eb3-9d81-111acc1fbddc@cs.ucla.edu>
 <11c9a6a2-c73d-4b99-b071-48e7eab2fd19@bernhard-voelker.de>
 <4356f3eb-544e-4ce9-b9ea-374cd01663d5@cs.ucla.edu>
 <dcf073d9-a60b-429d-b9e2-40f6069e2641@bernhard-voelker.de>
 <e1269c19-c2b9-45ac-b683-47a473326662@cs.ucla.edu>
From: Bernhard Voelker <mail@bernhard-voelker.de>
In-Reply-To: <e1269c19-c2b9-45ac-b683-47a473326662@cs.ucla.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OD3B9/ctLfwk8eitD6WCbD0eW3ZvcFj4GeiqkuMY7gqQfZLYh5r
 fAUsNA4xXmE2SIR/H0TiiQ2Cp8MU9EZHBKrY592iCKfrx7XqmVMc7C7zrBtqukCbthGiedf
 oWfAMMTUwBypkxsX1luiBC5VjYrJNxe7ja93yDb4vDP4itA4/g9qs1XliiJ8sFn6JwjY1Wi
 CEutdZVzlLHLUd5E98Rww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Tpspq5xNKl0=;+stEOdDku/VufBtlYDtEIJUgjIA
 Kp+JXnSe6bO7tWugfabAWT6PZIo2jdeCgWbZwH/Qec+AjY+uXOVfhepw1x7zakL/Sgw9JAOOa
 enq6b5q9LKpsvNqBwBDfXYB1SP+FYa874TUXm8N9ieIJULESZfa0sXCDSGLVSpS9+ZuMlvMwq
 Mh4+A1ohcm1Eh2t3OGSyvAqX5CVnBtD43q+Rt3bVL+Nza98rGUf+SbiNurbf/MM+Vhk9vThSs
 ScPhDMDqljOKGuXxnCjs8J7nnGr1TsbIf/FoZTiCenBWfxK2kGqAc0yQSYTugt7NrgPYUBIxH
 sXrbw179XOVsSgqRtU6BqHPZsVN5bra0Z2mCERUsBhqses2LrGbImj/+Wcqm5we47ruMCqtlH
 neFDNlDeki8t0UufbDjQ7UoSvWkvOSDPWo8/+xyn29R1p1evLicE0lIQS7CYIlO3/LRtLUWCG
 eoaS9gi/OGsN4UUBif4jIM86Lmhd6h5TJoA+J4SC+s2qcLFGb5yUaLqskWR6tqwe+kcUJCKoQ
 WmuHwMw2bEA9iKROF1SBhBF7BesO+CQUiiy8UtY724nsJxXmwfaGbNQkV5Kd2u9wTrJlP2P46
 CNZnptQdW/K5BOFa8qsXOXIZM3fH/7Ma1TQSqdiSMBoaFGS9sCJBUDzhnOHdQHVFVzGHGmgoZ
 5fL0b2EIzZvlGGiQKloeSu8bE9lJST1eMWjQeUpguC9og5+NROUnDRp6VTLxxfWAE2k0i1ni3
 gcI36SrjWPx8C4L2gfjdZBNpoIm8xgqbxelNq0/oWMWJuAkshplfzg=

On 3/21/24 00:56, Paul Eggert wrote:
> On 3/20/24 15:53, Bernhard Voelker wrote:
> Yes, that's the expected behavior for this contrived case. Just as one
> would get odd behavior if one did the same thing without --exchange.

There's another which is not consistent with/without --exchange:

   $ src/mv -v a a
   src/mv: 'a' and 'a' are the same file

   $ src/mv -v --exchange a a
   renamed 'a' -> 'a'

RENAME_EXCHANGE is allowed (but useless?) for 1 file.

BTW: shouldn't the -v diagnostic better say "exchanged 'a' <-> 'a'"
because that's what happened?

>>   =C2=A0 - not sure if exchange works well together with -f.
>
> What problems do you see there?

it's up to the tests to proof that.

>> why does exchange not work to exchange a regular with a
>> directory file?
>
> It works. I don't see a problem there.
>
>     $ touch a
>     $ mkdir d
>     $ ./mv -T --exchange a d
>     $ ls -ld a d
>     drwxr-xr-x. 2 eggert eggert 4096 Mar 20 16:52 a
>     -rw-r--r--. 1 eggert eggert    0 Mar 20 16:52 d

indeed, it works.  It seems my test was wrong, sorry.

>> Finally, the test cases are very sparse:
>
> Feel free to add some. :-)

Unfortunately, I cannot currently spend as much time as I'd love to.

It seems that -i is skipped:

   $ src/mv -iv --exchange a b
   renamed 'a' -> 'b'

As far as I know Padraig would like to do the next release very soon,
so I would recommend to not hurrying this one into it, and instead
ironing all out after the release.

Have a nice day,
Berny
