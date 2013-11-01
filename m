Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28113 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812Ab3KALXo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Nov 2013 07:23:44 -0400
Date: Fri, 1 Nov 2013 12:23:40 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: fdisk shows sun end sectors with +1 error
Message-ID: <20131101112340.GA23604@x2.net.home>
References: <52728FCE.2050003@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52728FCE.2050003@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 31, 2013 at 01:13:50PM -0400, Phillip Susi wrote:
> Device       Flag     Start       End   Blocks  Id System
> /dev/loop0p1              0  19904535  9952267+ 83 Linux native
> /dev/loop0p2   u   19904535  20000925    48195  82 Linux swap
> /dev/loop0p3              0  20000925 10000462+  5 Whole disk

Oh, excellent catch -- it seems like pretty old bug (I see it in v2.9,
year 1999) ;-)

Fixed. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
