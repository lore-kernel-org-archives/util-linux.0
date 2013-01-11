Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20856 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754797Ab3AKQNi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 11 Jan 2013 11:13:38 -0500
Date: Fri, 11 Jan 2013 17:13:20 +0100
From: Karel Zak <kzak@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: util-linux@vger.kernel.org, Neil Horman <nhorman@tuxdriver.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Subject: Re: [PATCH] enter: new command (light wrapper around setns)
Message-ID: <20130111161320.GA16206@x2.net.home>
References: <876234812z.fsf@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <876234812z.fsf@xmission.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jan 11, 2013 at 02:29:24AM -0800, Eric W. Biederman wrote:
> 
> Inspired by unshare, enter is a simple wrapper around setns that
> allows running a new process in the context of an existing process.

 It would be really nice to have "ns" in the name -- for example
 "enterns" sounds good.

> While doing a final check on this patch I just realized I am a week or
> two late to the discussion.

 Yep :-)

> Little things like retaining the the ability for unshare to be suid root
> safely and sanely become intractable if you call setns() and join a
> user namespace.  

 Do you have any example (use case) with suid unshare(1)? 

> Supporting the ability for the command to be setuid root does not
> work in combination with the user namespace.  As after entering
> the user namespace you can not reliably change your uid back to
> your uid without setuid as your uid may not be mapped.
> 
> When joining an existing mount namespace you most likely want to change
> your root directory and your working directory to the directory of the
> process whoose mount namespace you are entering.  Something you don't
> even think about when just unsharing a mount namespace.
> 
> Then there is the practical wish to call fork after entering a pid
> namespace and before launching a command.  You don't always want that
> but almost always so that the command will actually be run in the new
> pid namespace with a new pid, instead of having it's children in the new
> pid namespace.
> 
> I really can't see support for using setns being in the same binary as
> unshare that just mixes two different but closely related things that
> will want to evolve in different directions.
> 
> My inclination is to send a follow up patch to remove setns and migrate
> from unshare. 

 unnecessary, "git revert" works fine :-)

> And a second patch to add pid and user namespace support
> to unshare.  But since I am going against the way that seems to have
> already been decided I will hold off on those patches until after we
> there is agreement on this one.

 well, the decision has been based on little different context. 
 
 I have no problem to revert the change if there is a real use case 
 with suid and if the setns() goals will be incompatible with the 
 way how people use unshare(1) command.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
