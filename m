Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34877 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753747AbbDPLGd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 16 Apr 2015 07:06:33 -0400
Received: by pdbqd1 with SMTP id qd1so88335729pdb.2
        for <util-linux@vger.kernel.org>; Thu, 16 Apr 2015 04:06:33 -0700 (PDT)
Received: from Sihnon (c-71-238-70-108.hsd1.or.comcast.net. [71.238.70.108])
        by mx.google.com with ESMTPSA id np6sm6818309pdb.80.2015.04.16.04.06.32
        for <util-linux@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2015 04:06:32 -0700 (PDT)
Message-ID: <1429182391.15041.2.camel@gmail.com>
Subject: sfdisk: failure to write partition layout to loopback devices
From: Unknown <ben.kero@gmail.com>
To: util-linux@vger.kernel.org
Date: Thu, 16 Apr 2015 04:06:31 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In util-linux 2.26 and onward a check is done to see if there are any
open filehandles on the device that is being updated. Specifically,
this check is being done in 'is_device_used': disk-utils/sfdisk.c:1055

For loopback devices the ioctl(fd, BLKRRPART) will always fail with
return code -1. Checking errno will yield error '22'. This is
"expected" and parted has considered making exceptions for this in the
past [1]. I would propose that instead of having to iss ue a '--force'
flag for basic loopback device operation, an exception should be
included in the is_device_used function.

It could be as simple as:

+    // If we are dealing with a loopback device this will fail, but
shouldn't
+    if (!strncmp("/dev/loop", fdisk_get_devname(sf->cxt), 9)) {
+        return 0;
+    }


[1] http://comments.gmane.org/gmane.comp.gnu.parted.devel/2254
