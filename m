Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36320 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753430AbbEOK6F (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 15 May 2015 06:58:05 -0400
Date: Fri, 15 May 2015 12:58:01 +0200
From: Karel Zak <kzak@redhat.com>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] script: Fix mangled EOF and hang on big endian
Message-ID: <20150515105801.GJ4834@ws.net.home>
References: <5554C58C.5080004@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5554C58C.5080004@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 14, 2015 at 05:55:56PM +0200, Stanislav Brabec wrote:
> -		int c = DEF_EOF;
> +		char c = DEF_EOF;

 Ah... so nice ;-) Applied, thanks.

    Karel
-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
