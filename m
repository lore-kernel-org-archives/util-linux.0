Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60024 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbdJDJr4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 4 Oct 2017 05:47:56 -0400
Date: Wed, 4 Oct 2017 11:47:52 +0200
From: Karel Zak <kzak@redhat.com>
To: Peter Cordes <peter@cordes.ca>
Cc: Bruce Dubbs <bruce.dubbs@gmail.com>,
        Util-Linux <util-linux@vger.kernel.org>
Subject: Re: fdisk request for functionality (or info)
Message-ID: <20171004094752.4xlt2kw5gr6wcmnl@ws.net.home>
References: <59D3C162.4050005@gmail.com>
 <20171004082728.if274peupxjljbxd@ws.net.home>
 <20171004085926.GI18363@cordes.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171004085926.GI18363@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 04, 2017 at 05:59:26AM -0300, Peter Cordes wrote:
> On Wed, Oct 04, 2017 at 10:27:28AM +0200, Karel Zak wrote:
> > The tricky thing is that fdisks by default see GPT partition, so you
> > have to force the tools to ignore GPT and use PMBR.
> 
>  Would it be possible to add a more user-friendly way to present this
> to the user?

Good point. Added to our TODO (probably v2.32):

  * fdisk: add "Print PMBR" and "Toggle PMBR boot flag" to main menu for GPT
  * sfdisk: make "--activate" usable also for GPT, in this case set PMBR boot flag


 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
