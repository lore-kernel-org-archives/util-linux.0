Return-Path: util-linux-owner@vger.kernel.org
Received: from out02.mta.xmission.com ([166.70.13.232]:54208 "EHLO
	out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbcEDPNp convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 4 May 2016 11:13:45 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: "W. Trevor King" <wking@tremily.us>,
        Linux Containers <containers@lists.linux-foundation.org>,
        systemd-devel@lists.freedesktop.org, util-linux@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>
References: <1461880928.2307.48.camel@HansenPartnership.com>
	<20160428230045.GS22888@odin.tremily.us>
	<1461944328.2311.10.camel@HansenPartnership.com>
Date: Wed, 04 May 2016 10:02:45 -0500
In-Reply-To: <1461944328.2311.10.camel@HansenPartnership.com> (James
	Bottomley's message of "Fri, 29 Apr 2016 08:38:48 -0700")
Message-ID: <87wpn9988a.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: Unprivileged containers and co-ordinating user namespaces
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

James Bottomley <James.Bottomley@HansenPartnership.com> writes:

> On Thu, 2016-04-28 at 16:00 -0700, W. Trevor King wrote:
>> On Thu, Apr 28, 2016 at 03:02:08PM -0700, James Bottomley wrote:
>> > /etc/usernamespaces
>> > 
>> > and the format be :::
>> > 
>> > …
>> > 
>> > If this sounds OK to people, I can code up a utility that does this,
>> > which should probably belong in util-linux.
>> 
>> This sounds a lot like shadow's newuidmap and newgidmap [1,2,3].
>> 
>> Cheers,
>> Trevor
>> 
>> [1]: https://github.com/shadow-maint/shadow/commit/673c2a6f9aa6c69588f4c1be08589b8d3475a520
>> [2]: http://man7.org/linux/man-pages/man1/newuidmap.1.html
>> [3]: http://man7.org/linux/man-pages/man5/subuid.5.html
>
> I think that mostly works.  No-one's packaging it yet, which is why I
> didn't notice.  It also looks like the build dependencies have vastly
> expanded, so I can't get it to build in the build service yet.

Both Fedora and Ubuntu should be packaging it.  Further Docker should
already be using these files.

> It looks like the only addition it needs is the setgroups flag for
> newgidmap, which the security people will need, so I can patch that. 
>  Plus it's trying to install newgidmap/newuidmap as setuid root rather
> than cap_setuid/cap_setgid, but that's fixable in the spec file.

I read the rest of this thread and I don't understand the setgroups flag
that you desire.  It sounds like someone with an incomplete grasp on the
situtation being cautious.

As far as I can tell the use cases for containers not supporting
setgroups is very limited.  Basically just using user namespaces to
drop privileges, and mapping the existing uids and gids to 0.

I don't think it actually makes sense to have a knob.  From a practical
standpoint entering any subordinate ids into the subgid file for a user
is a permission to use groups in such a way that can not use them as a
negative acl (because we allow them to be dropped).

Certainly it has been that way for quite a while now.

Except for the negative acl aspect there are no issues with dropping
groups, as setgroups will limit you to the groups allowed in your user
namespace.

Eric

