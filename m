Return-Path: util-linux-owner@vger.kernel.org
Received: from imap.thunk.org ([74.207.234.97]:56042 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751015AbaGJO22 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Jul 2014 10:28:28 -0400
Date: Thu, 10 Jul 2014 10:28:24 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: util-linux@vger.kernel.org
Subject: Supporting human parsable journal_dev specifiers
Message-ID: <20140710142824.GA20753@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I have a user request that mount be able to interpret the device
specifier for the journal_dev mount option, so that instead of having
to type something like

   mount -o journal_dev=0x0803 ....

they could unstead use: "journal_dev=/dev/sda3" or even
"journal_dev=LABEL=ext_journal".  I assume the right way to do this is
a mount helper?  Or is this something that you would be willing to
accept as a patch into util-linux?

If it is a mount helper, what's the best way to do things?  Simply
parse through the mount options until finding the journal_dev one, and
then calling blkid or stat as necessary to interpret the argument, and
then re-exec mount with the modified mount option?  Or is there some
gotchas involved with doing this?

Thanks,

						- Ted
