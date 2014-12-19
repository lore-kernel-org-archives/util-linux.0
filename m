Return-Path: util-linux-owner@vger.kernel.org
Received: from out03.mta.xmission.com ([166.70.13.233]:51741 "EHLO
	out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752312AbaLSMbK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 19 Dec 2014 07:31:10 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
References: <87zjalkhb8.fsf@x220.int.ebiederm.org>
	<87sigdkglg.fsf@x220.int.ebiederm.org>
	<20141219100749.GJ19904@x2.net.home>
Date: Fri, 19 Dec 2014 06:28:45 -0600
In-Reply-To: <20141219100749.GJ19904@x2.net.home> (Karel Zak's message of
	"Fri, 19 Dec 2014 11:07:49 +0100")
Message-ID: <87a92j4yde.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [RFC][PATCH] unshare: Fix --map-root-user to work on new kernels
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> On Wed, Dec 17, 2014 at 05:21:31PM -0600, Eric W. Biederman wrote:
>> ebiederm@xmission.com (Eric W. Biederman) writes:
>> 
>> > I have just merged a security fix into the linux kernel that corrects an
>> > oversight in the permission checks of /proc/self/gid_map.
>> >
>> > The root of the issue is that unix allows anyone to specify permissions
>> > such like: --rwx---rwx on a file, and setgroups call at login time
>> > allows seting groups that even setgid exectuables don't drop.  Which
>> > results in the ability to assign a process fewer privileges just because
>> > it is in a specified group, and this makes dropping groups an unsafe
>> > operation.
>> >
>> > Therefore unprivileged writing of /proc/self/gid_map has been disabled
>> > unless /proc/self/setgroups is written first to permanently disable the
>> > ability to call setgroups in that user namespace.
>
>  What does it mean "allow" in /proc/self/setgroups? 
>  
>  If I good understand than /proc/self/gid_map is unwritable until the
>  setgroups file is set to "deny", and "allow" means that gid_map is
>  disabled at all, but setgroup() syscall is possible to use in the
>  user namespace. Right?

No.

The current state is backwards compatible for root, and is a little
weird but not that weird.

setgroups(2) is only callable with CAP_SETGID.
CAP_SETGID in a user namespace (now) does not give you permission to
call setgroups(2) (or any other system call) until after gid_map has
been set.

/proc/self/setgroups controls the setgroups system call.
"allow" means setgroups(2) is callable (permission checks permitting).
"allow" is the default state of /proc/self/setgroups.
"deny" means setgroups(2) is permanently disabled in the user namespace.
"deny" is only settable while setgroups(2) is disabled (aka "deny" is
       only settable before the gid_map is programmed)

gid_map is writable by root when setgroups(2) is enabled.
gid_map becomes writable by "unprivileged" processes when setgroups(2)
is permamently disabled.


In short /proc/self/setgroups controlls setgroups(2), and /proc/self/gid_map
controlls gids and a processes ability to use system calls that take
gids.

Compared to a clean sheet design everything things are a little wonky
in the interests of backwards compatibility.  To allow existing
applications run as root to ignore /proc/self/setgroups.

>> > In part this design was chosen so that applications that are affected
>> > will break early instead of late, and in part to make it clear to
>> > everyone what is going on.
>> >
>> > I think for the experimental tool that is unshare --make-root-user we
>> > just want to flip the bit and be done with it (patch below).
>> >
>> > However we may want to require an additional option to clear setgroups,
>> > if there loging type applications running that call setgroups and having
              ^^^^^^ login
>> > explicit breakage up front instead of more silent stealthy breakage
>> > when the application runs is desired.
>> >
>> > If we don't want any extra options working tested code is below.
>
>  Do you mean "unshare --setgroups-allow"?

I was thinking --setgroups=deny.

>  (And it has to be mutually exclusive to --map-root-user.)

Agreed --setgroups=allow would need to be mutually exclusive with
--map-root-user.

>  IMHO it's good idea to make it possible to control this feature by
>  unshare util.

Fair enough.  A general control is reasonable, and not hard to support.
Call it --setgroups=[allow|deny].

I was wondering if we should have such a control and require it with
--map-root-user to tell users their shell scripts fork login will break.
For the prupose of breaking setups that will break a little later when
setgroups(2) is called I don't think the option is worth it.

Just as a general knob I can see value in having a
--setgroups=[allow|deny] knob.



Stepping back a minute to the big picture and how this functionality is
used in other programs.

Typically a process will create a user namespace and then another
process with privileges will write to uid_map and gid_map.  For
processes that don't run as root by the helpers newuidmap and newgidmap
from the shadow package provide this functionality.

Note: Even if you start as root with all privileges once you create
the user namespace and enter into it you don't have any privileges
so you must arrange for an outside process to set uid_map and gid_map.

There is a special case for processes without privilege.  They can map
their own uids and gids without privilege.  This facilitates testing
and using user namespaces without coordination with any higher power.

--map-root-user as currently designed only uses that narrow special case
for processes without privilege that allows  mapping your own euid and
egid.  It writes uid_map and gid_map from inside the user namespace
(which is without privilege for purposes of the uid_map and gid_map
permission checks).



Given that unshare is a simple low level tool I can see real value in
my patch to fix --map-root-user.  I can see a little value in a general
--setgroups=[allow|deny] option.  Going any more general seems to
take unshare past the pont of being a simple general purpose utility
and well past the point of diminishing returns.

>> This may also have some affect on the setgroups(0, NULL) case of
>> nsenter as well.
>
>  Definitely yes, if I good understand then the best way is to read
>  /proc/self/setgroups to check for "allow" before we call setgroups().
>  Now we call it all time (for --setguid).
>
>  I can write the patches.

The best is not to check for "allow" before we call setgroups(0, NULL).
Reading /proc/self/setgroups won't tell you anything checking the return
of code of setgroups(0, NULL) won't tell you.

The best would be to call setgroups(0, NULL) before entering the user
namespace (so root can always clear their groups), and call setgroups(0,
NULL) after entering the user namespace (as currently happens).  If both
setgroups(0, NULL) calls fail then complain.

nsenter as currently constructed can not enter a user namespaces that
does not map uid 0 and gid 0.   So not handling setgroups=deny for
non-root users in seems reasonable.

What looks compelling to me is a --preserve-credentials option to
nsenter that would not touch uids or gids.  A --preserve-credentials
option will allow nsenter to enter all manner of user namespaces
irrespective of they are configured.

Does that clear up the confusion?

Eric
