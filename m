Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.171]:60350 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486Ab2G0Kkk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Jul 2012 06:40:40 -0400
Message-ID: <50127025.9060201@bernhard-voelker.de>
Date: Fri, 27 Jul 2012 12:40:37 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: umount for deleted backing file?
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi *,

shouldn't umount also work for a deleted backing file?

# rm -v /media/sdb5/berny/git/util-linux/tests/output/mount/regfile.img
removed `/media/sdb5/berny/git/util-linux/tests/output/mount/regfile.img'

$ mount | grep regfile
/media/sdb5/berny/git/util-linux/tests/output/mount/regfile.img (deleted) on
/media/sdb5/berny/git/util-linux/tests/output/mount/regfile-mnt type ext3
(rw,relatime,errors=continue,barrier=1,data=ordered)

$ ../umount -v /media/sdb5/berny/git/util-linux/tests/output/mount/regfile.img
umount: /media/sdb5/berny/git/util-linux/tests/output/mount/regfile.img: not found

Have a nice day,
Berny
