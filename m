Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:52631 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbbCMJAc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 13 Mar 2015 05:00:32 -0400
Received: from brln-5f72d2af.pool.mediaways.net ([95.114.210.175]) by
 mail.gmx.com (mrgmx103) with ESMTPSA (Nemesis) id 0MTjMy-1YwmI21mi0-00QX3m
 for <util-linux@vger.kernel.org>; Fri, 13 Mar 2015 10:00:30 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: tailf, really needed?
Date: Fri, 13 Mar 2015 10:00:29 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201503131000.29307.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

As far as I understood tailf's advantage over "tail -f" is that it does 
not access the file when it does not grow. But nowadays 
coreutils "tail -f" also does not seem to access the file. So do we 
really need tailf?

The point is that I've noticed that our tailf fails to deal with 
filesystems where inotify is broken. For example it does not work for 
overlayfs. coreutils tail code looks quite complicated and seems to 
manage such cases. Is it worth to fix our tailf or better just remove 
it and use "tail -f"?

BTW coreutils tail is much more comfortable. It has many important 
options. For example watching log files without -F or --retry does not 
make sense to me (because of logrotate).

Last but not least, is anybody using tailf at all? Google does not find 
much about people who are using this.

cu,
Rudi
