Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:39003 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751482Ab2LWVyk (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 23 Dec 2012 16:54:40 -0500
Date: Sun, 23 Dec 2012 22:53:55 +0100
From: Karel Zak <kzak@redhat.com>
To: Werner Fink <werner@suse.de>, util-linux@vger.kernel.org
Subject: Re: [PATCH 4/5] sulogin: mount temporary /dev and /proc if not found
Message-ID: <20121223215355.GA25576@x2.redhat.com>
References: <20121207170118.GG603@rampage>
 <1355142431-8199-1-git-send-email-werner@suse.de>
 <20121218152311.GA13554@x2.net.home>
 <20121223043342.GA633@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121223043342.GA633@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Dec 22, 2012 at 11:33:42PM -0500, Dave Reisner wrote:
> I suggest that this code be relegated to sulogin.

 Fixed:
    - removed from libcommon (it's sulogin specific)
    - removed the attributes

  Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
