Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:52812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751687AbcIBJXU (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 2 Sep 2016 05:23:20 -0400
Date: Fri, 2 Sep 2016 11:23:18 +0200
From: Karel Zak <kzak@redhat.com>
To: Scott Moser <smoser@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: request for sfdisk --no-blkrrpart
Message-ID: <20160902092318.52xoiv6xksqj7b3e@ws.net.home>
References: <alpine.DEB.2.20.1609011256580.13370@milhouse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1609011256580.13370@milhouse>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Sep 01, 2016 at 01:08:46PM -0400, Scott Moser wrote:
> Long story short, could you add a '--no-blkrrpart' flag that growpart
> could add in its usage.  Then it wouldn't have to deal with ignoring an
> expected failure.  Growpart handles calling
>    partx --update --nr <PART> <DEVICE>
> when it can.

I have added --no-tell-kernel option (we already have --no-reread for
another purpose).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
