Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57844 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753123AbbCFL4j (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 6 Mar 2015 06:56:39 -0500
Date: Fri, 6 Mar 2015 12:56:25 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org, Rainer Gerhards <rgerhards@adiscon.com>
Subject: Re: [PATCH] logger: make unix socket logging to use syslog_local
 format by default
Message-ID: <20150306115625.GA26473@ws.net.home>
References: <1425589920-850-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1425589920-850-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 05, 2015 at 09:12:00PM +0000, Sami Kerola wrote:
>  misc-utils/logger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 I already merged Rainer's version of the patch (it's almost the same,
 but it also set unix_socket path to _PATH_DEVLOG is no -u specified).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
