Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:46835 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755487Ab2IRXIg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 18 Sep 2012 19:08:36 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1TE6u9-0006ZL-86
	for util-linux@vger.kernel.org; Wed, 19 Sep 2012 01:08:33 +0200
Received: from 209.239.228.34 ([209.239.228.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 19 Sep 2012 01:08:33 +0200
Received: from amit.uttam by 209.239.228.34 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Wed, 19 Sep 2012 01:08:33 +0200
To: util-linux@vger.kernel.org
From: Amit <amit.uttam@gmail.com>
Subject: Return status of =?utf-8?b?bW50X2NvbnRleHRfbW91bnQ=?= when helper is used
Date: Tue, 18 Sep 2012 23:08:16 +0000 (UTC)
Message-ID: <loom.20120919T005618-428@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

When trying to mount samba shares using *mnt_context_mount*, the
*mount.cifs* helper is called and used. This allows for automatic
resolving of hostnames.

However, if the hostname is not valid and the resolve fails,
the call *mnt_context_mount* is still successful. Using
*mnt_init_debug*, the mount.cifs helper returns an error code but this
is not propagated to the status of mnt_context_mount or
mnt_context_get_status.

This has been tried with util-linux 2.20.1 and the latest util-linux
from git (as of today).

Is there a way to check the return status of the helper?

START TRACE

mount error: could not resolve address for pmanalo-pc2: Unknown error
libmount:      CXT: [0x811010]: /sbin/mount.cifs executed [status=1]
libmount:      CXT: [0x811010]: don't update: external helper
mount_cifs: mnt_context_mount return code = 0 status = 1
mount_cifs: error:
libmount:      CXT: [0x811010]: <---- reset [status=1] ---->
libmount:    CACHE: [0x811350]: free
libmount:      CXT: [0x811010]: <---- free

END TRACE

Thanks,
Amit

