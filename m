Received: from mail.cs.ucla.edu (mail.cs.ucla.edu [131.179.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0C186146
	for <util-linux@vger.kernel.org>; Wed, 20 Mar 2024 23:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=131.179.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710978996; cv=none; b=XIehaKK9VTHRlltXGhwYVbIvR8Jn2JNGkOxz+8k81G2uXt8HmxNtJzpT6lu6wpQoMcCo6Nsnm9GaCD8kpverS9joI9yRj9tlS6+gUMCBQQidZBy8IvJ1kbQW8yPFnqyDhGFXFmARCathngTUYLZ8eFbRHqgJxuLvLBTvwZ2g/sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710978996; c=relaxed/simple;
	bh=7Ejnsqt5cbD7nALWFGibyGvjSB+9YXKlZdDJ0FN8dP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQanePX4yyIaqqOkTGk6x1tvDfm9PCeslbQs9DakTHrH2wkFttAU59ec0ylPBYtaHnjrhextwX5ZZbK6Wf7TZI/3OAui04NjodlrBkRfAMRsmyccf/Yolrw7sV4SPZ5DcZ3pZqahNEB1bk0fSj7oOGM2iTsAXgVoLqKh6wKdj44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu; spf=pass smtp.mailfrom=cs.ucla.edu; dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b=Po+694Xu; arc=none smtp.client-ip=131.179.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs.ucla.edu header.i=@cs.ucla.edu header.b="Po+694Xu"
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id 372AF3C0140A0;
	Wed, 20 Mar 2024 16:56:34 -0700 (PDT)
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10032) with ESMTP
 id aabSwXU3zZT9; Wed, 20 Mar 2024 16:56:33 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.cs.ucla.edu (Postfix) with ESMTP id C87573C0140A4;
	Wed, 20 Mar 2024 16:56:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.cs.ucla.edu C87573C0140A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs.ucla.edu;
	s=9D0B346E-2AEB-11ED-9476-E14B719DCE6C; t=1710978993;
	bh=D5qLNRZIIU2ePWcIgK6Jz5FhdW88fwgXCaBV5/aPmLI=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=Po+694Xu1lP1w83lYBqJXPBv5O0emUu/O9C0xkrpJqnszXABY3vlONTHImmCHX2x6
	 wFINGIRnBQs5qhsxcz39BVm2I0JOSGGoiKnLzbAUj2ltuTrBwxj7PT5AybhdWJvii1
	 dkQ0cemnONYfLoXriQ4YJxZ4n23KQbRI1dJZ5yqA7RF1rqpQqD1JU8Z69ArhX5S8xs
	 BLFpLKuFg7spoSVD/idVqoRGzAdRjty6xUlDs+9FHZJQ5K58i/caJlQMSb4n1uVFgR
	 igRFbDBhgUD9bzNsIqO6O1DAdfq+BKF+NIRS7n78xrZ62kH7WhZ22poXzEBP93GuCJ
	 hjFGYaPPokRxA==
X-Virus-Scanned: amavis at mail.cs.ucla.edu
Received: from mail.cs.ucla.edu ([127.0.0.1])
 by localhost (mail.cs.ucla.edu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id unVHSK5E99S9; Wed, 20 Mar 2024 16:56:33 -0700 (PDT)
Received: from [131.179.64.200] (Penguin.CS.UCLA.EDU [131.179.64.200])
	by mail.cs.ucla.edu (Postfix) with ESMTPSA id 9B8163C0140A0;
	Wed, 20 Mar 2024 16:56:33 -0700 (PDT)
Message-ID: <e1269c19-c2b9-45ac-b683-47a473326662@cs.ucla.edu>
Date: Wed, 20 Mar 2024 16:56:32 -0700
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
 <4356f3eb-544e-4ce9-b9ea-374cd01663d5@cs.ucla.edu>
 <dcf073d9-a60b-429d-b9e2-40f6069e2641@bernhard-voelker.de>
From: Paul Eggert <eggert@cs.ucla.edu>
Organization: UCLA Computer Science Department
In-Reply-To: <dcf073d9-a60b-429d-b9e2-40f6069e2641@bernhard-voelker.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On 3/20/24 15:53, Bernhard Voelker wrote:

>  =C2=A0 $ echo 1 > a
>  =C2=A0 $ mkdir d
>  =C2=A0 $ echo 2 > d/a
>  =C2=A0 $ src/mv -v --exchange a a a d
>  =C2=A0 renamed 'a' -> 'd/a'
>  =C2=A0 renamed 'a' -> 'd/a'
>  =C2=A0 renamed 'a' -> 'd/a'
>  =C2=A0 $ cat a
>  =C2=A0 2
>  =C2=A0 $ src/mv -v --exchange a a a d
>  =C2=A0 renamed 'a' -> 'd/a'
>  =C2=A0 renamed 'a' -> 'd/a'
>  =C2=A0 renamed 'a' -> 'd/a'
>  =C2=A0 $ cat a
>  =C2=A0 1
>  =C2=A0 $ src/mv -v --exchange a a a a d
>  =C2=A0 renamed 'a' -> 'd/a'
>  =C2=A0 renamed 'a' -> 'd/a'
>  =C2=A0 renamed 'a' -> 'd/a'
>  =C2=A0 renamed 'a' -> 'd/a'
>  =C2=A0 $ cat a
>  =C2=A0 1

Yes, that's the expected behavior for this contrived case. Just as one=20
would get odd behavior if one did the same thing without --exchange.


> I remember some implementation where mv(1) really was just a rename(2),
> which failed when crossing file systems.  Was it some HP-UX or Solaris =
mv(1)?

I doubt it. Even 7th Edition 'mv' (1979) fell back on 'cp' when the link=20
syscall failed (this was before 'rename' existed).


> My point is that "exchange" is a different functionality.

Yes, but it's closely related. Arguably --backup is also a different=20
functionality too (and arguably --exchange is simply an alternative=20
backup scheme!) but 'mv' has --backup.


> - How large is the useful overlap with the existing code of mv(1)?
>  =C2=A0 Not much: no traditional rename nor copy.

I don't follow this point. The code change was fairly small, which=20
indicates there was a lot of overlap with existing functionality.


> - How large is the useful overlap with the existing options/modes of mv=
(1)?
>  =C2=A0 - exchange contradicts --backup,

That could be fixed for regular files, if there's a need, by backing up=20
the destination via 'link' before exchanging. For directories it's=20
admittedly a problem, but that's also the case for plain 'mv' (or for=20
'cp' or 'ln', for that matter) so there's not much new here.


>  =C2=A0 - exchange is not useful together with options working with a r=
egular
>  =C2=A0=C2=A0=C2=A0 rename of copy, at least: --update, -Z, -n.

It should work with --update and -Z. -n of course is logically=20
incompatible, but this not the only set of logically incompatible=20
options (e.g., -t vs -T).


>  =C2=A0 - not sure if exchange works well together with -f.

What problems do you see there?



> why does exchange not work to exchange a regular with a=20
> directory file?

It works. I don't see a problem there.

   $ touch a
   $ mkdir d
   $ ./mv -T --exchange a d
   $ ls -ld a d
   drwxr-xr-x. 2 eggert eggert 4096 Mar 20 16:52 a
   -rw-r--r--. 1 eggert eggert    0 Mar 20 16:52 d


> Finally, the test cases are very sparse:

Feel free to add some. :-)
