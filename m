Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:26358 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145Ab1L3HIK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 30 Dec 2011 02:08:10 -0500
Received: from cdptpa-omtalb.mail.rr.com ([10.127.143.54])
          by cdptpa-qmta01.mail.rr.com with ESMTP
          id <20111229185607144.KHV5351@cdptpa-qmta01.mail.rr.com>
          for <util-linux@vger.kernel.org>; Thu, 29 Dec 2011 18:56:07 +0000
Message-ID: <4EFCB784.3080904@cfl.rr.com>
Date: Thu, 29 Dec 2011 13:55:00 -0500
From: Phillip Susi <psusi@cfl.rr.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: cfdisk fails to zap mac partition table
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When a disk has a mac partition table and you run cfdisk on it, it 
creates a new msdos partition table, but preserves the mac partition 
table's signature, probably because it is in the area where the mbr boot 
code is.  When initializing a new MBR, cfdisk should not preserve any 
existing data.  fdisk does not exhibit this behavior.

To reproduce with a clean loop device:

parted /dev/loop0 mklabel mac
cfdisk /dev/loop0
parted /dev/loop0 print

Parted still recognizes the mac partition table.

The original bug report can be seen here: 
https://bugs.launchpad.net/bugs/909424
