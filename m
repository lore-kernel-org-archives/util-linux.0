Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28716 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759963AbaGYIpo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 25 Jul 2014 04:45:44 -0400
Date: Fri, 25 Jul 2014 10:45:38 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>, util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix switch_root/pivot_root cut-n-paste error in
 configure.ac
Message-ID: <20140725084538.GQ26781@x2.net.home>
References: <1406137142-15441-1-git-send-email-andreas@fatal.se>
 <20140724165226.GB519@rampage>
 <20140724171924.GA21736@fatal.se>
 <20140724172627.GC519@rampage>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140724172627.GC519@rampage>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 24, 2014 at 01:26:27PM -0400, Dave Reisner wrote:
> Ah, I wrongly assumed what UL_REQUIRES_LINUX does. Makes more sense
> having now read the .m4 file, and I agree with your fix.

 Yep, I have created UL_REQUIRES_ to have an elegant way how to specify
 dependences between --disable-* options, utils, libs (with in package) 
 and external requirements. One day I'd like to write a blog about it ;-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
