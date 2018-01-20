Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:62043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756422AbeATTbl (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 20 Jan 2018 14:31:41 -0500
Subject: Re: Problem building util-linux without a separate ncursesw include
 dir
To: Karel Zak <kzak@redhat.com>,
        Carlos Santos <casantos@datacom.ind.br>,
        util-linux@vger.kernel.org
References: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br>
 <1705151756.2691717.1501548399616.JavaMail.zimbra@datacom.ind.br>
 <20170801072017.yl7mgv64pq7ccj5e@ws.net.home> <20180119024717.GJ7217@vapier>
 <20180119094051.g3qztrrqf5guife5@ws.net.home> <20180119182123.GK28967@vapier>
 <9f4f0155-fd38-e8d7-1340-b128b6ac447f@gmx.de> <20180120181405.GH14915@vapier>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <8f64924f-f89f-bc10-1be5-c8e64d2cdd12@gmx.de>
Date: Sat, 20 Jan 2018 20:31:26 +0100
MIME-Version: 1.0
In-Reply-To: <20180120181405.GH14915@vapier>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 01/20/2018 07:14 PM, Mike Frysinger wrote:
> On 20 Jan 2018 18:50, Rüdiger Meier wrote:
>> On 01/19/2018 07:21 PM, Mike Frysinger wrote:
>>> On 19 Jan 2018 10:40, Karel Zak wrote:
>>>> On Thu, Jan 18, 2018 at 09:47:17PM -0500, Mike Frysinger wrote:
>>>>> On 01 Aug 2017 09:20, Karel Zak wrote:
>>>>>> On Mon, Jul 31, 2017 at 09:46:39PM -0300, Carlos Santos wrote:
>>>>>>>> From: "Carlos Santos" <casantos@datacom.ind.br>
>>>>>>>> To: util-linux@vger.kernel.org
>>>>>>>> Sent: Monday, July 31, 2017 9:12:03 PM
>>>>>>>> Subject: Problem building util-linux without a separate ncursesw include dir
>>>>>>>
>>>>>>>> of util-linux. Would it be possible to make the location of ncursesw4c12a334dc4104d16dc06edf51904b08b08fcdfa
>>>>>>>> headers configurable, instead?
>>>>>>
>>>>>> We test for alone ncurses.h and term.h in the for non-wide ncurses.
>>>>>> Can you send output from your configure from the current master
>>>>>> branch (or v2.30.1)?
>>>>>>
>>>>>>> I was thinking on something simple, like https://pastebin.com/VqM9G9yu
>>>>>>
>>>>>> Hmm, but you don't distinguish between wide and non-wide ncurses.
>>>>>
>>>>> why don't we just support ncurses's pkg-config files as the default ?
>>>>> $ pkg-config --cflags ncurses
>>>>> -D_GNU_SOURCE
>>>>> $ pkg-config --cflags ncursesw
>>>>> -D_GNU_SOURCE -I/usr/include/ncursesw
>>>>
>>>> because pkg-config is not supported by ncurses upstream by default and
>>>> it's not always the best solution.
>>>
>>> you mean upstream's configure script doesn't default it to on.  distros
>>> can (and many do) simply pass --enable-pc-files to get them.  but i don't
>>> see how that's relevant to preference when it comes to detection.
>>>
>>>> See commit 4c12a334dc4104d16dc06edf51904b08b08fcdfa.
>>>
>>> seems like that's trivial to resolve with a compile test rather than
>>> throwing it all out.  xxx-config scripts provide bad defaults when you
>>> cross-compile because now the user has to make sure the build's copy
>>> of ncurses-config don't get used.
>>>
>>>> The ncurses detection and variability in distros is horrible. We
>>>> already tried all possible combinations and always someone complains
>>>> about the way how we detect ncurses. See mailing list archive for more
>>>> information.
>>>
>>> that's the point of pkg-config.  if someone is having problems because
>>> they're doing something weird/non-standard, tell them to sort out their
>>> pkg-config installs.
>>
>> non-standard is to have ncurses.pc installed.
> 
> that's a silly position to try to take.  you're claiming anything that isn't
> turned on by default in `./configure` is non-standard ?

No, as you could have read I'm talking only about --enable-pc-files being non
standard. Many distros and users are not using it and you can't just call them
all stupid. We have to support this case first.

> have you ever actually
> tried building ncurses before and see what its defaults are ?

Yes, and I install it into $HOME/usr and don't what to get it overridden by
/usr/lib64/pkgconfig/ although my $HOME/usr/bin/ncurses-config
comes first in my PATH. Especially since this worked since always and would
stop now when upgrading SLE-12 to SLE-15 (where they added --enable-pc-files),
just as an example.

   ncursesw isn't
> the default, neither is installing into a subdir like /usr/include/ncursesw.
> neither is libtinfo nor libtinfow.
> 
>> Also cross-compiling is certainly more "weird" than not cross-compiling.
> 
> you are aware that multilib is cross-compiling right ?  so people are doing
> it every day on all the mainstream distros.

I'm regularly building ul for i386 on x86_64 for testing. Just to see whether
our code works for 32bit. And it works. It's still absolutely unusual that any
real user would do that. And beside that I have no other use case for multilib
support at all.

>> Regarding "tell them",
>> Have you tried yet to ask ncurses upstream about installing *.pc files
>> by default?
> 
> i can send them an e-mail, but Thomas often leans towards not changing things
> from how they've always been done, so i'm not exactly hopeful.
> 
>>> that's a lot easier than trying to cater to all
>>> the stupid ways people try to set up their build environments.
>>enable
>> Installing ncurses via './configure && make install' is not the most
>> stupid thing IMO ... Maybe just remove your ncurses-config system wide
>> if you don't like it or use it correctly. Could be easier than telling
>> all other people on the planet that they havnote to install ncurses in a way
>> you like ...
> 
> telling people to mess with their build system (actively breaking it),
> especially when they might be on a shared system or where they don't have
> admin access, doesn't sound like a great idea to me.  especially when it's
> trivial for them to resolve with --enable-pc-files.  then again, the number
> of people who are building & installing ncurses by hand seems significantly
> lower than those who get it from distros, so catering to their choices (that
> then break things) doesn't seem worth it when they can simply adjust to do
> what everyone else is doing.

I do not think that the number of people who are building util-linux by hand
is significantly lower than the ones who would build ncurses.

Anyways I don't want to argue. My point is only that any project like UL should
respect upstream's default regarding pkg-config. There are even worse cases where
distros add/patch *.pc files to projects which don't even have --enable-pc-files
(e.g. libev on openSUSE). That's annoying if other projects would start requiring
these *.pc files although no user could provide them unless using distro packages.

cu,
Rudi
