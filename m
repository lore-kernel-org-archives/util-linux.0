Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:16382 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756422Ab1KPNGo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Nov 2011 08:06:44 -0500
Date: Wed, 16 Nov 2011 14:06:39 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 14/15] prlimit: avoid prlimit syscalls for limits
	unless to modify or to show
Message-ID: <20111116130639.GL7916@nb.net.home>
References: <4EC07385.70101@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC07385.70101@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 14, 2011 at 02:48:53AM +0100, Bernhard Voelker wrote:
> [PATCH 14/15] prlimit: avoid prlimit syscalls for limits unless to  
> modify or to show

 This is unnecessary now.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
