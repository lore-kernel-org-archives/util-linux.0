Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:24087 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750837Ab3CRNSc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Mar 2013 09:18:32 -0400
Date: Mon, 18 Mar 2013 14:18:27 +0100
From: Karel Zak <kzak@redhat.com>
To: Jeff Mahoney <jeffm@suse.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] loopdev: sync capacity after setting it
Message-ID: <20130318131827.GE2172@x2.net.home>
References: <51438CF9.7020707@suse.com>
 <5145D0B4.1070207@suse.com>
 <20130318092700.GC2172@x2.net.home>
 <51471122.6030804@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51471122.6030804@suse.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 18, 2013 at 09:05:38AM -0400, Jeff Mahoney wrote:
> Yeah, but that's in losetup --set-capacity where it's an explicit
> operation. This change will add the ioctl into every
> loopdev_setup_device call when the offset or sizelimit options are used.
> If it isn't supported by the kernel, the ioctl will fail silently and
> *maybe* the mount will fail, but that's totally dependent on the the
> file system. If the mount succeeds, it will be done outside of the
> parameters the user requested.
> 
> So, all I really want to do is dump an error message when the ioctl
> fails with -ENOTTY || -EINVAL about there being a lack of kernel
> support. We shouldn't allow the device configuration to proceed.
> 
> The part that makes it more "fun" is that a few patches in 3.9-rc1 fixed
> this in the kernel, so it won't actually be needed for new kernels.

 Nasty... well, send patch.
 
    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
