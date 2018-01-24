Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:50278 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933669AbeAXMyW (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Jan 2018 07:54:22 -0500
Date: Wed, 24 Jan 2018 13:54:18 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 1/2] cal: honor num_months when only a year argument
Message-ID: <20180124125418.txntlrwtme7mjqor@ws.net.home>
References: <85ea05cd-c4d0-f7d6-14f4-7deb065089d1@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <85ea05cd-c4d0-f7d6-14f4-7deb065089d1@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 22, 2018 at 03:05:08PM -0500, J William Piggott wrote:
> It also says that cal(1) has no options, so in that context
> if an option is given then it should be expected to override
> POSIX behavior.
> 
> Before patched all of these command displayed a full year:
> cal -1 2020
> cal -3 2020
> cal -n6 2020

It enables *year header*, and for one month is looks strange,
especially if you don't asked for it.

$ ./cal -1 2018
                               2018                               

       January      
Su Mo Tu We Th Fr Sa
    1  2  3  4  5  6  
 7  8  9 10 11 12 13  
14 15 16 17 18 19 20  
21 22 23 24 25 26 27  
28 29 30 31           


The problem is that <year> command line argument enables yflag, but in
this case it does not make sense. I guess solution is something like:

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 562ae2afb..82f3e4558 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -484,7 +484,8 @@ int main(int argc, char **argv)
                }
                if (!ctl.req.month && !ctl.req.week) {
                        ctl.req.month = local_time->tm_mon + 1;
-                       yflag = 1;
+                       if (!ctl.num_months)
+                               yflag = 1;
                }
                break;
        case 0:


It means that header for "-1|-3|-n <year>" is the same as without
<year>.

Fixed version:

$ ./cal -1 2020
    January 2020    
Su Mo Tu We Th Fr Sa
          1  2  3  4 
 5  6  7  8  9 10 11 
12 13 14 15 16 17 18 
19 20 21 22 23 24 25 
26 27 28 29 30 31                       

$ ./cal -3 2020
    December 2019         January 2020          February 2020   
Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa  Su Mo Tu We Th Fr Sa
 1  2  3  4  5  6  7            1  2  3  4                     1 
 8  9 10 11 12 13 14   5  6  7  8  9 10 11   2  3  4  5  6  7  8 
15 16 17 18 19 20 21  12 13 14 15 16 17 18   9 10 11 12 13 14 15 
22 23 24 25 26 27 28  19 20 21 22 23 24 25  16 17 18 19 20 21 22 
29 30 31              26 27 28 29 30 31     23 24 25 26 27 28 29 
                                          
You can force year header by explicit -y on command line:

./cal -3y 2020
                               2020

      December                January               February
Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa   Su Mo Tu We Th Fr Sa
 1  2  3  4  5  6  7             1  2  3  4                      1
 8  9 10 11 12 13 14    5  6  7  8  9 10 11    2  3  4  5  6  7  8
15 16 17 18 19 20 21   12 13 14 15 16 17 18    9 10 11 12 13 14 15
22 23 24 25 26 27 28   19 20 21 22 23 24 25   16 17 18 19 20 21 22
29 30 31               26 27 28 29 30 31      23 24 25 26 27 28 29


IMHO it's more consistent behavior. 

We need to add a note to the man page that -y forces cal(1) to use 
year header in all contexts.

Comments?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
