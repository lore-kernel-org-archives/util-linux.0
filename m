Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55896 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756092AbbFBKex (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Jun 2015 06:34:53 -0400
Date: Tue, 2 Jun 2015 12:34:51 +0200
From: Karel Zak <kzak@redhat.com>
To: Boris Egorov <egorov@linux.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] bash-completion: handle comma-separated options in
 findmnt
Message-ID: <20150602103451.GG7285@ws.net.home>
References: <1433008876-8622-1-git-send-email-egorov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433008876-8622-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 31, 2015 at 12:01:16AM +0600, Boris Egorov wrote:
> So, I discovered a way to complete comma-separated options. This
> solution can become messy when you have too many values listed.

Yes, it's little bit messy, but it's still better than nothing :-)

> Similar fixes for other utils follow if this one will be merged.

I have no objections, go ahead.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
