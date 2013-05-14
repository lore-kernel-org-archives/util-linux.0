Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:19655 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751881Ab3ENKtn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 May 2013 06:49:43 -0400
Date: Tue, 14 May 2013 12:49:33 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 14/16] cal: move global variables to local scope
Message-ID: <20130514104933.GG18123@x2.net.home>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
 <1367520701-14962-15-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367520701-14962-15-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 02, 2013 at 07:51:39PM +0100, Sami Kerola wrote:
> Also include small change to function parameter coding style.  The braces
> are from function line to new line, and return value is in same line with
> the function.

 The version you send to mailing list seems correct, but the version
 in your cal-again branch is completely broken. It's obvious that
 nobody has tried "make cal" for the branch :-(

 Anyway, I'm really not sure if this change:

> -void monthly(int, int, int);
> +void monthly(const int, const int, const char *, const char **, int, int, int);

 makes the code more readable. Maybe you can drop the patch at all for now.

 From long term point of view it would be better to introduce
 'cal_context' struct for all the stuff. It's a way how to make the
 code more readable and extendible.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
