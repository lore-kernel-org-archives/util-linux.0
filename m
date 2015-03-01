Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:44667 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751855AbbCANcF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Mar 2015 08:32:05 -0500
Message-ID: <54F314D1.2080003@draigBrady.com>
Date: Sun, 01 Mar 2015 13:32:01 +0000
From: =?windows-1252?Q?P=E1draig_Brady?= <P@draigBrady.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>, kerolasa@gmail.com,
        "Dale R. Worley" <worley@alum.mit.edu>, mrmazda@earthlink.net,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: tty[1-6]: colors a negative accessibility/usability trend
References: <54DC88BF.5040702@draigBrady.com> <87h9uqv6lv.fsf@hobgoblin.ariadne.com> <20150213092131.GM32318@ws.net.home> <CAG27Bk0JrVSbKEBqeEr63O4cz3B5zyDmGw_MFVzXYTbWjZ2URQ@mail.gmail.com> <20150213112523.GP32318@ws.net.home> <20150215111238.GG32251@vapier> <20150216091043.GA11948@ws.net.home> <20150216093533.GJ4075@vapier> <20150216094747.GC11948@ws.net.home> <20150216103241.GD3926@type.bordeaux.inria.fr> <20150227134805.GB8046@ws.net.home>
In-Reply-To: <20150227134805.GB8046@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 27/02/15 13:48, Karel Zak wrote:
> On Mon, Feb 16, 2015 at 11:32:41AM +0100, Samuel Thibault wrote:
>> Karel Zak, le Mon 16 Feb 2015 10:47:47 +0100, a écrit :
>>> On Mon, Feb 16, 2015 at 04:35:33AM -0500, Mike Frysinger wrote:
>>>> On 16 Feb 2015 10:10, Karel Zak wrote:
>>>>>  What we want to duplicate? What exactly in lib/colors.c is duplicate?
>>>>>  The code evaluates filenames and parses files with "name colorcode".
>>>>
>>>> whether the terminal even supports color in the first place.  if i picked a 
>>>> terminal that doesn't support color so i didn't have to worry about it, it's a 
>>>> bit crazy i also have to go to multiple config files and also tell them i don't 
>>>> want color otherwise i get corrupted output.
>>>
>>> For now it checks isatty() and nothing else, it would be possible to
>>> check number of supported colors in terminfo too, or is there any
>>> other way?
>>
>> It should also check how to change the colors. Not all terminals will
>> support the ANSI way.
> 
>  OK, linked with libtinfo, now it checks if the current terminal supports 
>  colors ("colors" from tinfo) and all the stuff is disabled for terminals
>  like vt100.
> 
>>> Anyway, we don't want to create (duplicate) any database, all it
>>> provides are knobs for customization and enable/disable.
>>
>> It provides only that because the source code currently hardcodes the
>> \033[%sm sequence, but it really should not, and use terminfo instead.
> 
>  This is not implemented yet, I (or any volunteer?) will try to add to code 
>  an extra layer to avoid the hardcoded sequences and read the colors from terminfo.

I'd be careful to not over engineer that.
coreutils currently hardcodes ansi sequences,
and I've not heard specific complaints about it.
What terminals are not catered for here?

