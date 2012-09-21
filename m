Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58765 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755488Ab2IUOiV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 21 Sep 2012 10:38:21 -0400
Date: Fri, 21 Sep 2012 16:38:16 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: Petr Uzel <petr.uzel@suse.cz>, util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/3] fdisk: add guid
Message-ID: <20120921143816.GB18699@x2.net.home>
References: <1345550594.2664.5.camel@offbook>
 <20120921111253.GA18699@x2.net.home>
 <20120921130543.GA643@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120921130543.GA643@gnu.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Sep 21, 2012 at 09:05:43AM -0400, Davidlohr Bueso wrote:
> I honestly don't see much difference between doing it before or
> after GPT, since all the other labels need to be adapted anyway. 

 I see a difference. Why we need struct fdisk_guid in struct where we
 define DOS partition types? Why there is {0} everywhere?
 Do you want to remove all these changes later?

 Anyway, I have no problem to write the patch to split part types to
 separate per-label tables :-)

 It also seems that you're introduce a new hex codes for GPT partition
 types. It means that you want to use int16_t to address types defined
 by UUIDs.  Is it good idea? Would be better to address the types by
 numbers <1-N> as printed in the menu or directly by UUIDs?

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
