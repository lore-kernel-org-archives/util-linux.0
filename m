Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta15.westchester.pa.mail.comcast.net ([76.96.59.228]:58721
	"EHLO qmta15.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751545AbaCGXWh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 7 Mar 2014 18:22:37 -0500
Date: Fri, 7 Mar 2014 18:22:33 -0500
Message-Id: <201403072322.s27NMX6A018323@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Stuart T Rogers <stuart@stella-maris.org.uk>
CC: util-linux@vger.kernel.org
In-reply-to: <52EAAA43.8030509@stella-maris.org.uk>
	(stuart@stella-maris.org.uk)
Subject: Re: Possible problem mounting Video DVD
References: <52E7EBBC.4070009@stella-maris.org.uk> <201401282126.s0SLQFZK011980@hobgoblin.ariadne.com> <52E836E0.70900@stella-maris.org.uk> <201401292054.s0TKsrph021368@hobgoblin.ariadne.com> <52E98342.8070103@stella-maris.org.uk> <201401301906.s0UJ60YL023456@hobgoblin.ariadne.com> <52EAAA43.8030509@stella-maris.org.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Stuart T Rogers <stuart@stella-maris.org.uk>

> Thanks for that explanation. The only thing regarding the DVD_RECORDER 
> directory is that it does not exist until the DVD is mounted so whoever 
> creates it sets the permissions. The name DVD_RECORDER is the volume 
> name of the DVD. I'm not sure how the DVD can itself have permissions 
> attributed to it though.

One thing you can try for diagnosis is this:  Insert the DVD and wait
for it to show up in File Manager.  Then go to a shell and run "df".
That command lists *all* of the file systems that are rightly and
properly mounted.  Most likely, /run/media/stuart/DVD_RECORDER will
show up as a mount point, showing that your DVD *actually is*
mounted.  Which starts to narrow down where things could be going
wrong.

Then run "mount".  That dumps a lot of information about the options
that were used during the mount operation.  In particular, the word
after "type" in the relevant line is the type of file system, and the
stuff in parentheses is the options.  You can go to the mount manual
page and look up the options to see if one of the options is buggering
how the DVD is mounted.

You can also do "ls -al /run/media/stuart/DVD_RECORDER", which will
show what the permissions are of the DVD_RECORDER directory and also
the subdirectories within it.  (Under normal conditions, those should
be the same.)

This will give you some info to help figure out what's messing up:
the program creating DVD_RECORDER, the mount command that is getting
executed, the mount program itself, or the kernel filesystem code.

Dale
