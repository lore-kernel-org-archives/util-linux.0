Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:33169 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754616AbbAZKH5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Jan 2015 05:07:57 -0500
Date: Mon, 26 Jan 2015 11:07:55 +0100
From: Karel Zak <kzak@redhat.com>
To: Ingo =?iso-8859-1?Q?Br=FCckl?= <ib@wupperonline.de>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] dmesg: Enable proper indent for messages containing line
 breaks
Message-ID: <20150126100755.GB6354@x2.net.home>
References: <54b6b75c.0b36989b.bm000@wupperonline.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <54b6b75c.0b36989b.bm000@wupperonline.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Jan 14, 2015 at 07:36:55PM +0100, Ingo Brückl wrote:
> Messages containing line breaks somehow look broken when additional time,
> facility or level information is displayed, because they partly appear in
> time/facility/level column.

 Nice. Applied, thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
