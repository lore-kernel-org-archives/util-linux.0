Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53837 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757157Ab3CDLbY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 4 Mar 2013 06:31:24 -0500
Date: Mon, 4 Mar 2013 12:31:14 +0100
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] login: remove file descriptor leak [cppcheck]
Message-ID: <20130304113114.GB8830@x2.net.home>
References: <1361395869-2959-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1361395869-2959-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Feb 20, 2013 at 09:31:09PM +0000, Sami Kerola wrote:
>  login-utils/login.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
