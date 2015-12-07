Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57276 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755687AbbLGJ2B (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Dec 2015 04:28:01 -0500
Date: Mon, 7 Dec 2015 10:27:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: cfdisk cuts lines for logical partitions too short
Message-ID: <20151207092756.GA2353@ws.net.home>
References: <1447862680.1454629.443346489.1A298B99@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1447862680.1454629.443346489.1A298B99@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Nov 18, 2015 at 05:04:40PM +0100, Benno Schulenberg wrote:
> In 2.27, the highlight bar of cfdisk is three or four characters
> shorter than the width of the screen -- for logical partitions.
> I noticed because on a 100-column terminal two letters of a
> translation were bitten off.
> 
> The culprit is commit ed99eac0e2a83a315c7cf5d8a461df16b3106596.
> Before that, the lines were full length.

.. because it (incorrectly) counts escape seq. to the size of the
header line. I'll try to fix it.

Thanks.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
