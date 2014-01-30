Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta01.westchester.pa.mail.comcast.net ([76.96.62.16]:52101
	"EHLO qmta01.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753137AbaA3TGG (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 30 Jan 2014 14:06:06 -0500
Date: Thu, 30 Jan 2014 14:06:00 -0500
Message-Id: <201401301906.s0UJ60YL023456@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Stuart T Rogers <stuart@stella-maris.org.uk>
CC: util-linux@vger.kernel.org
In-reply-to: <52E98342.8070103@stella-maris.org.uk>
	(stuart@stella-maris.org.uk)
Subject: Re: Possible problem mounting Video DVD
References: <52E7EBBC.4070009@stella-maris.org.uk> <201401282126.s0SLQFZK011980@hobgoblin.ariadne.com> <52E836E0.70900@stella-maris.org.uk> <201401292054.s0TKsrph021368@hobgoblin.ariadne.com> <52E98342.8070103@stella-maris.org.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Stuart T Rogers <stuart@stella-maris.org.uk>

> OK let me explain, I am not issuing any mount commands myself. I place 
> the DVD in the drive and close it, wait until it appears in the device 
> notifier and select action Open in File Manager, when it opens having 
> been mounted by the system at run/media/stuart/DVD_RECORDER the response 
> from Dolphin is that the permissions wont allow me to open the root 
> directory of the drive for browsing. If I try to play the video using 
> Dragon etc again this works OK the permissions it is mounted with do not 
> stop that action.

In regard to *playing* the videos, it's possible that the players
don't mount the DVD as a file system at all, so the fact that they
work isn't particularly informative.

http://forums.fedoraforum.org/showthread.php?t=296874

It looks like Skull One in that thread has the best explanation.  I'm
not familiar with the details of mounting DVDs, but he suggests that
the directories /run/media/stuart/DVD_VIDEO_RECORDER and
/run/media/stuart/LG_VDR *on your disk* may have different
permissions, and those permissions leak into the permissions seen when
a DVD is mounted there.  So what are the permissions on those
directories (when no DVD is mounted)?

In any case, it's unlikely to be a problem that this mailing list
deals with.  We only handle the mount executable.  One possibility is
that the DVD mount and processing code in the kernel is providing
unreasonable permission values (after all, it synthesizes them), in
which case the fix is a kernel change.  Another possibility is that
adjusting the permissions of /run/media/stuart/DVD_VIDEO_RECORDER will
make the problem go away, in which case it can reasonably be
considered to be a configuration error.  It's also possible that
whatever is automounting the DVD isn't being smart enough about the
permissions it is setting up for the DVD file system.  That would be a
problem for the a different mailing list.

Dale
