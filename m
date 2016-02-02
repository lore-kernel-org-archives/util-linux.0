Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35768 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754258AbcBBKAm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Feb 2016 05:00:42 -0500
Date: Tue, 2 Feb 2016 11:00:41 +0100
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] libmount: run btrfs subvol checks for "auto" fs type
Message-ID: <20160202100040.6xhelhhq6oaxv7vk@ws.net.home>
References: <56A7DE4B.5060308@suse.cz>
 <20160201111815.wilhso7klaiy6cio@ws.net.home>
 <56AF77BE.5030601@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56AF77BE.5030601@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Feb 01, 2016 at 04:20:30PM +0100, Stanislav Brabec wrote:
> Karel Zak wrote:
> >  It's safe, but "mount -a" is going to call the btrfs ioctl or each
> >  "auto" fstab entry :-)
> >
> I am aware of it. Guessing what is more effective: search for all
> candidates in mountinfo and checking whether it is btrfs, or blindly
> issuing ioctl() that will:
> - quickly fail with EINVAL for non-btrfs
> - wil be needed for btrfs anyway

I think the EINVAL based solution is good enough. It's one syscall, be
smart in mountinfo (and canonicalize paths, etc.) is more expensive in
some use-cases.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
