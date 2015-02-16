Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:60654 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932078AbbBPKNQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Feb 2015 05:13:16 -0500
Date: Mon, 16 Feb 2015 11:13:03 +0100
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Ruediger Meier <sweet_f_a@gmx.de>, util-linux@vger.kernel.org
Subject: Re: [PATCH] fsck: fix warning, gcc 5.0
Message-ID: <20150216101303.GG11948@ws.net.home>
References: <1423937550-2035-1-git-send-email-sweet_f_a@gmx.de>
 <1423937550-2035-2-git-send-email-sweet_f_a@gmx.de>
 <54E091A1.10404@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <54E091A1.10404@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Feb 15, 2015 at 01:31:29PM +0100, Bernhard Voelker wrote:
> On 02/14/2015 07:12 PM, Ruediger Meier wrote:
> > -					   !strncmp(argv[i+1], "-", 1) == 0) {
> > +					   strncmp(argv[i+1], "-", 1) != 0) {
> 
> ... or better avoid the strncmp() for 1 character at all?

 Yes, fixed.

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
