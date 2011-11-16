Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59047 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753222Ab1KPM6D (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Nov 2011 07:58:03 -0500
Date: Wed, 16 Nov 2011 13:57:59 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 12/15] prlimit: add note to man page that setting
	limits without --pid is pointless.
Message-ID: <20111116125759.GJ7916@nb.net.home>
References: <4EC0737D.3090404@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4EC0737D.3090404@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 14, 2011 at 02:48:45AM +0100, Bernhard Voelker wrote:
> [PATCH 12/15] prlimit: add note to man page that setting limits without  
> --pid is pointless.

 Not applied, we need the exec() call.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
