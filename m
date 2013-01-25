Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38127 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754418Ab3AYPRi (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 25 Jan 2013 10:17:38 -0500
Date: Fri, 25 Jan 2013 16:17:36 +0100
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: util-linux-ng@vger.kernel.org
Subject: Re: fsck files w/relative paths
Message-ID: <20130125151736.GP27413@x2.net.home>
References: <201301201827.23141.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201301201827.23141.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Jan 20, 2013 at 06:27:22PM -0500, Mike Frysinger wrote:
> we could tweak parse_argv() so that it checks for argv[0] == '.' in addition 
> to argv[0] == '/'.  but that wouldn't fix other relative paths like:
> $ fsck images/foo
> $ fsck foo

Hmm... maybe add a hint to the fsck man page is the best solution :-)

> should we treat all non-options as devices ?  would that break anything ?

I don't think it's a good idea.

All unknown stuff is by default interpreted as filesystem specific options
(options for fsck.<type>) and it's pretty common that people don't use
"--" separator between fsck and fsck.<type> options.

 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
