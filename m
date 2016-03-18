Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:53263 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751361AbcCRC0k (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 22:26:40 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1agk7a-0002RT-4Z
	for util-linux@vger.kernel.org; Fri, 18 Mar 2016 03:26:38 +0100
Received: from ppp37-190-56-84.pppoe.spdop.ru ([37.190.56.84])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 18 Mar 2016 03:26:38 +0100
Received: from yumkam by ppp37-190-56-84.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Fri, 18 Mar 2016 03:26:38 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: unshare -m and mount propagation
Date: Fri, 18 Mar 2016 05:26:25 +0300
Message-ID: <m3oaacfrn2.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

1. User-ns, mount-ns and mount propagation.

When you create mount-ns in user-ns (or both at once), kernel
automatically breaks mount propagation from guest to host (in other
words, `forcibly downgrade "shared" mounts to "slave"`), due to obvious
security consideration (if your mount in user-ns guest will propagate
back to host, it will be disaster).

E.g. try
   unshare -r -m --prop unchanged findmnt -no TARGET,PROPAGATION|head -1
or
   unshare -r unshare --prop unchanged findmnt -no TARGET,PROPAGATION|head -1
(both will show "/ private,slave", even though unshare(1) have not tried
to change propagation flags).

Note that once propagation is broken, you cannot go back. E.g.
  unshare -r -m --propagation shared -- findmnt -no TARGET,PROPAGATION|head -1
or (basically same)
  unshare -r -m --propagation unchanged sh -c 'mount --make-rshared /;
    findmnt -no TARGET,PROPAGATION|head -1'
will results in "/ shared,slave"; that is, propagation from guest to
host is disabled, but propagation within guest is enabled.

2. Long-lived mount-ns and dangers of `--propagation private` (default in
recent util-linux).

`--propagation private` breaks unmount propagation from "host" to
"guest", so if you mount e.g. removable media in host, unshare mount
namespace and spawn long-lived process, then umount your media
in host namespace, it still remains mounted in guest namespace, and keep
device busy:

  mount /media/cdrom
  unshare -rm --prop private sleep inf &
  pid=$!
  eject /media/cdrom # oops, still locked
  grep /media/cdrom /proc/self/mounts
  (empty)
  sudo nsenter -t $pid -m grep /media/cdrom /proc/self/mounts
  # ... as it is still mounted there

If device locks mounted media (e.g. cdrom), this can be confusing to
user ("why eject does not work? I umounted it, fuser/lsof shows nothing???").

If device does not lock mounted media, and user forcibly ejects media
(e.g. cardreader or usb drive), this can result in data loss (filesystem
is not properly umounted, there can be unsynced data in cache).

`--propagation slave` does not have this problem (when host unmount
/cdrom, it is also unmounted in guest):

  mount /media/cdrom
  unshare -rm --prop slave sleep inf &
  pid=$!
  umount /media/cdrom # or eject /media/cdrom
  sudo nsenter -t $pid -m grep /media/cdrom /proc/self/mounts
(empty)

Also, once you (completely) broke propagation by `--propagation private`
[as implied by default in current util-linux], you cannot go back. E.g.

  unshare -rm sh -c 'findmnt -no TARGET,PROPAGATION|head -1;
  mount --make-rslave /;
  findmnt -no TARGET,PROPAGATION|head -1'

/ private
/ private

I think this issue should be at least documented. And, maybe, default
`--propagation` should be changed to `slave`.

=====================================================================

P.S. I'd like to note that this thing has some abuse potential. Above
scenarios suggest *accidental* case when `unshare -rm --prop private \
sleep inf &` can trigger data loss. But someone can *intentionally* try
to choose moment when it triggers most disruption to other users (and
root) work. This also affects fs/devices they cannot access (and thus
cannot normally block by chdir or opening file; besides, chdir or open
file is visible in lsof/fuser, stray sleep-in-namespace is not).

(Of course, this possible abuse is *not* a util-linux problem [and
cannot be solved within util-linux]; this is a *kernel* problem)

P.P.S. as I dig into user-ns, I'm more and more happy our debian
overlords disabled unprivileged userns by default. And lately I feel
they should've disabled it completely :-| It's a way too prone to abuse.

