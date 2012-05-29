Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37444 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750872Ab2E2IOG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 29 May 2012 04:14:06 -0400
Date: Tue, 29 May 2012 10:14:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Thomas Schwinge <thomas@codesourcery.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 5/7] write: Use PATH_MAX instead of MAXPATHLEN, as
 elsewhere.
Message-ID: <20120529081401.GL3757@x2.net.home>
References: <1337969621-3052-1-git-send-email-thomas@codesourcery.com>
 <1337969778-3154-1-git-send-email-thomas@codesourcery.com>
 <1337969778-3154-5-git-send-email-thomas@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337969778-3154-5-git-send-email-thomas@codesourcery.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, May 25, 2012 at 08:16:16PM +0200, Thomas Schwinge wrote:
>  term-utils/write.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
