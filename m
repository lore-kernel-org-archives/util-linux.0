Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47454 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750950Ab2JVUWs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Oct 2012 16:22:48 -0400
Date: Mon, 22 Oct 2012 22:22:44 +0200
From: Karel Zak <kzak@redhat.com>
To: Mike Frysinger <vapier@gentoo.org>
Cc: kerolasa@gmail.com, util-linux@vger.kernel.org
Subject: Re: [PATCH 03/19] write: stop using MAXHOSTNAMELEN
Message-ID: <20121022202244.GE21724@x2.net.home>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
 <201210220201.02516.vapier@gentoo.org>
 <20121022080624.GA21724@x2.net.home>
 <201210221603.02244.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201210221603.02244.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Oct 22, 2012 at 04:03:01PM -0400, Mike Frysinger wrote:
> if you were to do something like:
> 	int foo = 10;
> 	usleep(foo++);
> 
> this define macro would misbehave because it expands x twice.  not that the 
> current code base does.

 Yes, I moved the fallback to c.h as inline function this morning.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
