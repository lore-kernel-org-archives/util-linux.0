Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:38714 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527Ab3FGJ2V (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Jun 2013 05:28:21 -0400
Date: Fri, 7 Jun 2013 11:28:07 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        10317@debbugs.gnu.org
Subject: Re: su: -l and -p should not be used together
Message-ID: <20130607092807.GA19555@x2.net.home>
References: <519DF601.4090700@bernhard-voelker.de>
 <20130529094010.GF30341@x2.net.home>
 <51A5D07E.8000603@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51A5D07E.8000603@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, May 29, 2013 at 11:55:10AM +0200, Bernhard Voelker wrote:
> As the change was in su-common.c, this also affects runuser.
> I think this should then be documented in runuser.1, too, right?

 Good point, fixed.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
