Return-Path: util-linux-owner@vger.kernel.org
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37320 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752124AbcEDSVg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 4 May 2016 14:21:36 -0400
Message-ID: <1462386093.14310.93.camel@HansenPartnership.com>
Subject: Re: Unprivileged containers and co-ordinating user namespaces
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        systemd-devel@lists.freedesktop.org, util-linux@vger.kernel.org
Date: Wed, 04 May 2016 14:21:33 -0400
In-Reply-To: <1462385876.14310.90.camel@HansenPartnership.com>
References: <1461880928.2307.48.camel@HansenPartnership.com>
	 <20160428230045.GS22888@odin.tremily.us>
	 <1461944328.2311.10.camel@HansenPartnership.com>
	 <87wpn9988a.fsf@x220.int.ebiederm.org>
	 <1462385876.14310.90.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 2016-05-04 at 14:17 -0400, James Bottomley wrote:
> > Certainly it has been that way for quite a while now.
> 
> I don't quite get this.  If setgroups is set to deny and I have a set
> of group mappings, I still can't get rid of the negative acl group. 
>  I can map it to a different gid inside my container, or I can not 
> map  it at all, but in either case I still can't get access to 
> anything with the negative acl group marker because the group 
> permission checks occurs with the kguid_t set which includes my 
> mapped or unmapped group.  The only way I can lose it is to call
> sys_setgroups().

Sorry, this next bit should be at the end of the email (I was playing
and typing at the same time):

> It's a bit ugly because I have to enter the container with --preserve
> -credentials and I can't su to myself if I enter as root (-S 0), I 
> have to re-enter as myself instead, but it works.
> 
> > Except for the negative acl aspect there are no issues with 
> > dropping groups, as setgroups will limit you to the groups allowed 
> > in your user namespace.
> 
> Well, notwithstanding the merits of negative acls, which I don't want
> to debate because I don't think they're that useful, the use case 
> might be that a user possessing a negative acl still wants to use an
> architecture emulation container for building.  Installing such a
> container requires being able to set a set of groups and uids 
> (required by the installer), but it doesn't require the 
> sys_setgroups() system call, so they could reasonably be given the 
> ability to set one up with the nosetgroups flag and a range of gids 
> allocated in subgid to ensure they still can't get access to 
> resources denied by the negative acl group.

It's a bit ugly because I have to enter the container with --preserve
-credentials and I can't su to myself if I enter as root (-S 0), I have
to re-enter as myself instead, but it works.

James

