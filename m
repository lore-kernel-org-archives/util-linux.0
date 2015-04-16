Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43214 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753502AbbDPLYU (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Apr 2015 07:24:20 -0400
Date: Thu, 16 Apr 2015 13:24:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Thomas Bechtold <tbechtold@suse.com>
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk input parsing broken with 2.26.1
Message-ID: <20150416112418.GD6757@ws.net.home>
References: <552F87E5.5010507@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <552F87E5.5010507@suse.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 16, 2015 at 11:59:01AM +0200, Thomas Bechtold wrote:
> [please CC me - I'm not subscribed to the list]
> 
> Hi,
> 
> the following worked fine with 2.20 (tested on Ubuntu):
> 
> sfdisk $IMAGE_BLOCK_DEVICE << EOF
> 1 - - *
> 0 0;
> 0 0;
> 0 0;
> EOF

I have doubts that '-' is documented somewhere, but you're right that
this feature is supported by the old version. I'll fix the problem in
v2.26.2.

If the goal is to set bootable flag then you can use

 echo ",,,*' | sfdisk -N1 $IMAGE_BLOCK_DEVICE

or 
 
 sfdisk --activate ...


Note that there was another problem with boot flag if you resize
partition (commit 4d156d92eb538f9dbc077a2dd181a48d8fdc65cd), will be
also in 2.26.2.


    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
