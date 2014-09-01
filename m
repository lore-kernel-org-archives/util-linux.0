Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:47315 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751952AbaIAUFr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Sep 2014 16:05:47 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1XOXrC-0005xt-Lc
	for util-linux@vger.kernel.org; Mon, 01 Sep 2014 22:05:44 +0200
Received: from 79-139-19-75.prenet.pl ([79.139.19.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 01 Sep 2014 22:05:42 +0200
Received: from jb.1234abcd by 79-139-19-75.prenet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 01 Sep 2014 22:05:42 +0200
To: util-linux@vger.kernel.org
From: jb <jb.1234abcd@gmail.com>
Subject: Re: mount errors on /dev/sr0 (cd-rw)
Date: Mon, 1 Sep 2014 20:05:23 +0000 (UTC)
Message-ID: <loom.20140901T215808-781@post.gmane.org>
References: <loom.20140901T194119-339@post.gmane.org> <201409011936.s81Ja4ov004057@hobgoblin.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Dale R. Worley <worley@...> writes:

> 
> > From: jb <jb.1234abcd@...>
> 
> > # mount -t auto /dev/sr0 /media/
> > mount: /dev/sr0 is write-protected, mounting read-only
> > mount: /dev/sr0: can't read superblock
> > #
> 
> What condition was the CD in when you inserted it into the drive?
> (You haven't told us the full sequence of actions you've taken, only
> listed the output of some programs.)
> 
> Dale

I just realized that wodim fooled me (it burned cd-rw without any indication
of a problem, but actually the cd-rw is useless - there are multiple bug
reports for wodim).

jb


