Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38325 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751696AbaLSKHz (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 19 Dec 2014 05:07:55 -0500
Date: Fri, 19 Dec 2014 11:07:49 +0100
From: Karel Zak <kzak@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: util-linux@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [RFC][PATCH] unshare: Fix --map-root-user to work on new kernels
Message-ID: <20141219100749.GJ19904@x2.net.home>
References: <87zjalkhb8.fsf@x220.int.ebiederm.org>
 <87sigdkglg.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87sigdkglg.fsf@x220.int.ebiederm.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Dec 17, 2014 at 05:21:31PM -0600, Eric W. Biederman wrote:
> ebiederm@xmission.com (Eric W. Biederman) writes:
> 
> > I have just merged a security fix into the linux kernel that corrects an
> > oversight in the permission checks of /proc/self/gid_map.
> >
> > The root of the issue is that unix allows anyone to specify permissions
> > such like: --rwx---rwx on a file, and setgroups call at login time
> > allows seting groups that even setgid exectuables don't drop.  Which
> > results in the ability to assign a process fewer privileges just because
> > it is in a specified group, and this makes dropping groups an unsafe
> > operation.
> >
> > Therefore unprivileged writing of /proc/self/gid_map has been disabled
> > unless /proc/self/setgroups is written first to permanently disable the
> > ability to call setgroups in that user namespace.

 What does it mean "allow" in /proc/self/setgroups? 
 
 If I good understand than /proc/self/gid_map is unwritable until the
 setgroups file is set to "deny", and "allow" means that gid_map is
 disabled at all, but setgroup() syscall is possible to use in the
 user namespace. Right?

> > In part this design was chosen so that applications that are affected
> > will break early instead of late, and in part to make it clear to
> > everyone what is going on.
> >
> > I think for the experimental tool that is unshare --make-root-user we
> > just want to flip the bit and be done with it (patch below).
> >
> > However we may want to require an additional option to clear setgroups,
> > if there loging type applications running that call setgroups and having
> > explicit breakage up front instead of more silent stealthy breakage
> > when the application runs is desired.
> >
> > If we don't want any extra options working tested code is below.

 Do you mean "unshare --setgroups-allow"?

 (And it has to be mutually exclusive to --map-root-user.)

 IMHO it's good idea to make it possible to control this feature by
 unshare util.

> This may also have some affect on the setgroups(0, NULL) case of
> nsenter as well.

 Definitely yes, if I good understand then the best way is to read
 /proc/self/setgroups to check for "allow" before we call setgroups().
 Now we call it all time (for --setguid).

 I can write the patches.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
