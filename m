Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:31207 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752770Ab1JUV3n (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 21 Oct 2011 17:29:43 -0400
Date: Fri, 21 Oct 2011 23:29:39 +0200
From: Karel Zak <kzak@redhat.com>
To: Davidlohr Bueso <dave@gnu.org>
Cc: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 2/3] prlimit: new program
Message-ID: <20111021212939.GA519@nb>
References: <1318893789.5289.10.camel@offworld> <20111017150804.GA9767@nb.net.home> <1319054555.2170.3.camel@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1319054555.2170.3.camel@offworld>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 19, 2011 at 04:02:35PM -0400, Davidlohr Bueso wrote:
> Below is a v2 version with the requested corrections, thanks for
> reviewing.

 Applied with some changes:

    - sync short options with ulimits(1)
    - remove PRLIMIT_UNKNOWN (limits are unsigned)

 BTW, what about to add another column "UNIT" (bytes, seconds, ms,
 ...)?
   
 Thanks!
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
