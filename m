Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta13.westchester.pa.mail.comcast.net ([76.96.59.243]:38775
	"EHLO qmta13.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751532AbaB0PbS (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 27 Feb 2014 10:31:18 -0500
Date: Thu, 27 Feb 2014 10:25:07 -0500
Message-Id: <201402271525.s1RFP7Uv021719@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Bernhard Voelker <mail@bernhard-voelker.de>
CC: util-linux@vger.kernel.org
In-reply-to: <530F0972.3040205@bernhard-voelker.de> (mail@bernhard-voelker.de)
Subject: Re: chcpu exit code?
References: <530F0972.3040205@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Bernhard Voelker <mail@bernhard-voelker.de>
> 
> Although the man page does not mention the exit status, I think
> it's wrong that 'chcpu' exits OK when an action failed or
> when a bad CPU number was specified:

> WDYT?

I agree that it would be helpful if chcpu used the usual
success/failure convention for exit status.  The reason is that
sometimes one wants to use "set -e" in a script so that any command
that fails unexpectedly will cause processing to halt.  Similarly, if
one hands a command to a program to execute, a program that is set up
to execute generic commands supplied by some outside source usually
handles non-zero exit status specially by reporting that the command
failed, while treating zero exit statuses as not-to-be-remarked-upon.

Dale
