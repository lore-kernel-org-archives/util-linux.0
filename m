Return-Path: util-linux-owner@vger.kernel.org
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:15919 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756870Ab2EAPXo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 1 May 2012 11:23:44 -0400
Message-ID: <4F9FFFFE.5070404@ubuntu.com>
Date: Tue, 01 May 2012 11:23:42 -0400
From: Phillip Susi <psusi@ubuntu.com>
MIME-Version: 1.0
To: Mike Frysinger <vapier@gentoo.org>
CC: Thomas Orgis <thomas-forum@orgis.org>, util-linux@vger.kernel.org
Subject: Re: losetup -d --force for zombie loop devices?
References: <20120417100346.2a0b8301@orgis.org> <4F9EF01B.9040003@ubuntu.com> <201204301607.22712.vapier@gentoo.org>
In-Reply-To: <201204301607.22712.vapier@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 4/30/2012 4:07 PM, Mike Frysinger wrote:
> `umount -l` has its place -- there are cases where you want those semantics.
> granted, most people actually want a `umount -f`, but the two aren't mutually
> exclusive.
> -mike

If you want to prevent processes from opening new files on the mount 
point, it would be much more sane to mount --move it somewhere hidden. 
When you detach it entirely from the namespace, you can't even be aware 
that the mount still exists, let alone change your mind and reattach it. 
  Having a device that is still mounted, but appears not to be to all 
tools that normally check for such things ( partitioning tools, auto 
mounters, etc ) is broken.

It is very confusing when you later try to change the cd in the drive 
and can't mount it because the old one is still mounted, yet lsof, 
mount, etc offer no evidence that this is the case, and you can't track 
down the process that is still holding an open fd and kill it.

