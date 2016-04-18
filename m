Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:41236 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751296AbcDRJDK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 18 Apr 2016 05:03:10 -0400
Date: Mon, 18 Apr 2016 11:03:08 +0200
From: Karel Zak <kzak@redhat.com>
To: Bernhard Voelker <mail@bernhard-voelker.de>
Cc: Nir Soffer <nsoffer@redhat.com>, Nir Soffer <nirsof@gmail.com>,
        util-linux@vger.kernel.org
Subject: Re: [PATCH] Fail like the shell when execvp fails
Message-ID: <20160418090308.neuoomfv2acncdcu@ws.net.home>
References: <1460827912-19521-1-git-send-email-nsoffer@redhat.com>
 <5712ACB2.7090103@bernhard-voelker.de>
 <CAMRbyyvheOFY=2uRHDCwEHwNzBN4r2DsyLAKEiXJj_PZQkttdg@mail.gmail.com>
 <CAMRbyyt5nAoMR8=8k0GRm-jijwxzTywA+hk65esxQqPkhTmabA@mail.gmail.com>
 <57135343.2080105@bernhard-voelker.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57135343.2080105@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Apr 17, 2016 at 11:11:31AM +0200, Bernhard Voelker wrote:
> > So we may adapt this behavior?
> 
> Good examples, indeed.  I really should've looked that up myself
> before replying, sorry.  Thanks for correcting me.  So your patch
> actually makes util-linux more consistent with other tools ...
> which is good.

I agree. Please, send updated version of the patch. Thanks.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
