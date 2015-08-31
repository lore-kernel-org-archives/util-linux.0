Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f181.google.com ([209.85.214.181]:36559 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753307AbbHaQU1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 31 Aug 2015 12:20:27 -0400
Received: by obkg7 with SMTP id g7so94853449obk.3
        for <util-linux@vger.kernel.org>; Mon, 31 Aug 2015 09:20:26 -0700 (PDT)
Message-ID: <55E47EC8.1030904@gmail.com>
Date: Mon, 31 Aug 2015 11:20:24 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: Bernhard Voelker <mail@bernhard-voelker.de>, util-linux@vger.kernel.org
Subject: Re: fdisk
References: <55E3B640.2060606@gmail.com> <55E3FAA9.5060204@bernhard-voelker.de>
In-Reply-To: <55E3FAA9.5060204@bernhard-voelker.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Bernhard Voelker wrote:
> On 08/31/2015 04:04 AM, Bruce Dubbs wrote:
>> I have a question about (or a enhancement request) running fdisk.  When
>> asking to list known partition types, I get about 70 lines of output.
>> Generally that would not be a problem, but I was running in a Debian
>> install/rescue iso that uses busybox in a 25 line terminal.  I do not
>> have a way to scroll up and thus cannot see the first 40 or so partition
>> types.
>>
>> Is there a way to use a pager for this?  In this situation 'more' is
>> available but 'less' is not.  Otherwise I think an automatic pause every
>> 20 lines or so would be appropriate to build into the partition type
>> listing.
>
> hmm, I'm getting 27 lines (at a maximum line length of 79 characters) as
> output of the 'l' command  here - even if I resize the xterm to 20x80
> characters.
> OTOH, the main help output via the 'm' command uses 38 lines.  Shouldn't
> you also have issues with that one in your environment?

In a konsole terminal resized to

# echo $LINES
25
# fdisk --version
fdisk from util-linux 2.26.2

Yes, the main menu scrolls off the top do the topmost line is:

n   add a new partition

but that is not a big problem in konsole because I can scroll back the 
buffer.  The l command lists the partition types and the topmost line of 
the screen is entry number 44.

If it's meaningful, for konsole, I do not use a LANG or any LC_* 
variables and the TERM variable is xterm.

The difficult problem is in busybox where there is no scroll back 
capability.

The problem should be relatively easy to reproduce.  Get a copy of 
debian-8.1.0-amd64-DVD-1.iso and boot it either to HW or in a virtual 
system (I'm using qemu).  Follow the prompts and drop to a terminal and 
then run fdisk.

   -- Bruce


   -- Bruce

