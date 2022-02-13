Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8654AC433F5
	for <util-linux@archiver.kernel.org>; Sun, 13 Feb 2022 19:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbiBMTkg (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 13 Feb 2022 14:40:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBMTkf (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 13 Feb 2022 14:40:35 -0500
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Feb 2022 11:40:27 PST
Received: from info.physics.ubc.ca (info.physics.ubc.ca [142.103.234.23])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 94B4456C2B
        for <util-linux@vger.kernel.org>; Sun, 13 Feb 2022 11:40:27 -0800 (PST)
Received: by info.physics.ubc.ca (Postfix, from userid 1000)
        id D003112004B; Sun, 13 Feb 2022 11:35:23 -0800 (PST)
Date:   Sun, 13 Feb 2022 11:35:23 -0800 (PST)
From:   Bill Unruh <unruh@physics.ubc.ca>
To:     Helge Kreutzmann <debian@helgefjell.de>
cc:     =?ISO-8859-15?Q?Mario_Bl=E4ttermann?= 
        <mario.blaettermann@gmail.com>, util-linux@vger.kernel.org
Subject: Re: Errors in man pages of util-linux
In-Reply-To: <20220213185104.GA23259@Debian-50-lenny-64-minimal>
Message-ID: <alpine.LMD.2.11.2202131133420.30526@physics.ubc.ca>
References: <20220210192341.GA23576@Debian-50-lenny-64-minimal> <20220210203542.GA25645@Debian-50-lenny-64-minimal> <CAHi0vA_7ZWjT=BY7Tc65N4sajBjkKd1LLbd1CmmYPWfgwWvg1A@mail.gmail.com> <20220213185104.GA23259@Debian-50-lenny-64-minimal>
User-Agent: Alpine 2.11 (LMD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1737365482-580583748-1644780923=:30526"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1737365482-580583748-1644780923=:30526
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

It is good English. It unifies the two concepts. If they are not separated =
by
a hyphen, date becomes an adjective of time. It is the type of time called =
a
date, and I have no idea what that means.


William G. Unruh __| Canadian Institute for|____ Tel: +1(604)822-3273
Physics&Astronomy _|___ Advanced Research _|____ Fax: +1(604)822-5324
UBC, Vancouver,BC _|_ Program in Cosmology |____ unruh@physics.ubc.ca
Canada V6T 1Z1 ____|____ and Gravity ______|_ www.theory.physics.ubc.ca/

On Sun, 13 Feb 2022, Helge Kreutzmann wrote:

> Hello Mario,
> On Sun, Feb 13, 2022 at 07:33:07PM +0100, Mario Bl=C3=A4ttermann wrote:
>> Am Do., 10. Feb. 2022 um 21:35 Uhr schrieb Helge Kreutzmann
>> <debian@helgefjell.de>:
>>>
>>> Hello all,
>>> On Thu, Feb 10, 2022 at 08:23:41PM +0100, Helge Kreutzmann wrote:
>>>> I will send the issues in individual mails (like last time), without
>>>> this header. This will be a total of 84 mails.
>>>>
>>>> I'll wait with sending for ~ 1 hour in case you would not like to have
>>>> them in those e-mails.
>>>
>>> Mario asked me to provide the issues, therefor I send them to him
>>> directly for handling.
>>>
>>
>> I've fixed most of the issues in my Github fork; see pull request
>> #1601. However, there's something left (my comments are in brackets):
>
> Thanks.
>
> My 5 =C2=A2:
>
>> --
>> Man page: hwclock.8
>> Issue:    date-time =E2=86=92 date time??
>>
>> "There are two types of date-time clocks:"
>>
>> (We have lots of occurences of this "date-time" thing. Don't know
>> whether it's good English or bad English =E2=80=A6)
>
> It's used quite a few times in the file, so better leave it as is to
> be consistent.
>
>> --
>> Man page: lsmem.1
>> Issue:    The first sentence is broken
>>
>> "The B<lsmem> command lists a new memory range always when the current m=
emory "
>> "block distinguish from the previous block by some output column. This "
>> "default behavior is possible to override by the B<--split> option (e.g.=
, "
>> "B<lsmem --split=3DZONES>). The special word \"none\" may be used to ign=
ore all "
>> "differences between memory blocks and to create as large as possible "
>> "continuous ranges. The opposite semantic is B<--all> to list individual=
 "
>>
>> (Not sure what this means. I can't remember anymore why I wrote this
>> comment more than three years ago =E2=80=A6)
>
> Sorry, the english is rather hard to read:
> Suggested:
> The command B<lsmem> always lists a new memory range when the current
> memory block differs from the previous block in some output column.
>
> Greetings
>
>             Helge
> --
>      Dr. Helge Kreutzmann                     debian@helgefjell.de
>           Dipl.-Phys.                   http://www.helgefjell.de/debian.p=
hp
>        64bit GNU powered                     gpg signed mail preferred
>           Help keep free software "libre": http://www.ffii.de/
>
--1737365482-580583748-1644780923=:30526--
