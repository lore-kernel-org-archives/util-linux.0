Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:57055 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758145AbaELNKs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 12 May 2014 09:10:48 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0M7Hao-1WyVKi2xfC-00x6Rj for
 <util-linux@vger.kernel.org>; Mon, 12 May 2014 15:10:46 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: losesetup -f, broken error handling
Date: Mon, 12 May 2014 15:10:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201405121510.46066.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

When having a kernel without loop device support
$ losetup -f 
returns 0 and no warning on stderr

With older util-linux I get error and nice message on stderr
$ losetup -f
losetup: Could not find any loop device. Maybe this kernel does not know
about the loop device? (If so, recompile or `modprobe loop'.)

I guess this is broken since c7e0925d.

Woule be nice to have this again.

cu,
Rudi
