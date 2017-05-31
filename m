Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60038 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751200AbdEaJSg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 31 May 2017 05:18:36 -0400
Date: Wed, 31 May 2017 11:18:32 +0200
From: Karel Zak <kzak@redhat.com>
To: NeilBrown <neilb@suse.com>
Cc: util-linux@vger.kernel.org
Subject: Re: "mount -o remount,rw" sometimes doesn't work as expected.
Message-ID: <20170531091832.3pjvxrhnc7ptd75g@ws.net.home>
References: <87wp9djp2n.fsf@notabene.neil.brown.name>
 <20170519091125.bdans7hirua3blb5@ws.net.home>
 <87r2zhkg8r.fsf@notabene.neil.brown.name>
 <20170522112635.bcnfvxuqi7xbifb5@ws.net.home>
 <87zidtenex.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87zidtenex.fsf@notabene.neil.brown.name>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 31, 2017 at 01:05:26PM +1000, NeilBrown wrote:
> Sorry for the delay.
> 
> Yes, this does look easy, makes sense, and does work as expected for me
> too.
> 
> Reported-and-tested-by: NeilBrown <neilb@suse.com>
> 
> will you be queuing this for the next release?

IMHO it's too late for v2.30. I'd like to wait for v2.31 (September)
as it is not so urgent and common issue :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
