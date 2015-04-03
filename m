Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:61671 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbbDCOTq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 3 Apr 2015 10:19:46 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: eject test fails with kernel 3.19
Date: Fri, 3 Apr 2015 15:19:38 +0100
Cc: Douglas Gilbert <dgilbert@interlog.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201504031619.38548.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

eject(1) fails for scsi_debug module version 1.85 (kernel 3.19).

The Problem is that command ALLOW_MEDIUM_REMOVAL now returns 
driverstatus==DRIVER_SENSE with sensecode==0x20 (INVALID COMMAND 
OPERATION CODE).

If I ignore that senscode then the other two START_STOP commands finish 
successfully.

Should this be fixed in eject(1) or in scsi_debug or is it just a bad 
idea to eject scsi_debug devices? This documentations says 
ALLOW_MEDIUM_REMOVAL is supported.
http://sg.danny.cz/sg/sdebug.html

I guess the issue came with this kernel commit:

commit c2248fc974df7be55a5f6db6b6f99a90b749581b
Author: Douglas Gilbert <dgilbert@interlog.com>
Date:   Mon Nov 24 20:46:29 2014 -0500

    scsi_debug: change SCSI command parser to table driven

    The existing 'big switch' parser in queuecommand() is changed to
    a table driven parser. The old and new queuecommand() were moved
    in the source so diff would not shuffle them. Apart from the new
    tables most other changes are refactoring existing response code
    to be more easily called out of the table parser. The 'strict'
    parameter is added so that cdb_s can be checked for non-zero
    values in parts of the cdb that are reserved. Some other changes
    include: tweak request sense response when D_SENSE differs; support
    NDOB in Write Same(16); and fix crash in Get LBA Status when LBP
    was inactive.

cu,
Rudi
