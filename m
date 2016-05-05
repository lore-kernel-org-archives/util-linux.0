Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33695 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756401AbcEEJx5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 5 May 2016 05:53:57 -0400
Date: Thu, 5 May 2016 11:53:55 +0200
From: Karel Zak <kzak@redhat.com>
To: Peter Cordes <peter@cordes.ca>
Cc: util-linux@vger.kernel.org
Subject: Re: cfdisk UI problem with a small partition starting and ending
	before sector 2048 (1MiB)
Message-ID: <20160505095355.xjxbrw7gtag4ybpg@ws.net.home>
References: <20160227041955.GT20685@cordes.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160227041955.GT20685@cordes.ca>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Feb 27, 2016 at 12:19:55AM -0400, Peter Cordes wrote:
> I tested sfdisk/cfdisk from the latest git while setting up a new disk.
> It finds some free space where there isn't any:

 Fixed by commit b362a4cb986f7eea4b884c800719971502e2e8a8.

 Note that technically there is a free space between sectors 34 and
 40, but after align to MiBs it's useless and libfdisk code has been
 confused with it...

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
