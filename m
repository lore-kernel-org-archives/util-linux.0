Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36940 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934344AbaEFJLt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 6 May 2014 05:11:49 -0400
Date: Tue, 6 May 2014 11:11:45 +0200
From: Karel Zak <kzak@redhat.com>
To: Benno Schulenberg <bensberg@justemail.net>
Cc: Util-Linux <util-linux@vger.kernel.org>
Subject: Re: [patches] removing some duplicate includes and standardizing a
 usage text
Message-ID: <20140506091145.GA5962@x2.net.home>
References: <1398797443.20719.111805353.31C825B4@webmail.messagingengine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1398797443.20719.111805353.31C825B4@webmail.messagingengine.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 29, 2014 at 08:50:43PM +0200, Benno Schulenberg wrote:
> The first few patches remove two duplicate includes, tweak some
> comments and usage strings, and normalizes another include.
> 
> The sixth patch adds a missing error message to ionice.  And as the
> usage text of ionice recently changed, the seventh patch seizes the
> opportunity to slice it up, standardize its form, and improve some
> of the descriptions.
> 
> The eighth patch tries to massage the usage howto into a better
> grammatical shape.
> 
> Sami, there is one thing I changed: the square brackets around the
> three dots, as that seems pleonastic to me, and the man-pages man page
> suggests the bare three dots: see 'man 1 man' and search for "repeat".

 Applied, thanks.


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
