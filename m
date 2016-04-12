Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:48570 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932222AbcDLSWB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Apr 2016 14:22:01 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 1C66DAC13
	for <util-linux@vger.kernel.org>; Tue, 12 Apr 2016 18:21:59 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH 0/3] btrfs-safe implementation of -oloop
Message-ID: <570D3CC7.5060809@suse.cz>
Date: Tue, 12 Apr 2016 20:21:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

As it was discussed in LKML[1], kernel has no way to detect backing
file data changes if multiple loop devices have the same backing file.

Exactly this happened if -oloop is used multiple times with the same
source.

It could not happen in past, but with introduction of btrfs sub-volumes
it has a perfectly legal use cases.

This patch set introduces a new behavior of -oloop:

First check, whether the same backing file with the same offset is
already used. If yes, reuse already initialized loop device.

If not, initialize another loop device.

There are some controversial things with these patches. Some of them
cannot be fixed.

- Kernel never returns EBUSY for LOOP_CLR_FD. It prevents errors when
   mount will steal other's loop device. But I am not sure, whether it
   will work correctly in all possible situations. Anyway, I don't see a
   better solution.

- If the same backing file is already used for a read-only loop device,
   there is no safe way to continue.
   - There is no way to turn R/O loop to R/W in kernel.
   - If another loop is initialized, changes will not propagate to R/O
     volume.
   - One would need to umount all R/O devices, initialize loop R/W, and
     then everything mount again.
   I can imagine partial solution: Introduce looprw option. Such option
   would cause to initialize loop device R/W even for R/O mount.

- If the same backing file is already used for a loop device with
   correct offset, but incorrect sizelimit, there is no solution. The
   current implementation does not check for it.

- There exists a change for a race condition between device lookup and
   mount syscall.

- The implementation does not check for crypto. I think it is not a big
   problem, as it makes no sense to initialize the same backing file as
   encrypted and non-encrypted at once.

References:
[1] https://lkml.org/lkml/2016/2/26/897

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Lihovarská 1060/12                            tel: +49 911 7405384547
190 00 Praha 9                                 fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
