Return-Path: util-linux-owner@vger.kernel.org
Received: from DMZ-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.35]:65207 "EHLO
	dmz-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964915Ab1GMLOE (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 13 Jul 2011 07:14:04 -0400
Subject: Re: `fsck -A` and fs-specific options
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Theodore Tso <tytso@MIT.EDU>
In-Reply-To: <20110713083214.GA3486@nb.net.home>
Date: Wed, 13 Jul 2011 07:13:59 -0400
Cc: Mike Frysinger <vapier@gentoo.org>, util-linux@vger.kernel.org,
        David Zeuthen <davidz@redhat.com>
Message-Id: <77711669-CC94-41FB-900B-1D31AEA682F7@MIT.EDU>
References: <201107112259.55340.vapier@gentoo.org> <9CD6ADB9-F3AD-47EE-BF7E-251D86B7B305@mit.edu> <20110713083214.GA3486@nb.net.home>
To: Karel Zak <kzak@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


On Jul 13, 2011, at 4:32 AM, Karel Zak wrote:

> Good point. There is demand for a generic API to assemble block
> devices (dm-crypt, MD, LVM, loopdev, ...). This functionality has
> been requested by desktop guys, dracut, udev and it seems also
> attractive for mount and fsck. I'll probably start to work on this
> task at the end of this year (I hope with DM guys).
> 
> My goal is to provide only library and command line interface, so the
> library will be usable everywhere (for example also in some D-BUS
> daemon, dracut, etc.) 

For many cases it might also be useful to have some way of specfying
that some of these block devices should be automatically specified at
at boot time, and supply an init script that sets up certain block devices
before the fsckall script is run?

What might also be cool is some way of specifying that certain block
devices should only be created after the user logs on, and then there
would be a PAM module that would take care of using the user's
login password and passing it to LUKS.

Some of thise might be done in plugins, and not your core library,
but I think these are two important use cases to keep in mind.

-- Ted


