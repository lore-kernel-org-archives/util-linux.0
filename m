Return-Path: worley@ariadne.com
Date: Tue, 7 Oct 2014 09:34:35 -0400
Message-Id: <201410071334.s97DYZa5021378@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
Sender: worley@alum.mit.edu (Dale R. Worley)
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
In-reply-to: <20141007095647.GD8057@x2.net.home> (kzak@redhat.com)
Subject: Re: Error in losetup man page
References: <201410031430.s93EUddT014847@hobgoblin.ariadne.com> <20141007095647.GD8057@x2.net.home>
List-ID: <util-linux.vger.kernel.org>

> From: Karel Zak <kzak@redhat.com>
> 
> On Fri, Oct 03, 2014 at 10:30:39AM -0400, Dale R. Worley wrote:
> > On Fedora 19, the man page for losetup says:
> > 
> >        Delete all used loop devices:
> > 
> >             losetup -D
> > 
> > That should be "Delete all *unused* loop devices:", I'm sure.
> 
> "used" means loop devices that have backing file, I have replaced the
> text with "Detach all associated loop devices:"

Does it detach loop devices that are associated and also mounted or
otherwise opened?  My test case does not attempt to do that.

So the criterion is that the loop device has to be "used" in the sense
of being associated but "not used" in the sense of being open.  Maybe
"Delete all associated loop devices that are not opened"?  (Mounting
is known to be a variety of opening.)

Dale
