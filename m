Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4748 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706AbaIPJfg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 16 Sep 2014 05:35:36 -0400
Date: Tue, 16 Sep 2014 11:35:25 +0200
From: Karel Zak <kzak@redhat.com>
To: JWP <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: * RECALL * [PATCH 1/2] hwclock: hctosys drift compensation
Message-ID: <20140916093525.GG7867@x2.net.home>
References: <5415EC97.4060305@gmx.com>
 <5416F1CC.2010007@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5416F1CC.2010007@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Sep 15, 2014 at 10:03:56AM -0400, JWP wrote:
> So, also on my hwclock todo list is drift correcting --show.
> I believe that doing them together will yield a more eloquent
> patch, and streamline the code in general. Therefore, please
> disregard this patch for the time being.  I apologize for 
> submitting it prematurely.

 OK, the idea to read adjtime file when we apply HW clock to
 sys time makes sense.

> Of course, comments on the concepts or the code are welcome.

 Something else:

 See Documentation/TODO, the writable /etc/adjtime sucks, because in
 many cases we want to keep /etc read-only. I see two possible ways:

  1. move the file to /var/lib/hwclock/adjtime
  
     This is already possible by "./configure ADJTIME_PATH=/var/lib/hwclock/adjtime"
     (used for example by Linux-from-scratch project).

     -- the problem is that the file (specially last UTC/LOCAL line)
        may be expected by another tools

  2. create another independent /var/lib/hwclock/drift file with
     info about HW clock drift numbers and keep only zeros and
     and UTC/LOCAL setting in /etc/adjtime. 
     
     This could be implemented backwardly compatible, if there is no
     /var/lib/hwclock then always use /etc/adjtime for drift numbers.

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
