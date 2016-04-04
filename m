Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47554 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276AbcDDAVD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 3 Apr 2016 20:21:03 -0400
Date: Mon, 4 Apr 2016 02:21:00 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] chrt: make --sched-* short options to require an
 argument
Message-ID: <20160404002100.eqclqk2rqbttbued@ws.net.home>
References: <1459672529-2278-1-git-send-email-kerolasa@iki.fi>
 <1459672529-2278-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1459672529-2278-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 03, 2016 at 09:35:27AM +0100, Sami Kerola wrote:
> These options are expecting an argument, and the long options struct already
> required them.

 Good catch, but deadline and runtime should be optional arguments (it
 seems I have merged wrong version of my patch:-(

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
