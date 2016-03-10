Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:37519 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164AbcCJLQI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Mar 2016 06:16:08 -0500
Date: Thu, 10 Mar 2016 12:16:05 +0100
From: Karel Zak <kzak@redhat.com>
To: =?iso-8859-1?Q?R=FCdiger?= Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: sfdisk, stderr/stdout output order
Message-ID: <20160310111605.n2jona662wvbgymh@ws.net.home>
References: <201603101140.50532.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <201603101140.50532.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, Mar 10, 2016 at 11:40:50AM +0100, Rüdiger Meier wrote:
> Hi,
> 
> I've found such test diffs with musl libc. Maybe it needs some fflush(3) 
> calls.

 Yes, good point. I'll fix it.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
