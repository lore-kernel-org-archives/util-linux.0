Return-Path: util-linux-owner@vger.kernel.org
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37250 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755238AbcEDSSA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 4 May 2016 14:18:00 -0400
Message-ID: <1462385876.14310.90.camel@HansenPartnership.com>
Subject: Re: Unprivileged containers and co-ordinating user namespaces
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: systemd-devel@lists.freedesktop.org,
        Linux Containers <containers@lists.linux-foundation.org>,
        util-linux@vger.kernel.org
Date: Wed, 04 May 2016 14:17:56 -0400
In-Reply-To: <87wpn9988a.fsf@x220.int.ebiederm.org>
References: <1461880928.2307.48.camel@HansenPartnership.com>
	 <20160428230045.GS22888@odin.tremily.us>
	 <1461944328.2311.10.camel@HansenPartnership.com>
	 <87wpn9988a.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 2016-05-04 at 10:02 -0500, Eric W. Biederman wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> 
> > On Thu, 2016-04-28 at 16:00 -0700, W. Trevor King wrote:
> > > On Thu, Apr 28, 2016 at 03:02:08PM -0700, James Bottomley wrote:
> > > > /etc/usernamespaces
> > > > 
> > > > and the format be :::
> > > > 
> > > > …
> > > > 
> > > > If this sounds OK to people, I can code up a utility that does 
> > > > this, which should probably belong in util-linux.
> > > 
> > > This sounds a lot like shadow's newuidmap and newgidmap [1,2,3].
> > > 
> > > Cheers,
> > > Trevor
> > > 
> > > [1]: https://github.com/shadow-maint/shadow/commit/673c2a6f9aa6c6
> > > 9588f4c1be08589b8d3475a520
> > > [2]: http://man7.org/linux/man-pages/man1/newuidmap.1.html
> > > [3]: http://man7.org/linux/man-pages/man5/subuid.5.html
> > 
> > I think that mostly works.  No-one's packaging it yet, which is why 
> > I didn't notice.  It also looks like the build dependencies have
> > vastly expanded, so I can't get it to build in the build service
> > yet.
> 
> Both Fedora and Ubuntu should be packaging it.  Further Docker should
> already be using these files.
> 
> > It looks like the only addition it needs is the setgroups flag for
> > newgidmap, which the security people will need, so I can patch 
> > that.  Plus it's trying to install newgidmap/newuidmap as setuid 
> > root rather than cap_setuid/cap_setgid, but that's fixable in the 
> > spec file.
> 
> I read the rest of this thread and I don't understand the setgroups 
> flag that you desire.  It sounds like someone with an incomplete 
> grasp on the situtation being cautious.
> 
> As far as I can tell the use cases for containers not supporting
> setgroups is very limited.  Basically just using user namespaces to
> drop privileges, and mapping the existing uids and gids to 0.
> 
> I don't think it actually makes sense to have a knob.  From a 
> practical standpoint entering any subordinate ids into the subgid 
> file for a user is a permission to use groups in such a way that can 
> not use them as a negative acl (because we allow them to be dropped).
> 
> Certainly it has been that way for quite a while now.

I don't quite get this.  If setgroups is set to deny and I have a set
of group mappings, I still can't get rid of the negative acl group.  I
can map it to a different gid inside my container, or I can not map it
at all, but in either case I still can't get access to anything with
the negative acl group marker because the group permission checks
occurs with the kguid_t set which includes my mapped or unmapped group.
 The only way I can lose it is to call sys_setgroups().

It's a bit ugly because I have to enter the container with --preserve
-credentials and I can't su to myself if I enter as root (-S 0), I have
to re-enter as myself instead, but it works.

> Except for the negative acl aspect there are no issues with dropping
> groups, as setgroups will limit you to the groups allowed in your 
> user namespace.

Well, notwithstanding the merits of negative acls, which I don't want
to debate because I don't think they're that useful, the use case might
be that a user possessing a negative acl still wants to use an
architecture emulation container for building.  Installing such a
container requires being able to set a set of groups and uids (required
by the installer), but it doesn't require the sys_setgroups() system
call, so they could reasonably be given the ability to set one up with
the nosetgroups flag and a range of gids allocated in subgid to ensure
they still can't get access to resources denied by the negative acl
group.

James

