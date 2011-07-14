Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:25778 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754530Ab1GNLwg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jul 2011 07:52:36 -0400
Date: Thu, 14 Jul 2011 13:52:31 +0200
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Lennart Poettering <lennart@poettering.net>
Subject: dmesg(1) changes
Message-ID: <20110714115231.GF3486@nb.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


 Hi,

I did some changes to dmesg(1) in last days:

 * \x<hex> encoding is used for non-printable chars and invalid 
   multibyte sequences

 * add --decode option to decode facility and level (priotity) number to
   human readable prefixes, for example:

    $ dmesg --decode
    kern  :info  : [53335.593617] ata1.00: configured for UDMA/100
    kern  :info  : [53335.743185] PM: resume of devices complete after 2496.795 msecs
    kern  :debug : [53335.743593] PM: Finishing wakeup.
    kern  :warn  : [53335.743595] Restarting tasks ... done.
    kern  :info  : [53335.790452] video LNXVIDEO:00: Restoring backlight state

 * add --facility=<LIST> option to filter out messages, for example:

    $ dmesg --facility=daemon,user
    [    1.802065] dracut: dracut-009-11.fc15
    [    1.811267] dracut: rd.luks=0: removing cryptoluks activation
    [    1.813913] dracut: rd.lvm=0: removing LVM activation
    [    1.819348] udev[111]: starting version 167

 * add --level=<LIST> option to filter out messages, for example:

    $ dmesg --level=debug,info

    $ dmesg --facility=kern --level=warn,err

 * add --clear option to clear the kernel ring buffer

 * add --read-clear to read and clear the kernel ring buffer

 * add --console-off and --console-on to control output to console

 * -n <LEVEL> (--console-level) supports human readable level names,
   for example:

    $ dmesg --console-level=emerg,alert

Comments & suggestions?

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
