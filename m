Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58756 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755820AbbLGLZd (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Dec 2015 06:25:33 -0500
Date: Mon, 7 Dec 2015 12:25:31 +0100
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: cfdisk cuts lines for logical partitions too short
Message-ID: <20151207112531.GB2353@ws.net.home>
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

 Probably fixed -- I'm not sure if I have found the same bugs like
 you :-) 
 
 Test it please. Thanks!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
