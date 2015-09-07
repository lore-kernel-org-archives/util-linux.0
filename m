Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:35545 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751240AbbIGGwa (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Sep 2015 02:52:30 -0400
Date: Mon, 7 Sep 2015 08:52:27 +0200
From: Karel Zak <kzak@redhat.com>
To: Andreas Henriksson <andreas@fatal.se>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/3] hwclock: fix signed/unsigned comparison warning on
 alpha
Message-ID: <20150907065227.GM2726@ws.net.home>
References: <1440166409-32215-1-git-send-email-andreas@fatal.se>
 <20150824085835.GK1689@ws.net.home>
 <20150901141327.GA17192@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150901141327.GA17192@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Sep 01, 2015 at 04:13:27PM +0200, Andreas Henriksson wrote:
> The first warning should be trivially fixed by the attached patch,

 Applied, thanks.

> Not sure how to deal with the assembler warnings....

 Me too :-)

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
