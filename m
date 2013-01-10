Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:2730 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957Ab3AJKHu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Jan 2013 05:07:50 -0500
Date: Thu, 10 Jan 2013 11:07:45 +0100
From: Karel Zak <kzak@redhat.com>
To: Roger Leigh <rleigh@codelibre.net>
Cc: util-linux@vger.kernel.org
Subject: Re: Preservation of non-kernel mount options
Message-ID: <20130110100745.GB19166@x2.net.home>
References: <20130108104443.GF3739@codelibre.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130108104443.GF3739@codelibre.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jan 08, 2013 at 10:44:43AM +0000, Roger Leigh wrote:
> Options like _netdev, comment= etc. are currently just ignored by
> mount AFAICS.  It would however be quite useful if they could be
> preserved in e.g. utab if possible so that you can use this to
> label mounts so that you can query for the information later using
> e.g. mount or findmnt.  Is this something which might be possible
> to add if it's not already possible?

 The goal is to minimize number of situations when anything about
 mountpoints is maintained in userspace. It's usually too tricky to
 keep the userspace information synchronized with in-kernel
 information (imagine things like namespaces, sandboxes, ...).

> It turned out (at least in Debian) that some users were using the
> "bind" option to track which filesystems were to be e.g. backed up,
> space usage checked etc. (or not).  With the switch to /proc/mounts
> this information has been lost.  While using the bind option to do
> this is debatable, I was looking for a better and more robust
> solution to their problem, and being able to attach comments to
> the mounts seemed like it would fit in with the existing tools
> if they could be stored.

 Would be possible to improve the backup scripts to maintain
 information about *filesystems* in userspace and address the
 information by filesystem UUIDs? Something like

   /var/log/backup-info/<UUID>/item{A,B,C}

 the UUID is stable, you will not affected by things like namespaces,
 umount/mount/move/... operations. The info will be completely
 independent on mountpoints and found the filesystem in the findmnt(8)
 or lsblk(8) output by UUID is pretty simple.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
