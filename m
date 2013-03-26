Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:32302 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755672Ab3CZLjX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 26 Mar 2013 07:39:23 -0400
Date: Tue, 26 Mar 2013 12:39:18 +0100
From: Karel Zak <kzak@redhat.com>
To: Daniel Stodden <daniel.stodden@googlemail.com>
Cc: util-linux@vger.kernel.org, Daniel Stodden <daniel.stodden@gmail.com>
Subject: Re: [PATCH] schedutils: don't apply -a without -p
Message-ID: <20130326113918.GC26297@x2.net.home>
References: <1364204039-18148-1-git-send-email-daniel.stodden@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1364204039-18148-1-git-send-email-daniel.stodden@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Mar 25, 2013 at 02:33:59AM -0700, Daniel Stodden wrote:
>  schedutils/taskset.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

 Good catch! Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
