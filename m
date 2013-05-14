Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3071 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752338Ab3ENKpT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 14 May 2013 06:45:19 -0400
Date: Tue, 14 May 2013 12:45:04 +0200
From: Karel Zak <kzak@redhat.com>
To: Sami Kerola <kerolasa@iki.fi>
Cc: util-linux@vger.kernel.org,
        =?iso-8859-1?Q?P=E1draig?= Brady <P@draigbrady.com>
Subject: Re: [PATCH 13/16] cal: stop trimming whitespaces
Message-ID: <20130514104504.GF18123@x2.net.home>
References: <1367520701-14962-1-git-send-email-kerolasa@iki.fi>
 <1367520701-14962-14-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1367520701-14962-14-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, May 02, 2013 at 07:51:38PM +0100, Sami Kerola wrote:
> Remove trailing spaces from output it is trivial

and introduce a regression and ugly output, see "cal -3":

old version:

     April 2013             May 2013              June 2013     
Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
    1  2  3  4  5  6            1  2  3  4                     1
 7  8  9 10 11 12 13   5  6  7  8  9 10 11   2  3  4  5  6  7  8
14 15 16 17 18 19 20  12 13 14 15 16 17 18   9 10 11 12 13 14 15
21 22 23 24 25 26 27  19 20 21 22 23 24 25  16 17 18 19 20 21 22
28 29 30              26 27 28 29 30 31     23 24 25 26 27 28 29
                                            30                  

new version:

     April 2013             May 2013              June 2013     
Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
    1  2  3  4  5  6             1  2  3  4                      1 
 7  8  9 10 11 12 13    5  6  7  8  9 10 11    2  3  4  5  6  7  8 
14 15 16 17 18 19 20   12 13 14 15 16 17 18    9 10 11 12 13 14 15 
21 22 23 24 25 26 27   19 20 21 22 23 24 25   16 17 18 19 20 21 22 
28 29 30               26 27 28 29 30 31      23 24 25 26 27 28 29 
                                              30                   

btw, it's pretty obvious from
https://github.com/kerolasa/lelux-utiliteetit/commit/5b472fb7f4d8b855756a249633250e818a560a66

I guess we have regression test just to check for regressions.


 Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
