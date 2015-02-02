Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53379 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbbBBMLb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Feb 2015 07:11:31 -0500
Date: Mon, 2 Feb 2015 13:11:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: cfdisk's input fields behave awkwardly (in utf8 locale)
Message-ID: <20150202121126.GL16162@ws.net.home>
References: <1422799326.1853638.221575473.7DCCA1B0@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1422799326.1853638.221575473.7DCCA1B0@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 01, 2015 at 03:02:06PM +0100, Benno Schulenberg wrote:
> To reproduce:  # LC_ALL=en_US.utf8 ./cfdisk
> 
> Anyway, if the cursor keys would not produce weird characters,
> and they can't be made to work normally (that is: to go left and
> right), then the only way to change the suggested value is to use
> the Backspace key.  This is awkward.  The older cfdisk, when it

 "Fixed" .. I just disable some keys (like left, right...).

> prompted for a partition size, would put the cursor at the start
> of the suggested value, and hitting any other key than Enter
> would erase this value. That is nice and desirable behaviour.
> Could that be restored?

 It would be better to implement full one line editor with support for
 all basic keys and with ability to insert and erase chars on
 arbitrary position with in the string... v2.27 :-)

> Also, upon startup the old cfdisk would put the cursor on the
> menu item "Quit", showing the user the most important thing
> right at the start: how to get out.  This is extra useful when
> cfdisk is localized to another language where the word for quit
> doesn't start with a Q.  Could this initial menu-item selection
> be restored?

 Fixed.

> Something quite different: the man page of cfdisk says that it
> is possible to load an sfdisk-compatible script into cfdisk.
> But how?

 "cfdisk --zero" asks for new disk label or for the script.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
