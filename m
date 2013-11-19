Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47202 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab3KSSGC (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Nov 2013 13:06:02 -0500
Date: Tue, 19 Nov 2013 19:05:56 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] setsid: don't fork
Message-ID: <20131119180556.GN5572@x2.net.home>
References: <1384456993-3721-1-git-send-email-psusi@ubuntu.com>
 <20131119132412.GG5572@x2.net.home>
 <528B7D4C.1030405@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528B7D4C.1030405@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Nov 19, 2013 at 10:01:32AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 11/19/2013 8:24 AM, Karel Zak wrote:
> > Yep, it was our goal to not change the default behaviour that
> > exists for years.
> 
> It isn't really a default preference but a straight up bug since the
> behavior depends on how the shell invokes it.  You only get the no
> wait behavior when it is a process group leader.  When invoked not as
> a group leader, then you get the wait behavior whether you asked for
> it or not.  So if you really want no wait to be the default behavior

 but why you don't want --wait behavior? It does not change anything,
 but fix the problem with group leader. 
 
 IMHO we can make it (--wait) the default (you almost convinced me
 that the default behaviour should be fixed).

> then you need to fork whether or not you're a group leader and the
> policy decision chooses whether to wait for the child or not.
> 
> > It does not seem too elegant :-) If you really want to change the 
> > default behaviour than it would be better to make --wait default 
> > and exec() in child, then you don't need setpgid(), kill() and 
> > sleep/pause() at all.
> 
> What's not elegant about it? 

 fork for sleep() and then kill it

> I think it's cleaner than keeping around
> a useless intermediary process that just waits for the child and
> returns its exit status. 
 
 it also fixes the problem with group leader as child process is never
 group leader (you have to call setpgid() to be leader).

 I'm also not sure if remove --wait is the best way... what about
 people who already use it? (yep, it's release few weeks ago, but...)

> I'm still not sure why the kernel requires
> you to not be a group leader but this seems like a better workaround
> than forking off a lost child.

 If I good understand the man page then setsid() caller is session and
 group leader of the *new* session and group. It's probably unwanted
 to make the original group orphaned (without leader), because
 processes in orphaned group get SIGCONT from kernel...

 (BTW, SIGCONT is probably what will happen in your version after
  kill(pid) as the sleeping child is group leader, right?)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
