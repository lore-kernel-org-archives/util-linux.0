Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:60031 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751543Ab2G0Loz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Jul 2012 07:44:55 -0400
Message-ID: <50127F34.70406@bernhard-voelker.de>
Date: Fri, 27 Jul 2012 13:44:52 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: kerolasa@gmail.com, util-linux@vger.kernel.org
Subject: Re: v2.22-rc2 wish list
References: <20120727081033.GA14019@x2.net.home> <CAG27Bk1mk08N=0Zbo-Bbd_v93C6cfEcO1chYyiDAtRf1sQOEpw@mail.gmail.com> <20120727103132.GA28708@x2.net.home> <501271D2.8090708@bernhard-voelker.de> <20120727111550.GA29738@x2.net.home>
In-Reply-To: <20120727111550.GA29738@x2.net.home>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 07/27/2012 01:15 PM, Karel Zak wrote:
> On Fri, Jul 27, 2012 at 12:47:46PM +0200, Bernhard Voelker wrote:
>> On 07/27/2012 12:31 PM, Karel Zak wrote:
>>>  Maybe, but many of the tests requires root permissions and it's
>>>  designed for developers only. I'd like to avoid situations when the
>>>  tests are executed with root permissions by automatic distro build
>>>  systems etc.
>>
>> Why? The more folks run the tests, the more bugs can be reported and fixed.
>> What's wrong about the tests? And if there's something wrong: shouldn't
>> they not be made more robust?
>>
>> E.g. coreutils also has many tests which "require_root", and I think
>> it's safe to run these tests.
> 
> Does the tests modify /etc/fstab, mount another filesystems and
> initialize scsi_debug, loop and raid devices?

yes, but I don't consider mount/umount as too dangerous - coreutils'
test suite also does it. Some more harmful tests could be guarded by
some special mechanism, e.g. an environment variable.

> I have experience that some distros and end-users rebuild packages
> as superuser.

Building as root is certainly not okay, but prior to packaging UL into a
distro or applying it on a few servers, I expect every admin and
distro maintainer to run 'make check'.

With a proper test suite, we give him/her a basic test to check whether
the software is running as expected in his/her environment. Otherwise,
he doesn't have much chance other than waiting for productive problems.

> I don't want to be responsible for possible problems on
> the target systems.

You aren't:
  $ grep -i warranty COPYING
;-)

Have a nice day,
Berny
