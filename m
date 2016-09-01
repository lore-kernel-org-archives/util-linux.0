Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35027 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbcIAU6v (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 1 Sep 2016 16:58:51 -0400
Received: by mail-pf0-f182.google.com with SMTP id x72so34904628pfd.2
        for <util-linux@vger.kernel.org>; Thu, 01 Sep 2016 13:58:50 -0700 (PDT)
Received: from milhouse (d27-96-63-67.nap.wideopenwest.com. [96.27.67.63])
        by smtp.gmail.com with ESMTPSA id d9sm9056486pan.7.2016.09.01.10.08.47
        for <util-linux@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Sep 2016 10:08:48 -0700 (PDT)
Date: Thu, 1 Sep 2016 13:08:46 -0400 (EDT)
From: Scott Moser <smoser@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: request for sfdisk --no-blkrrpart
Message-ID: <alpine.DEB.2.20.1609011256580.13370@milhouse>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I maintain 'growpart' in cloud-utils, which handles growing partitions to
fill up extra space.  Its common that disk images in vms will have
additional space added to the end, and growpart just resizes the partition
to take advantage of that if it is present.

Ubuntu just updated to 2.28.1 and cloud-utils and that caused bug
http://pad.lv/1619285.  I see that we are now now running with this in
place:
  commit e0d30ef4c sfdisk: exit with error if rereading partition table fails

Then i see in trunk that that is reverted:

  commit 78e7f7889 Revert "sfdisk: exit with error if rereading partition table fails"

In the past I had put some hacky error message output string matching
handle failure due only to BLKRRPART having failed, since the partition
i'm resizing usually is mounted as /.

Long story short, could you add a '--no-blkrrpart' flag that growpart
could add in its usage.  Then it wouldn't have to deal with ignoring an
expected failure.  Growpart handles calling
   partx --update --nr <PART> <DEVICE>
when it can.

Scott
