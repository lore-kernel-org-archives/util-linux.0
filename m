Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36261 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722AbbEYQG5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 25 May 2015 12:06:57 -0400
Received: by obbea2 with SMTP id ea2so56536129obb.3
        for <util-linux@vger.kernel.org>; Mon, 25 May 2015 09:06:57 -0700 (PDT)
Message-ID: <556348A0.9020206@gmail.com>
Date: Mon, 25 May 2015 11:06:56 -0500
From: Bruce Dubbs <bruce.dubbs@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>, Martin Pitt <martin.pitt@ubuntu.com>
CC: util-linux@vger.kernel.org, Werner Fink <werner@suse.de>
Subject: Re: sulogin: Don't ask for password when it is locked/disabled
References: <20150525140117.GA9697@ws.net.home>
In-Reply-To: <20150525140117.GA9697@ws.net.home>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak wrote:
>
> Hi all,
>
> https://github.com/karelzak/util-linux/pull/200
> this is Martin's request for a change to sulogin.
>
> It seems that Debian for last 10 years uses modified sulogin to
> don't ask for password when /etc/shadow contains '!' or '*' as
> root password.
>
>>From my point of view the request makes sense, because otherwise it's
> impossible to enter shell in emergency more. BUT it also means that
> systems with locked root accounts are less secure.
>
> (Note that bootloader maybe password protected and access to console
>   does not always mean physical access to machine in all situations (locked
>   racks, console exported over network, virtual machines, etc.))
>
> Any security objections, comments?
>
> Do we want this feature enabled by default or do we need extra
> command line/compile option?

Perhaps it's security by obscurity, but doesn't this tell a malicious user 
immediately that the account is locked and to move on to another user id to try?

   -- Bruce Dubbs
      linuxfromscratch.org
