Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta03.westchester.pa.mail.comcast.net ([76.96.62.32]:41326
	"EHLO qmta03.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751974AbaA2Uy4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 29 Jan 2014 15:54:56 -0500
Date: Wed, 29 Jan 2014 15:54:53 -0500
Message-Id: <201401292054.s0TKsrph021368@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: Stuart T Rogers <stuart@stella-maris.org.uk>
CC: util-linux@vger.kernel.org
In-reply-to: <52E836E0.70900@stella-maris.org.uk> (stuart@stella-maris.org.uk)
Subject: Re: Possible problem mounting Video DVD
References: <52E7EBBC.4070009@stella-maris.org.uk> <201401282126.s0SLQFZK011980@hobgoblin.ariadne.com> <52E836E0.70900@stella-maris.org.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: Stuart T Rogers <stuart@stella-maris.org.uk>

> Sorry I did not make myself completely clear, these disks mount with the 
> wrong permissions, my user in this case uid 1000 has no access to the 
> directory structure of the DVD, either a filemanager or cd in a console 
> gets permission denied. All other DVDs I create from other recorders 
> will mount with uid 1000 having read access to the directory structure.

Can you provide the exact mount command that you are using, an "ls
-al" showing what user/group/permissions the files *are* showing up
as, etc.?  There's a tremendous amount of information that you're not
telling us, and even if I had your DVD and your computer in hand, I
couldn't begin to verify that I'm seeing the same problem you are
having.

"How to Report Bugs Effectively"
http://www.chiark.greenend.org.uk/~sgtatham/bugs.html

Dale
