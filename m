Return-Path: util-linux-owner@vger.kernel.org
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42806 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725739AbeHFIz1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 6 Aug 2018 04:55:27 -0400
Date: Mon, 6 Aug 2018 08:47:47 +0200
From: Karel Zak <kzak@redhat.com>
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: util-linux@vger.kernel.org
Subject: Re: =?iso-8859-1?Q?Debian=B4?= =?iso-8859-1?Q?s?= change of "su" to
 the one in util-linux
Message-ID: <20180806064747.if5vniu65nsibfvg@ws.net.home>
References: <1734536.DseMWcvaqb@merkaba>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1734536.DseMWcvaqb@merkaba>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Aug 05, 2018 at 10:35:34AM +0200, Martin Steigerwald wrote:
> ownership preserved. However, for accessing the remote servers it needs
> access to the SSH agent running in the user session. The backup scripts 
> uses commands that are in "sbin" related directories.

This is common misunderstanding with su/sudo. 

su(1) creates a new *session* -- it means all the PAM stuff, all
logging, extra session parent process, etc. It's almost always
overkill to use such commands if all you need is a different UID.

> And then: How to implement a backup script that needs root access for 
> most operations, but also requires access to SSH agent from a user 
> setup? Dig out the environment variables of the SSH agent myself? Let 
> the script run as a user and use "setprivs" that is mentioned as 
> recommend in the "su" manpage, yet is in a different package altogether 
> and not part of "util-linux".

setpriv(1) is the right choice and it's part of util-linux (at least
in upstream tree).

> Also… login.defs manpage from shadow project does not mention 
> "ALWAYS_SET_PATH", but manpage of su from util-linux does mention it. 
> And there does not appear to be a manpage about "login.defs" in "util-
> linux" package at all. (I found before that there appears to be a huge, 
> big mess about some things in "util-linux", some in "shadow" and some in 
> both).

"login.defs" is shared between many projects and tools. We have all
related options described in tool specific man pages -- for example in
su(1).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
