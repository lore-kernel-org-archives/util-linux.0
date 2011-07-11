Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52990 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756080Ab1GKMSl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Jul 2011 08:18:41 -0400
Date: Mon, 11 Jul 2011 14:18:36 +0200
From: Karel Zak <kzak@redhat.com>
To: Daniel Drake <dsd@laptop.org>
Cc: util-linux@vger.kernel.org, pgf@laptop.org, dmitry.torokhov@gmail.com,
        Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: [PATCH] evstate: new utility for querying evdev
	key/switch/event state
Message-ID: <20110711121836.GJ5214@nb.net.home>
References: <20110709132046.90A119D401C@zog.reactivated.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110709132046.90A119D401C@zog.reactivated.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Jul 09, 2011 at 02:20:46PM +0100, Daniel Drake wrote:
> evstate is a small utility that queries evdev state of a specific
> key, switch, button, LED or sound event. This is useful in programs
> such as powerd (http://wiki.laptop.org/go/Powerd) which need to query
> things like the state of the laptop lid switch from shell code.
> 
> Our earlier non-upstream approach to this was to add sysfs nodes that
> would indicate button state, but Dmitry Torokhov is against seeing those
> in the upstream kernel as it is duplicating info from the input layer:

Sounds too crazy...

The duplication is normal (see for example block devices). There is
many places where we have the same information accessible by ioctl()
as well as by sysfs.

The sysfs is usually the preferred way, because it does not require root
permissions to read the attributes and you can use standard file/text
utils rather than any specialized ioctl wrappers.

> http://article.gmane.org/gmane.linux.drivers.platform.x86.devel/1089

Wow, so you have already implemented a patch that exports the state
in *human readable format* by sysfs. This patch was NACKed.

Now it's expected that everyone in userspace will use ioctl() (with
root permissions?) and translate any crazy bit array to something
human readable. Right? Really?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
