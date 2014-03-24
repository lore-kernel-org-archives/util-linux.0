Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:46112 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751067AbaCXWo3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 24 Mar 2014 18:44:29 -0400
Received: from localhost (unknown [100.42.98.7])
	(using SSLv3 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: chutzpah)
	by smtp.gentoo.org (Postfix) with ESMTPSA id BF24D33FAAD
	for <util-linux@vger.kernel.org>; Mon, 24 Mar 2014 22:44:28 +0000 (UTC)
Date: Mon, 24 Mar 2014 15:44:26 -0700
From: Patrick McLean <chutzpah@gentoo.org>
To: util-linux@vger.kernel.org
Subject: mount: "nofail" option does not seem to work as expected
Message-ID: <20140324154426.0e5d2781@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

First the "nofail" doesn't actually prevent "failure" when using "mount
-a". If any filesystem fails to mount with mount -a due to the device
not existing, even if "nofail" is specified in the mount, mount will
exit with a status of 32. I would expect that "nofail" would imply that
such failures would cause the exit status to be 0.

Also, it seems that the "nofail" mount option does not work at all when
using the tag-style partition identifiers rather than udev symlinks.

Using this line in fstab:
UUID=nonexist /mnt/nonexist1 ext4 nofail 0 1

Will produce an error message:
# mount -av
mount: can't find UUID=nonexist
#

Where this line:
/dev/disk/by-uuid/nonexist /mnt/nonexist ext4 nofail 0 1

Does not produce any error:
# mount -av
#
