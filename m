Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:55927 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750983AbbDGKJJ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Apr 2015 06:09:09 -0400
Date: Tue, 7 Apr 2015 12:09:03 +0200
From: Karel Zak <kzak@redhat.com>
To: Ruediger Meier <sweet_f_a@gmx.de>
Cc: util-linux@vger.kernel.org
Subject: Re: question about logger tests
Message-ID: <20150407100903.GG3923@ws.net.home>
References: <201503261450.33545.sweet_f_a@gmx.de>
 <20150327141458.GN1749@ws.net.home>
 <201504030110.58092.sweet_f_a@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201504030110.58092.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Apr 03, 2015 at 12:10:57AM +0100, Ruediger Meier wrote:
> So how could we skip logger tests safely if /dev/log does not work?

Would be enough to test by

    socat - UNIX-CONNECT:/dev/log

connect to the socket?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
