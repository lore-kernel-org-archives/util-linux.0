Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:26749 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755870AbaGNO6F (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 Jul 2014 10:58:05 -0400
Date: Mon, 14 Jul 2014 16:57:59 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: mount: what is the point of 'nouser' on the command line?
Message-ID: <20140714145759.GM30288@x2.net.home>
References: <1405331864.10850.141333833.2F92BBFD@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1405331864.10850.141333833.2F92BBFD@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jul 14, 2014 at 11:57:44AM +0200, Benno Schulenberg wrote:
> 
> The man page of mount(8) currently contains the following example
> to show how the -o option can be used:
> 
>     mount LABEL=mydisk -o noatime,nouser
> 
> As the command does not contain a mountpoint, it requires an entry
> in fstab in order to work.  If that entry does not contain the keyword
> 'user' in the options field, then the mount will effectively already be
> 'nouser'.  If it does contain the keyword 'user', does specifying 'nouser'
> then somehow exclude other users?  As far as I can tell it doesn't.

 It does not exclude others users. The idea of the "no*" options is 
 disable previously applied flags. The options from command line are
 evaluated after options from fstab, so for example "foo,bar" (fstab)
 and "nofoo" (command line)  means that "nofoo" negate the previous "foo".

 The "user" option is alias to "noexec,nosuid,nodev" mount flags. 
 
 I'm  not sure why, but "nouser" has never been implemented. So it does not
 have any effect and "user" from fstab is still applied -- maybe to
 avoid possible security bugs or so.

> So, is it ever useful to specify '-o nouser' on the command line?

 No, it would be better to remove it from the example and add to the
 man page note that "nouser" has no any effect and you have to 
 explicitly use "exec,suid,dev" to negate.

> Something else.  On the man page of umount, shouldn't it say that
> the -O and -t options are only effective in combination with -a?

 The -t is generic and it's usable in more case (for example to
 specify filesystem that should be tried for the device).

 The -O is really usable for -a only.

> Further, mount recognizes the options -L and -U besides the keywords
> LABEL= and UUID=, but umount only recognizes the latter two.  For
> symmetry it would be nice if umount also recognized -L and -U.

 I think -L and -U are mistakes maintained for backward compatibility,
 because TAG=value is more generic and extendable syntax. For example
 now we also supports PARTUUID= and PARTLABEL=.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
