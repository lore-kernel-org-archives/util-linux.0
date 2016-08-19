Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp2.dds.nl ([83.96.147.103]:50878 "EHLO smtp2.dds.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752338AbcHSJqz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 19 Aug 2016 05:46:55 -0400
Received: from webmail.dds.nl (app1.dds.nl [81.21.136.61])
        by smtp2.dds.nl (Postfix) with ESMTP id 4722040A67C1
        for <util-linux@vger.kernel.org>; Fri, 19 Aug 2016 11:45:54 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Fri, 19 Aug 2016 11:45:54 +0200
From: Xen <list@xenhideout.nl>
To: Util linux <util-linux@vger.kernel.org>
Subject: Re: PV on disk without partitions not recognised as LVM2_member
In-Reply-To: <c3d87222fe4f87eed72f61b6bc501344@dds.nl>
References: <c3d87222fe4f87eed72f61b6bc501344@dds.nl>
Message-ID: <7a56f741e70cc37568b950ff12aa05df@dds.nl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Xen schreef op 18-08-2016 22:39:

> Ie. I had a disk that had a "promise fasttrack raid member" (from
> memory) signature at the end of the disk (last 1MB) and was recognised
> as such. When I wiped the signature, it was recognised as "dos":
> 
> /dev/sda: PTUUID="ef39c6e5" PTTYPE="dos"

Oh, I mean... the PTTYPE would be "dos" but there would not be any 
FS_TYPE description (as per the udev name?). In any case.

Both regular "msdos" partition tables and PV signatures get an empty 
"TYPE" in blkid.

So I can match those in udev by just matching the empty string. Both are 
also given the same PTTYPE of "dos". So I cannot distinguish between 
msdos partition tables and PV disks.

Regards.
