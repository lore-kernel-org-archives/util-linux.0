Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46050 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032AbbBJMUb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 10 Feb 2015 07:20:31 -0500
Date: Tue, 10 Feb 2015 13:20:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: more nits in cfdisk
Message-ID: <20150210122026.GA11158@ws.net.home>
References: <1423426808.1949360.224667813.2ED36110@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1423426808.1949360.224667813.2ED36110@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 08, 2015 at 09:20:08PM +0100, Benno Schulenberg wrote:
> "Device does not contain a recognized partition table."
> This is most likely not an accurate message in this situation,
> so an upcoming patch suggests to differentiate between an
> invocation with --zero and a normal invocation.
> 
> A second patch will suggest to also accept a lowercase 'l'
> for loading a script file.  The Load command isn't dangerous,
> as is the Write command, so there is no need to make it
> somewhat more difficult to enter.

 Applied, thanks.

> When cfdisk prompts for a script file name, the line that says
> "Select a type..." should probably be cleared.  And maybe also
> the menu of label types?

 Improved.


> When the user enters a wrong name or some other error occurs,
> probably the line that says "The script file will be applied..."
> should be cleared.

 Improved.

> When starting cfdisk with --zero and choosing the sun label type,
> a bottombar message says: "Note that partition table entries are
> not in disk order now."  The menu item "Sort" is present, but
> using it has no effect.  Probably things have to be this way and
> the message shouldn't be given for a Sun label?

 Yes, fixed. (Note that Sun/SGI/BSD are not well tested with cfdisk.)


 I'm going to check/fix the rest from your list tomorrow. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
