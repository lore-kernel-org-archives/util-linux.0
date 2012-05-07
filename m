Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31556 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754541Ab2EGPlO (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 May 2012 11:41:14 -0400
Date: Mon, 7 May 2012 17:41:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Petr Pisar <petr.pisar@atlas.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: addpart and delpart tools are not internationalized
Message-ID: <20120507154103.GB23825@x2.net.home>
References: <20120507133415.GA7097@album.bayer.uni.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120507133415.GA7097@album.bayer.uni.cx>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, May 07, 2012 at 03:34:15PM +0200, Petr Pisar wrote:
> I've just found addpart and delpart does not put any message into most recent
> (2.21-rc2) gettext translation catalog template. Thus the output of these two
> tools cannot be translated.

 Already fixed by:

 commit 791130208506f50be63672fa733a70db871900da
 Author: Sami Kerola <kerolasa@iki.fi>
 Date:   Sat Mar 17 18:04:37 2012 +0100

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
