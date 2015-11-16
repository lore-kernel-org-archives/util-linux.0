Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:55774 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752642AbbKPC0o (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 15 Nov 2015 21:26:44 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1Zy9VB-0005Ml-MV
	for util-linux@vger.kernel.org; Mon, 16 Nov 2015 03:26:41 +0100
Received: from ip4d14b390.dynamic.kabel-deutschland.de ([77.20.179.144])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 16 Nov 2015 03:26:41 +0100
Received: from for-gmane by ip4d14b390.dynamic.kabel-deutschland.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 16 Nov 2015 03:26:41 +0100
To: util-linux@vger.kernel.org
From: "U.Mutlu" <for-gmane@mutluit.com>
Subject: unshare -m should not be a privileged option
Date: Mon, 16 Nov 2015 03:26:33 +0100
Message-ID: <n2besp$j56$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I'm proposing that "unshare -m" should not be a privileged option,
because in practice it is IMO used like this:

unshare -m /bin/bash
now user can do his mounts (mostly via sudo)

The user should need the root permission (or CAP_ADMIN or whatever
caps it needs) only for the mount and unmount cmds, but not for "unshare -m".

Therefore the -m option (and maybe even most of the other options) of unshare
should be made to work for users, without needing root permission.

Maybe even better would be to define the users in a new conf file 
/etc/unshare.conf or so.

The other solution via user namespace is IMHO overkill and in my case 
impractical and irritating because user gets a root-prompt (#)
eventhough it is only inside the user namespace.

I like "unshare -m", but it should work also for unprivileged users without 
needing sudo.

As said in previous postings of mine: "chmod u+s unshare" does what I need,
but I don't know if that solution will continue working in newer versions.

...just my .02 cents from the field as admin and user

