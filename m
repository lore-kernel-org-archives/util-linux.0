Return-Path: util-linux-owner@vger.kernel.org
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:56413 "EHLO
	out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753477AbaGNJ5q (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 05:57:46 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E9BD420AF9
	for <util-linux@vger.kernel.org>; Mon, 14 Jul 2014 05:57:44 -0400 (EDT)
Message-Id: <1405331864.10850.141333833.2F92BBFD@webmail.messagingengine.com>
From: Benno Schulenberg <bensberg@justemail.net>
To: "Util-Linux" <util-linux@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: mount: what is the point of 'nouser' on the command line?
Date: Mon, 14 Jul 2014 11:57:44 +0200
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Hi all,

The man page of mount(8) currently contains the following example
to show how the -o option can be used:

    mount LABEL=mydisk -o noatime,nouser

As the command does not contain a mountpoint, it requires an entry
in fstab in order to work.  If that entry does not contain the keyword
'user' in the options field, then the mount will effectively already be
'nouser'.  If it does contain the keyword 'user', does specifying 'nouser'
then somehow exclude other users?  As far as I can tell it doesn't.

So, is it ever useful to specify '-o nouser' on the command line?


Something else.  On the man page of umount, shouldn't it say that
the -O and -t options are only effective in combination with -a?

Further, mount recognizes the options -L and -U besides the keywords
LABEL= and UUID=, but umount only recognizes the latter two.  For
symmetry it would be nice if umount also recognized -L and -U.

Benno

-- 
http://www.fastmail.fm - Access your email from home and the web

