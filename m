Return-Path: util-linux-owner@vger.kernel.org
Received: from li9-11.members.linode.com ([67.18.176.11]:38111 "EHLO
	test.thunk.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943Ab2DWRHH (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 Apr 2012 13:07:07 -0400
Date: Mon, 23 Apr 2012 13:07:01 -0400
From: "Ted Ts'o" <tytso@mit.edu>
To: Marcin Szewczyk <Marcin.Szewczyk@wodny.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Duplicate UUIDs, findmnt, /dev/disk/by-uuid
Message-ID: <20120423170701.GC3042@thunk.org>
References: <20120423154106.GD2437@magazyn-ziarno.zbozowa>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120423154106.GD2437@magazyn-ziarno.zbozowa>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Apr 23, 2012 at 05:41:06PM +0200, Marcin Szewczyk wrote:
> 
> The system has been cloned (with dd) to many disks inserted to many
> machines. From time to time someone inserts an additional disk which has
> been previously used as the system disk. Then there are two filesystems
> with same UUIDs inserted to one machine.

This probably won't help you that much now, but best practice for
ext[234] file systems is after you clone them using dd, you should run
the command "tune2fs -U random /dev/sdXX" to reset the UUID to a new
random value.  For XFS, the command is "xfs_admin -U generate /dev/sdXX".
For ntfs, the advanced utilities have a --new-serial option to ntfslabel.

It's *always* a good idea to make sure that the UUID is reset after
cloning a file system, to avoid this sort of problem.

Regards,

					- Ted
