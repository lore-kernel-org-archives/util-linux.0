Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:51694 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbdB1P5Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 28 Feb 2017 10:57:16 -0500
Subject: Re: [V2 0/4] hwclock: remove date(1)
To: Karel Zak <kzak@redhat.com>
References: <ee9e12b4-a921-b47e-975d-53a5b8575361@gmx.com>
 <20170228133713.377klbjm44roizx6@ws.net.home>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <0d36f495-d691-9e80-9c05-461d3563b468@gmx.com>
Date: Tue, 28 Feb 2017 10:23:39 -0500
MIME-Version: 1.0
In-Reply-To: <20170228133713.377klbjm44roizx6@ws.net.home>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>



On 02/28/2017 08:37 AM, Karel Zak wrote:
> On Sat, Feb 25, 2017 at 01:25:37PM -0500, J William Piggott wrote:
>>
>> * The last commit/patch adds hwclock-date.c
> 
> Seems better than the previous attempt.
> 
>>    I added this file in case testers do not have 'bison' installed. It
>>    may, or may not, need to be tracked depending on how it is to be
>>    maintained. The 'c' file probably should be included in the
>>    distributed source archive to avoid the bison dependency.  Karel, I
>>    don't know if you want to create a separate clean and build target
>>    for hwclock-date.c, or how you want to handle this. So, if you don't
>>    mind, I'll leave this detail to you.
> 
> Yes, it's good idea to have .c files in the distribution tarball, but
> I'd like to avoid generated files in the git repository. I'll try to
> play with it (autotools) to generate .y to .c on the fly if missing.
> 
> Do you want to keep the .y file sync with gnulib and minimize number
> of our local changes, or is it so stable area that we don't have to
> care about it? ... because I don't like the coding style and  the
> debug stuff. If the overhead to maintain the file locally will be
> minimal than we can probably clean up it :-)

Stripping the gnulib dependencies are significant enough to make syncing
to with upstream impractical, I think. I fact, I have already excluded the
latest changes because they add more gnulib dependencies.

My impression is that the original parse_datetime() is stable. It seems
like most of the changes now involve parse_datetime2() to expand
capabilities. I was using the new api only for the debug output; I
thought if changes were ever needed in the parser it might be helpful.
Since that may be unlikely, and since you don't like the debugging,
parse_datetime2() along with all of its extensions can be removed.

> 
> I guess it will be possible to move it to lib/parse-datetime.c and use
> it on another places in util-linux (instead of our minimalistic
> parse_datetime()), right?

Sure, I think a name change to avoid confusion with gnulib would be
good. Maybe just parse_date.c?

I will work on these changes Karel.

> 
>     Karel
> 
