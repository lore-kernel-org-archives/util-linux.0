Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B8B1E87E
	for <util-linux@vger.kernel.org>; Wed, 20 Mar 2024 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710975536; cv=none; b=oUOz55Ib+D+JtAjeZdyyCdgu3dEpg3lX5j0nOYfGtqIWIYpUcibTnXL4wX+FvxgYEt0+tgvm5A9KtooU4n3nw7DsmzJxSq1ooWQCLyZ36TlnPxGro2HDCKZ2PZRpM+SDcSjsfuDktHGodLkX48Snyxv3/ENshebTsaVXZc1Z2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710975536; c=relaxed/simple;
	bh=DcP2D2ym17rPURGx6hYP3SGWqxRpdOyffuX2l+ziXEc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p/1M/IDSdt3Ndz0QQ1ErSANi8OJBzVdYyWSG4kEOro13Eye1aGbmpUY534nfN0HjE4JbOnJBLL/pRyPsHEV9yKVP1RkJtCmG6IPjYBf14M9IVCTHc4f4C/2xIZislxbHFxQZKWljFJA8ktEBisD4nyrHcjLyLaJAOt9oNnN46QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bernhard-voelker.de; spf=pass smtp.mailfrom=bernhard-voelker.de; dkim=pass (2048-bit key) header.d=bernhard-voelker.de header.i=mail@bernhard-voelker.de header.b=dI6Dn/h5; arc=none smtp.client-ip=217.72.192.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bernhard-voelker.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bernhard-voelker.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bernhard-voelker.de header.i=mail@bernhard-voelker.de header.b="dI6Dn/h5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=bernhard-voelker.de; s=s1-ionos; t=1710975528; x=1711580328;
	i=mail@bernhard-voelker.de;
	bh=jsyJTLQUd61oOlFwsqStZDqw45pazUxe4EIgIKYBZe4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=dI6Dn/h54cNMgXfDFtZigVB01QAqFHYLB/8hmP4xK7vCrE5TvNOYkJF4u7rqqGEq
	 FRW5uqpNh3nt/nj54+04+5c7eC1IiWWYlOiMjBQP+ZdRga7mC9AEWu67izAwIJXFc
	 txOIDx0Y1zIjYBtjkDDY/nImZ6Tt03sksKj9IYwMwtHn/yLxgq1cKQizRWFlhMKcL
	 GDBZ0VT/mab42r95H63EgenBlnFLWi8850aJbri/oXN3iyGRb7YtQnvf0BIDRS+3V
	 o7UWPhXXKqvuzprHareoX0+H0y5pHPyLORccGfOwMt+V8Mq0h7E2VGs01sJEzjcx2
	 YukAIJkolMPp5V0OZQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.101.10] ([91.49.76.118]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MrPVJ-1r158u2ByJ-00oZ9M; Wed, 20 Mar 2024 23:53:07 +0100
Message-ID: <dcf073d9-a60b-429d-b9e2-40f6069e2641@bernhard-voelker.de>
Date: Wed, 20 Mar 2024 23:53:05 +0100
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
From: Bernhard Voelker <mail@bernhard-voelker.de>
In-Reply-To: <4356f3eb-544e-4ce9-b9ea-374cd01663d5@cs.ucla.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AUw4Pt2ulRQRdoCBo0gUeiPJ4PBLHNJaxRQMmpj2TPJOzGkvU/b
 eyJoC2BR3XCrkoiapi6+Q6OhbfWPbwgmFEUp0qiLCMP2zmkDPb9xEuD92yJcAhPGVGBsWrz
 KrS9PpmeBmLrm1MvboaAUBKK7JQOEVQhrFIiEG+LSBFrSu9xgTRy7ch/KgSyvwR7fEgwIsg
 eG7lHzhnEyUFsCvLaW1vg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rsAw3F6Rk5I=;2QgIvTLlcAy+xmyOYobbBRvd1LO
 1i6vtppCjTz7TH25FO54amYyGd9ss5KCd5ktyvtZaHskhEjmcZ5eLcce+9s2/WgWnS53MO/Yi
 JRXmZtE4oLK1+xJc8wV5LqD3HSl5oNXwgFdrp/cFYY5lyK0YTUbDNyDmcYOjT3ZcgrjYSGv9f
 KGlj4Y2zyn/wdooCd4vPBZlJIZKseoXHrZevdw20yEheLwJvEwTjeTzwFkl4eOebC9eHcMJTo
 PpbjufXLtfT0q03NVpsYys8msmJiUmv6CANQMXNXKN50/tztASf1t/nLg3EWshZpdLJ4mhpfq
 l27uClgCTDteRceU3TA2PlnH1Z12A5Pn/gtDJRy622JNvH4KwrcQS0LuR/zqiF4hodS0m8BDW
 inJwvztdMt+LoHQpIAlRO8Cy0e4ktc6spZyx+jbiJRV8eEFhHnVPnW+VrMvgo44IDzBwUDHTN
 sh1ajr8ufw8ussRG9y2s/riO+QC+cRJzv/ch888tODpZZVOzfWaxkvAgbRS4I2GqGp3hNcCcj
 aP4Wp4gwzM8UwX+VwnNpYv1NprLwIFw6SJJ6LCMV8mHBSXUWeYcSKLF/MhrDC2hAtxHykcJ+j
 NnR0bR74eBozj1nbC1L2NXfr5zEiLOcZEgq2HgNPADDjb7eQXX2nwG1xx/cEN4g0MNMn4DKe0
 KFMN9571t0IoWycw0eospIXadQ0nGxtOCnZYgjcOwneKysSPzLuVRtU6KxN2BKd7klXzzcDFv
 6wfSlzbIIbzg/9WGpm/C9EoI3jXnBdhotmf/oU6LapZ9f/jpKLcTCQ=

On 3/20/24 21:56, Paul Eggert wrote:
> On 3/20/24 12:43, Bernhard Voelker wrote:
>
>> This stems from the fact that although mv(1) is a userland frontend
>> for renameat(2), the user interface is different:
>> while renameat(2) deals exactly with 2 operands, mv(1) has always
>> been able to work on more arguments.
>
> Yes, that's mv's original sin, which we cannot realistically change now.

I wouldn't go that far that it was a sin.  It's useful and people got
used to it without having to think about it.

>> I have the gut feeling that we didn't think through all cases,
>> and that some might be surprising, e.g.:
>>
>>   =C2=A0 $ mkdir d; echo 1 > a; echo 2 > d/a
>>   =C2=A0 $ src/mv --exchange a a a a d/a
>>
>> versus
>>
>>   =C2=A0 $ src/mv --exchange a a a a d/a
>
> I don't understand the word "versus" here, as the two examples look the
> same to me.

sorry, I messed the example up.

   $ echo 1 > a
   $ mkdir d
   $ echo 2 > d/a
   $ src/mv -v --exchange a a a d
   renamed 'a' -> 'd/a'
   renamed 'a' -> 'd/a'
   renamed 'a' -> 'd/a'
   $ cat a
   2
   $ src/mv -v --exchange a a a d
   renamed 'a' -> 'd/a'
   renamed 'a' -> 'd/a'
   renamed 'a' -> 'd/a'
   $ cat a
   1
   $ src/mv -v --exchange a a a a d
   renamed 'a' -> 'd/a'
   renamed 'a' -> 'd/a'
   renamed 'a' -> 'd/a'
   renamed 'a' -> 'd/a'
   $ cat a
   1

I remember some implementation where mv(1) really was just a rename(2),
which failed when crossing file systems.  Was it some HP-UX or Solaris mv(=
1)?
mv(1) has learned to copy+delete over time, which is what people would
expect from a "move".

My point is that "exchange" is a different functionality.
It's well somehow belonging and related to what renameat(2) is doing in th=
e kernel,
and therefore it comes in handy that we can simply call it with an additio=
nal flag.
Yet it's IMO a different operation.  I bet there had been discussions whet=
her
to create a new syscall, but apparently it was easier to put it with a fla=
g
into an existing one.  Fine for the kernel.

On userland OTOH, we have broader choice.
Karel did his choice in util-linux for exch(1), and coreutils could expose
the same functionality.

For other feature requests, we were much more reluctant in coreutils ... f=
or
good reasons: feature bloat, maintainability, etc.

So I'm asking myself what is different this time?
- The feature already exists -> util-linux.
- Okay, we're using the same syscall, renameat(2) -> it's tempting.
- How large is the useful overlap with the existing code of mv(1)?
   Not much: no traditional rename nor copy.
- How large is the useful overlap with the existing options/modes of mv(1)=
?
   - exchange contradicts --backup,
   - exchange is not useful together with options working with a regular
     rename of copy, at least: --update, -Z, -n.
   - not sure if exchange works well together with -f.

I'm currently only 20:80 for adding it to mv(1).
The functionality is cool, but do we need to press it into mv(1) with so m=
any
incompatibilities just because it's requiring renameat(2) we already use?
Maybe to consider: One tool for one thing ... means another tool for anoth=
er thing.

Again, I have the gut feeling that we've missed some cases to think about.
And once the feature would be in ...

Furthermore, why does exchange not work to exchange a regular with a direc=
tory file?
We've all learned that everything's a file, so it cannot be explained to u=
sers that
exchanging a regular file with a directory doesn't work.

Finally, the test cases are very sparse: no cases with different owners, d=
ifferent
directory permissions, different file types (if we know already f<->d does=
n't work),
triggering races, etc.

I don't really want to object to add it, but I find it quite odd as of tod=
ay.

Have a nice day,
Berny
