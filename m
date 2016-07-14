Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:35021 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbcGNN2N (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 14 Jul 2016 09:28:13 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id CA3F4AC8D
	for <util-linux@vger.kernel.org>; Thu, 14 Jul 2016 13:28:11 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 0/7] safe implementation of loop reuse
Message-ID: <ecb4b89d-f9ad-a854-80e5-c3fb49b200a2@suse.cz>
Date: Thu, 14 Jul 2016 15:28:11 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Few months ago I sent a simple patch for loop reuse. It was able to
reuse loop device in simple cases, but it did not fully check for safe
usability of the loop device.

That is why I wrote new implementation that should be safe.

To keep the code as small as possible, it changes API of several
functions: it adds sizelimit check possibility.

Thing that should be done, but they are above scope of this patch set:

- The current API does not support passing the name of the conflicting
   loop device to the error reported to the user. Just now, only debug
   messages contain it.

- The same what is done for mount needs to be done for losetup.
   API is now ready for it, so it should be simple.

- Add mount option looprw. It would allow to mount read only but
   initialize loop device R/W. Required for things like:
   mount -oro,loop,looprw,subvol=snapshots/1 -tbtrfs\
    /home.img /home-snapshots/1
   mount -oloop -tbtrfs /home.img /home
   (Without looprw, /home will be mounted read-only.)

And there are still some risks above scope of this patch set:

- Risk of race conditions if two processes allocate loop device in
   parallel.

- I am not sure, whether loop reuse with combination of autoclear flag
   differences could cause preliminary releasing of loop device or
   keeping orphan loop device in some situations.

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
