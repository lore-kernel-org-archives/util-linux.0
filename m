Return-Path: util-linux-owner@vger.kernel.org
Received: from awesome.dsw2k3.info ([217.188.63.246]:36471 "EHLO
	awesome.dsw2k3.info" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbaH2JnI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 29 Aug 2014 05:43:08 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by awesome.dsw2k3.info (Postfix) with ESMTP id 1B55FC0108
	for <util-linux@vger.kernel.org>; Fri, 29 Aug 2014 11:33:49 +0200 (CEST)
Received: from awesome.dsw2k3.info ([127.0.0.1])
	by localhost (awesome.dsw2k3.info [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UukafuXxsTbn for <util-linux@vger.kernel.org>;
	Fri, 29 Aug 2014 11:33:47 +0200 (CEST)
Received: from citd.de (p5B15A9EF.dip0.t-ipconnect.de [91.21.169.239])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by awesome.dsw2k3.info (Postfix) with ESMTPSA
	for <util-linux@vger.kernel.org>; Fri, 29 Aug 2014 11:33:47 +0200 (CEST)
Date: Fri, 29 Aug 2014 11:35:22 +0200
From: Matthias Schniedermeyer <ms@citd.de>
To: util-linux@vger.kernel.org
Subject: Debugging why fstrim doesn't work
Message-ID: <20140829093522.GA32003@citd.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi


All of my computers have a SSD for the root-filesystem.
But on none fstrim works. I only get this:

$ fstrim -v /
fstrim: /: discard operation not supported.

How can i debug why fstrim/the kernel thinks discard isn't supported?

All my root-filesystems are XFS.
kernel differs by computer, currently between 3.15.2 and 3.16.1
(Same self-compiled kernel on all machines)
util-linux is version 2.25 (Experimental Package from Debian SID)

The mount-output for the root-filesystem of one my compters looks like 
this:
/dev/sda2 on / type xfs (rw,noatime,attr2,inode64,allocsize=64k,noquota)

I DO NOT use an initrd/initramfs, so the root-filesystem is still the 
original mount from the kernel itself (i case that matters)




-- 

Matthias
