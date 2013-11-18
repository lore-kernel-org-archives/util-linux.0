Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46081 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789Ab3KRQnA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Nov 2013 11:43:00 -0500
Date: Mon, 18 Nov 2013 17:42:52 +0100
From: Karel Zak <kzak@redhat.com>
To: Colin Guthrie <colin@mageia.org>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] su: Remove the impossible -C option to request the same
 session.
Message-ID: <20131118164252.GA5572@x2.net.home>
References: <1384785840-31957-1-git-send-email-colin@mageia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384785840-31957-1-git-send-email-colin@mageia.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Nov 18, 2013 at 02:44:00PM +0000, Colin Guthrie wrote:
> It's impossible to pass this argument so it is pointless to keep the
> code to support it.

 Really? See struct option longopts[] and --session-command.

    Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
