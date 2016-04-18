Return-Path: ebiederm@xmission.com
From: ebiederm@xmission.com (Eric W. Biederman)
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org
References: <1460982392.2452.6.camel@HansenPartnership.com>
	<1460993854.7385.11.camel@HansenPartnership.com>
	<20160418171103.lcbrxvaldcyhemd3@ws.net.home>
	<1461000495.7385.18.camel@HansenPartnership.com>
Date: Mon, 18 Apr 2016 13:26:49 -0500
In-Reply-To: <1461000495.7385.18.camel@HansenPartnership.com> (James
	Bottomley's message of "Mon, 18 Apr 2016 13:28:15 -0400")
Message-ID: <87k2juu61i.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH] nsenter: fix ability to enter unprivileged containers
List-ID: <util-linux.vger.kernel.org>

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Mon, 2016-04-18 at 19:11 +0200, Karel Zak wrote:
>> On Mon, Apr 18, 2016 at 11:37:34AM -0400, James Bottomley wrote:
>> > OK, so if you want me to reply properly, you're going to have to keep
>> > my address in the cc list.
>> > 
>> > > > If you enter it first, you lose privilege for subsequent
>> > > namespace
>> > > > enters,see issue
>> > > >
>> > > > https://github.com/karelzak/util-linux/issues/315
>> > > >
>> > > > The fix is to enter the user namespace last of all.
>> > > 
>> > > I verified that with *current*/unpatched nsenter,
>> > > 
>> > > $ unshare -rm sleep inf &
>> > > $ nsenter -t $! -U -m --preserve
>> > > 
>> > > works as expected (from regular user [and with unprivileged userns
>> > > enabled]).
>> > > 
>> > > With this patch it *won't* work [verified], of course (as you'll need
>> > > root privileges in userns before joining mount-ns, and you can only
>> > > obtain them by entering userns first).
>> > 
>> > So we're using userns for different things.  I'm using it to remove
>> > privilege (so on my userns implementation root in the host enters but
>> > on becoming root in the userns, it can do nothing other than write to
>> > its own files) and you're using it to enhance privilege.  It looks like
>> > these two things will always be mutually exclusive, so perhaps we need
>> > an extra flag to nsenter to say do the userns first or last?
>> 
>> That's what I have talked about at github -- see Eric's comment in the
>> code, the user NS is the first in the array for a good reason. May be
>> it would be really better to add --user-{first,last} options to
>> specify when you want to enter user NS.
>
> OK, I'll code this up; hang on.

I think we can do this even better with two passes to setns.

A first pass before the user namespace is set (that ignores failures),
and a second pass that sets the user namespace first as happens today.

That should satisfy both cases without flags, and would remove the need
to remember/guess which kind of container people are using.

Eric
