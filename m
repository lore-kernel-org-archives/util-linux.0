Return-Path: util-linux-owner@vger.kernel.org
Received: from averel.grnet-hq.admin.grnet.gr ([195.251.29.3]:5599 "EHLO
	averel.grnet-hq.admin.grnet.gr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752878Ab3LBRgM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 2 Dec 2013 12:36:12 -0500
Message-ID: <529CC1AE.9090006@grnet.gr>
Date: Mon, 02 Dec 2013 19:21:50 +0200
From: Nikos Skalkotos <skalkoto@grnet.gr>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
CC: synnefo-devel@googlegroups.com
Subject: Support for the new OpenBSD disklabel format
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello all,

Lately, I've been evaluating all available solutions for manipulationg
*BSD disks from Linux and found out that none recognizes the new OpenBSD
disklabel format correctly. I ended up writing my own tool in python for
manipulating OpenBSD partitions.

parted, that is more script-friendly than fdisk, does not support
disklabels at all. Older fdisk versions (the ones that are shipped with
the major linux distos like Debian and Ubuntu) only check for FreeBSD
and NetBSD partition IDs (but not OpenBSD). Latest versions of fdisk
recognize disklabels on OpenBSD partitions but OpenBSD has changed the
disklabel format.

In order to support disks and partitions that are larger that 2TB, the
OpenBSD folks have converted some 32bit disklabel fields to 48bit (e.g.
the "sectors per unit" field). In order to implement this, they have
replaced some obsolete "hardware characteristics" fields with the high
part (16 most significant bits) of the aforementioned. Even the
partition table has changed. The "filesystem basic fragment size"
(=32bit) has been replaced with the "starting sector high part" (=16bit)
and the "number of sectors high part" (=16bit) fields.

Besides the python tool I've written, for a more permanent solution, I'm
considering patching libfdisk to support the OpenBSD disklabel. I wanted
to know if you are interested for those patches. I think the best way to
do it is to split the disklabel parts that have changed into different
structs and use unions to create a disklabel struct that will work both
for NetBSD and OpenBSD. What do you think?

If this works out, I'd be happy to create python bindings for libfdisk
(like the ones you have for libmount) as a later step. I know that the
API is not currently stable, but most parts seem OK.


Best Regards,
Nikos Skalkotos

