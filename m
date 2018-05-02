Return-Path: util-linux-owner@vger.kernel.org
Received: from ishtar.tlinx.org ([173.164.175.65]:37632 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEBDdy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 1 May 2018 23:33:54 -0400
Message-ID: <5AE9319E.6050105@tlinx.org>
Date: Tue, 01 May 2018 20:33:50 -0700
From: L A Walsh <lkml@tlinx.org>
MIME-Version: 1.0
To: Bruce Dubbs <bruce.dubbs@gmail.com>
CC: util-linux@vger.kernel.org
Subject: Re: configure output seems confusing in util-linux-2.32
References: <5AE908A7.2010900@tlinx.org> <0a977638-61e0-2ffc-8b3e-e4c9dcbaea2a@gmail.com>
In-Reply-To: <0a977638-61e0-2ffc-8b3e-e4c9dcbaea2a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Bruce Dubbs wrote:
> On 05/01/2018 07:39 PM, L A Walsh wrote:
>   
>> Looked at configure help, saw:
>> Optional packages:
>> ...
>>   --with-systemd          build with support for systemd
>> to me, this means systemd is optional and may be
>> included using a 'with'.
>> Conversely, one could use:
>>   --without-systemd
>>     
>
> Works for me,  but you also need to use --without-systemdsystemunitdir
>   
---
    I see.
    That's a workaround to suppress the message.  Even without
the '--without-systemdsystemunitdir', systemd appears to be
disabled.  Under the summary of options, it had:

  Bash completions:  /usr/share/bash-completion
  Systemd support:   no
  Btrfs support:     yes
  Wide-char support: yes

    It seems like it is more confusing than
an actual problem.  Though, IMO, "--without-systemd"
should disable any processing for the systemd unit dir as well,
no?  And going with standard meanings, if the switch to toggle
default behavior is the one listed in "configure --help", wouldn't
the default have been --without-systemdsystemunitdir (boy that's
a mouthful of a switch name)?

    AFAIK, this issue is more along the lines of dotting an 'i'
or crossing a 't', but it's still a bit odd...

-l



