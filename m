Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:32909 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756769Ab3HNIeK (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Aug 2013 04:34:10 -0400
Message-Id: <1376469249.6044.9623767.55648398@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
In-Reply-To: <520A9016.8040208@bernhard-voelker.de>
References: <1376406563-24198-1-git-send-email-mail@bernhard-voelker.de>
 <1376408542.14036.9332767.314B2850@webmail.messagingengine.com>
 <520A9016.8040208@bernhard-voelker.de>
Subject: Re: [PATCH] last: mention optional arguments in usage
Date: Wed, 14 Aug 2013 10:34:09 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Aug 13, 2013, at 21:59, Bernhard Voelker wrote:
> On 08/13/2013 05:42 PM, Benno Schulenberg wrote:
> > Better use angular-brackets convention right away: "[<name>...]".
> 
> Correct. I just did it as in the man page, therefore that
> one should also be fixed.

No, man pages do not use angular brackets, they use instead
italics for arguments.

> However, I'm not that happy with it anyway, because <name> can
> either be a username or a terminal name, e.g. 'last root tty0',
> and '<name>' does not describe that too well.

Yes, I thought of that too, moments after sending the mail.  :)

> Any idea - besides falling back to the old '[<username>..] [tty..]'
> (which isn't too bad IMO)?

"<username>" and ".RI [ username ...]" would be fine.

Benno

-- 
http://www.fastmail.fm - The professional email service

