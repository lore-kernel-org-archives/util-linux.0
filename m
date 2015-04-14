Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36261 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753038AbbDNJrJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 Apr 2015 05:47:09 -0400
Date: Tue, 14 Apr 2015 11:47:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Cristian =?iso-8859-1?Q?Rodr=EDguez?= <crrodriguez@opensuse.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lib/sysfs.c: use fcntl(..F_DUPFD_CLOEXEC) instead of
 dup(2)
Message-ID: <20150414094707.GU3923@ws.net.home>
References: <1428692278-5226-1-git-send-email-crrodriguez@opensuse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1428692278-5226-1-git-send-email-crrodriguez@opensuse.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 10, 2015 at 03:57:58PM -0300, Cristian Rodríguez wrote:
> "The two descriptors do not share file descriptor flags (the
> close-on-exec flag).  The close-on-exec flag  for the duplicate descriptor is off"
> ---
>  lib/sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Excellent catch. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
