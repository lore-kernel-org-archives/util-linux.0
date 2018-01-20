Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:50779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756278AbeATRvG (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sat, 20 Jan 2018 12:51:06 -0500
Subject: Re: Problem building util-linux without a separate ncursesw include
 dir
To: Karel Zak <kzak@redhat.com>,
        Carlos Santos <casantos@datacom.ind.br>,
        util-linux@vger.kernel.org
References: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br>
 <1705151756.2691717.1501548399616.JavaMail.zimbra@datacom.ind.br>
 <20170801072017.yl7mgv64pq7ccj5e@ws.net.home> <20180119024717.GJ7217@vapier>
 <20180119094051.g3qztrrqf5guife5@ws.net.home> <20180119182123.GK28967@vapier>
From: =?UTF-8?Q?R=c3=bcdiger_Meier?= <sweet_f_a@gmx.de>
Message-ID: <9f4f0155-fd38-e8d7-1340-b128b6ac447f@gmx.de>
Date: Sat, 20 Jan 2018 18:50:52 +0100
MIME-Version: 1.0
In-Reply-To: <20180119182123.GK28967@vapier>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 01/19/2018 07:21 PM, Mike Frysinger wrote:
> On 19 Jan 2018 10:40, Karel Zak wrote:
>> On Thu, Jan 18, 2018 at 09:47:17PM -0500, Mike Frysinger wrote:
>>> On 01 Aug 2017 09:20, Karel Zak wrote:
>>>> On Mon, Jul 31, 2017 at 09:46:39PM -0300, Carlos Santos wrote:
>>>>>> From: "Carlos Santos" <casantos@datacom.ind.br>
>>>>>> To: util-linux@vger.kernel.org
>>>>>> Sent: Monday, July 31, 2017 9:12:03 PM
>>>>>> Subject: Problem building util-linux without a separate ncursesw include dir
>>>>>
>>>>>> of util-linux. Would it be possible to make the location of ncursesw4c12a334dc4104d16dc06edf51904b08b08fcdfa
>>>>>> headers configurable, instead?
>>>>
>>>> We test for alone ncurses.h and term.h in the for non-wide ncurses.
>>>> Can you send output from your configure from the current master
>>>> branch (or v2.30.1)?
>>>>
>>>>> I was thinking on something simple, like https://pastebin.com/VqM9G9yu
>>>>
>>>> Hmm, but you don't distinguish between wide and non-wide ncurses.
>>>
>>> why don't we just support ncurses's pkg-config files as the default ?
>>> $ pkg-config --cflags ncurses
>>> -D_GNU_SOURCE
>>> $ pkg-config --cflags ncursesw
>>> -D_GNU_SOURCE -I/usr/include/ncursesw
>>
>> because pkg-config is not supported by ncurses upstream by default and
>> it's not always the best solution.
> 
> you mean upstream's configure script doesn't default it to on.  distros
> can (and many do) simply pass --enable-pc-files to get them.  but i don't
> see how that's relevant to preference when it comes to detection.
> 
>> See commit 4c12a334dc4104d16dc06edf51904b08b08fcdfa.
> 
> seems like that's trivial to resolve with a compile test rather than
> throwing it all out.  xxx-config scripts provide bad defaults when you
> cross-compile because now the user has to make sure the build's copy
> of ncurses-config don't get used.
> 
>> The ncurses detection and variability in distros is horrible. We
>> already tried all possible combinations and always someone complains
>> about the way how we detect ncurses. See mailing list archive for more
>> information.
> 
> that's the point of pkg-config.  if someone is having problems because
> they're doing something weird/non-standard, tell them to sort out their
> pkg-config installs.

non-standard is to have ncurses.pc installed. Also cross-compiling is
certainly more "weird" than not cross-compiling. Regarding "tell them",
Have you tried yet to ask ncurses upstream about installing *.pc files
by default?

However I agree that pkg-config should be checked *before* ncurses-config
otherwise it doesn't make much sense to support pc-files at all. The case
that *.pc or ncurses-config files are installed without the headers is
really a packaging bug made by distros. We don't need to handle this case.

BTW we need to fix our usage of environment vars NCURSESW_CFLAGS,
NCURSESW_LIBS, NCURSES_CFLAGS, NCURSES_LIBS. They don't seem to work as
expected although documented in configure --help. These vars should skip
pkg-config and ncurses-config too. Probably this would work automatically
again when doing pkg-config before ncurses-config.

I still think we should evaluate autoconf_archive's ncurses detection. It's
using pkg-config first and then fallback even without ncurses-config. Could
be that even cross-compiling would work without *.pc files.
https://www.gnu.org/software/autoconf-archive/ax_with_curses.html
Though I'm too lazy for testing this ;)

> that's a lot easier than trying to cater to all
> the stupid ways people try to set up their build environments.

Installing ncurses via './configure && make install' is not the most
stupid thing IMO ... Maybe just remove your ncurses-config system wide
if you don't like it or use it correctly. Could be easier than telling
all other people on the planet that they have to install ncurses in a way
you like ...

cu,
Rudi
