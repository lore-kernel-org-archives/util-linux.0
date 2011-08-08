Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:22872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab1HHKFG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Aug 2011 06:05:06 -0400
Date: Mon, 8 Aug 2011 12:05:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] small corrections to a few man pages
Message-ID: <20110808100501.GJ2204@nb.net.home>
References: <1312395717.22139.2159101333@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312395717.22139.2159101333@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Aug 03, 2011 at 08:21:57PM +0200, Benno Schulenberg wrote:
> Attached first patch corrects "fistt" to "first" in the help text of cal,
> and seizes the opportunity to clarify the text and add uppercase where 
> needed.  The second patch corrects the short option for --timeout (from 
> -t to -w) in the man page of findmnt, and then fixes some markup and
> spacing issues.
> 
> Most utilities use -V as the short option for --version, only a few
> use -v instead; several use -v for --verbose.  The third patch makes
> wipefs conform to the majority now that the option is still fresh, and
> adds it to the man page.
> 
> The other five patches correct typos, grammar, markup and spacing
> in five other man pages.

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
