Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:10341 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab2E2IKa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 May 2012 04:10:30 -0400
Date: Tue, 29 May 2012 10:10:25 +0200
From: Karel Zak <kzak@redhat.com>
To: Thomas Schwinge <thomas@codesourcery.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 3/7] last, login, write: Provide a fallback for
 MAXHOSTNAMELEN, as elsewhere.
Message-ID: <20120529081025.GJ3757@x2.net.home>
References: <1337969621-3052-1-git-send-email-thomas@codesourcery.com>
 <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
 <1337969778-3154-3-git-send-email-thomas@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337969778-3154-3-git-send-email-thomas@codesourcery.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 25, 2012 at 08:16:14PM +0200, Thomas Schwinge wrote:
> Signed-off-by: Thomas Schwinge <thomas@codesourcery.com>
> ---
>  login-utils/last.c  |    8 ++++++++
>  login-utils/login.c |    8 ++++++++
>  term-utils/write.c  |    8 ++++++++
>  3 files changed, 24 insertions(+), 0 deletions(-)

 I have moved the fallback for MAXHOSTNAMELEN to c.h, it seems better
 than duplicate the code.  Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
