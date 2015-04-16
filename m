Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:43830 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752233AbbDPQFe (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Apr 2015 12:05:34 -0400
Date: Thu, 16 Apr 2015 18:05:32 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: Thomas Bechtold <tbechtold@suse.com>, util-linux@vger.kernel.org
Subject: Re: sfdisk input parsing broken with 2.26.1
Message-ID: <20150416160532.GE6757@ws.net.home>
References: <552F87E5.5010507@suse.com>
 <201504161351.23675.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201504161351.23675.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Apr 16, 2015 at 01:51:22PM +0200, Ruediger Meier wrote:
> BTW I've noticed that since 2.26 --dump produces incompatible dump 
> files. 

Yes, this is expected behavior.

> Shouldn't we have at least backward compatibility, i.e. old 
> dumps still work with new sfdisk?

yes

> >>> Script header accepted.
> >>> Created a new DOS disklabel with disk identifier 0xdf10c8b1.
> Created a new partition 1 of type 'Linux' and of size 100 GiB.
> Start sector 0 out of range.
> Failed to add partition: Numerical result out of range
> /tmp/image2: Leaving.

This is bug introduces probably later when I learned libfdisk to
accept zero size/offsets. 

Fixed, will be in v2.26.2 (probably next week).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
