Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:20699 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757631AbaFSIdD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 19 Jun 2014 04:33:03 -0400
Date: Thu, 19 Jun 2014 10:32:59 +0200
From: Karel Zak <kzak@redhat.com>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.25-rc1
Message-ID: <20140619083259.GB25885@x2.net.home>
References: <20140618134616.GA25885@x2.net.home>
 <53A1A9CA.7000108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <53A1A9CA.7000108@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jun 18, 2014 at 10:01:30AM -0500, Bruce Dubbs wrote:
> It would be nice if we could set the adjtime path in configure.  Right now
> we do:
> 
> sed -i -e 's@etc/adjtime@var/lib/hwclock/adjtime@g' \
>           $(grep -rl '/etc/adjtime' .)

 Ah, I forgot this old issue. Fixed now.

   ./configure ADJTIME_PATH=/var/lib/hwclock/adjtime

 is the way how you can override the default in code and man pages.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
