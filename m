Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:58611 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbbDGInF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Apr 2015 04:43:05 -0400
Date: Tue, 7 Apr 2015 10:43:01 +0200
From: Karel Zak <kzak@redhat.com>
To: kerolasa@gmail.com
Cc: Bernhard Voelker <mail@bernhard-voelker.de>,
        Patrick Plagwitz <patrick.plagwitz@fau.de>,
        util-linux <util-linux@vger.kernel.org>
Subject: Re: logger: Segmentation fault when reading from stdin and writing
 to socket
Message-ID: <20150407084301.GD3923@ws.net.home>
References: <5521E92D.2090404@fau.de>
 <alpine.LNX.2.03.1504062226540.593@iki.fi>
 <55237AF1.3010004@bernhard-voelker.de>
 <CAG27Bk1487WSthzMnX7vbRw-i2ianr15DnEGwK+0FY3Hhem5Xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAG27Bk1487WSthzMnX7vbRw-i2ianr15DnEGwK+0FY3Hhem5Xg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Apr 07, 2015 at 09:00:25AM +0100, Sami Kerola wrote:
> On 7 April 2015 at 07:36, Bernhard Voelker <mail@bernhard-voelker.de> wrote:
> > On 04/06/2015 11:50 PM, Sami Kerola wrote:
> >> On Mon, 6 Apr 2015, Patrick Plagwitz wrote:
> https://github.com/kerolasa/lelux-utiliteetit/commit/4a8919a4e5b28a47cd61fc8b774a6eaee943b90e
> https://github.com/kerolasa/lelux-utiliteetit/commit/c3dd2ecd5fcaf30860d5fcfd74edfd70a3dd7603

 Thanks Patrick and Sami.

 ...by the way -- it means we don't have stdin logger tests at all!

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
