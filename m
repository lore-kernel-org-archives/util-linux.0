Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59963 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420Ab2DEOae (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 Apr 2012 10:30:34 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q35EUYXq010069
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Thu, 5 Apr 2012 10:30:34 -0400
Date: Thu, 5 Apr 2012 16:30:32 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux <util-linux@vger.kernel.org>
Cc: David Zeuthen <davidz@redhat.com>, Michal Luscon <mluscon@redhat.com>
Subject: eject merged into util-linux
Message-ID: <20120405143032.GC20515@x2.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 The original eject project (at sourceforge.net) is inactive for more
 than 4 year. Unfortunately, the command is still used in mainstream
 Linux distributions (for example udisks depends on the eject
 functionality). Changes:

  * complete refactoring (the original code was real mess...)

  * merged patches from Fedora (auto-eject, manual-eject, close-tray
    list-speed and removable/hotpluggable-check patches)

  * removed support for incomplete paths (for example "eject foo" was
    interpreted as "eject /media/foo" or "eject /mnt/foo". The
    incomplete paths are supported for devices only (e.g. "eject sda").

    FOR MOUNTPOINT YOU HAVE TO SPECIFY COMPLETE PATH!

  * enabled by default (and added --disable-eject)

  * if a partition is specified, whole-disk device is used for eject
    ioctl(s), for example "eject /dev/sda1" is the same as "eject /dev/sda"


 Thanks to Michal Luscon for help.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
