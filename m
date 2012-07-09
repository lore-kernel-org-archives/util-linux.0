Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64324 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559Ab2GIRP6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 Jul 2012 13:15:58 -0400
Received: by qcro28 with SMTP id o28so6856610qcr.19
        for <util-linux@vger.kernel.org>; Mon, 09 Jul 2012 10:15:57 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 9 Jul 2012 19:15:57 +0200
Message-ID: <CABikg9y0q1onOb2vzuxtOJt4QQL+gXR7FzNjHJffxQCJWsL5RQ@mail.gmail.com>
Subject: Buffer overrun in some calls to sscanf
From: Sergei Antonov <saproj@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello!
Take a look at these 7 places where sscanf may write 1 zero byte past
the end of the array.
To fix this either decrease the %N limit or increase array size.

util-linux/libblkid/src/devno.c:

		char name[64];

		if (sscanf(buf, "%d %64[^\n ]", &maj, name) != 2)


util-linux/libblkid/src/devname.c:

	char ptname0[128], ptname1[128], *ptname = 0;
	char *ptnames[2];

...

	int which = 0, last = 0;

...

	ptnames[0] = ptname0;
	ptnames[1] = ptname1;

...

		which ^= 1;
		ptname = ptnames[which];

		if (sscanf(line, " %d %d %llu %128[^\n ]",
			   &ma, &mi, &sz, ptname) != 4)


util-linux/lib/sysfs.c:

	char buf[1024];
	return sysfs_scanf(cxt, attr, "%1024[^\n]", buf) == 1 ?
						strdup(buf) : NULL;


util-linux/lib/loopdev.c:

		char name[128];


		if (sscanf(buf, " %u %*s %*s %128[^\n ]",
			   &m, name) != 2 || m != LOOPDEV_MAJOR)


util-linux/fdisks/sfdisk.c:

    char line[1024], ptname[128];

...

	if (sscanf(line, " %d %d %llu %128[^\n ]", &ma, &mi, &sz, ptname) != 4)


util-linux/fdisks/fdisk.c:

	char line[128], ptname[128], devname[256];

...

		if (sscanf (line, " %d %d %llu %128[^\n ]",
			    &ma, &mi, &sz, ptname) != 4)


util-linux/disk-utils/blockdev.c:

	char ptname[200];

...

		if (sscanf(line, " %d %d %d %200[^\n ]",
			   &ma, &mi, &sz, ptname) != 4)
