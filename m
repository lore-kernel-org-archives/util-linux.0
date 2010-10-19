Return-Path: util-linux-ng-owner@vger.kernel.org
Received: from rcsinet10.oracle.com ([148.87.113.121]:45230 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751086Ab0JSRcT convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Tue, 19 Oct 2010 13:32:19 -0400
Received: from rcsinet15.oracle.com (rcsinet15.oracle.com [148.87.113.117])
	by rcsinet10.oracle.com (Switch-3.4.2/Switch-3.4.2) with ESMTP id o9JHWHqw026395
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <util-linux-ng@vger.kernel.org>; Tue, 19 Oct 2010 17:32:19 GMT
Received: from acsmt355.oracle.com (acsmt355.oracle.com [141.146.40.155])
	by rcsinet15.oracle.com (Switch-3.4.2/Switch-3.4.1) with ESMTP id o9JDBZYA002628
	for <util-linux-ng@vger.kernel.org>; Tue, 19 Oct 2010 17:32:16 GMT
From: Chuck Lever <Chuck.Lever@oracle.com>
Content-Type: text/plain; charset=us-ascii
Subject: NFS remount bug
Date: Tue, 19 Oct 2010 13:32:11 -0400
Message-Id: <6BEE826D-5AC3-4CA7-A954-6255A6BD7AED@oracle.com>
To: util-linux-ng@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v1081)
Sender: util-linux-ng-owner@vger.kernel.org
List-ID: <util-linux-ng.vger.kernel.org>

Hi-

I'm working on the NFS submount commands.  These are found in the nfs-utils package, but they inherited a bunch of code from utils-linux to read fstab and manage mtab.

We've got a little problem with "-o remount".

At mount time, mount.nfs can negotiate with the target NFS server to determine how to contact it to send the MNT request and set up the communication parameters for the NFS protocol.  If the mount process succeeds, mount.nfs puts the command line options in /etc/mtab.

At umount time, umount.nfs reads these options back from /etc/mtab so that it can figure out how to send a UMNT request.  There are some problem cases, though.

If /etc/mtab is a link to /proc/mounts, the final fixed negotiated options appear there, not necessarily what was on the command line.  If the server reboots, some of those options might become stale.

If a remount is done, the options in /etc/mtab are wiped, so umount.nfs has no way to know how to contact the server.

We also know that everyone wants to toss /etc/mtab.

So: what future-proof mechanism do we use to preserve the mount command line so umount.nfs has a chance of working reliably?

In the meantime, is there a straightforward way to merge the old and new mount options during a remount?

-- 
chuck[dot]lever[at]oracle[dot]com




