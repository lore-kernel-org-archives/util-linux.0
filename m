Return-Path: util-linux-owner@vger.kernel.org
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:37130 "EHLO
	bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753251AbcEDSA4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 4 May 2016 14:00:56 -0400
Message-ID: <1462384853.14310.87.camel@HansenPartnership.com>
Subject: Re: bind mounting namespace inodes for unprivileged users
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linux Containers <containers@lists.linux-foundation.org>,
        util-linux@vger.kernel.org
Date: Wed, 04 May 2016 14:00:53 -0400
In-Reply-To: <87futx3eid.fsf@x220.int.ebiederm.org>
References: <1462299656.16133.51.camel@HansenPartnership.com>
	 <87oa8lc2ic.fsf@x220.int.ebiederm.org>
	 <1462382890.14310.67.camel@HansenPartnership.com>
	 <87futx3eid.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 2016-05-04 at 12:43 -0500, Eric W. Biederman wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> > On Wed, 2016-05-04 at 09:38 -0500, Eric W. Biederman wrote:
> > > James Bottomley <James.Bottomley@HansenPartnership.com> writes:
> > > > So, does anyone have any strong (or even weak) opinions about 
> > > > this before I start coding patches?
> > > 
> > > The mount namespace is complex and getting it right is a pain in 
> > > the rear.  So adding yet another path and piece in to the 
> > > existing complexity makes me cringe a little.
> > 
> > Yes, well which is worse: having no way to bind unprivileged
> > containers without spawning a long running process or having a way 
> > to bind them which may lead to unremovable files.  Since I just use 
> > sudo mount --bind anyway for my containers, I don't see the file 
> > removal argument as too daunting.
> 
> So far with setns support I haven't felt the need to bind mount
> containers.  So I am not certain it is an either or choice.
> 
> And of course the other side of the craziness is having a mount point 
> on a filesystem makes that filesystem unmountable (except for lazy
> unmounts).  So getting this wrong could affect clean shutdowns and
> reboots.

OK, I by this argument a little.  It could be circumvented by having
the shutdown script remove all container bindings, though.  This seems
to work

umount -t nsfs -a

>   Which suggests it may be wise to limit this kind of thing
> to a tmpfs like /run/user/<uid>/.
> 
> Mostly this is my way of say tread carefully because there be dragons
> here.

Understood.  Even though fixing the pinned filesystem issue can be
done, I do agree that it makes the problem knottier.

James

