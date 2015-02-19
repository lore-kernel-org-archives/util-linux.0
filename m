Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37403 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752324AbbBSKBU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 19 Feb 2015 05:01:20 -0500
Date: Thu, 19 Feb 2015 11:01:16 +0100
From: Karel Zak <kzak@redhat.com>
To: grantksupport@operamail.com
Cc: util-linux@vger.kernel.org
Subject: Re: blikid reports gdisk-created Bios Boot Partition, created with
 NO fs, has fs TYPE=ext4. Bug/why?
Message-ID: <20150219100116.GD11507@ws.net.home>
References: <1424032823.1090725.227824713.20C2D28B@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424032823.1090725.227824713.20C2D28B@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 15, 2015 at 12:40:23PM -0800, grantksupport@operamail.com wrote:
> Note that it IDs the filesystem type as
> 
> 	TYPE="ext4"
> 
> Why?
> 
> Bios Boot Partition should have NO filesystem.
> 
> Is blkid correct?  Is there, or isn't there a fs on that partition?

Maybe the disk has been originally used for ext4 and now there is
obsolete signature... Note that fdisks usually only write partition
table to the disk, but does not erase any old stuff.

> If there IS, how do I make sure there isn't?

 wipefs /dev/sdc1

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
