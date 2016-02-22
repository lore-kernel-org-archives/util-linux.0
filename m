Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48539 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753140AbcBVJAo (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Feb 2016 04:00:44 -0500
Date: Mon, 22 Feb 2016 10:00:42 +0100
From: Karel Zak <kzak@redhat.com>
To: Hushan Jia <hushan.jia@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] ipcs: show gid instead of uid
Message-ID: <20160222090042.xm7o6gh33epytf7a@ws.net.home>
References: <20160222051024.GE23038@sfo-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160222051024.GE23038@sfo-1>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 21, 2016 at 09:10:24PM -0800, Hushan Jia wrote:
> ipcs -i incorrectly used uid where it should be gid

Applied, thanks. This is pretty stupid bug.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
