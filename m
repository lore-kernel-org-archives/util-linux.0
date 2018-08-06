Return-Path: util-linux-owner@vger.kernel.org
Received: from mondschein.lichtvoll.de ([194.150.191.11]:48839 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbeHFKls (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 6 Aug 2018 06:41:48 -0400
From: Martin Steigerwald <martin@lichtvoll.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: =?UTF-8?B?RGViaWFuwrRz?= change of "su" to the one in util-linux
Date: Mon, 06 Aug 2018 10:33:48 +0200
Message-ID: <9527938.bmH0D6gqrg@merkaba>
In-Reply-To: <20180806064747.if5vniu65nsibfvg@ws.net.home>
References: <1734536.DseMWcvaqb@merkaba> <20180806064747.if5vniu65nsibfvg@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak - 06.08.18, 08:47:
> On Sun, Aug 05, 2018 at 10:35:34AM +0200, Martin Steigerwald wrote:
> > ownership preserved. However, for accessing the remote servers it
> > needs access to the SSH agent running in the user session. The
> > backup scripts uses commands that are in "sbin" related
> > directories.
> 
> This is common misunderstanding with su/sudo.
> 
> su(1) creates a new *session* -- it means all the PAM stuff, all
> logging, extra session parent process, etc. It's almost always
> overkill to use such commands if all you need is a different UID.

>From the viewpoint of the "loginctl" command from "systemd-logind" it 
does not. "loginctl" always displays one session, no matter how many 
"su" sessions I have open.

But I bet sessions are something different in different contexts.

> > And then: How to implement a backup script that needs root access
> > for
> > most operations, but also requires access to SSH agent from a user
> > setup? Dig out the environment variables of the SSH agent myself?
> > Let
> > the script run as a user and use "setprivs" that is mentioned as
> > recommend in the "su" manpage, yet is in a different package
> > altogether and not part of "util-linux".
> 
> setpriv(1) is the right choice and it's part of util-linux (at least
> in upstream tree).

Thanks for that hint. I now found that the "setpriv" binary package in 
Debian is from the "util-linux" source package.

However I do not see how "setpriv" would be appropriate for my use case. 
Just as "runuser" it can only be used as "root". It cannot be used by a 
regular user, as it can only drop privileges and does not ask for a 
password.

> > Also… login.defs manpage from shadow project does not mention
> > "ALWAYS_SET_PATH", but manpage of su from util-linux does mention
> > it.
> > And there does not appear to be a manpage about "login.defs" in
> > "util- linux" package at all. (I found before that there appears to
> > be a huge, big mess about some things in "util-linux", some in
> > "shadow" and some in both).
> 
> "login.defs" is shared between many projects and tools. We have all
> related options described in tool specific man pages -- for example in
> su(1).

Okay, noted. It of course adds to the confusion. And it feels 
inconsistent for it. 

And as I wrote in my reply to Ted´s mail: The "login" command from 
"shadow" project does not understand the "ALWAYS_SET_PATH" option the 
"su" command from "util-linux" project knows.

However I am not at all for "systemd"-ing this as well. But I wonder 
whether the current split of "shadow" and "util-linux" is all that 
beneficial. At least in that case I of using the "login.defs" file for 
both, I´d expect the tools to ignore unknown configuration options, but 
this has the risk to let a configuration error go unnoticed.

Thanks,
-- 
Martin


