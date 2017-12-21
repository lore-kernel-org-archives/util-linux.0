Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:42242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751734AbdLUONg (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 21 Dec 2017 09:13:36 -0500
Date: Thu, 21 Dec 2017 15:13:32 +0100
From: Karel Zak <kzak@redhat.com>
To: J William Piggott <elseifthen@gmx.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] cal: add --iso and --1782-reform format options
Message-ID: <20171221141332.dk6i3oj3qr44k35l@ws.net.home>
References: <20171219132906.74xm7nm4r3trr4qq@ws.net.home>
 <9f5b10fe-1286-3aa7-a170-7a30b9e577a3@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9f5b10fe-1286-3aa7-a170-7a30b9e577a3@gmx.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Dec 19, 2017 at 09:32:49PM -0500, J William Piggott wrote:
> -#define REFORMATION_YEAR	1752		/* Signed-off-by: Lord Chesterfield */
> +/* Dec 19 2017 - After an appropriate mourning period change 1752 to -1 making
> + * the default output format the proleptic Gregorian calendar
> + */
> +int reformation_year = 1752;

Wow, I have to appreciate this really nice hack, it's way how to keep
the change as small as possible ;-)

... but I'm not sure this way is elegant from code consistence,
extendability, and for readers. 

We have control struct where is "julian" flag. It would be probably
better to use the control struct for all the things around calendars.

 * add enum CAL_TYPE_{JULIAN,GREGORIAN,GB1752,...}
 * use the enum in cal_control (and remove julian flag)
 * set calendar type in getopt code block

 * use the same prefix (e.g. GB1752_*) for all the "British Empire"
   specific reform macros (including NUMBER_MISSING_DAYS and YDAY_AFTER_MISSING)

 * in code use switch(ctl->calendar) { case CAL_TYPE .... } to keep is
   readable ;-)

 * yes, it will require to use cal_control in small functions like
   leap_year(), but IMHO it's better than hide all in magic reformation_year
   global variable

BTW, in theory it would be possible to support more reforms, for
example Greece 1923 (16-Feb -> 1-Mar), etc. Maybe the region of the
reform should be somehow within the command line option --reform-1752-GB
--reform-1923-GR, etc.

> @@ -279,6 +284,8 @@ int main(int argc, char **argv)
>  		{"year", no_argument, NULL, 'y'},
>  		{"week", optional_argument, NULL, 'w'},
>  		{"color", optional_argument, NULL, OPT_COLOR},
> +		{"iso", no_argument, NULL, OPT_ISO},

--iso seems like good idea, but --gregorian alias would be also nice
as we already have --julian.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
