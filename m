Return-Path: util-linux-owner@vger.kernel.org
Received: from out01.mta.xmission.com ([166.70.13.231]:35582 "EHLO
	out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750956AbaG1T2q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 28 Jul 2014 15:28:46 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Karel Zak <kzak@redhat.com>
Cc: bobtfish@bobtfish.net, util-linux@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
References: <1406406174-20938-1-git-send-email-bobtfish@bobtfish.net>
	<20140728115630.GJ8533@x2.net.home>
Date: Mon, 28 Jul 2014 12:24:58 -0700
In-Reply-To: <20140728115630.GJ8533@x2.net.home> (Karel Zak's message of "Mon,
	28 Jul 2014 13:56:30 +0200")
Message-ID: <874my1xp4l.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] Setting uid / gid is generally useful in nseneter
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Karel Zak <kzak@redhat.com> writes:

> On Sat, Jul 26, 2014 at 01:22:54PM -0700, bobtfish@bobtfish.net wrote:
>> It's useful to be able to set the UID/GID even when not using user namespaces
>> (for example when creating a non-root shell in a pre-existing docker container)
>>
>> Signed-off-by: Tomas Doran <bobtfish@bobtfish.net>
>> ---
>>  sys-utils/nsenter.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/sys-utils/nsenter.c b/sys-utils/nsenter.c
>> index d57edc8..23798f9 100644
>> --- a/sys-utils/nsenter.c
>> +++ b/sys-utils/nsenter.c
>> @@ -328,7 +328,7 @@ int main(int argc, char *argv[])
>>  	if (do_fork == 1)
>>  		continue_as_child();
>>  
>> -	if (namespaces & CLONE_NEWUSER) {
>> +	if (uid > 0 || gid > 0) {
>
>  Well, it breaks the current behavior (the default for CLONE_NEWUSER
>  is UID=0 and GID=0).
>
>  The question is this is the right direction, because I guess that the next 
>  patch for nsenter(1) will be "please, add supplementary groups
>  support" ;-)
>
>  Maybe the best will be to add to su(1) support for namespaces, something 
>  like:
>
>    su --ns <pid>[:mount,uts,ipc,net,pid,user]
>
>  to enter namespaces after authenticate (if required) and before
>  identity change. Not sure how huge is this Pandora's box, but it's
>  definitely the final solution for all the requirements, because su(1)
>  already supports all the UID/GID related features.
>
>  Eric, any note?

Thinking about it.

For my own use I believe I am still using an earlier version of nsenter
that does not even call setuid or setgid.

Thinking out loud.  Calling setuid(0) and setgid(0) in nsenter solves a
very practical problem of losing all capabilities on exec (because your
uid != 0).  Adding --setuid and --setgid is necessary because some
user namespaces do not have uid 0 or gid 0 mapped so switching to
those uids and gids would fail.

At the end of the day nsenter needs to be a simple tool, that is easy
to understand, because it is raw tool exposing the what the kernel
provides more or less directly without any significant abstractions.

Now it is a fact that nsenter must be run by root a process with
CAP_SYS_ADMIN or it must enter a user namespace.  Otherwise nsenter
does not have the privileges to do someting.  So assuming we have
CAP_SETUID or CAP_SETGID also is reasonable.

Hmm.

I think su (in general) is a bad fit.  There are two reasons.  nsenter
is not setuid and would not benefit from being so, most containers are
primarily managed as a separate system, and so the configuration in /etc
would not apply.

In general I would not trust the global root to run in a container 
so there is sense in the direction of this patch.  Especially if
su does not exist in the destination which makes chaining
nsenter and su difficult.

....

So the direction I could see this nsenter evolving is reading the
default uid and gid from the target process (A pain when in the case of
user namespaces because the value uid and gid will need to be mapped
into the target user namespace).

Likewise we could if it matters read the supplementary groups from from
the target process.  As a practical matter I don't think supplementary
groups are particularly interesting in simple cases and containers tend
to be simple cases.  So simply clearing the supplementary group ids
should be sufficient.

What I can see as productive (although possibly too much work) is to
allow setting the control groups and the security module identifiers to
that of the target process, or specified explicitly as we do with
namespaces now.

Ultimately nsenter should remain the simple raw tool that is gives you
raw access to what the kernel implements (without too much pain) so that
you can do things that whatever framework you are in does not implement.

...

So my gut feel about this patch it that we should add a uid/gid unset
state and generally implement this patch.  As the code is simple
and it implements a use case that quite hard to implement any other
way.

Eric
