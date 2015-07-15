Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53299 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbbGONmf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 15 Jul 2015 09:42:35 -0400
Date: Wed, 15 Jul 2015 15:42:34 +0200
From: Karel Zak <kzak@redhat.com>
To: Scott Moser <smoser@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: GPT writing of unknown partition uuids
Message-ID: <20150715134234.GC31997@ws.net.home>
References: <alpine.DEB.2.02.1507141610310.21273@brickies>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.02.1507141610310.21273@brickies>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Jul 14, 2015 at 04:16:56PM -0400, Scott Moser wrote:
> It seems like if the user provided you with a GUID, sfdisk should trust
> them, or at very least exit failure if it refuses to use the provided
> GUID.
> 
> Thoughts?

It's bug, the "unknown" partition type is expected. Fixed in git tree:

# sfdisk -ql /dev/sdc
Device     Start     End Sectors  Size Type
/dev/sdc1   2048 1023966 1021919  499M Linux filesystem


# sfdisk --part-type /dev/sdc 1 $(uuidgen)
...


# sfdisk -ql /dev/sdc
Device     Start     End Sectors  Size Type
/dev/sdc1   2048 1023966 1021919  499M unknown


Thanks for your report!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
