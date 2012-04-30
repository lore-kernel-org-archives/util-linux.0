Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:13588 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756283Ab2D3UDl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 30 Apr 2012 16:03:41 -0400
Message-ID: <4F9EF01B.9040003@ubuntu.com>
Date: Mon, 30 Apr 2012 16:03:39 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Thomas Orgis <thomas-forum@orgis.org>
CC: util-linux@vger.kernel.org
Subject: Re: losetup -d --force for zombie loop devices?
References: <20120417100346.2a0b8301@orgis.org>
In-Reply-To: <20120417100346.2a0b8301@orgis.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 4/17/2012 4:03 AM, Thomas Orgis wrote:
> Hi,
>
> I am having an issue with a loop device that used to be connected to a file on NFS.
> Not sure if this is actually a kernel bug, but I assume (perhaps ignorantly so)
> that losetup could resolve the situation anyways.
>
> 0. have NFS share on /mnt/nfs  (rw,users,noexec,nosuid,nodev,hard,intr)
> 1. losetup --show -f /mnt/nfs/file.img
>     /dev/loop0
> # actually, it was using cryptsetup luksOpen/Close
> 2. mount /dev/loop0&&  do_work&&  umount /dev/loop0
> 3. loose connection to NFS server (it went offline, client machine (laptop) switched networks ...)
> 4. umount -l /mnt/nfs

This is the problem with umount -l: all it does is remove the path from 
the namespace, leaving the device still mounted.  Unfortunately umount 
-f is not properly supported.  The proper fix for this is to have the 
kernel support umount -f, and do away with the brain damaged umount -l.


