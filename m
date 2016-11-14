Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f171.google.com ([209.85.220.171]:34790 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbcKNR71 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 14 Nov 2016 12:59:27 -0500
Received: by mail-qk0-f171.google.com with SMTP id q130so105282548qke.1
        for <util-linux@vger.kernel.org>; Mon, 14 Nov 2016 09:59:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAG27Bk3hONs8GZ_4GvwJYHu-kMntNzvmVn-qzSO7p6EBDS8xog@mail.gmail.com>
References: <CADBFhQdpTibzv8G8gLXS+TW6XFg=WFjNG6+dy7snKLf44ToGQw@mail.gmail.com>
 <CAG27Bk3hONs8GZ_4GvwJYHu-kMntNzvmVn-qzSO7p6EBDS8xog@mail.gmail.com>
From: Jim Patterson <jimp@wegrok.net>
Date: Mon, 14 Nov 2016 12:59:26 -0500
Message-ID: <CADBFhQd0dReuAPbMrybi8So9xShVKJEaq15+c-SXtyN7MHB=9A@mail.gmail.com>
Subject: Re: New option for wall to limit message by group?
To: kerolasa@gmail.com
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Sami,

I think can handle the code without difficulty, but I'm open to help
from anyone we wants to help, and of course code review and feedback
is always welcome.

Thanks for heads up about the maintainer, sounds like a great holiday.

Jim P


On Mon, Nov 14, 2016 at 12:18 PM, Sami Kerola <kerolasa@iki.fi> wrote:
> On 14 November 2016 at 16:31, Jim Patterson <jimp@wegrok.net> wrote:
>> The company that I work for has an old terminal application that is
>> still in use today.  This app used to run on AIX boxes but has been
>> moved to modern Linux based systems.  The users on this application
>> are in groups and under AIX we used the "-g" switch on wall to be able
>> to send a message to a single group at a time.  The wall on Linux does
>> not offer this option.  I will either be adding this option to wall or
>> writing a custom tool to support sending a message based on the user's
>> groups.
>>
>> Is there any interest in a pull request supporting such an option in
>> the standard wall?  And if so, does anyone have any particular
>> concerns about implementation details?
>>
>> The AIX man page does not describe the implementation details, but
>> experimenting with the command on an AIX system shows that the the
>> message is sent to all users that have the specified group in the
>> primary or supplementary groups.  My plan for doing this on a Linux
>> system is to use the username in the utmp entry to lookup the user's
>> primary and supplementary groups, then skip the utmp entry if the user
>> does not have the specified group.
>>
>> Thanks in advance,
>> Jim P
>>
>> PS. I'm not subscribed to the group, so please reply to this address also.
>
> Hi Jim,
>
> Adding -g, --group <groupname|gid> option should be doable. Do you want
> to write this change or prefer someone else doing the work? Either way I
> don't mind helping a bit.
>
> Reference: http://www.ibm.com/support/knowledgecenter/ssw_aix_61/com.ibm.aix.cmds6/wall.htm
>
> p.s. Maintainer is off-line
> http://marc.info/?l=util-linux-ng&m=147877091818853&w=2
>
> --
> Sami Kerola
> http://www.iki.fi/kerolasa/
