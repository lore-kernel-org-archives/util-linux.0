Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10717 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755239AbaJNMyc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Oct 2014 08:54:32 -0400
Date: Tue, 14 Oct 2014 14:54:27 +0200
From: Karel Zak <kzak@redhat.com>
To: "Dale R. Worley" <worley@alum.mit.edu>
Cc: util-linux@vger.kernel.org
Subject: Re: Error in losetup man page
Message-ID: <20141014125427.GV8057@x2.net.home>
References: <201410031430.s93EUddT014847@hobgoblin.ariadne.com>
 <20141007095647.GD8057@x2.net.home>
 <201410071334.s97DYZa5021378@hobgoblin.ariadne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201410071334.s97DYZa5021378@hobgoblin.ariadne.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 07, 2014 at 09:34:35AM -0400, Dale R. Worley wrote:
> > From: Karel Zak <kzak@redhat.com>
> > 
> > On Fri, Oct 03, 2014 at 10:30:39AM -0400, Dale R. Worley wrote:
> > > On Fedora 19, the man page for losetup says:
> > > 
> > >        Delete all used loop devices:
> > > 
> > >             losetup -D
> > > 
> > > That should be "Delete all *unused* loop devices:", I'm sure.
> > 
> > "used" means loop devices that have backing file, I have replaced the
> > text with "Detach all associated loop devices:"
> 
> Does it detach loop devices that are associated and also mounted or
> otherwise opened?  My test case does not attempt to do that.
> 
> So the criterion is that the loop device has to be "used" in the sense
> of being associated but "not used" in the sense of being open.  Maybe
> "Delete all associated loop devices that are not opened"?  (Mounting
> is known to be a variety of opening.)

 Well, I'd like to keep synopsis section brief. It would be better to
 add such details to --detach and --detach-all description where we
 can be more verbose. Any volunteer? :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
