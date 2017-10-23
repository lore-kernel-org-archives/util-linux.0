Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yw0-f178.google.com ([209.85.161.178]:45510 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbdJWPEu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 23 Oct 2017 11:04:50 -0400
Received: by mail-yw0-f178.google.com with SMTP id j4so12307220ywb.2
        for <util-linux@vger.kernel.org>; Mon, 23 Oct 2017 08:04:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171023105347.e6k3xwnwmhvgfzgw@ws.net.home>
References: <CAM9ceLjMPtUHNxj-G2YL=5w+dE+EoD+6rYKE1uDCDn5k19z8gw@mail.gmail.com>
 <20171023105347.e6k3xwnwmhvgfzgw@ws.net.home>
From: Jeff Sadowski <jeff.sadowski@gmail.com>
Date: Mon, 23 Oct 2017 09:04:49 -0600
Message-ID: <CAM9ceLhURzEtMnpr21VwqUR1HG31J5hoRRWWbw0bZu1fQFLYmA@mail.gmail.com>
Subject: Re: wall logging or run command each post?
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

So my best bet is going to be to put

alias wall=/script/wall.sh

in my /etc/bash.bashrc
and any other allowed shell rc's
where my /script/wall.sh does the things I want.
and change any scripts like my /etc/apcupsd/apccontrol
and change its WALL=wall to WALL=/script/wall.sh
as well.

I'll just have to go searching through /etc/ for files containing wall

This will get most things I care about but it might skip messages that
some users may broadcast
should adding the "#!/bin/bash" as the first line to shell scripts
cause the script to use the alias?


On Mon, Oct 23, 2017 at 4:53 AM, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Oct 18, 2017 at 02:06:25PM -0600, Jeff Sadowski wrote:
>> I would like to know if this feature is built into wall or is there a
>> good work around?
>
> wall is usually used by superuser. I guess if you can all "wall" than
> you can also call for example logger to write to the system logs. I
> don't see reason to merge functionally of these tools together.
>
>> I would like to configure wall to run a script after anything is posted to wall.
>
> Why? Maybe there is better way go get your goal.
>
>> I would also like to log all wall messages. I could easily do that
>> with a script.
>
> yes, script(1) is the right way
>
>     Karel
>
>
> --
>  Karel Zak  <kzak@redhat.com>
>  http://karelzak.blogspot.com
