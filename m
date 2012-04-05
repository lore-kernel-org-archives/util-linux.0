Return-Path: util-linux-owner@vger.kernel.org
Received: from mta02.ornl.gov ([128.219.14.62]:7492 "EHLO mta02.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753640Ab2DETq4 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 5 Apr 2012 15:46:56 -0400
From: "Males, Jess L." <malesjl@ornl.gov>
To: "util-linux-ng@vger.kernel.org" <util-linux-ng@vger.kernel.org>
Date: Thu, 5 Apr 2012 15:37:22 -0400
Subject: mount bind options
Message-ID: <CBA36CB2.C75%malesjl@ornl.gov>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I'm trying:
Mount -o bind,gid=10101 /path/to/some/dir /new/mnt/

Where:
drwxr-xr-x. 2 user1 user1  4096 Apr  5 14:34 /path/to/some/dir

I wanted:
drwxr-xr-x. 2 user1 user2  4096 Apr  5 14:34 /new/mnt

But I don't get it.

Is this purposefully not implemented because it would be BAD (Å)?  Or has
it just not been implemented.

Thanks,



-- Jess




