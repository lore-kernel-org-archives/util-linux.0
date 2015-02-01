Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34443 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605AbbBAOCJ convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 1 Feb 2015 09:02:09 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 6C864209B5
	for <util-linux@vger.kernel.org>; Sun,  1 Feb 2015 09:02:06 -0500 (EST)
Message-Id: <1422799326.1853638.221575473.7DCCA1B0@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: cfdisk's input fields behave awkwardly (in utf8 locale)
Date: Sun, 01 Feb 2015 15:02:06 +0100
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi,

In the current cfdisk, when making a new partition in a free space,
the program prompts for the partition size, with a suggested value
already filled in and the cursor sitting at the end of that value.

If one tries to use the cursor-left key to edit the value, in a utf8
locale this produces the character Ą instead of a bell.  (The same
happens when cfdisk asks for the name of a script file.)

To reproduce:  # LC_ALL=en_US.utf8 ./cfdisk

Anyway, if the cursor keys would not produce weird characters,
and they can't be made to work normally (that is: to go left and
right), then the only way to change the suggested value is to use
the Backspace key.  This is awkward.  The older cfdisk, when it
prompted for a partition size, would put the cursor at the start
of the suggested value, and hitting any other key than Enter
would erase this value. That is nice and desirable behaviour.
Could that be restored?


Also, upon startup the old cfdisk would put the cursor on the
menu item "Quit", showing the user the most important thing
right at the start: how to get out.  This is extra useful when
cfdisk is localized to another language where the word for quit
doesn't start with a Q.  Could this initial menu-item selection
be restored?


Something quite different: the man page of cfdisk says that it
is possible to load an sfdisk-compatible script into cfdisk.
But how?


Benno

-- 
http://www.fastmail.com - Accessible with your email software
                          or over the web

