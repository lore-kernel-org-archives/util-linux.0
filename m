Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:28280 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932159Ab2JRRcq (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Oct 2012 13:32:46 -0400
Date: Thu, 18 Oct 2012 19:32:42 +0200
From: Karel Zak <kzak@redhat.com>
To: Ayan George <ayan@ayan.net>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] Use C99 idioms in kill.c
Message-ID: <20121018173242.GB16193@x2.net.home>
References: <508025be.e81S03iobeo1edmy%ayan@ayan.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <508025be.e81S03iobeo1edmy%ayan@ayan.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Oct 18, 2012 at 03:52:30PM +0000, Ayan George wrote:
> * Moved some declarations closer to where the vairable is used.

 No problem if the declaration is at the begin of any block, like

  if (x) {
      int y;
      ...
  }

 everything other is MESS.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
