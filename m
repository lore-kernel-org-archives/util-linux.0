Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:54500 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753091Ab2FEPsF (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 5 Jun 2012 11:48:05 -0400
Date: Tue, 5 Jun 2012 17:48:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux-ng@vger.kernel.org
Subject: Re: make install: some SUID-root programs?
Message-ID: <20120605154801.GB3882@x2.net.home>
References: <318289300.205241.1338909469539.JavaMail.open-xchange@email.1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <318289300.205241.1338909469539.JavaMail.open-xchange@email.1und1.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jun 05, 2012 at 05:17:49PM +0200, Bernhard Voelker wrote:
>  Today, only write and wall seem to get SUID/SGID privileges during
> "make install". What about others?

 mount, umount

> E.g. login and su would deserve

 - for login(1) is it unnecessary, it's executed by getty ant it runs
   with root perms.

 - for su(1) is it necessary, fixed. Thanks ;-)

> to be `chmod u+s`-ed, right?
> Or is this a task of the distributions?

It's definitely better if distributions somehow control all the stuff
from upstreams -- blindly use result from "make install" is a bad idea.
For example in rpm is special %files section for this purpose.

Trust, but verify :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
