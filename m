Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4113 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515AbaEZJuh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 May 2014 05:50:37 -0400
Date: Mon, 26 May 2014 11:50:28 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 2/4] uuidd: set options to be mutually exclusive
Message-ID: <20140526095028.GB2968@x2.net.home>
References: <1401015580-27951-1-git-send-email-kerolasa@iki.fi>
 <1401015580-27951-2-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1401015580-27951-2-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, May 25, 2014 at 11:59:38AM +0100, Sami Kerola wrote:
> --pid     || --no-pid
> --debug   || --quiet
> --timeout || --socket-activation

 timeout and socket-activation are not mutually exclusive

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
