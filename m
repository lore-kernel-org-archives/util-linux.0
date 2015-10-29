Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:49649 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751491AbbJ2Kff (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 29 Oct 2015 06:35:35 -0400
Date: Thu, 29 Oct 2015 11:35:32 +0100
From: Karel Zak <kzak@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: util-linux@vger.kernel.org, Lennart Poettering <lennart@poettering.net>
Subject: Re: regression in logger output to syslog
Message-ID: <20151029103532.GC19508@ws.net.home>
References: <20151009082541.GA9068@aepfle.de>
 <20151012104414.GF2356@ws.net.home>
 <20151012133451.GA6825@aepfle.de>
 <20151021093743.GA6552@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151021093743.GA6552@aepfle.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 21, 2015 at 11:37:43AM +0200, Olaf Hering wrote:
> On Mon, Oct 12, Olaf Hering wrote:
> 
> > So, its "systemd" who eats the required info.
> 
> In case you miss it:
> 
> ...
> We do not allow faking syslog PID fields, for security reasons, it
> will always be set to what the kernel passed to journald.
> 
> If this is something to support, then "logger" needs to to be patched so
> that it can fake the SCM_CREDENTIALS metadata of the messages sent.
> This requires privileges, but is not hard to do. Please file a bug
> against util-linux and ask for for this to be added.

 Implemented, try logger(1) from util-linux git tree, please. 
 
 Thanks!

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
