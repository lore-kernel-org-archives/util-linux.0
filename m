Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59260 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336AbaJ1Hc0 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 28 Oct 2014 03:32:26 -0400
Date: Tue, 28 Oct 2014 08:32:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Felix Miata <mrmazda@earthlink.net>
Cc: dE <de.techno@gmail.com>, util-linux@vger.kernel.org
Subject: Re: fdisk and 2048 sectors obsession.
Message-ID: <20141028073208.GH10134@x2.net.home>
References: <544E923E.6050406@gmail.com>
 <544E97ED.7040406@earthlink.net>
 <544F0C88.1080807@gmail.com>
 <544F13CD.8000502@earthlink.net>
 <544F1BF2.3040203@gmail.com>
 <544F2F5A.5090608@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <544F2F5A.5090608@earthlink.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Oct 28, 2014 at 01:53:30AM -0400, Felix Miata wrote:
> dE composed on 2014-10-28 10:00 (UTC+0530):
> 
> > But I also think this fdisk 2048 behavior should be removed now or at 
> > least provide a switch for the same and document this in the man page.
> 
> There is a switch:
> 
> 	-c , --compatibility[=mode]

 Please, don't use this option. You can move the first sector of the
 first partition in expert menu by command 'b'.

> The man page does fail to explain what dos mode actually means.

 - start at sector 63
 - care about CHS in partition table
 - extra checks for alignment to be compatible with CHS addressing

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
