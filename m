Return-Path: util-linux-owner@vger.kernel.org
Received: from qmta07.westchester.pa.mail.comcast.net ([76.96.62.64]:58998
	"EHLO qmta07.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752031AbaIATgH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Sep 2014 15:36:07 -0400
Date: Mon, 1 Sep 2014 15:36:04 -0400
Message-Id: <201409011936.s81Ja4ov004057@hobgoblin.ariadne.com>
From: worley@alum.mit.edu (Dale R. Worley)
To: jb <jb.1234abcd@gmail.com>
CC: util-linux@vger.kernel.org
In-reply-to: <loom.20140901T194119-339@post.gmane.org> (jb.1234abcd@gmail.com)
Subject: Re: mount errors on /dev/sr0 (cd-rw)
References: <loom.20140901T194119-339@post.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

> From: jb <jb.1234abcd@gmail.com>

> # mount -t auto /dev/sr0 /media/
> mount: /dev/sr0 is write-protected, mounting read-only
> mount: /dev/sr0: can't read superblock
> #

What condition was the CD in when you inserted it into the drive?
(You haven't told us the full sequence of actions you've taken, only
listed the output of some programs.)

Dale
