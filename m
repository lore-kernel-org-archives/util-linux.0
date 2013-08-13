Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:50482 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758545Ab3HMT7U (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 13 Aug 2013 15:59:20 -0400
Message-ID: <520A9016.8040208@bernhard-voelker.de>
Date: Tue, 13 Aug 2013 21:59:18 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Benno Schulenberg <bensberg@justemail.net>
CC: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH] last: mention optional arguments in usage
References: <1376406563-24198-1-git-send-email-mail@bernhard-voelker.de> <1376408542.14036.9332767.314B2850@webmail.messagingengine.com>
In-Reply-To: <1376408542.14036.9332767.314B2850@webmail.messagingengine.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 08/13/2013 05:42 PM, Benno Schulenberg wrote:
> 
> On Tue, Aug 13, 2013, at 17:09, Bernhard Voelker wrote:
>> -		" %s [options]\n"), program_invocation_short_name);
>> +		" %s [options] [name...]\n"), program_invocation_short_name);
> 
> Better use angular-brackets convention right away: "[<name>...]".

Correct. I just did it as in the man page, therefore that
one should also be fixed.

However, I'm not that happy with it anyway, because <name> can
either be a username or a terminal name, e.g. 'last root tty0',
and '<name>' does not describe that too well.

Any idea - besides falling back to the old '[<username>..] [tty..]'
(which isn't too bad IMO)?

Have a nice day,
Berny
