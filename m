Return-Path: util-linux-owner@vger.kernel.org
Received: from hermod.fs.tum.de ([129.187.202.12]:35215 "EHLO hermod.fs.tum.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753442Ab3AYNsA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jan 2013 08:48:00 -0500
From: Marcel Meyer <meyerm-utillinux@fs.tum.de>
To: util-linux@vger.kernel.org
Subject: bug in parameter parsing mkfs
Date: Fri, 25 Jan 2013 14:42:02 +0100
Message-ID: <8726723.nWpYbPFEYv@taris>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,


we encountered a bug in the parameter parsing of mkfs after c&p of a wrongly 
written wiki article.

So

  $ mkfs.ext4 -Llabel /dev/device

and

  $ mkfs.ext4 -L label /dev/device

work as expected.

  $ mkfs ext4 -Llabel /dev/device       # note the missing "."

reports correctly "invalid blocks '/dev/device' on device 'ext4'" after 
invoking mkfs.ext2 as the default mkfs.

But when you enter the same wrong command line with an additional space in the 
label like

  $ mkfs ext4 -L label /dev/device

it formats /dev/device with an ext2 filesystem and the label "label".


Yours
Marcel

