Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25420 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015Ab3HWKCl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 23 Aug 2013 06:02:41 -0400
Date: Fri, 23 Aug 2013 12:02:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] last: mention optional arguments in usage
Message-ID: <20130823100234.GA32136@x2.net.home>
References: <1376406563-24198-1-git-send-email-mail@bernhard-voelker.de>
 <1376408542.14036.9332767.314B2850@webmail.messagingengine.com>
 <520A9016.8040208@bernhard-voelker.de>
 <1376469249.6044.9623767.55648398@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1376469249.6044.9623767.55648398@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 14, 2013 at 10:34:09AM +0200, Benno Schulenberg wrote:
> On Tue, Aug 13, 2013, at 21:59, Bernhard Voelker wrote:
> > On 08/13/2013 05:42 PM, Benno Schulenberg wrote:
> > > Better use angular-brackets convention right away: "[<name>...]".
> > 
> > Correct. I just did it as in the man page, therefore that
> > one should also be fixed.
> 
> No, man pages do not use angular brackets, they use instead
> italics for arguments.
> 
> > However, I'm not that happy with it anyway, because <name> can
> > either be a username or a terminal name, e.g. 'last root tty0',
> > and '<name>' does not describe that too well.
> 
> Yes, I thought of that too, moments after sending the mail.  :)
> 
> > Any idea - besides falling back to the old '[<username>..] [tty..]'
> > (which isn't too bad IMO)?
> 
> "<username>" and ".RI [ username ...]" would be fine.

 Fixed (in .c and .1), Thanks Bernhard!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
