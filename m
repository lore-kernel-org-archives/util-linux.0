Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42473 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544AbcGALwx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jul 2016 07:52:53 -0400
Date: Fri, 1 Jul 2016 13:52:49 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 0/6] pull: utmpdump iso-8601 format
Message-ID: <20160701115249.5m2bqxuozjpytbd7@ws.net.home>
References: <20160620204037.3292-1-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160620204037.3292-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 20, 2016 at 09:40:31PM +0100, Sami Kerola wrote:
>   utmpdump: use always UTC-0 timezone in textual output
>   libcommon: add ISO_8601_GMTIME that will print UTC-0 timestamps
>   utmpdump: use iso-8601 timestamp format with subsecond accuracy
>   tests: fix utmpdump timestamps to be in iso format
>   tests: remove utmpdump localization go-around
>   tests: utmpdump add subsecond accuracy test

 Applied, thanks.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
